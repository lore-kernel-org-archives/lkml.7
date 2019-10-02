Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D371C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1727E21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfJBUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfJBUsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:48:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1494C309DEE2;
        Wed,  2 Oct 2019 20:48:11 +0000 (UTC)
Received: from treble (ovpn-121-106.rdu2.redhat.com [10.10.121.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA6585B681;
        Wed,  2 Oct 2019 20:48:05 +0000 (UTC)
Date:   Wed, 2 Oct 2019 15:48:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 10/15] static_call: Add basic static call infrastructure
Message-ID: <20191002204803.jb2q6cufudau6txf@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131945.125037517@infradead.org>
 <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com>
 <20190607082851.GV3419@hirez.programming.kicks-ass.net>
 <20191002135417.GS4519@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002135417.GS4519@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 02 Oct 2019 20:48:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 03:54:17PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 07, 2019 at 10:28:51AM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 06, 2019 at 10:44:23PM +0000, Nadav Amit wrote:
> > > > + * Usage example:
> > > > + *
> > > > + *   # Start with the following functions (with identical prototypes):
> > > > + *   int func_a(int arg1, int arg2);
> > > > + *   int func_b(int arg1, int arg2);
> > > > + *
> > > > + *   # Define a 'my_key' reference, associated with func_a() by default
> > > > + *   DEFINE_STATIC_CALL(my_key, func_a);
> > > > + *
> > > > + *   # Call func_a()
> > > > + *   static_call(my_key, arg1, arg2);
> > > > + *
> > > > + *   # Update 'my_key' to point to func_b()
> > > > + *   static_call_update(my_key, func_b);
> > > > + *
> > > > + *   # Call func_b()
> > > > + *   static_call(my_key, arg1, arg2);
> > > 
> > > I think that this calling interface is not very intuitive.
> > 
> > Yeah, it is somewhat unfortunate..
> > 
> > > I understand that
> > > the macros/objtool cannot allow the calling interface to be completely
> > > transparent (as compiler plugin could). But, can the macros be used to
> > > paste the key with the “static_call”? I think that having something like:
> > > 
> > >   static_call__func(arg1, arg2)
> > > 
> > > Is more readable than
> > > 
> > >   static_call(func, arg1, arg2)
> > 
> > Doesn't really make it much better for me; I think I'd prefer to switch
> > to the GCC plugin scheme over this.  ISTR there being some propotypes
> > there, but I couldn't quickly locate them.
> 
> How about something like:
> 
> 	static_call(key)(arg1, arg2);
> 
> which is very close to the regular indirect call syntax.

Looks ok to me.

> Furthermore, how about we put the trampolines in .static_call.text
> instead of relying on prefixes?

Yeah, that would probably be better.

> Also, I think I can shrink static_call_key by half:
> 
>  - we can do away with static_call_key::tramp; there are only two usage
>    sites:
> 
>      o __static_call_update, the static_call() macro can provide the
>        address of STATIC_CALL_TRAMP(key) directly
> 
>      o static_call_add_module(), has two cases:
> 
>        * the trampoline is from outside the module; in this case
>          it will already have been updated by a previous call to
> 	 __static_call_update.
>        * the trampoline is from inside the module; in this case
>          it will have the default value and it doesn't need an
> 	 update.
> 
>        so in no case does static_call_add_module() need to modify a
>        trampoline.

Sounds plausible.

>   - we can change static_call_key::site_mods into a single next pointer,
>     just like jump_label's static_key.

Yep.

> But so far all the schemes I've come up with require 'key' to be a name,
> it cannot be an actual 'struct static_call_key *' value. And therefore
> usage from within structures isn't allowed.

Is that something we need?  At least we were able to work around this
limitation with tracepoints' usage of static calls.  But I could see how
it could be useful.

One way to solve that would be a completely different implementation:
have a global trampoline which detects the call site of the caller,
associates it with the given key, schedules some work to patch the call
site later, and then jumps to key->func.  So the first call would
trigger the patching.

Then we might not even need objtool :-)  But it might be tricky to pull
off.

-- 
Josh
