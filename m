Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3127BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE82620850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EgQOslsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfDKJbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:31:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35663 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbfDKJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:30:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so6391146wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=joOQiQILwSUQpc0pTrHcK/ya5VvWQmcmFsscTsVp5Yw=;
        b=EgQOslscCdg9QNMZU/Bmy89sWYhpPCz71b3AUgk9nLqxNHNg1pI/E5AN+sMPGwj0no
         dLLWajdIxgW6ZXMt0sD9MPDdhZey85TqREKHcEoQ5dItHGElCuMk+LDOKuV0CiuYAS3Z
         qx0krI14O7/bgOxhziDK099EixwkG4mR7RvOaXhf8yz/FGfnzV9o1QRcXvGpBpm9HvKN
         QlkJJ+JuuKpMyz4xOoSW03IcBBKcAz/HV9yKR4VnkBh4QcItjeS181kTJAURjl1ruz6A
         fkRxdxAgWImttXyvzhGfBpaEkZfdasotYPRLd/S7Pk19gH2BqHsm+Y1HzgRQ45Xgmfo9
         K3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joOQiQILwSUQpc0pTrHcK/ya5VvWQmcmFsscTsVp5Yw=;
        b=apg4NrJzmm+UGAwYxmnbVwuK12VMStfS2erFwM9B3/4Wj59//hGPn+Ix9tgycDkq/S
         fatUFVrROA5/BaC3sbtEDUDg0SYZ/hqPIMlQ630KVvGK1L6gY/bqYJHTXl8AB5hc4ygC
         rHhuwGdOeHCIUmzwBBXMD1fbUDKiyWnQWGv984HiJQ6QSg7VIVyfFqvX4955cjAxawSd
         KXjbzgHHjAtGYRx20lv28FGm1aeFq6Yv18MPhRMajUDlzIbI20Ot7FOTyZaeD4Qo11H/
         hqvuq2Z/K6YE2eD4x9SKfem8On0Qt9OWG3gz/DevT6LRLjNPepEg5ozuNvfsOg3CIOyo
         KZvg==
X-Gm-Message-State: APjAAAUqkMJ5vGgReIMiEIbznlRsD+6zRvRPsTKGX5TOdF/MQM7yJxCp
        /xITSJbLSu6co2zyUB8yjJVX2w==
X-Google-Smtp-Source: APXvYqyUOAE+neN/xsO+xoLZUe6zOOYX4bRL3Bf0Vlw1KF3Q1rQEfh4MaSvn1jgF2DVc2WcCsdXfAw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr30852625wru.117.1554975032038;
        Thu, 11 Apr 2019 02:30:32 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a9sm37517228wrt.29.2019.04.11.02.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:30:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/6] usb: ohci-da8xx: let the regulator framework keep track of use count
Date:   Thu, 11 Apr 2019 11:30:20 +0200
Message-Id: <20190411093024.23555-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411093024.23555-1-brgl@bgdev.pl>
References: <20190411093024.23555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no reason to have a separate variable to keep track of the
regulator state. The regulator core already does that. Remove
reg_enabled from struct da8xx_ohci_hcd.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-da8xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index ca8a94f15ac0..209a262b5565 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -40,7 +40,6 @@ struct da8xx_ohci_hcd {
 	struct phy *usb11_phy;
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
-	unsigned int reg_enabled;
 	struct gpio_desc *vbus_gpio;
 	struct gpio_desc *oc_gpio;
 };
@@ -100,21 +99,18 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
 
-	if (on && !da8xx_ohci->reg_enabled) {
+	if (on) {
 		ret = regulator_enable(da8xx_ohci->vbus_reg);
 		if (ret) {
 			dev_err(dev, "Failed to enable regulator: %d\n", ret);
 			return ret;
 		}
-		da8xx_ohci->reg_enabled = 1;
-
-	} else if (!on && da8xx_ohci->reg_enabled) {
+	} else {
 		ret = regulator_disable(da8xx_ohci->vbus_reg);
 		if (ret) {
 			dev_err(dev, "Failed  to disable regulator: %d\n", ret);
 			return ret;
 		}
-		da8xx_ohci->reg_enabled = 0;
 	}
 
 	return 0;
-- 
2.21.0

