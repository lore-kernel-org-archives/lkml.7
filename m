Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC2C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450242171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfDLUjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDLUju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:39:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3406C0005DA;
        Fri, 12 Apr 2019 20:39:49 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB75600C5;
        Fri, 12 Apr 2019 20:39:47 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v2 1/5] cpu/speculation: Add 'mitigations=' cmdline option
Date:   Fri, 12 Apr 2019 15:39:28 -0500
Message-Id: <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Apr 2019 20:39:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
have its own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- mitigations=off: Disable all mitigations.

- mitigations=auto: [default] Enable all the default mitigations, but
  leave SMT enabled, even if it's vulnerable.

- mitigations=auto,nosmt: Enable all the default mitigations, disabling
  SMT if needed by a mitigation.

Currently, these options are placeholders which don't actually do
anything.  They will be fleshed out in upcoming patches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 24 +++++++++++++++++++
 include/linux/cpu.h                           | 24 +++++++++++++++++++
 kernel/cpu.c                                  | 15 ++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index faafdc59104a..3ea92e075c64 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2544,6 +2544,30 @@
 			in the "bleeding edge" mini2440 support kernel at
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
+	mitigations=
+			Control optional mitigations for CPU vulnerabilities.
+			This is a set of curated, arch-independent options, each
+			of which is an aggregation of existing arch-specific
+			options.
+
+			off
+				Disable all optional CPU mitigations.  This
+				improves system performance, but it may also
+				expose users to several CPU vulnerabilities.
+
+			auto (default)
+				Mitigate all CPU vulnerabilities, but leave SMT
+				enabled, even if it's vulnerable.  This is for
+				users who don't want to be surprised by SMT
+				getting disabled across kernel upgrades, or who
+				have other ways of avoiding SMT-based attacks.
+				This is the default behavior.
+
+			auto,nosmt
+				Mitigate all CPU vulnerabilities, disabling SMT
+				if needed.  This is for users who always want to
+				be fully mitigated, even if it means losing SMT.
+
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index ae99dde02320..5350357dfbdb 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -188,4 +188,28 @@ static inline void cpu_smt_disable(bool force) { }
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
index 38890f62f9a8..aed9083f8eac 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2320,3 +2320,18 @@ void __init boot_cpu_hotplug_init(void)
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
+
+enum cpu_mitigations cpu_mitigations __ro_after_init = CPU_MITIGATIONS_AUTO;
+
+static int __init mitigations_cmdline(char *arg)
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
+early_param("mitigations", mitigations_cmdline);
-- 
2.17.2

