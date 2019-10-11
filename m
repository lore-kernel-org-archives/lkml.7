Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85019ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5486C21D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824542;
	bh=k+sGVGWSn+UbNBmmbjQryUAEWTxwX2hUl0c/+PK71aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bn3CMKJkrvAKMx8AlW4FFDzb5Sc9qrbdlsDlAk7AbnBvUR+9lUxckNuy4NyYVSm6Q
	 8REvcci76tGvhpbi4r7VIv5201cwLuaO5Nv241/IZzbBylBTg1ejavRCOWJuNVrjQ/
	 89bGsnjc5obyTuWvhALxik77JsnBn2eA/ZvcolP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfJKUJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:00 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A509421D71;
        Fri, 11 Oct 2019 20:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824539;
        bh=k+sGVGWSn+UbNBmmbjQryUAEWTxwX2hUl0c/+PK71aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDL83cmDO9NrS42ZQU8590g9QrbqEf9Ge2VG4a9mr5bNhHcD8NQFagwWg3RCNsM7j
         +cTJz0fZK/2P9TY3FVlsdQh9/oKmZjjr+qqtQuvNexvAYbEctk08KkndUOPdsrQ3VY
         YQgzzt2bY0ncfvQz0lFS6Qw9tskq3djmsGo9h6JU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 28/69] perf beauty: Hook up the x86 MSR table generator
Date:   Fri, 11 Oct 2019 17:05:18 -0300
Message-Id: <20191011200559.7156-29-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/Makefile.perf | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 902c792f326a..45c14dc24f4b 100644
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
-- 
2.21.0

