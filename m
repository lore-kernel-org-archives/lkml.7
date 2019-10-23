Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5219ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2533B2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 02:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mOy5hTZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbfJWCn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:43:56 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:40086 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbfJWCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 22:43:55 -0400
Received: by mail-pf1-f174.google.com with SMTP id x127so11915305pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mofPZU0gDfCeMdQs09aoNyZbpVsgKBRv49oSTcbrnzI=;
        b=mOy5hTZQlIbUw/dLIeqJ54nqXPthp1Z+w+N0xfknDKFXtqQwMk7Wnfn5/rNspav5uV
         MDdW15WOQGDrNUHwqTPtFPR2ayZOR8PMkZQPsCoIGFkMa15/YWeG535VD4rhqVXQc9QF
         hbxhmYfc7eY5CvzZRVxMHsmJhf0O38G/wX6CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mofPZU0gDfCeMdQs09aoNyZbpVsgKBRv49oSTcbrnzI=;
        b=aqsaZ5+IrKPQZ1UPcciRixMcjpn6poaDO1G6l2fTdiG4IiyoXAoEiPVoxvZXwc+mwi
         64i77wR7LHus/Lvnw0Ii8ma3gGYeC8NIoBpQ2REbbbznofwaDPydn2HWk3wt/ZqDxcpG
         6+wywBqCXTqD5Tc1R0+vXZEAoOZvPSyHujaE0EpVL2ejxUVcqNefTAfhS3Ut7NKnTDmk
         okgPVZ/xluUfqjvQ9FtUUF+2I/DPxdwEPtrXBpdPSC5VqH9bp/kwSDiWB4xfNMpxnUyX
         g7zeOvEErA8fPawBEfBqTHg1nEbPKP6T0xdTuJfPpwZmI5AHkXZrTS9/Y6nw/OxsPASS
         rKEw==
X-Gm-Message-State: APjAAAW5PkrzxXd6RZlsrP7AYYBHvS8EfYEwmsTIwfHJ7Hog/88Wmr5k
        KqLNZNBks8at8P5HcZXUyliVzQ==
X-Google-Smtp-Source: APXvYqxv+U6sKv24k78c6mmhFtzdjMFTEVjKujp5UDRJgvxJ5YW1F0J5Ur7LHviLgSGCAZnRoVmNKQ==
X-Received: by 2002:a63:fe56:: with SMTP id x22mr7379113pgj.282.1571798635041;
        Tue, 22 Oct 2019 19:43:55 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id o64sm45970901pjb.24.2019.10.22.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 19:43:54 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: input: Add DT bindings for Whiskers switch
Date:   Wed, 23 Oct 2019 10:43:48 +0800
Message-Id: <20191023024348.225969-1-ikjn@chromium.org>
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
 .../devicetree/bindings/input/cros-cbas.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml

diff --git a/Documentation/devicetree/bindings/input/cros-cbas.yaml b/Documentation/devicetree/bindings/input/cros-cbas.yaml
new file mode 100644
index 000000000000..3bc989c6a295
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cros-cbas.yaml
@@ -0,0 +1,22 @@
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
+  This device is used to signal when a detachable base is attached to a
+  Chrome OS tablet. The node for this device must be under a cros-ec node
+  like google,cros-ec-spi or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const: google,cros-cbas
+
+required:
+  - compatible
-- 
2.23.0.866.gb869b98d4c-goog

