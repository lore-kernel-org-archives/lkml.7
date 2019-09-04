Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF023C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7F208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620459;
	bh=DAi0C6swFcMcd//mMOcVxSAobHTZG8k4cKETahqWwl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1r60pDuO7adUvzugNCLoCqnRgWTT9EQtAn4tqmNk6OMvnCTVkxb0Cinf4/Ueh/czS
	 cxqAwL4wbjxS7THN8ANda7MD1ol5kn6ua3sFHDZXtpbxJ969gZkw5YU5GHpy7BX3qO
	 2cWvSGbPgH5XWpTGNpATNJGzXkm5tSyz4BQJB+vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbfIDSHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389470AbfIDSHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922F12087E;
        Wed,  4 Sep 2019 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620454;
        bh=DAi0C6swFcMcd//mMOcVxSAobHTZG8k4cKETahqWwl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOI1rfJyY+/Ag64L+eiKpHqhQmDct6gIiILf74EpouDGig3I4OFkaLNubHT1SZrKX
         lB2VqxkntpGUiOf2CZ2ylNQsc7/Ytm1Kd3R7ueAhkgUedyXPniwnCInCC9orqIPbS7
         LPyEExZMMRXWfH58h5jgWXshkjJpHlqeej9uVwhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philip Langdale <philipl@overt.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manuel Presnitz <mail@mpy.de>
Subject: [PATCH 4.19 64/93] mmc: core: Fix init of SD cards reporting an invalid VDD range
Date:   Wed,  4 Sep 2019 19:54:06 +0200
Message-Id: <20190904175308.500855452@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 72741084d903e65e121c27bd29494d941729d4a1 upstream.

The OCR register defines the supported range of VDD voltages for SD cards.
However, it has turned out that some SD cards reports an invalid voltage
range, for example having bit7 set.

When a host supports MMC_CAP2_FULL_PWR_CYCLE and some of the voltages from
the invalid VDD range, this triggers the core to run a power cycle of the
card to try to initialize it at the lowest common supported voltage.
Obviously this fails, since the card can't support it.

Let's fix this problem, by clearing invalid bits from the read OCR register
for SD cards, before proceeding with the VDD voltage negotiation.

Cc: stable@vger.kernel.org
Reported-by: Philip Langdale <philipl@overt.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Philip Langdale <philipl@overt.org>
Tested-by: Philip Langdale <philipl@overt.org>
Tested-by: Manuel Presnitz <mail@mpy.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/sd.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1277,6 +1277,12 @@ int mmc_attach_sd(struct mmc_host *host)
 			goto err;
 	}
 
+	/*
+	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
+	 * these bits as being in-valid and especially also bit7.
+	 */
+	ocr &= ~0x7FFF;
+
 	rocr = mmc_select_voltage(host, ocr);
 
 	/*


