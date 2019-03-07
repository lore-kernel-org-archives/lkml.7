Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB0BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435AB20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCGQou convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:44:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59551 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGQou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:44:50 -0500
Received: from [IPv6:2607:fb90:363c:d311:852d:262d:594c:4506] ([IPv6:2607:fb90:363c:d311:852d:262d:594c:4506])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x27Ghstd2258097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Mar 2019 08:43:55 -0800
Date:   Thu, 07 Mar 2019 08:43:50 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190307151036.GD26566@zn.tnic>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com> <20190129003422.9328-11-rick.p.edgecombe@intel.com> <20190211182956.GN19618@zn.tnic> <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com> <20190211190108.GP19618@zn.tnic> <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com> <20190211191059.GR19618@zn.tnic> <3996E3F9-92D2-4561-84E9-68B43AC60F43@gmail.com> <20190211194251.GS19618@zn.tnic> <A55214F3-CDC0-44C4-AFB6-7E8E23CC6F85@gmail.com> <20190307151036.GD26566@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/cpufeature: Remove __pure attribute to _static_cpu_has()
To:     Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
From:   hpa@zytor.com
Message-ID: <D683E00D-845E-4970-80DE-AD1DED3AE609@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 7, 2019 7:10:36 AM PST, Borislav Petkov <bp@alien8.de> wrote:
>On Mon, Feb 11, 2019 at 12:32:41PM -0800, Nadav Amit wrote:
>> BTW: the “__pure” attribute is useless when “__always_inline” is
>used.
>> Unless it is intended to be some sort of comment, of course.
>
>---
>From: Borislav Petkov <bp@suse.de>
>Date: Thu, 7 Mar 2019 15:54:51 +0100
>
>__pure is used to make gcc do Common Subexpression Elimination (CSE)
>and thus save subsequent invocations of a function which does a complex
>computation (without side effects). As a simple example:
>
>  bool a = _static_cpu_has(x);
>  bool b = _static_cpu_has(x);
>
>gets turned into
>
>  bool a = _static_cpu_has(x);
>  bool b = a;
>
>However, gcc doesn't do CSE with asm()s when those get inlined - like
>it
>is done with _static_cpu_has() - because, for example, the t_yes/t_no
>labels are different for each inlined function body and thus cannot be
>detected as equivalent anymore for the CSE heuristic to hit.
>
>However, this all is beside the point because best it should be avoided
>to have more than one call to _static_cpu_has(X) in the same function
>due to the fact that each such call is an alternatives patch site and
>it
>is simply pointless.
>
>Therefore, drop the __pure attribute as it is not doing anything.
>
>Reported-by: Nadav Amit <nadav.amit@gmail.com>
>Signed-off-by: Borislav Petkov <bp@suse.de>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: x86@kernel.org
>---
> arch/x86/include/asm/cpufeature.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/cpufeature.h
>b/arch/x86/include/asm/cpufeature.h
>index e25d11ad7a88..6d6d5cc4302b 100644
>--- a/arch/x86/include/asm/cpufeature.h
>+++ b/arch/x86/include/asm/cpufeature.h
>@@ -162,7 +162,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c,
>unsigned int bit);
>* majority of cases and you should stick to using it as it is generally
>  * only two instructions: a RIP-relative MOV and a TEST.
>  */
>-static __always_inline __pure bool _static_cpu_has(u16 bit)
>+static __always_inline bool _static_cpu_has(u16 bit)
> {
> 	asm_volatile_goto("1: jmp 6f\n"
> 		 "2:\n"

Uhm... (a) it is correct, even if the compiler doesn't use it now, it allows the compiler to CSE it in the future; (b) it is documentation; (c) there is an actual bug here: the "volatile" implies a side effect, which in reality is not present, inhibiting CSE.

So the correct fix is to remove "volatile", not remove "__pure".
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
