Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E1A2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553233;
	bh=NiqXvwojC1D7C1RXV3saA1gnnXcxvKec8v+zqiUIXuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+FJ8jd2fkYdoo4k9pZHRbtwMcIt5XK8TLXgN2NkdrmZMh2o4a2gPB4J+caZFlS0I
	 N0JXCkrQmCRaWq3CLSnKkfyx36MKeR8aA/ekjKN8dVBJ5vfwKeX6gjP4fu8SYL34TG
	 iR4/vKQYWUIFkIb3WqED+E0R8FEOhslU2BuqxUfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbfEVT1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbfEVT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:27:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2945420675;
        Wed, 22 May 2019 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553225;
        bh=NiqXvwojC1D7C1RXV3saA1gnnXcxvKec8v+zqiUIXuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zc/p15SmSzJtp48O5Njc1M7lOrgpfo/HRXS4nOArNgx4GCS1DA+YQOYzE/X5IbiLg
         wt865035vYkPdokeDQEAcGzOtRRNEF4d/gVmI1bzu/WDpehLeecr+XSObuU6hh5DeC
         B3EctWWOUMHn8skyt8dFdlR3w0Us/4i9svjyUPWE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 023/244] powerpc/boot: Fix missing check of lseek() return value
Date:   Wed, 22 May 2019 15:22:49 -0400
Message-Id: <20190522192630.24917-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo YU <tsu.yubo@gmail.com>

[ Upstream commit 5d085ec04a000fefb5182d3b03ee46ca96d8389b ]

This is detected by Coverity scan: CID: 1440481

Signed-off-by: Bo YU <tsu.yubo@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/boot/addnote.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/addnote.c b/arch/powerpc/boot/addnote.c
index 9d9f6f334d3cc..3da3e2b1b51bc 100644
--- a/arch/powerpc/boot/addnote.c
+++ b/arch/powerpc/boot/addnote.c
@@ -223,7 +223,11 @@ main(int ac, char **av)
 	PUT_16(E_PHNUM, np + 2);
 
 	/* write back */
-	lseek(fd, (long) 0, SEEK_SET);
+	i = lseek(fd, (long) 0, SEEK_SET);
+	if (i < 0) {
+		perror("lseek");
+		exit(1);
+	}
 	i = write(fd, buf, n);
 	if (i < 0) {
 		perror("write");
-- 
2.20.1

