Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE09C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF912133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F7glSsC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCSJQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:16:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfCSJQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:16:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so7179619wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZZhZLbJvBzON0duWiiauO58hIPvf57wqKLHU8bYJBU=;
        b=F7glSsC/K6n61MGpENpWcmH+B8OvjeE89p5GtNH1OL7tR3XJS/6jVUU8KpIJV7dH+a
         P+H+n6dRAbvbMMCcJ6DPdujDzCbWmZlXozXdX6FRiCIfmMyk3UoxLOwiYElAfl1sBdXE
         SuEiWGUWzDSlg097UzUA0t6GoqpWi9+42zLQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZZhZLbJvBzON0duWiiauO58hIPvf57wqKLHU8bYJBU=;
        b=CHkz6Hsoji/hYlCRTOSSrZE8zrbf8BA4chI6hh0VaoLsZ4G+HvVz8XFWx59oJFbanr
         JnbqwUFpKdz3Jnia13E4Ji52zw3gJYVmlKfH7fYeezt9qARmWNTOhFJDrDwDD8pCqIR/
         sqtTHPsLlpBp5OZPR4kJBA29/OqlWpT8yHY8N6AqTIZSfQCKNAEDzXBgQntxgnuS9dhv
         /kHVDBiQ44i0TsIu/2jYv5c4V3zmpqwC2MUwvjnl+Q5PVkGKZdLC219mj1s9Oj1leiCz
         Lc6sUkvdwkwGMpUjA4+7WbqY7Z27nfFMTfUWvGXkHEvEFo7ImW1duH9y9YuA1+sRp/Jv
         uO/A==
X-Gm-Message-State: APjAAAUiW78yzBwnMdb134FGV2giZgED6qNW+HcLJE02D9BY8yenmPrX
        /c2OozZNdGL9csU/RK/qrsFfbQ==
X-Google-Smtp-Source: APXvYqx2m3lWTnDg7uRuEPncR9EJsCw4U0PcnbZloiCsX4vginrZJoNeQ8t4t9PH7OicgV5Qyszg8A==
X-Received: by 2002:a1c:a749:: with SMTP id q70mr2243764wme.151.1552986980110;
        Tue, 19 Mar 2019 02:16:20 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w10sm14875743wrn.32.2019.03.19.02.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Mar 2019 02:16:19 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v6 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
Date:   Tue, 19 Mar 2019 14:45:42 +0530
Message-Id: <1552986944-3398-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for Stingray USB PHY.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/brcm,stingray-usb-phy.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
new file mode 100644
index 0000000..4ba2989
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
@@ -0,0 +1,32 @@
+Broadcom Stingray USB PHY
+
+Required properties:
+ - compatible : should be one of the listed compatibles
+	- "brcm,sr-usb-combo-phy" is combo PHY has two PHYs, one SS and one HS.
+	- "brcm,sr-usb-hs-phy" is a single HS PHY.
+ - reg: offset and length of the PHY blocks registers
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
+		#phy-cells = <1>;
+	};
+
+	usbphy1: usb-phy@10000 {
+		compatible = "brcm,sr-usb-combo-phy";
+		reg = <0x00010000 0x100>,
+		#phy-cells = <1>;
+	};
+
+	usbphy2: usb-phy@20000 {
+		compatible = "brcm,sr-usb-hs-phy";
+		reg = <0x00020000 0x100>,
+		#phy-cells = <0>;
+	};
-- 
2.7.4

