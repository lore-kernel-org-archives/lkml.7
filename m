Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E29BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E3720B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 09:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDGJXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 05:23:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50721 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDGJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 05:23:41 -0400
Received: from p5492ee6e.dip0.t-ipconnect.de ([84.146.238.110] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hD41b-000055-3z; Sun, 07 Apr 2019 11:23:39 +0200
Date:   Sun, 7 Apr 2019 11:23:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: 8b275b3754 ("x86/irq/64: Remap the IRQ stack with guard pages"):
 BUG: unable to handle kernel paging request at ffffb659000a1000
In-Reply-To: <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904071121270.1840@nanos.tec.linutronix.de>
References: <5ca84952.hpEqUp6kap0tafzR%lkp@intel.com> <CALCETrX_ys9dJZOkN7QBjWz9Y1iukQDaJaASPAkGtWvwNkOESw@mail.gmail.com>
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

On Sat, 6 Apr 2019, Andy Lutomirski wrote:
> I haven't spotted the actual bug yet, but the faulting instruction is:
> 
>   2a:    65 8b 35 09 ca 75 63     mov    %gs:*0x6375ca09(%rip),%esi
>     # 0x6375ca3a        <-- trapping instruction
> 
> This seems to be faulting just above the top of the stack (the thing
> in RSP), so I suspect that there is some path that is shoving the
> remapped value into GSBASE, which is wrong.
> 
> Also, FWIW, there was some reason that I initialized all the virtual
> mappings for all possible CPUs early.  I don't remember what it was,
> and it may not have been a good reason, but I put at least some
> nonzero amount of thought into it :)

There is absolutely no reason to have irq stacks before init_IRQ(). 32bit
uses at runtime allocated irq stacks for years.

If the CPU takes a device interrupt before that, then there are way more
things which explode than just the irqstack pointer being NULL.

Thanks,

	tglx
