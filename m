Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B98E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256977;
	bh=hN6tBlMji7OyBYl0a4drz0k18ueJxevOA/DPoqq6m/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1pOzhMzO2ZyU7kKKVC+F8bhHTs8HdrnBHtazKuJ15OqI2qEYR8eIaGBeMQr7oAp8Y
	 YUaD9nCCZ4xwCJuNHkFMu1JiMvFHnA65uMz3DDrOTTh3PHIWBvzJ5ymvPNxDtLIcM9
	 ErJbSvgcHHmUBNBI2D47girLFR1S8Ydr/EGxBhQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390185AbfCVMQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389935AbfCVMQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259172083D;
        Fri, 22 Mar 2019 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256972;
        bh=hN6tBlMji7OyBYl0a4drz0k18ueJxevOA/DPoqq6m/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4GhkxgCc3FO2604SwD/mVWKM495+FCbS5L+udfA20PV1iI/hueOmhLicxlM8tTd8
         rxyTw07aafE8In1bwfpy0ZOF5r8oC06xDfyJhTl4NQd83I+pPm0eat82F79QsBOOPI
         dJSG0Fher83METJ+caWieOiGb4T3ysDC9zA6x8vA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.0 062/238] mmc: sdhci-esdhc-imx: fix HS400 timing issue
Date:   Fri, 22 Mar 2019 12:14:41 +0100
Message-Id: <20190322111302.221433774@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: BOUGH CHEN <haibo.chen@nxp.com>

commit de0a0decf2edfc5b0c782915f4120cf990a9bd13 upstream.

Now tuning reset will be done when the timing is MMC_TIMING_LEGACY/
MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS. But for timing MMC_TIMING_MMC_HS,
we can not do tuning reset, otherwise HS400 timing is not right.

Here is the process of init HS400, first finish tuning in HS200 mode,
then switch to HS mode and 8 bit DDR mode, finally switch to HS400
mode. If we do tuning reset in HS mode, this will cause HS400 mode
lost the tuning setting, which will cause CRC error.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Cc: stable@vger.kernel.org # v4.12+
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: d9370424c948 ("mmc: sdhci-esdhc-imx: reset tuning circuit when power on mmc card")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-esdhc-imx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -979,6 +979,7 @@ static void esdhc_set_uhs_signaling(stru
 	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS:
 	case MMC_TIMING_MMC_HS200:
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		break;


