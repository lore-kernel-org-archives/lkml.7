Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED782085A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 00:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pAui3RKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfG2ADC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 20:03:02 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.39]:34804 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbfG2ADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 20:03:01 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 42D0D1BB02
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 19:03:01 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rt81hyXGoYTGMrt81hmiJW; Sun, 28 Jul 2019 19:03:01 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SJfPdZTo2M85Vw3lHIQ11VnHDmrMyrobeeJz1b5+CjI=; b=pAui3RKJ1ADSdk4AwIc+LTxLgw
        VkhmHMV4lTkhok2hK1TM1gX1q0p3Wyb/MxMwTWG4GHFr7n/tt+KJj1u3k5kNzzMk1S+hRfrb99SHG
        aVigMBTyAM8oKyVaKrX/PEoZ8eR5JOwt6Kq57CO6p0sM0vULmnAKkL8mmS5jlC+W9gI+FRX5+DJc2
        nkMc/lsJP96phVeOrc3WFZd5VZEgduiLmMicIonxttCtEC4acWlctuTSARPR7iRXqe1DDa/HTJ35G
        58DHevjxcYTWtxjq05Ymc7hdB8Cvnj6CGduk7x1p7tPXhV1pcNeW/hEkh0myLRzaD8KoakJNKfF4Q
        O6VbInLw==;
Received: from [187.192.11.120] (port=39660 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrt7z-003pUp-IG; Sun, 28 Jul 2019 19:02:59 -0500
Date:   Sun, 28 Jul 2019 19:02:59 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] mmc: sdhci-s3c: Mark expected switch fall-through
Message-ID: <20190729000259.GA24022@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrt7z-003pUp-IG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:39660
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
drivers/mmc/host/sdhci-s3c.c:613:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->mmc->caps |= MMC_CAP_8_BIT_DATA;
drivers/mmc/host/sdhci-s3c.c:614:2: note: here
  case 4:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-s3c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e4a8ba33f05..cefa0fb8cfde 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -611,6 +611,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	switch (pdata->max_width) {
 	case 8:
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+		/* Fall through */
 	case 4:
 		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
 		break;
-- 
2.22.0

