Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986BB21872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dIM65kZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfDLHTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:19:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39354 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDLHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:19:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so4704260pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bpshunN1IL1fT0m4QBe0G901Jh/2yYGqDLMVZIYs7BM=;
        b=dIM65kZbeG+z/n4Lj0fBOoEU14s9vNHO0PTMPStFMkwJ3aoZ2Lxh4b8rVgeQIeMbOB
         uRYsSxfGeVSGh98fx0ZuOF5g443GUc7Z2Y6EhyOQdjPCaMsp8osmmo2Fo1K7hnpcqgqB
         6bUek6hjYZASlWQglgTezX0tAMp/L/XS69V2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bpshunN1IL1fT0m4QBe0G901Jh/2yYGqDLMVZIYs7BM=;
        b=TSxLQAKPWc0WwUbx61AgNsMdGGZRsMw9z2FpCbUAqUbdqFKyE9ZaLpOjf0oA8KAwJd
         3sRFoqyE4BqWwrhdpCn4ed50iD/TwS/FBQhOcqW7gpML9C1OVtESYfSNtkxK9KSKMKp6
         StKII9NWcQo8mpAj/n8BHOTft8PAeYW1LzfWcKbfQp0oqOCcMLCJ4VVKfNZ/gCN+OMsO
         RjmlTFWVRMteC2JO3UYIRdEmcPLw4KJg1iBgRW2CAMW6FD8JHC6f5D3qhVo8X9Zksyc9
         UXYb68GV+h4qepaOWq4mq3G4JvpQFIY0NB8ky3JS9cYeZXA5cyRouQOQIoCBfPKqkRkV
         r6jQ==
X-Gm-Message-State: APjAAAVLWtaXuyR0QV47Meh4jkb1Yw8eyHjmIDx3tdD9yRiy6vSOoMjx
        uckXlvGyNNNMFJJWKY3/PF3fMA==
X-Google-Smtp-Source: APXvYqy9bMjioLB6lFJi8zT0pVCM7Dp2cPiZaZCbgk/VV43NddHmnGIuJ2E+izHUEjubZ4NBgXamng==
X-Received: by 2002:a62:5707:: with SMTP id l7mr26494636pfb.205.1555053589759;
        Fri, 12 Apr 2019 00:19:49 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id k124sm67466862pgc.65.2019.04.12.00.19.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 00:19:49 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 5/7] dt-bindings: Add binding for cros-ec-rpmsg.
Date:   Fri, 12 Apr 2019 15:18:49 +0800
Message-Id: <20190412071851.60332-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190412071851.60332-1-pihsun@chromium.org>
References: <20190412071851.60332-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT binding documentation for ChromeOS EC driver over rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes from v7:
 - No change.

Changes from v6:
 - No change.

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
2.21.0.392.gf8f6787159e-goog

