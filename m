Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A36C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2245C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eqjkwSjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfCLQHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:07:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45600 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfCLQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:07:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id 125so2146503pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rPNgzgbvhLIiu347ABIkW24xC4dTBndQokPHgfYmhng=;
        b=eqjkwSjT15RVyt4/Dy2nXg9Ffr/GDFwNpA2uPXC4MnwBJJPyl7q1UGIXPMEXoVd1Cu
         4/V+cxd5AQtcsPbtgwRpt7sANvsYqG3rVOTfAHRCCuOPRG+9AEuJoI1PJ5qG3hJBjW61
         7MYu7FngyXAFK8IknQekFKyYSOUgj/L+qOaGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rPNgzgbvhLIiu347ABIkW24xC4dTBndQokPHgfYmhng=;
        b=FutRoIujK9rJw9QrQjCMCNKpkYnBjsr/3rKQHPfdV9QxzUTQ7iN86ZSEqVAjLFEqoJ
         CePH/QpEQAS/KnspDjWMmPPn1REdiuLi4mWEM4iOLBfUAgK2iy79N9LaYyOhyOsRmthe
         TpGaHiZa8UwQs9mOzfVFLTcZcEsTC+e73fhF9bYLmyTLu+0FKlJAvJM9dl1H4gI/1RTY
         jbDok87/CtnEZuK03oN93WMJrxJ9K7yCPQDOcuJ0c4GLFB3NonFaSs5qgm1UTMgyNV74
         76fUAdEvHb8hUPzQzCXwBxHbx11pFvRz+hMcHNOfXd6hYfWx+mSIgVz5CS6iO31aJ1BC
         QZYQ==
X-Gm-Message-State: APjAAAUdkMQCMLoVHkNmrd3rp4CSVg99Hx/IwRAZ1aAGkz1yJ/vhx5cZ
        KmbcVHHq01ZI7XW2Vo9Jl9oxwg==
X-Google-Smtp-Source: APXvYqyP+zi5KoQZoHkrSkF5jj9w8gmtZN0J18n9NEeAs/zWpCA2ARWCX16FJr7yosNIddpPxlXzWw==
X-Received: by 2002:a63:6e84:: with SMTP id j126mr22049800pgc.253.1552406840544;
        Tue, 12 Mar 2019 09:07:20 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z12sm12875854pgv.0.2019.03.12.09.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 09:07:19 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
Date:   Tue, 12 Mar 2019 21:36:19 +0530
Message-Id: <1552406781-5180-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552406781-5180-1-git-send-email-srinath.mannam@broadcom.com>
References: <1552406781-5180-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for Stingray USB PHY.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../bindings/phy/brcm,stingray-usb-phy.txt         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
new file mode 100644
index 0000000..51c3d73
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
@@ -0,0 +1,40 @@
+Broadcom Stingray USB PHY
+
+Required properties:
+ - compatible : should be one of the listed compatibles
+	- "brcm,sr-usb-combo-phy" is combo PHY has two PHYs, one SS and one HS.
+	- "brcm,sr-usb-hs-phy" is a single HS PHY.
+ - reg: offset and length of the PHY blocks registers
+ - address-cells: should be 1
+ - size-cells: should be 0
+ - #phy-cells:
+   - Must be 1 for brcm,sr-usb-combo-phy as it expects one argument to indicate
+     the PHY number of two PHYs. 0 for HS PHY and 1 for SS PHY.
+   - Must be 0 for brcm,sr-usb-hs-phy.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usbphy0: usb-phy@0 {
+		compatible = "brcm,sr-usb-combo-phy";
+		reg = <0x00000000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <1>;
+	};
+
+	usbphy1: usb-phy@10000 {
+		compatible = "brcm,sr-usb-combo-phy";
+		reg = <0x00010000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <1>;
+	};
+
+	usbphy2: usb-phy@20000 {
+		compatible = "brcm,sr-usb-hs-phy";
+		reg = <0x00020000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <0>;
+	};
-- 
2.7.4

