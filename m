Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E10C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300E0222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497537;
	bh=iM1DRWLg/EZkcgBIASKaE0hYTDyDeIPKvMjcj8krd/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlBDicXVEzT98bpbi5vig1VIoMXIJ5qvIuEflUuoRE50u+ARx4yRk0UCF/CpYTZia
	 9eLjG7Rhy5TP/Pc1PFPXIIs1BesFwx5uMe1m3hRYim7DYi55rSbWmdLUvo0oL20Tw0
	 XpruhrqPmJZ5v6f5TAmyDxNIAJppNwrjb2pPKIb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfKKSiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbfKKSix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:38:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB552196E;
        Mon, 11 Nov 2019 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497532;
        bh=iM1DRWLg/EZkcgBIASKaE0hYTDyDeIPKvMjcj8krd/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzTra3WTl4GSRSO64eIoTv8B1fKkAA7sw9kbVQgWruiqP85DDlmyHDsC2koDdKeoM
         OjdDUCrM8pcXgH5OLCPtjvqPtl2XOpJJf5cOehYxjJoUIFCTYSUEZxwG5s2RN/0FwL
         oDuniF/fIzclrHet8SGyQGMStG/o2x46wcTgjxV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.14 047/105] mfd: palmas: Assign the right powerhold mask for tps65917
Date:   Mon, 11 Nov 2019 19:28:17 +0100
Message-Id: <20191111181441.571177580@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

commit 572ff4d560be3784205b224cd67d6715620092d7 upstream

The powerhold mask for TPS65917 is different when comapred to
the other palmas versions. Hence assign the right mask that enables
power off of tps65917 pmic correctly.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/palmas.c       |   10 +++++++++-
 include/linux/mfd/palmas.h |    3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -430,6 +430,7 @@ static void palmas_power_off(void)
 {
 	unsigned int addr;
 	int ret, slave;
+	u8 powerhold_mask;
 	struct device_node *np = palmas_dev->dev->of_node;
 
 	if (of_property_read_bool(np, "ti,palmas-override-powerhold")) {
@@ -437,8 +438,15 @@ static void palmas_power_off(void)
 					  PALMAS_PRIMARY_SECONDARY_PAD2);
 		slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
 
+		if (of_device_is_compatible(np, "ti,tps65917"))
+			powerhold_mask =
+				TPS65917_PRIMARY_SECONDARY_PAD2_GPIO_5_MASK;
+		else
+			powerhold_mask =
+				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK;
+
 		ret = regmap_update_bits(palmas_dev->regmap[slave], addr,
-				PALMAS_PRIMARY_SECONDARY_PAD2_GPIO_7_MASK, 0);
+					 powerhold_mask, 0);
 		if (ret)
 			dev_err(palmas_dev->dev,
 				"Unable to write PRIMARY_SECONDARY_PAD2 %d\n",
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -3733,6 +3733,9 @@ enum usb_irq_events {
 #define TPS65917_REGEN3_CTRL_MODE_ACTIVE			0x01
 #define TPS65917_REGEN3_CTRL_MODE_ACTIVE_SHIFT			0x00
 
+/* POWERHOLD Mask field for PRIMARY_SECONDARY_PAD2 register */
+#define TPS65917_PRIMARY_SECONDARY_PAD2_GPIO_5_MASK		0xC
+
 /* Registers for function RESOURCE */
 #define TPS65917_REGEN1_CTRL					0x2
 #define TPS65917_PLLEN_CTRL					0x3


