Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF9218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1+ACGyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfC2ANI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39927 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfC2ANF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so298082pga.6;
        Thu, 28 Mar 2019 17:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tcR00c+x/qPss4WigYinQdjgrdl3IrFp15zkYRBwPA=;
        b=H1+ACGyYo184/HKRjmXqGP9jnrVfo5mlmim19kyN3IZHlUpLJWsH9g1u9rtEfyXSZg
         zrwCpZAa0Lf8Crakm3TqJQUnYotWVScwivohlkOxYQsT0nMWb0n9xV8WdAU0hNvFNHwb
         IhpYvjCNM9FyVD79dnLeipRLXmT/xR0zROEqmg5G1sJVdx/5TkiauqDbfWRu5vupBvs8
         V4iAq+RM+VeUpnSa3yDfpNouV6bAbCHV8Pi0ve66ROto6ZGuTJxmCfKT38AalXCHwdEf
         YxU3td+CT3ePrnXFY05FORupaCOcOGOS2oiZK1szGrCCidka7Nx+NSiCOqmIN9iLDfO9
         nXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tcR00c+x/qPss4WigYinQdjgrdl3IrFp15zkYRBwPA=;
        b=V1G1ydKKS9lKiLw4kRV7MXjbMnDneGYiyWyBUQFinBS2OsQoMiEpPq/JlgEoPWqYuk
         L1SqJDZCxBlo23ad9j1ZazWObLi0O2dIsPTonN0RnUiIQ2CPI5teIRMbgekVtBlQi6gM
         f5hqdxresUIoT1xUXIby8WoWW9SII7VJGgvpTgaiYT8dwAU9nOfCMQBV8yUtNsZTI0vC
         5zyFLIFpXb1eft43kLyJZDDfEzgNnQAiHYEMC/Suj245Bm1qI5crtel0u50vtRFj5CnR
         9UmOasv3pEraIdJwqH0vJfvxV0ZH5gt580NyMcnia4Ucd/TE4/Tf4aZYjmtT8To5zpPU
         7qNA==
X-Gm-Message-State: APjAAAWNIPwr+pGiY3Cdb4GOUBd/GlhpJPkWhGA/lLZjleI9tT8e8uB1
        Qvq3173jg4maG/mMt7CM/Jc=
X-Google-Smtp-Source: APXvYqweNsUJ6OUYF4al+jJ+jt2qu9Kc6rF0efNacuzVi8J4aFYIaW1veUzNlbG6Z0iBV2tVKe0XBw==
X-Received: by 2002:a63:c112:: with SMTP id w18mr14971594pgf.200.1553818384648;
        Thu, 28 Mar 2019 17:13:04 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 12/24] acpi doc: convert acpi/i2c-muxes.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:23 +0800
Message-Id: <20190329001135.15847-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/acpi/i2c-muxes.rst | 61 ++++++++++++++++++++++++++++++++
 Documentation/acpi/i2c-muxes.txt | 58 ------------------------------
 Documentation/acpi/index.rst     |  1 +
 3 files changed, 62 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/acpi/i2c-muxes.rst
 delete mode 100644 Documentation/acpi/i2c-muxes.txt

diff --git a/Documentation/acpi/i2c-muxes.rst b/Documentation/acpi/i2c-muxes.rst
new file mode 100644
index 000000000000..3a8997ccd7c4
--- /dev/null
+++ b/Documentation/acpi/i2c-muxes.rst
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
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index 72fe855f567e..78f72a525a3f 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -13,6 +13,7 @@ Linux ACPI (Advanced Configuration and Power Interface)
    osi
    DSD-properties-rules
    gpio-properties
+   i2c-muxes
    scan_handlers
    method-customizing
    initrd_table_override
-- 
2.20.1

