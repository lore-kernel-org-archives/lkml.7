Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF41DC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BF4208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyuRwHDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfDYPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:33:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41677 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfDYPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:33:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so86906pfd.8;
        Thu, 25 Apr 2019 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nn95F9/oxRsjhaP/vqYEb2kwBw3lresYDu+ZATb/62A=;
        b=FyuRwHDMn4Y6ICmBm2misiCxajLlG5Vr0Yezaq9+y5bYEGDd7l/2Rp6g7xYHbqMj/7
         mL6YeTYoVzhooRjb9K68Uv6w2RiPan0DnJjfPQVyFUbPiRkS5/bvNIvSdiA6SSIKl3Ju
         zx/RHyAyTBhMhlCKGPrA7A+hJr+7jhT7psUvUUrYrWhlfpG7SdSN/lZfi1ky21zV9sxC
         hJN5m3hHvUGFzXScfQBUuvq2L+vgctc06Xme//ShW9T+meRjabEPStghP59dY9RfwymQ
         rrnMeMotu61odNSFlHYW7iO6lMqIMmEI1eJZjhtbFOUOK0CZtKLDC0nRXVZ310IdcsZn
         BoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nn95F9/oxRsjhaP/vqYEb2kwBw3lresYDu+ZATb/62A=;
        b=DN5nzPTFBP1B6uQEIAPiSzZVzgZAIXHGO5enxoxKJCgDS05rvrf8Sm6zhuXM53SgQK
         WXjrjQTJhODTMKTKTomZVea0TlSFy0HSV2B64a/bd5a/KAuYOHsq2zgl2G81VFfvS7+J
         3HMj5fk3Zc4Cb/q9cKWULorBwU4XTw7tIQbtchUnyt8eNOlDE7P76ls3QXLKTl0NTwyT
         OHgNUPxTL+UjIrcijJ6KRcPpuaKrz2YDyX057cyMrYwIN8MvhTnCv2y1HWdlCH8R6JLA
         x+H3cnuV6JDTx7K9a5swmxhOim9RSbf8rJSc1QQZXb6YJ0UfFQL4w3oA/5zi8SKevYYX
         V8tQ==
X-Gm-Message-State: APjAAAVMkw0lBYj36mMzLgvidUrojtNLure0nGQeanxVfzDw9OHwmkRd
        PPaMnRT6ajKuTBo0amhlejk=
X-Google-Smtp-Source: APXvYqwEcZgJ3IY5vbwqUeUv1Egnj0izihPenTs/6sU2Gmg7Vlg25fu/rN8lP4FVhBgqsQTS+nCXzA==
X-Received: by 2002:a62:aa01:: with SMTP id e1mr41241390pff.43.1556206412812;
        Thu, 25 Apr 2019 08:33:32 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:33:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 20/24] Documentation: ACPI: move apei/einj.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:13 +0800
Message-Id: <20190425153117.16057-21-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
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
 .../acpi/apei/einj.rst}                       | 94 ++++++++++---------
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 2 files changed, 52 insertions(+), 43 deletions(-)
 rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)

diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/firmware-guide/acpi/apei/einj.rst
similarity index 67%
rename from Documentation/acpi/apei/einj.txt
rename to Documentation/firmware-guide/acpi/apei/einj.rst
index e550c8b98139..e588bccf5158 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -1,13 +1,16 @@
-			APEI Error INJection
-			~~~~~~~~~~~~~~~~~~~~
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+APEI Error INJection
+====================
 
 EINJ provides a hardware error injection mechanism. It is very useful
 for debugging and testing APEI and RAS features in general.
 
 You need to check whether your BIOS supports EINJ first. For that, look
-for early boot messages similar to this one:
+for early boot messages similar to this one::
 
-ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
+  ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
 
 which shows that the BIOS is exposing an EINJ table - it is the
 mechanism through which the injection is done.
@@ -23,11 +26,11 @@ order to see the APEI,EINJ,... functionality supported and exposed by
 the BIOS menu.
 
 To use EINJ, make sure the following are options enabled in your kernel
-configuration:
+configuration::
 
-CONFIG_DEBUG_FS
-CONFIG_ACPI_APEI
-CONFIG_ACPI_APEI_EINJ
+  CONFIG_DEBUG_FS
+  CONFIG_ACPI_APEI
+  CONFIG_ACPI_APEI_EINJ
 
 The EINJ user interface is in <debugfs mount point>/apei/einj.
 
@@ -37,20 +40,22 @@ The following files belong to it:
 
   This file shows which error types are supported:
 
+  ================  ===================================
   Error Type Value	Error Description
-  ================	=================
-  0x00000001		Processor Correctable
-  0x00000002		Processor Uncorrectable non-fatal
-  0x00000004		Processor Uncorrectable fatal
-  0x00000008		Memory Correctable
-  0x00000010		Memory Uncorrectable non-fatal
-  0x00000020		Memory Uncorrectable fatal
-  0x00000040		PCI Express Correctable
-  0x00000080		PCI Express Uncorrectable fatal
-  0x00000100		PCI Express Uncorrectable non-fatal
-  0x00000200		Platform Correctable
-  0x00000400		Platform Uncorrectable non-fatal
-  0x00000800		Platform Uncorrectable fatal
+  ================  ===================================
+  0x00000001        Processor Correctable
+  0x00000002        Processor Uncorrectable non-fatal
+  0x00000004        Processor Uncorrectable fatal
+  0x00000008        Memory Correctable
+  0x00000010        Memory Uncorrectable non-fatal
+  0x00000020        Memory Uncorrectable fatal
+  0x00000040        PCI Express Correctable
+  0x00000080        PCI Express Uncorrectable fatal
+  0x00000100        PCI Express Uncorrectable non-fatal
+  0x00000200        Platform Correctable
+  0x00000400        Platform Uncorrectable non-fatal
+  0x00000800        Platform Uncorrectable fatal
+  ================  ===================================
 
   The format of the file contents are as above, except present are only
   the available error types.
@@ -73,9 +78,12 @@ The following files belong to it:
   injection. Value is a bitmask as specified in ACPI5.0 spec for the
   SET_ERROR_TYPE_WITH_ADDRESS data structure:
 
-	Bit 0 - Processor APIC field valid (see param3 below).
-	Bit 1 - Memory address and mask valid (param1 and param2).
-	Bit 2 - PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 0
+      Processor APIC field valid (see param3 below).
+    Bit 1
+      Memory address and mask valid (param1 and param2).
+    Bit 2
+      PCIe (seg,bus,dev,fn) valid (see param4 below).
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -121,7 +129,7 @@ BIOS versions based on the ACPI 5.0 specification have more control over
 the target of the injection. For processor-related errors (type 0x1, 0x2
 and 0x4), you can set flags to 0x3 (param3 for bit 0, and param1 and
 param2 for bit 1) so that you have more information added to the error
-signature being injected. The actual data passed is this:
+signature being injected. The actual data passed is this::
 
 	memory_address = param1;
 	memory_address_range = param2;
@@ -131,7 +139,7 @@ signature being injected. The actual data passed is this:
 For memory errors (type 0x8, 0x10 and 0x20) the address is set using
 param1 with a mask in param2 (0x0 is equivalent to all ones). For PCI
 express errors (type 0x40, 0x80 and 0x100) the segment, bus, device and
-function are specified using param1:
+function are specified using param1::
 
          31     24 23    16 15    11 10      8  7        0
 	+-------------------------------------------------+
@@ -152,26 +160,26 @@ documentation for details (and expect changes to this API if vendors
 creativity in using this feature expands beyond our expectations).
 
 
-An error injection example:
+An error injection example::
 
-# cd /sys/kernel/debug/apei/einj
-# cat available_error_type		# See which errors can be injected
-0x00000002	Processor Uncorrectable non-fatal
-0x00000008	Memory Correctable
-0x00000010	Memory Uncorrectable non-fatal
-# echo 0x12345000 > param1		# Set memory address for injection
-# echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
-# echo 0x8 > error_type			# Choose correctable memory error
-# echo 1 > error_inject			# Inject now
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type		# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  # echo 0x12345000 > param1		# Set memory address for injection
+  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
+  # echo 0x8 > error_type			# Choose correctable memory error
+  # echo 1 > error_inject			# Inject now
 
-You should see something like this in dmesg:
+You should see something like this in dmesg::
 
-[22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-[22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
-[22715.834759] EDAC sbridge MC3: TSC 0
-[22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
-[22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
-[22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
+  [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
+  [22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
+  [22715.834759] EDAC sbridge MC3: TSC 0
+  [22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
+  [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
+  [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
 
 For more information about EINJ, please refer to ACPI specification
 version 4.0, section 17.5 and ACPI 5.0, section 18.6.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index 869badba6d7a..fca854f017d8 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -18,6 +18,7 @@ ACPI Support
    debug
    aml-debugger
    apei/output_format
+   apei/einj
    gpio-properties
    i2c-muxes
    acpi-lid
-- 
2.20.1

