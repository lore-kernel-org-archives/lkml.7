Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA70C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C121D205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557129821;
	bh=SAM3Ec8r2ucy3VrPhwPp5DND+cnFEYQMG3eCZS1fD00=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ut71RHANntbQCA01ib4pCezcDxGewcRrdZ9TPuXS6m57KwwTRhR022FF4Mbs/pMeR
	 ov2Te9T8Qo4C1CyYxtCERNa6nNKsRU6R529oS7YwJ33WDmM7qKQQ1EOMaF2WtmPa0n
	 wf9Iydm0RwUZwmPiec2OwL61jJtC9a07Oa329+B4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfEFIDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:03:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39739 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:03:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so13928258wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mythwgyp9uKwDaitwCFjuF2GlQTCobW4jv/aJncEGNA=;
        b=PAuD8MFh0PQrg9WHBmaPDe2K56S119i1yMiu8SuWer/9oExaLyVKpU3b/BXhTYCXk0
         jQ8ikxVk0HRouufMVdkoxFV0CUPOBkO5biVwoxQjAU7Mv3mi6DyH0VN5LXBalNB44HCz
         QyKiXCDsPxoMynt/DRbBxZRB7IDOiz/DgthWPvgZCXmOMYXsOwXamWFN43LLYRHETwaO
         rOD1ohgdYROvfzHBSAL4aGb4xd62Y5Q8LmotLHAgfyH976fF9snzI5o3InIJtbSxBqPx
         2onN71s3WpW085A9ltp4Vm9NBdK0KdnNhQm+kk8NDJcdT9ZB+IsReo6WEn3x/vZQDd40
         liGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Mythwgyp9uKwDaitwCFjuF2GlQTCobW4jv/aJncEGNA=;
        b=JUGGz1ooTfnzF+PtIbrb+2yU/0JncNwhtJmhRBZJli8szU+9i7zRlYr6Z6MoD5L6st
         9BlAiu/inSxraq7UY9EOelTTbFZSth8Gz9/PWkuZUbiG9QXHON4FolW2glw1O26FAP6N
         aBDYX6MN3UYAEA+FqjfAkqtvFxMCKnUD1t9xkmjv8YOWoVeWnUAUJY8fNfQbEAyFEWG+
         otLhgCc1QcXenrORQN7kdGEGWUPGIsT13HUl9IVI+n+q7lRIJ1z7PH4LluZO7mQqKwcK
         F3UaOCz1YLEx0R6aH4gSGR9dwnsOFP1pBidVNoUY5ImTxT7mfj3VrznE4CwSdsFDq6y0
         nMAQ==
X-Gm-Message-State: APjAAAWxBA6pyrtu+SDK58lCDsuGEmp3jyViX7gtGKMJFcMcXFfSP2Im
        rTYwyuGWunTMNxA0xr2d/YU=
X-Google-Smtp-Source: APXvYqy32Y55HDROw72wHbzHSPUG9Tqx1fdugLt07a9sbPNR6ze+Oyqrvp1YaUGNzQFQFVHmRTHv+g==
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr817754wmz.92.1557129818276;
        Mon, 06 May 2019 01:03:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r64sm3531765wmr.0.2019.05.06.01.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 01:03:37 -0700 (PDT)
Date:   Mon, 6 May 2019 10:03:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] core/speculation updates for v5.2
Message-ID: <20190506080335.GA25701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-speculation-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-speculation-for-linus

   # HEAD: 0336e04a6520bdaefdb0769d2a70084fa52e81ed s390/speculation: Support 'mitigations=' cmdline option

This adds the "mitigations=" bootline option, which offers a cross-arch 
set of options that will work on x86, PowerPC and s390 that will map to 
the arch specific option internally.

 Thanks,

	Ingo

------------------>
Josh Poimboeuf (4):
      cpu/speculation: Add 'mitigations=' cmdline option
      x86/speculation: Support 'mitigations=' cmdline option
      powerpc/speculation: Support 'mitigations=' cmdline option
      s390/speculation: Support 'mitigations=' cmdline option


 Documentation/admin-guide/kernel-parameters.txt | 32 +++++++++++++++++++++++++
 arch/powerpc/kernel/security.c                  |  6 ++---
 arch/powerpc/kernel/setup_64.c                  |  2 +-
 arch/s390/kernel/nospec-branch.c                |  3 ++-
 arch/x86/kernel/cpu/bugs.c                      | 11 +++++++--
 arch/x86/mm/pti.c                               |  4 +++-
 include/linux/cpu.h                             | 24 +++++++++++++++++++
 kernel/cpu.c                                    | 15 ++++++++++++
 8 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9a15..1ae93872b79f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2513,6 +2513,38 @@
 			in the "bleeding edge" mini2440 support kernel at
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
+	mitigations=
+			[X86,PPC,S390] Control optional mitigations for CPU
+			vulnerabilities.  This is a set of curated,
+			arch-independent options, each of which is an
+			aggregation of existing arch-specific options.
+
+			off
+				Disable all optional CPU mitigations.  This
+				improves system performance, but it may also
+				expose users to several CPU vulnerabilities.
+				Equivalent to: nopti [X86,PPC]
+					       nospectre_v1 [PPC]
+					       nobp=0 [S390]
+					       nospectre_v2 [X86,PPC,S390]
+					       spectre_v2_user=off [X86]
+					       spec_store_bypass_disable=off [X86,PPC]
+					       l1tf=off [X86]
+
+			auto (default)
+				Mitigate all CPU vulnerabilities, but leave SMT
+				enabled, even if it's vulnerable.  This is for
+				users who don't want to be surprised by SMT
+				getting disabled across kernel upgrades, or who
+				have other ways of avoiding SMT-based attacks.
+				Equivalent to: (default behavior)
+
+			auto,nosmt
+				Mitigate all CPU vulnerabilities, disabling SMT
+				if needed.  This is for users who always want to
+				be fully mitigated, even if it means losing SMT.
+				Equivalent to: l1tf=flush,nosmt [X86]
+
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 9b8631533e02..cdf3e73000e9 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -57,7 +57,7 @@ void setup_barrier_nospec(void)
 	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
 		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
 
-	if (!no_nospec)
+	if (!no_nospec && !cpu_mitigations_off())
 		enable_barrier_nospec(enable);
 }
 
@@ -116,7 +116,7 @@ static int __init handle_nospectre_v2(char *p)
 early_param("nospectre_v2", handle_nospectre_v2);
 void setup_spectre_v2(void)
 {
-	if (no_spectrev2)
+	if (no_spectrev2 || cpu_mitigations_off())
 		do_btb_flush_fixups();
 	else
 		btb_flush_enabled = true;
@@ -307,7 +307,7 @@ void setup_stf_barrier(void)
 
 	stf_enabled_flush_types = type;
 
-	if (!no_stf_barrier)
+	if (!no_stf_barrier && !cpu_mitigations_off())
 		stf_barrier_enable(enable);
 }
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 236c1151a3a7..c7ec27ba8926 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -958,7 +958,7 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 
 	enabled_flush_types = types;
 
-	if (!no_rfi_flush)
+	if (!no_rfi_flush && !cpu_mitigations_off())
 		rfi_flush_enable(enable);
 }
 
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index bdddaae96559..649135cbedd5 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
 #include <asm/nospec-branch.h>
 
 static int __init nobp_setup_early(char *str)
@@ -58,7 +59,7 @@ early_param("nospectre_v2", nospectre_v2_setup_early);
 
 void __init nospec_auto_detect(void)
 {
-	if (test_facility(156)) {
+	if (test_facility(156) || cpu_mitigations_off()) {
 		/*
 		 * The machine supports etokens.
 		 * Disable expolines and disable nobp.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 01874d54f4fd..435c078c2948 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -440,7 +440,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
+	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
@@ -672,7 +673,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	char arg[20];
 	int ret, i;
 
-	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable")) {
+	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
+	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
 	} else {
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
@@ -996,6 +998,11 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
 
+	if (cpu_mitigations_off())
+		l1tf_mitigation = L1TF_MITIGATION_OFF;
+	else if (cpu_mitigations_auto_nosmt())
+		l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+
 	override_cache_bits(&boot_cpu_data);
 
 	switch (l1tf_mitigation) {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4fee5c3003ed..5890f09bfc19 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/cpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/hypervisor.h>
@@ -115,7 +116,8 @@ void __init pti_check_boottime_disable(void)
 		}
 	}
 
-	if (cmdline_find_option_bool(boot_command_line, "nopti")) {
+	if (cmdline_find_option_bool(boot_command_line, "nopti") ||
+	    cpu_mitigations_off()) {
 		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..2d9c6f4b78f5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -187,4 +187,28 @@ static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
+/*
+ * These are used for a global "mitigations=" cmdline option for toggling
+ * optional CPU mitigations.
+ */
+enum cpu_mitigations {
+	CPU_MITIGATIONS_OFF,
+	CPU_MITIGATIONS_AUTO,
+	CPU_MITIGATIONS_AUTO_NOSMT,
+};
+
+extern enum cpu_mitigations cpu_mitigations;
+
+/* mitigations=off */
+static inline bool cpu_mitigations_off(void)
+{
+	return cpu_mitigations == CPU_MITIGATIONS_OFF;
+}
+
+/* mitigations=auto,nosmt */
+static inline bool cpu_mitigations_auto_nosmt(void)
+{
+	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
+}
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d1c6d152da89..e70a90634b41 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2279,3 +2279,18 @@ void __init boot_cpu_hotplug_init(void)
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
+
+enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
+
+static int __init mitigations_parse_cmdline(char *arg)
+{
+	if (!strcmp(arg, "off"))
+		cpu_mitigations = CPU_MITIGATIONS_OFF;
+	else if (!strcmp(arg, "auto"))
+		cpu_mitigations = CPU_MITIGATIONS_AUTO;
+	else if (!strcmp(arg, "auto,nosmt"))
+		cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
+
+	return 0;
+}
+early_param("mitigations", mitigations_parse_cmdline);
