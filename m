Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBAE2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBkLteBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfCOTmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:42:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36225 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfCOTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:42:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id y36so1655390qtb.3;
        Fri, 15 Mar 2019 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+9HyiyauWUeAchfMfptz4sKxCIyLca0DY24Pz3M+TJc=;
        b=rBkLteBth6lD2UVpUCmIOe3njhECrdn3b0BETbIgothLa9I3x/to/tBof4cUhQ5NRA
         oJ5dtUzXGHgmFINkGRUwj4U9F0KbJl7RHul6TIWtKHVuVi8rpyYOkVJ1iYQPjKFRMPqd
         YoZXpexeCIB0FyINRKGbPkGdbe+LlubxoC244x3usVK2JEubA/WApzIe0kXAqGBH0RSb
         OUvRqBd4Nh+e2UGTHOr2ZuUyX2ajViyAHyBIDD7L84bSVgtvtMjzB7YZIejsxP9ZW4IW
         iJIm4eiy7Lqk4OLXzRLnTZElaYe/UqGsOXDG3C8ifDzX/nkh2zfd4QICWj36cUNdVVAA
         9UJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+9HyiyauWUeAchfMfptz4sKxCIyLca0DY24Pz3M+TJc=;
        b=Qe6N7g+nEeJMtqWdBEoYfZJMA0X/bpEi150Ju1iO4f6g8xsI632MqNvxSpDbrOm+rz
         gFe4zczUkQxdIPGcaNnUL2UsgtD0SGQ6uWRkVqNfL79dzAaG7Mf5pAngn3SrTH3/msH/
         E/Ud3rhjIEy+1gWutVfaijE26cMne6U7PliD0FbvrpIW1sbYtahi0VARIkkR3StJqLLd
         +TDu3QjwnWaWmlzuRUaCPuLzYokuTC87+3Ln3kmhnCRkFYOhDBQWyknvNLisM4G00EBP
         G1Z/0CJYn4jGaAQl/gAswhoRMCSOzGjc9QK2VXTjAwMvJvojGIMyMIdxg6TrDJFDsHRu
         QNkw==
X-Gm-Message-State: APjAAAVUnluu1jNqoEt6W/IhajnzWrn5dqgY0yf6r5TagyEm/8rRX3WQ
        a4mvMAyHOXvLrDw6GCG0XZM=
X-Google-Smtp-Source: APXvYqycKIcChaOAzNfiS0TvVtRxI9LaVadCbhAOEbx5fFukO4L4v+kZ8wwWFsqurvcTkSjpSH949w==
X-Received: by 2002:ac8:67cb:: with SMTP id r11mr4239097qtp.388.1552678931918;
        Fri, 15 Mar 2019 12:42:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id y2sm2231466qty.63.2019.03.15.12.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:42:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ED2BA4039C; Fri, 15 Mar 2019 16:42:07 -0300 (-03)
Date:   Fri, 15 Mar 2019 16:42:07 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190315194207.GE14938@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org>
 <20190312151608.GH4939@kernel.org>
 <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
 <20190312170556.GJ4939@kernel.org>
 <97D0A2F1-1F82-4CF0-ACE3-A276784DF7EA@fb.com>
 <20190315190651.GA14938@kernel.org>
 <20190315192610.GB14938@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315192610.GB14938@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 15, 2019 at 04:26:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 15, 2019 at 04:06:51PM -0300, Arnaldo Carvalho de Melo escreveu:
> > And yes, there are BPF programs with BTF information associated:
>  
> > [root@quaco perf]# bpftool map dump pids_filtered
> > [{
> >         "key": 2592,
> >         "value": true
> >     },{
> >         "key": 20511,
> >         "value": true
> >     }
> > ]
> > [root@quaco perf]#
>  
> > I.e. bpftool can find the BTF info and thus is able to show the
> > 'pids_filtered' map keys and values pretty printed, not just as hex raw
> > data.
>  
> > I'm trying to find out why 'bpftool map dump' finds the BTF info while
> > perf_event__synthesize_one_bpf_prog() doesn't.
> 
> Humm, the BTF info above is for BPF _maps_ not for _programs_, I think
> you haven't added BTF info for maps in the perf.data header, right?

And then the BPF program I was using to test this had BTF encoded from
DWARF by pahole, so only associated to BPF maps, not to BPF programs, as
soon as I regenerated that BPF .o with clang 9.0, I got the BTF info for
the BPF programs and all works as expected:

[root@quaco perf]# clang --version
clang version 9.0.0 (https://git.llvm.org/git/clang.git/ 7906282d3afec5dfdc2b27943fd6c0309086c507) (https://git.llvm.org/git/llvm.git/ a1b5de1ff8ae8bc79dc8e86e1f82565229bd0500)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /opt/llvm/bin
[root@quaco perf]# perf record -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.023 MB perf.data ]
[root@quaco perf]# file /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
[root@quaco perf]# readelf -SW /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep BTF
  [22] .BTF              PROGBITS        0000000000000000 000ede 000b0e 00      0   0  1
  [23] .BTF.ext          PROGBITS        0000000000000000 0019ec 0002a0 00      0   0  1
  [24] .rel.BTF.ext      REL             0000000000000000 002fa8 000270 10     30  23  8
[root@quaco perf]# grep examples ~/.perfconfig
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
[root@quaco perf]# 
[root@quaco perf]# perf trace -e recvmmsg

Then, while this runs, using that augmented_raw_syscalls.o BPF program
generated with clang 9.0 and with proper BTF for BPF programs and not
just for BPF maps:

[root@quaco ~]# bpftool map dump pids_filtered
[{
        "key": 22459,
        "value": true
    },{
        "key": 2592,
        "value": true
    }
]
[root@quaco ~]#

[root@quaco ~]# perf record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data (7 samples) ]
[root@quaco ~]# perf report --header-only | grep b[pt]f
# event : name = cycles:ppp, , id = { 1116204, 1116205, 1116206, 1116207, 1116208, 1116209, 1116210, 1116211 }, size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, read_format = ID, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, ksymbol = 1, bpf_event = 1
# bpf_prog_info of id 13
# bpf_prog_info of id 14
# bpf_prog_info of id 15
# bpf_prog_info of id 16
# bpf_prog_info of id 17
# bpf_prog_info of id 18
# bpf_prog_info of id 21
# bpf_prog_info of id 22
# bpf_prog_info of id 51
# bpf_prog_info of id 52
# btf info of id 8
[root@quaco ~]#

Moving along the patch queue...

- Arnaldo
