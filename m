Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39898206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sn/e46Le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCKGfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:35:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38270 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfCKGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:35:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id n125so2988245pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcLTNt90K3HQNfqcf3oOtt8t0kIprUBx1yUX1QOFD34=;
        b=Sn/e46Le0/dFt8VqLmhi7/ISj7IE0gyXX+x+DiKDNs2QHrOyOe47/Vub4g4xzeiAe/
         R/30cRatV1IbSo+d2jmOMwdl00XvRelOHEcr6KCHCgt+HqucGI/FOF/lkHlWGZU1E5ln
         ikcywA5j6PoRAuQR2yzoKruSXvcXJ0BSQZrrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcLTNt90K3HQNfqcf3oOtt8t0kIprUBx1yUX1QOFD34=;
        b=fQKVFL7QINdVf/BXbHpxHQCseGAaivXdqxFxwoC8iIKbqqKeed3RAdKywzjA4zgeUY
         RUWsjh0JbtKIRQr0vCBZuVoIP5rlZB9AroBcPf0F7kFW5woHyj0xBfzFOhza1CV23NSe
         5Rw/Dtf5Kk6Ys5Loj6TOXFa98ZPjeahj8FPSe/AhBfCt/VPnC20ffOiwsYUMJ+w/I8V8
         EH7ezHjeOae78cfto2HCvxpbVx5spc18ulOceTiYWjWzd7g5d2XAiYUX3ZEG3L4zy3Do
         x2aPbrOfhJdIVv0Mr+NVXqV2F/iNWNEjFusfWrIf3yu0BWZk3yZ6HS3S9UIcd1pdgy3+
         EQUQ==
X-Gm-Message-State: APjAAAXczLUIkjDcuTytGyhFZ24Rt12YFM4aMJCFpkHL2oNzfGgPUNxw
        8x0X0fKPxtR4coAB8EPrjKvr1A==
X-Google-Smtp-Source: APXvYqyLf5obYszTfft3HW2ngp7iduXfpw6KeK2CNFeBZ3s5L3a0C8mcF4NSIjLQue8Ygfm6Oa0cpQ==
X-Received: by 2002:a63:e813:: with SMTP id s19mr28193461pgh.12.1552286138592;
        Sun, 10 Mar 2019 23:35:38 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id p5sm6573040pfn.154.2019.03.10.23.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 23:35:38 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 5/7] dt-bindings: Add binding for cros-ec-rpmsg.
Date:   Mon, 11 Mar 2019 14:34:56 +0800
Message-Id: <20190311063458.137473-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
In-Reply-To: <20190311063458.137473-1-pihsun@chromium.org>
References: <20190311063458.137473-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT binding documentation for ChromeOS EC driver over rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v5:
 - New patch.
---
 Documentation/devicetree/bindings/mfd/cros-ec.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
index 6245c9b1a68b..4860eabd0f72 100644
--- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
+++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
@@ -3,7 +3,7 @@ ChromeOS Embedded Controller
 Google's ChromeOS EC is a Cortex-M device which talks to the AP and
 implements various function such as keyboard and battery charging.
 
-The EC can be connect through various means (I2C, SPI, LPC) and the
+The EC can be connect through various means (I2C, SPI, LPC, RPMSG) and the
 compatible string used depends on the interface. Each connection method has
 its own driver which connects to the top level interface-agnostic EC driver.
 Other Linux driver (such as cros-ec-keyb for the matrix keyboard) connect to
@@ -17,6 +17,9 @@ Required properties (SPI):
 - compatible: "google,cros-ec-spi"
 - reg: SPI chip select
 
+Required properties (RPMSG):
+- compatible: "google,cros-ec-rpmsg"
+
 Optional properties (SPI):
 - google,cros-ec-spi-pre-delay: Some implementations of the EC need a little
   time to wake up from sleep before they can receive SPI transfers at a high
-- 
2.21.0.360.g471c308f928-goog

