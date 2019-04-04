Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ACBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E343221734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Y1z3/UNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfDDDyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:54:54 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64697 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfDDDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:54:54 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x343slkB013747;
        Thu, 4 Apr 2019 12:54:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x343slkB013747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554350088;
        bh=9TtKvr86lCRWDzLB5qp7W/7os9kgPgCNlRNNkcKtNgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y1z3/UNkZseu0pgJPyikukZHuo04yt1DKn9risncLieX3N5v1P36yKeiNJ/bG2ofq
         FXOxu+P9zwTEyR0KG+IALMyXNWebTO9qYsZU4l1UhtCu5/PNO3ApgxkW8VL2mLjkVh
         6W4HbKeWmUP9yc4i/OWCTwfTWa5ZVj6DATxUXK2qv3rzx8d8XFaBfZm/HSesS0yhqM
         hrYJRmEd/uwMSCfgPnmUoLHTCQsPsSkBMR5NzXeoMbCqhNCJrt3GIskNpl5O8b2SNx
         vBsx+6XxKv0ym6ISwYA6px2GWYV0S4p7AZ/JbV7vuW0y2KFXFnK2/5apie1SFhGbaw
         TuKDCtvDt9KWA==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id o187so311082vkg.4;
        Wed, 03 Apr 2019 20:54:48 -0700 (PDT)
X-Gm-Message-State: APjAAAWjs9etkU0NzyZkfaf5KLSAFazcIF7RazNl9iI5TKAoZhH7X4Wd
        SRA0YZi37TT0DsW6xUJDRHYnfv9K1pqMRubLubw=
X-Google-Smtp-Source: APXvYqyC6n7Kg01N/nQkcMNmCnger1LJL5DyePe0wWCNfg40D+iUvThQKkIiQXjs00a5Ghecmd1U3SONWmHQnD2aIn0=
X-Received: by 2002:a1f:1a49:: with SMTP id a70mr2517805vka.33.1554350087207;
 Wed, 03 Apr 2019 20:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp> <20190325134947.GA187133@google.com>
 <20190327173103.GA205980@google.com> <CAK7LNARcaVtgHvco-Q=E5jhOXduk=55g9AC7nFn2esFxnk9Naw@mail.gmail.com>
 <20190403172031.GA260189@google.com> <CAKOZueszGpij1ZLqQfNggY-7t7BV+SksApVvmWE+kuExYvv+aA@mail.gmail.com>
 <20190403175653.GA60809@google.com>
In-Reply-To: <20190403175653.GA60809@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Apr 2019 12:54:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZsUgYVeAhr5PZ1u1=+RzXgo+PUq+Bpcq4r_tPNSVMpA@mail.gmail.com>
Message-ID: <CAK7LNATZsUgYVeAhr5PZ1u1=+RzXgo+PUq+Bpcq4r_tPNSVMpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Colascione <dancol@google.com>,
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

On Thu, Apr 4, 2019 at 2:59 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Apr 03, 2019 at 10:46:01AM -0700, Daniel Colascione wrote:
> > On Wed, Apr 3, 2019 at 10:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Wed, Apr 03, 2019 at 04:48:37PM +0900, Masahiro Yamada wrote:
> > > > On Thu, Mar 28, 2019 at 2:32 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Mon, Mar 25, 2019 at 09:49:47AM -0400, Joel Fernandes wrote:
> > > > > > On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> > > > > > > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > > > > > > Introduce in-kernel headers and other artifacts which are made available
> > > > > > > > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > > > > > > > it possible to build kernel modules, run eBPF programs, and other
> > > > > > > > tracing programs that need to extend the kernel for tracing purposes
> > > > > > > > without any dependency on the file system having headers and build
> > > > > > > > artifacts.
> > > > > > > >
> > > > > > > > On Android and embedded systems, it is common to switch kernels but not
> > > > > > > > have kernel headers available on the file system. Raw kernel headers
> > > > > > > > also cannot be copied into the filesystem like they can be on other
> > > > > > > > distros, due to licensing and other issues. There's no linux-headers
> > > > > > > > package on Android. Further once a different kernel is booted, any
> > > > > > > > headers stored on the file system will no longer be useful. By storing
> > > > > > > > the headers as a compressed archive within the kernel, we can avoid these
> > > > > > > > issues that have been a hindrance for a long time.
> > > > > > >
> > > > > > > The set looks good to me and since the main use case is building bpf progs
> > > > > > > I can route it via bpf-next tree if there are no objections.
> > > > > > > Masahiro, could you please ack it?
> > > > > >
> > > > > > FYI, Masahiro's comments were all address by v5:
> > > > > > https://lore.kernel.org/patchwork/project/lkml/list/?series=387311
> > > > > >
> > > > > > I believe aren't more outstanding concerns. Could we consider it for v5.2?
> > > > >
> > > > > Just to highlight the problem, today I booted v5.0 on an emulated Android
> > > > > device for some testing, that didn't have a set of prebuilt headers that we
> > > > > have been packaging on well known kernels, to get around this issue. This
> > > > > caused great pain and issues with what I was doing. I know me and many others
> > > > > really want this. With this I can boot an emulated Android device with
> > > > > IKCONFIG_PROC=y and run BCC with that that. Also I want to do the BCC side of
> > > > > the development, but first want to know if we can merge this upstream.
> > > > >
> > > > > Masahiro, I believe due diligence has been done in solidifying it as posted
> > > > > in the v5.  Anything else we need to do here? Are you with the patches?
> > > >
> > > >
> > > > As you said, these updates are "cosmetic".
> > > > Nobody is worried about (or interested in) them.
> > > > Even if we miss something, they are fixable later.
> > > >
> > > > I accept embedding headers in the kernel,
> > > > but I do not like the part about external module build.
> > > >  - kernel embeds build artifacts that depend on a
> > > >    particular host-arch
> > > >  - users do not know which compiler to use
> > > > Perhaps, you may remember my concerns.
> > > > https://lore.kernel.org/patchwork/patch/1046307/#1239501
> > >
> > > Masahiro,
> > > I think we already discussed this right. The compiler issue is a user-issue -
> > > it is not a problem that has arisen because this patch. Anyone can build a
> > > kernel module today without this patch - using a compiler that is different
> > > from the running kernel. So I did not fully understand your concern. This
> > > patch does not ship a compiler in the archive. The compiler is upto the user
> > > based on user environment. They can already shoot themself in foot without
> > > this patch.
> > >
> > > Greg,
> > > Would be great to get your thoughts here as well about Masami's concern.
> > >
> > > Honestly, the "kernel module building artifacts" bit is a bonus with this
> > > patch. The main thing we are adding or that we need is really the headers
> > > (for BCC).


Yeah, this part looks solid to me.


> I just thought shipping the kernel build artifacts would also be
> > > awesome because people can now build kernel modules without needing a kernel
> > > tree at all.
> > >
> > > But I also want this stuff merged so if folks are really unhappy with the
> > > module build artifacts and only want headers - then that's also fine with me
> > > and I can yank them - that would also mean though that this work cannot be a
> > > replacement for linux-headers package on distros, so that would be sad.
> > >
> > > thanks!
> >
> > IMHO, including the module build stuff is fine, and the stuff that
> > Masahiro mentions doesn't matter much. To be specific about the
> > concerns:
> >
> > >> > >  - kernel embeds build artifacts that depend on a
> > > >    particular host-arch
> >
> > What are these artifacts? We build the kernel as a standalone system.
> > It's not as if we statically link host glibc into it or something.
>
> There are some scripts/ that are built in the host-arch ABI. These are also put
> in the archive because they are needed to build modules. So if you
> cross-compile then the archive will have scripts/ that are in the host arch,
> not the target arch. This makes it not possible to build modules on the
> target using the archive. This is not much of an issue because I already
> proved that such kernel modules can be built using a chroot in this thread:
> https://lkml.org/lkml/2019/2/28/1313
> And in the non cross-compile case, it will be immensely useful for distros..


Now the kernel depends on the host-arch that built it.
It looks somewhat weird to me.


> > > >  - users do not know which compiler to use
> >
> > Does that matter much? Do things ever break if the kernel proper is
> > built with GCC x.y.z and we build a module with GCC x.y.(z+1)? Why
> > would it? Structure layout is invariant across compiler version, or at
> > least ought to be.


The difference in the minor version
will not be a problem in practice.

The difference in the major version could be a problem.

Difference compilers have a different set of compiler options in general.

In Kbuild Makefiles, unsupported compiler options are
disabled by $(call cc-option,...).

So, users may potentially compile external modules
wit a slightly different set of flags without noticing that.

It may still work, but some compiler flags insert stubs.
There are some cases where compiler flags are sensitive.

For example, if we miss the compiler flag that was given to vmlinux,
slightly different code structure may cause kernel panic:
https://bugzilla.kernel.org/show_bug.cgi?id=201891


>  And don't we have exactly the same problem with
> > any kernel headers package? I don't think it'd hurt to include the
> > output of $(CC) --version though.
>
> Apparently there were some issues in some posting where Greg said we don't
> support anything but modules built with the same compiler as the kernel its
> being loaded into, even if such modules do work in practice. I don't recall
> the details, I can dig up that thread if you want. My point is, whether
> that's an issue or not - it is not an issue introduced by this patch. That's
> just a module building issue which we neither solve here, nor introduce.

What I can tell is, distributions provide packages of the compiler,
kernel headers, and whatever needed to compile external modules.

I feel this is a double-edged sword.


> > Like Joel, I'd like to see this change merged. It'll make life easier
> > for a lot of people.
>
> Thanks.
>
> - Joel
>


-- 
Best Regards
Masahiro Yamada
