Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0901EC2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEC421744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642169;
	bh=/T7HwT5cQHY2Nk1h2a8PJTQcmCfQYDDMv5go85/bY/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b3/HLdKYYZ9WxhJYpCf6i9iQlBb3DXcMq16Dlc4VfqBBSZwpGuLkt6PENdgVwleRr
	 uA8PxpwBCMWktP8vMZFYKKn1pLIGVLkZZi9r+ivP4NnUFSyt78/PYH41bQ8WdPcnSy
	 7Zy+F6YgDdxrFFA2m50gSnGuShKHKa9lC3evOOto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfL2R4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732681AbfL2Rz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:55:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B6021D7E;
        Sun, 29 Dec 2019 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642158;
        bh=/T7HwT5cQHY2Nk1h2a8PJTQcmCfQYDDMv5go85/bY/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1lJMCfOS5NCy+DE8drEiWrMj5El7B00/1H7gJcF1NdGo07UebBk5TLKKR4Jh8FkG
         BzVfrwqegf2wF8m0vqxGpwlw6D31pRvw7CkZunL/03Dbj7Ht4COG2vUbKEqVk8hkvd
         ttH3/SD8fhgnwBLYA5UPlg4IhvwVh1bIaZBuNApk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 364/434] mmc: mediatek: fix CMD_TA to 2 for MT8173 HS200/HS400 mode
Date:   Sun, 29 Dec 2019 18:26:57 +0100
Message-Id: <20191229172726.150815354@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaotian Jing <chaotian.jing@mediatek.com>

commit 8f34e5bd7024d1ffebddd82d7318b1be17be9e9a upstream.

there is a chance that always get response CRC error after HS200 tuning,
the reason is that need set CMD_TA to 2. this modification is only for
MT8173.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: stable@vger.kernel.org
Fixes: 1ede5cb88a29 ("mmc: mediatek: Use data tune for CMD line tune")
Link: https://lore.kernel.org/r/20191204071958.18553-1-chaotian.jing@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/mtk-sd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -228,6 +228,7 @@
 #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)	/* RW */
 #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)	/* RW */
 
+#define MSDC_PATCH_BIT1_CMDTA     (0x7 << 3)    /* RW */
 #define MSDC_PATCH_BIT1_STOP_DLY  (0xf << 8)    /* RW */
 
 #define MSDC_PATCH_BIT2_CFGRESP   (0x1 << 15)   /* RW */
@@ -1881,6 +1882,7 @@ static int hs400_tune_response(struct mm
 
 	/* select EMMC50 PAD CMD tune */
 	sdr_set_bits(host->base + PAD_CMD_TUNE, BIT(0));
+	sdr_set_field(host->base + MSDC_PATCH_BIT1, MSDC_PATCH_BIT1_CMDTA, 2);
 
 	if (mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
 	    mmc->ios.timing == MMC_TIMING_UHS_SDR104)


