Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3D3205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xyq7TKxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDCRUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:20:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:20:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so5384534plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kGUNQRr8wFBx0Ky+XAPBIRxY0Q1MoBrpm+ZTJCdrmIQ=;
        b=xyq7TKxxfKgn0NhN9pTk1kTrsUfqOIhGr7CPlSVDNJi4QXM3QaXC/hDhr9t/IqAba1
         4iwnmoLodGB2oXs8RpnqudUjZk02Hjo03LDjFkGW4koIBGY7f/5RCEaVIH3h6tU7oJuU
         5k/SAl6a+Bv5vLgr5hF6Ae/MrHyRcIQUpdjzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kGUNQRr8wFBx0Ky+XAPBIRxY0Q1MoBrpm+ZTJCdrmIQ=;
        b=MtD5eQLquOF3y/ZS3rMryPTfZszk175q63kuEZ/B+9jdRZCjjJYFiAyOaRdc744CFf
         3dYrycSHxf2rsrTz5p6kzyqGWL+JIkHx6VS+PpzMOTCWKfUoF5GggfbdpcOeU43s2lqE
         8zweeXmzs53L8cKgqkJzsGmrT1bfjcIh3YBDQoSAW4h6g5KfANNCmH1JGd9b+0Jinqej
         4JWrNpGYVQXxBO+8NkDbO4BdMwHqGVCwaEBsuCzbMfQKrIkVFwFPFgIhv25KIT2pWwlY
         sjkZ8wbOMI4ZTlZ08/7UXFhx/est4R/JbzkkI79rKuVjZD/W/h/BpWpqgyKyFozUlEC3
         AkRA==
X-Gm-Message-State: APjAAAXQ3XcZRUweCIFpO8Wu0A09j0oNzBwMwJkef4HgENAV0JzOTSe1
        Iq06r39iAt+uj8tpMj+QP0GcrA==
X-Google-Smtp-Source: APXvYqywlgjkToE3Nveo3qz7923sPdO4veypp46Hz63EetXNYJAPsizwX8AQ824V0ZLe+dshxplq7Q==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr1137873plo.183.1554312034310;
        Wed, 03 Apr 2019 10:20:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b7sm51077810pfj.67.2019.04.03.10.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 10:20:33 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:20:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
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
Subject: Re: [PATCH v2 1/2] Provide in-kernel headers for making it easy to
 extend the kernel
Message-ID: <20190403172031.GA260189@google.com>
References: <20190211143600.15021-1-joel@joelfernandes.org>
 <20190215031926.ljzluy2cfxp64u6o@ast-mbp>
 <20190325134947.GA187133@google.com>
 <20190327173103.GA205980@google.com>
 <CAK7LNARcaVtgHvco-Q=E5jhOXduk=55g9AC7nFn2esFxnk9Naw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARcaVtgHvco-Q=E5jhOXduk=55g9AC7nFn2esFxnk9Naw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:48:37PM +0900, Masahiro Yamada wrote:
> On Thu, Mar 28, 2019 at 2:32 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, Mar 25, 2019 at 09:49:47AM -0400, Joel Fernandes wrote:
> > > On Thu, Feb 14, 2019 at 07:19:29PM -0800, Alexei Starovoitov wrote:
> > > > On Mon, Feb 11, 2019 at 09:35:59AM -0500, Joel Fernandes (Google) wrote:
> > > > > Introduce in-kernel headers and other artifacts which are made available
> > > > > as an archive through proc (/proc/kheaders.txz file). This archive makes
> > > > > it possible to build kernel modules, run eBPF programs, and other
> > > > > tracing programs that need to extend the kernel for tracing purposes
> > > > > without any dependency on the file system having headers and build
> > > > > artifacts.
> > > > >
> > > > > On Android and embedded systems, it is common to switch kernels but not
> > > > > have kernel headers available on the file system. Raw kernel headers
> > > > > also cannot be copied into the filesystem like they can be on other
> > > > > distros, due to licensing and other issues. There's no linux-headers
> > > > > package on Android. Further once a different kernel is booted, any
> > > > > headers stored on the file system will no longer be useful. By storing
> > > > > the headers as a compressed archive within the kernel, we can avoid these
> > > > > issues that have been a hindrance for a long time.
> > > >
> > > > The set looks good to me and since the main use case is building bpf progs
> > > > I can route it via bpf-next tree if there are no objections.
> > > > Masahiro, could you please ack it?
> > >
> > > FYI, Masahiro's comments were all address by v5:
> > > https://lore.kernel.org/patchwork/project/lkml/list/?series=387311
> > >
> > > I believe aren't more outstanding concerns. Could we consider it for v5.2?
> >
> > Just to highlight the problem, today I booted v5.0 on an emulated Android
> > device for some testing, that didn't have a set of prebuilt headers that we
> > have been packaging on well known kernels, to get around this issue. This
> > caused great pain and issues with what I was doing. I know me and many others
> > really want this. With this I can boot an emulated Android device with
> > IKCONFIG_PROC=y and run BCC with that that. Also I want to do the BCC side of
> > the development, but first want to know if we can merge this upstream.
> >
> > Masahiro, I believe due diligence has been done in solidifying it as posted
> > in the v5.  Anything else we need to do here? Are you with the patches?
> 
> 
> As you said, these updates are "cosmetic".
> Nobody is worried about (or interested in) them.
> Even if we miss something, they are fixable later.
> 
> I accept embedding headers in the kernel,
> but I do not like the part about external module build.
>  - kernel embeds build artifacts that depend on a
>    particular host-arch
>  - users do not know which compiler to use
> Perhaps, you may remember my concerns.
> https://lore.kernel.org/patchwork/patch/1046307/#1239501

Masahiro,
I think we already discussed this right. The compiler issue is a user-issue -
it is not a problem that has arisen because this patch. Anyone can build a
kernel module today without this patch - using a compiler that is different
from the running kernel. So I did not fully understand your concern. This
patch does not ship a compiler in the archive. The compiler is upto the user
based on user environment. They can already shoot themself in foot without
this patch.

Greg,
Would be great to get your thoughts here as well about Masami's concern.

Honestly, the "kernel module building artifacts" bit is a bonus with this
patch. The main thing we are adding or that we need is really the headers
(for BCC). I just thought shipping the kernel build artifacts would also be
awesome because people can now build kernel modules without needing a kernel
tree at all.

But I also want this stuff merged so if folks are really unhappy with the
module build artifacts and only want headers - then that's also fine with me
and I can yank them - that would also mean though that this work cannot be a
replacement for linux-headers package on distros, so that would be sad.

thanks!

- Joel

> 
> --
> Best Regards
> Masahiro Yamada
