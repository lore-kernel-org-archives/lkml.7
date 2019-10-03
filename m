Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89868C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59994215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570135990;
	bh=yowsqFgBN3g03tzI8bPhnB/eqX3mSgB7OHNH/n5OKLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pwSP/P9tsCqNl8dIJwo3oQ9s68HATYcuvrf9PUg0qLo8tUwbTxVtlwisr2MIE5vaB
	 Du1dEr5qT4agJlKVhHUG7lmyxYs6Mmuzr2mofoPEA9FhCyJzwR8MmrPGFkGy8p628L
	 3qM1Z+DHgWvUFFpnYk4VPRDOQtRrYgesk1ZFgeC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfJCUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfJCUxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:53:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F35BE2086A;
        Thu,  3 Oct 2019 20:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570135988;
        bh=yowsqFgBN3g03tzI8bPhnB/eqX3mSgB7OHNH/n5OKLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0CtLPiZsYBXJAfAy5axgjtYgZQEXimPqPJ9Wcq1cQq7n2Hp9Ppx2pvFhAudYxfKj
         8HQV7EL8Pwi+3TY44pJYiMZ5oV+ZE9hJ4Sx1KK30AsmuLRM9iSHcAnY6ceHjhVzPC/
         jQAGPuL9KLyHhPPbZ1PJcsKYMKH8v913FLee/p+U=
Date:   Thu, 3 Oct 2019 21:53:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        contact@xogium.me, Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] panic: Ensure preemption is disabled during panic()
Message-ID: <20191003205303.ge324uspaaocfxq4@willie-the-truck>
References: <20191002123538.22609-1-will@kernel.org>
 <20191002144558.87531ea9f68b535453fedd3e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002144558.87531ea9f68b535453fedd3e@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for having a look.

On Wed, Oct 02, 2019 at 02:45:58PM -0700, Andrew Morton wrote:
> On Wed,  2 Oct 2019 13:35:38 +0100 Will Deacon <will@kernel.org> wrote:
> > Disable preemption in 'panic()' before re-enabling interrupts.
> > 
> > ...
> >
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -180,6 +180,7 @@ void panic(const char *fmt, ...)
> >  	 * after setting panic_cpu) from invoking panic() again.
> >  	 */
> >  	local_irq_disable();
> > +	preempt_disable_notrace();
> >  
> >  	/*
> >  	 * It's possible to come here directly from a panic-assertion and
> 
> We still do a lot of stuff (kexec, kgdb, etc) after this
> preempt_disable() and I worry that something in there will now trigger
> a might_sleep() warning as a result?

Given that interrupts are already disabled at this point, I don't think
we'll get any additional warnings here by disabling preemption as well.

Will
