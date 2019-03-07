Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE55BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF69B20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MMTf+qM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfCGRCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:02:54 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53568 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfCGRCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:02:54 -0500
Received: from zn.tnic (unknown [IPv6:2003:ec:2f08:1c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71BE81EC066F;
        Thu,  7 Mar 2019 18:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551978171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y3qq1FJAtgMcBrhxJOuu6fPyW4x/qy6rfTwk7P7bdN4=;
        b=MMTf+qM5o5XuoSWwaEXahf1r1N0Uzibm438tZBQJCyJa28wh0t3NHqV9+LCJc/KAUVt0F4
        /cYa61X4/5ES4JmSh89MXAEWV0xafzdCuIDLPjbWxu4Gu8NVU7b7/xRFzc2AGidX/jTp7x
        sA46QeeJG2aL3u03dxDA5CCVDdKx6F0=
Date:   Thu, 7 Mar 2019 18:02:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     hpa@zytor.com
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/cpufeature: Remove __pure attribute to
 _static_cpu_has()
Message-ID: <20190307170254.GF26566@zn.tnic>
References: <20190211182956.GN19618@zn.tnic>
 <1533F2BB-2284-499B-9912-6D74D0B87BC1@gmail.com>
 <20190211190108.GP19618@zn.tnic>
 <A671F14F-3E03-4A97-9F54-426533077E0C@gmail.com>
 <20190211191059.GR19618@zn.tnic>
 <3996E3F9-92D2-4561-84E9-68B43AC60F43@gmail.com>
 <20190211194251.GS19618@zn.tnic>
 <A55214F3-CDC0-44C4-AFB6-7E8E23CC6F85@gmail.com>
 <20190307151036.GD26566@zn.tnic>
 <D683E00D-845E-4970-80DE-AD1DED3AE609@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D683E00D-845E-4970-80DE-AD1DED3AE609@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lemme preface this by saying that I've talked to gcc guys before doing
this.

On Thu, Mar 07, 2019 at 08:43:50AM -0800, hpa@zytor.com wrote:
> Uhm... (a) it is correct, even if the compiler doesn't use it now, it
> allows the compiler to CSE it in the future;

Well, the compiler won't CSE asm blocks due to the difference in the
labels, for example, so the heuristic won't detect them as equivalent
blocks.

Also, compiler guys said that they might consider inlining pure
functions later, in the IPA stage but that's future stuff.

This is how I understood it, at least.

> (b) it is documentation;

That could be a comment instead. Otherwise we will wonder again why this
is marked pure.

> (c) there is an actual bug here: the "volatile" implies a side effect,
> which in reality is not present, inhibiting CSE.
>
> So the correct fix is to remove "volatile", not remove "__pure".

There's not really a volatile there:

/*
 * GCC 'asm goto' miscompiles certain code sequences:
 *
 *   http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
 *
 * Work it around via a compiler barrier quirk suggested by Jakub Jelinek.
 *
 * (asm goto is automatically volatile - the naming reflects this.)
 */
#define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
