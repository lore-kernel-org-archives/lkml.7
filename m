Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86C1ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB62205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES/OzHKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbfJOWqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:46:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37920 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390034AbfJOWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:46:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id b20so21950974ljj.5;
        Tue, 15 Oct 2019 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sX8jTMX1nSIXGcCRNZ453mld0cSsi8SG9vJtVFWmkgY=;
        b=ES/OzHKnNaTbjDoZaXmFsqYm4h8O0iW4SYK/1ndLuLvY7RUpbwD2ej7ZWtshgaPazd
         UUnQwewSFBIjRDF44nesd7JXsVX/k50opp+s5i5b2f19wxk/LbSzVk13LFGb+CmUXKlV
         092qU3KAwKp92DLApsSN7InO1e5M6HAIoyijAJkq862bxOQ/FEc3MztS6PHQuENM75Yx
         GjUKKm+9FNF4fghj+tPnOBSUSvEPMCmdTXXQaSyrDys0wQ9C/qOqkBoiS3sP28uQwYG3
         KQKnDniiiVXYLDbejzoUpnDGXbTxZ8ulLBvxQz2fRcdjco3lJrfiSWsU+sgsT+1QQk8j
         ZsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sX8jTMX1nSIXGcCRNZ453mld0cSsi8SG9vJtVFWmkgY=;
        b=tUBfF9bMuSvxERqghdiiE3zDWsnvAP5Oo8ucMz1GvO8c8f/dmYOMhRTvkfAF+LCPmp
         +aduvoAbEpD/BNijO3MwKodzF7ZlwnMlGbWE2czPNIzz+0wKT0bgM3+T+8sWYIXXzqOa
         k5g1mvrMeZ+5e2EKHAxwQQdYHs8q4sDFwogs2qPmGpLeW20H6yChSdICDspAvXE9SeGd
         2NzQJHxwLqB2lHfDoJGL7JFfyH00yMTYjeSAeG0xwgHv8h9LV1KsYhk3qksq9h61P4Hf
         mpqU51b+tIeX6RF6+T2+tyIWt5gRG4HgRe8cnu/On+vC+xLKakKPiNnPp8z0n/6E4H1n
         BaSg==
X-Gm-Message-State: APjAAAU8iIR7/IUL7uaSbzDbD5ysGyC2SpI26r8/HFnCB6WBqkfE2+pK
        pGHloyGcnIoG103gpPvpYKT92afj/YtCs/P1gpg=
X-Google-Smtp-Source: APXvYqzlNJ02z8aHXTE2BBN+PZ4eg4j3tGXrnmLyvYl56/qH/Wq5j5U+oaAP2hF4sPK9AnCKWxQBVEiuc6J0CBfrUro=
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr23559078ljc.10.1571179565793;
 Tue, 15 Oct 2019 15:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191009160907.10981-1-christian.brauner@ubuntu.com>
 <CAADnVQJxUwD3u+tK1xsU2thpRWiAbERGx8mMoXKOCfNZrETMuw@mail.gmail.com> <20191010092647.cpxh7neqgabq36gt@wittgenstein>
In-Reply-To: <20191010092647.cpxh7neqgabq36gt@wittgenstein>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Oct 2019 15:45:54 -0700
Message-ID: <CAADnVQJ6t+HQBRhN3mZrz4qhzGybsY2g-26mc2kQARkbLxqzTA@mail.gmail.com>
Subject: Re: [PATCH 0/3] bpf: switch to new usercopy helpers
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 2:26 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Oct 09, 2019 at 04:06:18PM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 9, 2019 at 9:09 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > Hey everyone,
> > >
> > > In v5.4-rc2 we added two new helpers check_zeroed_user() and
> > > copy_struct_from_user() including selftests (cf. [1]). It is a generic
> > > interface designed to copy a struct from userspace. The helpers will be
> > > especially useful for structs versioned by size of which we have quite a
> > > few.
> > >
> > > The most obvious benefit is that this helper lets us get rid of
> > > duplicate code. We've already switched over sched_setattr(), perf_event_open(),
> > > and clone3(). More importantly it will also help to ensure that users
> > > implementing versioning-by-size end up with the same core semantics.
> > >
> > > This point is especially crucial since we have at least one case where
> > > versioning-by-size is used but with slighly different semantics:
> > > sched_setattr(), perf_event_open(), and clone3() all do do similar
> > > checks to copy_struct_from_user() while rt_sigprocmask(2) always rejects
> > > differently-sized struct arguments.
> > >
> > > This little series switches over bpf codepaths that have hand-rolled
> > > implementations of these helpers.
> >
> > check_zeroed_user() is not in bpf-next.
> > we will let this set sit in patchworks for some time until bpf-next
> > is merged back into net-next and we fast forward it.
> > Then we can apply it (assuming no conflicts).
>
> Sounds good to me. Just ping me when you need me to resend rebase onto
> bpf-next.

-rc1 is now in bpf-next.
I took a look at patches and they look good overall.

In patches 2 and 3 the zero init via "= {};"
should be unnecessary anymore due to
copy_struct_from_user() logic, right?

Could you also convert all other case in kernel/bpf/,
so bpf_check_uarg_tail_zero() can be removed ?
Otherwise the half-way conversion will look odd.
