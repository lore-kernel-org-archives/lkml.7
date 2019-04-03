Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B63C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951A1206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORwt50rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDCRqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:46:15 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33553 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:46:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id a190so10529350vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GwufkSbp0za0y/s8xKK2xTDQXCwRXeNWzjwsCevJp4g=;
        b=ORwt50rS710swPF0g0qv9e7iN5BycM9pL0hDygcwntRGdvxDSBrP0RrMxIW9Zt3R+o
         OllrS3Z2hW0pveqb4t6qF+RrK7woqMrQyZ9ea34OU5GZeEGc/pZiCzpBeicnSjj+HnJY
         4svuomD/NwsbDfmYv3+ct0BKKkx+mqdjTFcPfk6DAbNAF+VANHZXrV6lyc1xUVkZ8//K
         3J7ov5sqI4r0fgK8wpk5QiEpu/QLi4JL0e8JrXwtFyLv5dFCQGMztFC0h/9XP6tKrscg
         7yu9Ja3hjRsv9qOjbrz0lG0wRKQKCg4aYJadNHVqb01jlM+TlCW/PBczCSKDGersGYpT
         EC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GwufkSbp0za0y/s8xKK2xTDQXCwRXeNWzjwsCevJp4g=;
        b=nB8JsZAVF7AJqZrw6E7VcwZmKZD9uokqCECZTfekWmMIS9HQR4aKl+HNVtF3nztFxu
         jkSZyIGnaEegmrayx7tC7EvuT1cydn2XfKOdJuuhdQBuAY0v4WKkUOxqBuS27w2WsV1y
         gKKXC9cZT5TEfxHHEmu/Iq+xylfmThzaWoY4Lt3e2Xm53eVMrmhBeXCh9PMxtblTkvKJ
         6kmTiJ4wVWAvwR12yVwjkZugzuTQVARSzj9rSTSIJW2fjJqyRBX1LkzUCcz+XWMHeOoJ
         xdlt30sLSw8pEZ1m1AhIvB7ZkzWiEUkXbqO7A+mzUIrCNjhUnixN1AdU/duEuL2Sf37Y
         w4oA==
X-Gm-Message-State: APjAAAUZKJWTSRg9jmNcagTcZ2gZSF4YjdAPwoNZHQf84rr7an5iDJdj
        XXuh2Ncjk5gxW+8yWbWhGoa17yOHPvKOkoruGlyaBg==
X-Google-Smtp-Source: APXvYqzzM/ASg2XJ60VtP2bmNuXJ/YvQ+IPrU18wjZGGeg/FXrTS2w+ijQVlvxnCwfgpYume1V/FOovIPKwrr0QDqw8=
X-Received: by 2002:a67:ea08:: with SMTP id g8mr1145592vso.31.1554313573382;
 Wed, 03 Apr 2019 10:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp> <20190325134947.GA187133@google.com>
 <20190327173103.GA205980@google.com> <CAK7LNARcaVtgHvco-Q=E5jhOXduk=55g9AC7nFn2esFxnk9Naw@mail.gmail.com>
 <20190403172031.GA260189@google.com>
In-Reply-To: <20190403172031.GA260189@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 3 Apr 2019 10:46:01 -0700
Message-ID: <CAKOZueszGpij1ZLqQfNggY-7t7BV+SksApVvmWE+kuExYvv+aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 10:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Apr 03, 2019 at 04:48:37PM +0900, Masahiro Yamada wrote:
> > On Thu, Mar 28, 2019 at 2:32 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 09:49:47AM -0400, Joel Fernandes wrote:
> > > > On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> > > > > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > > > > Introduce in-kernel headers and other artifacts which are made available
> > > > > > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > > > > > it possible to build kernel modules, run eBPF programs, and other
> > > > > > tracing programs that need to extend the kernel for tracing purposes
> > > > > > without any dependency on the file system having headers and build
> > > > > > artifacts.
> > > > > >
> > > > > > On Android and embedded systems, it is common to switch kernels but not
> > > > > > have kernel headers available on the file system. Raw kernel headers
> > > > > > also cannot be copied into the filesystem like they can be on other
> > > > > > distros, due to licensing and other issues. There's no linux-headers
> > > > > > package on Android. Further once a different kernel is booted, any
> > > > > > headers stored on the file system will no longer be useful. By storing
> > > > > > the headers as a compressed archive within the kernel, we can avoid these
> > > > > > issues that have been a hindrance for a long time.
> > > > >
> > > > > The set looks good to me and since the main use case is building bpf progs
> > > > > I can route it via bpf-next tree if there are no objections.
> > > > > Masahiro, could you please ack it?
> > > >
> > > > FYI, Masahiro's comments were all address by v5:
> > > > https://lore.kernel.org/patchwork/project/lkml/list/?series=387311
> > > >
> > > > I believe aren't more outstanding concerns. Could we consider it for v5.2?
> > >
> > > Just to highlight the problem, today I booted v5.0 on an emulated Android
> > > device for some testing, that didn't have a set of prebuilt headers that we
> > > have been packaging on well known kernels, to get around this issue. This
> > > caused great pain and issues with what I was doing. I know me and many others
> > > really want this. With this I can boot an emulated Android device with
> > > IKCONFIG_PROC=y and run BCC with that that. Also I want to do the BCC side of
> > > the development, but first want to know if we can merge this upstream.
> > >
> > > Masahiro, I believe due diligence has been done in solidifying it as posted
> > > in the v5.  Anything else we need to do here? Are you with the patches?
> >
> >
> > As you said, these updates are "cosmetic".
> > Nobody is worried about (or interested in) them.
> > Even if we miss something, they are fixable later.
> >
> > I accept embedding headers in the kernel,
> > but I do not like the part about external module build.
> >  - kernel embeds build artifacts that depend on a
> >    particular host-arch
> >  - users do not know which compiler to use
> > Perhaps, you may remember my concerns.
> > https://lore.kernel.org/patchwork/patch/1046307/#1239501
>
> Masahiro,
> I think we already discussed this right. The compiler issue is a user-issue -
> it is not a problem that has arisen because this patch. Anyone can build a
> kernel module today without this patch - using a compiler that is different
> from the running kernel. So I did not fully understand your concern. This
> patch does not ship a compiler in the archive. The compiler is upto the user
> based on user environment. They can already shoot themself in foot without
> this patch.
>
> Greg,
> Would be great to get your thoughts here as well about Masami's concern.
>
> Honestly, the "kernel module building artifacts" bit is a bonus with this
> patch. The main thing we are adding or that we need is really the headers
> (for BCC). I just thought shipping the kernel build artifacts would also be
> awesome because people can now build kernel modules without needing a kernel
> tree at all.
>
> But I also want this stuff merged so if folks are really unhappy with the
> module build artifacts and only want headers - then that's also fine with me
> and I can yank them - that would also mean though that this work cannot be a
> replacement for linux-headers package on distros, so that would be sad.
>
> thanks!

IMHO, including the module build stuff is fine, and the stuff that
Masahiro mentions doesn't matter much. To be specific about the
concerns:

>> > >  - kernel embeds build artifacts that depend on a
> >    particular host-arch

What are these artifacts? We build the kernel as a standalone system.
It's not as if we statically link host glibc into it or something.

> >  - users do not know which compiler to use

Does that matter much? Do things ever break if the kernel proper is
built with GCC x.y.z and we build a module with GCC x.y.(z+1)? Why
would it? Structure layout is invariant across compiler version, or at
least ought to be.  And don't we have exactly the same problem with
any kernel headers package? I don't think it'd hurt to include the
output of $(CC) --version though.

Like Joel, I'd like to see this change merged. It'll make life easier
for a lot of people.
