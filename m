Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8177C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D7F21934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256304;
	bh=9cxJeWuTvTSMON4oCdGSeMBpWt8+bdvqde6Rjlkb5HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGjpC400fdkkUEA/t72gZmQVoi98Ty+ot/Nw5LjhhxBB9M2MGQBqMmik29tfGDeWa
	 oyBT4N5Qrf9+gK7b3Z/ENpggMoA1sFlpq2fsOhrkbM4CstALFRGIKptluRZhFUZgGv
	 IUo29c5OwVT24bXG3mdsq8IQr1b9Ug4rnpGKAQF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbfCVMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388247AbfCVME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:04:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCE22192D;
        Fri, 22 Mar 2019 12:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256298;
        bh=9cxJeWuTvTSMON4oCdGSeMBpWt8+bdvqde6Rjlkb5HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxeDWN9PdvJtqYhRoJf1om3lqlNtdQsnvUzXmDCksTV5QuvnnQY10gvZp9t5KLNt8
         sntwcjoYXyAxFTCT2tCwdCLjOso899fb8lBfUv0PB3pCrj0Kj8u1D25QSuPjIgBK2y
         M/i0OEoJQ1T878gC4jhzFfK5sao4TfleoMlN0NIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.19 145/280] mmc: sdhci-esdhc-imx: fix HS400 timing issue
Date:   Fri, 22 Mar 2019 12:14:58 +0100
Message-Id: <20190322111319.137302540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -981,6 +981,7 @@ static void esdhc_set_uhs_signaling(stru
 	case MMC_TIMING_UHS_SDR25:
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS:
 	case MMC_TIMING_MMC_HS200:
 		writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		break;


