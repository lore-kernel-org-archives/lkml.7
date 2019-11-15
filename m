Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E016C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176CD2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfQzyGBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKOSoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:44:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38611 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKOSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so12049679wro.5;
        Fri, 15 Nov 2019 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=ZfQzyGBTDq2JsmAF6Eh9iDl+Q8ae6hWrlfyq1qDABegjvni4ncRQe7VfUvjwF8NZOm
         zqDIxIfzys9VdjodVY+M+y+H4Y23arlmvL4yTcmzZyH2WBG+dCAvYIUxSV1UPQjw5zI6
         2kUubxMAG/576F7xmvw+IHx3iBzS7qPXTzLjKhM44OHG7CY4rBS77k9gnqwkvOI9KDYZ
         WrtUkiK5hOPFyrrW3YC8xUVygOMuS3UWCsnlpQbBSCGcX9bP0WvjSN13B2FpG/b2FkAp
         0Rr/XhxLZFXTZSWI0CiMysGIAvsl1do3BL0JXEYwRQRsvYnTS/FiHQ+fZGe9NBuJWEUH
         pPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wS4OYwLXLEvBtINm/7GwVk3W/9nI5ZzRdQ3AYe/w/RE=;
        b=o/1TQH8EnJrQde6yw6cR7Rmnm3Wo5lnqIu7lUCCe/szPoAyImM0/bpVfg51mOhh9jE
         sl2ZQS2uZsCUBpUFjgYEHw7GH11Oik6suyWt5u7HHZDIjX6DoOt3geZuffVsLv7Lf/zz
         lIbPgFNKBOej/SPM7ESWBEKTrIv7i+sq6kWpGny/VwUqp32CzJIs4BFhgRgFPSQcBUL5
         gju2y1nkFncisjwQKOpjpnucff/VR854f+YKP/41KYyEILLiVm31dvj/F1ae0SUSDrPa
         Nb0X6IwGWUKnPXnQJpWuCdDWjrfsIYdCkoX0W/Zz4eOrfqcmE/dqWxygA4WNty5PAwOs
         rAFQ==
X-Gm-Message-State: APjAAAVWqQRTt635tuLkX49knCMm8ucwKxnGTnNN5M1y1lhXY8U4tfim
        +be6r5Jn1u8pDo/KSOFjXPKA7vTCsbI=
X-Google-Smtp-Source: APXvYqx5Ackgu5oO7MlkxDLNeqrXtQzAqtgQjJXWKc6eQCl5NZT10rv9zLGyYs9Wmoopnoh/iyFT7A==
X-Received: by 2002:adf:de86:: with SMTP id w6mr16923037wrl.220.1573843436058;
        Fri, 15 Nov 2019 10:43:56 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:55 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 12/13] phy: usb: USB driver is crashing during S3 resume on 7216
Date:   Fri, 15 Nov 2019 13:42:22 -0500
Message-Id: <20191115184223.41504-13-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115184223.41504-1-alcooperx@gmail.com>
References: <20191115184223.41504-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a result of the USB 2.0 clocks not being disabled/enabled
during suspend/resume on XHCI only systems.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index cc5763ace3ad..1ab44f54244b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -543,7 +543,7 @@ static int brcm_usb_phy_suspend(struct device *dev)
 		brcm_usb_wake_enable(&priv->ini, true);
 		if (priv->phys[BRCM_USB_PHY_3_0].inited)
 			clk_disable_unprepare(priv->usb_30_clk);
-		if (priv->phys[BRCM_USB_PHY_2_0].inited)
+		if (priv->phys[BRCM_USB_PHY_2_0].inited || !priv->has_eohci)
 			clk_disable_unprepare(priv->usb_20_clk);
 		if (priv->wake_irq >= 0)
 			enable_irq_wake(priv->wake_irq);
-- 
2.17.1

