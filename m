Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD8EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D473921582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLRUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:34:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:60206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRUef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:34:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7E24AEE0;
        Wed, 18 Dec 2019 20:34:33 +0000 (UTC)
Date:   Wed, 18 Dec 2019 12:28:01 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] rxrpc: struct mutex cannot be used for
 rxrpc_call::user_mutex
Message-ID: <20191218202801.wokf6hcvbafmjnkd@linux-p48b>
References: <157659672074.19580.11641288666811539040.stgit@warthog.procyon.org.uk>
 <20191218135047.GS2844@hirez.programming.kicks-ass.net>
 <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191218190833.ufpxjrvin5jvp3m5@linux-p48b>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, Davidlohr Bueso wrote:

>On Wed, 18 Dec 2019, Peter Zijlstra wrote:
>
>>On Tue, Dec 17, 2019 at 03:32:00PM +0000, David Howells wrote:
>>>Standard kernel mutexes cannot be used in any way from interrupt or softirq
>>>context, so the user_mutex which manages access to a call cannot be a mutex
>>>since on a new call the mutex must start off locked and be unlocked within
>>>the softirq handler to prevent userspace interfering with a call we're
>>>setting up.
>>>
>>>Commit a0855d24fc22d49cdc25664fb224caee16998683 ("locking/mutex: Complain
>>>upon mutex API misuse in IRQ contexts") causes big warnings to be splashed
>>>in dmesg for each a new call that comes in from the server.
>>
>>FYI that patch has currently been reverted.
>>
>>commit c571b72e2b845ca0519670cb7c4b5fe5f56498a5 (tip/locking/urgent, tip/locking-urgent-for-linus)
>
>Will we ever want to re-add this warning (along with writer rwsems) at some point?
>
>It seems that having it actually prompts things getting fixed, as opposed to
>just sitting there forever borken (at least in -rt).

Hmm so fyi __crash_kexec() is another one, but can be called in hard-irq, and
it's extremely obvious that the trylock+unlock occurs in the same context.

It would be nice to automate this...

Thanks,
Davidlohr
