Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF34C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02A821925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbfJOFcS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42095 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfJOFcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR9-0000K3-Go; Tue, 15 Oct 2019 07:31:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A18951C04D0;
        Tue, 15 Oct 2019 07:31:45 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf beauty: Hook up the x86 MSR table generator
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-b3rmutg4igcohx6kpo67qh4j@git.kernel.org>
References: <tip-b3rmutg4igcohx6kpo67qh4j@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750551.12254.1187486778237278829.tip-bot2@tip-bot2>
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

Commit-ID:     fd21834704a678a583cf294aea47c7ed3fd9d8d2
Gitweb:        https://git.kernel.org/tip/fd21834704a678a583cf294aea47c7ed3fd9d8d2
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 26 Sep 2019 15:47:16 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf beauty: Hook up the x86 MSR table generator

This way we generate the source with the table for later use by plugins,
etc.

I.e. after running:

  $ make -C tools/perf O=/tmp/build/perf

We end up with:

  $ head /tmp/build/perf/trace/beauty/generated/x86_arch_MSRs_array.c
  static const char *x86_MSRs[] = {
  	[0x00000000] = "IA32_P5_MC_ADDR",
  	[0x00000001] = "IA32_P5_MC_TYPE",
  	[0x00000010] = "IA32_TSC",
  	[0x00000017] = "IA32_PLATFORM_ID",
  	[0x0000001b] = "IA32_APICBASE",
  	[0x00000020] = "KNC_PERFCTR0",
  	[0x00000021] = "KNC_PERFCTR1",
  	[0x00000028] = "KNC_EVNTSEL0",
  	[0x00000029] = "KNC_EVNTSEL1",
  $

Now its just a matter of using it, first in a libtracevent plugin.

At some point we should move tools/perf/trace/beauty to tools/beauty/,
so that it can be used more generally and even made available externally
like libbpf, libperf, libtraevent, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b3rmutg4igcohx6kpo67qh4j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 902c792..45c14dc 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -407,6 +407,7 @@ linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
 arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
 x86_arch_asm_uapi_dir := $(srctree)/tools/arch/x86/include/uapi/asm/
+x86_arch_asm_dir := $(srctree)/tools/arch/x86/include/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
@@ -543,6 +544,12 @@ x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
 $(x86_arch_prctl_code_array): $(x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
 	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(x86_arch_asm_uapi_dir) > $@
 
+x86_arch_MSRs_array := $(beauty_outdir)/x86_arch_MSRs_array.c
+x86_arch_MSRs_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_msr.sh
+
+$(x86_arch_MSRs_array): $(x86_arch_asm_dir)/msr-index.h $(x86_arch_MSRs_tbl)
+	$(Q)$(SHELL) '$(x86_arch_MSRs_tbl)' $(x86_arch_asm_dir) > $@
+
 rename_flags_array := $(beauty_outdir)/rename_flags_array.c
 rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
 
@@ -677,6 +684,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
 	$(usbdevfs_ioctl_array) \
+	$(x86_arch_MSRs_array) \
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array) \
@@ -981,6 +989,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(perf_ioctl_array) \
 		$(OUTPUT)$(prctl_option_array) \
 		$(OUTPUT)$(usbdevfs_ioctl_array) \
+		$(OUTPUT)$(x86_arch_MSRs_array) \
 		$(OUTPUT)$(x86_arch_prctl_code_array) \
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array) \
