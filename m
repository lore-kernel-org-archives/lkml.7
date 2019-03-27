Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1202146E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553649170;
	bh=kCUfUtEjwYx5aDYl/xvjS8uRBDeP7miV+jT9v14u+ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=muZO9W8SlG0LOkQc9jyxX0eRJV1xq/NQq5zZoH1v4ZzjZ0jhSfXYQpMQxzHebhPSh
	 FXTexbnvGrUVCW4G4q3tYJxcYOdzjao/qWPZ/BfYt2yi3vpobnAYsAlDtwA7z4LauE
	 +A4vrOaexd4OgagUxNjiWOpZOmYin3teXTo54tc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfC0BMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfC0BMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:12:48 -0400
Received: from localhost (mobile-166-137-177-030.mycingular.net [166.137.177.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241882075E;
        Wed, 27 Mar 2019 01:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553649166;
        bh=kCUfUtEjwYx5aDYl/xvjS8uRBDeP7miV+jT9v14u+ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsoiDGjO/3m2t7e9/Nm1UUV1bRv7iZRTdvB4C8n0IXcm7DR3bIM/XWf0LmqkEx6lA
         Kr4RAOLk0n9dhEKn+IO1g3oPK18gPJljzATN+3i0zn8kRsUXwMbRO9ptZF1CepmANL
         drlxBx9DbHQYxcfaBydVDb9pDkpIF1v13pywImEU=
Date:   Wed, 27 Mar 2019 10:12:42 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>, Rik van Riel <riel@surriel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Micheal Kelley <michael.h.kelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [patch 1/2] cpu/hotplug: Prevent crash when CPU bringup fails on
 CONFIG_HOTPLUG_CPU=n
Message-ID: <20190327011242.GA3099@kroah.com>
References: <20190326163604.348882514@linutronix.de>
 <20190326163811.503390616@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326163811.503390616@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:36:05PM +0100, Thomas Gleixner wrote:
> Tianyu reported a crash in a CPU hotplug teardown callback when booting a
> kernel which has CONFIG_HOTPLUG_CPU disabled with the 'nosmt' boot
> parameter.
> 
> It turns out that the SMP=y CONFIG_HOTPLUG_CPU=n case has been broken
> forever in case that a bringup callback fails. Unfortunately this issue was
> not recognized when the CPU hotplug code was reworked, so the shortcoming
> just stayed in place.
> 
> When a bringup callback fails, the CPU hotplug code rolls back the
> operation and takes the CPU offline.
> 
> The 'nosmt' command line argument uses a bringup failure to abort the
> bringup of SMT sibling CPUs. This partial bringup is required due to the
> MCE misdesign on Intel CPUs.
> 
> With CONFIG_HOTPLUG_CPU=y the rollback works perfectly fine, but
> CONFIG_HOTPLUG_CPU=n lacks essential mechanisms to exercise the low level
> teardown of a CPU including the synchronizations in various facilities like
> RCU, NOHZ and others.
> 
> As a consequence the teardown callbacks which must be executed on the
> outgoing CPU within stop machine with interrupts disabled are executed on
> the control CPU in interrupt enabled and preemptible context causing the
> kernel to crash and burn. The pre state machine code has a different
> failure mode which is more subtle and resulting in a less obvious use after
> free crash because the control side frees resources which are still in use
> by the undead CPU.
> 
> But this is not a x86 only problem. Any architecture which supports the
> SMP=y HOTPLUG_CPU=n combination suffers from the same issue. It's just less
> likely to be triggered because in 99.99999% of the cases all bringup
> callbacks succeed.
> 
> The easy solution of making HOTPLUG_CPU mandatory for SMP is not working on
> all architectures as the following architectures have either no hotplug
> support at all or not all subarchitectures support it:
> 
>  alpha, arc, hexagon, openrisc, riscv, sparc (32bit), mips (partial).
> 
> Crashing the kernel in such a situation is not an acceptable state
> either.
> 
> Implement a minimal rollback variant by limiting the teardown to the point
> where all regular teardown callbacks have been invoked and leave the CPU in
> the 'dead' idle state. This has the following consequences:
> 
>  - the CPU is brought down to the point where the stop_machine takedown
>    would happen.
> 
>  - the CPU stays there forever and is idle
> 
>  - The CPU is cleared in the CPU active mask, but not in the CPU online
>    mask which is a legit state.
> 
>  - Interrupts are not forced away from the CPU
> 
>  - All facilities which only look at online mask would still see it, but
>    that is the case during normal hotplug/unplug operations as well. It's
>    just a (way) longer time frame.
> 
> This will expose issues, which haven't been exposed before or only seldom,
> because now the normally transient state of being non active but online is
> a permanent state. In testing this exposed already an issue vs. work queues
> where the vmstat code schedules work on the almost dead CPU which ends up
> in an unbound workqueue and triggers 'preemtible context' warnings. This is
> not a problem of this change, it merily exposes an already existing issue.
> Still this is better than crashing fully without a chance to debug it.
> 
> This is mainly thought as workaround for those architectures which do not
> support HOTPLUG_CPU. All others should enforce HOTPLUG_CPU for SMP.
> 
> Fixes: 2e1a3483ce74 ("cpu/hotplug: Split out the state walk into functions")
> Reported-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: Konrad Wilk <konrad.wilk@oracle.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Micheal Kelley <michael.h.kelley@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: stable@vger.kernel.org
> ---
>  kernel/cpu.c |   20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
