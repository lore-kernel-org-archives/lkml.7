Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989D5CA9EAE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB3221929
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 03:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jqjY5/cR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfJUDCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 23:02:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43596 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfJUDCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 23:02:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so7456138pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 20:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6S9FvkBoX7c9Y0Hjke4iSmTgg6uvkf7lyNpBmBveR4=;
        b=jqjY5/cRtRPsSQipV6x7w7sJTISINntClKcx3DEiBiEgiApkspaaryjY+sf1sMPpNQ
         3JceZD5RVyRelflxZBQJV09SLFvs2Q5aZ5iD4C9Rls12W+fTcYfxsV9DKKgZol9rlVMJ
         lTN6l0Fkkry/hgn+Vvognph08JVBslE2YM2VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6S9FvkBoX7c9Y0Hjke4iSmTgg6uvkf7lyNpBmBveR4=;
        b=ZBuauJMFamTR2lO6MGyhPxjbq9eI82vl1nt2cJGpZqoNrAjCkQBucRTbQEko87cZaz
         L3IJfQsvjP82zFTqi1NVgqIIWjhNgEqYOEI7G6y1FB37u+iM0kgAEPkZ9caa2C1lbKzd
         9b1fjBEvgPir0kMApUsrJWLvuxDsv7K44Xejg3LZDPAcNSJyxj5RjdVNpELvMrR4g4oM
         IzPJftEalCTJa8/TYFGwJgZFcv2bN9mw3LF7P89ZRlKN6OOd9e/iy8qLVhZniPaFDY3o
         az7tyt2oaTsGINk2T++L7DVrLF13gvwwbpViXGwD09dnyr2YAaVFw7hu5mdFrw+UW2aK
         dDew==
X-Gm-Message-State: APjAAAVNFif6GzMhOOL9+Y855TTFZV6CGW1Htvy3VZUGtasAUeDK6MsL
        L4xTGYwe0iOTerKXHLGb3Cojcw==
X-Google-Smtp-Source: APXvYqx6vYSF3nqStjI3axUliugUutPWmW6Gm5SwyKeglqcnXF7BTh2/vo3VqrBkGBJmsaFaKdW1jw==
X-Received: by 2002:a17:90a:dd43:: with SMTP id u3mr26201536pjv.130.1571626938285;
        Sun, 20 Oct 2019 20:02:18 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id j126sm14983542pfb.186.2019.10.20.20.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 20:02:17 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Boitchat <drinkcat@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 1/2] dt-bindings: input: Add DT bindings for Whiskers switch
Date:   Mon, 21 Oct 2019 11:01:59 +0800
Message-Id: <20191021030158.32464-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding document for Hammer's TABLET_MODE switch.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 .../devicetree/bindings/input/cros-cbas.yaml  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml

diff --git a/Documentation/devicetree/bindings/input/cros-cbas.yaml b/Documentation/devicetree/bindings/input/cros-cbas.yaml
new file mode 100644
index 000000000000..6a746c4cb266
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cros-cbas.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cros-cbas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS Hammer's Base Attached Switch
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description:
+  On some ChromeOS devices with a foldable variant of Hammer base, SW_TABLET_MODE
+  event should be generated with proper consideration of current device state.
+  This device senses "base attached" signal from EC (Embedded Controller)
+  and generates SW_TABLET_MODE event when Hammer is not attached.
+  The node for this device must be under a cros-ec node like google,cros-ec-spi
+  or google,cros-ec-i2c.
+
+properties:
+  compatible:
+   const: google,cros-cbas
+
+required:
+  - compatible
-- 
2.23.0.866.gb869b98d4c-goog

