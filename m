Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2164BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNDGyejf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCLRGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:06:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32942 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:06:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id z39so3434707qtz.0;
        Tue, 12 Mar 2019 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIqpgHk/8EBAdakHmpIkQ5ImqAeUJitVgr1g2ciwU8A=;
        b=SNDGyejfYO2aO4kWNSnICo6UxL2eWKhwj0iPdAyp28j+7OZh5m2R0ik0uvZtKS4w8q
         LxkXgivPfQDQaQplPhoGMhtPYZN4O93ZDkdkTyYkMB5FBEnJabyZ2xxf9V7DeNUx7NQC
         gKQbl2bk3/0aT6CRdyu7JCGxGsQBbAao6UIeJ75dzdLIYqQgH70MR/KN41XxMBguRHZf
         mxX5VIqfrTYjUFLLr3upu0P/G7wUDOkV8MfMNrObpQtOkwlvioRo6T6dKk5Ef6WhJWXA
         +ZHpgKpQLDI6D5NLdxHZdE8vVVNzKWMefb/oSUW5B/AAQNH7H669RP/irFcBCtq28HGU
         sLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIqpgHk/8EBAdakHmpIkQ5ImqAeUJitVgr1g2ciwU8A=;
        b=INHv9T8qsrdJvXG8Askqcq7n0ShftOm9ZRpht/9aXnrQo6AjhQOJZSCANKtlmbwQgo
         8dW9a+2EcO1akotELlPK/tvfgwzLBDMb/9Ka5w96TB6J8/lKzlMZwYFG96YHsFSaf2Ja
         M14YYGzztMjLdFqi4kfbUkoOfucMKb/ZJF7xWigSH0E/r2IixoOl9X+2cEdDgGL3uZug
         kVEt1WEnX6l0tT+KjxOxKGZT7HToAnE5nC7c5I47DmF/B0xeCelRDSco4TyxW7Op5w6/
         QM6ayRqbivW5EdZKg2mz4sm0Jfc0u4Vf7WgRck7rW5G6Qb7fovHdWfvWvGJeLgpjVRN+
         rpIg==
X-Gm-Message-State: APjAAAWWIaF+GBcStEpQtCz+PXpKA5/B3wTnph9Cr3NKZ2bukQ3Xeflz
        dq3cBqk1OoQf6ICk5yp61VQ=
X-Google-Smtp-Source: APXvYqxwa8QmR34f0xZo34m+yCgX9poiSA6BFhHkS7BNgEOtHsAIji52GxxctixtWYXMZVGdetkflw==
X-Received: by 2002:aed:2303:: with SMTP id h3mr21116518qtc.140.1552410360505;
        Tue, 12 Mar 2019 10:06:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id h186sm5379278qkd.15.2019.03.12.10.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 10:05:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29AF74039C; Tue, 12 Mar 2019 14:05:56 -0300 (-03)
Date:   Tue, 12 Mar 2019 14:05:56 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190312170556.GJ4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org>
 <20190312151608.GH4939@kernel.org>
 <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 12, 2019 at 04:26:17PM +0000, Song Liu escreveu:
> 
> 
> > On Mar 12, 2019, at 8:16 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > 
> > Em Tue, Mar 12, 2019 at 12:14:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Mar 11, 2019 at 10:30:45PM -0700, Song Liu escreveu:
> >>> +static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
> >>> +{
> >>> +	struct perf_env *env = &ff->ph->env;
> >>> +	struct rb_root *root;
> >>> +	struct rb_node *next;
> >>> +
> >>> +	down_read(&env->bpf_progs.lock);
> >>> +
> >>> +	root = &env->bpf_progs.btfs;
> >>> +	next = rb_first(root);
> >>> +
> >>> +	while (next) {
> >>> +		struct btf_node *node;
> >>> +
> >>> +		node = rb_entry(next, struct btf_node, rb_node);
> >>> +		next = rb_next(&node->rb_node);
> >>> +		fprintf(fp, "# btf info of id %u\n", node->id);
> >> 
> >> So, I couldn't get this to work right now, and I have BPF programs that
> >> are loaded and that have BTF info:
> >> 
> >> [root@quaco ~]# bpftool prog | tail -6
> >> 208: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
> >> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
> >> 	xlated 528B  jited 381B  memlock 4096B  map_ids 107,106,105
> >> 209: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
> >> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
> >> 	xlated 256B  jited 191B  memlock 4096B  map_ids 107,106
> >> [root@quaco ~]#
> >> 
> >> 
> >> [root@quaco ~]# bpftool map  | tail -6
> >> 105: perf_event_array  name __augmented_sys  flags 0x0
> >> 	key 4B  value 4B  max_entries 8  memlock 4096B
> >> 106: array  name syscalls  flags 0x0
> >> 	key 4B  value 1B  max_entries 512  memlock 8192B
> >> 107: hash  name pids_filtered  flags 0x0
> >> 	key 4B  value 1B  max_entries 64  memlock 8192B
> >> [root@quaco ~]#
> >> 
> >> [root@quaco ~]# bpftool map dump id 107
> >> [{
> >>        "key": 8104,
> >>        "value": true
> >>    },{
> >>        "key": 18868,
> >>        "value": true
> >>    }
> >> ]
> >> [root@quaco ~]# ps ax|egrep 8104\|18868 | grep -v grep
> >> 8104 pts/8    S+     0:07 trace -e recvmmsg
> >> 18868 ?        Ssl   21:21 /usr/libexec/gnome-terminal-server
> >> [root@quaco ~]#
> >> 
> >> So I was expecting to see those btf lines there :-\
> >> 
> >> All the patches up to this point I have already merged and tested in my
> >> local branch.
> >> 
> >> Will continue right after lunch to try to figure out why this BTF info
> >> isn't landing on this new header feature...
> > 
> > I've pushed what I have to my git.kernel.org repo, branch
> > tmp.perf/bpf-annotate.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/bpf-annotate
> > 
> > The HEAD is this cset.

> I am not sure I fully understand the problem here. 

Trying to say it another way, when I start 'perf record', with the
patches in your series up to this one ('[PATCH v9 perf,bpf 09/15] perf,
bpf: save btf information as headers to perf.data'), and while there is
a BPF program running, that has BTF attached to it as can be seen by
using 'bpf map dump', 'perf report --header-only' isn't showing any line
with 'btf' on it.

So, using -v I notice that it is failing to get enable attr.bpf_event
and attr.ksymbol, which makes me go get another coffee to check that the
kernel was built from my 5.1 tree that has those events and not 5.0 that
doesn't ;-\ Sorry for the noise, will get back here after I check all
this :-)

But to recap, the BPF events I was getting were the synthesized ones...

[root@quaco ~]# perf record -vv
Using CPUID GenuineIntel-6-8E-A
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
nr_cblocks: 0
affinity: SYS
------------------------------------------------------------
perf_event_attr:
  size                             112
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CPU|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off bpf_event
------------------------------------------------------------
perf_event_attr:
  size                             112
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CPU|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off ksymbol
------------------------------------------------------------
perf_event_attr:
  size                             112
  { sample_period, sample_freq }   4000
  sample_type                      IP|TID|TIME|CPU|PERIOD
  read_format                      ID
  disabled                         1
  inherit                          1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  precise_ip                       3
  sample_id_all                    1
  exclude_guest                    1
  mmap2                            1
  comm_exec                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 11
mmap size 528384B
perf event ring buffer mmapped per cpu
Synthesizing TSC conversion information


