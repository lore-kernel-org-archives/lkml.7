Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03081C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A2E2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCvqqguM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfCLOsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:48:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40520 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfCLOsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:48:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id h28so1574938qkk.7;
        Tue, 12 Mar 2019 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7IyRL8Mv5gxFyFp2FqPwI4V2MnxWESwOst1dyjfKLQA=;
        b=BCvqqguML2Gql/hcZA1ZgPm23TJdEbTh0a4Fw/YVsYXYUdL9grVsKFv77mcubfXVmF
         wxKcbTIor7DnvCiaVJHRG6iEz7zbqCYb0ctnHi+VPhMvGpgisPW/RSf3Mfe71VsEMSeL
         w3IEecgTGk27AgIZ0DBt6qC0U2//Ppigq2SzENeCbEO6OjtClPATxOzhxW0Wr4pXe/h7
         K9f8FGQKJUPHtamJr9wFLHk/xsR6ijeOI38k+nN4IJ6Di6DaKNGYjZtTTzohsHfLWfju
         bBGPtclpCCXSUwAfAYvhl54HIugkWZR4GZAVKpQj3CSDWbGufjjOG11+zK4uNlf6AokO
         3QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7IyRL8Mv5gxFyFp2FqPwI4V2MnxWESwOst1dyjfKLQA=;
        b=mS30cZXj7ZqzyKss9MFjuv5C5j2xCbPwqdY619AJofL6AlVCXqrSYdJ++qQWMe3E/4
         fufkUZANKweViwwtnlqdcbYVRKv9Xu7pr5uChNSVjHbNLe2dpEV3SwbztB7AAzUkxp9r
         B002GwzvJ47Shj39rGpsC5gdZNHkQGDekQ3A1bQcj7NYDb4sY2Os8yJT8KWjGY7VT8CF
         FrZ5OgmZwvWNEjTAXM9V8pcfSWXXreHXLbWsc36oZswCsQ8LJPL4zcOrBa6zMwvVAIbG
         so3E6yodsw70qFwy9qUQuSh2vByykaT7Nd0axQaDYk2P6/zVvz5SEL7Sn9wKiKLz7vfT
         PEZQ==
X-Gm-Message-State: APjAAAUzNjCv/zbnmSg7QT7fi3rZGXk7HzhRLjgLAUKz7A3AGZJ5HdB0
        9JWIYVsjZpghW48PSVDiBJE=
X-Google-Smtp-Source: APXvYqwZf6A4BxD5HRYwrEZWkBAvjRa+HcvzsS/dtGuIpWWh8Bm0WaAHPQEnylCBiQVGAfzro1A1gQ==
X-Received: by 2002:a37:7ac6:: with SMTP id v189mr15757552qkc.205.1552402083267;
        Tue, 12 Mar 2019 07:48:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-59-123-113.3g.claro.net.br. [177.59.123.113])
        by smtp.gmail.com with ESMTPSA id x25sm5758255qtx.71.2019.03.12.07.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 07:48:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BDF4D4039C; Tue, 12 Mar 2019 11:47:58 -0300 (-03)
Date:   Tue, 12 Mar 2019 11:47:58 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190312144758.GE4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-8-songliubraving@fb.com>
 <20190312131023.GA3034@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312131023.GA3034@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 12, 2019 at 02:10:23PM +0100, Jiri Olsa escreveu:
> On Mon, Mar 11, 2019 at 10:30:43PM -0700, Song Liu wrote:
> 
> SNIP
> 
> > +static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
> > +{
> > +	struct perf_env *env = &ff->ph->env;
> > +	struct rb_root *root;
> > +	struct rb_node *next;
> > +
> > +	down_read(&env->bpf_progs.lock);
> > +
> > +	root = &env->bpf_progs.infos;
> > +	next = rb_first(root);
> > +
> > +	while (next) {
> > +		struct bpf_prog_info_node *node;
> > +
> > +		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
> > +		next = rb_next(&node->rb_node);
> > +		fprintf(fp, "# bpf_prog_info of id %u\n",
> > +			node->info_linear->info.id);
> 
> so report displays bpf prog dso/name like:
> 
>    0.02%  ls           bpf_prog_c80ffe554aba1bec_syscall_enter_o  [k] bpf_prog_c80ffe554aba1bec_syscall_enter_o                                                                                       ▒
> 
> and 'perf report --header-only -I' shows:
> 
> 
> 	# bpf_prog_info of id 17
> 	# bpf_prog_info of id 18
> 	# bpf_prog_info of id 19
> 	# bpf_prog_info of id 20
> 	# bpf_prog_info of id 21
> 	# bpf_prog_info of id 22
> 	# bpf_prog_info of id 25
> 	# bpf_prog_info of id 26
> 	# bpf_prog_info of id 34
> 	# bpf_prog_info of id 35
> 
> could we have something more detailed like bpftool output:
> 
> 	34: tracepoint  name syscall_enter_o  tag c80ffe554aba1bec  gpl
> 		loaded_at 2019-03-12T14:02:03+0100  uid 0
> 		xlated 360B  jited 232B  memlock 4096B  map_ids 30
> 
> 	35: tracepoint  name syscall_enter_o  tag ada5ccbe5576399c  gpl
> 		loaded_at 2019-03-12T14:02:03+0100  uid 0
> 		xlated 352B  jited 228B  memlock 4096B  map_ids 30
> 
> 
> could be on top of this patchset

Yeah, please, and can we have the name of programs that loaded that
program there as well? 8-)

- Arnaldo
