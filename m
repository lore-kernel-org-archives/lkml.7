Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E95E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RFNYtuMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfCUVEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:04:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XLLrPHlC84DUyxUwAwrYQjiN/k4oVNNWVS2AaHdNgXc=; b=RFNYtuMiQ/KCJXoem/+msq8PR
        VB5ri1d3xbuCv2G21/cB9Ui/CI7mS8d2SMcXZlfA2NdosemlIMF5ZoHVG6tm43qrYMB2Bk3mx6Py4
        dQvVHEjop/lU/BQehIdShB4aADJpLzv/mz6XktH3d8bM06GVQs5B3M9tiCqAAvUJyofdN0de66YM1
        4HM9ZgG7vcTBawBOLSRiUcisFoZwUAhHcEF5v0sBr4Feo/OMku+dYZYgCqQncKnPiK4YxbdaSFQbF
        V6395txZR/VecKKFSXO15evOC0JJ/hroaly2lZpiDGcqLDB1TroOzMvTd2Sqkj3VzzBg5Wne2PYKw
        gbvZz6+5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h74qv-0005hq-BF; Thu, 21 Mar 2019 21:03:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E430B984EEA; Thu, 21 Mar 2019 22:03:50 +0100 (CET)
Date:   Thu, 21 Mar 2019 22:03:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
Message-ID: <20190321210350.GF2490@worktop.programming.kicks-ass.net>
References: <20190318153840.906404905@infradead.org>
 <20190318155139.963285969@infradead.org>
 <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
 <20190318173657.GV6058@hirez.programming.kicks-ass.net>
 <20190318175135.GE6521@hirez.programming.kicks-ass.net>
 <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com>
 <aac45ef8-0196-b1c4-67ce-26dd0da6d641@redhat.com>
 <33D32634-51DC-426D-BE4A-F78B862760D5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33D32634-51DC-426D-BE4A-F78B862760D5@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:18:05AM -0700, hpa@zytor.com wrote:
> On March 21, 2019 10:25:05 AM PDT, Denys Vlasenko <dvlasenk@redhat.com> wrote:

> >I did not see evidence of this. In my testing,
> >POPF is always ~20 cycles, even if popped flags are identical to
> >current state of flags.
> 
> I think you will find that if you change system flags it is much slower.

So with all the patches in this series applied, only x86_32 will suffer
this, and I don't think anybody still considers that a performance
critical platform.

That said, we could do something terrible like:

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -673,7 +673,8 @@ ENTRY(__switch_to_asm)
 #endif
 
        /* restore callee-saved registers */
-       popfl
+       ALTERNATIVE "popl %esi", \
+                   "popfl", X86_FEATURE_SMAP
        popl    %esi
        popl    %edi
        popl    %ebx

And then you only pay the POPF penalty when you run a 32bit kernel on a
SMAP enabled CPU, and we have a very good solution in that code: run a
64bit kernel.
