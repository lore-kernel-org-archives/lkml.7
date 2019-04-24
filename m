Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF79C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3698E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao8c3o27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392139AbfDXRzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:55:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41392 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388824AbfDXRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:55:31 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so3730772pls.8;
        Wed, 24 Apr 2019 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyEwlX82c6Bq2y5y3PF+BOLHdI7/R7pprHZNYOVIDmE=;
        b=Ao8c3o27DVJS+td3Zq4h0fQmDtNlyrCXvNmeV0mWTf4BylpV2abAvznJGC83EfFAem
         Uy5Jm6DQdOgcv0AE7qZMa+HhO1cKZXRVFlKaPlm13Usjs3aWJ2BGr7iijHxjJxuSK2rN
         78hjGJDmOctLdAVSCoaVylbbnhartcgElPduqEHHhDYzRnSU3SKyvVgjnYXcAE3wbGm8
         ZdV3059adtGHrzqfgJtS9Iq1u+vyz+Ntzhax8wN6oX3T0k5mTFL6bnoza862T0t77DXa
         gNP+dyYyUCN3jqYFO5xr1BFe6Iwsxvcr3WB3Divx9HsuxbSlhHGwNL1gUaGgPTvLShet
         0znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyEwlX82c6Bq2y5y3PF+BOLHdI7/R7pprHZNYOVIDmE=;
        b=H//SfFDNfLnO5/hBOQD6Z0GDoKNSgTq0i4DVL+R0vzpmb4F5+1Po0L0R9jiyytLmVq
         hQekGWXrw2ncYsf125cDc1i7NEiflDrsquVTg1h/3e72faF778qpy5aE29DQOkUd+AaV
         B4XBjg4fI+QBxzPCZGGxlRuCwySBtECB2MZOA8FTHqyWxUCd0+Br0P8icoFUBETuqH/L
         OsJEH1L/u/zOkB60Q6pek/D/7HNqw1KFO1qQUBEecjSy6OP582PNNqDJWUdIueqtxkny
         +7qSUt7L2+ySvp7fT+LxG96OmrL/njJ2fXglYBUaFYcuFXyE4VqoLBf96g0KtCQXtUEJ
         /1SQ==
X-Gm-Message-State: APjAAAX/7fHw2FIEYzMQwGMt1DtcifJXQ6lQ/mjHoQUq4tfR0hRTCa/m
        HsWEw5/u4kVaYSK3yX8oyrU=
X-Google-Smtp-Source: APXvYqyLiy6JIJC5J6Wz8EOj23tVgypuKbBEmBTNqmI2ATltyajlQV2hb8Jz4KEPqF9lBCFJ/Y0B9g==
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr31964530plt.1.1556128529965;
        Wed, 24 Apr 2019 10:55:29 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:55:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 11/23] Documentation: ACPI: move i2c-muxes.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:52:54 +0800
Message-Id: <20190424175306.25880-12-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/acpi/i2c-muxes.txt              | 58 ------------------
 .../firmware-guide/acpi/i2c-muxes.rst         | 61 +++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |  3 +-
 3 files changed, 63 insertions(+), 59 deletions(-)
 delete mode 100644 Documentation/acpi/i2c-muxes.txt
 create mode 100644 Documentation/firmware-guide/acpi/i2c-muxes.rst

diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
deleted file mode 100644
index 9fcc4f0b885e..000000000000
--- a/Documentation/acpi/i2c-muxes.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-ACPI I2C Muxes
---------------
-
-Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
-Device () scope per mux channel.
-
-Consider this topology:
-
-+------+   +------+
-| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
-|      |   | 0x70 |--CH01--> i2c client B (0x50)
-+------+   +------+
-
-which corresponds to the following ASL:
-
-Device (SMB1)
-{
-    Name (_HID, ...)
-    Device (MUX0)
-    {
-        Name (_HID, ...)
-        Name (_CRS, ResourceTemplate () {
-            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
-                          AddressingMode7Bit, "^SMB1", 0x00,
-                          ResourceConsumer,,)
-        }
-
-        Device (CH00)
-        {
-            Name (_ADR, 0)
-
-            Device (CLIA)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH00", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-
-        Device (CH01)
-        {
-            Name (_ADR, 1)
-
-            Device (CLIB)
-            {
-                Name (_HID, ...)
-                Name (_CRS, ResourceTemplate () {
-                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
-                                  AddressingMode7Bit, "^CH01", 0x00,
-                                  ResourceConsumer,,)
-                }
-            }
-        }
-    }
-}
diff --git a/Documentation/firmware-guide/acpi/i2c-muxes.rst b/Documentation/firmware-guide/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..3a8997ccd7c4
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/i2c-muxes.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+ACPI I2C Muxes
+==============
+
+Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
+Device () scope per mux channel.
+
+Consider this topology::
+
+    +------+   +------+
+    | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+    |      |   | 0x70 |--CH01--> i2c client B (0x50)
+    +------+   +------+
+
+which corresponds to the following ASL::
+
+    Device (SMB1)
+    {
+        Name (_HID, ...)
+        Device (MUX0)
+        {
+            Name (_HID, ...)
+            Name (_CRS, ResourceTemplate () {
+                I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
+                            AddressingMode7Bit, "^SMB1", 0x00,
+                            ResourceConsumer,,)
+            }
+
+            Device (CH00)
+            {
+                Name (_ADR, 0)
+
+                Device (CLIA)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH00", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+
+            Device (CH01)
+            {
+                Name (_ADR, 1)
+
+                Device (CLIB)
+                {
+                    Name (_HID, ...)
+                    Name (_CRS, ResourceTemplate () {
+                        I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
+                                    AddressingMode7Bit, "^CH01", 0x00,
+                                    ResourceConsumer,,)
+                    }
+                }
+            }
+        }
+    }
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index d1d069b26bbc..1c89888f6ee8 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -12,4 +12,5 @@ ACPI Support
    osi
    method-customizing
    DSD-properties-rules
-   gpio-properties
\ No newline at end of file
+   gpio-properties
+   i2c-muxes
-- 
2.20.1

