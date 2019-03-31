Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B2CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AA52070B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfCaKmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:42:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57207 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfCaKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:42:21 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAXus-0005Xq-SP; Sun, 31 Mar 2019 12:42:19 +0200
Date:   Sun, 31 Mar 2019 10:39:43 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core updates for 5.1
Message-ID: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

up to:  7dd476171149 ("watchdog: Respect watchdog cpumask on CPU hotplug")

A small set of core updates:

 - Make the watchdog respect the selected CPU mask again. That was broken
   by the rework of the watchdog thread management and caused inconsistent
   state and NMI watchdog being unstoppable.

 - Ensure that the objtool build can find the libelf location.

 - Remove dead kcore stub code

Thanks,

	tglx

------------------>
Bhupesh Sharma (1):
      proc/kcore: Remove unused kclist_add_remap()

Rolf Eike Beer (1):
      objtool: Query pkg-config for libelf location

Thomas Gleixner (1):
      watchdog: Respect watchdog cpumask on CPU hotplug


 Makefile               |  4 +++-
 include/linux/kcore.h  | 11 -----------
 kernel/watchdog.c      |  6 ++++--
 tools/objtool/Makefile |  7 +++++--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index c0a34064c574..eef3d3f87c3b 100644
--- a/Makefile
+++ b/Makefile
@@ -950,9 +950,11 @@ mod_sign_cmd = true
 endif
 export mod_sign_cmd
 
+HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
+
 ifdef CONFIG_STACK_VALIDATION
   has_libelf := $(call try-run,\
-		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null -lelf -,1,0)
+		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
   ifeq ($(has_libelf),1)
     objtool_target := tools/objtool FORCE
   else
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index c843f4a9c512..da676cdbd727 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -38,12 +38,6 @@ struct vmcoredd_node {
 
 #ifdef CONFIG_PROC_KCORE
 void __init kclist_add(struct kcore_list *, void *, size_t, int type);
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-	m->vaddr = (unsigned long)vaddr;
-	kclist_add(m, addr, sz, KCORE_REMAP);
-}
 
 extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
 #else
@@ -51,11 +45,6 @@ static inline
 void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
 {
 }
-
-static inline
-void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
-{
-}
 #endif
 
 #endif /* _LINUX_KCORE_H */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 403c9bd90413..6a5787233113 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -554,13 +554,15 @@ static void softlockup_start_all(void)
 
 int lockup_detector_online_cpu(unsigned int cpu)
 {
-	watchdog_enable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_enable(cpu);
 	return 0;
 }
 
 int lockup_detector_offline_cpu(unsigned int cpu)
 {
-	watchdog_disable(cpu);
+	if (cpumask_test_cpu(cpu, &watchdog_allowed_mask))
+		watchdog_disable(cpu);
 	return 0;
 }
 
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index c9d038f91af6..53f8be0f4a1f 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -25,14 +25,17 @@ LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
 OBJTOOL    := $(OUTPUT)objtool
 OBJTOOL_IN := $(OBJTOOL)-in.o
 
+LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
+
 all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES)
-LDFLAGS  += -lelf $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
 elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)

