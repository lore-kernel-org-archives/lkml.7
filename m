Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B011C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C86C206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cd8FfgOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfG2KN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:13:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=POkWbYSzgMMetxfnUpRwoxKNTv69Z5Jby4ut6IgKLxA=; b=cd8FfgOjNl0dMpnrFQZIJlJyM
        82FG2WPHwGf4qgHzITxlwy11tommB5/OOvyseY3NOgWP4y3l5W2mgDFZcguWvzpoIYbLFDXwEBEB0
        ZfzySigRiawmp4TVh5bd5xMO99K3IwYpJpFMMcxK3psTGCZxLBGUoVSBiTdyyxCHo3cyS84gJer2E
        CK1C9ve6wUv7jYPZTJC6fD+oS1Dw+O94JwjgVyWUydNCWietPk1Pr6FhQIbFm3XNXnFep8cTxRv48
        hxJ14jvz5pUpHxqYl04LHU3/exAuVH0nHanGkAssCi1iZXk8DJsPywNmGR79uo6eZAm7izibGckG5
        JQq6E2IUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs2f9-0001Uc-N9; Mon, 29 Jul 2019 10:13:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0292B20AF2C34; Mon, 29 Jul 2019 12:13:49 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:13:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: sched: Unexpected reschedule of offline CPU#2!
Message-ID: <20190729101349.GX31381@hirez.programming.kicks-ass.net>
References: <20190727164450.GA11726@roeck-us.net>
 <20190729093545.GV31381@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907291156170.1791@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:58:24AM +0200, Thomas Gleixner wrote:
> On Mon, 29 Jul 2019, Peter Zijlstra wrote:
> > On Sat, Jul 27, 2019 at 09:44:50AM -0700, Guenter Roeck wrote:
> > > [   61.348866] Call Trace:
> > > [   61.349392]  kick_ilb+0x90/0xa0
> > > [   61.349629]  trigger_load_balance+0xf0/0x5c0
> > > [   61.349859]  ? check_preempt_wakeup+0x1b0/0x1b0
> > > [   61.350057]  scheduler_tick+0xa7/0xd0
> > 
> > kick_ilb() iterates nohz.idle_cpus_mask to find itself an idle_cpu().
> > 
> > idle_cpus_mask() is set from nohz_balance_enter_idle() and cleared from
> > nohz_balance_exit_idle(). nohz_balance_enter_idle() is called from
> > __tick_nohz_idle_stop_tick() when entering nohz idle, this includes the
> > cpu_is_offline() clause of the idle loop.
> > 
> > However, when offline, cpu_active() should also be false, and this
> > function should no-op.
> 
> Ha. That reboot mess is not clearing cpu active as it's not going through
> the regular cpu hotplug path. It's using reboot IPI which 'stops' the cpus
> dead in their tracks after clearing cpu online....

$string-of-cock-compliant-curses

What a trainwreck...

So if it doesn't play by the normal rules; how does it expect to work?

So what do we do? 'Fix' reboot or extend the rules?
