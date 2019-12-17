Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08315C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8692053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f6anDsyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfLQAyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:54:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37835 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbfLQAy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:54:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so4694055pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 16:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCp9LEFv5R58q0Ve3yI3/VooHbGgWJ66I2unNqlCWqg=;
        b=f6anDsyQClM9W76kd0DoShSZDZ5v7Ccfnl4VNtTTEDU2dbEtULeRxSwdWbF1CEAjDm
         mCAyyfN+y59J9k30MSGelYp75e4eKKD61GyiEoe6rzwIz3wSZaYdktVvFqtHQhyI/cvz
         f/xk4i04iXBo2UwHlR+yE5O5KBhb3htQMtqqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCp9LEFv5R58q0Ve3yI3/VooHbGgWJ66I2unNqlCWqg=;
        b=GZW+44lTedzQQQaMDGhQ5DIc0PritOkTqPRgaEOWjjvlwfZe76LrTtazU6dw5iPrHT
         J80oUuCLQa56sAtfnOiR4tqM5fMRREKfeJkD9jkE9v6gJtPwvPlfQmIWBOk1+2mX6OQo
         +C0+qq1tX21+a8S1pP57M4h5G80/f7lS2InzKUmGaJJzOuKADH+ADpc9Ol9TaDRzvwDn
         NCwsXvvD/DaC4b+APoJtGDMPnvZ7bZmeNZAaeHPvvimv54tztQBPrZIq083bpbcGEwGp
         serHbFbg5FKssDs724JA8lEdcG54nxUhdoTd7PxNsYwFxivjsntkNgvqaVkiFt45tAUk
         3hyA==
X-Gm-Message-State: APjAAAVOUtHbdWTxjJyW+7VaHKkrHpvAe5ehzc/L0Lya9MxVYGnDeIq1
        iFWKthqfQfR1ir8bHUpguBglPw==
X-Google-Smtp-Source: APXvYqzENmMAc5uU4zTFwjEiQPPxPyfnFn0xDf7hP8923INwhTSh3s7n8eBLXiOBMpI/4Cet9D3y8A==
X-Received: by 2002:aa7:91c8:: with SMTP id z8mr19804607pfa.223.1576544065385;
        Mon, 16 Dec 2019 16:54:25 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k3sm24021873pgc.3.2019.12.16.16.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 16:54:25 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] dt-bindings: tpm: Convert cr50 binding to YAML
Date:   Mon, 16 Dec 2019 16:54:24 -0800
Message-Id: <20191217005424.226858-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to validate the dt binding to the implementation. Add the
interrupt property too, because that's required but nobody noticed when
the non-YAML binding was introduced.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/security/tpm/google,cr50.txt     | 19 -------
 .../bindings/security/tpm/google,cr50.yaml    | 52 +++++++++++++++++++
 2 files changed, 52 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
deleted file mode 100644
index cd69c2efdd37..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
-
-H1 Secure Microcontroller running Cr50 firmware provides several
-functions, including TPM-like functionality. It communicates over
-SPI using the FIFO protocol described in the PTP Spec, section 6.
-
-Required properties:
-- compatible: Should be "google,cr50".
-- spi-max-frequency: Maximum SPI frequency.
-
-Example:
-
-&spi0 {
-	tpm@0 {
-		compatible = "google,cr50";
-		reg = <0>;
-		spi-max-frequency = <800000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
new file mode 100644
index 000000000000..8bfff0e757af
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: H1 Secure Microcontroller with Cr50 Firmware on SPI Bus
+
+description:
+  H1 Secure Microcontroller running Cr50 firmware provides several functions,
+  including TPM-like functionality. It communicates over SPI using the FIFO
+  protocol described in the PTP Spec, section 6.
+
+maintainers:
+  - Andrey Pronin <apronin@chromium.org>
+
+properties:
+  compatible:
+    const: google,cr50
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <0x1>;
+      #size-cells = <0x0>;
+      tpm@0 {
+          compatible = "google,cr50";
+          reg = <0>;
+          spi-max-frequency = <800000>;
+          interrupts = <50 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+
+...
-- 
Sent by a computer, using git, on the internet

