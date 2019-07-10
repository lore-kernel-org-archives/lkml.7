Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C232FC73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F23120665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFy61xio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGJFdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:33:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38947 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfGJFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:33:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so517060pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OrOSsNxhIZciYkcjMPmuwLUMYCtrLlEpope/siqRImQ=;
        b=oFy61xio6o5o6oZg8qDjk3UiunlMiqbQ4BxAszWVjl46cUNLQFKBQA1E+kvQ1wg+6y
         IL3syUiT+53vzqWykBbKQ2e+I/TpGmxuvUEJYFOIrMUl2q7tAROuRAw5ZpccUMfBucvx
         8kecSKc+Yw5XwLTzqxf9ZOkM/d9ZdTljiqMlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OrOSsNxhIZciYkcjMPmuwLUMYCtrLlEpope/siqRImQ=;
        b=ByzVM2EhxKgEVpBjoRZ8yMRI/Sc9eQxCKWY98aP+QuyBpgd1QwW6PLCFn9I9Ppa4C6
         0/FmHDeyTCngNJZT+zRq7QTWr7gEkSgRpuLtHLlqnQq3EG6OPkf9qbSHbDk2puNIfGE6
         6T41T0GCFWKB3fmMpiVt58D2xIJVGChgy+unz0KG/PbGqzFtiTQXd5vmKC0I5LoH1Pz/
         Wg3AZ6e2hD3uey19Kibg7ac38ROBoql49PoiR+L1xVflC/oRD8xo4rx9IMGd6VCuJELI
         Xp41JQFbZ7/FlhiMKL1aYhIHhLGWri/AyS7ds3Pj95r7OVtqCn3SAabo0pCcp7wMzDMr
         bp2Q==
X-Gm-Message-State: APjAAAVELi/sLIJ3HpRNei8NcGnS0uwa3iqs19MYU7MRqIE8F/iRhqEU
        Jnf9x4IY1RXcuVNaDse5yZPIJg==
X-Google-Smtp-Source: APXvYqy2iJVge6LqUSDvIBef/YANWezau9Fxp5ZeU5uepXbfFhmbjUTuuON5+53ENiIZvmAe21IVjg==
X-Received: by 2002:a17:90a:376f:: with SMTP id u102mr4705725pjb.5.1562736797257;
        Tue, 09 Jul 2019 22:33:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm733141pjt.30.2019.07.09.22.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 22:33:16 -0700 (PDT)
Date:   Tue, 9 Jul 2019 22:33:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
Message-ID: <201907092227.6ED4CB9C@keescook>
References: <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
 <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
 <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
 <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
 <CAHk-=wj5E=WTz3jfNFnupCPoLXDyFZdW1xgKvuuU-M1_7MEqaw@mail.gmail.com>
 <CAHk-=wghD6CzP7NxHzG4_-bAqOiad_aAohdETDTpUpyci55kfg@mail.gmail.com>
 <CAHk-=wgqVLVeBZi8t+2GpTxGdFpD2FsdkL81irF8tc=qqG0t_w@mail.gmail.com>
 <CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:15:21PM -0700, Linus Torvalds wrote:
> On Tue, Jul 9, 2019 at 8:21 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Whee. It looks like it's bisecting to the same thing. Only partway
> > done, but it feels very much like my desktop.
> 
> Confirmed.
> 
> With that config, I get this
> 
>   c21ac93288f0 (refs/bisect/bad) Merge tag 'v5.2-rc6' into x86/asm, to
> refresh the branch
>   8dbec27a242c (HEAD) x86/asm: Pin sensitive CR0 bits
>   873d50d58f67 x86/asm: Pin sensitive CR4 bits
> 
> ie those "pin sensitive bits" merge is bad, but before the commits is good.
> 
> I think there is _another_ problem too, and maybe it's the APCI one,
> but this one triggers some issue before the other issue even gets to
> play..

Okay, fun. Thanks for confirming it. Well, I guess I get to try to
find some more modern hardware to track this down. Does booting with
init=/bin/sh get far enough to see if all the CPUs are online or anything
like that? I'm baffled about the "gets mostly to userspace" part. I'd
expect this to explode very badly if it misbehaved. Or maybe something
gets confused between how many CPUs are expected and how many actually
show up to the party. Hmmm.

-- 
Kees Cook
