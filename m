Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06203C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DFE2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHsSa2Hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392408AbfDXR4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:56:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33346 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390316AbfDXR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:56:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so9752560pgh.0;
        Wed, 24 Apr 2019 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5a/6MPsR4urKp6yQEMyiUcAMrF2FenVOvePurxnpdZ8=;
        b=fHsSa2HbsgDt5R9Pt5buJ5laHzRdvCq1gBdvWrnaRN9guUkb/VBFzGPAy82XhrTbbP
         CRmBZpA8k3nxUu6yfWZoxHJxKKbzURhcprsAgwyMn/17aDxbcGb5JiuWkbTAcX7lnMz3
         Y5Sq0FpBGeGPDMz/saeUJMJYbUHTC0Rkt76YRv4P6+ofK7TD7VKX096iRAKrcVSeNvFc
         FOr13R8IX5f52dsHpKtbm+TeVgpKXm+7FZDwdx/9TxUsV3h6bZMXXnMnB128bqPws3QN
         PlitJslpDQKTHaIUgk3tOle2GsxtJw+EZypA3LwzgrI9BYAEU3sgieYkA+TJOaW9yfrs
         8ERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5a/6MPsR4urKp6yQEMyiUcAMrF2FenVOvePurxnpdZ8=;
        b=FKtNqDcY5n3v8Mv/xrFNuWApF8et5Qmtw0GSKOVfUyWZjqvXSS61nwMgWnosb8vmCx
         fLaVc4VTEn/wmmxIjH7T1RdULd6zk1/uyUBs8K8p0koPJDCQVgCi4O3Rhi+Es3WViS8O
         deseWHyt/veQ1b/r0/Z6kITtR4MH64x1bnEyMKgbDMXrenLZ6vSVgvqphdx8zuPTIDp1
         98PS1AKm+ZadBGU5m3+pntkxJgMQMnZH1ze48+HwEe3xV+BzKm+tULHPNUlipup25qx1
         rlTw1ufPw8U4gIryf/wEmDqpW09fZXHxQN4TjhsvB/Vnf5n3YuIVgvz5vdY5WWcwgxTm
         PULw==
X-Gm-Message-State: APjAAAXk1SptslsGZI1z7F0LEJoLauyL4SLmvIIfu9V7wRxUvZPtmrzA
        G+f7DOi84CjBO+kzP1JeV0BoCv6d
X-Google-Smtp-Source: APXvYqw/Rz86U4MtWXY/gHoxtin6iU20oqYObT6hNtlZ8WDtx10G5Bq+b4tjpAhL+gs/eDCSDYO7eQ==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr16189198pfe.163.1556128577869;
        Wed, 24 Apr 2019 10:56:17 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:56:17 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 18/23] Documentation: ACPI: move apei/output_format.txt to firmware-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:53:01 +0800
Message-Id: <20190424175306.25880-19-changbin.du@gmail.com>
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
 Documentation/acpi/apei/output_format.txt     | 147 -----------------
 .../acpi/apei/output_format.rst               | 150 ++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 3 files changed, 151 insertions(+), 147 deletions(-)
 delete mode 100644 Documentation/acpi/apei/output_format.txt
 create mode 100644 Documentation/firmware-guide/acpi/apei/output_format.rst

diff --git a/Documentation/acpi/apei/output_format.txt b/Documentation/acpi/apei/output_format.txt
deleted file mode 100644
index 0c49c197c47a..000000000000
--- a/Documentation/acpi/apei/output_format.txt
+++ /dev/null
@@ -1,147 +0,0 @@
-                     APEI output format
-                     ~~~~~~~~~~~~~~~~~~
-
-APEI uses printk as hardware error reporting interface, the output
-format is as follow.
-
-<error record> :=
-APEI generic hardware error status
-severity: <integer>, <severity string>
-section: <integer>, severity: <integer>, <severity string>
-flags: <integer>
-<section flags strings>
-fru_id: <uuid string>
-fru_text: <string>
-section_type: <section type string>
-<section data>
-
-<severity string>* := recoverable | fatal | corrected | info
-
-<section flags strings># :=
-[primary][, containment warning][, reset][, threshold exceeded]\
-[, resource not accessible][, latent error]
-
-<section type string> := generic processor error | memory error | \
-PCIe error | unknown, <uuid string>
-
-<section data> :=
-<generic processor section data> | <memory section data> | \
-<pcie section data> | <null>
-
-<generic processor section data> :=
-[processor_type: <integer>, <proc type string>]
-[processor_isa: <integer>, <proc isa string>]
-[error_type: <integer>
-<proc error type strings>]
-[operation: <integer>, <proc operation string>]
-[flags: <integer>
-<proc flags strings>]
-[level: <integer>]
-[version_info: <integer>]
-[processor_id: <integer>]
-[target_address: <integer>]
-[requestor_id: <integer>]
-[responder_id: <integer>]
-[IP: <integer>]
-
-<proc type string>* := IA32/X64 | IA64
-
-<proc isa string>* := IA32 | IA64 | X64
-
-<processor error type strings># :=
-[cache error][, TLB error][, bus error][, micro-architectural error]
-
-<proc operation string>* := unknown or generic | data read | data write | \
-instruction execution
-
-<proc flags strings># :=
-[restartable][, precise IP][, overflow][, corrected]
-
-<memory section data> :=
-[error_status: <integer>]
-[physical_address: <integer>]
-[physical_address_mask: <integer>]
-[node: <integer>]
-[card: <integer>]
-[module: <integer>]
-[bank: <integer>]
-[device: <integer>]
-[row: <integer>]
-[column: <integer>]
-[bit_position: <integer>]
-[requestor_id: <integer>]
-[responder_id: <integer>]
-[target_id: <integer>]
-[error_type: <integer>, <mem error type string>]
-
-<mem error type string>* :=
-unknown | no error | single-bit ECC | multi-bit ECC | \
-single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
-target abort | parity error | watchdog timeout | invalid address | \
-mirror Broken | memory sparing | scrub corrected error | \
-scrub uncorrected error
-
-<pcie section data> :=
-[port_type: <integer>, <pcie port type string>]
-[version: <integer>.<integer>]
-[command: <integer>, status: <integer>]
-[device_id: <integer>:<integer>:<integer>.<integer>
-slot: <integer>
-secondary_bus: <integer>
-vendor_id: <integer>, device_id: <integer>
-class_code: <integer>]
-[serial number: <integer>, <integer>]
-[bridge: secondary_status: <integer>, control: <integer>]
-[aer_status: <integer>, aer_mask: <integer>
-<aer status string>
-[aer_uncor_severity: <integer>]
-aer_layer=<aer layer string>, aer_agent=<aer agent string>
-aer_tlp_header: <integer> <integer> <integer> <integer>]
-
-<pcie port type string>* := PCIe end point | legacy PCI end point | \
-unknown | unknown | root port | upstream switch port | \
-downstream switch port | PCIe to PCI/PCI-X bridge | \
-PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
-root complex event collector
-
-if section severity is fatal or recoverable
-<aer status string># :=
-unknown | unknown | unknown | unknown | Data Link Protocol | \
-unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
-Poisoned TLP | Flow Control Protocol | Completion Timeout | \
-Completer Abort | Unexpected Completion | Receiver Overflow | \
-Malformed TLP | ECRC | Unsupported Request
-else
-<aer status string># :=
-Receiver Error | unknown | unknown | unknown | unknown | unknown | \
-Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
-Replay Timer Timeout | Advisory Non-Fatal
-fi
-
-<aer layer string> :=
-Physical Layer | Data Link Layer | Transaction Layer
-
-<aer agent string> :=
-Receiver ID | Requester ID | Completer ID | Transmitter ID
-
-Where, [] designate corresponding content is optional
-
-All <field string> description with * has the following format:
-
-field: <integer>, <field string>
-
-Where value of <integer> should be the position of "string" in <field
-string> description. Otherwise, <field string> will be "unknown".
-
-All <field strings> description with # has the following format:
-
-field: <integer>
-<field strings>
-
-Where each string in <fields strings> corresponding to one set bit of
-<integer>. The bit position is the position of "string" in <field
-strings> description.
-
-For more detailed explanation of every field, please refer to UEFI
-specification version 2.3 or later, section Appendix N: Common
-Platform Error Record.
diff --git a/Documentation/firmware-guide/acpi/apei/output_format.rst b/Documentation/firmware-guide/acpi/apei/output_format.rst
new file mode 100644
index 000000000000..c2e7ebddb529
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/apei/output_format.rst
@@ -0,0 +1,150 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+APEI output format
+==================
+
+APEI uses printk as hardware error reporting interface, the output
+format is as follow::
+
+        <error record> :=
+        APEI generic hardware error status
+        severity: <integer>, <severity string>
+        section: <integer>, severity: <integer>, <severity string>
+        flags: <integer>
+        <section flags strings>
+        fru_id: <uuid string>
+        fru_text: <string>
+        section_type: <section type string>
+        <section data>
+
+        <severity string>* := recoverable | fatal | corrected | info
+
+        <section flags strings># :=
+        [primary][, containment warning][, reset][, threshold exceeded]\
+        [, resource not accessible][, latent error]
+
+        <section type string> := generic processor error | memory error | \
+        PCIe error | unknown, <uuid string>
+
+        <section data> :=
+        <generic processor section data> | <memory section data> | \
+        <pcie section data> | <null>
+
+        <generic processor section data> :=
+        [processor_type: <integer>, <proc type string>]
+        [processor_isa: <integer>, <proc isa string>]
+        [error_type: <integer>
+        <proc error type strings>]
+        [operation: <integer>, <proc operation string>]
+        [flags: <integer>
+        <proc flags strings>]
+        [level: <integer>]
+        [version_info: <integer>]
+        [processor_id: <integer>]
+        [target_address: <integer>]
+        [requestor_id: <integer>]
+        [responder_id: <integer>]
+        [IP: <integer>]
+
+        <proc type string>* := IA32/X64 | IA64
+
+        <proc isa string>* := IA32 | IA64 | X64
+
+        <processor error type strings># :=
+        [cache error][, TLB error][, bus error][, micro-architectural error]
+
+        <proc operation string>* := unknown or generic | data read | data write | \
+        instruction execution
+
+        <proc flags strings># :=
+        [restartable][, precise IP][, overflow][, corrected]
+
+        <memory section data> :=
+        [error_status: <integer>]
+        [physical_address: <integer>]
+        [physical_address_mask: <integer>]
+        [node: <integer>]
+        [card: <integer>]
+        [module: <integer>]
+        [bank: <integer>]
+        [device: <integer>]
+        [row: <integer>]
+        [column: <integer>]
+        [bit_position: <integer>]
+        [requestor_id: <integer>]
+        [responder_id: <integer>]
+        [target_id: <integer>]
+        [error_type: <integer>, <mem error type string>]
+
+        <mem error type string>* :=
+        unknown | no error | single-bit ECC | multi-bit ECC | \
+        single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
+        target abort | parity error | watchdog timeout | invalid address | \
+        mirror Broken | memory sparing | scrub corrected error | \
+        scrub uncorrected error
+
+        <pcie section data> :=
+        [port_type: <integer>, <pcie port type string>]
+        [version: <integer>.<integer>]
+        [command: <integer>, status: <integer>]
+        [device_id: <integer>:<integer>:<integer>.<integer>
+        slot: <integer>
+        secondary_bus: <integer>
+        vendor_id: <integer>, device_id: <integer>
+        class_code: <integer>]
+        [serial number: <integer>, <integer>]
+        [bridge: secondary_status: <integer>, control: <integer>]
+        [aer_status: <integer>, aer_mask: <integer>
+        <aer status string>
+        [aer_uncor_severity: <integer>]
+        aer_layer=<aer layer string>, aer_agent=<aer agent string>
+        aer_tlp_header: <integer> <integer> <integer> <integer>]
+
+        <pcie port type string>* := PCIe end point | legacy PCI end point | \
+        unknown | unknown | root port | upstream switch port | \
+        downstream switch port | PCIe to PCI/PCI-X bridge | \
+        PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
+        root complex event collector
+
+        if section severity is fatal or recoverable
+        <aer status string># :=
+        unknown | unknown | unknown | unknown | Data Link Protocol | \
+        unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
+        Poisoned TLP | Flow Control Protocol | Completion Timeout | \
+        Completer Abort | Unexpected Completion | Receiver Overflow | \
+        Malformed TLP | ECRC | Unsupported Request
+        else
+        <aer status string># :=
+        Receiver Error | unknown | unknown | unknown | unknown | unknown | \
+        Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
+        Replay Timer Timeout | Advisory Non-Fatal
+        fi
+
+        <aer layer string> :=
+        Physical Layer | Data Link Layer | Transaction Layer
+
+        <aer agent string> :=
+        Receiver ID | Requester ID | Completer ID | Transmitter ID
+
+Where, [] designate corresponding content is optional
+
+All <field string> description with * has the following format::
+
+        field: <integer>, <field string>
+
+Where value of <integer> should be the position of "string" in <field
+string> description. Otherwise, <field string> will be "unknown".
+
+All <field strings> description with # has the following format::
+
+        field: <integer>
+        <field strings>
+
+Where each string in <fields strings> corresponding to one set bit of
+<integer>. The bit position is the position of "string" in <field
+strings> description.
+
+For more detailed explanation of every field, please refer to UEFI
+specification version 2.3 or later, section Appendix N: Common
+Platform Error Record.
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index e9f253d54897..869badba6d7a 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -17,6 +17,7 @@ ACPI Support
    DSD-properties-rules
    debug
    aml-debugger
+   apei/output_format
    gpio-properties
    i2c-muxes
    acpi-lid
-- 
2.20.1

