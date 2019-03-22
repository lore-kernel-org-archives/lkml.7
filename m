Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7295921873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259305;
	bh=on+R2nQIaxF54KIDWNxTwaZZip1dT92o7ZwXkemC/Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PBHRibXPnxtgU+JRTd7v5/EB656N9pBu7gRXcr61Hd1a92YwJtPWvOaprqH1SiBpW
	 vMk/kgXxG2YQJ1xmYSlmj+E3rjxZmTrMp6l/ueiJxelSTbAn0ZZOUUMJ7gU1z9YM+G
	 NGK4Atm2kGkxEItwTLXdlgIPbmTLjosbLgpW/L+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfCVLuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732611AbfCVLuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9ED2082C;
        Fri, 22 Mar 2019 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255417;
        bh=on+R2nQIaxF54KIDWNxTwaZZip1dT92o7ZwXkemC/Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlJOmsv2Uxmg/V5BMgVZ1JjFee+ZWZzwFVCNn2fUAmloZJjlNCk7Ue8D14TjMtUsF
         oVTqERQeOl6HDq4psQ355ABilwZ9PZgakWBnaNLWH9QMXK2WShpO6oAOCETDvGJsga
         GXaQaE3yhBV8mqrD5XOML0ILZ6pTfvgwwit/sLcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 085/183] mmc: sdhci-esdhc-imx: fix HS400 timing issue
Date:   Fri, 22 Mar 2019 12:15:13 +0100
Message-Id: <20190322111247.891275050@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -961,6 +961,7 @@ static void esdhc_set_uhs_signaling(stru
 	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS:
 	case MMC_TIMING_MMC_HS200:
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		break;


