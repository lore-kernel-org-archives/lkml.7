Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DA0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BC620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UxfoaKCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCRN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:27:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43730 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfCRN1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:27:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so17030659wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2taATSeLwYLlK3AoeIDGHb1SmDZDEtC2Zy8s96NWr0=;
        b=UxfoaKCodDKWM/fMLqfRLPZbMQ8mYOBpQVeNkESThMkjRtFNwenDw8/crEYok1ZT+c
         I3DbLBUoriYpbZfFJ4z1QH93cn44hzdy+u9n6t4V600opfh8oq9Pm4BMZp6EJCCBKazq
         FVObvP10p/bKKuDfPm2QwKo2+tHIfw3mcAeo3Jp6CPRm0blorH8WWkNUtafevy4o5bp5
         v0vfqY04BiL6K5xtVP50yqkVl1SJG3ZCo9z9FcYECoYKCJ3FF7Qjjw8tAJ4+ivcf/iu1
         1fO1u6VIhA3qBdiTZtrG9KA6ZVkzUB9iezOR2jv6xoU6wZ8pSTGakI+sjPpnDV4WEv2o
         mfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2taATSeLwYLlK3AoeIDGHb1SmDZDEtC2Zy8s96NWr0=;
        b=I7DXPCjvK6Isi3bljiZRaiRnrD/Drn6hfpugJ55bsHLfEgCuSBxGnxufA2EAZe47PK
         WRJ5isfQckYu0EDIO1ekkHTf3ZbrWzV5IGC4GCxKdd5oUeDjovjXgk4N/M5p97q0EsJc
         WMVbY2qs/57T3nx02z7E3w/HAfM6MjXA7dYhZ41JDcq8+GuJp7urWytomN2WBER7MaDM
         t70VfdZww0mGCB2WHF9wZ2gYMqxY3kCSfyRuH6yjdCgla60i2uWJqXXtih7bjj6/fY98
         Vf2EPIEUPIYIyoFExPI0gp67rgiTLsU0raApcV6iAa8rAYRuUGgH86KU4JQNHmHLmFRM
         epAg==
X-Gm-Message-State: APjAAAXtz3UYKQYFIoonIjLB3bLLBQ2Q4qL020cPrtBclaNxOjxqFfcm
        OKogLDug2V/ZG7zvFib7LWs0EQ==
X-Google-Smtp-Source: APXvYqyWketn5R+yzXKwlclGE7MSY9EAfsFayppYhUaNTbevks4EOVeGHkL8kSjZCZQWFTCZsl504w==
X-Received: by 2002:adf:9c85:: with SMTP id d5mr12098593wre.68.1552915618838;
        Mon, 18 Mar 2019 06:26:58 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j128sm10421601wmb.43.2019.03.18.06.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 06:26:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
Date:   Mon, 18 Mar 2019 14:26:48 +0100
Message-Id: <20190318132655.30040-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318132655.30040-1-narmstrong@baylibre.com>
References: <20190318132655.30040-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Amlogic G12A Family USB2 OTG PHY Bindings

The PHY can work in host or peripheral modes depending on it's position.
Configuration of the mode is part of the USBCTRL registers which are
outside of the PHY registers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/meson-g12a-usb2-phy.txt      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
new file mode 100644
index 000000000000..a6ebc3dea159
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
@@ -0,0 +1,22 @@
+* Amlogic G12A USB2 PHY binding
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb2-phy"
+- reg:		The base address and length of the registers
+- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)
+- clocks:	a phandle to the clock of this PHY
+- clock-names:	must be "xtal"
+- resets:	a phandle to the reset line of this PHY
+- reset-names:	must be "phy"
+- phy-supply:	see phy-bindings.txt in this directory
+
+Example:
+	usb2_phy0: phy@36000 {
+		compatible = "amlogic,g12a-usb2-phy";
+		reg = <0x0 0x36000 0x0 0x2000>;
+		clocks = <&xtal>;
+		clock-names = "xtal";
+		resets = <&reset RESET_USB_PHY21>;
+		reset-names = "phy";
+		#phy-cells = <0>;
+	};
-- 
2.20.1

