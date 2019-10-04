Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0C6C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF09620865
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7q0hzLT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfJDBUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37288 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfJDBUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id p14so4001064wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Ssb5BoGD2tFFLgD5N+BkgLbfgGu33iBCWXu+H3lWj4=;
        b=X7q0hzLTV0Y4JogLbcNpXW5LQfhBj0N0ZHrm0bc2BcO9IbwFpJdH3PaPftbEikxXPo
         GUL8pxSKxcg8UmhtAHsS5N9BTifkOSV0W16Ib63GPfV4AoWs949ufat2XXhzZSrImPhk
         K26Ql+zK6vUs28/kR73lNTebYF9QI6bQd7lQ/TGgzJwKXHhqPvQqRSQCltuIKM9WZSJ5
         9EVvXYVXHeEs9msoAwGkA1APRMGjQxNSuNsZ2khMoxprDqxyTeqCbjrI4NRi2Ejw6Eer
         xK1UvU77denXFptsjo1V5xvuIwExBYaCw3m+Npp5ge5Hoo5AVWCi6aKxI5I3mLPVZsan
         ww4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Ssb5BoGD2tFFLgD5N+BkgLbfgGu33iBCWXu+H3lWj4=;
        b=B6tB4iyj4BTydO2a8tjAK1kyX9jC2sgyrkjVFlCdnDpZa/HIYnrBbh4giFEgzDaUvr
         j24AFoB8Aq/rhhhpULCT3+4F6rEEEBZZsKWT41RD2mwLzPq/Xhb5GaiRq0eLlHUFtIuP
         mrTAbEdNeelbQjs5A4htKEbjeGw6tCzjau7NQfLEw9GNmOD4bcKGEJlYCwJ8qU3yp1Bx
         dlNQFEI/dcYJFY1laxgNav6qsV3cRjQuHrHxUzT1P7w7Xo8D6r3+5s7T8WsilGom5taw
         p1v6jSPUdzvIq4PJ4/nwlvP1ZTVkjB09o0IqlSooiXgRngl3U3eeD8kMGFob+pLcMxAl
         urMg==
X-Gm-Message-State: APjAAAXnv6EoGUjiUPtNSQWbkmfk4Th0BHsRYQSLouJhmsVqfADq5k00
        nwT2eXDXXHPzDSaunXUJoqiUv/8udNSuLQ==
X-Google-Smtp-Source: APXvYqxhxFitm+jfiB57U9bmeoNH9XQz6ZuzEcr9M6cOUet9DFTzX+yPAqC1ANPW6n8/dX1SDxA1wA==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr8907165wrv.162.1570152041010;
        Thu, 03 Oct 2019 18:20:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 4/9] hacking: Move kernel testing and coverage options to same submenu
Date:   Fri,  4 Oct 2019 09:20:05 +0800
Message-Id: <20191004012010.11287-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move error injection, coverage, testing, kunit options to a new submenu
'Kernel Testing and Coverage'. They are all for test purpose.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 499 +++++++++++++++++++++++-----------------------
 1 file changed, 252 insertions(+), 247 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f1de5e79573b..9911e5c6eafa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -766,53 +766,6 @@ source "lib/Kconfig.kasan"
 
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
@@ -1482,164 +1435,6 @@ config CPU_HOTPLUG_STATE_CONTROL
 
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
@@ -1686,7 +1481,108 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 	  See Documentation/debugging-via-ohci1394.txt for more information.
 
-source "lib/kunit/Kconfig"
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
 
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
@@ -2105,57 +2001,166 @@ config MEMTEST
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
+source "lib/kunit/Kconfig"
+
+endmenu # "Kernel Testing and Coverage"
 
 endmenu # Kernel hacking
-- 
2.20.1

