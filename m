Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2724C2D0BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E077206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="fNwiQqfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfLEAYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:24:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46013 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLEAYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:24:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so992791lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=WlXLW2RI1tJQOcMNYgc98Qgcf4rYrGp8OIDLgoJCH0c=;
        b=fNwiQqfGnNsyEJYMPlge43hvB2JRQtOIQ7khRISVYNFdvNINB6iKEx0QoEJON7A4qg
         omWu6pKQJ8w6HgqGWf/MIO65vwjCsdYIYZYEtD4ySqIzqRvyd8CP/lBjPg1J2ol2FgZj
         Rs1eI4tDR3rz0hMU1ncrKBRIHY2AAMoHQEfbmMNudMkELJbUTpVZklq88nj/dZVis8EY
         vYBkyTnAjEkqNk34aamGnLh3muzsO95SpMOL7Or6FmPVzQ8pC2c2KY4yI/reU3XsRvOn
         lb3ahcDI3+7vyUAVoS7mXj4eE6EF+IQqduJA1uUjhXuEQ5sxhx8d3EDrxT5l2KHwEN2P
         ZkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=WlXLW2RI1tJQOcMNYgc98Qgcf4rYrGp8OIDLgoJCH0c=;
        b=Ln3DzeL4MJzFJEFI24jDaF5tesA/pa6tJXZ6IPHiIwkm2iud4P29GEc4cwwULuks8X
         BCbG7+Lz9QC9pA8rs0XwTEDVs105ODbElEcqTdSO02zkTVYDwIopIPI+8qiwvri/uEWt
         Nf9NKy4C5J1ruzX+YTC49B0SDt6MkF90qDDD8DokQI9JgY/prl+1cI+bqb8WvePjfQ1q
         a3FrHwnYcQ2ZkWAQTcY42RMzs4BAml4iLe7NgkN1OKMierKMonvwVNLtel0Rlk19ew9b
         XtOU6t6ik4rTEHBM1IYNo5JJH2B87uIAYIluHk7x7nfROvTvWZWTdEv3O3KLWjv9yoTf
         kFcQ==
X-Gm-Message-State: APjAAAX3pM0ALHQIigA/AFpLHyoV+30ED09cILDJ8KrnSaJ3+MuVNgfO
        DRg5I2aaVTxWLxpjSZXizNPe5w==
X-Google-Smtp-Source: APXvYqy7QeMNXACuTpx2U0w7soJGbGDcz1sK5VXmG2ytucMOOYNINLaDrgync325PZJQuq3Nc0rb3g==
X-Received: by 2002:a19:c7c5:: with SMTP id x188mr3580128lff.22.1575505452514;
        Wed, 04 Dec 2019 16:24:12 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l7sm4054402lfc.80.2019.12.04.16.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:24:12 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:23:48 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Toke =?UTF-8?B?SMO4aWxh?= =?UTF-8?B?bmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCHv4 0/6] perf/bpftool: Allow to link libbpf dynamically
Message-ID: <20191204162348.49be5f1b@cakuba.netronome.com>
In-Reply-To: <20191204233948.opvlopjkxe5o66lr@ast-mbp.dhcp.thefacebook.com>
References: <20191202131847.30837-1-jolsa@kernel.org>
        <CAEf4BzY_D9JHjuU6K=ciS70NSy2UvSm_uf1NfN_tmFz1445Jiw@mail.gmail.com>
        <87wobepgy0.fsf@toke.dk>
        <CAADnVQK-arrrNrgtu48_f--WCwR5ki2KGaX=mN2qmW_AcRyb=w@mail.gmail.com>
        <CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com>
        <20191204135405.3ffb9ad6@cakuba.netronome.com>
        <20191204233948.opvlopjkxe5o66lr@ast-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Dec 2019 15:39:49 -0800, Alexei Starovoitov wrote:
> > Agreed. Having libbpf on GH is definitely useful today, but one can hope
> > a day will come when distroes will get up to speed on packaging libbpf,
> > and perhaps we can retire it? Maybe 2, 3 years from now? Putting
> > bpftool in the same boat is just more baggage. =20
>=20
> Distros should be packaging libbpf and bpftool from single repo on github.
> Kernel tree is for packaging kernel.

Okay, single repo on GitHub:

https://github.com/torvalds/linux

we are in agreement =F0=9F=98=9D

Jokes aside, you may need to provide some reasoning on this one..
The recommendation for packaging libbpf from GitHub never had any=20
clear justification either AFAICR.

I honestly don't see why location matters. bpftool started out on GitHub
but we moved it into the tree for... ease of packaging/distribution(?!)
Now it's handy to have it in the tree to reuse the uapi headers.

As much as I don't care if we move it (back) out of the tree - having
two copies makes no sense to me. As does having it in the libbpf repo.
The sync effort is not warranted. User confusion is not warranted.

The distroes already package bpftool from the kernel sources, people had
put in time to get to this stage and there aren't any complaints.

In fact all the BPF projects and test suites we are involved in at
Netronome are entirely happy the packaged versions of LLVM and libbpf
in Fedora _today_, IOW the GH libbpf is irrelevant to us already.

As for the problem which sparked this discussion - I disagree that
bpftool should have "special relationship" with the library. In fact
bpftool uses the widest range of libbpf's interfaces of all known
projects so it's invaluable for making sure that those interfaces are
usable, consistent and complete.

You also said a few times you don't want to merge fixes into bpf/net.
That divergence from kernel development process is worrying.

None of this makes very much sense to me. We're diverging from well
established development practices without as much as a justification.

Perhaps I'm not clever enough to follow. But if I'm allowed to make an
uneducated guess it would be that it's some Facebook internal reason,
like it's hard to do backports? :/
