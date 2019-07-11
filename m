Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC9C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 07:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfGKHQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 03:16:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49141 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfGKHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:16:42 -0400
Received: from [5.158.153.55] (helo=nanos.guests.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hlTJh-00006C-Pb; Thu, 11 Jul 2019 09:16:33 +0200
Date:   Thu, 11 Jul 2019 09:16:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Xi Ruoyao <xry111@mengyan1223.wang>,
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
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <89EBC357-BEAC-4252-915F-E183C2D350C4@vmware.com>
Message-ID: <alpine.DEB.2.21.1907110915570.1889@nanos.tec.linutronix.de>
References: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com> <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
 <201907091727.91CC6C72D8@keescook> <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang> <cb6d381ed7cd0bf732ae9d8f30c806b849b0f94b.camel@mengyan1223.wang> <alpine.DEB.2.21.1907101404570.1758@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1907101425290.5899@cbobk.fhfr.pm>
 <768463eb26a2feb0fcc374fd7f9cc28b96976917.camel@mengyan1223.wang> <20190710134433.GN3402@hirez.programming.kicks-ass.net> <nycvar.YFH.7.76.1907101621050.5899@cbobk.fhfr.pm> <89EBC357-BEAC-4252-915F-E183C2D350C4@vmware.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019, Nadav Amit wrote:
> > On Jul 10, 2019, at 7:22 AM, Jiri Kosina <jikos@kernel.org> wrote:
> > 
> > On Wed, 10 Jul 2019, Peter Zijlstra wrote:
> > 
> >> If we mark the key as RO after init, and then try and modify the key to
> >> link module usage sites, things might go bang as described.
> >> 
> >> Thanks!
> >> 
> >> 
> >> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> >> index 27d7864e7252..5bf7a8354da2 100644
> >> --- a/arch/x86/kernel/cpu/common.c
> >> +++ b/arch/x86/kernel/cpu/common.c
> >> @@ -366,7 +366,7 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
> >> 	cr4_clear_bits(X86_CR4_UMIP);
> >> }
> >> 
> >> -DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
> >> +DEFINE_STATIC_KEY_FALSE(cr_pinning);
> > 
> > Good catch, I guess that is going to fix it.
> > 
> > At the same time though, it sort of destroys the original intent of Kees' 
> > patch, right? The exploits will just have to call static_key_disable() 
> > prior to calling native_write_cr4() again, and the protection is gone.
> 
> Even with DEFINE_STATIC_KEY_FALSE_RO(), I presume you can just call
> set_memory_rw(), make the page that holds the key writable, and then call
> static_key_disable(), followed by a call to native_write_cr4().

That's true, but it's not worth the trouble.

Thanks,

	tglx
