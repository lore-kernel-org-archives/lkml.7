Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698DC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC6822CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620802;
	bh=Lp65w8bCVFRZzhKlFfy8mS7sxj3+157WDvruDBBU3Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1qrDJtUl+sRzANwszpc9XhDujPETFQI8tE/ykDNg/JNgrpV9DAyJqpxkWjJf513eF
	 gTVcl9xRJwV4D/NGuUD+1VEu3xXFWJuysFax67x34YeP4cADwvx5kSDHNrhQwdE6Wx
	 rT02CMOE45rJ4aT0m9xYRaFHsZlm0vjIqzCsNd+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390670AbfIDSNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389686AbfIDSNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:13:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBDE23400;
        Wed,  4 Sep 2019 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620798;
        bh=Lp65w8bCVFRZzhKlFfy8mS7sxj3+157WDvruDBBU3Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yix90NLIOxf4tBNE0SIaHNZGvxJv5QRpnTj7ZgqSobWK/dfphibzS3m/GuB0LF5iS
         OxHsvfsGTxI7oe1cW6dYCmUtqp1vUynRQidMrp7P30yTRi9yOOxWHJ0UFLj2kIkheE
         T/mB6Uc0u8iNwKKqss+50oKH42+omfht7jqHOrig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.2 097/143] mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Wed,  4 Sep 2019 19:54:00 +0200
Message-Id: <20190904175317.989209856@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

commit 6a526f66ab1494b63c71cd6639d9d96fd7216add upstream.

The bit of PRESET_VAL_ENABLE in HOST_CONTROL2 register is reserved on
sprd's sd host controller, set quirk2 to disable configuring this.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-sprd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -321,7 +321,8 @@ static void sdhci_sprd_request(struct mm
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
-		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
+		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_sprd_ops,
 };
 


