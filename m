Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D3FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798312067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI0EwwNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgAINiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:38:54 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:33843 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgAINiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:38:54 -0500
Received: by mail-qt1-f170.google.com with SMTP id 5so5870614qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TMXqPhBlxToPgILpB7CE8lkhHyLWR+bAOA0IBUAw5Pg=;
        b=PI0EwwNen3te6ufegDJc/yNsjxlYeS1A5V2f4jm+udOHgO2AYHXzOJPpGrLtkx8Gh7
         gNq9RYCk5ifuS2vjIsM3nrRntFH0wOCOOzv99ACimOgM2nrlEYiQof3UqKyP2uBKTj9P
         cuOXgmxIj9p1iO0NgYFYOq4AmAAEJuGgDyMG/4wKroM6kVqZ4MVtjY+2Oxu9GTYP8WM3
         xh9Si+Hnv1883JT9/sz+d+8ZrPhdvheFADndfC1K+0zOHRwZ+ZSiG25RTEDmy3olYgVM
         mAeS/MY5i3ffP+qaptjL68PZUiYzrovVMvvwQx1JMujCB+ISO8vEQaOqmpI7LQSQHGBJ
         b0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TMXqPhBlxToPgILpB7CE8lkhHyLWR+bAOA0IBUAw5Pg=;
        b=XXb/Mi5PWMxwNsqydGt95A0SnXv5GgcEg7LzT7hUwkGYkwVt82+Y4kyGBIhF7aWnV9
         f75vsp6nhnp6CGrKV9zgPu3cowySE0hgIhrq+7er5EBs72uddKr1bKqZsL9QOidF/8Jm
         ElCkP+4rVBqyV798V1WhqOQEHPN+VU2QUi6d07tgCmCHy0usLRtFjqXgy489PhLVLA1f
         xGwrkNbXqb47sm3jUFXdqwsein46IYh+F+rbJeu4l8nXZH+el2gcHw8d0huk1jZ7lRRO
         JWndzQOSF2pwe/w8htwQ1jANDBA6Oo/rNQflZSA7NERmBxnjxryGCwKKqWW61ohwiXoo
         ikwQ==
X-Gm-Message-State: APjAAAVK4WQuwPaolTUR1ilneat1IuMEm+PJdgSL3arnqeagZ6Fc5ZgE
        msOE+EVjBSVzgFwpUA8CT7o=
X-Google-Smtp-Source: APXvYqy7JkIPSzGviVrFXPFi3+DwTuPXdfFxeY/ZT6rvjyMYkH5VP6TKAc+VkDfb3nGYyu0CNH7ryQ==
X-Received: by 2002:ac8:383d:: with SMTP id q58mr7906877qtb.45.1578577130968;
        Thu, 09 Jan 2020 05:38:50 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u16sm2963701qku.19.2020.01.09.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 05:38:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B88840DFD; Thu,  9 Jan 2020 10:38:46 -0300 (-03)
Date:   Thu, 9 Jan 2020 10:38:46 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
        Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] list corruption while enabling multi call uprobes via perf
Message-ID: <20200109133846.GA2158@kernel.org>
References: <20200108171611.GA8472@kernel.org>
 <20200109111056.484a181fc6acc20196344f9a@kernel.org>
 <20200109183356.5a81ad2bfed6804f9934faee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109183356.5a81ad2bfed6804f9934faee@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 09, 2020 at 06:33:56PM +0900, Masami Hiramatsu escreveu:
> Hi,
> 
> On Thu, 9 Jan 2020 11:10:56 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hmm, this seems that the event->hw.tp_list is not initialized when removing
> > from the list in uprobe_perf_close().
> 
> Oops, that's wrong. Of course my patch can ease (avoid kernel panic) the
> issue, but not fixing the root cause.
> The root cause is that the uprobe event tries to open multiple probes with
> one perf_event. So the perf_event is reused on different probes.
> 
> In the reported case, if we remove the multiple probe event before perf-stat,
> no problem happens.
> 
> I'll try to fix it.

Ok!

For reference, I rebooted it with a fedora kernel, 5.3ish and it seems
to work:

[root@quaco ~]# uname -a
Linux quaco 5.3.18-200.fc30.x86_64 #1 SMP Wed Dec 18 20:26:50 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
[root@quaco ~]# perf -v
perf version 5.5.rc3.g6c4798d3f08b
[root@quaco ~]# perf probe -x ~/bin/perf libbpf_*
Added new events:
  probe_perf:libbpf_perf_print (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_num_possible_cpus (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_get_error (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_attach_type_by_name (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_find_attach_btf_id (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_find_prog_btf_id (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_find_vmlinux_btf_id (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_prog_type_by_name (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_get_type_names (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_print (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_set_print (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_validate_opts (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_dump_errormsg (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_parse_nested (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_parse (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_len (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_data (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_strerror (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_strerror_r (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_filter (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_qdisc (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_class (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nl_get_link (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_netlink_open (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_getattr_u32 (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_getattr_u8 (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf_nla_data_1 (on libbpf_* in /home/acme/bin/perf)
  probe_perf:libbpf__load_raw_btf (on libbpf_* in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:libbpf__load_raw_btf -aR sleep 1

[root@quaco ~]# perf stat -e probe_perf:libbpf* perf test bpf
41: BPF filter                                            :
41.1: Basic BPF filtering                                 : Ok
41.2: BPF pinning                                         : Ok
41.3: BPF prologue generation                             : Ok
41.4: BPF relocation checker                              : Ok

 Performance counter stats for 'perf test bpf':

                 8      probe_perf:libbpf__load_raw_btf                                   
                 0      probe_perf:libbpf_nla_data_1                                   
                 0      probe_perf:libbpf_nla_getattr_u8                                   
                 0      probe_perf:libbpf_nla_getattr_u32                                   
                 0      probe_perf:libbpf_netlink_open                                   
                 0      probe_perf:libbpf_nl_get_link                                   
                 0      probe_perf:libbpf_nl_get_class                                   
                 0      probe_perf:libbpf_nl_get_qdisc                                   
                 0      probe_perf:libbpf_nl_get_filter                                   
                 0      probe_perf:libbpf_strerror_r                                   
                 0      probe_perf:libbpf_strerror                                   
                 0      probe_perf:libbpf_nla_data                                   
                 0      probe_perf:libbpf_nla_len                                   
                 0      probe_perf:libbpf_nla_parse                                   
                 0      probe_perf:libbpf_nla_parse_nested                                   
                 0      probe_perf:libbpf_nla_dump_errormsg                                   
                 4      probe_perf:libbpf_validate_opts                                   
                 4      probe_perf:libbpf_set_print                                   
               200      probe_perf:libbpf_print                                     
                 3      probe_perf:libbpf_get_type_names                                   
                 3      probe_perf:libbpf_prog_type_by_name                                   
                 0      probe_perf:libbpf_find_vmlinux_btf_id                                   
                 0      probe_perf:libbpf_find_prog_btf_id                                   
                 0      probe_perf:libbpf_find_attach_btf_id                                   
                 0      probe_perf:libbpf_attach_type_by_name                                   
                 0      probe_perf:libbpf_get_error                                   
                 0      probe_perf:libbpf_num_possible_cpus                                   
               200      probe_perf:libbpf_perf_print                                   

       9.239808031 seconds time elapsed

       5.689898000 seconds user
       3.156735000 seconds sys


[root@quaco ~]#
[root@quaco ~]# perf stat -e probe_perf:libbpf* perf test llvm
39: LLVM search and compile                               :
39.1: Basic BPF llvm compile                              : Ok
39.2: kbuild searching                                    : Ok
39.3: Compile source for BPF prologue generation          : Ok
39.4: Compile source for BPF relocation                   : Ok

 Performance counter stats for 'perf test llvm':

                 6      probe_perf:libbpf__load_raw_btf
                 0      probe_perf:libbpf_nla_data_1
                 0      probe_perf:libbpf_nla_getattr_u8
                 0      probe_perf:libbpf_nla_getattr_u32
                 0      probe_perf:libbpf_netlink_open
                 0      probe_perf:libbpf_nl_get_link
                 0      probe_perf:libbpf_nl_get_class
                 0      probe_perf:libbpf_nl_get_qdisc
                 0      probe_perf:libbpf_nl_get_filter
                 0      probe_perf:libbpf_strerror_r
                 0      probe_perf:libbpf_strerror
                 0      probe_perf:libbpf_nla_data
                 0      probe_perf:libbpf_nla_len
                 0      probe_perf:libbpf_nla_parse
                 0      probe_perf:libbpf_nla_parse_nested
                 0      probe_perf:libbpf_nla_dump_errormsg
                 3      probe_perf:libbpf_validate_opts
                 0      probe_perf:libbpf_set_print
               134      probe_perf:libbpf_print
                 3      probe_perf:libbpf_get_type_names
                 3      probe_perf:libbpf_prog_type_by_name
                 0      probe_perf:libbpf_find_vmlinux_btf_id
                 0      probe_perf:libbpf_find_prog_btf_id
                 0      probe_perf:libbpf_find_attach_btf_id
                 0      probe_perf:libbpf_attach_type_by_name
                 3      probe_perf:libbpf_get_error
                 0      probe_perf:libbpf_num_possible_cpus
                 0      probe_perf:libbpf_perf_print

       5.016205398 seconds time elapsed

       2.713370000 seconds user
       2.398449000 seconds sys


[root@quaco ~]#

Then another pony to ask for, more than 128 probe points, please:

[root@quaco ~]# perf probe -x ~/bin/perf -F bpf*__* | wc -l
171
[root@quaco ~]# perf probe -x ~/bin/perf -F bpf*__* | head
bpf__apply_obj_config
bpf__clear
bpf__config_obj
bpf__foreach_event
bpf__gen_prologue
bpf__load
bpf__prepare_load
bpf__prepare_load_buffer
bpf__probe
bpf__setup_output_event
[root@quaco ~]# perf probe -x ~/bin/perf bpf*__*
Too many( > 128) probe point found.
Too many functions matched in /home/acme/bin/perf
  Error: Failed to add events.
[root@quaco ~]#

Lets artificially reduce this:

[root@quaco ~]# perf probe -x ~/bin/perf -F bpf_[op]*__*  | head -5
bpf_obj_config__map_funcs
bpf_object__add_map
bpf_object__add_program
bpf_object__btf
bpf_object__btf_fd
[root@quaco ~]# perf probe -x ~/bin/perf -F bpf_[op]*__*  | tail -5
bpf_program__size
bpf_program__title
bpf_program__unload
bpf_program__unpin
bpf_program__unpin_instance
[root@quaco ~]# perf probe -x ~/bin/perf -F bpf_[op]*__*  | tail -5

Now it works, scroll down harder to see the continuation...

[root@quaco ~]# perf probe -x ~/bin/perf bpf_[op]*__* 
Added new events:
  probe_perf:bpf_output__fprintf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_output__printer (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__bpil_offs_to_addr (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__bpil_addr_to_offs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__get_prog_info_linear (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_trace (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_raw_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_uprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_kprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__attach_perf_event (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_map_by_offset (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_map_fd_by_name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_map_by_name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_expected_attach_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__get_expected_attach_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_tracing (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_tracing (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_perf_event (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_perf_event (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_xdp (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_xdp (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_raw_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_raw_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_tracepoint (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_sched_act (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_sched_act (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_sched_cls (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_sched_cls (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_kprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_kprobe (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_socket_filter (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_socket_filter (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__get_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__nth_fd (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_prep (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__size (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__fd (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__title (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_ifindex (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__set_priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__prev (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__next (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__set_priv (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__btf_fd (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__kversion (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__next (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__close (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__pin (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__unpin_programs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__pin_programs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__unpin_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__pin_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__unpin (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__pin (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__unpin_instance (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__pin_instance (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__load (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__load_xattr (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__unload (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_buffer (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_mem (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_file (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__open_xattr (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__load_progs (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__is_function_storage (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__load (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__collect_reloc (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__relocate (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__relocate (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__reloc_text (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__relocate_core (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__create_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__populate_internal_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__reuse_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_caps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_array_mmap (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_btf_datasec (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_btf_func (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_global_data (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__probe_name (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__collect_reloc (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__record_reloc (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__section_to_libbpf_map_type (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__shndx_is_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__shndx_is_data (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_program_by_title (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__find_prog_by_idx (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__elf_collect (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__sanitize_and_load_btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__is_btf_mandatory (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__sanitize_btf_ext (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__sanitize_btf (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_user_btf_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_user_btf_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_user_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_global_data_maps (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_internal_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__add_map (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__variable_offset (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__section_size (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_kversion (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_license (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__check_endianness (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__elf_init (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__elf_finish (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__new (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__init_prog_names (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_object__add_program (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__init (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__exit (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_program__unload (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__lfind (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__lfind_addr_func (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__new (on bpf_[op]*__* in /home/acme/bin/perf)
  probe_perf:bpf_prog_linfo__free (on bpf_[op]*__* in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:bpf_prog_linfo__free -aR sleep 1

[root@quaco ~]#

It works, I think I'll add some option to 'perf stat' to suppress showing zeroed counters...

[root@quaco ~]# perf stat -e probe_perf:bpf* perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c -e openat --max-events=4
     0.000 ( 0.065 ms): gpm/1040 openat(dfd: CWD, filename: "/dev/tty0")                               = 4
  2000.487 ( 0.096 ms): gpm/1040 openat(dfd: CWD, filename: "/dev/tty0")                               = 4
  3842.601 ( 0.054 ms): pickup/1440 openat(dfd: CWD, filename: "maildrop", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 16
  4001.040 ( 0.078 ms): gpm/1040 openat(dfd: CWD, filename: "/dev/tty0")                               = 4

 Performance counter stats for 'perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c -e openat --max-events=4':

                 0      probe_perf:bpf_prog_linfo__free                                   
                 0      probe_perf:bpf_prog_linfo__new                                   
                 0      probe_perf:bpf_prog_linfo__lfind_addr_func                                   
                 0      probe_perf:bpf_prog_linfo__lfind                                   
                18      probe_perf:bpf_program__unload                                   
                 9      probe_perf:bpf_program__exit                                   
                 9      probe_perf:bpf_program__init                                   
                 9      probe_perf:bpf_object__add_program                                   
                 1      probe_perf:bpf_object__init_prog_names                                   
                 1      probe_perf:bpf_object__new                                   
                 2      probe_perf:bpf_object__elf_finish                                   
                 1      probe_perf:bpf_object__elf_init                                   
                 1      probe_perf:bpf_object__check_endianness                                   
                 1      probe_perf:bpf_object__init_license                                   
                 1      probe_perf:bpf_object__init_kversion                                   
                 0      probe_perf:bpf_object__section_size                                   
                 0      probe_perf:bpf_object__variable_offset                                   
                 6      probe_perf:bpf_object__add_map                                   
                 0      probe_perf:bpf_object__init_internal_map                                   
                 1      probe_perf:bpf_object__init_global_data_maps                                   
                 1      probe_perf:bpf_object__init_user_maps                                   
                 0      probe_perf:bpf_object__init_user_btf_map                                   
                 1      probe_perf:bpf_object__init_user_btf_maps                                   
                 1      probe_perf:bpf_object__init_maps                                   
                 0      probe_perf:bpf_object__sanitize_btf                                   
                 0      probe_perf:bpf_object__sanitize_btf_ext                                   
                 1      probe_perf:bpf_object__is_btf_mandatory                                   
                 1      probe_perf:bpf_object__init_btf                                   
                 1      probe_perf:bpf_object__sanitize_and_load_btf                                   
                 1      probe_perf:bpf_object__elf_collect                                   
                 8      probe_perf:bpf_object__find_prog_by_idx                                   
                 5      probe_perf:bpf_object__find_program_by_title                                   
                 0      probe_perf:bpf_object__shndx_is_data                                   
                17      probe_perf:bpf_object__shndx_is_maps                                   
                17      probe_perf:bpf_object__section_to_libbpf_map_type                                   
                17      probe_perf:bpf_program__record_reloc                                   
                 8      probe_perf:bpf_program__collect_reloc                                   
                 1      probe_perf:bpf_object__probe_name                                   
                 1      probe_perf:bpf_object__probe_global_data                                   
                 1      probe_perf:bpf_object__probe_btf_func                                   
                 1      probe_perf:bpf_object__probe_btf_datasec                                   
                 1      probe_perf:bpf_object__probe_array_mmap                                   
                 1      probe_perf:bpf_object__probe_caps                                   
                 0      probe_perf:bpf_object__reuse_map                                   
                 0      probe_perf:bpf_object__populate_internal_map                                   
                 1      probe_perf:bpf_object__create_maps                                   
                 0      probe_perf:bpf_object__relocate_core                                   
                 0      probe_perf:bpf_program__reloc_text                                   
                 9      probe_perf:bpf_program__relocate                                   
                 1      probe_perf:bpf_object__relocate                                   
                 1      probe_perf:bpf_object__collect_reloc                                   
                 9      probe_perf:bpf_program__load                                   
                74      probe_perf:bpf_program__is_function_storage                                   
                 1      probe_perf:bpf_object__load_progs                                   
                 0      probe_perf:bpf_object__open_xattr                                   
                 0      probe_perf:bpf_object__open                                   
                 0      probe_perf:bpf_object__open_file                                   
                 1      probe_perf:bpf_object__open_mem                                   
                 1      probe_perf:bpf_object__open_buffer                                   
                 1      probe_perf:bpf_object__unload                                   
                 1      probe_perf:bpf_object__load_xattr                                   
                 1      probe_perf:bpf_object__load                                   
                 0      probe_perf:bpf_program__pin_instance                                   
                 0      probe_perf:bpf_program__unpin_instance                                   
                 0      probe_perf:bpf_program__pin                                   
                 0      probe_perf:bpf_program__unpin                                   
                 0      probe_perf:bpf_object__pin_maps                                   
                 0      probe_perf:bpf_object__unpin_maps                                   
                 0      probe_perf:bpf_object__pin_programs                                   
                 0      probe_perf:bpf_object__unpin_programs                                   
                 0      probe_perf:bpf_object__pin                                   
                 1      probe_perf:bpf_object__close                                   
                17      probe_perf:bpf_object__next                                   
                 0      probe_perf:bpf_object__name                                   
                 0      probe_perf:bpf_object__kversion                                   
                 0      probe_perf:bpf_object__btf                                   
                 0      probe_perf:bpf_object__btf_fd                                   
                 0      probe_perf:bpf_object__set_priv                                   
                 0      probe_perf:bpf_object__priv                                   
                71      probe_perf:bpf_program__next                                   
                 0      probe_perf:bpf_program__prev                                   
                 9      probe_perf:bpf_program__set_priv                                   
                27      probe_perf:bpf_program__priv                                   
                 0      probe_perf:bpf_program__set_ifindex                                   
                 9      probe_perf:bpf_program__title                                   
                11      probe_perf:bpf_program__fd                                   
                 0      probe_perf:bpf_program__size                                   
                 0      probe_perf:bpf_program__set_prep                                   
                11      probe_perf:bpf_program__nth_fd                                   
                 0      probe_perf:bpf_program__get_type                                   
                 9      probe_perf:bpf_program__set_type                                   
                 0      probe_perf:bpf_program__is_type                                   
                 0      probe_perf:bpf_program__set_socket_filter                                   
                 0      probe_perf:bpf_program__is_socket_filter                                   
                 0      probe_perf:bpf_program__set_kprobe                                   
                 0      probe_perf:bpf_program__is_kprobe                                   
                 0      probe_perf:bpf_program__set_sched_cls                                   
                 0      probe_perf:bpf_program__is_sched_cls                                   
                 0      probe_perf:bpf_program__set_sched_act                                   
                 0      probe_perf:bpf_program__is_sched_act                                   
                 9      probe_perf:bpf_program__set_tracepoint                                   
                 0      probe_perf:bpf_program__is_tracepoint                                   
                 0      probe_perf:bpf_program__set_raw_tracepoint                                   
                 0      probe_perf:bpf_program__is_raw_tracepoint                                   
                 0      probe_perf:bpf_program__set_xdp                                   
                 0      probe_perf:bpf_program__is_xdp                                   
                 0      probe_perf:bpf_program__set_perf_event                                   
                 0      probe_perf:bpf_program__is_perf_event                                   
                 0      probe_perf:bpf_program__set_tracing                                   
                 0      probe_perf:bpf_program__is_tracing                                   
                 0      probe_perf:bpf_program__get_expected_attach_type                                   
                 0      probe_perf:bpf_program__set_expected_attach_type                                   
                 4      probe_perf:bpf_object__find_map_by_name                                   
                 0      probe_perf:bpf_object__find_map_fd_by_name                                   
                 0      probe_perf:bpf_object__find_map_by_offset                                   
                 0      probe_perf:bpf_program__attach_perf_event                                   
                 0      probe_perf:bpf_program__attach_kprobe                                   
                 0      probe_perf:bpf_program__attach_uprobe                                   
                 0      probe_perf:bpf_program__attach_tracepoint                                   
                 0      probe_perf:bpf_program__attach_raw_tracepoint                                   
                 0      probe_perf:bpf_program__attach_trace                                   
                 0      probe_perf:bpf_program__get_prog_info_linear                                   
                 0      probe_perf:bpf_program__bpil_addr_to_offs                                   
                 0      probe_perf:bpf_program__bpil_offs_to_addr                                   
                 0      probe_perf:bpf_output__printer                                   
                 0      probe_perf:bpf_output__fprintf                                   

       7.345027900 seconds time elapsed

       0.841158000 seconds user
       1.013929000 seconds sys


[root@quaco ~]#
