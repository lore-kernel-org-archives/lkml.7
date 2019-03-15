Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6992C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5E1218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 19:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5xhVxwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCOTG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:06:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45067 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfCOTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 15:06:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so11298216qtv.12;
        Fri, 15 Mar 2019 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XE8nShGk9Yk69pMV8IGp0mbt4fQ4EgtCDAZ52TzWk8=;
        b=L5xhVxwE4924WsEqZxP40IaRiEG1i9CQSC8CjE3bxR3HrkcIu5zzZqRicr4DVgrNEZ
         SChL4+CcXR7b8IKKOarNO8XVtoEQXEh71qhMdhrHqVqhB7jfyva+w0ZNPF92Nf+RlJLw
         TuG++fkMj25OOPNZjCF1pODb4i4/tZk9QRSYyI63o5r0K3gn1jvlxdy0A6aw/TE/au7F
         9ifHkiB3rZFjvzgSoFGwCAbl6n/zW1k5iU51w42DlZApGnK2PQQqgq0Mjfq0uHKzqgN4
         ulM5+hjKR02tbx+Y+CQ8vI7eq+YRxObMfDVoKTQidDdl2syriEpMCBNg0cBRc6UplYvb
         0Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XE8nShGk9Yk69pMV8IGp0mbt4fQ4EgtCDAZ52TzWk8=;
        b=bWVP2JpIua++af+rFC82QRewoJw+6GPpUBCtLGACQd0vV0/PHbD02Wvwl2TqXBOM2+
         d/Wy3iEuqkj1X+MRG/XJOI3AtXpu1/odzf2sNRO9q6O6uGOpbhng4feXE8Aw1Le+8520
         uPWq+qiItm2nU1P+2yGWNKIw9Umz5tFjK8fPN/EkOf665UzmAL4PqyA+vpHrMhrCQzEu
         TBkUM5e6DowN2On6LQb2bOBgnlOYctq/sRaHd/MdDxDDDkBW759nA43MqolLHTlqwBy6
         i/vm529VbLAlgE2ziO9Dv1Rem8Y2IIF9Xldnman3b0qBl4VhijgXZ5cFSBjB3dj8cWWg
         tD0Q==
X-Gm-Message-State: APjAAAVj7ZHmQ0er/mtSt20gdSVat9DpnqCj09LQhjEn+1Nt+dYW82oZ
        FzFXFGYj5Csir0Srxm/vp/Y=
X-Google-Smtp-Source: APXvYqzkTn9lvTo5ddUGc4GqaruV4xLm7e51cnAJshRFtjHkKmwwNhH/l9NBP3bdwhmd40NVFeHyyA==
X-Received: by 2002:aed:29a5:: with SMTP id o34mr4208558qtd.145.1552676817596;
        Fri, 15 Mar 2019 12:06:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id k17sm1397091qtj.59.2019.03.15.12.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:06:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 66D344039C; Fri, 15 Mar 2019 16:06:51 -0300 (-03)
Date:   Fri, 15 Mar 2019 16:06:51 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf@vger.kernel.org, Networking <netdev@vger.kernel.org>,
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
Message-ID: <20190315190651.GA14938@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org>
 <20190312151608.GH4939@kernel.org>
 <61901DA6-47B4-44E0-A0C9-9F2DBD6C34C1@fb.com>
 <20190312170556.GJ4939@kernel.org>
 <97D0A2F1-1F82-4CF0-ACE3-A276784DF7EA@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97D0A2F1-1F82-4CF0-ACE3-A276784DF7EA@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 12, 2019 at 05:29:03PM +0000, Song Liu escreveu:
> > On Mar 12, 2019, at 10:05 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > Em Tue, Mar 12, 2019 at 04:26:17PM +0000, Song Liu escreveu:
> >>> On Mar 12, 2019, at 8:16 AM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >>> Em Tue, Mar 12, 2019 at 12:14:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>> Em Mon, Mar 11, 2019 at 10:30:45PM -0700, Song Liu escreveu:
> >>>>> +static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
> >>>>> +{
> >>>>> +	struct perf_env *env = &ff->ph->env;
> >>>>> +	struct rb_root *root;
> >>>>> +	struct rb_node *next;
> >>>>> +
> >>>>> +	down_read(&env->bpf_progs.lock);
> >>>>> +
> >>>>> +	root = &env->bpf_progs.btfs;
> >>>>> +	next = rb_first(root);
> >>>>> +
> >>>>> +	while (next) {
> >>>>> +		struct btf_node *node;
> >>>>> +
> >>>>> +		node = rb_entry(next, struct btf_node, rb_node);
> >>>>> +		next = rb_next(&node->rb_node);
> >>>>> +		fprintf(fp, "# btf info of id %u\n", node->id);
> >>>> 
> >>>> So, I couldn't get this to work right now, and I have BPF programs that
> >>>> are loaded and that have BTF info:
> >>>> 
> >>>> [root@quaco ~]# bpftool prog | tail -6
> >>>> 208: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
> >>>> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
> >>>> 	xlated 528B  jited 381B  memlock 4096B  map_ids 107,106,105
> >>>> 209: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
> >>>> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
> >>>> 	xlated 256B  jited 191B  memlock 4096B  map_ids 107,106
> >>>> [root@quaco ~]#
> >>>> 
> >>>> 
> >>>> [root@quaco ~]# bpftool map  | tail -6
> >>>> 105: perf_event_array  name __augmented_sys  flags 0x0
> >>>> 	key 4B  value 4B  max_entries 8  memlock 4096B
> >>>> 106: array  name syscalls  flags 0x0
> >>>> 	key 4B  value 1B  max_entries 512  memlock 8192B
> >>>> 107: hash  name pids_filtered  flags 0x0
> >>>> 	key 4B  value 1B  max_entries 64  memlock 8192B
> >>>> [root@quaco ~]#
> >>>> 
> >>>> [root@quaco ~]# bpftool map dump id 107
> >>>> [{
> >>>>       "key": 8104,
> >>>>       "value": true
> >>>>   },{
> >>>>       "key": 18868,
> >>>>       "value": true
> >>>>   }
> >>>> ]
> >>>> [root@quaco ~]# ps ax|egrep 8104\|18868 | grep -v grep
> >>>> 8104 pts/8    S+     0:07 trace -e recvmmsg
> >>>> 18868 ?        Ssl   21:21 /usr/libexec/gnome-terminal-server
> >>>> [root@quaco ~]#
> >>>> 
> >>>> So I was expecting to see those btf lines there :-\
> >>>> 
> >>>> All the patches up to this point I have already merged and tested in my
> >>>> local branch.
> >>>> 
> >>>> Will continue right after lunch to try to figure out why this BTF info
> >>>> isn't landing on this new header feature...
> >>> 
> >>> I've pushed what I have to my git.kernel.org repo, branch
> >>> tmp.perf/bpf-annotate.
> >>> 
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/bpf-annotate
> >>> 
> >>> The HEAD is this cset.
> > 
> >> I am not sure I fully understand the problem here. 
> > 
> > Trying to say it another way, when I start 'perf record', with the
> > patches in your series up to this one ('[PATCH v9 perf,bpf 09/15] perf,
> > bpf: save btf information as headers to perf.data'), and while there is
> > a BPF program running, that has BTF attached to it as can be seen by
> > using 'bpf map dump', 'perf report --header-only' isn't showing any line
> > with 'btf' on it.
> > 
> > So, using -v I notice that it is failing to get enable attr.bpf_event
> > and attr.ksymbol, which makes me go get another coffee to check that the
> > kernel was built from my 5.1 tree that has those events and not 5.0 that
> > doesn't ;-\ Sorry for the noise, will get back here after I check all
> > this :-)
> > 
> > But to recap, the BPF events I was getting were the synthesized ones...
> 
> Yeah, to capture the short living BPF/BTF, we need patch 15/15 of the set. 

So, I continue trying to test this with the patches applied up to the
patch in the subject of this message, i.e. up to:

  09/15 perf, bpf: save btf information as headers to perf.data

While running on a kernel based on tip/perf/core, so it should have what
is needed:

  [root@quaco ~]# egrep 't perf_event_(bpf|ksymbol)_output' /proc/kallsyms
  ffffffff94211a40 t perf_event_bpf_output
  ffffffff94216550 t perf_event_ksymbol_output
  [root@quaco ~]#

But when I debug breakpointing perf_event__synthesize_one_bpf_prog(),
bpf_prog_info->btf_info is always zero, i.e. here:

        /* check BTF func info support */
        if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
                /* btf func info number should be same as sub_prog_cnt */
                if (sub_prog_cnt != info->nr_func_info) {
                        pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
                        err = -1;
                        goto out;
                }
                if (btf__get_from_id(info->btf_id, &btf)) {
                        pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
                        err = -1;
                        btf = NULL;
                        goto out;
                }
                has_btf = true;
                perf_env__fetch_btf(env, info->btf_id, btf);
        }

So we never get into this if body and this do not call
perf__env_fetch_btf() and thus don't write BTF info to the perf.data
header.

And yes, there are BPF programs with BTF information associated:

[root@quaco perf]# bpftool map dump pids_filtered
[{
        "key": 2592,
        "value": true
    },{
        "key": 20511,
        "value": true
    }
]
[root@quaco perf]#

I.e. bpftool can find the BTF info and thus is able to show the
'pids_filtered' map keys and values pretty printed, not just as hex raw
data.

I'm trying to find out why 'bpftool map dump' finds the BTF info while
perf_event__synthesize_one_bpf_prog() doesn't.

- Arnaldo
