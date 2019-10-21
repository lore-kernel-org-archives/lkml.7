Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7106CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A986721872
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665208;
	bh=U59Hnif32lFO1qfBO+vOtfzRZCqfAhNhH8wWqgFnhi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fhccZnhY0KvhLDBE7sR3pbUsAUUJgjaByHc0UZCxcTSKBUiLmVCXr9j6QGKBe+/Kl
	 aSrgwQ2b/C7xOu9ao/sJiRwRhIyNAIunmT8I3pYayU0ri8M9GTyUQoRxVzRecAD6gB
	 cKy47dboFfi2YmkN1ycveMu+d3flTfMXqOvxsLRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfJUNkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbfJUNkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DCF2173B;
        Mon, 21 Oct 2019 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665204;
        bh=U59Hnif32lFO1qfBO+vOtfzRZCqfAhNhH8wWqgFnhi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uorZoixhitJMKGVbQam9x7anFdteyYAmBXUiTmgvtAxlFt2LUs76dcjGuWgmNZMVX
         ujKulY1b0XfC/dgXusl0FQyGk7Zp0Wm/R6ZTktvOPOgOXyeUXkE748mGxEs6AqjWd2
         Q1CTxms3eXB5np0LR4Q5ittg6e7bKkTKglRnewxY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 25/57] libbeauty: Hook up the x86 irq_vectors table generator
Date:   Mon, 21 Oct 2019 10:38:02 -0300
Message-Id: <20191021133834.25998-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 8f1ba986d3bf..1cd294468a1f 100644
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
-- 
2.21.0

