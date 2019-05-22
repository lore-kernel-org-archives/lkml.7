Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56046C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2463821473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn6CJI4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfEVSfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:35:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38618 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:35:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so5200828edl.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2yFcpeyX6JPm/ecJCYVsQ23H/MFISXMka+yL/1ipPcI=;
        b=Vn6CJI4Iv01K+/MIKACrYzOgVTCFnZD+WoawUUmft83IYO69sapogfVUFB9bOzn4Uz
         P2o44RNOrKprGiToU47Lr4IQTKRxwqSDCDtnNnS53ly3FHnO/iJSje6z4IAejyobIq/a
         bqRMQkxoFDtAs0aHOjav4cnAOe5CBRZyAVMSAY4i/qKG/MMvJWvbYEeoTc51PGXFv19c
         4jq1LHLuaJNTriNuYa1Trq+r2xZ7hy/IokoKF2+IWM7NJlJkM4SunCIsFLYF8CUBOy6s
         TU1Nr2ucHtfgr3yQoS85raP+TeJ5VDOKA1OvO9q/V9MN/ytF//wxiCSQhDzrBbLXPayE
         G0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2yFcpeyX6JPm/ecJCYVsQ23H/MFISXMka+yL/1ipPcI=;
        b=K/5+9MtFQu6U5dwVw6G/DIYjgpKbizDLRNeV3UafYY7ILST35Hi2+rHmR3zQFMXHZ4
         9T+FwqoFhBzyNQ8nXa09SLCWwSCf5p/CADCfo28U/S6jc7BDJuC+pmBffIRoP+/23ywI
         7Z/juVi06LboJmSv/hFuTrZl02ibbu7UyOAKcqFMFJbkcEZolXFX3yCdjrQyxVmrTMnw
         XqdfS7Am6Slnetf0PnNFNnsWTHeJeybfsgo0H0E+4CQFjM8jg/+FeNkT2AFKrO45K7dE
         kMqxrauseXthz1nehfzajQR7adMkcbvPJxMupEel1TLX1JbNr+vAOT5Gi765as44HOTs
         Nk1A==
X-Gm-Message-State: APjAAAWxgfbPgQbofk3c4GPMXyLUYK4HRhEdAnsDqZ+6tjrPbrkD09w8
        zR5FcqCS20XLSKtmr/LVyQhO1WxP
X-Google-Smtp-Source: APXvYqxhJChWD1XAly4+6D8uS2kpzjlPZvSw2+lf63M8KVbXZanuPwO9zgr6zuOP8oM7S3EVM5Pfdw==
X-Received: by 2002:a50:fc97:: with SMTP id f23mr90805607edq.104.1558550137237;
        Wed, 22 May 2019 11:35:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k18sm7293117eda.92.2019.05.22.11.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 11:35:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal
Date:   Wed, 22 May 2019 11:35:25 -0700
Message-Id: <20190522183525.5957-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are not destroying the sysfs attribute groupe we registered during
the probe function which will make subsequent probe calls to that
driver fail. Correct that with adding a remove function which only
removes those attributes since the reference counting on clocks did its
job already.

Fixes: 415060b21f31 ("phy: usb: phy-brcm-usb: Add ability to force DRD mode to host or device")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index f59b1dc30399..292d5b3fc66c 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -376,6 +376,13 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static int brcm_usb_phy_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &brcm_usb_phy_group);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int brcm_usb_phy_suspend(struct device *dev)
 {
@@ -441,6 +448,7 @@ MODULE_DEVICE_TABLE(of, brcm_usb_dt_ids);
 
 static struct platform_driver brcm_usb_driver = {
 	.probe		= brcm_usb_phy_probe,
+	.remove		= brcm_usb_phy_remove,
 	.driver		= {
 		.name	= "brcmstb-usb-phy",
 		.owner	= THIS_MODULE,
-- 
2.17.1

