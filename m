Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11871C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343B2089E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfHFMHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:07:11 -0400
Received: from foss.arm.com ([217.140.110.172]:60768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:07:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE6228;
        Tue,  6 Aug 2019 05:07:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EFBC3F694;
        Tue,  6 Aug 2019 05:07:09 -0700 (PDT)
Date:   Tue, 6 Aug 2019 13:07:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cache: fix -Woverride-init compiler warnings
Message-ID: <20190806120706.GC475@lakrids.cambridge.arm.com>
References: <1564759944-2197-1-git-send-email-cai@lca.pw>
 <20190805095256.ocgdb2yfhnbdz6kw@willie-the-truck>
 <771C4B4C-6D79-419D-9778-5DE1BFC67FBE@lca.pw>
 <20190805140118.fys437oor2b2rnq5@willie-the-truck>
 <06613F4A-3DA7-4FF9-8616-52CB4BB58C48@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06613F4A-3DA7-4FF9-8616-52CB4BB58C48@lca.pw>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:50:03PM -0400, Qian Cai wrote:
> 
> 
> > On Aug 5, 2019, at 10:01 AM, Will Deacon <will@kernel.org> wrote:
> > 
> > On Mon, Aug 05, 2019 at 07:47:37AM -0400, Qian Cai wrote:
> >> 
> >> 
> >>> On Aug 5, 2019, at 5:52 AM, Will Deacon <will@kernel.org> wrote:
> >>> 
> >>> On Fri, Aug 02, 2019 at 11:32:24AM -0400, Qian Cai wrote:
> >>>> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> >>>> VIVT I-caches") introduced some compiation warnings from GCC,
> >>>> 
> >>>> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> >>>> overwritten [-Woverride-init]
> >>>> [ICACHE_POLICY_VIPT]  = "VIPT",
> >>>>                         ^~~~~~
> >>>> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> >>>> 'icache_policy_str[2]')
> >>>> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> >>>> overwritten [-Woverride-init]
> >>>> [ICACHE_POLICY_PIPT]  = "PIPT",
> >>>>                         ^~~~~~
> >>>> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> >>>> 'icache_policy_str[3]')
> >>>> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> >>>> overwritten [-Woverride-init]
> >>>> [ICACHE_POLICY_VPIPT]  = "VPIPT",
> >>>>                          ^~~~~~~
> >>>> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> >>>> 'icache_policy_str[0]')
> >>>> 
> >>>> because it initializes icache_policy_str[0 ... 3] twice.
> >>>> 
> >>>> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> >>>> Signed-off-by: Qian Cai <cai@lca.pw>
> >>>> ---
> >>>> arch/arm64/kernel/cpuinfo.c | 4 ++--
> >>>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>> 
> >>>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >>>> index 876055e37352..193b38da8d96 100644
> >>>> --- a/arch/arm64/kernel/cpuinfo.c
> >>>> +++ b/arch/arm64/kernel/cpuinfo.c
> >>>> @@ -34,10 +34,10 @@
> >>>> static struct cpuinfo_arm64 boot_cpu_data;
> >>>> 
> >>>> static char *icache_policy_str[] = {
> >>>> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> >>>> +	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> >>>> +	[ICACHE_POLICY_VPIPT + 1]	= "RESERVED/UNKNOWN",
> >>>> 	[ICACHE_POLICY_VIPT]		= "VIPT",
> >>>> 	[ICACHE_POLICY_PIPT]		= "PIPT",
> >>>> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> >>> 
> >>> I really don't like this patch. Using "[0 ... MAXIDX] = <default>" is a
> >>> useful idiom and I think the code is more error-prone the way you have
> >>> restructured it.
> >>> 
> >>> Why are you passing -Woverride-init to the compiler anyway? There's only
> >>> one Makefile that references that option, and it's specific to a pinctrl
> >>> driver.
> >> 
> >> Those extra warnings can be enabled by “make W=1”. “-Woverride-init “ seems to be useful
> >> to catch potential developer mistakes with unintented double-initializations. It is normal to
> >> start to fix the most of false-positives first before globally enabling the flag by default just like
> >> “-Wimplicit-fallthrough” mentioned in,
> >> 
> >> https://lwn.net/Articles/794944/
> > 
> > I think this case is completely different to the implicit fallthrough stuff.
> > The solution there was simply to add a comment without restructuring the
> > surrounding code. What your patch does here is actively make the code harder
> > to understand.
> > 
> > Initialising a static array with a non-zero pattern is a useful idiom and I
> > don't think we should throw that away just to appease a silly compiler
> > warning that appears only with non-default build options. Have a look at
> > the way we use PERF_MAP_ALL_UNSUPPORTED in the Arm PMU code, for example.
> 
> Well, both GCC and Clang would generate warnings for those. Clang even enable this by
> default,
> 
> https://releases.llvm.org/8.0.0/tools/clang/docs/DiagnosticsReference.html#winitializer-overrides
> 
> Assume compiler people are sane, I probably not call those are “silly”.

We're not disputing the sanity of compiler folk; Will did not say
anything about that.

The warning is unhelpful in the case of the [0 ... MAXIDX] = <default>
idiom, and the modification you suggest:

* Makes the code harder to read.

* Increases the necessary context. e.g. I must know the specific values
  of the enum to know that ICACHE_POLICY_VPIPT + 1 is the unallocated
  slot.

* Less robust. If the enum gets re-ordered, we must update the array.
  If the enum is expanded, new elements must be added to the array to
  initialize entries to the default value, which also makes the code
  more verbose and painful to read. IIUC if we don't explicitly
  initialize an element, we won't get a warning, which would be harmful.

If there's some way to mark the default initialization as overridable,
I think that would be fine, e.g.

struct foo *array[] = {
	[0 ... MAXIDX] __default = <default>,
	[SOMEIDX] = <someval>,
	[OTHERIDX] = <otherval>,
}

We have a number of cases where the [0 ... MAXIDX] = <default> idiom are
used, and I don't think that any of them should be changed in the manner
suggested by this patch.


Thanks,
Mark.
