Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B38AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133F120840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OKvc3cDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfCFVZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:25:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:25:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id w6so15060121wrs.4;
        Wed, 06 Mar 2019 13:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BedjtFQU/fr+TTy7+SIsqMM58N+2NlaN5QGB5Viy9yI=;
        b=OKvc3cDTykin5hm8pPx/HbHzDzm7RksnYTTWFLnVXIPDs6IKOB5VJw6bwadCffbeEd
         nhflNkSIXIBArPmm/Aougyu/iI5GhSrS1NC1HAAjaa9R7tY8Da4uFMZMBxAlnabb6m0m
         Bzqgr63xSkCEn+tMJubQvl8xz1V9MdSD1Cu+WZv6oJeC1r6JoJ9pc/6tNjoRKkEe6kIR
         xDCIAvT0canD3NwOo6a4j5v7ubG49HCrFUNRFQvUJHuWZLikn7LtfCqidt2gYySqEmOe
         YQEKWwFGuEfS2olEHGWGHTgot8BCjydtlHpCsxMZzYS7c8ao/g8u5j7qUl4xl9ofPSxI
         2Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BedjtFQU/fr+TTy7+SIsqMM58N+2NlaN5QGB5Viy9yI=;
        b=aSusjB1g+b2s7dJ0xil9rWg7/8WujJPf7RtQxYpOIoWW2HiC9EPzp7HSPzugta6cRO
         fJAsNLbWmRGA4UrNHv5KlgCSq2kOfZkQxrAuEmr6MHmjj9HEZYj2ijsiX59qtZ/evSiO
         Te24+iLGgp5UI98aRykw9wzUa/uAFJhYtjT0O++DMRM9z3NgtQSC5co1dN9XrQwBZIco
         aH9nn+qQVxSY5MWZ3IFBF36pLjLKZ4yVm/HWKD9sykvmZ8FvIOdfDv69cpK5WiqaChmP
         12QW5BEXAWcUhy1T4Fw+2aG5+LG1bTCW77cdACCGOmAn66k9kq5Z1Zp3xJleq4llvMkE
         qKUA==
X-Gm-Message-State: APjAAAVNhpkiszIqkobvVxbEX+hyX2uz7YxHNQJsqwxm0y15vxCAsFeI
        0k/H2OniZzq8GaTIUNce37Y=
X-Google-Smtp-Source: APXvYqxr2W1IeK82jjf8wG/cS1b8SoRq60PuSlFuteJ9r7aQQ3GPwPacjKZ9ooiWbq+OCWKpO0a5LA==
X-Received: by 2002:adf:8251:: with SMTP id 75mr4705634wrb.112.1551907498910;
        Wed, 06 Mar 2019 13:24:58 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD7464E00D1A79B18B8800EE5.dip0.t-ipconnect.de. [2003:dc:d746:4e00:d1a7:9b18:b880:ee5])
        by smtp.googlemail.com with ESMTPSA id g10sm2940174wrq.61.2019.03.06.13.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 13:24:58 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, amelie.delaunay@st.com,
        felipe.balbi@linux.intel.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] dt-bindings: usb: dwc2: document the vbus-supply property
Date:   Wed,  6 Mar 2019 22:24:31 +0100
Message-Id: <20190306212431.5779-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various boards have an external VBUS supply regulator. This regulator
depends on the current mode of the controller which is defined as:
- dr_mode set to either "host" or "peripheral" (fixed value)
- dr_mode set to "otg", based on the OTG status the dwc2 controller
  internally switches between "host" and "peripheral" mode (selection
  happens at runtime)

Based on the current mode the regulator has to be enabled or disabled:
- host: provide power to the connected USB device, thus the regulator
  has to be enabled
- peripheral: the host device to which the controller is connected
  provides power, thus the regulator has to be disabled

Add the dt-bindings documentation for this property so .dts authors know
that this property exists and how it behaves.

Fixes: 531ef5ebea9639 ("usb: dwc2: add support for host mode external vbus supply")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 6dc3c4a34483..1e8a775a0e72 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -31,6 +31,10 @@ Refer to clk/clock-bindings.txt for generic clock consumer properties
 Optional properties:
 - phys: phy provider specifier
 - phy-names: shall be "usb2-phy"
+- vbus-supply: reference to the VBUS regulator. Depending on the current mode
+  this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
+  regulator is updated if the controller is configured in "otg" mode and the
+  status changes between "host" and "peripheral".
 Refer to phy/phy-bindings.txt for generic phy consumer properties
 - dr_mode: shall be one of "host", "peripheral" and "otg"
   Refer to usb/generic.txt
-- 
2.21.0

