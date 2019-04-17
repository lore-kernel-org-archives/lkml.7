Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD3CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD0421773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="xJME2M1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfDQUC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:02:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57237 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:02:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HK1KGf4055600
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 13:01:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HK1KGf4055600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555531282;
        bh=v970F83GTb2/HkuauTyH6ZUiaoaCioO1nf2EpqqnWDQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xJME2M1V7SZGzZdHEIHuyg075iow4HMGM5wug7QAZtYhgm3ZmgbXkXU4kTvBURXze
         YPg4IUNeMsiBFanuQPpdlU2+H+lzOeWbK5WQLXcx4na/3yxCnV0119IdDiJ9BEcHsF
         JIBs5VHSxB5UtuUim7sYO40B6BYuZWC1EawbmF6T+ujAiG1KSNM4BTSdqN297jhqFN
         gRlcUuDjmETxM4NMVu1je75EKcfk1Jv4aEKEkf3yMvBt0oRiboB1kh+BpEhPj+qMbI
         WNjliBwau6gGYlHR46nw67rp8TRb//vu+eZd9mGcLkWaaayEXA67DVMgwmZhKzM1gq
         xJkvCUm1iO6lA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HK1HmU4055593;
        Wed, 17 Apr 2019 13:01:17 -0700
Date:   Wed, 17 Apr 2019 13:01:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-98af8452945c55652de68536afdde3b520fec429@git.kernel.org>
Cc:     paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        jikos@kernel.org, luto@kernel.org, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        tyhicks@canonical.com, pauld@redhat.com, jkosina@suse.cz,
        peterz@infradead.org, heiko.carstens@de.ibm.com, jcm@redhat.com,
        torvalds@linux-foundation.org, jpoimboe@redhat.com,
        will.deacon@arm.com, longman@redhat.com, steven.price@arm.com,
        gregkh@linuxfoundation.org, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, tglx@linutronix.de, aarcange@redhat.com,
        catalin.marinas@arm.com
Reply-To: aarcange@redhat.com, catalin.marinas@arm.com, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, bp@alien8.de,
          longman@redhat.com, will.deacon@arm.com, steven.price@arm.com,
          gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
          jcm@redhat.com, heiko.carstens@de.ibm.com, jpoimboe@redhat.com,
          peterz@infradead.org, tyhicks@canonical.com, jkosina@suse.cz,
          pauld@redhat.com, luto@kernel.org, rdunlap@infradead.org,
          linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
          mpe@ellerman.id.au, paulus@samba.org, schwidefsky@de.ibm.com,
          jikos@kernel.org
In-Reply-To: <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
References: <b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/speculation] cpu/speculation: Add 'mitigations=' cmdline
 option
Git-Commit-ID: 98af8452945c55652de68536afdde3b520fec429
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  98af8452945c55652de68536afdde3b520fec429
Gitweb:     https://git.kernel.org/tip/98af8452945c55652de68536afdde3b520fec429
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Fri, 12 Apr 2019 15:39:28 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Apr 2019 21:37:28 +0200

cpu/speculation: Add 'mitigations=' cmdline option

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz> (on x86)
Reviewed-by: Jiri Kosina <jkosina@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jon Masters <jcm@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Price <steven.price@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/b07a8ef9b7c5055c3a4637c87d07c296d5016fe0.1555085500.git.jpoimboe@redhat.com

---
 Documentation/admin-guide/kernel-parameters.txt | 24 ++++++++++++++++++++++++
 include/linux/cpu.h                             | 24 ++++++++++++++++++++++++
 kernel/cpu.c                                    | 15 +++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9a15..720ffa9c4e04 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2513,6 +2513,30 @@
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
