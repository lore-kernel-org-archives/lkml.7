Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42011C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070552075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJgfS45w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfCUOQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:16:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38807 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCUOQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:16:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id s1so6720447qte.5;
        Thu, 21 Mar 2019 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rxMWKN8Al/U2Qhlo1yI64BoK/E0UlE5BH7Fj/JDLAUo=;
        b=HJgfS45w65Ur6LCb8B80w4ZFieBA36S7uy6sA4eQuXFbnJqOlKF/cxkcXe7IOiM4L5
         6sg4FhVVcPxwZKiDqU3HZLtSv9EdKr+BjsVoC4MFe2EtLfRIjSgncqlgSaVKbCWpH2Vb
         UFdUc4fHxe8n9TttCbyZ3Y9CEX2nc/8m56fobbwBlGPvONWhItvr6camFUV9UperFmbq
         IQnM0sWLz3svhKagJn2RddpLBBYmO7InJXWQv2wCK5yFG0glUH00jhAGRWPwxE/R09+N
         OOKckohZDuOseTbMDEKLdW94zGjnOW3ilqkT6rUFcjTSMWvv7bVQx+kO97nf8+GPUqHM
         8hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rxMWKN8Al/U2Qhlo1yI64BoK/E0UlE5BH7Fj/JDLAUo=;
        b=l6ZeYFwOpKWR1duUQn+hLHt7nHLVXZkSTGMoZOCYDTja3bVfVbEFCTX5/2Zf1t9JUz
         Du27NTkVbiTpnHqESVWQeWgo4p75phPEUxuCkQX7d0bBiwDkyTJsnjZODXs8xCeRiN9s
         cspDekQFHP6sBRINSxrnkwqPAgMGc9EOvsjb3CUIbNsGL9elh/z+f0sfYxGVZ+Tmfu+P
         VTYsNV40u5eCoec3sCMuzJ/2W2LK42095MfMihtNn/UQzobRW9wcyjQh3eJKXQSNQeGG
         oFJVI903qY5/XQvavjt2e9F6UZ0UJR17WlPC9LBlq3v8xcyQad5QlWcpCx6PjrLT7Tmc
         /bqg==
X-Gm-Message-State: APjAAAUlTskx/SSbcxFDJxzJztfkXQ5KpiYLHZWK9KiLZvNBojWPnb4Y
        BBzYo7FnjkQFPlphpZPlIO0=
X-Google-Smtp-Source: APXvYqzRzASN5u2pm350BMT4h90k8C1ELhkMrjdpeS1bR3sNRXZEvcUYUVoJrzGS7ByoP7R3w9G00g==
X-Received: by 2002:ac8:3696:: with SMTP id a22mr3191960qtc.191.1553177757620;
        Thu, 21 Mar 2019 07:15:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s20sm2973204qth.56.2019.03.21.07.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 07:15:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 022254039C; Thu, 21 Mar 2019 11:12:30 -0300 (-03)
Date:   Thu, 21 Mar 2019 11:12:30 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 00/15] perf annotation of BPF programs
Message-ID: <20190321141230.GG3967@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190321091016.GA30875@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321091016.GA30875@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 21, 2019 at 10:10:16AM +0100, Jiri Olsa escreveu:
> On Mon, Mar 11, 2019 at 10:30:36PM -0700, Song Liu wrote:
> > Changes v8 to v9:
> > 1. Rebase on top of torvalds/master:
> >     commit ea295481b6e313b4ea3ca2720ffcafd6005b5643 ;
> > 2. Change perf-record option --bpf-event to --no-bpf-event.
> > 
> > Changes v7 to v8:
> > 1. Address issues suggested by Jiri and Stanislav.
> > 
> > Changes v6 to v7:
> > 1. Fix minor issues suggested by Jiri.
> > 
> > Changes v5 to v6:
> > 1. Improve side band evlist interface;
> > 2. Minor style fixes.
> > 
> > Changes v4 to v5:
> > 1. Rebase to latest bpf-next;
> > 2. Add dependency of 94816add0005 from Arnaldo's tree;
> > 3. More details in change logs;
> > 4. Add perf_env__init() to init bpf related lock and rbtrees;
> > 5. Small clean ups.
> > 
> > Changes v3 to v4:
> > 1. Incorporate feedbacks from Jiri and Namhyung;
> > 2. Fixed compilation error with different feature-disassembler-four-args;
> > 3. Split some patches to smaller patches;
> > 4. Improved error handleing in symbol__disassemble_bpf();
> > 5. Made side band thread more generic;
> > 6. Added comments as suggested.
> > 
> > Changes v2 to v3:
> > 1. Remove unnecessary include in header files;
> > 2. Improved error handling;
> > 3. Better naming of functions, variables, etc.;
> > 4. Enable bpf events by default for perf-top.
> > 
> > Changes v1 to v2:
> > 1. Fix compilation error with different feature-disassembler-four-args;
> > 2. Fix a segfault in perf-record;
> > 3. Split patches 5/9 and 6/9 so that perf_env changes and perf.data changes
> >    are in separate patches.
> > 
> > This series enables annotation of BPF programs in perf.
> > 
> > perf tool gathers information via sys_bpf and (optionally) stores them in
> > perf.data as headers.
> > 
> > Patch 1/15 changes --bpf-event option to --no-bpf-event;
> > Patch 2/15 to 4/15 introduce new helper functions and use them in perf and
> >      bpftool;
> > Patch 5/15 to 9/15 saves information of bpf program in perf_env;
> > Patch 10/15 adds --bpf-event options to perf-top;
> > Patch 11/15 to 13/15 enables annotation of bpf progs based on information
> >      gathered in 5/15 to 9/15;
> > Patch 14/15 introduces side band polling thread that gathers information
> >      for special kernel events during perf-record or perf-top.
> > Patch 15/15 handles information of short living BPF program using the new
> >      side band polling thread.
> > 
> > Commands tested during developments are perf-top, perf-record, perf-report,
> > and perf-annotate.
> > 
> > This set is also available at:
> > 
> > https://github.com/liu-song-6/linux/tree/bpf-annotation-v9
> > 
> > Thanks!!
> > 
> > Song Liu (15):
> >   perf-record: replace option --bpf-event with --no-bpf-event
> >   bpf: libbpf: introduce bpf_program__get_prog_info_linear()
> >   bpf: bpftool: use bpf_program__get_prog_info_linear() in
> >     prog.c:do_dump()
> >   perf, bpf: synthesize bpf events with
> >     bpf_program__get_prog_info_linear()
> >   perf: change prototype of perf_event__synthesize_bpf_events()
> >   perf, bpf: save bpf_prog_info in a rbtree in perf_env
> >   perf, bpf: save bpf_prog_info information as headers to perf.data
> >   perf, bpf: save btf in a rbtree in perf_env
> >   perf, bpf: save btf information as headers to perf.data
> >   perf-top: add option --no-bpf-event
> >   perf: add -lopcodes to feature-libbfd
> >   perf, bpf: enable annotation of bpf program
> >   perf, bpf: process PERF_BPF_EVENT_PROG_LOAD for annotation
> >   perf: introduce side band thread
> >   perf, bpf: save bpf_prog_info and btf of short living bpf programs
> 
> it still crashes on standard user, like:
> 
> 
> [jolsa@krava perf]$ ./perf record  ./perf bench sched messaging
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 10 groups == 400 processes run
> 
>      Total time: 0.143 [sec]
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.282 MB perf.data (6341 samples) ]
> perf: Segmentation fault
> Obtained 14 stack frames.
> ./perf(dump_stack+0x2d) [0x531f8b]
> ./perf(sighandler_dump_stack+0x2d) [0x53206b]
> ./perf() [0x444cd9]
> /lib64/libc.so.6(+0x36f2f) [0x7f64a0ef2f2f]
> /lib64/libpthread.so.0(+0x88bc) [0x7f64a32518bc]
> ./perf(perf_evlist__stop_sb_thread+0x47) [0x4f30fc]
> ./perf() [0x447909]
> ./perf(cmd_record+0x815) [0x448afc]
> ./perf() [0x4d4c52]
> ./perf() [0x4d4ebf]
> ./perf() [0x4d500e]
> ./perf(main+0x267) [0x4d537a]
> /lib64/libc.so.6(__libc_start_main+0xea) [0x7f64a0edf11a]
> ./perf(_start+0x29) [0x42cbd9]
> Segmentation fault (core dumped)
> 
> 
> the reason is that you try to open system wide counter
> and that's not allow for standard user.. so the thread
> won't get started, but there's code to stop it unconsidtionaly
> which crashes
> 
> 
> the patch below fixes that for me, but I guess we want
> to check if th eerror was -EACCESS, if not we should fail

Right, I'll apply your patch as a stop-gap solution so that I can
proceed with pushing what we already have, and then we need to polish
this thing for good.


- Arnaldo
 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 08832fdaa26b..766059bf26ee 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1240,7 +1240,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  
>  	if (!opts->no_bpf_event)
>  		bpf_event__add_sb_event(&sb_evlist, &session->header.env);
> -	perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target);
> +	if (perf_evlist__start_sb_thread(sb_evlist, &rec->opts.target))
> +		opts->no_bpf_event = true;
>  
>  	err = record__synthesize(rec, false);
>  	if (err < 0)
> @@ -1493,7 +1494,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  out_delete_session:
>  	perf_session__delete(session);
>  
> -	perf_evlist__stop_sb_thread(sb_evlist);
> +	if (!opts->no_bpf_event)
> +		perf_evlist__stop_sb_thread(sb_evlist);
>  	return status;
>  }
>  

-- 

- Arnaldo
