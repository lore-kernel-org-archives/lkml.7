Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC072C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AEC2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419233;
	bh=CU9tKT6KmdY5XkHWOV14uNEe1lBa1UfOHASx6+LfbQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQy8nCaALDK084cfyxGgY5gmLNVeAqx9E0eBFsUjnawg3q3ykleGv0PIVC9BoeDrs
	 NvrBt2QFMZ2OU14W6fPVFnTeeDGfxLSVYwnJi1HavC12IXv+IJV5E7liizm5L/z5/G
	 51dhpi8ik5q6Lp29ZqfsBr1DQ7m2Iz+BZ4tp3sqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbfGRDHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390345AbfGRDHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:07:07 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81824205F4;
        Thu, 18 Jul 2019 03:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419227;
        bh=CU9tKT6KmdY5XkHWOV14uNEe1lBa1UfOHASx6+LfbQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eskZEKCCMxl0XMBMymLl8BbplXVExK9LFenEd8DbvJkoUK3JfJ5dUq+lr+eIjnzKH
         ZZbVNOLwnki3J6grwZVStyGlYXfv5ZTuhhtncWt/mGT77fCKkkcp/204nufvzuH2jp
         vyVXXbV0WiO3gFdjP5+0tuf0A34LP1NuXU9GyS6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Marchand <jmarchan@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/47] dm table: dont copy from a NULL pointer in realloc_argv()
Date:   Thu, 18 Jul 2019 12:01:34 +0900
Message-Id: <20190718030050.388713512@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030045.780672747@linuxfoundation.org>
References: <20190718030045.780672747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a0651926553cfe7992166432e418987760882652 ]

For the first call to realloc_argv() in dm_split_args(), old_argv is
NULL and size is zero. Then memcpy is called, with the NULL old_argv
as the source argument and a zero size argument. AFAIK, this is
undefined behavior and generates the following warning when compiled
with UBSAN on ppc64le:

In file included from ./arch/powerpc/include/asm/paca.h:19,
                 from ./arch/powerpc/include/asm/current.h:16,
                 from ./include/linux/sched.h:12,
                 from ./include/linux/kthread.h:6,
                 from drivers/md/dm-core.h:12,
                 from drivers/md/dm-table.c:8:
In function 'memcpy',
    inlined from 'realloc_argv' at drivers/md/dm-table.c:565:3,
    inlined from 'dm_split_args' at drivers/md/dm-table.c:588:9:
./include/linux/string.h:345:9: error: argument 2 null where non-null expected [-Werror=nonnull]
  return __builtin_memcpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/md/dm-table.c: In function 'dm_split_args':
./include/linux/string.h:345:9: note: in a call to built-in function '__builtin_memcpy'

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index c7fe4789c40e..34ab30dd5de9 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -562,7 +562,7 @@ static char **realloc_argv(unsigned *size, char **old_argv)
 		gfp = GFP_NOIO;
 	}
 	argv = kmalloc_array(new_size, sizeof(*argv), gfp);
-	if (argv) {
+	if (argv && old_argv) {
 		memcpy(argv, old_argv, *size * sizeof(*argv));
 		*size = new_size;
 	}
-- 
2.20.1



