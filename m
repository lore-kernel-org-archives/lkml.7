Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8A5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A40520656
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfJVAE4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbfJVAEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx7-000436-UD; Tue, 22 Oct 2019 01:19:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3730C1C04D3;
        Tue, 22 Oct 2019 01:19:04 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:03 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Hook the 'vec' tracepoint argument with
 the x86 IRQ vectors scnprintf/strtoul
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-wer4cwbbqub3o7sa8h1j3uzb@git.kernel.org>
References: <tip-wer4cwbbqub3o7sa8h1j3uzb@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169994385.29376.7726590102304461873.tip-bot2@tip-bot2>
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

Commit-ID:     df604bfda6f550f088e1cffcd098bfec0eee9cdf
Gitweb:        https://git.kernel.org/tip/df604bfda6f550f088e1cffcd098bfec0eee9cdf
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 15 Oct 2019 16:50:13 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 16:50:13 -03:00

perf trace: Hook the 'vec' tracepoint argument with the x86 IRQ vectors scnprintf/strtoul

Ended up only being useful when filtering multiple irq_vectors
tracepoints, as we end up having a tracepoint for each of the entries,
i.e.:

This will always come with the "RESCHEDULE_VECTOR" in the 'vector' arg:

  # perf trace --max-events 8 -e irq_vectors:reschedule*
     0.000 cc1/29067 irq_vectors:reschedule_entry(vector: RESCHEDULE)
     0.004 cc1/29067 irq_vectors:reschedule_exit(vector: RESCHEDULE)
     0.553 cc1/29067 irq_vectors:reschedule_entry(vector: RESCHEDULE)
     0.556 cc1/29067 irq_vectors:reschedule_exit(vector: RESCHEDULE)
     1.182 cc1/29067 irq_vectors:reschedule_entry(vector: RESCHEDULE)
     1.185 cc1/29067 irq_vectors:reschedule_exit(vector: RESCHEDULE)
     1.203 :29052/29052 irq_vectors:reschedule_entry(vector: RESCHEDULE)
     1.206 :29052/29052 irq_vectors:reschedule_exit(vector: RESCHEDULE)
  #

While filtering that value will produce nothing:

  # perf trace --max-events 8 -e irq_vectors:reschedule* --filter="vector != RESCHEDULE"
  ^C#

Maybe it'll be useful for those other tracepoints:

  # perf list irq_vectors:vector_*

  List of pre-defined events (to be used in -e):

    irq_vectors:vector_activate                        [Tracepoint event]
    irq_vectors:vector_alloc                           [Tracepoint event]
    irq_vectors:vector_alloc_managed                   [Tracepoint event]
    irq_vectors:vector_clear                           [Tracepoint event]
    irq_vectors:vector_config                          [Tracepoint event]
    irq_vectors:vector_deactivate                      [Tracepoint event]
    irq_vectors:vector_free_moved                      [Tracepoint event]
    irq_vectors:vector_reserve                         [Tracepoint event]
    irq_vectors:vector_reserve_managed                 [Tracepoint event]
    irq_vectors:vector_setup                           [Tracepoint event]
    irq_vectors:vector_teardown                        [Tracepoint event]
    irq_vectors:vector_update                          [Tracepoint event]
  #

But since we have it done, keep it.

This at least served to teach me that all those irq vectors have a entry
and an exit tracepoint that I can then use just like with
raw_syscalls:sys_{enter,exit}, i.e. pair them, use just a
trace__irq_vectors_entry() + trace__irq_vectors_exit() and use the
'vector' arg as I use the 'syscall id' one for syscalls.

Then the default for 'perf trace' will include irq_vectors in addition
to syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wer4cwbbqub3o7sa8h1j3uzb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 58bbe85..e71605c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1528,7 +1528,8 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
-	{ .name = "msr", .scnprintf = SCA_X86_MSR, .strtoul = STUL_X86_MSR, }
+	{ .name = "msr",	.scnprintf = SCA_X86_MSR,	  .strtoul = STUL_X86_MSR,	   },
+	{ .name = "vector",	.scnprintf = SCA_X86_IRQ_VECTORS, .strtoul = STUL_X86_IRQ_VECTORS, },
 };
 
 static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
