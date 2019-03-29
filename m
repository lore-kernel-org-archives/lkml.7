Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E93C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1119F218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmSG4MGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfC2ANn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43216 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbfC2ANl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id m10so119963plt.10;
        Thu, 28 Mar 2019 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVgroTjcUkS9nqIZT433GaippAQQkLNBQjYZ9znp6m8=;
        b=gmSG4MGYIoIQ3MVtWACY83lSq+1Gl5uQL3zWytipSN5r9x3FOeLtqbzTFUz3rpLEsA
         OS+4hTSdgAtGG1RsXfvUm6HPJutxVVt8kvTXWWH2jK5OlRoUGA7BnC9L0PnxkxYLhevq
         OYFlSbmuIzSWq32T5CgyKacN5ikRPw7WbyVOW7YcYd1Gs9hBvADTSpgVh/w+ovVvRBxM
         /SLFrQOr1cEbQwcuSl4wlti0A1K7n6F74jaqKx7tTfK82Jg9a3dz9CLXCc/yQkWpfEF6
         ZSyuhf8IhClgvxhyeawRbs6NdWIpf4GQNvAE6jFGLwkTOH6kda7lAMdxDChAjMyQ0pGw
         6zTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVgroTjcUkS9nqIZT433GaippAQQkLNBQjYZ9znp6m8=;
        b=nH2AZ49899bZMDACVnnmChD3fKKxa+y3VhmaCAMY1MBccov5ZpsFgOsKQsI1ewJD8t
         IjU/PoqbDPx012pgtpacr/0poSmFM9Prf0NW8TTCBIYkTNd3QZtsVykxBXBq2DH21QVy
         6tLZtl/YJddFtp8/DqDGydaFP2heSeVnvuUbL2SKvL8v0J0NvwrBrPkShFJvHR06MPDm
         p9BXbfuoULsr0SXwzzIx4qzxV/8JIlGnMJbgTR/Hw+tSKXSbWmF6v/M/mmagLqCSjnSR
         8P9NkZjtV1hfTFEU+YEE4GKTl56MVxFKkZXDcI7st9pOOp9kFtseetwZQPXt4jqJQz/K
         MJqw==
X-Gm-Message-State: APjAAAVCLfzOlj1Gi5Pmvl08w5FfnBxY9rW6++YgemRYAVAiuIHHPfS+
        SkjqB2vOvQ0DYwNLXJLqlts=
X-Google-Smtp-Source: APXvYqzAi9hsLOT3CpGtc/S3ZP25wrACW9rf1NkieFaGLNCEujrAqzkhrAOL4VYS3RGDuWmFkJGdPQ==
X-Received: by 2002:a17:902:e90b:: with SMTP id cs11mr44878696plb.197.1553818420140;
        Thu, 28 Mar 2019 17:13:40 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 19/24] acpi doc: convert acpi/apei/output_format.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:30 +0800
Message-Id: <20190329001135.15847-20-changbin.du@gmail.com>
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
 Documentation/acpi/apei/output_format.rst | 150 ++++++++++++++++++++++
 Documentation/acpi/apei/output_format.txt | 147 ---------------------
 Documentation/acpi/index.rst              |   1 +
 3 files changed, 151 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/acpi/apei/output_format.rst
 delete mode 100644 Documentation/acpi/apei/output_format.txt

diff --git a/Documentation/acpi/apei/output_format.rst b/Documentation/acpi/apei/output_format.rst
new file mode 100644
index 000000000000..c2e7ebddb529
--- /dev/null
+++ b/Documentation/acpi/apei/output_format.rst
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
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index a1c7ad451099..39c647386fe2 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -24,3 +24,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    debug
    method-tracing
    aml-debugger
+   apei/output_format
-- 
2.20.1

