Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88C6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7825521920
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665218;
	bh=tXIvQP7f9sWnvZ2CqU7cyI2q498MnIgv2v33J6cIotM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IYHjnJd8wHMcbyOjzqXi6KpB9F0dBiqiVDLZOsF9xa7Tu2/F3OidPMbEl18ZiAznF
	 x9jwJe7Km3LJT5EgrN+qpcxj1NSbsZ1D+uBRdrYe2LV/8YzmO04FylLrpHrf40pa+W
	 LEQHGLTRl0UrQRTAGOtZabGofmXymbO1X87fYve8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfJUNkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbfJUNkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD3220873;
        Mon, 21 Oct 2019 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665213;
        bh=tXIvQP7f9sWnvZ2CqU7cyI2q498MnIgv2v33J6cIotM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAN5AUWe8BkKR/JuAKs8UzHvKqsfjGQuTnJk0zgb6q+ld6lnVBXkel157NNr+LUJZ
         LBSoyiwcU4cm89hQPyCgmqbIkq61oqWFZMF7UnqcAq6gZAQJSbeVuUTBNDt+cws8YV
         /gNKAoCU6Mf1bjjK0yfffeUUPv6QlTiKjmA1soWg=
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
Subject: [PATCH 28/57] perf trace: Hook the 'vec' tracepoint argument with the x86 IRQ vectors scnprintf/strtoul
Date:   Mon, 21 Oct 2019 10:38:05 -0300
Message-Id: <20191021133834.25998-29-acme@kernel.org>
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
index 58bbe85d4166..e71605c99080 100644
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
-- 
2.21.0

