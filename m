Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AF12075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfCVWqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:46:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfCVWq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:46:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMjoGQ757996
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:45:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMjnis757991;
        Fri, 22 Mar 2019 15:45:49 -0700
Date:   Fri, 22 Mar 2019 15:45:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-d56354dc49091e33d9ffca732ac913ed2df70537@git.kernel.org>
Cc:     daniel@iogearbox.net, acme@redhat.com, peterz@infradead.org,
        ast@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        songliubraving@fb.com, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, sdf@google.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, sdf@google.com,
          hpa@zytor.com, namhyung@kernel.org, songliubraving@fb.com,
          jolsa@kernel.org, ast@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, daniel@iogearbox.net, acme@redhat.com
In-Reply-To: <20190312053051.2690567-16-songliubraving@fb.com>
References: <20190312053051.2690567-16-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Save bpf_prog_info and BTF of new BPF
 programs
Git-Commit-ID: d56354dc49091e33d9ffca732ac913ed2df70537
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

Commit-ID:  d56354dc49091e33d9ffca732ac913ed2df70537
Gitweb:     https://git.kernel.org/tip/d56354dc49091e33d9ffca732ac913ed2df70537
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 11 Mar 2019 22:30:51 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 21 Mar 2019 11:27:04 -0300

perf tools: Save bpf_prog_info and BTF of new BPF programs

To fully annotate BPF programs with source code mapping, 4 different
information are needed:

    1) PERF_RECORD_KSYMBOL
    2) PERF_RECORD_BPF_EVENT
    3) bpf_prog_info
    4) btf

This patch handles 3) and 4) for BPF programs loaded after 'perf
record|top'.

For timely process of these information, a dedicated event is added to
the side band evlist.

When PERF_RECORD_BPF_EVENT is received via the side band event, the
polling thread gathers 3) and 4) vis sys_bpf and store them in perf_env.

This information is saved to perf.data at the end of 'perf record'.

Committer testing:

The 'wakeup_watermark' member in 'struct perf_event_attr' is inside a
unnamed union, so can't be used in a struct designated initialization
with older gccs, get it out of that, isolating as 'attr.wakeup_watermark
= 1;' to work with all gcc versions.

We also need to add '--no-bpf-event' to the 'perf record'
perf_event_attr tests in 'perf test', as the way that that test goes is
to intercept the events being setup and looking if they match the fields
described in the control files, since now it finds first the side band
event used to catch the PERF_RECORD_BPF_EVENT, they all fail.

With these issues fixed:

Same scenario as for testing BPF programs loaded before 'perf record' or
'perf top' starts, only start the BPF programs after 'perf record|top',
so that its information get collected by the sideband threads, the rest
works as for the programs loaded before start monitoring.

Add missing 'inline' to the bpf_event__add_sb_event() when
HAVE_LIBBPF_SUPPORT is not defined, fixing the build in systems without
binutils devel files installed.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190312053051.2690567-16-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c                        |   3 +
 tools/perf/builtin-top.c                           |   3 +
 tools/perf/tests/attr/test-record-C0               |   2 +-
 tools/perf/tests/attr/test-record-basic            |   2 +-
 tools/perf/tests/attr/test-record-branch-any       |   2 +-
 .../perf/tests/attr/test-record-branch-filter-any  |   2 +-
 .../tests/attr/test-record-branch-filter-any_call  |   2 +-
 .../tests/attr/test-record-branch-filter-any_ret   |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-hv |   2 +-
 .../tests/attr/test-record-branch-filter-ind_call  |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-k  |   2 +-
 tools/perf/tests/attr/test-record-branch-filter-u  |   2 +-
 tools/perf/tests/attr/test-record-count            |   2 +-
 tools/perf/tests/attr/test-record-data             |   2 +-
 tools/perf/tests/attr/test-record-freq             |   2 +-
 tools/perf/tests/attr/test-record-graph-default    |   2 +-
 tools/perf/tests/attr/test-record-graph-dwarf      |   2 +-
 tools/perf/tests/attr/test-record-graph-fp         |   2 +-
 tools/perf/tests/attr/test-record-group            |   2 +-
 tools/perf/tests/attr/test-record-group-sampling   |   2 +-
 tools/perf/tests/attr/test-record-group1           |   2 +-
 tools/perf/tests/attr/test-record-no-buffering     |   2 +-
 tools/perf/tests/attr/test-record-no-inherit       |   2 +-
 tools/perf/tests/attr/test-record-no-samples       |   2 +-
 tools/perf/tests/attr/test-record-period           |   2 +-
 tools/perf/tests/attr/test-record-raw              |   2 +-
 tools/perf/util/bpf-event.c                        | 100 +++++++++++++++++++++
 tools/perf/util/bpf-event.h                        |  15 ++++
 28 files changed, 145 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6f645fd72fed..4e2d953d4bc5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1238,6 +1238,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_child;
 	}
 
+	if (!opts->no_bpf_event)
+		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
+
 	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3ce8a8db6c1d..1999d6533d12 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1637,6 +1637,9 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (!top.record_opts.no_bpf_event)
+		bpf_event__add_sb_event(&sb_evlist, &perf_env);
+
 	if (perf_evlist__start_sb_thread(sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
 		opts->no_bpf_event = true;
diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
index cb0a3138fa54..93818054ae20 100644
--- a/tools/perf/tests/attr/test-record-C0
+++ b/tools/perf/tests/attr/test-record-C0
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -C 0 kill >/dev/null 2>&1
+args    = --no-bpf-event -C 0 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-basic b/tools/perf/tests/attr/test-record-basic
index 85a23cf35ba1..b0ca42a5ecc9 100644
--- a/tools/perf/tests/attr/test-record-basic
+++ b/tools/perf/tests/attr/test-record-basic
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = kill >/dev/null 2>&1
+args    = --no-bpf-event kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-any b/tools/perf/tests/attr/test-record-branch-any
index 81f839e2fad0..1a99b3ce6b89 100644
--- a/tools/perf/tests/attr/test-record-branch-any
+++ b/tools/perf/tests/attr/test-record-branch-any
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -b kill >/dev/null 2>&1
+args    = --no-bpf-event -b kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any b/tools/perf/tests/attr/test-record-branch-filter-any
index 357421f4dfce..709768b508c6 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any
+++ b/tools/perf/tests/attr/test-record-branch-filter-any
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j any kill >/dev/null 2>&1
+args    = --no-bpf-event -j any kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_call b/tools/perf/tests/attr/test-record-branch-filter-any_call
index dbc55f2ab845..f943221f7825 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_call
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j any_call kill >/dev/null 2>&1
+args    = --no-bpf-event -j any_call kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-any_ret b/tools/perf/tests/attr/test-record-branch-filter-any_ret
index a0824ff8e131..fd4f5b4154a9 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-any_ret
+++ b/tools/perf/tests/attr/test-record-branch-filter-any_ret
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j any_ret kill >/dev/null 2>&1
+args    = --no-bpf-event -j any_ret kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-hv b/tools/perf/tests/attr/test-record-branch-filter-hv
index f34d6f120181..4e52d685ebe1 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-hv
+++ b/tools/perf/tests/attr/test-record-branch-filter-hv
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j hv kill >/dev/null 2>&1
+args    = --no-bpf-event -j hv kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-ind_call b/tools/perf/tests/attr/test-record-branch-filter-ind_call
index b86a35232248..e08c6ab3796e 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-ind_call
+++ b/tools/perf/tests/attr/test-record-branch-filter-ind_call
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j ind_call kill >/dev/null 2>&1
+args    = --no-bpf-event -j ind_call kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-k b/tools/perf/tests/attr/test-record-branch-filter-k
index d3fbc5e1858a..b4b98f84fc2f 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-k
+++ b/tools/perf/tests/attr/test-record-branch-filter-k
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j k kill >/dev/null 2>&1
+args    = --no-bpf-event -j k kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-branch-filter-u b/tools/perf/tests/attr/test-record-branch-filter-u
index a318f0dda173..fb9610edbb0d 100644
--- a/tools/perf/tests/attr/test-record-branch-filter-u
+++ b/tools/perf/tests/attr/test-record-branch-filter-u
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -j u kill >/dev/null 2>&1
+args    = --no-bpf-event -j u kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-count b/tools/perf/tests/attr/test-record-count
index 34f6cc577263..5e9b9019d786 100644
--- a/tools/perf/tests/attr/test-record-count
+++ b/tools/perf/tests/attr/test-record-count
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -c 123 kill >/dev/null 2>&1
+args    = --no-bpf-event -c 123 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-data b/tools/perf/tests/attr/test-record-data
index a9cf2233b0ce..a99bb13149c2 100644
--- a/tools/perf/tests/attr/test-record-data
+++ b/tools/perf/tests/attr/test-record-data
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -d kill >/dev/null 2>&1
+args    = --no-bpf-event -d kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-freq b/tools/perf/tests/attr/test-record-freq
index bf4cb459f0d5..89e29f6b2ae0 100644
--- a/tools/perf/tests/attr/test-record-freq
+++ b/tools/perf/tests/attr/test-record-freq
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -F 100 kill >/dev/null 2>&1
+args    = --no-bpf-event -F 100 kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-graph-default b/tools/perf/tests/attr/test-record-graph-default
index 0b216e69760c..5d8234d50845 100644
--- a/tools/perf/tests/attr/test-record-graph-default
+++ b/tools/perf/tests/attr/test-record-graph-default
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -g kill >/dev/null 2>&1
+args    = --no-bpf-event -g kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-graph-dwarf b/tools/perf/tests/attr/test-record-graph-dwarf
index da2fa73bd0a2..ae92061d611d 100644
--- a/tools/perf/tests/attr/test-record-graph-dwarf
+++ b/tools/perf/tests/attr/test-record-graph-dwarf
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --call-graph dwarf -- kill >/dev/null 2>&1
+args    = --no-bpf-event --call-graph dwarf -- kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-graph-fp b/tools/perf/tests/attr/test-record-graph-fp
index 625d190bb798..5630521c0b0f 100644
--- a/tools/perf/tests/attr/test-record-graph-fp
+++ b/tools/perf/tests/attr/test-record-graph-fp
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --call-graph fp kill >/dev/null 2>&1
+args    = --no-bpf-event --call-graph fp kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
index 618ba1c17474..14ee60fd3f41 100644
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --group -e cycles,instructions kill >/dev/null 2>&1
+args    = --no-bpf-event --group -e cycles,instructions kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index f0729c454f16..300b9f7e6d69 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
index 48e8bd12fe46..3ffe246e0228 100644
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -e '{cycles,instructions}' kill >/dev/null 2>&1
+args    = --no-bpf-event -e '{cycles,instructions}' kill >/dev/null 2>&1
 ret     = 1
 
 [event-1:base-record]
diff --git a/tools/perf/tests/attr/test-record-no-buffering b/tools/perf/tests/attr/test-record-no-buffering
index aa3956d8fe20..583dcbb078ba 100644
--- a/tools/perf/tests/attr/test-record-no-buffering
+++ b/tools/perf/tests/attr/test-record-no-buffering
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = --no-buffering kill >/dev/null 2>&1
+args    = --no-bpf-event --no-buffering kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-no-inherit b/tools/perf/tests/attr/test-record-no-inherit
index 560943decb87..15d1dc162e1c 100644
--- a/tools/perf/tests/attr/test-record-no-inherit
+++ b/tools/perf/tests/attr/test-record-no-inherit
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -i kill >/dev/null 2>&1
+args    = --no-bpf-event -i kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-no-samples b/tools/perf/tests/attr/test-record-no-samples
index 8eb73ab639e0..596fbd6d5a2c 100644
--- a/tools/perf/tests/attr/test-record-no-samples
+++ b/tools/perf/tests/attr/test-record-no-samples
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -n kill >/dev/null 2>&1
+args    = --no-bpf-event -n kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-period b/tools/perf/tests/attr/test-record-period
index 69bc748f0f27..119101154c5e 100644
--- a/tools/perf/tests/attr/test-record-period
+++ b/tools/perf/tests/attr/test-record-period
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -c 100 -P kill >/dev/null 2>&1
+args    = --no-bpf-event -c 100 -P kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/tests/attr/test-record-raw b/tools/perf/tests/attr/test-record-raw
index a188a614a44c..13a5f7860c78 100644
--- a/tools/perf/tests/attr/test-record-raw
+++ b/tools/perf/tests/attr/test-record-raw
@@ -1,6 +1,6 @@
 [config]
 command = record
-args    = -R kill >/dev/null 2>&1
+args    = --no-bpf-event -R kill >/dev/null 2>&1
 ret     = 1
 
 [event:base-record]
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 7ffe7db59828..2a8c245ca942 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -13,6 +13,7 @@
 #include "env.h"
 #include "session.h"
 #include "map.h"
+#include "evlist.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -330,3 +331,102 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	free(event);
 	return err;
 }
+
+static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct btf *btf = NULL;
+	u64 arrays;
+	u32 btf_id;
+	int fd;
+
+	fd = bpf_prog_get_fd_by_id(id);
+	if (fd < 0)
+		return;
+
+	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
+	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
+
+	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
+		goto out;
+	}
+
+	btf_id = info_linear->info.btf_id;
+
+	info_node = malloc(sizeof(struct bpf_prog_info_node));
+	if (info_node) {
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	} else
+		free(info_linear);
+
+	if (btf_id == 0)
+		goto out;
+
+	if (btf__get_from_id(btf_id, &btf)) {
+		pr_debug("%s: failed to get BTF of id %u, aborting\n",
+			 __func__, btf_id);
+		goto out;
+	}
+	perf_env__fetch_btf(env, btf_id, btf);
+
+out:
+	free(btf);
+	close(fd);
+}
+
+static int bpf_event__sb_cb(union perf_event *event, void *data)
+{
+	struct perf_env *env = data;
+
+	if (event->header.type != PERF_RECORD_BPF_EVENT)
+		return -1;
+
+	switch (event->bpf_event.type) {
+	case PERF_BPF_EVENT_PROG_LOAD:
+		perf_env__add_bpf_info(env, event->bpf_event.id);
+
+	case PERF_BPF_EVENT_PROG_UNLOAD:
+		/*
+		 * Do not free bpf_prog_info and btf of the program here,
+		 * as annotation still need them. They will be freed at
+		 * the end of the session.
+		 */
+		break;
+	default:
+		pr_debug("unexpected bpf_event type of %d\n",
+			 event->bpf_event.type);
+		break;
+	}
+
+	return 0;
+}
+
+int bpf_event__add_sb_event(struct perf_evlist **evlist,
+			    struct perf_env *env)
+{
+	struct perf_event_attr attr = {
+		.type	          = PERF_TYPE_SOFTWARE,
+		.config           = PERF_COUNT_SW_DUMMY,
+		.sample_id_all    = 1,
+		.watermark        = 1,
+		.bpf_event        = 1,
+		.size	   = sizeof(attr), /* to capture ABI version */
+	};
+
+	/*
+	 * Older gcc versions don't support designated initializers, like above,
+	 * for unnamed union members, such as the following:
+	 */
+	attr.wakeup_watermark = 1;
+
+	return perf_evlist__add_sb_event(evlist, &attr, bpf_event__sb_cb, env);
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index b9ec394dc7c7..8cb1189149ec 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -4,12 +4,17 @@
 
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
+#include <pthread.h>
+#include <api/fd/array.h>
 #include "event.h"
 
 struct machine;
 union perf_event;
+struct perf_env;
 struct perf_sample;
 struct record_opts;
+struct evlist;
+struct target;
 
 struct bpf_prog_info_node {
 	struct bpf_prog_info_linear	*info_linear;
@@ -31,6 +36,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
+int bpf_event__add_sb_event(struct perf_evlist **evlist,
+				 struct perf_env *env);
+
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -46,5 +54,12 @@ static inline int perf_event__synthesize_bpf_events(struct perf_session *session
 {
 	return 0;
 }
+
+static inline int bpf_event__add_sb_event(struct perf_evlist **evlist __maybe_unused,
+					  struct perf_env *env __maybe_unused)
+{
+	return 0;
+}
+
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
