Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CF2C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052D4206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DTXJINGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfGaKUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:20:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32944 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbfGaKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:20:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so30217877plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RQGFkwgFaLnGGoQ1NvDOCDLZIEZUzuJI5zevIe71AxU=;
        b=DTXJINGXVoTql1fXQHHPFsg3EipbEhbHQzDr6FeRofUSP/OzviQIKQg+49YLikdEqQ
         YjNM5/uykn2qAyF0kVd/+4V/lByaAjL4OlR1muQrRUKLmQ3xs48e9VAQruzJToarL/XU
         3YIZuGVXB1XvgHJh22L/KCNzYkMI96K7Qz0es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RQGFkwgFaLnGGoQ1NvDOCDLZIEZUzuJI5zevIe71AxU=;
        b=I9Zrx6DHye6bg8+yAEO8rtTTlAGdL8tG84K/9Lc9RMLgJa/PNbxO3c5utajxm8QMMA
         gShOYJccYDqBE+gL9dq5tnn/ReRonjicbBL+WqPpaIrMgl7op/fkY2cKorokseX/4KrP
         R4iEMsFEBON7kQewkH+6fjRom627OVNLe82jhEMZJmR8v1Tjnu/oua/GQA3eYWnrmrtQ
         +jo/Qdo3c08fYPuSayrSsDwKXl3U4rkCRihwULHGEILd9UUelf1BTTBxJnav4vUCKiXq
         KkJFF8Sssu5mac5HTa3SL1mIU2bzw9iTbZk7aPC1a1e6m6hzlV1nNGi1OJOvXJCQuIAy
         xuAw==
X-Gm-Message-State: APjAAAUSwBZC1o9PKOw3sGfe9i9auTw+AEIXM/XRXjc/96MvZ1OQbImu
        LrdWiCZkhfBMC1kAoh9qVtjTEw==
X-Google-Smtp-Source: APXvYqyQgTrw9DUSsZLKLghRHWUN5/nvwSS94vv8+O0RVIrayMcxuja5bB0RZ59O26Nh4mBQFbfI0w==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr119247923plb.269.1564568423495;
        Wed, 31 Jul 2019 03:20:23 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 3sm71161776pfg.186.2019.07.31.03.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:20:22 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 3/5] phy: sr-usb: Set phy ports
Date:   Wed, 31 Jul 2019 15:49:53 +0530
Message-Id: <1564568395-9980-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set phy ports value in xlate handler which is taken from second argument
of PHY phandle.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/phy/broadcom/phy-bcm-sr-usb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
index fe6c589..5274e45 100644
--- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
+++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
@@ -278,9 +278,16 @@ static struct phy *bcm_usb_phy_xlate(struct device *dev,
 		if (WARN_ON(phy_idx > 1))
 			return ERR_PTR(-ENODEV);
 
+		if (args->args[1])
+			phy_set_phy_ports(phy_cfg[phy_idx].phy, args->args[1]);
+
 		return phy_cfg[phy_idx].phy;
-	} else
+	} else {
+		if (args->args[0])
+			phy_set_phy_ports(phy_cfg->phy, args->args[0]);
+
 		return phy_cfg->phy;
+	}
 }
 
 static int bcm_usb_phy_create(struct device *dev, struct device_node *node,
-- 
2.7.4

