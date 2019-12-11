Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94C2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C912465E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077620;
	bh=mLEWgaRg4QN21zySbsZbDq5eOsEUGBbcPKlCrTYgZ9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjfcO+AkOb1ph7mNoHu1HQ/m0TywfV/3uxxBnoKMFedToe6afC5TZSDAf3QTf9Kx4
	 IkUI/iQiKpxgUlx0L0VXrcc75Ka3XZAfZnpT3kP6ke4mygJtlEiQCfotcM8P5IcX/X
	 SnWhqRNqIISIcXmo5KSppxES5Zrdzr8wiZ9qzbbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfLKPUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfLKPUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:20:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8744324658;
        Wed, 11 Dec 2019 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077615;
        bh=mLEWgaRg4QN21zySbsZbDq5eOsEUGBbcPKlCrTYgZ9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n/U99nasT/kWq8cJTibmRLeHIjNBag0XaNnnR4CFr2I2snM0+Z46tOSA6Xd0jA+iM
         qJVTaK2eKgimh01VolPsC1ipNbJ8U7HvNhr7YV8AtBDWiX6TdTjOxqJnbCHva+hgG9
         5mRYbonG+jT3vIgYYKIrXSx/YaDjz5tKdFoy5Q/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlong Song <yunlong.song@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/243] f2fs: change segment to section in f2fs_ioc_gc_range
Date:   Wed, 11 Dec 2019 16:04:26 +0100
Message-Id: <20191211150346.143738231@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit 67b0e42b768c9ddc3fd5ca1aee3db815cfaa635c ]

f2fs_ioc_gc_range skips blocks_per_seg each time, however, f2fs_gc moves
blocks of section each time, so fix it from segment to section.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 187bf7e260c99..5eef2a8b29ab6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2143,7 +2143,7 @@ do_more:
 	}
 
 	ret = f2fs_gc(sbi, range.sync, true, GET_SEGNO(sbi, range.start));
-	range.start += sbi->blocks_per_seg;
+	range.start += BLKS_PER_SEC(sbi);
 	if (range.start <= end)
 		goto do_more;
 out:
-- 
2.20.1



