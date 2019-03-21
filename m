Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27026C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E693220850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbfCUJKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:10:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfCUJKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:10:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E37130BA36D;
        Thu, 21 Mar 2019 09:10:20 +0000 (UTC)
Received: from krava (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DCC760857;
        Thu, 21 Mar 2019 09:10:17 +0000 (UTC)
Date:   Thu, 21 Mar 2019 10:10:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 00/15] perf annotation of BPF programs
Message-ID: <20190321091016.GA30875@krava>
References: <20190312053051.2690567-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-1-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Mar 2019 09:10:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:30:36PM -0700, Song Liu wrote:
> Changes v8 to v9:
> 1. Rebase on top of torvalds/master:
>     commit ea295481b6e313b4ea3ca2720ffcafd6005b5643 ;
> 2. Change perf-record option --bpf-event to --no-bpf-event.
> 
> Changes v7 to v8:
> 1. Address issues suggested by Jiri and Stanislav.
> 
> Changes v6 to v7:
> 1. Fix minor issues suggested by Jiri.
> 
> Changes v5 to v6:
> 1. Improve side band evlist interface;
> 2. Minor style fixes.
> 
> Changes v4 to v5:
> 1. Rebase to latest bpf-next;
> 2. Add dependency of 94816add0005 from Arnaldo's tree;
> 3. More details in change logs;
> 4. Add perf_env__init() to init bpf related lock and rbtrees;
> 5. Small clean ups.
> 
> Changes v3 to v4:
> 1. Incorporate feedbacks from Jiri and Namhyung;
> 2. Fixed compilation error with different feature-disassembler-four-args;
> 3. Split some patches to smaller patches;
> 4. Improved error handleing in symbol__disassemble_bpf();
> 5. Made side band thread more generic;
> 6. Added comments as suggested.
> 
> Changes v2 to v3:
> 1. Remove unnecessary include in header files;
> 2. Improved error handling;
> 3. Better naming of functions, variables, etc.;
> 4. Enable bpf events by default for perf-top.
> 
> Changes v1 to v2:
> 1. Fix compilation error with different feature-disassembler-four-args;
> 2. Fix a segfault in perf-record;
> 3. Split patches 5/9 and 6/9 so that perf_env changes and perf.data changes
>    are in separate patches.
> 
> This series enables annotation of BPF programs in perf.
> 
> perf tool gathers information via sys_bpf and (optionally) stores them in
> perf.data as headers.
> 
> Patch 1/15 changes --bpf-event option to --no-bpf-event;
> Patch 2/15 to 4/15 introduce new helper functions and use them in perf and
>      bpftool;
> Patch 5/15 to 9/15 saves information of bpf program in perf_env;
> Patch 10/15 adds --bpf-event options to perf-top;
> Patch 11/15 to 13/15 enables annotation of bpf progs based on information
>      gathered in 5/15 to 9/15;
> Patch 14/15 introduces side band polling thread that gathers information
>      for special kernel events during perf-record or perf-top.
> Patch 15/15 handles information of short living BPF program using the new
>      side band polling thread.
> 
> Commands tested during developments are perf-top, perf-record, perf-report,
> and perf-annotate.
> 
> This set is also available at:
> 
> https://github.com/liu-song-6/linux/tree/bpf-annotation-v9
> 
> Thanks!!
> 
> Song Liu (15):
>   perf-record: replace option --bpf-event with --no-bpf-event
>   bpf: libbpf: introduce bpf_program__get_prog_info_linear()
>   bpf: bpftool: use bpf_program__get_prog_info_linear() in
>     prog.c:do_dump()
>   perf, bpf: synthesize bpf events with
>     bpf_program__get_prog_info_linear()
>   perf: change prototype of perf_event__synthesize_bpf_events()
>   perf, bpf: save bpf_prog_info in a rbtree in perf_env
>   perf, bpf: save bpf_prog_info information as headers to perf.data
>   perf, bpf: save btf in a rbtree in perf_env
>   perf, bpf: save btf information as headers to perf.data
>   perf-top: add option --no-bpf-event
>   perf: add -lopcodes to feature-libbfd
>   perf, bpf: enable annotation of bpf program
>   perf, bpf: process PERF_BPF_EVENT_PROG_LOAD for annotation
>   perf: introduce side band thread
>   perf, bpf: save bpf_prog_info and btf of short living bpf programs

it still crashes on standard user, like:


[jolsa@krava perf]$ ./perf record  ./perf bench sched messaging
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 0.143 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.282 MB perf.data (6341 samples) ]
perf: Segmentation fault
Obtained 14 stack frames.
./perf(dump_stack+0x2d) [0x531f8b]
./perf(sighandler_dump_stack+0x2d) [0x53206b]
./perf() [0x444cd9]
/lib64/libc.so.6(+0x36f2f) [0x7f64a0ef2f2f]
/lib64/libpthread.so.0(+0x88bc) [0x7f64a32518bc]
./perf(perf_evlist__stop_sb_thread+0x47) [0x4f30fc]
./perf() [0x447909]
./perf(cmd_record+0x815) [0x448afc]
./perf() [0x4d4c52]
./perf() [0x4d4ebf]
./perf() [0x4d500e]
./perf(main+0x267) [0x4d537a]
/lib64/libc.so.6(__libc_start_main+0xea) [0x7f64a0edf11a]
./perf(_start+0x29) [0x42cbd9]
Segmentation fault (core dumped)


the reason is that you try to open system wide counter
and that's not allow for standard user.. so the thread
won't get started, but there's code to stop it unconsidtionaly
which crashes


the patch below fixes that for me, but I guess we want
to check if th eerror was -EACCESS, if not we should fail

jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 08832fdaa26b..766059bf26ee 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1240,7 +1240,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	if (!opts->no_bpf_event)
 		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
-	perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target);
+	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target))
+		opts->no_bpf_event = true;
 
 	err = record__synthesize(rec, false);
 	if (err < 0)
@@ -1493,7 +1494,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 out_delete_session:
 	perf_session__delete(session);
 
-	perf_evlist__stop_sb_thread(sb_evlist);
+	if (!opts->no_bpf_event)
+		perf_evlist__stop_sb_thread(sb_evlist);
 	return status;
 }
 
