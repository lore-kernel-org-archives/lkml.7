Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7EDC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDD206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9pRcmqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfHNR0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:26:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55851 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfHNR0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:26:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so5253827wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNjTRM/T7OXW0nZJunZsUPEa7EgL/wJtZiGTQlV3OHQ=;
        b=T9pRcmqG6NuGeq8Z11fIDsWIww+aIe02v4ziKCzBf6quxQBZuci9T0nbxltbJkKUzM
         kLU2rvIfHM1nQ0j0K3OQjPN5BqNzks7m6baXJaYMy5Jz3dbQHUk0lbQMfXRHaPbgqBQL
         ZoJBMkEgH888ZAVE4AAqW1mAUwJab0yL5pCoDGMvWfWqfOxgqcVenbL4BYwocBMem82a
         mj4GTf3sJb5UagumaVIhq9StuEVnwm90WOJOE1n3F+kKiCWpeqejSY9S+G09xH3N6MqL
         8rUqLfqWhPc5Np9qs0XPLaQvHCcd2J/7hw/h/qDmg/zRjt2NdYVaC5KIr/V3RX2vH1Jo
         FoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNjTRM/T7OXW0nZJunZsUPEa7EgL/wJtZiGTQlV3OHQ=;
        b=pA6vHIQ/eyC9M400pmoZp6tguIfPwQq9UKQv6Erq+AsZuqxzXDQFjfgeQM6TyMnASw
         tcF5CWUcaRX3CvT2oiGKBlCu6K54gl/XcZSMtY0pCn07bs0xVFx0ZqGC+xebdn8hmmSi
         R5NLzupHi6UNtQFS1JXEO7AYchDjowzNcy0Z2xJzaJ77lJzoel6Rzl6jfvLOzxOPHfFy
         NHBVJlpNBAIj0XWgOdLasNPBYQ61mSFciDxw8sjE85tX3I/L2+J5DNXFjA8SNRxLjYTc
         51qmvEb6U69LDUio6HHxExPPEXn7j8qr8IAh8kBg0HjvdHQvQFZveQoxDRl29OKR2u29
         POYA==
X-Gm-Message-State: APjAAAUvHaQ2OgoQKnJ3dpmLCLIuKUzEgCOp7C5rvnPrWG+F91Ak6ZtK
        S7bjFOUtNvyXc+xAqr5ngmc=
X-Google-Smtp-Source: APXvYqxhoLfBKKYxZC9FhueVnfsOm9dE5gx8yqSEV3RTDUAW1pkOq/EFjsOI95yEQvdMFwm2C7ssQQ==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr202651wmi.137.1565803602609;
        Wed, 14 Aug 2019 10:26:42 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id p4sm373092wrs.6.2019.08.14.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 10:26:42 -0700 (PDT)
Date:   Wed, 14 Aug 2019 10:26:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qian Cai <cai@lca.pw>, will@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: Explicitly marking initializer overrides (was "Re: [PATCH]
 arm64/cache: silence -Woverride-init warnings")
Message-ID: <20190814172640.GA116758@archlinux-threadripper>
References: <20190808032916.879-1-cai@lca.pw>
 <20190808103808.GC46901@lakrids.cambridge.arm.com>
 <20190808170916.GA32668@archlinux-threadripper>
 <20190809083251.GA48423@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809083251.GA48423@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:32:51AM +0100, Mark Rutland wrote:
> On Thu, Aug 08, 2019 at 10:09:16AM -0700, Nathan Chancellor wrote:
> > On Thu, Aug 08, 2019 at 11:38:08AM +0100, Mark Rutland wrote:
> > > On Wed, Aug 07, 2019 at 11:29:16PM -0400, Qian Cai wrote:
> > > > The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> > > > VIVT I-caches") introduced some compiation warnings from GCC (and
> > > > Clang) with -Winitializer-overrides),
> > > > 
> > > > arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> > > > overwritten [-Woverride-init]
> > > > [ICACHE_POLICY_VIPT]  = "VIPT",
> > > >                         ^~~~~~
> > > > arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> > > > 'icache_policy_str[2]')
> > > > arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> > > > overwritten [-Woverride-init]
> > > > [ICACHE_POLICY_PIPT]  = "PIPT",
> > > >                         ^~~~~~
> > > > arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> > > > 'icache_policy_str[3]')
> > > > arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> > > > overwritten [-Woverride-init]
> > > > [ICACHE_POLICY_VPIPT]  = "VPIPT",
> > > >                          ^~~~~~~
> > > > arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> > > > 'icache_policy_str[0]')
> > > > 
> > > > because it initializes icache_policy_str[0 ... 3] twice. Since
> > > > arm64 developers are keen to keep the style of initializing a static
> > > > array with a non-zero pattern first, just disable those warnings for
> > > > both GCC and Clang of this file.
> > > > 
> > > > Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > 
> > > This is _not_ a fix, and should not require backporting to stable trees.
> > > 
> > > What about all the other instances that we have in mainline?
> > > 
> > > I really don't think that we need to go down this road; we're just going
> > > to end up adding this to every file that happens to include a header
> > > using this scheme...
> > > 
> > > Please just turn this off by default for clang.
> > > 
> > > If we want to enable this, we need a mechanism to permit overridable
> > > assignments as we use range initializers for.
> > > 
> > > Thanks,
> > > Mark.
> > > 
> > 
> > For what it's worth, this is disabled by default for clang in the
> > kernel:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.extrawarn?h=v5.3-rc3#n69
> > 
> > It only becomes visible with clang at W=1 because that section doesn't
> > get applied. It becomes visible with GCC at W=1 because of -Wextra.
> 
> Thanks for clarifying that!
> 
> Do you know if there's any existing mechanism that we can use to silence
> the warning on a per-assignment basis? Either to say that an assignment
> can be overridden, or that the assignment is expected to override an
> existing assignment?
> 

I don't think there is, from the brief amount of research I did.

> If not, who would be able to look at adding a mechanism to clang for
> this?
> 

I've filed https://github.com/ClangBuiltLinux/linux/issues/639 on our
issue tracker so that I can try to remember to distill all of this
down and file an LLVM bug.

> If we could have some attribute or intrinsic that we could wrap like:
> 
> struct foo f = {
> 	.bar __defaultval = <default>,
> 	.bar = <newval>,		// no warning
> 	.bar = <anotherval>,		// warning
> };
> 
> ... or:
> 
> struct foo f = {
> 	.bar = <default>,
> 	.bar __override = <newval>,	// no warning
> 	.bar = <anotherval>,		// warning
> };
> 
> ... or:
> 	
> 	.bar = OVERRIDE(<newval>),	// no warning
> 
> ... or:
> 	OVERRIDE(.bar) = <newval>,	// no warning
> 
> ... then I think it would be possible to make use of the warning
> effectively, as we could distinguish intentional overrides from
> unintentional ones, and annotating assignments in this way doesn't seem
> onerous to me.
> 
> Thanks,
> Mark.

I definitely think it is an interesting idea, hopefully some of our
resident clang experts can weigh in and see how feasible it would be to
implement.

Cheers,
Nathan
