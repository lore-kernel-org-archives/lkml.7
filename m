Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAE8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797C32054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/WY1KIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfCLPQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:16:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44009 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfCLPQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:16:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id s26so1631097qkm.10;
        Tue, 12 Mar 2019 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFCYhIuvjRfB7KrXIhHJEv/cs/BVWBAkCKgRESs/Q8Y=;
        b=B/WY1KIfr7Yj5yci9MURcDxECFJaShuNGTQ5GzEz+CVbYMXaEEkE2OzWMBrSNY5Pag
         bXDu/JvvhqVut5IZshMwtyPRw0vh+tV28gLh/XOo5IhlLcuFbJXXdK+cwigO5wFU4A8s
         GS69TrIf3fU5eRB0oAO482vrdaunH8Uy/hfA3dGgQHTtm3nobsYEUIE3FCQjH6wAs6Rj
         5j/ULO4FjRZ1TucWtZ9yrY/NTrsv50aD9GS4EeCmeNpyPmne/bj1BGOTNsuNxKPxvYAN
         jKR++QynGOFF9eirJF+8l/P3iMspBUnZrJvSr0dSqdqYiToaEolNGxyuXUfCS5VnVili
         rlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFCYhIuvjRfB7KrXIhHJEv/cs/BVWBAkCKgRESs/Q8Y=;
        b=TClAKQUAk3dMfZroQzs1bVmPAk3+ONd8idZuBK/ovA4n0hBuztuxTzxl8OTqlgF3cE
         MePf1AIr3xJvFhSognIw5Q7+XYnJbvQZFW6af9XucLmYR4T1yVa3q/ztpwM7nxBaTJX9
         Rry1T+FhHS+Kw2VkOgrBcmKbs2+XFStZfbwiuLxmHDpPujvG7uvmm+AJdwU7ir90xkTW
         A/ZbTO/W14jg5WWKslpcP/VyO+xBYO1lrEZRfdEbShTrrk5MzPK38YzIfxICQTKNnjvc
         TGd8TUAA9MiQPn+4zy3fmWlzcAtoSsO8Mo2AeL5qMmAT0aTQJE1MBc3sQSM0X5TtD7v9
         JWGg==
X-Gm-Message-State: APjAAAWTuaRDoGun1pGFCr4Ha0Izz0oytM0GM+FirHQASWC5Udi3bnkD
        +k3liA8PTMnA5iPV5V1FGVw=
X-Google-Smtp-Source: APXvYqyGedcrr5R8BWqHiJBcwp8DLcorSIJBm/H9s+b6VqichNC7jmTDQaZXVZIHYLKsridklfF0ZQ==
X-Received: by 2002:a37:e40e:: with SMTP id y14mr1643365qkf.232.1552403772054;
        Tue, 12 Mar 2019 08:16:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-59-123-113.3g.claro.net.br. [177.59.123.113])
        by smtp.gmail.com with ESMTPSA id u31sm6227297qth.15.2019.03.12.08.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:16:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31B044039C; Tue, 12 Mar 2019 12:16:08 -0300 (-03)
Date:   Tue, 12 Mar 2019 12:16:08 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190312151608.GH4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
 <20190312151405.GG4939@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312151405.GG4939@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 12, 2019 at 12:14:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 11, 2019 at 10:30:45PM -0700, Song Liu escreveu:
> > +static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
> > +{
> > +	struct perf_env *env = &ff->ph->env;
> > +	struct rb_root *root;
> > +	struct rb_node *next;
> > +
> > +	down_read(&env->bpf_progs.lock);
> > +
> > +	root = &env->bpf_progs.btfs;
> > +	next = rb_first(root);
> > +
> > +	while (next) {
> > +		struct btf_node *node;
> > +
> > +		node = rb_entry(next, struct btf_node, rb_node);
> > +		next = rb_next(&node->rb_node);
> > +		fprintf(fp, "# btf info of id %u\n", node->id);
> 
> So, I couldn't get this to work right now, and I have BPF programs that
> are loaded and that have BTF info:
> 
> [root@quaco ~]# bpftool prog | tail -6
> 208: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
> 	xlated 528B  jited 381B  memlock 4096B  map_ids 107,106,105
> 209: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
> 	loaded_at 2019-03-12T11:16:55-0300  uid 0
> 	xlated 256B  jited 191B  memlock 4096B  map_ids 107,106
> [root@quaco ~]#
> 
> 
> [root@quaco ~]# bpftool map  | tail -6
> 105: perf_event_array  name __augmented_sys  flags 0x0
> 	key 4B  value 4B  max_entries 8  memlock 4096B
> 106: array  name syscalls  flags 0x0
> 	key 4B  value 1B  max_entries 512  memlock 8192B
> 107: hash  name pids_filtered  flags 0x0
> 	key 4B  value 1B  max_entries 64  memlock 8192B
> [root@quaco ~]#
> 
> [root@quaco ~]# bpftool map dump id 107
> [{
>         "key": 8104,
>         "value": true
>     },{
>         "key": 18868,
>         "value": true
>     }
> ]
> [root@quaco ~]# ps ax|egrep 8104\|18868 | grep -v grep
>  8104 pts/8    S+     0:07 trace -e recvmmsg
> 18868 ?        Ssl   21:21 /usr/libexec/gnome-terminal-server
> [root@quaco ~]#
> 
> So I was expecting to see those btf lines there :-\
> 
> All the patches up to this point I have already merged and tested in my
> local branch.
> 
> Will continue right after lunch to try to figure out why this BTF info
> isn't landing on this new header feature...

I've pushed what I have to my git.kernel.org repo, branch
tmp.perf/bpf-annotate.

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/bpf-annotate

The HEAD is this cset.

- Arnaldo
