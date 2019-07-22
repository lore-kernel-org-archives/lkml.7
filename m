Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4845DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215CA21903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817153;
	bh=Ezw+UMUmg3Om7hrNEtww2I7/feRKEH+8XEKfOkyGE78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xx98aFhxqNL6zOe5MJyExc9tDyMUTWOtSJc0qiIeBCRLo8ga6eBqqIJhDprgO5nwh
	 stF1QTrxcV4pf0SwAV6cambO5g8tZFu64Tc/iqD5wjQ5pgZIb+16x14spnuql61mH6
	 cjCnlTGLNNJpttCq5o18NEvz3wcsyz7HHgM3wVYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfGVRjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728860AbfGVRjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:11 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C769D21901;
        Mon, 22 Jul 2019 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817150;
        bh=Ezw+UMUmg3Om7hrNEtww2I7/feRKEH+8XEKfOkyGE78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBDIe9Q0qGyVZYxgAEDaHnEUGzCyJHdgmoVfpA0cKWOEDvwlhp8BVi/oaaWbiCWM6
         eB3DwIL4nD1MsIL9jacKKh7f39u0N5/IYLCLCoh3E5SMkjl1zDDTL22Q8bHmwiAhIn
         c3j4IY6QpwfcSWd2uN0PQ7jo2WZNHG48dFx6t3i0=
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
Subject: [PATCH 02/37] perf bpf: Do not attach a BPF prog to a tracepoint if its name starts with !
Date:   Mon, 22 Jul 2019 14:38:04 -0300
Message-Id: <20190722173839.22898-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
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

