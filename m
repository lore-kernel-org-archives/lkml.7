Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E524C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF0420656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383734;
	bh=T88Q3anJ67jpB0REIQ/RS5fqCmqeehWTngeXF6jmrhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ov9MWlRSIwCCwPqtTVhSbYQFhnWlO0+OMAhm51/t53sGeosmx9B+Zbo6ed3T3mnf
	 WQ/nm5+CBlPAWGOBdVLZfRnDp+iioO8Rp1UccehD4tD3uhOO/BvizNNzF3CRTRoa+l
	 mj/AxuAzQhXU54EB4e2CzzY+Nx/4MzmrevRjwn+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfDPDCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:02:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDPC4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Lb1CvBkrKYi+GQQcnRgIGMmigthJb6x2jCvm9OgUTJc=; b=hS5h/Mr3ejfUGhc/kptDKuIW6s
        NXggfm8sYnyVO7dJA80+NNtq5Y2pkm5bLTiWVxEHLc458UK8YByeCbZwBaYoWSevb3hYNta6yjQnX
        5kpgOkmcpXjpyt4CX7w4XAa6+swg0nUNcwBf14/7hJ+bLAHUTXSh2bviFMQ72kHhv6wae6s3xtb4V
        ZTkXGYBSDX6Vwe2o1Vxn0ERHMcz3/yo7QQbdIb54cSsBJJb/Nx8GzwT0gupU3dxGh7v4EWpjwH6it
        6EBgdgZIZQSvSN/TnJzDiOyYUM93EeqW0nQqXXvKYb7892iC1iYLXOuvbZvezQJW5ila0YLlknpC7
        LoYfwkkw==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGp-0007aK-Sj; Tue, 16 Apr 2019 02:56:29 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGm-0001l0-Sn; Mon, 15 Apr 2019 23:56:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 02/57] docs: acpi: convert text files to ReST
Date:   Mon, 15 Apr 2019 23:55:27 -0300
Message-Id: <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the files are already in good shape, making easier to
convert them to ReST by adding proper title markups and
addressing some identation and markups to properly format the
document.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/acpi/DSD-properties-rules.txt   |   4 +-
 Documentation/acpi/acpi-lid.txt               |  37 +-
 Documentation/acpi/aml-debugger.txt           |  31 +-
 Documentation/acpi/apei/einj.txt              |  59 ++--
 Documentation/acpi/apei/output_format.txt     | 247 +++++++-------
 Documentation/acpi/cppc_sysfs.txt             |  52 +--
 Documentation/acpi/debug.txt                  |  20 +-
 .../acpi/dsd/data-node-references.txt         |  11 +-
 Documentation/acpi/dsd/graph.txt              |  24 +-
 Documentation/acpi/dsd/leds.txt               |  18 +-
 Documentation/acpi/dsdt-override.txt          |   4 +-
 Documentation/acpi/enumeration.txt            |  42 +--
 Documentation/acpi/gpio-properties.txt        |  42 +--
 Documentation/acpi/i2c-muxes.txt              |  21 +-
 Documentation/acpi/initrd_table_override.txt  |  90 ++---
 Documentation/acpi/linuxized-acpica.txt       |  58 ++--
 Documentation/acpi/lpit.txt                   |   8 +-
 Documentation/acpi/method-customizing.txt     |  48 ++-
 Documentation/acpi/method-tracing.txt         | 132 ++++---
 Documentation/acpi/namespace.txt              | 323 +++++++++---------
 Documentation/acpi/osi.txt                    |   3 +-
 Documentation/acpi/scan_handlers.txt          |   9 +-
 Documentation/acpi/ssdt-overlays.txt          | 128 +++----
 Documentation/acpi/video_extension.txt        |  16 +-
 24 files changed, 794 insertions(+), 633 deletions(-)

diff --git a/Documentation/acpi/DSD-properties-rules.txt b/Documentation/acpi/DSD-properties-rules.txt
index 3e4862bdad98..2b0307a897c1 100644
--- a/Documentation/acpi/DSD-properties-rules.txt
+++ b/Documentation/acpi/DSD-properties-rules.txt
@@ -1,5 +1,6 @@
+==================================
 _DSD Device Properties Usage Rules
-----------------------------------
+==================================
 
 Properties, Property Sets and Property Subsets
 ----------------------------------------------
@@ -94,4 +95,5 @@ References
 ----------
 
 [1] http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
+
 [2] http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
index effe7af3a5af..a4bc51ee2db1 100644
--- a/Documentation/acpi/acpi-lid.txt
+++ b/Documentation/acpi/acpi-lid.txt
@@ -1,10 +1,14 @@
+=========================================================
 Special Usage Model of the ACPI Control Method Lid Device
+=========================================================
 
 Copyright (C) 2016, Intel Corporation
-Author: Lv Zheng <lv.zheng@intel.com>
 
+:Author: Lv Zheng <lv.zheng@intel.com>
 
-Abstract:
+
+Abstract
+========
 
 Platforms containing lids convey lid state (open/close) to OSPMs using a
 control method lid device. To implement this, the AML tables issue
@@ -20,6 +24,7 @@ expections of the Linux ACPI lid device driver.
 
 
 1. Restrictions of the returning value of the _LID control method
+=================================================================
 
 The _LID control method is described to return the "current" lid state.
 However the word of "current" has ambiguity, some buggy AML tables return
@@ -31,6 +36,8 @@ with cached value, the initial returning value is likely not reliable.
 There are platforms always retun "closed" as initial lid state.
 
 2. Restrictions of the lid state change notifications
+=====================================================
+
 
 There are buggy AML tables never notifying when the lid device state is
 changed to "opened". Thus the "opened" notification is not guaranteed. But
@@ -40,26 +47,32 @@ trigger some system power saving operations on Windows. Since it is fully
 tested, it is reliable from all AML tables.
 
 3. Expections for the userspace users of the ACPI lid device driver
+===================================================================
 
 The ACPI button driver exports the lid state to the userspace via the
 following file:
+
   /proc/acpi/button/lid/LID0/state
+
 This file actually calls the _LID control method described above. And given
 the previous explanation, it is not reliable enough on some platforms. So
 it is advised for the userspace program to not to solely rely on this file
 to determine the actual lid state.
 
 The ACPI button driver emits the following input event to the userspace:
-  SW_LID
-The ACPI lid device driver is implemented to try to deliver the platform
-triggered events to the userspace. However, given the fact that the buggy
-firmware cannot make sure "opened"/"closed" events are paired, the ACPI
-button driver uses the following 3 modes in order not to trigger issues.
+
+SW_LID
+  The ACPI lid device driver is implemented to try to deliver the platform
+  triggered events to the userspace. However, given the fact that the buggy
+  firmware cannot make sure "opened"/"closed" events are paired, the ACPI
+  button driver uses the following 3 modes in order not to trigger issues.
 
 If the userspace hasn't been prepared to ignore the unreliable "opened"
 events and the unreliable initial state notification, Linux users can use
 the following kernel parameters to handle the possible issues:
-A. button.lid_init_state=method:
+
+A. `button.lid_init_state=method`:
+
    When this option is specified, the ACPI button driver reports the
    initial lid state using the returning value of the _LID control method
    and whether the "opened"/"closed" events are paired fully relies on the
@@ -69,7 +82,9 @@ A. button.lid_init_state=method:
    notification is missing.
    This option is the default behavior during the period the userspace
    isn't ready to handle the buggy AML tables.
-B. button.lid_init_state=open:
+
+B. `button.lid_init_state=open`:
+
    When this option is specified, the ACPI button driver always reports the
    initial lid state as "opened" and whether the "opened"/"closed" events
    are paired fully relies on the firmware implementation.
@@ -80,7 +95,9 @@ B. button.lid_init_state=open:
 If the userspace has been prepared to ignore the unreliable "opened" events
 and the unreliable initial state notification, Linux users should always
 use the following kernel parameter:
-C. button.lid_init_state=ignore:
+
+C. `button.lid_init_state=ignore`:
+
    When this option is specified, the ACPI button driver never reports the
    initial lid state and there is a compensation mechanism implemented to
    ensure that the reliable "closed" notifications can always be delievered
diff --git a/Documentation/acpi/aml-debugger.txt b/Documentation/acpi/aml-debugger.txt
index 75ebeb64ab29..22144e0c496d 100644
--- a/Documentation/acpi/aml-debugger.txt
+++ b/Documentation/acpi/aml-debugger.txt
@@ -1,6 +1,9 @@
+================
 The AML Debugger
+================
 
 Copyright (C) 2016, Intel Corporation
+
 Author: Lv Zheng <lv.zheng@intel.com>
 
 
@@ -10,16 +13,16 @@ kernel.
 1. Build the debugger
 
    The following kernel configuration items are required to enable the AML
-   debugger interface from the Linux kernel:
+   debugger interface from the Linux kernel::
 
-   CONFIG_ACPI_DEBUGGER=y
-   CONFIG_ACPI_DEBUGGER_USER=m
+     CONFIG_ACPI_DEBUGGER=y
+     CONFIG_ACPI_DEBUGGER_USER=m
 
    The userspace utilities can be built from the kernel source tree using
-   the following commands:
+   the following commands::
 
-   $ cd tools
-   $ make acpi
+     $ cd tools
+     $ make acpi
 
    The resultant userspace tool binary is then located at:
 
@@ -31,11 +34,11 @@ kernel.
 2. Start the userspace debugger interface
 
    After booting the kernel with the debugger built-in, the debugger can be
-   started by using the following commands:
+   started by using the following commands::
 
-   # mount -t debugfs none /sys/kernel/debug
-   # modprobe acpi_dbg
-   # tools/power/acpi/acpidbg
+     # mount -t debugfs none /sys/kernel/debug
+     # modprobe acpi_dbg
+     # tools/power/acpi/acpidbg
 
    That spawns the interactive AML debugger environment where you can execute
    debugger commands.
@@ -51,9 +54,9 @@ kernel.
 3. Stop the userspace debugger interface
 
    The interactive debugger interface can be closed by pressing Ctrl+C or using
-   the "quit" or "exit" commands.  When finished, unload the module with:
+   the "quit" or "exit" commands.  When finished, unload the module with::
 
-   # rmmod acpi_dbg
+     # rmmod acpi_dbg
 
    The module unloading may fail if there is an acpidbg instance running.
 
@@ -61,6 +64,6 @@ kernel.
 
    It may be useful to run the AML debugger in a test script. "acpidbg" supports
    this in a special "batch" mode.  For example, the following command outputs
-   the entire ACPI namespace:
+   the entire ACPI namespace::
 
-   # acpidbg -b "namespace"
+     # acpidbg -b "namespace"
diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
index e550c8b98139..4fe670dd2d4c 100644
--- a/Documentation/acpi/apei/einj.txt
+++ b/Documentation/acpi/apei/einj.txt
@@ -1,13 +1,14 @@
-			APEI Error INJection
-			~~~~~~~~~~~~~~~~~~~~
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
@@ -23,11 +24,11 @@ order to see the APEI,EINJ,... functionality supported and exposed by
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
 
@@ -37,8 +38,9 @@ The following files belong to it:
 
   This file shows which error types are supported:
 
+  ================	===================================
   Error Type Value	Error Description
-  ================	=================
+  ================	===================================
   0x00000001		Processor Correctable
   0x00000002		Processor Uncorrectable non-fatal
   0x00000004		Processor Uncorrectable fatal
@@ -51,6 +53,7 @@ The following files belong to it:
   0x00000200		Platform Correctable
   0x00000400		Platform Uncorrectable non-fatal
   0x00000800		Platform Uncorrectable fatal
+  ================	===================================
 
   The format of the file contents are as above, except present are only
   the available error types.
@@ -121,7 +124,7 @@ BIOS versions based on the ACPI 5.0 specification have more control over
 the target of the injection. For processor-related errors (type 0x1, 0x2
 and 0x4), you can set flags to 0x3 (param3 for bit 0, and param1 and
 param2 for bit 1) so that you have more information added to the error
-signature being injected. The actual data passed is this:
+signature being injected. The actual data passed is this::
 
 	memory_address = param1;
 	memory_address_range = param2;
@@ -131,7 +134,7 @@ signature being injected. The actual data passed is this:
 For memory errors (type 0x8, 0x10 and 0x20) the address is set using
 param1 with a mask in param2 (0x0 is equivalent to all ones). For PCI
 express errors (type 0x40, 0x80 and 0x100) the segment, bus, device and
-function are specified using param1:
+function are specified using param1::
 
          31     24 23    16 15    11 10      8  7        0
 	+-------------------------------------------------+
@@ -152,26 +155,26 @@ documentation for details (and expect changes to this API if vendors
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
diff --git a/Documentation/acpi/apei/output_format.txt b/Documentation/acpi/apei/output_format.txt
index 0c49c197c47a..b132bdd950b8 100644
--- a/Documentation/acpi/apei/output_format.txt
+++ b/Documentation/acpi/apei/output_format.txt
@@ -1,128 +1,129 @@
-                     APEI output format
-                     ~~~~~~~~~~~~~~~~~~
+==================
+APEI output format
+==================
 
 APEI uses printk as hardware error reporting interface, the output
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
+format is as follow::
+
+  <error record> :=
+  APEI generic hardware error status
+  severity: <integer>, <severity string>
+  section: <integer>, severity: <integer>, <severity string>
+  flags: <integer>
+  <section flags strings>
+  fru_id: <uuid string>
+  fru_text: <string>
+  section_type: <section type string>
+  <section data>
+
+  <severity string>* := recoverable | fatal | corrected | info
+
+  <section flags strings># :=
+  [primary][, containment warning][, reset][, threshold exceeded]\
+  [, resource not accessible][, latent error]
+
+  <section type string> := generic processor error | memory error | \
+  PCIe error | unknown, <uuid string>
+
+  <section data> :=
+  <generic processor section data> | <memory section data> | \
+  <pcie section data> | <null>
+
+  <generic processor section data> :=
+  [processor_type: <integer>, <proc type string>]
+  [processor_isa: <integer>, <proc isa string>]
+  [error_type: <integer>
+  <proc error type strings>]
+  [operation: <integer>, <proc operation string>]
+  [flags: <integer>
+  <proc flags strings>]
+  [level: <integer>]
+  [version_info: <integer>]
+  [processor_id: <integer>]
+  [target_address: <integer>]
+  [requestor_id: <integer>]
+  [responder_id: <integer>]
+  [IP: <integer>]
+
+  <proc type string>* := IA32/X64 | IA64
+
+  <proc isa string>* := IA32 | IA64 | X64
+
+  <processor error type strings># :=
+  [cache error][, TLB error][, bus error][, micro-architectural error]
+
+  <proc operation string>* := unknown or generic | data read | data write | \
+  instruction execution
+
+  <proc flags strings># :=
+  [restartable][, precise IP][, overflow][, corrected]
+
+  <memory section data> :=
+  [error_status: <integer>]
+  [physical_address: <integer>]
+  [physical_address_mask: <integer>]
+  [node: <integer>]
+  [card: <integer>]
+  [module: <integer>]
+  [bank: <integer>]
+  [device: <integer>]
+  [row: <integer>]
+  [column: <integer>]
+  [bit_position: <integer>]
+  [requestor_id: <integer>]
+  [responder_id: <integer>]
+  [target_id: <integer>]
+  [error_type: <integer>, <mem error type string>]
+
+  <mem error type string>* :=
+  unknown | no error | single-bit ECC | multi-bit ECC | \
+  single-symbol chipkill ECC | multi-symbol chipkill ECC | master abort | \
+  target abort | parity error | watchdog timeout | invalid address | \
+  mirror Broken | memory sparing | scrub corrected error | \
+  scrub uncorrected error
+
+  <pcie section data> :=
+  [port_type: <integer>, <pcie port type string>]
+  [version: <integer>.<integer>]
+  [command: <integer>, status: <integer>]
+  [device_id: <integer>:<integer>:<integer>.<integer>
+  slot: <integer>
+  secondary_bus: <integer>
+  vendor_id: <integer>, device_id: <integer>
+  class_code: <integer>]
+  [serial number: <integer>, <integer>]
+  [bridge: secondary_status: <integer>, control: <integer>]
+  [aer_status: <integer>, aer_mask: <integer>
+  <aer status string>
+  [aer_uncor_severity: <integer>]
+  aer_layer=<aer layer string>, aer_agent=<aer agent string>
+  aer_tlp_header: <integer> <integer> <integer> <integer>]
+
+  <pcie port type string>* := PCIe end point | legacy PCI end point | \
+  unknown | unknown | root port | upstream switch port | \
+  downstream switch port | PCIe to PCI/PCI-X bridge | \
+  PCI/PCI-X to PCIe bridge | root complex integrated endpoint device | \
+  root complex event collector
+
+  if section severity is fatal or recoverable
+  <aer status string># :=
+  unknown | unknown | unknown | unknown | Data Link Protocol | \
+  unknown | unknown | unknown | unknown | unknown | unknown | unknown | \
+  Poisoned TLP | Flow Control Protocol | Completion Timeout | \
+  Completer Abort | Unexpected Completion | Receiver Overflow | \
+  Malformed TLP | ECRC | Unsupported Request
+  else
+  <aer status string># :=
+  Receiver Error | unknown | unknown | unknown | unknown | unknown | \
+  Bad TLP | Bad DLLP | RELAY_NUM Rollover | unknown | unknown | unknown | \
+  Replay Timer Timeout | Advisory Non-Fatal
+  fi
+
+  <aer layer string> :=
+  Physical Layer | Data Link Layer | Transaction Layer
+
+  <aer agent string> :=
+  Receiver ID | Requester ID | Completer ID | Transmitter ID
 
 Where, [] designate corresponding content is optional
 
diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/acpi/cppc_sysfs.txt
index f20fb445135d..e4c6bb5a3333 100644
--- a/Documentation/acpi/cppc_sysfs.txt
+++ b/Documentation/acpi/cppc_sysfs.txt
@@ -1,5 +1,6 @@
-
-	Collaborative Processor Performance Control (CPPC)
+==================================================
+Collaborative Processor Performance Control (CPPC)
+==================================================
 
 CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
 performance of a logical processor on a contigious and abstract performance
@@ -8,28 +9,30 @@ to request performance levels and to measure per-cpu delivered performance.
 
 For more details on CPPC please refer to the ACPI specification at:
 
-http://uefi.org/specifications
+	http://uefi.org/specifications
 
 Some of the CPPC registers are exposed via sysfs under:
 
-/sys/devices/system/cpu/cpuX/acpi_cppc/
+	/sys/devices/system/cpu/cpuX/acpi_cppc/
 
 for each cpu X
 
 --------------------------------------------------------------------------------
 
-$ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
-/sys/devices/system/cpu/cpu0/acpi_cppc/:
-total 0
--r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
--r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
+::
+
+  $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
+  /sys/devices/system/cpu/cpu0/acpi_cppc/:
+  total 0
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
 
 --------------------------------------------------------------------------------
 
@@ -54,16 +57,17 @@ total 0
 
 --------------------------------------------------------------------------------
 
-		Computing Average Delivered Performance
+Computing Average Delivered Performance
+=======================================
 
 Below describes the steps to compute the average performance delivered by taking
-two different snapshots of feedback counters at time T1 and T2.
+two different snapshots of feedback counters at time T1 and T2::
 
-T1: Read feedback_ctrs as fbc_t1
-    Wait or run some workload
-T2: Read feedback_ctrs as fbc_t2
+  T1: Read feedback_ctrs as fbc_t1
+      Wait or run some workload
+  T2: Read feedback_ctrs as fbc_t2
 
-delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
-reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
+  delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
+  reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
 
-delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
+  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
diff --git a/Documentation/acpi/debug.txt b/Documentation/acpi/debug.txt
index 65bf47c46b6d..259a12a1e6a9 100644
--- a/Documentation/acpi/debug.txt
+++ b/Documentation/acpi/debug.txt
@@ -1,4 +1,6 @@
-			ACPI Debug Output
+=================
+ACPI Debug Output
+=================
 
 
 The ACPI CA, the Linux ACPI core, and some ACPI drivers can generate debug
@@ -33,7 +35,7 @@ to /sys/module/acpi/parameters/debug_layer.
 
 The possible components are defined in include/acpi/acoutput.h and
 include/acpi/acpi_drivers.h.  Reading /sys/module/acpi/parameters/debug_layer
-shows the supported mask values, currently these:
+shows the supported mask values, currently these::
 
     ACPI_UTILITIES                  0x00000001
     ACPI_HARDWARE                   0x00000002
@@ -81,7 +83,7 @@ to /sys/module/acpi/parameters/debug_level.
 
 The possible levels are defined in include/acpi/acoutput.h.  Reading
 /sys/module/acpi/parameters/debug_level shows the supported mask values,
-currently these:
+currently these::
 
     ACPI_LV_INIT                    0x00000001
     ACPI_LV_DEBUG_OBJECT            0x00000002
@@ -115,7 +117,7 @@ currently these:
 Examples
 --------
 
-For example, drivers/acpi/bus.c contains this:
+For example, drivers/acpi/bus.c contains this::
 
     #define _COMPONENT              ACPI_BUS_COMPONENT
     ...
@@ -127,22 +129,22 @@ statement uses ACPI_DB_INFO, which is macro based on the ACPI_LV_INFO
 definition.)
 
 Enable all AML "Debug" output (stores to the Debug object while interpreting
-AML) during boot:
+AML) during boot::
 
     acpi.debug_layer=0xffffffff acpi.debug_level=0x2
 
-Enable PCI and PCI interrupt routing debug messages:
+Enable PCI and PCI interrupt routing debug messages::
 
     acpi.debug_layer=0x400000 acpi.debug_level=0x4
 
-Enable all ACPI hardware-related messages:
+Enable all ACPI hardware-related messages::
 
     acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
 
-Enable all ACPI_DB_INFO messages after boot:
+Enable all ACPI_DB_INFO messages after boot::
 
     # echo 0x4 > /sys/module/acpi/parameters/debug_level
 
-Show all valid component values:
+Show all valid component values::
 
     # cat /sys/module/acpi/parameters/debug_layer
diff --git a/Documentation/acpi/dsd/data-node-references.txt b/Documentation/acpi/dsd/data-node-references.txt
index c3871565c8cf..9ccd02bf060c 100644
--- a/Documentation/acpi/dsd/data-node-references.txt
+++ b/Documentation/acpi/dsd/data-node-references.txt
@@ -1,4 +1,9 @@
+====================
+Data Node References
+====================
+
 Copyright (C) 2018 Intel Corporation
+
 Author: Sakari Ailus <sakari.ailus@linux.intel.com>
 
 
@@ -30,6 +35,8 @@ extension key.
 Example
 -------
 
+::
+
 	In the ASL snippet below, the "reference" _DSD property [2] contains a
 	device object reference to DEV0 and under that device object, a
 	hierarchical data extension key "node@1" referring to the NOD1 object
@@ -81,9 +88,9 @@ References
 ----------
 
 [1] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
     referenced 2018-07-17.
 
 [2] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
     referenced 2016-10-04.
diff --git a/Documentation/acpi/dsd/graph.txt b/Documentation/acpi/dsd/graph.txt
index b9ce910781dc..618deddcf512 100644
--- a/Documentation/acpi/dsd/graph.txt
+++ b/Documentation/acpi/dsd/graph.txt
@@ -1,4 +1,6 @@
+======
 Graphs
+======
 
 
 _DSD
@@ -40,7 +42,7 @@ All port nodes are located under the device's "_DSD" node in the hierarchical
 data extension tree. The data extension related to each port node must begin
 with "port" and must be followed by the "@" character and the number of the port
 as its key. The target object it refers to should be called "PRTX", where "X" is
-the number of the port. An example of such a package would be:
+the number of the port. An example of such a package would be::
 
     Package() { "port@4", PRT4 }
 
@@ -49,7 +51,7 @@ data extension key of the endpoint nodes must begin with
 "endpoint" and must be followed by the "@" character and the number of the
 endpoint. The object it refers to should be called "EPXY", where "X" is the
 number of the port and "Y" is the number of the endpoint. An example of such a
-package would be:
+package would be::
 
     Package() { "endpoint@0", EP40 }
 
@@ -65,7 +67,7 @@ The endpoint reference uses property extension with "remote-endpoint" property
 name followed by a reference in the same package. Such references consist of the
 the remote device reference, the first package entry of the port data extension
 reference under the device and finally the first package entry of the endpoint
-data extension reference under the port. Individual references thus appear as:
+data extension reference under the port. Individual references thus appear as::
 
     Package() { device, "port@X", "endpoint@Y" }
 
@@ -75,7 +77,7 @@ endpoint.
 The references to endpoints must be always done both ways, to the
 remote endpoint and back from the referred remote endpoint node.
 
-A simple example of this is show below:
+A simple example of this is show below::
 
     Scope (\_SB.PCI0.I2C2)
     {
@@ -151,23 +153,25 @@ References
 ----------
 
 [1] _DSD (Device Specific Data) Implementation Guide.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm,
     referenced 2016-10-03.
 
-[2] Devicetree. <URL:http://www.devicetree.org>, referenced 2016-10-03.
+[2] Devicetree.
+    http://www.devicetree.org, referenced 2016-10-03.
 
-[3] Documentation/devicetree/bindings/graph.txt
+[3] Linux Kernel device tree graph rules.
+    Documentation/devicetree/bindings/graph.txt
 
 [4] Device Properties UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf>,
+    http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,
     referenced 2016-10-04.
 
 [5] Hierarchical Data Extension UUID For _DSD.
-    <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
+    URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf,
     referenced 2016-10-04.
 
 [6] Advanced Configuration and Power Interface Specification.
-    <URL:http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf>,
+    http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf,
     referenced 2016-10-04.
 
 [7] _DSD Device Properties Usage Rules.
diff --git a/Documentation/acpi/dsd/leds.txt b/Documentation/acpi/dsd/leds.txt
index 81a63af42ed2..82ccd5cfb1fd 100644
--- a/Documentation/acpi/dsd/leds.txt
+++ b/Documentation/acpi/dsd/leds.txt
@@ -1,4 +1,6 @@
+========================================
 Describing and referring to LEDs in ACPI
+========================================
 
 Individual LEDs are described by hierarchical data extension [6] nodes under the
 device node, the LED driver chip. The "reg" property in the LED specific nodes
@@ -26,7 +28,7 @@ followed by the referred object name. That object shall be named "LED" followed
 by the number of the LED.
 
 An ASL example of a camera sensor device and a LED driver device for two LEDs.
-Objects not relevant for LEDs or the references to them have been omitted.
+Objects not relevant for LEDs or the references to them have been omitted::
 
 	Device (LED)
 	{
@@ -72,10 +74,14 @@ Objects not relevant for LEDs or the references to them have been omitted.
 
 where
 
-	LED	LED driver device
-	LED0	First LED
-	LED1	Second LED
-	SEN	Camera sensor device (or another device the LED is
+	LED
+		LED driver device
+	LED0
+		First LED
+	LED1
+		Second LED
+	SEN
+		Camera sensor device (or another device the LED is
 		related to)
 
 [1] Device tree. <URL:http://www.devicetree.org>, referenced 2019-02-21.
@@ -96,4 +102,4 @@ where
     <URL:http://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf>,
     referenced 2019-02-21.
 
-[7] Documentation/acpi/dsd/data-node-reference.txt
+[7] Documentation/acpi/dsd/data-node-references.txt
diff --git a/Documentation/acpi/dsdt-override.txt b/Documentation/acpi/dsdt-override.txt
index 784841caa6e6..d483b1957be1 100644
--- a/Documentation/acpi/dsdt-override.txt
+++ b/Documentation/acpi/dsdt-override.txt
@@ -1,4 +1,6 @@
-Linux supports a method of overriding the BIOS DSDT:
+===================================================
+Linux supports a method of overriding the BIOS DSDT
+===================================================
 
 CONFIG_ACPI_CUSTOM_DSDT builds the image into the kernel.
 
diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index 1395b844649c..5b740fb9054b 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -1,5 +1,7 @@
+=============================
 ACPI based device enumeration
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+=============================
+
 ACPI 5 introduced a set of new resources (UartTSerialBus, I2cSerialBus,
 SpiSerialBus, GpioIo and GpioInt) which can be used in enumerating slave
 devices behind serial bus controllers.
@@ -11,10 +13,10 @@ that are accessed through memory-mapped registers.
 In order to support this and re-use the existing drivers as much as
 possible we decided to do following:
 
-	o Devices that have no bus connector resource are represented as
+	- Devices that have no bus connector resource are represented as
 	  platform devices.
 
-	o Devices behind real busses where there is a connector resource
+	- Devices behind real busses where there is a connector resource
 	  are represented as struct spi_device or struct i2c_device
 	  (standard UARTs are not busses so there is no struct uart_device).
 
@@ -39,7 +41,7 @@ some other non-ACPI platform, the driver might work out of the box or needs
 some minor changes.
 
 Adding ACPI support for an existing driver should be pretty
-straightforward. Here is the simplest example:
+straightforward. Here is the simplest example::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mydrv_acpi_match[] = {
@@ -66,7 +68,7 @@ DMA controllers enumerated via ACPI should be registered in the system to
 provide generic access to their resources. For example, a driver that would
 like to be accessible to slave devices via generic API call
 dma_request_slave_channel() must register itself at the end of the probe
-function like this:
+function like this::
 
 	err = devm_acpi_dma_controller_register(dev, xlate_func, dw);
 	/* Handle the error if it's not a case of !CONFIG_ACPI */
@@ -74,7 +76,7 @@ function like this:
 and implement custom xlate function if needed (usually acpi_dma_simple_xlate()
 is enough) which converts the FixedDMA resource provided by struct
 acpi_dma_spec into the corresponding DMA channel. A piece of code for that case
-could look like:
+could look like::
 
 	#ifdef CONFIG_ACPI
 	struct filter_args {
@@ -114,7 +116,7 @@ provided by struct acpi_dma.
 Clients must call dma_request_slave_channel() with the string parameter that
 corresponds to a specific FixedDMA resource. By default "tx" means the first
 entry of the FixedDMA resource array, "rx" means the second entry. The table
-below shows a layout:
+below shows a layout::
 
 	Device (I2C0)
 	{
@@ -143,7 +145,7 @@ Slave devices behind SPI bus have SpiSerialBus resource attached to them.
 This is extracted automatically by the SPI core and the slave devices are
 enumerated once spi_register_master() is called by the bus driver.
 
-Here is what the ACPI namespace for a SPI slave might look like:
+Here is what the ACPI namespace for a SPI slave might look like::
 
 	Device (EEP0)
 	{
@@ -163,7 +165,7 @@ Here is what the ACPI namespace for a SPI slave might look like:
 
 The SPI device drivers only need to add ACPI IDs in a similar way than with
 the platform device drivers. Below is an example where we add ACPI support
-to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
+to at25 SPI eeprom driver (this is meant for the above ACPI snippet)::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id at25_acpi_match[] = {
@@ -182,7 +184,7 @@ to at25 SPI eeprom driver (this is meant for the above ACPI snippet):
 
 Note that this driver actually needs more information like page size of the
 eeprom etc. but at the time writing this there is no standard way of
-passing those. One idea is to return this in _DSM method like:
+passing those. One idea is to return this in _DSM method like::
 
 	Device (EEP0)
 	{
@@ -202,7 +204,7 @@ passing those. One idea is to return this in _DSM method like:
 		}
 
 Then the at25 SPI driver can get this configuration by calling _DSM on its
-ACPI handle like:
+ACPI handle like::
 
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
@@ -227,7 +229,7 @@ any slave devices behind the controller device once the adapter is
 registered.
 
 Below is an example of how to add ACPI support to the existing mpu3050
-input driver:
+input driver::
 
 	#ifdef CONFIG_ACPI
 	static const struct acpi_device_id mpu3050_acpi_match[] = {
@@ -257,10 +259,10 @@ and GpioInt. These resources can be used to pass GPIO numbers used by
 the device to the driver. ACPI 5.1 extended this with _DSD (Device
 Specific Data) which made it possible to name the GPIOs among other things.
 
-For example:
+For example::
 
-Device (DEV)
-{
+  Device (DEV)
+  {
 	Method (_CRS, 0, NotSerialized)
 	{
 		Name (SBUF, ResourceTemplate()
@@ -310,7 +312,7 @@ There is a standard GPIO API for that and is documented in
 Documentation/gpio/.
 
 In the above example we can get the corresponding two GPIO descriptors with
-a code like this:
+a code like this::
 
 	#include <linux/gpio/consumer.h>
 	...
@@ -340,15 +342,15 @@ devices there needs to be an ACPI handle that they can use to reference
 parts of the ACPI namespace that relate to them. In the Linux MFD subsystem
 we provide two ways:
 
-	o The children share the parent ACPI handle.
-	o The MFD cell can specify the ACPI id of the device.
+	- The children share the parent ACPI handle.
+	- The MFD cell can specify the ACPI id of the device.
 
 For the first case, the MFD drivers do not need to do anything. The
 resulting child platform device will have its ACPI_COMPANION() set to point
 to the parent device.
 
 If the ACPI namespace has a device that we can match using an ACPI id or ACPI
-adr, the cell should be set like:
+adr, the cell should be set like::
 
 	static struct mfd_cell_acpi_match my_subdevice_cell_acpi_match = {
 		.pnpid = "XYZ0001",
@@ -412,7 +414,7 @@ will be enumerated to depends on the device ID returned by _HID.
 
 For example, the following ACPI sample might be used to enumerate an lm75-type
 I2C temperature sensor and match it to the driver using the Device Tree
-namespace link:
+namespace link::
 
 	Device (TMP0)
 	{
diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index 88c65cb5bf0a..d8ba7a06db73 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -1,5 +1,6 @@
+======================================
 _DSD Device Properties Related to GPIO
---------------------------------------
+======================================
 
 With the release of ACPI 5.1, the _DSD configuration object finally
 allows names to be given to GPIOs (and other things as well) returned
@@ -8,7 +9,7 @@ the corresponding GPIO, which is pretty error prone (it depends on
 the _CRS output ordering, for example).
 
 With _DSD we can now query GPIOs using a name instead of an integer
-index, like the ASL example below shows:
+index, like the ASL example below shows::
 
   // Bluetooth device with reset and shutdown GPIOs
   Device (BTH)
@@ -34,7 +35,7 @@ index, like the ASL example below shows:
       })
   }
 
-The format of the supported GPIO property is:
+The format of the supported GPIO property is::
 
   Package () { "name", Package () { ref, index, pin, active_low }}
 
@@ -55,7 +56,7 @@ It is possible to leave holes in the array of GPIOs. This is useful in
 cases like with SPI host controllers where some chip selects may be
 implemented as GPIOs and some as native signals. For example a SPI host
 controller can have chip selects 0 and 2 implemented as GPIOs and 1 as
-native:
+native::
 
   Package () {
       "cs-gpios",
@@ -78,7 +79,7 @@ _DSD device properties for GPIO controllers:
 - input
 - line-name
 
-Example:
+Example::
 
   Name (_DSD, Package () {
       // _DSD Hierarchical Properties Extension UUID
@@ -100,7 +101,7 @@ Example:
 
 - gpio-line-names
 
-Example:
+Example::
 
   Package () {
       "gpio-line-names",
@@ -139,16 +140,16 @@ line in that resource starting from zero, and the active-low flag for that line,
 respectively, in analogy with the _DSD GPIO property format specified above.
 
 For the example Bluetooth device discussed previously the data structures in
-question would look like this:
+question would look like this::
 
-static const struct acpi_gpio_params reset_gpio = { 1, 1, false };
-static const struct acpi_gpio_params shutdown_gpio = { 0, 0, false };
+  static const struct acpi_gpio_params reset_gpio = { 1, 1, false };
+  static const struct acpi_gpio_params shutdown_gpio = { 0, 0, false };
 
-static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
-  { "reset-gpios", &reset_gpio, 1 },
-  { "shutdown-gpios", &shutdown_gpio, 1 },
-  { },
-};
+  static const struct acpi_gpio_mapping bluetooth_acpi_gpios[] = {
+    { "reset-gpios", &reset_gpio, 1 },
+    { "shutdown-gpios", &shutdown_gpio, 1 },
+    { },
+  };
 
 Next, the mapping table needs to be passed as the second argument to
 acpi_dev_add_driver_gpios() that will register it with the ACPI device object
@@ -163,7 +164,7 @@ Using the _CRS fallback
 If a device does not have _DSD or the driver does not create ACPI GPIO
 mapping, the Linux GPIO framework refuses to return any GPIOs. This is
 because the driver does not know what it actually gets. For example if we
-have a device like below:
+have a device like below::
 
   Device (BTH)
   {
@@ -177,7 +178,7 @@ have a device like below:
       })
   }
 
-The driver might expect to get the right GPIO when it does:
+The driver might expect to get the right GPIO when it does::
 
   desc = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 
@@ -195,18 +196,21 @@ objects, as listed in the above chapter, of the device in question.
 Getting GPIO descriptor
 -----------------------
 
-There are two main approaches to get GPIO resource from ACPI:
+There are two main approaches to get GPIO resource from ACPI::
+
 	desc = gpiod_get(dev, connection_id, flags);
 	desc = gpiod_get_index(dev, connection_id, index, flags);
 
 We may consider two different cases here, i.e. when connection ID is
 provided and otherwise.
 
-Case 1:
+Case 1::
+
 	desc = gpiod_get(dev, "non-null-connection-id", flags);
 	desc = gpiod_get_index(dev, "non-null-connection-id", index, flags);
 
-Case 2:
+Case 2::
+
 	desc = gpiod_get(dev, NULL, flags);
 	desc = gpiod_get_index(dev, NULL, index, flags);
 
diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
index 9fcc4f0b885e..5481cf1ad272 100644
--- a/Documentation/acpi/i2c-muxes.txt
+++ b/Documentation/acpi/i2c-muxes.txt
@@ -1,20 +1,21 @@
+==============
 ACPI I2C Muxes
---------------
+==============
 
 Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
 Device () scope per mux channel.
 
-Consider this topology:
+Consider this topology::
 
-+------+   +------+
-| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
-|      |   | 0x70 |--CH01--> i2c client B (0x50)
-+------+   +------+
+  +------+   +------+
+  | SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
+  |      |   | 0x70 |--CH01--> i2c client B (0x50)
+  +------+   +------+
 
-which corresponds to the following ASL:
+which corresponds to the following ASL::
 
-Device (SMB1)
-{
+  Device (SMB1)
+  {
     Name (_HID, ...)
     Device (MUX0)
     {
@@ -55,4 +56,4 @@ Device (SMB1)
             }
         }
     }
-}
+  }
diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
index 30437a6db373..1b89103f810a 100644
--- a/Documentation/acpi/initrd_table_override.txt
+++ b/Documentation/acpi/initrd_table_override.txt
@@ -1,3 +1,4 @@
+================================
 Upgrading ACPI tables via initrd
 ================================
 
@@ -19,12 +20,14 @@ ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
 feature to work.
 
 For a full list of ACPI tables that can be upgraded/installed, take a look
-at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
+at the `char *table_sigs[MAX_ACPI_SIGNATURE];` definition in
 drivers/acpi/tables.c.
 All ACPI tables iasl (Intel's ACPI compiler and disassembler) knows should
 be overridable, except:
+
    - ACPI_SIG_RSDP (has a signature of 6 bytes)
    - ACPI_SIG_FACS (does not have an ordinary ACPI table header)
+
 Both could get implemented as well.
 
 
@@ -50,47 +53,48 @@ change with not instrumented initrds.
 3) How does it work
 -------------------
 
-# Extract the machine's ACPI tables:
-cd /tmp
-acpidump >acpidump
-acpixtract -a acpidump
-# Disassemble, modify and recompile them:
-iasl -d *.dat
-# For example add this statement into a _PRT (PCI Routing Table) function
-# of the DSDT:
-Store("HELLO WORLD", debug)
-# And increase the OEM Revision. For example, before modification:
-DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
-# After modification:
-DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
-iasl -sa dsdt.dsl
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the cpio
-# archive. Note that if the table put here matches a platform table
-# (similar Table Signature, and similar OEMID, and similar OEM Table ID)
-# with a more recent OEM Revision, the platform table will be upgraded by
-# this table. If the table put here doesn't match a platform table
-# (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
-# ID), this table will be appended.
-mkdir -p kernel/firmware/acpi
-cp dsdt.aml kernel/firmware/acpi
-# A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
-# (see osl.c):
-iasl -sa facp.dsl
-iasl -sa ssdt1.dsl
-cp facp.aml kernel/firmware/acpi
-cp ssdt1.aml kernel/firmware/acpi
-# The uncompressed cpio archive must be the first. Other, typically
-# compressed cpio archives, must be concatenated on top of the uncompressed
-# one. Following command creates the uncompressed cpio archive and
-# concatenates the original initrd on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
-# reboot with increased acpi debug level, e.g. boot params:
-acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
-# and check your syslog:
-[    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-[    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
+# Extract the machine's ACPI tables::
+
+  cd /tmp
+  acpidump >acpidump
+  acpixtract -a acpidump
+  # Disassemble, modify and recompile them:
+  iasl -d *.dat
+  # For example add this statement into a _PRT (PCI Routing Table) function
+  # of the DSDT:
+  # Store("HELLO WORLD", debug)
+  # And increase the OEM Revision. For example, before modification:
+  # DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000000)
+  # After modification:
+  # DefinitionBlock ("DSDT.aml", "DSDT", 2, "INTEL ", "TEMPLATE", 0x00000001)
+  iasl -sa dsdt.dsl
+  # Add the raw ACPI tables to an uncompressed cpio archive.
+  # They must be put into a /kernel/firmware/acpi directory inside the cpio
+  # archive. Note that if the table put here matches a platform table
+  # (similar Table Signature, and similar OEMID, and similar OEM Table ID)
+  # with a more recent OEM Revision, the platform table will be upgraded by
+  # this table. If the table put here doesn't match a platform table
+  # (dissimilar Table Signature, or dissimilar OEMID, or dissimilar OEM Table
+  # ID), this table will be appended.
+  mkdir -p kernel/firmware/acpi
+  cp dsdt.aml kernel/firmware/acpi
+  # A maximum of "NR_ACPI_INITRD_TABLES (64)" tables are currently allowed
+  # (see osl.c):
+  iasl -sa facp.dsl
+  iasl -sa ssdt1.dsl
+  cp facp.aml kernel/firmware/acpi
+  cp ssdt1.aml kernel/firmware/acpi
+  # The uncompressed cpio archive must be the first. Other, typically
+  # compressed cpio archives, must be concatenated on top of the uncompressed
+  # one. Following command creates the uncompressed cpio archive and
+  # concatenates the original initrd on top:
+  find kernel | cpio -H newc --create > /boot/instrumented_initrd
+  cat /boot/initrd >>/boot/instrumented_initrd
+  # reboot with increased acpi debug level, e.g. boot params:
+  acpi.debug_level=0x2 acpi.debug_layer=0xFFFFFFFF
+  # and check your syslog:
+  [    1.268089] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
+  [    1.272091] [ACPI Debug]  String [0x0B] "HELLO WORLD"
 
 iasl is able to disassemble and recompile quite a lot different,
 also static ACPI tables.
@@ -106,6 +110,8 @@ on SUSE).
 
 acpidump can be found in Len Browns pmtools:
 ftp://kernel.org/pub/linux/kernel/people/lenb/acpi/utils/pmtools/acpidump
+
 This tool is also part of the acpica package on SUSE.
+
 Alternatively, used ACPI tables can be retrieved via sysfs in latest kernels:
 /sys/firmware/acpi/tables
diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/acpi/linuxized-acpica.txt
index 3ad7b0dfb083..bb5e7e49e175 100644
--- a/Documentation/acpi/linuxized-acpica.txt
+++ b/Documentation/acpi/linuxized-acpica.txt
@@ -1,10 +1,14 @@
+============================================================
 Linuxized ACPICA - Introduction to ACPICA Release Automation
+============================================================
 
 Copyright (C) 2013-2016, Intel Corporation
+
 Author: Lv Zheng <lv.zheng@intel.com>
 
 
-Abstract:
+Abstract
+========
 
 This document describes the ACPICA project and the relationship between
 ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
@@ -13,6 +17,7 @@ upstream.
 
 
 1. ACPICA Project
+=================
 
    The ACPI Component Architecture (ACPICA) project provides an operating
    system (OS)-independent reference implementation of the Advanced
@@ -25,7 +30,7 @@ upstream.
    supported by Intel Corporation.
 
    The following figure depicts the Linux ACPI subsystem where the ACPICA
-   adaptation is included:
+   adaptation is included::
 
       +---------------------------------------------------------+
       |                                                         |
@@ -72,34 +77,43 @@ upstream.
                  Figure 1. Linux ACPI Software Components
 
    NOTE:
+
     A. OS Service Layer - Provided by Linux to offer OS dependent
-       implementation of the predefined ACPICA interfaces (acpi_os_*).
+       implementation of the predefined ACPICA interfaces (acpi_os_*)::
+
          include/acpi/acpiosxf.h
          drivers/acpi/osl.c
          include/acpi/platform
          include/asm/acenv.h
+
     B. ACPICA Functionality - Released from ACPICA code base to offer
-       OS independent implementation of the ACPICA interfaces (acpi_*).
+       OS independent implementation of the ACPICA interfaces (acpi_*)::
+
          drivers/acpi/acpica
          include/acpi/ac*.h
          tools/power/acpi
+
     C. Linux/ACPI Functionality - Providing Linux specific ACPI
        functionality to the other Linux kernel subsystems and user space
-       programs.
+       programs::
+
          drivers/acpi
          include/linux/acpi.h
          include/linux/acpi*.h
          include/acpi
          tools/power/acpi
+
     D. Architecture Specific ACPICA/ACPI Functionalities - Provided by the
        ACPI subsystem to offer architecture specific implementation of the
        ACPI interfaces.  They are Linux specific components and are out of
-       the scope of this document.
+       the scope of this document::
+
          include/asm/acpi.h
          include/asm/acpi*.h
          arch/*/acpi
 
 2. ACPICA Release
+=================
 
    The ACPICA project maintains its code base at the following repository URL:
    https://github.com/acpica/acpica.git. As a rule, a release is made every
@@ -112,7 +126,7 @@ upstream.
    copy the ACPICA git repository.  Each commit in the monthly release is
    converted into a linuxized ACPICA patch.  Together, they form the monthly
    ACPICA release patchset for the Linux ACPI community.  This process is
-   illustrated in the following figure:
+   illustrated in the following figure::
 
     +-----------------------------+
     | acpica / master (-) commits |
@@ -154,6 +168,7 @@ upstream.
                 Figure 2. ACPICA -> Linux Upstream Process
 
    NOTE:
+
     A. Linuxize Utilities - Provided by the ACPICA repository, including a
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
@@ -171,6 +186,7 @@ upstream.
    CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
 
 3. ACPICA Divergences
+=====================
 
    Ideally, all of the ACPICA commits should be converted into Linux patches
    automatically without manual modifications, the "linux / master" tree should
@@ -183,6 +199,7 @@ upstream.
    "ACPICA Divergences".
 
    The various sources of ACPICA divergences include:
+
    1. Legacy divergences - Before the current ACPICA release process was
       established, there already had been divergences between Linux and
       ACPICA. Over the past several years those divergences have been greatly
@@ -214,6 +231,7 @@ upstream.
       divergences are generated.
 
 4. ACPICA Development
+=====================
 
    This paragraph guides Linux developers to use the ACPICA upstream release
    utilities to obtain Linux patches corresponding to upstream ACPICA commits
@@ -225,11 +243,11 @@ upstream.
    you want to cherry pick must be committed into the local repository.
 
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
-   from the ACPICA local repository:
+   from the ACPICA local repository::
 
-   $ git clone https://github.com/acpica/acpica
-   $ cd acpica
-   $ generate/linux/gen-patch.sh -u [commit ID]
+     $ git clone https://github.com/acpica/acpica
+     $ cd acpica
+     $ generate/linux/gen-patch.sh -u [commit ID]
 
    Here the commit ID is the ACPICA local repository commit ID you want to
    cherry pick.  It can be omitted if the commit is "HEAD".
@@ -240,11 +258,11 @@ upstream.
    changes that haven't been applied to Linux yet.
 
    You can generate the ACPICA release series yourself and rebase your code on
-   top of the generated ACPICA release patches:
+   top of the generated ACPICA release patches::
 
-   $ git clone https://github.com/acpica/acpica
-   $ cd acpica
-   $ generate/linux/make-patches.sh -u [commit ID]
+     $ git clone https://github.com/acpica/acpica
+     $ cd acpica
+     $ generate/linux/make-patches.sh -u [commit ID]
 
    The commit ID should be the last ACPICA commit accepted by Linux.  Usually,
    it is the commit modifying ACPI_CA_VERSION.  It can be found by executing
@@ -254,9 +272,9 @@ upstream.
    3. Inspect the current divergences
 
    If you have local copies of both Linux and upstream ACPICA, you can generate
-   a diff file indicating the state of the current divergences:
+   a diff file indicating the state of the current divergences::
 
-   # git clone https://github.com/acpica/acpica
-   # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
-   # cd acpica
-   # generate/linux/divergences.sh -s ../linux
+     # git clone https://github.com/acpica/acpica
+     # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+     # cd acpica
+     # generate/linux/divergences.sh -s ../linux
diff --git a/Documentation/acpi/lpit.txt b/Documentation/acpi/lpit.txt
index b426398d2e97..b01c97c6f739 100644
--- a/Documentation/acpi/lpit.txt
+++ b/Documentation/acpi/lpit.txt
@@ -1,3 +1,7 @@
+=====================
+Low Power Idle states
+=====================
+
 To enumerate platform Low Power Idle states, Intel platforms are using
 “Low Power Idle Table” (LPIT). More details about this table can be
 downloaded from:
@@ -8,11 +12,13 @@ Residencies for each low power state can be read via FFH
 
 On platforms supporting S0ix sleep states, there can be two types of
 residencies:
+
 - CPU PKG C10 (Read via FFH interface)
 - Platform Controller Hub (PCH) SLP_S0 (Read via memory mapped interface)
 
 The following attributes are added dynamically to the cpuidle
-sysfs attribute group:
+sysfs attribute group::
+
 	/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
 	/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
 
diff --git a/Documentation/acpi/method-customizing.txt b/Documentation/acpi/method-customizing.txt
index 7235da975f23..4a00a52e69f0 100644
--- a/Documentation/acpi/method-customizing.txt
+++ b/Documentation/acpi/method-customizing.txt
@@ -1,3 +1,4 @@
+=======================================
 Linux ACPI Custom Control Method How To
 =======================================
 
@@ -7,47 +8,58 @@ Written by Zhang Rui <rui.zhang@intel.com>
 Linux supports customizing ACPI control methods at runtime.
 
 Users can use this to
+
 1. override an existing method which may not work correctly,
    or just for debugging purposes.
 2. insert a completely new method in order to create a missing
    method such as _OFF, _ON, _STA, _INI, etc.
+
 For these cases, it is far simpler to dynamically install a single
 control method rather than override the entire DSDT, because kernel
 rebuild/reboot is not needed and test result can be got in minutes.
 
-Note: Only ACPI METHOD can be overridden, any other object types like
+Note:
+      Only ACPI METHOD can be overridden, any other object types like
       "Device", "OperationRegion", are not recognized. Methods
       declared inside scope operators are also not supported.
-Note: The same ACPI control method can be overridden for many times,
+Note:
+      The same ACPI control method can be overridden for many times,
       and it's always the latest one that used by Linux/kernel.
-Note: To get the ACPI debug object output (Store (AAAA, Debug)),
+Note:
+      To get the ACPI debug object output (Store (AAAA, Debug)),
       please run "echo 1 > /sys/module/acpi/parameters/aml_debug_output".
 
 1. override an existing method
+
    a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
       just run "cat /sys/firmware/acpi/tables/DSDT > /tmp/dsdt.dat"
    b) disassemble the table by running "iasl -d dsdt.dat".
    c) rewrite the ASL code of the method and save it in a new file,
    d) package the new file (psr.asl) to an ACPI table format.
-      Here is an example of a customized \_SB._AC._PSR method,
+      Here is an example of a customized \_SB._AC._PSR method::
 
-      DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
-      {
-	Method (\_SB_.AC._PSR, 0, NotSerialized)
-	{
+        DefinitionBlock ("", "SSDT", 1, "", "", 0x20080715)
+        {
+	  Method (\_SB_.AC._PSR, 0, NotSerialized)
+	  {
 		Store ("In AC _PSR", Debug)
 		Return (ACON)
-	}
-      }
+	  }
+        }
+
       Note that the full pathname of the method in ACPI namespace
       should be used.
    e) assemble the file to generate the AML code of the method.
-      e.g. "iasl -vw 6084 psr.asl" (psr.aml is generated as a result)
-      If parameter "-vw 6084" is not supported by your iASL compiler,
+      e.g. `iasl -vw 6084 psr.asl` (psr.aml is generated as a result)
+      If parameter `-vw 6084` is not supported by your iASL compiler,
       please try a newer version.
-   f) mount debugfs by "mount -t debugfs none /sys/kernel/debug"
-   g) override the old method via the debugfs by running
-      "cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method"
+   f) mount debugfs by running::
+
+	mount -t debugfs none /sys/kernel/debug
+
+   g) override the old method via the debugfs by running::
+
+	cat /tmp/psr.aml > /sys/kernel/debug/acpi/custom_method
 
 2. insert a new method
    This is easier than overriding an existing method.
@@ -62,12 +74,14 @@ Note: To get the ACPI debug object output (Store (AAAA, Debug)),
    and redo step c) ~ g) to override the method with the original one.
 
 
-Note: We can use a kernel with multiple custom ACPI method running,
+Note:
+      We can use a kernel with multiple custom ACPI method running,
       But each individual write to debugfs can implement a SINGLE
       method override. i.e. if we want to insert/override multiple
       ACPI methods, we need to redo step c) ~ g) for multiple times.
 
-Note: Be aware that root can mis-use this driver to modify arbitrary
+Note:
+      Be aware that root can mis-use this driver to modify arbitrary
       memory and gain additional rights, if root's privileges got
       restricted (for example if root is not allowed to load additional
       modules after boot).
diff --git a/Documentation/acpi/method-tracing.txt b/Documentation/acpi/method-tracing.txt
index 0aba14c8f459..779475fecefb 100644
--- a/Documentation/acpi/method-tracing.txt
+++ b/Documentation/acpi/method-tracing.txt
@@ -1,15 +1,20 @@
+=====================
 ACPICA Trace Facility
+=====================
 
 Copyright (C) 2015, Intel Corporation
+
 Author: Lv Zheng <lv.zheng@intel.com>
 
 
 Abstract:
+=========
 
 This document describes the functions and the interfaces of the method
 tracing facility.
 
 1. Functionalities and usage examples:
+======================================
 
    ACPICA provides method tracing capability. And two functions are
    currently implemented using this capability.
@@ -31,30 +36,38 @@ tracing facility.
 
    The following command examples illustrate the usage of the "log reducer"
    functionality:
+
    a. Filter out the debug layer/level matched logs when control methods
-      are being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "enable" > trace_state
+      are being evaluated::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0xXXXXXXXX" > trace_debug_layer
+        # echo "0xYYYYYYYY" > trace_debug_level
+        # echo "enable" > trace_state
+
    b. Filter out the debug layer/level matched logs when the specified
-      control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method" > /sys/module/acpi/parameters/trace_state
+      control method is being evaluated::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0xXXXXXXXX" > trace_debug_layer
+        # echo "0xYYYYYYYY" > trace_debug_level
+        # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+        # echo "method" > /sys/module/acpi/parameters/trace_state
+
    c. Filter out the debug layer/level matched logs when the specified
-      control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0xXXXXXXXX" > trace_debug_layer
-      # echo "0xYYYYYYYY" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method-once" > /sys/module/acpi/parameters/trace_state
-   Where:
-      0xXXXXXXXX/0xYYYYYYYY: Refer to Documentation/acpi/debug.txt for
+      control method is being evaluated for the first time::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0xXXXXXXXX" > trace_debug_layer
+        # echo "0xYYYYYYYY" > trace_debug_level
+        # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+        # echo "method-once" > /sys/module/acpi/parameters/trace_state
+
+      Where::
+
+        0xXXXXXXXX/0xYYYYYYYY: Refer to Documentation/acpi/debug.txt for
 			     possible debug layer/level masking values.
-      \PPPP.AAAA.TTTT.HHHH: Full path of a control method that can be found
+        \PPPP.AAAA.TTTT.HHHH: Full path of a control method that can be found
 			    in the ACPI namespace. It needn't be an entry
 			    of a control method evaluation.
 
@@ -63,7 +76,8 @@ tracing facility.
    There are special log entries added by the method tracing facility at
    the "trace points" the AML interpreter starts/stops to execute a control
    method, or an AML opcode. Note that the format of the log entries are
-   subject to change:
+   subject to change::
+
      [    0.186427]   exdebug-0398 ex_trace_point        : Method Begin [0xf58394d8:\_SB.PCI0.LPCB.ECOK] execution.
      [    0.186630]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905c88:If] execution.
      [    0.186820]   exdebug-0398 ex_trace_point        : Opcode Begin [0xf5905cc0:LEqual] execution.
@@ -87,43 +101,54 @@ tracing facility.
 
    The following command examples illustrate the usage of the "AML tracer"
    functionality:
+
    a. Filter out the method start/stop "AML tracer" logs when control
-      methods are being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "enable" > trace_state
+      methods are being evaluated::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0x80" > trace_debug_layer
+        # echo "0x10" > trace_debug_level
+        # echo "enable" > trace_state
+
    b. Filter out the method start/stop "AML tracer" when the specified
-      control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method" > trace_state
+      control method is being evaluated::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0x80" > trace_debug_layer
+        # echo "0x10" > trace_debug_level
+        # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+        # echo "method" > trace_state
+
    c. Filter out the method start/stop "AML tracer" logs when the specified
       control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "method-once" > trace_state
+
+        # cd /sys/module/acpi/parameters
+        # echo "0x80" > trace_debug_layer
+        # echo "0x10" > trace_debug_level
+        # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+        # echo "method-once" > trace_state
+
    d. Filter out the method/opcode start/stop "AML tracer" when the
-      specified control method is being evaluated:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "opcode" > trace_state
+      specified control method is being evaluated::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0x80" > trace_debug_layer
+        # echo "0x10" > trace_debug_level
+        # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+        # echo "opcode" > trace_state
+
    e. Filter out the method/opcode start/stop "AML tracer" when the
-      specified control method is being evaluated for the first time:
-      # cd /sys/module/acpi/parameters
-      # echo "0x80" > trace_debug_layer
-      # echo "0x10" > trace_debug_level
-      # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
-      # echo "opcode-opcode" > trace_state
+      specified control method is being evaluated for the first time::
+
+        # cd /sys/module/acpi/parameters
+        # echo "0x80" > trace_debug_layer
+        # echo "0x10" > trace_debug_level
+        # echo "\PPPP.AAAA.TTTT.HHHH" > trace_method_name
+        # echo "opcode-opcode" > trace_state
 
   Note that all above method tracing facility related module parameters can
-  be used as the boot parameters, for example:
+  be used as the boot parameters, for example::
+
       acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 \
       acpi.trace_method_name=\_SB.LID0._LID acpi.trace_state=opcode-once
 
@@ -150,9 +175,12 @@ tracing facility.
    trace_state
 	The status of the tracing feature.
 	Users can enable/disable this debug tracing feature by executing
-	the following command:
+	the following command::
+
 	    # echo string > /sys/module/acpi/parameters/trace_state
+
 	Where "string" should be one of the following:
+
 	"disable"
 	    Disable the method tracing feature.
 	"enable"
@@ -180,8 +208,10 @@ tracing facility.
 	    ACPICA debugging messages matching
 	    "trace_debug_layer/trace_debug_level" during method/opcode
 	    execution of "trace_method_name" will be logged only once.
+
 	Note that, the difference between the "enable" and other feature
         enabling options are:
+
 	1. When "enable" is specified, since
 	   "trace_debug_layer/trace_debug_level" shall apply to all control
 	   method evaluations, after configuring "trace_state" to "enable",
diff --git a/Documentation/acpi/namespace.txt b/Documentation/acpi/namespace.txt
index 1860cb3865c6..9a6dca683fbc 100644
--- a/Documentation/acpi/namespace.txt
+++ b/Documentation/acpi/namespace.txt
@@ -1,10 +1,14 @@
+===================================================
 ACPI Device Tree - Representation of ACPI Namespace
+===================================================
 
 Copyright (C) 2013, Intel Corporation
+
 Author: Lv Zheng <lv.zheng@intel.com>
 
 
 Abstract:
+=========
 
 The Linux ACPI subsystem converts ACPI namespace objects into a Linux
 device tree under the /sys/devices/LNXSYSTEM:00 and updates it upon
@@ -15,12 +19,14 @@ This document illustrates the structure of the ACPI device tree.
 
 
 Credit:
+=======
 
 Thanks for the help from Zhang Rui <rui.zhang@intel.com> and Rafael J.
 Wysocki <rafael.j.wysocki@intel.com>.
 
 
 1. ACPI Definition Blocks
+=========================
 
    The ACPI firmware sets up RSDP (Root System Description Pointer) in the
    system memory address space pointing to the XSDT (Extended System
@@ -40,7 +46,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
    structure of the underlying hardware platform.
 
    The relationships between ACPI System Definition Tables described above
-   are illustrated in the following diagram.
+   are illustrated in the following diagram::
 
      +---------+    +-------+    +--------+    +------------------------+
      |  RSDP   | +->| XSDT  | +->|  FADT  |    |  +-------------------+ |
@@ -68,18 +74,21 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
                      Figure 1. ACPI Definition Blocks
 
-   NOTE: RSDP can also contain a pointer to the RSDT (Root System
+   NOTE:
+         RSDP can also contain a pointer to the RSDT (Root System
          Description Table).  Platforms provide RSDT to enable
          compatibility with ACPI 1.0 operating systems.  The OS is expected
          to use XSDT, if present.
 
 
 2. Example ACPI Namespace
+=========================
 
    All definition blocks are loaded into a single namespace.  The namespace
    is a hierarchy of objects identified by names and paths.
    The following naming conventions apply to object names in the ACPI
    namespace:
+
    1. All names are 32 bits long.
    2. The first byte of a name must be one of 'A' - 'Z', '_'.
    3. Each of the remaining bytes of a name must be one of 'A' - 'Z', '0'
@@ -91,100 +100,101 @@ Wysocki <rafael.j.wysocki@intel.com>.
       (i.e. names prepended with '^' are relative to the parent of the
       current namespace node).
 
-   The figure below shows an example ACPI namespace.
+   The figure below shows an example ACPI namespace::
 
-   +------+
-   | \    |                     Root
-   +------+
-     |
-     | +------+
-     +-| _PR  |                 Scope(_PR): the processor namespace
-     | +------+
-     |   |
-     |   | +------+
-     |   +-| CPU0 |             Processor(CPU0): the first processor
-     |     +------+
-     |
-     | +------+
-     +-| _SB  |                 Scope(_SB): the system bus namespace
-     | +------+
-     |   |
-     |   | +------+
-     |   +-| LID0 |             Device(LID0); the lid device
-     |   | +------+
-     |   |   |
-     |   |   | +------+
-     |   |   +-| _HID |         Name(_HID, "PNP0C0D"): the hardware ID
-     |   |   | +------+
-     |   |   |
-     |   |   | +------+
-     |   |   +-| _STA |         Method(_STA): the status control method
-     |   |     +------+
-     |   |
-     |   | +------+
-     |   +-| PCI0 |             Device(PCI0); the PCI root bridge
-     |     +------+
-     |       |
-     |       | +------+
-     |       +-| _HID |         Name(_HID, "PNP0A08"): the hardware ID
-     |       | +------+
-     |       |
-     |       | +------+
-     |       +-| _CID |         Name(_CID, "PNP0A03"): the compatible ID
-     |       | +------+
-     |       |
-     |       | +------+
-     |       +-| RP03 |         Scope(RP03): the PCI0 power scope
-     |       | +------+
-     |       |   |
-     |       |   | +------+
-     |       |   +-| PXP3 |     PowerResource(PXP3): the PCI0 power resource
-     |       |     +------+
-     |       |
-     |       | +------+
-     |       +-| GFX0 |         Device(GFX0): the graphics adapter
-     |         +------+
-     |           |
-     |           | +------+
-     |           +-| _ADR |     Name(_ADR, 0x00020000): the PCI bus address
-     |           | +------+
-     |           |
-     |           | +------+
-     |           +-| DD01 |     Device(DD01): the LCD output device
-     |             +------+
-     |               |
-     |               | +------+
-     |               +-| _BCL | Method(_BCL): the backlight control method
-     |                 +------+
-     |
-     | +------+
-     +-| _TZ  |                 Scope(_TZ): the thermal zone namespace
-     | +------+
-     |   |
-     |   | +------+
-     |   +-| FN00 |             PowerResource(FN00): the FAN0 power resource
-     |   | +------+
-     |   |
-     |   | +------+
-     |   +-| FAN0 |             Device(FAN0): the FAN0 cooling device
-     |   | +------+
-     |   |   |
-     |   |   | +------+
-     |   |   +-| _HID |         Name(_HID, "PNP0A0B"): the hardware ID
-     |   |     +------+
-     |   |
-     |   | +------+
-     |   +-| TZ00 |             ThermalZone(TZ00); the FAN thermal zone
-     |     +------+
-     |
-     | +------+
-     +-| _GPE |                 Scope(_GPE): the GPE namespace
-       +------+
+     +------+
+     | \    |                     Root
+     +------+
+       |
+       | +------+
+       +-| _PR  |                 Scope(_PR): the processor namespace
+       | +------+
+       |   |
+       |   | +------+
+       |   +-| CPU0 |             Processor(CPU0): the first processor
+       |     +------+
+       |
+       | +------+
+       +-| _SB  |                 Scope(_SB): the system bus namespace
+       | +------+
+       |   |
+       |   | +------+
+       |   +-| LID0 |             Device(LID0); the lid device
+       |   | +------+
+       |   |   |
+       |   |   | +------+
+       |   |   +-| _HID |         Name(_HID, "PNP0C0D"): the hardware ID
+       |   |   | +------+
+       |   |   |
+       |   |   | +------+
+       |   |   +-| _STA |         Method(_STA): the status control method
+       |   |     +------+
+       |   |
+       |   | +------+
+       |   +-| PCI0 |             Device(PCI0); the PCI root bridge
+       |     +------+
+       |       |
+       |       | +------+
+       |       +-| _HID |         Name(_HID, "PNP0A08"): the hardware ID
+       |       | +------+
+       |       |
+       |       | +------+
+       |       +-| _CID |         Name(_CID, "PNP0A03"): the compatible ID
+       |       | +------+
+       |       |
+       |       | +------+
+       |       +-| RP03 |         Scope(RP03): the PCI0 power scope
+       |       | +------+
+       |       |   |
+       |       |   | +------+
+       |       |   +-| PXP3 |     PowerResource(PXP3): the PCI0 power resource
+       |       |     +------+
+       |       |
+       |       | +------+
+       |       +-| GFX0 |         Device(GFX0): the graphics adapter
+       |         +------+
+       |           |
+       |           | +------+
+       |           +-| _ADR |     Name(_ADR, 0x00020000): the PCI bus address
+       |           | +------+
+       |           |
+       |           | +------+
+       |           +-| DD01 |     Device(DD01): the LCD output device
+       |             +------+
+       |               |
+       |               | +------+
+       |               +-| _BCL | Method(_BCL): the backlight control method
+       |                 +------+
+       |
+       | +------+
+       +-| _TZ  |                 Scope(_TZ): the thermal zone namespace
+       | +------+
+       |   |
+       |   | +------+
+       |   +-| FN00 |             PowerResource(FN00): the FAN0 power resource
+       |   | +------+
+       |   |
+       |   | +------+
+       |   +-| FAN0 |             Device(FAN0): the FAN0 cooling device
+       |   | +------+
+       |   |   |
+       |   |   | +------+
+       |   |   +-| _HID |         Name(_HID, "PNP0A0B"): the hardware ID
+       |   |     +------+
+       |   |
+       |   | +------+
+       |   +-| TZ00 |             ThermalZone(TZ00); the FAN thermal zone
+       |     +------+
+       |
+       | +------+
+       +-| _GPE |                 Scope(_GPE): the GPE namespace
+         +------+
 
                      Figure 2. Example ACPI Namespace
 
 
 3. Linux ACPI Device Objects
+============================
 
    The Linux kernel's core ACPI subsystem creates struct acpi_device
    objects for ACPI namespace objects representing devices, power resources
@@ -230,6 +240,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
    the basis of the contents of ACPI System Description Tables (as
    indicated by the letter in the first column and the notation in the
    second column of the table above):
+
    N:
       The object's source is an ACPI namespace node (as indicated by the
       named object's type in the second column).  In that case the object's
@@ -256,6 +267,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
    The forth column of the above table indicates the 'bus_id' generation
    rule of the struct acpi_device object:
+
    _HID:
       _HID in the last column of the table means that the object's bus_id
       is derived from the _HID/_CID identification objects present under
@@ -276,6 +288,7 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
 
 4. Linux ACPI Physical Device Glue
+==================================
 
    ACPI device (i.e. struct acpi_device) objects may be linked to other
    objects in the Linux' device hierarchy that represent "physical" devices
@@ -310,79 +323,83 @@ Wysocki <rafael.j.wysocki@intel.com>.
 
 
 5. Example Linux ACPI Device Tree
+=================================
 
    The sysfs hierarchy of struct acpi_device objects corresponding to the
    example ACPI namespace illustrated in Figure 2 with the addition of
-   fixed PWR_BUTTON/SLP_BUTTON devices is shown below.
+   fixed PWR_BUTTON/SLP_BUTTON devices is shown below::
 
-   +--------------+---+-----------------+
-   | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
-   +--------------+---+-----------------+
-     |
-     | +-------------+-----+----------------+
-     +-| LNXPWRBN:00 | N/A | acpi:LNXPWRBN: |
-     | +-------------+-----+----------------+
-     |
-     | +-------------+-----+----------------+
-     +-| LNXSLPBN:00 | N/A | acpi:LNXSLPBN: |
-     | +-------------+-----+----------------+
-     |
-     | +-----------+------------+--------------+
-     +-| LNXCPU:00 | \_PR_.CPU0 | acpi:LNXCPU: |
-     | +-----------+------------+--------------+
-     |
-     | +-------------+-------+----------------+
-     +-| LNXSYBUS:00 | \_SB_ | acpi:LNXSYBUS: |
-     | +-------------+-------+----------------+
-     |   |
-     |   | +- - - - - - - +- - - - - - +- - - - - - - -+
-     |   +-| PNP0C0D:00 | \_SB_.LID0 | acpi:PNP0C0D: |
-     |   | +- - - - - - - +- - - - - - +- - - - - - - -+
-     |   |
-     |   | +------------+------------+-----------------------+
-     |   +-| PNP0A08:00 | \_SB_.PCI0 | acpi:PNP0A08:PNP0A03: |
-     |     +------------+------------+-----------------------+
-     |       |
-     |       | +-----------+-----------------+-----+
-     |       +-| device:00 | \_SB_.PCI0.RP03 | N/A |
-     |       | +-----------+-----------------+-----+
-     |       |   |
-     |       |   | +-------------+----------------------+----------------+
-     |       |   +-| LNXPOWER:00 | \_SB_.PCI0.RP03.PXP3 | acpi:LNXPOWER: |
-     |       |     +-------------+----------------------+----------------+
-     |       |
-     |       | +-------------+-----------------+----------------+
-     |       +-| LNXVIDEO:00 | \_SB_.PCI0.GFX0 | acpi:LNXVIDEO: |
-     |         +-------------+-----------------+----------------+
-     |           |
-     |           | +-----------+-----------------+-----+
-     |           +-| device:01 | \_SB_.PCI0.DD01 | N/A |
-     |             +-----------+-----------------+-----+
-     |
-     | +-------------+-------+----------------+
-     +-| LNXSYBUS:01 | \_TZ_ | acpi:LNXSYBUS: |
-       +-------------+-------+----------------+
-         |
-         | +-------------+------------+----------------+
-         +-| LNXPOWER:0a | \_TZ_.FN00 | acpi:LNXPOWER: |
-         | +-------------+------------+----------------+
-         |
-         | +------------+------------+---------------+
-         +-| PNP0C0B:00 | \_TZ_.FAN0 | acpi:PNP0C0B: |
-         | +------------+------------+---------------+
-         |
-         | +-------------+------------+----------------+
-         +-| LNXTHERM:00 | \_TZ_.TZ00 | acpi:LNXTHERM: |
-           +-------------+------------+----------------+
+     +--------------+---+-----------------+
+     | LNXSYSTEM:00 | \ | acpi:LNXSYSTEM: |
+     +--------------+---+-----------------+
+       |
+       | +-------------+-----+----------------+
+       +-| LNXPWRBN:00 | N/A | acpi:LNXPWRBN: |
+       | +-------------+-----+----------------+
+       |
+       | +-------------+-----+----------------+
+       +-| LNXSLPBN:00 | N/A | acpi:LNXSLPBN: |
+       | +-------------+-----+----------------+
+       |
+       | +-----------+------------+--------------+
+       +-| LNXCPU:00 | \_PR_.CPU0 | acpi:LNXCPU: |
+       | +-----------+------------+--------------+
+       |
+       | +-------------+-------+----------------+
+       +-| LNXSYBUS:00 | \_SB_ | acpi:LNXSYBUS: |
+       | +-------------+-------+----------------+
+       |   |
+       |   | +- - - - - - - +- - - - - - +- - - - - - - -+
+       |   +-| PNP0C0D:00 | \_SB_.LID0 | acpi:PNP0C0D: |
+       |   | +- - - - - - - +- - - - - - +- - - - - - - -+
+       |   |
+       |   | +------------+------------+-----------------------+
+       |   +-| PNP0A08:00 | \_SB_.PCI0 | acpi:PNP0A08:PNP0A03: |
+       |     +------------+------------+-----------------------+
+       |       |
+       |       | +-----------+-----------------+-----+
+       |       +-| device:00 | \_SB_.PCI0.RP03 | N/A |
+       |       | +-----------+-----------------+-----+
+       |       |   |
+       |       |   | +-------------+----------------------+----------------+
+       |       |   +-| LNXPOWER:00 | \_SB_.PCI0.RP03.PXP3 | acpi:LNXPOWER: |
+       |       |     +-------------+----------------------+----------------+
+       |       |
+       |       | +-------------+-----------------+----------------+
+       |       +-| LNXVIDEO:00 | \_SB_.PCI0.GFX0 | acpi:LNXVIDEO: |
+       |         +-------------+-----------------+----------------+
+       |           |
+       |           | +-----------+-----------------+-----+
+       |           +-| device:01 | \_SB_.PCI0.DD01 | N/A |
+       |             +-----------+-----------------+-----+
+       |
+       | +-------------+-------+----------------+
+       +-| LNXSYBUS:01 | \_TZ_ | acpi:LNXSYBUS: |
+         +-------------+-------+----------------+
+           |
+           | +-------------+------------+----------------+
+           +-| LNXPOWER:0a | \_TZ_.FN00 | acpi:LNXPOWER: |
+           | +-------------+------------+----------------+
+           |
+           | +------------+------------+---------------+
+           +-| PNP0C0B:00 | \_TZ_.FAN0 | acpi:PNP0C0B: |
+           | +------------+------------+---------------+
+           |
+           | +-------------+------------+----------------+
+           +-| LNXTHERM:00 | \_TZ_.TZ00 | acpi:LNXTHERM: |
+             +-------------+------------+----------------+
 
                   Figure 3. Example Linux ACPI Device Tree
 
-   NOTE: Each node is represented as "object/path/modalias", where:
+   NOTE:
+       Each node is represented as "object/path/modalias", where:
+
          1. 'object' is the name of the object's directory in sysfs.
          2. 'path' is the ACPI namespace path of the corresponding
             ACPI namespace object, as returned by the object's 'path'
             sysfs attribute.
          3. 'modalias' is the value of the object's 'modalias' sysfs
             attribute (as described earlier in this document).
-   NOTE: N/A indicates the device object does not have the 'path' or the
-         'modalias' attribute.
+   NOTE:
+       N/A indicates the device object does not have the 'path' or the
+       'modalias' attribute.
diff --git a/Documentation/acpi/osi.txt b/Documentation/acpi/osi.txt
index 50cde0ceb9b0..401518ca15cc 100644
--- a/Documentation/acpi/osi.txt
+++ b/Documentation/acpi/osi.txt
@@ -1,5 +1,6 @@
+==========================
 ACPI _OSI and _REV methods
---------------------------
+==========================
 
 An ACPI BIOS can use the "Operating System Interfaces" method (_OSI)
 to find out what the operating system supports. Eg. If BIOS
diff --git a/Documentation/acpi/scan_handlers.txt b/Documentation/acpi/scan_handlers.txt
index 3246ccf15992..fa8265f272d5 100644
--- a/Documentation/acpi/scan_handlers.txt
+++ b/Documentation/acpi/scan_handlers.txt
@@ -1,6 +1,9 @@
+==================
 ACPI Scan Handlers
+==================
 
 Copyright (C) 2012, Intel Corporation
+
 Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 During system initialization and ACPI-based device hot-add, the ACPI namespace
@@ -30,14 +33,14 @@ to configure that link so that the kernel can use it.
 Those additional configuration tasks usually depend on the type of the hardware
 component represented by the given device node which can be determined on the
 basis of the device node's hardware ID (HID).  They are performed by objects
-called ACPI scan handlers represented by the following structure:
+called ACPI scan handlers represented by the following structure::
 
-struct acpi_scan_handler {
+  struct acpi_scan_handler {
 	const struct acpi_device_id *ids;
 	struct list_head list_node;
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
-};
+  };
 
 where ids is the list of IDs of device nodes the given handler is supposed to
 take care of, list_node is the hook to the global list of ACPI scan handlers
diff --git a/Documentation/acpi/ssdt-overlays.txt b/Documentation/acpi/ssdt-overlays.txt
index 5ae13f161ea2..036ba3bb8613 100644
--- a/Documentation/acpi/ssdt-overlays.txt
+++ b/Documentation/acpi/ssdt-overlays.txt
@@ -1,3 +1,6 @@
+=============
+SSDT Overlays
+=============
 
 In order to support ACPI open-ended hardware configurations (e.g. development
 boards) we need a way to augment the ACPI configuration provided by the firmware
@@ -15,10 +18,10 @@ user defined SSDT tables that contain the board specific information.
 
 For example, to enumerate a Bosch BMA222E accelerometer on the I2C bus of the
 Minnowboard MAX development board exposed via the LSE connector [1], the
-following ASL code can be used:
+following ASL code can be used::
 
-DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
-{
+  DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
+  {
     External (\_SB.I2C6, DeviceObj)
 
     Scope (\_SB.I2C6)
@@ -45,25 +48,26 @@ DefinitionBlock ("minnowmax.aml", "SSDT", 1, "Vendor", "Accel", 0x00000003)
             }
         }
     }
-}
+  }
 
-which can then be compiled to AML binary format:
+which can then be compiled to AML binary format::
 
-$ iasl minnowmax.asl
+  $ iasl minnowmax.asl
 
-Intel ACPI Component Architecture
-ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
-Copyright (c) 2000 - 2014 Intel Corporation
+  Intel ACPI Component Architecture
+  ASL Optimizing Compiler version 20140214-64 [Mar 29 2014]
+  Copyright (c) 2000 - 2014 Intel Corporation
 
-ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
-AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
+  ASL Input:     minnomax.asl - 30 lines, 614 bytes, 7 keywords
+  AML Output:    minnowmax.aml - 165 bytes, 6 named objects, 1 executable opcodes
 
 [1] http://wiki.minnowboard.org/MinnowBoard_MAX#Low_Speed_Expansion_Connector_.28Top.29
 
 The resulting AML code can then be loaded by the kernel using one of the methods
 below.
 
-== Loading ACPI SSDTs from initrd ==
+Loading ACPI SSDTs from initrd
+==============================
 
 This option allows loading of user defined SSDTs from initrd and it is useful
 when the system does not support EFI or when there is not enough EFI storage.
@@ -74,23 +78,24 @@ aml code must be placed in the first, uncompressed, initrd under the
 in loading multiple tables. Only SSDT and OEM tables are allowed. See
 initrd_table_override.txt for more details.
 
-Here is an example:
+Here is an example::
 
-# Add the raw ACPI tables to an uncompressed cpio archive.
-# They must be put into a /kernel/firmware/acpi directory inside the
-# cpio archive.
-# The uncompressed cpio archive must be the first.
-# Other, typically compressed cpio archives, must be
-# concatenated on top of the uncompressed one.
-mkdir -p kernel/firmware/acpi
-cp ssdt.aml kernel/firmware/acpi
+  # Add the raw ACPI tables to an uncompressed cpio archive.
+  # They must be put into a /kernel/firmware/acpi directory inside the
+  # cpio archive.
+  # The uncompressed cpio archive must be the first.
+  # Other, typically compressed cpio archives, must be
+  # concatenated on top of the uncompressed one.
+  mkdir -p kernel/firmware/acpi
+  cp ssdt.aml kernel/firmware/acpi
 
-# Create the uncompressed cpio archive and concatenate the original initrd
-# on top:
-find kernel | cpio -H newc --create > /boot/instrumented_initrd
-cat /boot/initrd >>/boot/instrumented_initrd
+  # Create the uncompressed cpio archive and concatenate the original initrd
+  # on top:
+  find kernel | cpio -H newc --create > /boot/instrumented_initrd
+  cat /boot/initrd >>/boot/instrumented_initrd
 
-== Loading ACPI SSDTs from EFI variables ==
+Loading ACPI SSDTs from EFI variables
+=====================================
 
 This is the preferred method, when EFI is supported on the platform, because it
 allows a persistent, OS independent way of storing the user defined SSDTs. There
@@ -116,48 +121,49 @@ include/linux/efi.h). Writing to the file must also be done with one write
 operation.
 
 For example, you can use the following bash script to create/update an EFI
-variable with the content from a given file:
+variable with the content from a given file::
 
-#!/bin/sh -e
+  #!/bin/sh -e
 
-while ! [ -z "$1" ]; do
-        case "$1" in
-        "-f") filename="$2"; shift;;
-        "-g") guid="$2"; shift;;
-        *) name="$1";;
-        esac
-        shift
-done
+  while ! [ -z "$1" ]; do
+          case "$1" in
+          "-f") filename="$2"; shift;;
+          "-g") guid="$2"; shift;;
+          *) name="$1";;
+          esac
+          shift
+  done
 
-usage()
-{
-        echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
-        exit 1
-}
+  usage()
+  {
+          echo "Syntax: ${0##*/} -f filename [ -g guid ] name"
+          exit 1
+  }
 
-[ -n "$name" -a -f "$filename" ] || usage
+  [ -n "$name" -a -f "$filename" ] || usage
 
-EFIVARFS="/sys/firmware/efi/efivars"
+  EFIVARFS="/sys/firmware/efi/efivars"
 
-[ -d "$EFIVARFS" ] || exit 2
+  [ -d "$EFIVARFS" ] || exit 2
 
-if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
-        mount -t efivarfs none $EFIVARFS
-fi
+  if stat -tf $EFIVARFS | grep -q -v de5e81e4; then
+          mount -t efivarfs none $EFIVARFS
+  fi
 
-# try to pick up an existing GUID
-[ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
+  # try to pick up an existing GUID
+  [ -n "$guid" ] || guid=$(find "$EFIVARFS" -name "$name-*" | head -n1 | cut -f2- -d-)
 
-# use a randomly generated GUID
-[ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
+  # use a randomly generated GUID
+  [ -n "$guid" ] || guid="$(cat /proc/sys/kernel/random/uuid)"
 
-# efivarfs expects all of the data in one write
-tmp=$(mktemp)
-/bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
-dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
-rm $tmp
+  # efivarfs expects all of the data in one write
+  tmp=$(mktemp)
+  /bin/echo -ne "\007\000\000\000" | cat - $filename > $tmp
+  dd if=$tmp of="$EFIVARFS/$name-$guid" bs=$(stat -c %s $tmp)
+  rm $tmp
 
-== Loading ACPI SSDTs from configfs ==
+Loading ACPI SSDTs from configfs
+================================
 
 This option allows loading of user defined SSDTs from userspace via the configfs
 interface. The CONFIG_ACPI_CONFIGFS option must be select and configfs must be
@@ -165,8 +171,8 @@ mounted. In the following examples, we assume that configfs has been mounted in
 /config.
 
 New tables can be loading by creating new directories in /config/acpi/table/ and
-writing the SSDT aml code in the aml attribute:
+writing the SSDT aml code in the aml attribute::
 
-cd /config/acpi/table
-mkdir my_ssdt
-cat ~/ssdt.aml > my_ssdt/aml
+  cd /config/acpi/table
+  mkdir my_ssdt
+  cat ~/ssdt.aml > my_ssdt/aml
diff --git a/Documentation/acpi/video_extension.txt b/Documentation/acpi/video_extension.txt
index 79bf6a4921be..7a5882a567b9 100644
--- a/Documentation/acpi/video_extension.txt
+++ b/Documentation/acpi/video_extension.txt
@@ -1,5 +1,6 @@
+=====================
 ACPI video extensions
-~~~~~~~~~~~~~~~~~~~~~
+=====================
 
 This driver implement the ACPI Extensions For Display Adapters for
 integrated graphics devices on motherboard, as specified in ACPI 2.0
@@ -32,10 +33,10 @@ type: firmware
 
 Note that ACPI video backlight driver will always use index for
 brightness, actual_brightness and max_brightness. So if we have
-the following _BCL package:
+the following _BCL package::
 
-Method (_BCL, 0, NotSerialized)
-{
+  Method (_BCL, 0, NotSerialized)
+  {
 	Return (Package (0x0C)
 	{
 		0x64,
@@ -51,7 +52,7 @@ Method (_BCL, 0, NotSerialized)
 		0x5A,
 		0x64
 	})
-}
+  }
 
 The first two levels are for when laptop are on AC or on battery and are
 not used by Linux currently. The remaining 10 levels are supported levels
@@ -65,10 +66,11 @@ inclusive.
 2 Notify user space about hotkey event
 
 There are generally two cases for hotkey event reporting:
+
 i) For some laptops, when user presses the hotkey, a scancode will be
    generated and sent to user space through the input device created by
    the keyboard driver as a key type input event, with proper remap, the
-   following key code will appear to user space:
+   following key code will appear to user space::
 
 	EV_KEY, KEY_BRIGHTNESSUP
 	EV_KEY, KEY_BRIGHTNESSDOWN
@@ -82,7 +84,7 @@ ii) For some laptops, the press of the hotkey will not generate the
     about the event. The event value is defined in the ACPI spec. ACPI
     video driver will generate an key type input event according to the
     notify value it received and send the event to user space through the
-    input device it created:
+    input device it created::
 
 	event		keycode
 	0x86		KEY_BRIGHTNESSUP
-- 
2.20.1

