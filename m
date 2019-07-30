Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FDFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690D2216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455393;
	bh=Ezw+UMUmg3Om7hrNEtww2I7/feRKEH+8XEKfOkyGE78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Er8YpovCokN0eAaRrDKimMQv8knLgYjpSF7Cs1Lp/u7D3uQ21X0HcI2Qf7gjmc8O
	 TBJFj9S/jw8dPHhre2yrK4EK7/FriwBOQfuvMFWlV8+ZF4Cpdfwtxyw/F5n+plw99/
	 2ncrXNvFVwV3+Bc7xFyMneY2bZurcRfqU+0Wurmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfG3C4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731536AbfG3C41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:56:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D2692070B;
        Tue, 30 Jul 2019 02:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455386;
        bh=Ezw+UMUmg3Om7hrNEtww2I7/feRKEH+8XEKfOkyGE78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QG+lzWwdW2sZHXvFjOPrpCiM+GyRi6ka4WVBNCUHlieFcXq4pLs6kwr/YqAuLLUQo
         kAz5I2Yft9xnIBZVowwmb0wDlWbhNGygEfu7//Ab96/Hq/gg8Qkqn3zNro7NTp8Gj9
         jIBK8TzhU0yCr8/5wSoA/viNdSwMO6dI/+BUtgd4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 002/107] perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !
Date:   Mon, 29 Jul 2019 23:54:25 -0300
Message-Id: <20190730025610.22603-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With BPF_MAP_TYPE_PROG_ARRAY + bpf_tail_call() we want to have BPF
programs, i.e. functions in a object file that perf's BPF loader
shouldn't try to attach to anything, i.e. "!syscalls:sys_enter_open"
should just stay there, not be attached to a tracepoint with that name,
it'll be used by, for instance, 'perf trace' to associate with syscalls
that copy, in addition to the syscall raw args, a filename pointed by
the first arg, i.e. multiple syscalls that need copying the same pointer
arg in the same way, as a filename, for instance, will share the same
BPF program/function.

Right now when perf's BPF loader sees a function with a name
"sys:name" it'll look for a tracepoint and will associate that BPF
program with it, say:

  SEC("raw_syscalls:sys_enter")
  int sys_enter(struct syscall_enter_args *args)
  {
     //SNIP
  }

Will crate a perf_evsel tracepoint event and then associate with it that
BPF program.

This convention at some point will switch to the one used by the BPF
loader in libbpf, but to experiment with BPF_MAP_TYPE_PROG_ARRAY in
'perf trace' lets do this, that will not require changing too much
stuff.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lk6dasjr1yf9rtvl292b2hpc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 371ff3aee769..fac6b32ef94a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -639,6 +639,15 @@ static int add_bpf_event(const char *group, const char *event, int fd,
 	struct list_head *list = param->list;
 	struct perf_evsel *pos;
 	int err;
+	/*
+	 * Check if we should add the event, i.e. if it is a TP but starts with a '!',
+	 * then don't add the tracepoint, this will be used for something else, like
+	 * adding to a BPF_MAP_TYPE_PROG_ARRAY.
+	 *
+	 * See tools/perf/examples/bpf/augmented_raw_syscalls.c
+	 */
+	if (group[0] == '!')
+		return 0;
 
 	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
 		 group, event, fd);
-- 
2.21.0

