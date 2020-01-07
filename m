Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75812C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4540F2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431633;
	bh=6VoqeGveJREBkuplXC7wYAfH0Bl22wXTQobbpVsqYLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2cwkGHcSxdZDFL4QxTlTf+D8N89iAdYsj5NZmbETLFuxTn5y8bsmYryhw++Df2+u
	 hXVKV6Xmjd6CEdjCbLp8eadH1wE2cyygVIoTHi2gtl5z4fhDYYPCgIWoCWVl0pwXSM
	 79GLAw4R6E/dr9GT+QbKuHZ9bSr9sOwjV2oOnibI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgAGVJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbgAGVJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:09:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA122077B;
        Tue,  7 Jan 2020 21:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431388;
        bh=6VoqeGveJREBkuplXC7wYAfH0Bl22wXTQobbpVsqYLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RxjXAMoJDugxgHHps4ddcWOMHGssMiwm0wd0JtACcyT7y+5Kr9NhgbAijw7qYvmqN
         R/4zcbEnyWeC5s4K39j1uWQfBflbvbMcf9txi7qJDDYkqd8/INPj7+qPoRFmvtqqbY
         Du+67KQY2rRRR1P6vF9Ad/vB7L4eUYXaeCjEnUNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 37/74] ata: ahci_brcm: Allow optional reset controller to be used
Date:   Tue,  7 Jan 2020 21:55:02 +0100
Message-Id: <20200107205207.390016921@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 2b2c47d9e1fe90311b725125d6252a859ee87a79 upstream.

On BCM63138, we need to reset the AHCI core prior to start utilizing it,
grab the reset controller device cookie and do that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/ahci_brcm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/string.h>
 
 #include "ahci.h"
@@ -87,6 +88,7 @@ struct brcm_ahci_priv {
 	u32 port_mask;
 	u32 quirks;
 	enum brcm_ahci_version version;
+	struct reset_control *rcdev;
 };
 
 static const struct ata_port_info ahci_brcm_port_info = {
@@ -327,6 +329,11 @@ static int brcm_ahci_probe(struct platfo
 	if (IS_ERR(priv->top_ctrl))
 		return PTR_ERR(priv->top_ctrl);
 
+	/* Reset is optional depending on platform */
+	priv->rcdev = devm_reset_control_get(&pdev->dev, "ahci");
+	if (!IS_ERR_OR_NULL(priv->rcdev))
+		reset_control_deassert(priv->rcdev);
+
 	if ((priv->version == BRCM_SATA_BCM7425) ||
 		(priv->version == BRCM_SATA_NSP)) {
 		priv->quirks |= BRCM_AHCI_QUIRK_NO_NCQ;


