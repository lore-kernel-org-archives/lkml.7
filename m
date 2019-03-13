Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76AEC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6082070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKbtH3+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfCMVIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:08:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39221 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfCMVIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:08:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so2054022qke.6;
        Wed, 13 Mar 2019 14:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gHl7pab4HWZ1fyWQoYoSRKAmJkOm5E93j3TCFUyq89k=;
        b=kKbtH3+sJfzCAukDJXpQYwbdbD/AOSvM1Ktl5mld8oaaf5AoPb32eiHzNpaEPEaPJO
         3OI+004tF6/HDtRvlDzg2BY00zYTQ5dDjS2E1dOTPGZUMd6pT7EWX4V6p70wZm7UNCAC
         /l1MWRXQSmckwjPYE/vcV86ouSCINMV7U8cTl1z2eKJ31KzcLp77CH+om8NW7IC1Y3lD
         AIn1WvGtLhgDiQXsbGsdMNNsPVl4hKuqDx2lEgiLi35IUEBq7OxbtFnh3UUMNcARXX8J
         QNXsBpCUzVzOxNHbQY+wI/4etz/k7spMOTQ2hT0/bpT7IdOKveuJ9cxF9FOOhlCOiegN
         8/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHl7pab4HWZ1fyWQoYoSRKAmJkOm5E93j3TCFUyq89k=;
        b=fTZ7xxn7fzQQqHSjaAyAwL4Q6BjGK0c9noIz0T4EOIqeILuit7ZhTrhSX3UAv4RJsm
         fJK6H+6WBXVM0Zb5EhqEyASoJh5q9z3QK5nP2KGUIpESVCp/G1mwzuqyQQyGTnKEwNiB
         pULUUdVhHxgX3hGVwsCyh18hDDN2apBmAHQiTpEZefQVQwD96lhcbNd/0FISJHFa4NuG
         JYHhAa6NM6xzZiFJzYm7iGFe1h7ZdfYbMrM7P20KnhNNKrE2UuNdptaFhFVnONxJMxzo
         HfmUAd9cp720uZhY80DOvrsQ/IOj96FT69RcO/iSzMHozkN5zlJOQrSM5WMkU+f+bFxM
         gi/w==
X-Gm-Message-State: APjAAAV26VzE3p+j+4gm513dt+zPhemW3q6s3jCs+MnUfMdysNoeR7zU
        6TIzp+jyrSsNASoSi9gbFtU=
X-Google-Smtp-Source: APXvYqzY93i1iMmxjkVgk2KjY10LrH0bNVDOgEImDSuvUlBInlJmR2ncryIGQU/x59x5feNBnpzBTQ==
X-Received: by 2002:a37:c5d2:: with SMTP id k79mr9607183qkl.234.1552511323713;
        Wed, 13 Mar 2019 14:08:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id x28sm8077466qta.76.2019.03.13.14.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 14:08:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 758A24039C; Wed, 13 Mar 2019 18:08:40 -0300 (-03)
Date:   Wed, 13 Mar 2019 18:08:40 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Message-ID: <20190313210840.GB4786@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-5-songliubraving@fb.com>
 <20190313210030.GA16304@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313210030.GA16304@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 13, 2019 at 06:00:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 11, 2019 at 10:30:40PM -0700, Song Liu escreveu:
> > -
> >  	/* Synthesize PERF_RECORD_KSYMBOL */
> >  	for (i = 0; i < sub_prog_cnt; i++) {
> > +		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
> 
> Need this:
> 
> -               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
> +               u8 (*prog_tags)[BPF_TAG_SIZE] = (u8 *)(info->prog_tags);
> 
> 
> To overcome this on debian:experimental-x-mips, i.e. Debian Experimental
> cross building to MIPS 32-bit:
> 
> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
> util/bpf-event.c:143:35: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
>                                    ^
> util/bpf-event.c:144:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    __u32 *prog_lens = (__u32 *)(info->jited_func_lens);
>                       ^
> util/bpf-event.c:145:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    __u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
>                        ^
> util/bpf-event.c:146:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    void *func_infos = (void *)(info->func_info);
>                       ^
>   CC       /tmp/build/perf/util/pmu.o
>   CC       /tmp/build/perf/util/pmu-flex.o
> cc1: all warnings being treated as errors

Argh, hit the send button too fast, that is not the only case and then
my change just changed the error:

util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
util/bpf-event.c:143:35: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   u8 (*prog_tags)[BPF_TAG_SIZE] = (u8 *)(info->prog_tags);
                                   ^
util/bpf-event.c:143:35: error: initialization of 'u8 (*)[8]' {aka 'unsigned char (*)[8]'} from incompatible pointer type 'u8 *' {aka 'unsigned char *'} [-Werror=incompatible-pointer-types]
util/bpf-event.c:144:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   __u32 *prog_lens = (__u32 *)(info->jited_func_lens);
                      ^
util/bpf-event.c:145:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   __u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
                       ^
util/bpf-event.c:146:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   void *func_infos = (void *)(info->func_info);
                      ^
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/util/.bpf-event.o.tmp': No such file or directory

