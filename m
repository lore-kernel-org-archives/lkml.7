Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5133DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123342075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kc1uvwUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfC0OQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:16:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32944 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfC0OQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:16:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so1142575pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BLLMu/8vv8doTaNCrawYhyQVCHWkAOH2yUy1WysYxq8=;
        b=Kc1uvwUsaacLx9fi3fJc9kimvmV2RJP8U7tvUeYZAztvrUJD3A92CxGKVRVdLw0bLz
         jnsNbmBm7pALN2dUe1oQ27V3jl6KL9qo43gT5pCTliSsnZneXpgFXrVctGmNlgXY/5i/
         MhT4KNFGO7jULvH7eHP8dWrcen90PPkk6i6S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BLLMu/8vv8doTaNCrawYhyQVCHWkAOH2yUy1WysYxq8=;
        b=k5Hn2B+vPQsZ4H/aU+EVaMpJForRCzF0ybCrLbsM1nwJgjWSctWzPxJwir6LE/SsjA
         K1eFiV9rD2Wze9eC4+Tz2ZO81bYDJPfJFLOsIB9piwdYW4ELMMRhcCJuGEuy+mGe8O8b
         VFOkuw9RyRFMCI8PIihsmg/x0ezjllTg5Ie+M4HiRNTDO4UTV28uJ66iQyi7vkxCkVny
         /7zu700Ycnd9YrfjQjwImMvpJpcvIEWPWVdq7jxTamuyGcTpx11BVrgm6CxTV/cijmjL
         PbizYSfbYb88Wvo9KRFLIAOj2zX410ZbFVHs5uSO/dUptYoVBBSsfjRjZYG4uQAC+Ko5
         a5lQ==
X-Gm-Message-State: APjAAAUuOHNcP0RJdf8qY2wmubIM9L/+FnB/U0krJGFlZF2FKtaP809e
        5invCPPX58f6QI47B5TVdDfhpw==
X-Google-Smtp-Source: APXvYqwWTLMHvtWhhUhVhTAHB6h5nN3vsJed33n1ilFd9iO9TZdYx0miUNPQvd14Nnoinygaaehm4A==
X-Received: by 2002:a63:6805:: with SMTP id d5mr1128070pgc.416.1553696172200;
        Wed, 27 Mar 2019 07:16:12 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h8sm15663294pfo.149.2019.03.27.07.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 07:16:10 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] phy: sr-usb: fix build warning
Date:   Wed, 27 Mar 2019 19:45:47 +0530
Message-Id: <1553696147-32633-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add invalid version check to fix below warning reported for stingray
usb phy driver.

The kbuild robot reports:

drivers/phy/broadcom/phy-bcm-sr-usb.c: In function 'bcm_usb_phy_probe':
warning: 'phy_cfg' may be used uninitialized in this function

Fixes: a3b96057577 (phy: sr-usb: Add Stingray USB PHY driver)
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index bfe8237..fe6c589 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -328,7 +328,8 @@ static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
 			return PTR_ERR(phy_cfg->phy);
 
 		phy_set_drvdata(phy_cfg->phy, phy_cfg);
-	}
+	} else
+		return -ENODEV;
 
 	dev_set_drvdata(dev, phy_cfg);
 
-- 
2.7.4

