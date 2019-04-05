Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E3C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F2D2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfDERrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:47:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49431 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDERrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:47:19 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCSvq-0001Ha-Jn; Fri, 05 Apr 2019 19:47:14 +0200
Date:   Fri, 5 Apr 2019 19:47:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch V2 03/29] x86/irq/64: Remove a hardcoded irq_stack_union
 access
In-Reply-To: <20190405171843.52uijxyxbeiuczcl@treble>
Message-ID: <alpine.DEB.2.21.1904051926350.1802@nanos.tec.linutronix.de>
References: <20190405150658.237064784@linutronix.de> <20190405150928.684985548@linutronix.de> <20190405163727.GB19359@linux.intel.com> <20190405171843.52uijxyxbeiuczcl@treble>
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

On Fri, 5 Apr 2019, Josh Poimboeuf wrote:
> On Fri, Apr 05, 2019 at 09:37:27AM -0700, Sean Christopherson wrote:
> > On Fri, Apr 05, 2019 at 05:07:01PM +0200, Thomas Gleixner wrote:
> > > -	irq_stack_top = (u64)this_cpu_ptr(irq_stack_union.irq_stack) +
> > > -			STACK_TOP_MARGIN;
> > >  	irq_stack_bottom = (u64)__this_cpu_read(irq_stack_ptr);
> > > +	irq_stack_top = irq_stack_bottom - IRQ_STACK_SIZE + STACK_TOP_MARGIN;
> > 
> > Not introduced in this patch, but the names for top and bottom are flipped,
> > both for irq_stack and estack.  STACK_TOP_MARGIN should also be
> > STACK_BOTTOM_MARGIN.  The actual checks are functionally correct, but holy
> > hell does it make reading the code confusing, and the WARN prints backwards
> > information.
> 
> I agree, but... one man's top is another man's bottom.  Especially when
> stacks grow physically down (as defined by Intel) but conceptually up
> (as defined by every CS algorithms class ever).

That's where they explain that stack concept with stacking of porcelain
plates, which causes the association of shards when the stack is turned
around. Right?

Thankfully I got never exposed to that.

/me runs
