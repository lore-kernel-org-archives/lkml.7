Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DF92184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqKNT3m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCNSbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:31:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39696 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfCNSbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:31:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so7254661qte.6;
        Thu, 14 Mar 2019 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFmyM0FBeDcl5BR5aptcX1In+rhhEnKew37vATrlxzo=;
        b=UqKNT3m/NWOqgWUnmUvreqbsq0IMuvqBXWoxyERBzL/SGPaI3m6NtwcS/vTfDIKBQ7
         DUSs4zLJJr+Vxb0m23uUP52UqtEf5BO443mVWhS1jQrNmVjujRJQlePfbm9DYxuEj2Z6
         5OHKRvD302wtF+GXf3dZMtLTpdnVHPLWdQcCnXCMk/B1dzO9e//tvbThqxv796+fuMqf
         XF+o5MAIQjuhycujFbD5VO8+jyrCAv81byQThozk9+qlvm5pL9yhfFyC0MYyG6oaB+9L
         D/FQQftcv9LokF54JSJNYhDkTucQ3tNJJL4ivFUmfyleAiBaGE9uIQqld48o6wLjoWIG
         TBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFmyM0FBeDcl5BR5aptcX1In+rhhEnKew37vATrlxzo=;
        b=WVslKyKrl21xB843iX38rXMOdw3jNULfwH1hB37hNcWRkwlgL1l0zt4IPzSrTsPqxX
         RQao23v+WjoQJOp6E6NDH/lsMGcKqJJlczp2bjydTsF/naj1b6JJJ3/mFCoBTaVsW/vL
         9GXQWA6hD140/G7NLWet14jdmkC+bD2bkano1pfkxIvUzf84nVlHywswfN14krA1X2Ai
         Yf5M87+7gIWZX1fmdVfCrcmMYMfOu0OoKCr4Az5BB5X7pE/sqBGt1KjmEo5frWHEIDed
         68pM8nsNAgVktiPJPvCMY0RtWq9OYi9Rihlj7Ap5ci4e39f30QJ/Rt4ZohfXZa8LMnKj
         VorQ==
X-Gm-Message-State: APjAAAUAUrY3L+YkISjrpXM28t9aNuUS0QplicgUgmbm/Wn57I5gfoCb
        9smj3cx6aOnTyEouFdNLuO7Tm5cc
X-Google-Smtp-Source: APXvYqw97FLw/b7IrmSYX3bsxm2IaGupadXkq5P0p8AV9k+6OkNSBaKX9QYMvWCVJ3juq9Eh0xiK1g==
X-Received: by 2002:ac8:1e87:: with SMTP id c7mr5171611qtm.104.1552588255408;
        Thu, 14 Mar 2019 11:30:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id e2sm8324946qkd.7.2019.03.14.11.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 11:30:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49F204039C; Thu, 14 Mar 2019 15:30:51 -0300 (-03)
Date:   Thu, 14 Mar 2019 15:30:51 -0300
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
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "sdf@fomichev.me" <sdf@fomichev.me>
Subject: Re: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Message-ID: <20190314183051.GA956@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-5-songliubraving@fb.com>
 <20190313210030.GA16304@kernel.org>
 <20190313210840.GB4786@kernel.org>
 <A61CCE47-BB1E-48BD-B8F5-C8289E5F7B2E@fb.com>
 <741F3DF8-F95F-4521-BD46-B31A675D8E76@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741F3DF8-F95F-4521-BD46-B31A675D8E76@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 14, 2019 at 04:45:22PM +0000, Song Liu escreveu:
> > On Mar 13, 2019, at 10:08 PM, Song Liu <songliubraving@fb.com> wrote:
> >> On Mar 13, 2019, at 2:08 PM, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> >> Em Wed, Mar 13, 2019 at 06:00:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>> Em Mon, Mar 11, 2019 at 10:30:40PM -0700, Song Liu escreveu:
> >>>> 	/* Synthesize PERF_RECORD_KSYMBOL */
> >>>> 	for (i = 0; i < sub_prog_cnt; i++) {
> >>>> +		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
> >>> Need this:
> >>> -               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
> >>> +               u8 (*prog_tags)[BPF_TAG_SIZE] = (u8 *)(info->prog_tags);
> >>> 
> >>> To overcome this on debian:experimental-x-mips, i.e. Debian Experimental
> >>> cross building to MIPS 32-bit:

> >>> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
> >>> util/bpf-event.c:143:35: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >>>  u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);

> >> Argh, hit the send button too fast, that is not the only case and then
> >> my change just changed the error:

> >> util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
> >> util/bpf-event.c:143:35: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >>  u8 (*prog_tags)[BPF_TAG_SIZE] = (u8 *)(info->prog_tags);

> >> util/bpf-event.c:143:35: error: initialization of 'u8 (*)[8]' {aka 'unsigned char (*)[8]'} from incompatible pointer type 'u8 *' {aka 'unsigned char *'} [-Werror=incompatible-pointer-types]
> >> util/bpf-event.c:144:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >>  __u32 *prog_lens = (__u32 *)(info->jited_func_lens);


> >> cc1: all warnings being treated as errors
> >> mv: cannot stat '/tmp/build/perf/util/.bpf-event.o.tmp': No such file or directory

> > We can fix it with the following:

> > -               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
> > -               __u32 *prog_lens = (__u32 *)(info->jited_func_lens);
> > -               __u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
> > -               void *func_infos = (void *)(info->func_info);
> > +               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(intptr_t)(info->prog_tags);
> > +               __u32 *prog_lens = (__u32 *)(intptr_t)(info->jited_func_lens);
> > +               __u64 *prog_addrs = (__u64 *)(intptr_t)(info->jited_ksyms);
> > +               void *func_infos = (void *)(intptr_t)(info->func_info);
 
> Actually, I think uintptr_t is better than intptr_t here. 

Yeap, did the trick:

$ dm debian:experimental-x-mips
   1   debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0
$

Works as well with x86_64 with a recent distro such as fedora:30 or
ubuntu:19.04, building it with both gcc and clang:

$ dm fedora:30 ubuntu:19.04
   1 fedora:30    : Ok   gcc (GCC) 9.0.1 20190227 (Red Hat 9.0.1-0.8), clang version 8.0.0 (Fedora 8.0.0-0.5.rc3.fc30)
   2 ubuntu:19.04 : Ok   gcc (Ubuntu 8.3.0-2ubuntu2) 8.3.0, clang version 8.0.0-+rc4-1ubuntu1 (tags/RELEASE_800/rc4)
$

Continuing with the review/tests...

- Arnaldo
