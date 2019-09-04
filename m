Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB98C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64BA2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612759;
	bh=2vjN1mTgWrVfPYXSq4C3quBd4Ijtnf7GY7w2gVNMFUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCHrrTXlE+eXGvE55PL5Bfq7gwcXaH0Y1IXRII3p87ec0yM6Nx3BW59rKoV8wdIMH
	 x/5hwyAWvDPWFLuxfRMI0/dTIaJkbgpmBVQtCr7Ux3K1boiygy3lmeAooviFgnh1YW
	 zKPTV4Z/DoD+B37AiJEt3vKqQ2YFUOPXbO8w1Nik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfIDP7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732336AbfIDP7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F452087E;
        Wed,  4 Sep 2019 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612755;
        bh=2vjN1mTgWrVfPYXSq4C3quBd4Ijtnf7GY7w2gVNMFUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbbMZn9T9RHvcZUkqgbqABupcvdiMlGIS7BoDSsyj5BPLyWQgiB/zxO9ht5Kz4zuM
         lhOH71qPmir3besBiebHf+/s9uIctd/z0fMvcIsmavVKatJ/QQA1XfL2lonnsZ+iRz
         NiGnqk9YVazFNwaB2/n6CdmOm13Q9U9ZIYg5gqsA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nagarjuna Kristam <nkristam@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 64/94] usb: host: xhci-tegra: Set DMA mask correctly
Date:   Wed,  4 Sep 2019 11:57:09 -0400
Message-Id: <20190904155739.2816-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nagarjuna Kristam <nkristam@nvidia.com>

[ Upstream commit 993cc8753453fccfe060a535bbe21fcf1001b626 ]

The Falcon microcontroller that runs the XUSB firmware and which is
responsible for exposing the XHCI interface can address only 40 bits of
memory. Typically that's not a problem because Tegra devices don't have
enough system memory to exceed those 40 bits.

However, if the ARM SMMU is enable on Tegra186 and later, the addresses
passed to the XUSB controller can be anywhere in the 48-bit IOV address
space of the ARM SMMU. Since the DMA/IOMMU API starts allocating from
the top of the IOVA space, the Falcon microcontroller is not able to
load the firmware successfully.

Fix this by setting the DMA mask to 40 bits, which will force the DMA
API to map the buffer for the firmware to an IOVA that is addressable by
the Falcon.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/1566989697-13049-1-git-send-email-nkristam@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-tegra.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 294158113d62c..77142f9bf26ae 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1217,6 +1217,16 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 
 	tegra_xusb_config(tegra, regs);
 
+	/*
+	 * The XUSB Falcon microcontroller can only address 40 bits, so set
+	 * the DMA mask accordingly.
+	 */
+	err = dma_set_mask_and_coherent(tegra->dev, DMA_BIT_MASK(40));
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to set DMA mask: %d\n", err);
+		goto put_rpm;
+	}
+
 	err = tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to load firmware: %d\n", err);
-- 
2.20.1

