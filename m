Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98491C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658D9206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m134jeAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbfG2UvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:51:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46993 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbfG2UvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:51:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id k189so9798236pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SoKqHgmiv4tAja7Vbhan3qjXLAkeJjmJfY6Jshn/jTM=;
        b=m134jeAxviNJzkVWe3qEuTeSrF7LFMPnpAZSch1GP8VEq9yXdMn/0Y8XR4vv+QpgDu
         6+Q3m9vJLudQDxv1iqtiBxQ5dmEeLOThurVOqpsQayUmGpqPt+zOYD8N7XW3Q0soFGSU
         pcgUJ9wBJbIeExJjdwDMyilH5jBBY+DyEb1jDJkOQVL0/u5vdy3zkZ/g3HstfOlgh1B7
         p4YFHAMU5zu7CIQpMulyUsGvOdE/GtwkAjFsCrwhF7jtckVzxQW6mBMmWRy5ZkW0/u9l
         S8+jT+Ngq8n9CuHXWbK3dZy9X9bJkXUmqqzjyUfCPx2Wfb4mYI44fXkj2PO24v8zN4Cv
         +Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SoKqHgmiv4tAja7Vbhan3qjXLAkeJjmJfY6Jshn/jTM=;
        b=BTJ7iqlAvYuBm/spm+Kf3972SaAC03wMEIFzUga7kR7d4wBEMFBlOctJ4P51t3vLKC
         LaDgqP/He3MRQchJZq9WZlKPPZjOErdABC0EzMZ5WrHHTpPNtT3NvqCWYsRSfWSVyRyR
         vRGSG7Ocvtzijod/7pfSKfvqJBawEpVdfiz2V7x63RGU/o5ciVrcU6SOfu59swCyAZpr
         dXKhDzOz+IRGUKSiF0kloARI/ir5VCSK2YdT9+ndsQPGxh35HRak9zySrUOCAM1e3+Qf
         0EOKWnjjFgWIBRc1ufycl9U01KpxIRPRt8CY3vA18qI1rlEMcv7oGVKjgxHchF8bkHVP
         RaAw==
X-Gm-Message-State: APjAAAVo44YKCu8GYU3fqOWNe91U2ZMzh1C27JHhO29y3aIIAz14efvp
        xSis7eVCOrkQUc298QTpOm0=
X-Google-Smtp-Source: APXvYqzECOXVxwzmXZ+cJ5nseEO48agt2szWvqUkeZD7gBwPOLZBYTCnU/BdWRqOOHVd0IkPb2AKgw==
X-Received: by 2002:a63:724f:: with SMTP id c15mr108423404pgn.257.1564433461271;
        Mon, 29 Jul 2019 13:51:01 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v126sm8585234pgb.23.2019.07.29.13.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:51:00 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:50:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20190729205059.GA1127@roeck-us.net>
References: <20190727164450.GA11726@roeck-us.net>
 <20190729093545.GV31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
 <20190729101349.GX31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291235580.1791@nanos.tec.linutronix.de>
 <20190729104745.GA31398@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729104745.GA31398@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:47:45PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 29, 2019 at 12:38:30PM +0200, Thomas Gleixner wrote:
> > On Mon, 29 Jul 2019, Peter Zijlstra wrote:
> > > On Mon, Jul 29, 2019 at 11:58:24AM +0200, Thomas Gleixner wrote:
> > > > On Mon, 29 Jul 2019, Peter Zijlstra wrote:
> > > > > On Sat, Jul 27, 2019 at 09:44:50AM -0700, Guenter Roeck wrote:
> > > > > > [   61.348866] Call Trace:
> > > > > > [   61.349392]  kick_ilb+0x90/0xa0
> > > > > > [   61.349629]  trigger_load_balance+0xf0/0x5c0
> > > > > > [   61.349859]  ? check_preempt_wakeup+0x1b0/0x1b0
> > > > > > [   61.350057]  scheduler_tick+0xa7/0xd0
> > > > > 
> > > > > kick_ilb() iterates nohz.idle_cpus_mask to find itself an idle_cpu().
> > > > > 
> > > > > idle_cpus_mask() is set from nohz_balance_enter_idle() and cleared from
> > > > > nohz_balance_exit_idle(). nohz_balance_enter_idle() is called from
> > > > > __tick_nohz_idle_stop_tick() when entering nohz idle, this includes the
> > > > > cpu_is_offline() clause of the idle loop.
> > > > > 
> > > > > However, when offline, cpu_active() should also be false, and this
> > > > > function should no-op.
> > > > 
> > > > Ha. That reboot mess is not clearing cpu active as it's not going through
> > > > the regular cpu hotplug path. It's using reboot IPI which 'stops' the cpus
> > > > dead in their tracks after clearing cpu online....
> > > 
> > > $string-of-cock-compliant-curses
> > > 
> > > What a trainwreck...
> > > 
> > > So if it doesn't play by the normal rules; how does it expect to work?
> > > 
> > > So what do we do? 'Fix' reboot or extend the rules?
> > 
> > Reboot has two modes:
> > 
> >  - Regular reboot initiated from user space
> > 
> >  - Panic reboot
> > 
> > For the regular reboot we can make it go through proper hotplug, 
> 
> That seems sensible.
> 
> > for the panic case not so much.
> 
> It's panic, shit has already hit fan, one or two more pieces shouldn't
> something anybody cares about.
> 

Some more digging shows that this happens a lot with Google GCE intances,
typically after a panic. The problem with that, if I understand correctly,
is that it may prevent coredumps from being written. So, while of course
the panic is what needs to be fixed, it is still quite annoying, and it
would help if this can be fixed for panic handling as well.

How about the patch suggested by Hillf Danton ? Would that help for the
panic case ?

Thanks,
Guenter
