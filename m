Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F254C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5365520B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406001AbfHIIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:53:37 -0400
Received: from foss.arm.com ([217.140.110.172]:43642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405785AbfHIIxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:53:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9AA8344;
        Fri,  9 Aug 2019 01:53:35 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE65A3F706;
        Fri,  9 Aug 2019 01:53:34 -0700 (PDT)
Date:   Fri, 9 Aug 2019 09:53:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64/cache: silence -Woverride-init warnings
Message-ID: <20190809085332.GB48423@lakrids.cambridge.arm.com>
References: <20190808032916.879-1-cai@lca.pw>
 <20190808103808.GC46901@lakrids.cambridge.arm.com>
 <D2A2F2B9-0563-4DF6-8E77-F191A768CE4E@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D2A2F2B9-0563-4DF6-8E77-F191A768CE4E@lca.pw>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 06:18:39PM -0400, Qian Cai wrote:
> > On Aug 8, 2019, at 6:38 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Wed, Aug 07, 2019 at 11:29:16PM -0400, Qian Cai wrote:
> >> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> >> VIVT I-caches") introduced some compiation warnings from GCC (and
> >> Clang) with -Winitializer-overrides),
> >> 
> >> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> >> overwritten [-Woverride-init]
> >> [ICACHE_POLICY_VIPT]  = "VIPT",
> >>                        ^~~~~~
> >> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> >> 'icache_policy_str[2]')
> >> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> >> overwritten [-Woverride-init]
> >> [ICACHE_POLICY_PIPT]  = "PIPT",
> >>                        ^~~~~~
> >> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> >> 'icache_policy_str[3]')
> >> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> >> overwritten [-Woverride-init]
> >> [ICACHE_POLICY_VPIPT]  = "VPIPT",
> >>                         ^~~~~~~
> >> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> >> 'icache_policy_str[0]')
> >> 
> >> because it initializes icache_policy_str[0 ... 3] twice. Since
> >> arm64 developers are keen to keep the style of initializing a static
> >> array with a non-zero pattern first, just disable those warnings for
> >> both GCC and Clang of this file.
> >> 
> >> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> > 
> > This is _not_ a fix, and should not require backporting to stable trees.
> 
> From my experience, the stable AI will pick up whatever they want to backport
> not matter if there Is a “Fixes” tag or not unless it is one of those subsystems like
> Networking that exclusively manually flag for. backporting by the maintainer.  

My point is that this patch does not require backporting, and hence does
not require a fixes tag. The stable AI may choose the patch regardless,
so it's irrelevant.

[...]

> > What about all the other instances that we have in mainline?
> 
> I have not had a chance to review all instances yet. It is not unusually to fix one
> warning at a time, and then go on fixing some more if time permit.

Given that:

* All the suggested code changes so far are harmful to legibility,
  robustness, and maintainability of the code.

* The majority of the warnings (by orders of magnitude) occur for
  intentional overrides, rather than unintentional overrides, as
  assigning default values to arrays and structs is a common idiom.

* We have no known mechanism to selectively disable the warning on a
  per-assignment basis.

... I do not think that is an appropriate strategy here.

For example, I'm fairly certain that if you try to "fix" the instances
in syscall tables, many more people will complain.

A much better approach would be to analyse the warnings, and either:

* find the _real_ bugs where we unintentionally override fields and fix
  those first, or:

* Find the instances that produce the greatest set of false positives
  (e.g. the syscall tables), and figure out how to suppress those
  without harming the maintainability or robustness of the code.

> > I really don't think that we need to go down this road; we're just going
> > to end up adding this to every file that happens to include a header
> > using this scheme…
> 
> How about disable them this way in a top level like arch/arm64/Makefile or
> arch/arm64/kernel/Makefile? Therefore, there is no need to add this to
> every file, but with a drawback that it could miss a few real issues there
> in the future which probably not many people are checking for them of
> the arm64 subsystem nowadays.

This isn't arm64-specific. We validly use duplicate assignments all over
the kernel, and my position is that we either:

* Find a mechanism to suppress the warning on a per-assignment (not
  per-file) basis, without altering the structure of the existing code.

* Disable the warning tree-wide.

I would vastly prefer the former, as I do agree that this warning _can_
find real bugs, but similarly so can a script that warns "Line $N may
contain a bug" for every line of a C file.

> > Please just turn this off by default for clang.
> 
> As mentioned before, it is very valuable to run “make W=1” given it found
> many real developer mistakes which will enable “-Woverride-init” for both
> compilers. Even “-Woverride-init” itself is useful find real issues as in,
> 
> ae5e033d65a (“mfd: rk808: Fix RK818_IRQ_DISCHG_ILIM initializer”)
> 32df34d875bb (“[media] rc: img-ir: jvc: Remove unused no-leader timings”)
> 
> Especially, to find redundant initializations in large structures. e.g.,
> 
> e6ea0b917875 (“[media] dvb_frontend: Don't declare values twice at a table”)
> 
> It is important to keep the noise-level as low as possible by keeping the
> amount of false positives under control to be truly benefit from those
> valuable compiler warnings. 

I agree that we want to minimize the noise, but not at the expense of
the maintainability and robustness of the code, and not by disabling
warnings for arbitrary files.

> > If we want to enable this, we need a mechanism to permit overridable
> > assignments as we use range initializers for.
> 
> I am not sure that it is worth filling a RFE for compilers of that feature.

If that's your position, then I see no point continuing this conversation.

> I feel like the range initializers just another way to initialize an array, and
>  it is just easier to make mistakes with unintended double-initializations.
> The compiler developers probably recommend to enforce more of
> “-Woverride-init” for  the range initializers rather than permitting it.

From my analysis in a prior reply, the vast majority of duplicate
assignments in the kernel are intentional. We do that for both arrays
and structures in order to have defaults that can be overridden.

If the compiler developers don't think that's worth supporting, then the
feature is not worth using.

Thanks,
Mark.
