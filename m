Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8C8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1D320656
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfJVADe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:03:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfJVADe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:03:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxA-00044K-Eo; Tue, 22 Oct 2019 01:19:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F2CC41C0086;
        Tue, 22 Oct 2019 01:19:05 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:05 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libbeauty: Hook up the x86 irq_vectors table generator
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-0p2df4kq1afrxbck4e4ct34r@git.kernel.org>
References: <tip-0p2df4kq1afrxbck4e4ct34r@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994553.29376.6754649503560413293.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f19a85c68cb4d5bb90c587d9390e1ce2716d6160
Gitweb:        https://git.kernel.org/tip/f19a85c68cb4d5bb90c587d9390e1ce2716d6160
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 15 Oct 2019 15:48:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 15:48:50 -03:00

libbeauty: Hook up the x86 irq_vectors table generator

I.e. after running:

  $ make -C tools/perf O=/tmp/build/perf

We end up with:

  $ cat /tmp/build/perf/trace/beauty/generated/x86_arch_irq_vectors_array.c
  static const char *x86_irq_vectors[] = {
  	[0x02] = "NMI",
  	[0x12] = "MCE",
  	[0x20] = "IRQ_MOVE_CLEANUP",
  	[0x80] = "IA32_SYSCALL",
  	[0xec] = "LOCAL_TIMER",
  	[0xed] = "HYPERV_STIMER0",
  	[0xee] = "HYPERV_REENLIGHTENMENT",
  	[0xef] = "MANAGED_IRQ_SHUTDOWN",
  	[0xf0] = "POSTED_INTR_NESTED",
  	[0xf1] = "POSTED_INTR_WAKEUP",
  	[0xf2] = "POSTED_INTR",
  	[0xf3] = "HYPERVISOR_CALLBACK",
  	[0xf4] = "DEFERRED_ERROR",
  	[0xf6] = "IRQ_WORK",
  	[0xf7] = "X86_PLATFORM_IPI",
  	[0xf8] = "REBOOT",
  	[0xf9] = "THRESHOLD_APIC",
  	[0xfa] = "THERMAL_APIC",
  	[0xfb] = "CALL_FUNCTION_SINGLE",
  	[0xfc] = "CALL_FUNCTION",
  	[0xfd] = "RESCHEDULE",
  	[0xfe] = "ERROR_APIC",
  	[0xff] = "SPURIOUS_APIC",
  };
  $

Now its just a matter of using it, associating it to tracepoint arguments named
'vector', all of which can be correctly used with this table, for int args.

At some point we should move tools/perf/trace/beauty to tools/beauty/,
so that it can be used more generally and even made available externally
like libbpf, libperf, libtraceevent, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0p2df4kq1afrxbck4e4ct34r@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8f1ba98..1cd2944 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -546,6 +546,12 @@ x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 $(x86_arch_prctl_code_array): $(x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
 	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(x86_arch_asm_uapi_dir) > $@
 
+x86_arch_irq_vectors_array := $(beauty_outdir)/x86_arch_irq_vectors_array.c
+x86_arch_irq_vectors_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+
+$(x86_arch_irq_vectors_array): $(x86_arch_asm_dir)/irq_vectors.h $(x86_arch_irq_vectors_tbl)
+	$(Q)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(x86_arch_asm_dir) > $@
+
 x86_arch_MSRs_array := $(beauty_outdir)/x86_arch_MSRs_array.c
 x86_arch_MSRs_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_msr.sh
 
@@ -686,6 +692,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
 	$(usbdevfs_ioctl_array) \
+	$(x86_arch_irq_vectors_array) \
 	$(x86_arch_MSRs_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
@@ -991,6 +998,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
 		$(OUTPUT)$(usbdevfs_ioctl_array) \
+		$(OUTPUT)$(x86_arch_irq_vectors_array) \
 		$(OUTPUT)$(x86_arch_MSRs_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
