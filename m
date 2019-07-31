Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120A20651
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZnHxKlYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfGaKUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 06:20:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41695 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfGaKUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 06:20:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so31622230pff.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1hFW261EdAqqhHx0R9omLG8cea6wI1AtJQwshss1NJ0=;
        b=ZnHxKlYHCG2JqkdO1qYbMKw0Igq/zrkMr/66ZX3a3OBAcS2HoMJwTxyLFb/zdDXjtZ
         EpHOIh+NosfgOyztVan1SBci8of22qogiV29Dtq0p3o6g4J8xml+ttpPkJ8gmN6Y5h2m
         l9iFy3hgGtMzALboGVSKvQju1e+BKKjiOCNyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1hFW261EdAqqhHx0R9omLG8cea6wI1AtJQwshss1NJ0=;
        b=FMTrBg5j9777I7WeXLP4pnDhqrAjpDgvzBgH9EXgfdUa0Nrajs1p1ASJc/ttrYsh5N
         VzHJdTRC7AAiPT3IrR+hmMkCGZd9tCQaIVaZSVbECAY0eR3St5uSo00Pwgytrf+tqod8
         6iJ13fm3EVwgQ+IzwyWbiMvKnErTa1Up48zjALeG2NLca811VvFUEVWeMX56rvlYXof8
         i5LIUDXxqEq7BfF62wwxff6B6cA/Ik6M4W5OWhtfNL3qvZkW072+Bc2KihVurlaxI7vU
         jsvIxmIohxPkwbFegJKG7Kd0fhA/XWosuhhfkrK2MJvU+DtMkohfVMH4IkFTZ9ptwBiY
         KMXw==
X-Gm-Message-State: APjAAAV2VrGz32v80fO5d3mbr26PvhhhNFj0shcNNNw0LQbQQMPM9Bet
        YQjhRPrsa1N+XH4O1VZza5oI0Q==
X-Google-Smtp-Source: APXvYqy7893HyxGzB7cZaK8oOykAUo7aQy7ubsb08yXfflUP8pw31YdKnzcz2kzBkHHUe5ASPdTHAQ==
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr2216195pjq.36.1564568419949;
        Wed, 31 Jul 2019 03:20:19 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 3sm71161776pfg.186.2019.07.31.03.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:20:19 -0700 (PDT)
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
Subject: [PATCH v2 2/5] dt-bindings: phy: Modify Stingray USB PHY #phy-cells
Date:   Wed, 31 Jul 2019 15:49:52 +0530
Message-Id: <1564568395-9980-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase #phy-cells from 1 to 2 to have bitmask of PHY enabled ports.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../devicetree/bindings/phy/brcm,stingray-usb-phy.txt      | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
index 4ba2989..aeb0568 100644
--- a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
@@ -6,9 +6,11 @@ Required properties:
 	- "brcm,sr-usb-hs-phy" is a single HS PHY.
  - reg: offset and length of the PHY blocks registers
  - #phy-cells:
-   - Must be 1 for brcm,sr-usb-combo-phy as it expects one argument to indicate
-     the PHY number of two PHYs. 0 for HS PHY and 1 for SS PHY.
-   - Must be 0 for brcm,sr-usb-hs-phy.
+   - Must be 2 for brcm,sr-usb-combo-phy.
+     - Cell 1 - PHY Number, 0 for HS PHY and 1 for SS PHY.
+     - Cell 2 - Bitmask of enabled ports connected to USB Host controller.
+   - Must be 1 for brcm,sr-usb-hs-phy to indicate Bit mask of ports connected
+     to USB Host controller.
 
 Refer to phy/phy-bindings.txt for the generic PHY binding properties
 
@@ -16,17 +18,17 @@ Example:
 	usbphy0: usb-phy@0 {
 		compatible = "brcm,sr-usb-combo-phy";
 		reg = <0x00000000 0x100>;
-		#phy-cells = <1>;
+		#phy-cells = <2>;
 	};
 
 	usbphy1: usb-phy@10000 {
 		compatible = "brcm,sr-usb-combo-phy";
 		reg = <0x00010000 0x100>,
-		#phy-cells = <1>;
+		#phy-cells = <2>;
 	};
 
 	usbphy2: usb-phy@20000 {
 		compatible = "brcm,sr-usb-hs-phy";
 		reg = <0x00020000 0x100>,
-		#phy-cells = <0>;
+		#phy-cells = <1>;
 	};
-- 
2.7.4

