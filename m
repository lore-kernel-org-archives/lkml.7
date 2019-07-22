Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF9C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439DA21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817363;
	bh=ztkQhES8y8Wsn/jFHs6qGtQ40+i1S1sj0jybWitA1Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=te4z8jsDpGHm7ZrXfkHMRmEVaihBb5gkYD+zvEVGXQcgFyujqDrxWm9QxU3GSPdDx
	 YAREW4FbvjZ2jVK/q38i3G8uPtIsILVr3+u9p+Bc124Ut+peA20PyOMHBCAAFbb5qA
	 6bTC7FdCNGsbwbvrC2n36owlLON3hGNYoetopOIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfGVRml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730715AbfGVRmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:40 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 447F721901;
        Mon, 22 Jul 2019 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817358;
        bh=ztkQhES8y8Wsn/jFHs6qGtQ40+i1S1sj0jybWitA1Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvHGwMBZPZAIE6SNBfPtMSPQVEb37qV4b2mcj+Fj/LvRoYs0anp1wlI4UEJ8GCqMy
         8Phuf8ma7alfWy+80lJzzUDRGBMcAqPP9AnQN0FX/tIyMtoJWOSmrEHGVRRaiUIzHy
         +JmFeK+FLx9Xd4WerPSeL5eKG+nnUn/pYivZyczI=
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
Subject: [PATCH 33/37] perf trace: Reuse BPF augmenters from syscalls with similar args signature
Date:   Mon, 22 Jul 2019 14:38:35 -0300
Message-Id: <20190722173839.22898-34-acme@kernel.org>
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

We have an augmenter for the "open" syscall, which has just one pointer,
in the first argument, a "const char *", so any other syscall that has
just one pointer and that is the first can reuse the "open" BPF
augmenter program.

Even more, syscalls that get two pointers with the first being a string
can reuse "open"'s BPF augmenter till we have an augmenter that better
matches that syscall with two pointers.

With this the few augmenters we have, for open (first arg is a string),
openat (2nd arg is a string), renameat (2nd and 4th are strings) can be
reused by a lot of syscalls, ditto for "bind" reusing "connect" because
both have the 2nd argument as a sockaddr and the 3rd as its len.

Lets see how this makes the "bind" syscall reuse the "connect" BPF prog
augmenter found in tools/perf/examples/bpf/augmented_raw_syscalls.c:

  # perf trace -e bind,connect systemctl restart sshd
  connect(3, { .family: PF_LOCAL, path: /run/systemd/private }, 23) = 0
  #

Oh, it just connects to some daemon, so we better do it system wide and then
stop/start sshd:

  # perf trace -e bind,connect
  systemctl/10124 connect(3, { .family: PF_LOCAL, path: /run/systemd/private }, 23) = 0
  sshd/10102 connect(7, { .family: PF_LOCAL, path: /dev/log }, 110) = 0
  systemctl/10126 connect(3, { .family: PF_LOCAL, path: /run/systemd/private }, 23) = 0
  systemd/10128  ... [continued]: connect())            = 0
  (sshd)/10128 connect(3, { .family: PF_LOCAL, path: /run/systemd/journal/stdout }, 30) ...
  sshd/10128 bind(3, { .family: PF_NETLINK }, 12)    = 0
  sshd/10128 connect(4, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  sshd/10128 connect(3, { .family: PF_INET6, port: 22, addr: :: }, 28) = 0
  sshd/10128 connect(3, { .family: PF_UNSPEC }, 16)  = 0
  sshd/10128 connect(3, { .family: PF_INET, port: 22, addr: 0.0.0.0 }, 16) = 0
  sshd/10128 connect(3, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  sshd/10128 connect(3, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  sshd/10128 connect(5, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  sshd/10128 connect(5, { .family: PF_LOCAL, path: /var/run/nscd/socket }, 110) = -1 ENOENT (No such file or directory)
  sshd/10128 bind(4, { .family: PF_INET, port: 22, addr: 0.0.0.0 }, 16) = 0
  sshd/10128 connect(6, { .family: PF_LOCAL, path: /dev/log }, 110) = 0
  sshd/10128 bind(6, { .family: PF_INET6, port: 22, addr: :: }, 28) = 0
  sshd/10128 connect(7, { .family: PF_LOCAL, path: /dev/log }, 110) = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zfley2ghs4nim1uq4nu6ed3l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 154 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 152 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d8565c9a18a2..200fbe33d5de 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -709,7 +709,6 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_X86_ARCH_PRCTL_CODE, /* code */ },
 		   [1] = { .scnprintf = SCA_PTR, /* arg2 */ }, }, },
 	{ .name	    = "bind",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_connect", },
 	  .arg = { [0] = { .scnprintf = SCA_INT, /* fd */ },
 		   [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ },
 		   [2] = { .scnprintf = SCA_INT, /* addrlen */ }, }, },
@@ -879,7 +878,6 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "renameat2",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
 		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
@@ -2910,6 +2908,94 @@ static int trace__init_syscalls_bpf_map(struct trace *trace)
 	return __trace__init_syscalls_bpf_map(trace, enabled);
 }
 
+static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace, struct syscall *sc)
+{
+	struct tep_format_field *field, *candidate_field;
+	int id;
+
+	/*
+	 * We're only interested in syscalls that have a pointer:
+	 */
+	for (field = sc->args; field; field = field->next) {
+		if (field->flags & TEP_FIELD_IS_POINTER)
+			goto try_to_find_pair;
+	}
+
+	return NULL;
+
+try_to_find_pair:
+	for (id = 0; id < trace->sctbl->syscalls.nr_entries; ++id) {
+		struct syscall *pair = trace__syscall_info(trace, NULL, id);
+		struct bpf_program *pair_prog;
+		bool is_candidate = false;
+
+		if (pair == NULL || pair == sc ||
+		    pair->bpf_prog.sys_enter == trace->syscalls.unaugmented_prog)
+			continue;
+
+		for (field = sc->args, candidate_field = pair->args;
+		     field && candidate_field; field = field->next, candidate_field = candidate_field->next) {
+			bool is_pointer = field->flags & TEP_FIELD_IS_POINTER,
+			     candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
+
+			if (is_pointer) {
+			       if (!candidate_is_pointer) {
+					// The candidate just doesn't copies our pointer arg, might copy other pointers we want.
+					continue;
+			       }
+			} else {
+				if (candidate_is_pointer) {
+					// The candidate might copy a pointer we don't have, skip it.
+					goto next_candidate;
+				}
+				continue;
+			}
+
+			if (strcmp(field->type, candidate_field->type))
+				goto next_candidate;
+
+			is_candidate = true;
+		}
+
+		if (!is_candidate)
+			goto next_candidate;
+
+		/*
+		 * Check if the tentative pair syscall augmenter has more pointers, if it has,
+		 * then it may be collecting that and we then can't use it, as it would collect
+		 * more than what is common to the two syscalls.
+		 */
+		if (candidate_field) {
+			for (candidate_field = candidate_field->next; candidate_field; candidate_field = candidate_field->next)
+				if (candidate_field->flags & TEP_FIELD_IS_POINTER)
+					goto next_candidate;
+		}
+
+		pair_prog = pair->bpf_prog.sys_enter;
+		/*
+		 * If the pair isn't enabled, then its bpf_prog.sys_enter will not
+		 * have been searched for, so search it here and if it returns the
+		 * unaugmented one, then ignore it, otherwise we'll reuse that BPF
+		 * program for a filtered syscall on a non-filtered one.
+		 *
+		 * For instance, we have "!syscalls:sys_enter_renameat" and that is
+		 * useful for "renameat2".
+		 */
+		if (pair_prog == NULL) {
+			pair_prog = trace__find_syscall_bpf_prog(trace, pair, pair->fmt ? pair->fmt->bpf_prog_name.sys_enter : NULL, "enter");
+			if (pair_prog == trace->syscalls.unaugmented_prog)
+				goto next_candidate;
+		}
+
+		pr_debug("Reusing \"%s\" BPF sys_enter augmenter for \"%s\"\n", pair->name, sc->name);
+		return pair_prog;
+	next_candidate:
+		continue;
+	}
+
+	return NULL;
+}
+
 static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 {
 	int map_enter_fd = bpf_map__fd(trace->syscalls.prog_array.sys_enter),
@@ -2935,6 +3021,70 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 			break;
 	}
 
+	/*
+	 * Now lets do a second pass looking for enabled syscalls without
+	 * an augmenter that have a signature that is a superset of another
+	 * syscall with an augmenter so that we can auto-reuse it.
+	 *
+	 * I.e. if we have an augmenter for the "open" syscall that has
+	 * this signature:
+	 *
+	 *   int open(const char *pathname, int flags, mode_t mode);
+	 *
+	 * I.e. that will collect just the first string argument, then we
+	 * can reuse it for the 'creat' syscall, that has this signature:
+	 *
+	 *   int creat(const char *pathname, mode_t mode);
+	 *
+	 * and for:
+	 *
+	 *   int stat(const char *pathname, struct stat *statbuf);
+	 *   int lstat(const char *pathname, struct stat *statbuf);
+	 *
+	 * Because the 'open' augmenter will collect the first arg as a string,
+	 * and leave alone all the other args, which already helps with
+	 * beautifying 'stat' and 'lstat''s pathname arg.
+	 *
+	 * Then, in time, when 'stat' gets an augmenter that collects both
+	 * first and second arg (this one on the raw_syscalls:sys_exit prog
+	 * array tail call, then that one will be used.
+	 */
+	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
+		struct syscall *sc = trace__syscall_info(trace, NULL, key);
+		struct bpf_program *pair_prog;
+		int prog_fd;
+
+		if (sc == NULL || sc->bpf_prog.sys_enter == NULL)
+			continue;
+
+		/*
+		 * For now we're just reusing the sys_enter prog, and if it
+		 * already has an augmenter, we don't need to find one.
+		 */
+		if (sc->bpf_prog.sys_enter != trace->syscalls.unaugmented_prog)
+			continue;
+
+		/*
+		 * Look at all the other syscalls for one that has a signature
+		 * that is close enough that we can share:
+		 */
+		pair_prog = trace__find_usable_bpf_prog_entry(trace, sc);
+		if (pair_prog == NULL)
+			continue;
+
+		sc->bpf_prog.sys_enter = pair_prog;
+
+		/*
+		 * Update the BPF_MAP_TYPE_PROG_SHARED for raw_syscalls:sys_enter
+		 * with the fd for the program we're reusing:
+		 */
+		prog_fd = bpf_program__fd(sc->bpf_prog.sys_enter);
+		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
+		if (err)
+			break;
+	}
+
+
 	return err;
 }
 #else
-- 
2.21.0

