Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D32BC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mengyan1223.wang header.i=@mengyan1223.wang header.b="E9qTiaTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfGJOos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:44:48 -0400
Received: from mengyan1223.wang ([89.208.246.23]:38848 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfGJOos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:44:48 -0400
Received: from [IPv6:2408:8270:a58:d980:697b:cb16:ae5f:f5aa] (unknown [IPv6:2408:8270:a58:d980:697b:cb16:ae5f:f5aa])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 4312965B50;
        Wed, 10 Jul 2019 10:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1562769888;
        bh=LQJx49Lk+JlaaB/PDCeOfvrpjy0Ym/c/NLkIXQM/GWI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E9qTiaTSWnaQZ3HQWSZkMlqHuN5ZDk/8ztSuZ+iIYU8Fs6QiZl6Y4Hj6oyshxUlqY
         47Lh9qvtD2HVsuEsowWuQXFJ5RgcfwOjETtbE0ssaS6/E7JxiMSNPi8/0ASNRrFTje
         Ml5ZMTvwUMQJDDi0vAn/Ed1cZ6aZuocgbrOXBXVylNyUajLmoeKaqMeij7ypAipjWP
         N5fPwXUjCCFU2akj4ag4migh5QpTaS5+dT5RzHHfEvLzfUbazXEEdVpU9BufE3VRJe
         yIVHqxprfIsRLQOoRgokbWmTEjjkfBbYmOOddm2XlUR3G8dpPMaV9kNDLw2fc944kJ
         OVYkK2NI1l1Cg==
Message-ID: <00e7f454c2d531cdc6033cd6e3761e8a0d60c2e0.camel@mengyan1223.wang>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Jiri Kosina <jikos@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        xry111@mengyan1223.wang
Date:   Wed, 10 Jul 2019 22:44:33 +0800
In-Reply-To: <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
References: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
         <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
         <201907091727.91CC6C72D8@keescook>
         <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
         <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang>
         <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de>
         <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
         <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang>
         <20190710134433.GN3402@hirez.programming.kicks-ass.net>
         <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-10 16:22 +0200, Jiri Kosina wrote:
> On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> 
> > If we mark the key as RO after init, and then try and modify the key to
> > link module usage sites, things might go bang as described.
> > 
> > Thanks!
> > 
> > 
> > diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> > index 27d7864e7252..5bf7a8354da2 100644
> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct
> > cpuinfo_x86 *c)
> >  	cr4_clear_bits(X86_CR4_UMIP);
> >  }
> >  
> > -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> > +DEFINE_STATIC_KEY_FALSE(cr_pinning);
> 
> Good catch, I guess that is going to fix it.

Yes it works.

> At the same time though, it sort of destroys the original intent of Kees' 
> patch, right? The exploits will just have to call static_key_disable() 
> prior to calling native_write_cr4() again, and the protection is gone.

I think I should do some study and try to understand the full story of Kees'
change...
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

