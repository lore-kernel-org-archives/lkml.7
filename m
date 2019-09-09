Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BCC4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C81206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvKufjYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfIIOTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:19:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38652 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731355AbfIIOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:19:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id d10so7925441pgo.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wI/8/QSKCWQscrJ6pIN8WHFcqFbfep/PPP8QD5gBmDI=;
        b=OvKufjYA31WCb09huyYNhqs8B5LIMpMPbEoIb21SJyimOe2SCztubuPxo+JQHVggYH
         01ZjaD6eByiiaa1yRgI3K4V0Digvo8EvsoV1uqAS7ADh9E3qCZ3pVcTbL2vW2X1GbalZ
         d2H1+EMREki8meuHLFGgEto5407/DOX580DPkeph34ETJyowkPHKF1TlqdaywrOL0EnW
         fnRfO00zze8VNdloDb5v309Q8UrrtSC0njh3QcusExr1oZkrZWZ8ebPqDlNxKAOFB8OY
         QFo6RBiUlpOXSl41vYD1pjPwkq5FWF6WQhiOV//88lpE4oxG2RuVFOtwFXgaEJOSrtRE
         DwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wI/8/QSKCWQscrJ6pIN8WHFcqFbfep/PPP8QD5gBmDI=;
        b=FHBU3sJQ0gL6H9imbC545SnB5syxgG5Jc172UVkKxHPS9UmbLRKVNwrXI8kXnOh7zE
         /wN03B5q8d0TXMd1wjcrphD4p1uZJuwOOQbJUZHv7TWopwnt+pGzXH/FBqYxoPfhVTo9
         zEFz4atChpziANscNeKLQb5lZ3ScpEpsPMl1n3SyIeWNOIhKnCU1MVlsVKfksMu1DyQk
         hLsNytb2sbWCMFyJzah4I8ceMX6ds1Ci2/eaEAR4T4Q3NNQo7OlKgsPvWW9kF2fv/fMe
         2etGfUs0rBk/ZoAPtY+fhQrZ5hQtZ/JLr4EWTt5EisBb3XfhPkl/mfxPH9J4IdVQyVtu
         GIfQ==
X-Gm-Message-State: APjAAAXGKDpOmUsjzoqDrHe0RNIgAEx0+HDYImKOcrCGlFTzbZlXSUOW
        tSjO7/sxtd/73eVuRx1l72chBFJkj9TKrA==
X-Google-Smtp-Source: APXvYqwznBhm5WIBSzfZ1MLJMmVLuc4s6+SKbI0ds/qROq8+hzCLAfCPYxVMFQemms3JthCOLBWNhQ==
X-Received: by 2002:a63:e948:: with SMTP id q8mr21221200pgj.93.1568038741423;
        Mon, 09 Sep 2019 07:19:01 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id w6sm34574695pfw.84.2019.09.09.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:19:00 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 4/9] kconfig/hacking: Move kernel testing and coverage options to same submenu
Date:   Mon,  9 Sep 2019 22:18:18 +0800
Message-Id: <20190909141823.8638-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909141823.8638-1-changbin.du@gmail.com>
References: <20190909141823.8638-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move error injection, coverage, testing options to a new submenu
'Kernel Testing and Coverage'. They are all for test purpose.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 497 +++++++++++++++++++++++-----------------------
 1 file changed, 251 insertions(+), 246 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 92271898b029..7b3552531d02 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -784,53 +784,6 @@ source "lib/Kconfig.kasan"
 
 endmenu # "Memory Debugging"
 
-config ARCH_HAS_KCOV
-	bool
-	help
-	  An architecture should select this when it can successfully
-	  build and run with CONFIG_KCOV. This typically requires
-	  disabling instrumentation for some early boot code.
-
-config CC_HAS_SANCOV_TRACE_PC
-	def_bool $(cc-option,-fsanitize-coverage=trace-pc)
-
-config KCOV
-	bool "Code coverage for fuzzing"
-	depends on ARCH_HAS_KCOV
-	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
-	select DEBUG_FS
-	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
-	help
-	  KCOV exposes kernel code coverage information in a form suitable
-	  for coverage-guided fuzzing (randomized testing).
-
-	  If RANDOMIZE_BASE is enabled, PC values will not be stable across
-	  different machines and across reboots. If you need stable PC values,
-	  disable RANDOMIZE_BASE.
-
-	  For more details, see Documentation/dev-tools/kcov.rst.
-
-config KCOV_ENABLE_COMPARISONS
-	bool "Enable comparison operands collection by KCOV"
-	depends on KCOV
-	depends on $(cc-option,-fsanitize-coverage=trace-cmp)
-	help
-	  KCOV also exposes operands of every comparison in the instrumented
-	  code along with operand sizes and PCs of the comparison instructions.
-	  These operands can be used by fuzzing engines to improve the quality
-	  of fuzzing coverage.
-
-config KCOV_INSTRUMENT_ALL
-	bool "Instrument all code by default"
-	depends on KCOV
-	default y
-	help
-	  If you are doing generic system call fuzzing (like e.g. syzkaller),
-	  then you will want to instrument the whole kernel and you should
-	  say y here. If you are doing more targeted fuzzing (like e.g.
-	  filesystem fuzzing with AFL) then you will want to enable coverage
-	  for more specific subsets of files, and should say n here.
-
 config DEBUG_SHIRQ
 	bool "Debug shared IRQ handlers"
 	depends on DEBUG_KERNEL
@@ -1500,164 +1453,6 @@ config CPU_HOTPLUG_STATE_CONTROL
 
 	  Say N if your are unsure.
 
-config NOTIFIER_ERROR_INJECTION
-	tristate "Notifier error injection"
-	depends on DEBUG_KERNEL
-	select DEBUG_FS
-	help
-	  This option provides the ability to inject artificial errors to
-	  specified notifier chain callbacks. It is useful to test the error
-	  handling of notifier call chain failures.
-
-	  Say N if unsure.
-
-config PM_NOTIFIER_ERROR_INJECT
-	tristate "PM notifier error injection module"
-	depends on PM && NOTIFIER_ERROR_INJECTION
-	default m if PM_DEBUG
-	help
-	  This option provides the ability to inject artificial errors to
-	  PM notifier chain callbacks.  It is controlled through debugfs
-	  interface /sys/kernel/debug/notifier-error-inject/pm
-
-	  If the notifier call chain should be failed with some events
-	  notified, write the error code to "actions/<notifier event>/error".
-
-	  Example: Inject PM suspend error (-12 = -ENOMEM)
-
-	  # cd /sys/kernel/debug/notifier-error-inject/pm/
-	  # echo -12 > actions/PM_SUSPEND_PREPARE/error
-	  # echo mem > /sys/power/state
-	  bash: echo: write error: Cannot allocate memory
-
-	  To compile this code as a module, choose M here: the module will
-	  be called pm-notifier-error-inject.
-
-	  If unsure, say N.
-
-config OF_RECONFIG_NOTIFIER_ERROR_INJECT
-	tristate "OF reconfig notifier error injection module"
-	depends on OF_DYNAMIC && NOTIFIER_ERROR_INJECTION
-	help
-	  This option provides the ability to inject artificial errors to
-	  OF reconfig notifier chain callbacks.  It is controlled
-	  through debugfs interface under
-	  /sys/kernel/debug/notifier-error-inject/OF-reconfig/
-
-	  If the notifier call chain should be failed with some events
-	  notified, write the error code to "actions/<notifier event>/error".
-
-	  To compile this code as a module, choose M here: the module will
-	  be called of-reconfig-notifier-error-inject.
-
-	  If unsure, say N.
-
-config NETDEV_NOTIFIER_ERROR_INJECT
-	tristate "Netdev notifier error injection module"
-	depends on NET && NOTIFIER_ERROR_INJECTION
-	help
-	  This option provides the ability to inject artificial errors to
-	  netdevice notifier chain callbacks.  It is controlled through debugfs
-	  interface /sys/kernel/debug/notifier-error-inject/netdev
-
-	  If the notifier call chain should be failed with some events
-	  notified, write the error code to "actions/<notifier event>/error".
-
-	  Example: Inject netdevice mtu change error (-22 = -EINVAL)
-
-	  # cd /sys/kernel/debug/notifier-error-inject/netdev
-	  # echo -22 > actions/NETDEV_CHANGEMTU/error
-	  # ip link set eth0 mtu 1024
-	  RTNETLINK answers: Invalid argument
-
-	  To compile this code as a module, choose M here: the module will
-	  be called netdev-notifier-error-inject.
-
-	  If unsure, say N.
-
-config FUNCTION_ERROR_INJECTION
-	def_bool y
-	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
-
-config FAULT_INJECTION
-	bool "Fault-injection framework"
-	depends on DEBUG_KERNEL
-	help
-	  Provide fault-injection framework.
-	  For more details, see Documentation/fault-injection/.
-
-config FAILSLAB
-	bool "Fault-injection capability for kmalloc"
-	depends on FAULT_INJECTION
-	depends on SLAB || SLUB
-	help
-	  Provide fault-injection capability for kmalloc.
-
-config FAIL_PAGE_ALLOC
-	bool "Fault-injection capabilitiy for alloc_pages()"
-	depends on FAULT_INJECTION
-	help
-	  Provide fault-injection capability for alloc_pages().
-
-config FAIL_MAKE_REQUEST
-	bool "Fault-injection capability for disk IO"
-	depends on FAULT_INJECTION && BLOCK
-	help
-	  Provide fault-injection capability for disk IO.
-
-config FAIL_IO_TIMEOUT
-	bool "Fault-injection capability for faking disk interrupts"
-	depends on FAULT_INJECTION && BLOCK
-	help
-	  Provide fault-injection capability on end IO handling. This
-	  will make the block layer "forget" an interrupt as configured,
-	  thus exercising the error handling.
-
-	  Only works with drivers that use the generic timeout handling,
-	  for others it wont do anything.
-
-config FAIL_FUTEX
-	bool "Fault-injection capability for futexes"
-	select DEBUG_FS
-	depends on FAULT_INJECTION && FUTEX
-	help
-	  Provide fault-injection capability for futexes.
-
-config FAULT_INJECTION_DEBUG_FS
-	bool "Debugfs entries for fault-injection capabilities"
-	depends on FAULT_INJECTION && SYSFS && DEBUG_FS
-	help
-	  Enable configuration of fault-injection capabilities via debugfs.
-
-config FAIL_FUNCTION
-	bool "Fault-injection capability for functions"
-	depends on FAULT_INJECTION_DEBUG_FS && FUNCTION_ERROR_INJECTION
-	help
-	  Provide function-based fault-injection capability.
-	  This will allow you to override a specific function with a return
-	  with given return value. As a result, function caller will see
-	  an error value and have to handle it. This is useful to test the
-	  error handling in various subsystems.
-
-config FAIL_MMC_REQUEST
-	bool "Fault-injection capability for MMC IO"
-	depends on FAULT_INJECTION_DEBUG_FS && MMC
-	help
-	  Provide fault-injection capability for MMC IO.
-	  This will make the mmc core return data errors. This is
-	  useful to test the error handling in the mmc block device
-	  and to test how the mmc host driver handles retries from
-	  the block device.
-
-config FAULT_INJECTION_STACKTRACE_FILTER
-	bool "stacktrace filter for fault-injection capabilities"
-	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
-	depends on !X86_64
-	select STACKTRACE
-	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
-	help
-	  Provide stacktrace filter for fault-injection capabilities
-
 config LATENCYTOP
 	bool "Latency measuring infrastructure"
 	depends on DEBUG_KERNEL
@@ -1704,6 +1499,109 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
+source "samples/Kconfig"
+
+config ARCH_HAS_DEVMEM_IS_ALLOWED
+	bool
+
+config STRICT_DEVMEM
+	bool "Filter access to /dev/mem"
+	depends on MMU && DEVMEM
+	depends on ARCH_HAS_DEVMEM_IS_ALLOWED
+	default y if PPC || X86 || ARM64
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  of memory, including kernel and userspace memory. Accidental
+	  access to this is obviously disastrous, but specific access can
+	  be used by people debugging the kernel. Note that with PAT support
+	  enabled, even in this case there are restrictions on /dev/mem
+	  use due to the cache aliasing requirements.
+
+	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
+	  file only allows userspace access to PCI space and the BIOS code and
+	  data regions.  This is sufficient for dosemu and X and all common
+	  users of /dev/mem.
+
+	  If in doubt, say Y.
+
+config IO_STRICT_DEVMEM
+	bool "Filter I/O access to /dev/mem"
+	depends on STRICT_DEVMEM
+	---help---
+	  If this option is disabled, you allow userspace (root) access to all
+	  io-memory regardless of whether a driver is actively using that
+	  range.  Accidental access to this is obviously disastrous, but
+	  specific access can be used by people debugging kernel drivers.
+
+	  If this option is switched on, the /dev/mem file only allows
+	  userspace access to *idle* io-memory ranges (see /proc/iomem) This
+	  may break traditional users of /dev/mem (dosemu, legacy X, etc...)
+	  if the driver using a given range cannot be disabled.
+
+	  If in doubt, say Y.
+
+config DEBUG_AID_FOR_SYZBOT
+       bool "Additional debug code for syzbot"
+       default n
+       help
+         This option is intended for testing by syzbot.
+
+menu "$(SRCARCH) Debugging"
+
+source "arch/$(SRCARCH)/Kconfig.debug"
+
+endmenu
+
+menu "Kernel Testing and Coverage"
+
+config ARCH_HAS_KCOV
+	bool
+	help
+	  An architecture should select this when it can successfully
+	  build and run with CONFIG_KCOV. This typically requires
+	  disabling instrumentation for some early boot code.
+
+config CC_HAS_SANCOV_TRACE_PC
+	def_bool $(cc-option,-fsanitize-coverage=trace-pc)
+
+
+config KCOV
+	bool "Code coverage for fuzzing"
+	depends on ARCH_HAS_KCOV
+	depends on CC_HAS_SANCOV_TRACE_PC || GCC_PLUGINS
+	select DEBUG_FS
+	select GCC_PLUGIN_SANCOV if !CC_HAS_SANCOV_TRACE_PC
+	help
+	  KCOV exposes kernel code coverage information in a form suitable
+	  for coverage-guided fuzzing (randomized testing).
+
+	  If RANDOMIZE_BASE is enabled, PC values will not be stable across
+	  different machines and across reboots. If you need stable PC values,
+	  disable RANDOMIZE_BASE.
+
+	  For more details, see Documentation/dev-tools/kcov.rst.
+
+config KCOV_ENABLE_COMPARISONS
+	bool "Enable comparison operands collection by KCOV"
+	depends on KCOV
+	depends on $(cc-option,-fsanitize-coverage=trace-cmp)
+	help
+	  KCOV also exposes operands of every comparison in the instrumented
+	  code along with operand sizes and PCs of the comparison instructions.
+	  These operands can be used by fuzzing engines to improve the quality
+	  of fuzzing coverage.
+
+config KCOV_INSTRUMENT_ALL
+	bool "Instrument all code by default"
+	depends on KCOV
+	default y
+	help
+	  If you are doing generic system call fuzzing (like e.g. syzkaller),
+	  then you will want to instrument the whole kernel and you should
+	  say y here. If you are doing more targeted fuzzing (like e.g.
+	  filesystem fuzzing with AFL) then you will want to enable coverage
+	  for more specific subsets of files, and should say n here.
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	def_bool y
@@ -2121,57 +2019,164 @@ config MEMTEST
 	        memtest=17, mean do 17 test patterns.
 	  If you are unsure how to answer this question, answer N.
 
-source "samples/Kconfig"
+config NOTIFIER_ERROR_INJECTION
+	tristate "Notifier error injection"
+	depends on DEBUG_KERNEL
+	select DEBUG_FS
+	help
+	  This option provides the ability to inject artificial errors to
+	  specified notifier chain callbacks. It is useful to test the error
+	  handling of notifier call chain failures.
 
-config ARCH_HAS_DEVMEM_IS_ALLOWED
-	bool
+	  Say N if unsure.
 
-config STRICT_DEVMEM
-	bool "Filter access to /dev/mem"
-	depends on MMU && DEVMEM
-	depends on ARCH_HAS_DEVMEM_IS_ALLOWED
-	default y if PPC || X86 || ARM64
-	---help---
-	  If this option is disabled, you allow userspace (root) access to all
-	  of memory, including kernel and userspace memory. Accidental
-	  access to this is obviously disastrous, but specific access can
-	  be used by people debugging the kernel. Note that with PAT support
-	  enabled, even in this case there are restrictions on /dev/mem
-	  use due to the cache aliasing requirements.
+config PM_NOTIFIER_ERROR_INJECT
+	tristate "PM notifier error injection module"
+	depends on PM && NOTIFIER_ERROR_INJECTION
+	default m if PM_DEBUG
+	help
+	  This option provides the ability to inject artificial errors to
+	  PM notifier chain callbacks.  It is controlled through debugfs
+	  interface /sys/kernel/debug/notifier-error-inject/pm
 
-	  If this option is switched on, and IO_STRICT_DEVMEM=n, the /dev/mem
-	  file only allows userspace access to PCI space and the BIOS code and
-	  data regions.  This is sufficient for dosemu and X and all common
-	  users of /dev/mem.
+	  If the notifier call chain should be failed with some events
+	  notified, write the error code to "actions/<notifier event>/error".
 
-	  If in doubt, say Y.
+	  Example: Inject PM suspend error (-12 = -ENOMEM)
 
-config IO_STRICT_DEVMEM
-	bool "Filter I/O access to /dev/mem"
-	depends on STRICT_DEVMEM
-	---help---
-	  If this option is disabled, you allow userspace (root) access to all
-	  io-memory regardless of whether a driver is actively using that
-	  range.  Accidental access to this is obviously disastrous, but
-	  specific access can be used by people debugging kernel drivers.
+	  # cd /sys/kernel/debug/notifier-error-inject/pm/
+	  # echo -12 > actions/PM_SUSPEND_PREPARE/error
+	  # echo mem > /sys/power/state
+	  bash: echo: write error: Cannot allocate memory
 
-	  If this option is switched on, the /dev/mem file only allows
-	  userspace access to *idle* io-memory ranges (see /proc/iomem) This
-	  may break traditional users of /dev/mem (dosemu, legacy X, etc...)
-	  if the driver using a given range cannot be disabled.
+	  To compile this code as a module, choose M here: the module will
+	  be called pm-notifier-error-inject.
 
-	  If in doubt, say Y.
+	  If unsure, say N.
 
-config DEBUG_AID_FOR_SYZBOT
-       bool "Additional debug code for syzbot"
-       default n
-       help
-         This option is intended for testing by syzbot.
+config OF_RECONFIG_NOTIFIER_ERROR_INJECT
+	tristate "OF reconfig notifier error injection module"
+	depends on OF_DYNAMIC && NOTIFIER_ERROR_INJECTION
+	help
+	  This option provides the ability to inject artificial errors to
+	  OF reconfig notifier chain callbacks.  It is controlled
+	  through debugfs interface under
+	  /sys/kernel/debug/notifier-error-inject/OF-reconfig/
 
-menu "$(SRCARCH) Debugging"
+	  If the notifier call chain should be failed with some events
+	  notified, write the error code to "actions/<notifier event>/error".
 
-source "arch/$(SRCARCH)/Kconfig.debug"
+	  To compile this code as a module, choose M here: the module will
+	  be called of-reconfig-notifier-error-inject.
 
-endmenu
+	  If unsure, say N.
+
+config NETDEV_NOTIFIER_ERROR_INJECT
+	tristate "Netdev notifier error injection module"
+	depends on NET && NOTIFIER_ERROR_INJECTION
+	help
+	  This option provides the ability to inject artificial errors to
+	  netdevice notifier chain callbacks.  It is controlled through debugfs
+	  interface /sys/kernel/debug/notifier-error-inject/netdev
+
+	  If the notifier call chain should be failed with some events
+	  notified, write the error code to "actions/<notifier event>/error".
+
+	  Example: Inject netdevice mtu change error (-22 = -EINVAL)
+
+	  # cd /sys/kernel/debug/notifier-error-inject/netdev
+	  # echo -22 > actions/NETDEV_CHANGEMTU/error
+	  # ip link set eth0 mtu 1024
+	  RTNETLINK answers: Invalid argument
+
+	  To compile this code as a module, choose M here: the module will
+	  be called netdev-notifier-error-inject.
+
+	  If unsure, say N.
+
+config FUNCTION_ERROR_INJECTION
+	def_bool y
+	depends on HAVE_FUNCTION_ERROR_INJECTION && KPROBES
+
+config FAULT_INJECTION
+	bool "Fault-injection framework"
+	depends on DEBUG_KERNEL
+	help
+	  Provide fault-injection framework.
+	  For more details, see Documentation/fault-injection/.
+
+config FAILSLAB
+	bool "Fault-injection capability for kmalloc"
+	depends on FAULT_INJECTION
+	depends on SLAB || SLUB
+	help
+	  Provide fault-injection capability for kmalloc.
+
+config FAIL_PAGE_ALLOC
+	bool "Fault-injection capabilitiy for alloc_pages()"
+	depends on FAULT_INJECTION
+	help
+	  Provide fault-injection capability for alloc_pages().
+
+config FAIL_MAKE_REQUEST
+	bool "Fault-injection capability for disk IO"
+	depends on FAULT_INJECTION && BLOCK
+	help
+	  Provide fault-injection capability for disk IO.
+
+config FAIL_IO_TIMEOUT
+	bool "Fault-injection capability for faking disk interrupts"
+	depends on FAULT_INJECTION && BLOCK
+	help
+	  Provide fault-injection capability on end IO handling. This
+	  will make the block layer "forget" an interrupt as configured,
+	  thus exercising the error handling.
+
+	  Only works with drivers that use the generic timeout handling,
+	  for others it wont do anything.
+
+config FAIL_FUTEX
+	bool "Fault-injection capability for futexes"
+	select DEBUG_FS
+	depends on FAULT_INJECTION && FUTEX
+	help
+	  Provide fault-injection capability for futexes.
+
+config FAULT_INJECTION_DEBUG_FS
+	bool "Debugfs entries for fault-injection capabilities"
+	depends on FAULT_INJECTION && SYSFS && DEBUG_FS
+	help
+	  Enable configuration of fault-injection capabilities via debugfs.
+
+config FAIL_FUNCTION
+	bool "Fault-injection capability for functions"
+	depends on FAULT_INJECTION_DEBUG_FS && FUNCTION_ERROR_INJECTION
+	help
+	  Provide function-based fault-injection capability.
+	  This will allow you to override a specific function with a return
+	  with given return value. As a result, function caller will see
+	  an error value and have to handle it. This is useful to test the
+	  error handling in various subsystems.
+
+config FAIL_MMC_REQUEST
+	bool "Fault-injection capability for MMC IO"
+	depends on FAULT_INJECTION_DEBUG_FS && MMC
+	help
+	  Provide fault-injection capability for MMC IO.
+	  This will make the mmc core return data errors. This is
+	  useful to test the error handling in the mmc block device
+	  and to test how the mmc host driver handles retries from
+	  the block device.
+
+config FAULT_INJECTION_STACKTRACE_FILTER
+	bool "stacktrace filter for fault-injection capabilities"
+	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
+	depends on !X86_64
+	select STACKTRACE
+	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86
+	help
+	  Provide stacktrace filter for fault-injection capabilities
+
+endmenu # "Kernel Testing and Coverage"
 
 endmenu # Kernel hacking
-- 
2.20.1

