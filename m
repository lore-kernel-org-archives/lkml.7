Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD132064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908272;
	bh=ul2sLvyD1f84cfcacpe4EO4sPFWG1eckXIPx0tvUgRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=evllu7JAKrM1OKOCLG+FVfLof4UWVdk0XPOvsXU5p+w7n7Z9DkS5YmPjTOSEbc2yB
	 CwquARzAZXpJB8uVgHiJxsPrbls7EHwH9MJSEsZ1Be5hT0HZeTKYC638HZiJTsAIem
	 c4IcsIgE0JyrbPypRF5nZkow7yxZswOI/zPcdAXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfC3AvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730644AbfC3AvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A405218D8;
        Sat, 30 Mar 2019 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907069;
        bh=ul2sLvyD1f84cfcacpe4EO4sPFWG1eckXIPx0tvUgRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OK6ds+5fF2DRMdvjiKbocOBTfNAgLmhm4UeXWCjgj4ecVVosn4/ZP/nJ9ikHy0F8Q
         ++nMhCmsGJNBEt5HlvChldrp7iJgiHWD1AWtwFzjc9pB+zKuFbOwSopLV2w4/JxXa6
         YwbMvBsUkuVJX7j8wQq8/kfeC/rm8YtRsFIWDtdg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 16/67] mmc: davinci: remove extraneous __init annotation
Date:   Fri, 29 Mar 2019 20:49:56 -0400
Message-Id: <20190330005047.25998-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9ce58dd7d9da3ca0d7cb8c9568f1c6f4746da65a ]

Building with clang finds a mistaken __init tag:

WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
The function davinci_mmcsd_probe() references
the function __init init_mmcsd_host().
This is often because davinci_mmcsd_probe lacks a __init
annotation or the annotation of init_mmcsd_host is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..e6f14257a7d0 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1117,7 +1117,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
 {
 }
 #endif
-static void __init init_mmcsd_host(struct mmc_davinci_host *host)
+static void init_mmcsd_host(struct mmc_davinci_host *host)
 {
 
 	mmc_davinci_reset_ctrl(host, 1);
-- 
2.19.1

