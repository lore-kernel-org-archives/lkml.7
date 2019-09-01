Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC3EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63F122D6D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567335340;
	bh=IVVfF7zjQyZdVi1x3Qr1f9kK7XHqcjLFqyZnNGlB+3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VE+JyXunpDBw2zvlv4nTyLiMn2Cnnu41C7cEeR6Tl49pnnnkjm2kIVjFzOsr9vy/4
	 qbsRBZnE6OL/sn9vWtBHBtKb0iwo1J3qiVa9VzwwSxBeYJEikuEDgF/ApcLHkGLUyy
	 heMUh/laIjkKY5rs0lJ2neCZN3gQf/Xr+SZ3vTP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfIAKtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 06:49:45 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:49681 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728523AbfIAKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 06:49:45 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1i4NQQ-0001RB-Iw; Sun, 01 Sep 2019 12:49:38 +0200
Date:   Sun, 1 Sep 2019 11:49:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] genirq: move debugfs option to kernel hacking
Message-ID: <20190901114936.5e2f3490@why>
In-Reply-To: <20190901101032.7pysfrpincyrci35@mail.google.com>
References: <20190901035539.2957-1-changbin.du@gmail.com>
        <alpine.DEB.2.21.1909010814360.3955@nanos.tec.linutronix.de>
        <20190901101032.7pysfrpincyrci35@mail.google.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: changbin.du@gmail.com, tglx@linutronix.de, akpm@linux-foundation.org, yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2019 18:10:33 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> On Sun, Sep 01, 2019 at 08:23:02AM +0200, Thomas Gleixner wrote:
> > On Sun, 1 Sep 2019, Changbin Du wrote:
> >   
> > > Just like the other generic debug options, move the irq one to
> > > 'Kernel hacking' menu.  
> > 
> > Why?
> > 
> > Kernel hacking is a inscrutable mess where you can waste a lot of time to
> > find what you are looking for.
> >  
> yes, the 'kernel hacking' menu has many items now and are not well structured.
> Let me see if it can be improved.
> 
> > If I want to debug interrupts then having the option right there where all
> > other interrupt related configuration is makes tons of sense.
> > 
> > I would be less opposed to this when the kernel hacking menu would be
> > halfways well structured, but you just chose another random place for that
> > option which is worse than what we have now.
> >   
> We already have an irq debug option CONFIG_DEBUG_SHIRQ here. Maybe we can group
> them into a submenu.

DEBUG_SHIRQ is extremely different from GENERIC_IRQ_DEBUGFS. The former
is a test option, verifying that endpoint drivers have a correct
behaviour. The latter is a dump of the kernel internals, which is
mostly for people dealing with the internals of the IRQ subsystem.

Preserving this distinction between the users of the IRQ API on one
side and the debugging of the IRQ subsystem on the other is important.
Moving these two things close together could make it even more confusing
for the users (who usually do not need to mess with the IRQ subsystem's
internals...).

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
