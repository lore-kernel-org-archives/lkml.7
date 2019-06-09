Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A49C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D2A206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099824;
	bh=5ixMBIq1+roRVC3r4/nZrw1E/YkRIL6fVkkxoQk5dnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gto+orp0z5eDriwB+aYyAnqWkPidtXsCSn1E7BuZjwfZlMAOLCYprwDyk1BOrnL3u
	 6BQBtfg0HwZ4VxYtv5enMweNG9tXgdDwAmZBKZV+21Mbq1hHtybtaKjhjoQKyKo+4P
	 m8xaaU5gE7wIGRT0DTOTZSELCc4rVWOpKJueromw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbfFIRDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:03:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388448AbfFIRDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF6D6206C3;
        Sun,  9 Jun 2019 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099818;
        bh=5ixMBIq1+roRVC3r4/nZrw1E/YkRIL6fVkkxoQk5dnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtrS1lzn1lwjCDs6R2Lr/R9b4Hzu7R0Q77qKA6mr8JzSvOfFnFf4goDgSnXaRcZBG
         zQ0NFwEcgXDXF9TbUDTaowsWFMDNCcwvLw5d0iBK8Bku5N+GpyO8gpdl2GZt4X7rSy
         8XOf3UTa4ewztKonv7aRlThO7kS80SvxVr/CKzDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yinbo Zhu <yinbo.zhu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 140/241] mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358 support
Date:   Sun,  9 Jun 2019 18:41:22 +0200
Message-Id: <20190609164151.828510409@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 05cb6b2a66fa7837211a060878e91be5eb10cb07 ]

eSDHC-A001: The data timeout counter (SYSCTL[DTOCV]) is not
reliable for DTOCV values 0x4(2^17 SD clock), 0x8(2^21 SD clock),
and 0xC(2^25 SD clock). The data timeout counter can count from
2^13–2^27, but for values 2^17, 2^21, and 2^25, the timeout
counter counts for only 2^13 SD clocks.
A-008358: The data timeout counter value loaded into the timeout
counter is less than expected and can result into early timeout
error in case of eSDHC data transactions. The table below shows
the expected vs actual timeout period for different values of
SYSCTL[DTOCV]:
these two erratum has the same quirk to control it, and set
SDHCI_QUIRK_RESET_AFTER_REQUEST to fix above issue.

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index a5a11e7ab53b4..356b294c93c9e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -624,8 +624,10 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	if (esdhc->vendor_ver > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 
-	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc"))
+	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
 		host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
+		host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	}
 
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
-- 
2.20.1



