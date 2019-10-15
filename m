Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68956C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3790221925
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571144872;
	bh=+whaQ+MwPGJtmr2IHZWtOifmLos+iQ1uyyBF1Jo9wo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f9JQG9y7nR7DTpXoTfonxjwRKAFH8zIgyEEwOfUr9zUa76hoC1HqGQDuWtmZjQHuc
	 ze6CsVLPOhhhLmwUPVurArbgkb3Azz4tHSQAoNtHqkEWdtm81puoCHtMiZ46YkBJL7
	 Dxxn/IsfKcCGHTJnOPp90Ds03+olXvxw1vOl38qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfJONHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfJONHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:07:50 -0400
Received: from linux-8ccs (ip5f5adbbb.dynamic.kabel-deutschland.de [95.90.219.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC2321848;
        Tue, 15 Oct 2019 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571144870;
        bh=+whaQ+MwPGJtmr2IHZWtOifmLos+iQ1uyyBF1Jo9wo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iSWhwaqhbADtsPJv5sDQ8fvqZR5CgmAUDS8fHrqYqWm5BO6wc42vCi2mpotfTsa6N
         u2yuYWnNou+6OsOBOyuv7f5aCNfCAHrcMFI6MUyXYmJOY5BudHglwFphd09hR5DJf7
         hFstr53SfQarJVb1bfu8zvbQ36Rp2QUdRuWnayvg=
Date:   Tue, 15 Oct 2019 15:07:40 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191015130739.GA23565@linux-8ccs>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081945.10951536.8@infradead.org>
 <20191008104335.6fcd78c9@gandalf.local.home>
 <20191009224135.2dcf7767@oasis.local.home>
 <20191010092054.GR2311@hirez.programming.kicks-ass.net>
 <20191010091956.48fbcf42@gandalf.local.home>
 <20191010140513.GT2311@hirez.programming.kicks-ass.net>
 <20191010115449.22044b53@gandalf.local.home>
 <20191010172819.GS2328@hirez.programming.kicks-ass.net>
 <20191011125903.GN2359@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191011125903.GN2359@hirez.programming.kicks-ass.net>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Peter Zijlstra [11/10/19 14:59 +0200]:
>On Thu, Oct 10, 2019 at 07:28:19PM +0200, Peter Zijlstra wrote:
>
>> Really the best solution is to move all the poking into
>> ftrace_module_init(), before we mark it RO+X. That's what I'm going to
>> do for jump_label and static_call as well, I just need to add that extra
>> notifier callback.
>
>OK, so I started writing that patch... or rather, I wrote the patch and
>started on the Changelog when I ran into trouble describing why we need
>it.
>
>That is, I'm struggling to explain why we cannot flip
>prepare_coming_module() and complete_formation().
>
>Yes, it breaks ftrace, but I'm thinking that is all it breaks. So let me
>see if we can cure that.

I'm having trouble visualizing what changes you're planning on making.
I get that you want to squash ftrace_module_enable() into
ftrace_module_init(), before module_enable_ro(). I'm fine with that as
long as the races Steven described are addressed for affected arches.
And livepatch should be OK as long as klp_module_coming() is always
called *after* ftrace_module_enable(). But are you moving
klp_module_coming() before the module_enable_* calls as well?  And if
so, why?

>The fact that it is executable; also the fact that you do it right after
>we mark it ro. Flipping the memory protections back and forth is just
>really poor everything.
>
>Once this ftrace thing is sorted, we'll change x86 to _refuse_ to make
>executable (kernel) memory writable.

Not sure if relevant, but just thought I'd clarify: IIRC,
klp_module_coming() is not poking the coming module, but it calls
module_enable_ro() on itself (the livepatch module) so it can apply
relocations and such on the new code, which lives inside the livepatch
module, and it needs to possibly do this numerous times over the
lifetime of the patch module for any coming module it is responsible
for patching (i.e., call module_enable_ro() on the patch module, not
necessarily the coming module). So I am not be sure why
klp_module_coming() should be moved before complete_formation(). I
hope I'm remembering the details correctly, livepatch folks feel free
to chime in if I'm incorrect here.
