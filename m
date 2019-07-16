Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B179FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D28F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfGPTFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:05:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:05:35 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hnSlX-0008WM-JY; Tue, 16 Jul 2019 21:05:31 +0200
Date:   Tue, 16 Jul 2019 21:05:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Neil Horman <nhorman@tuxdriver.com>
cc:     linux-kernel@vger.kernel.org, djuran@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86: Add irq spillover warning
In-Reply-To: <20190716160745.GB1498@hmswarspite.think-freely.org>
Message-ID: <alpine.DEB.2.21.1907162100190.1767@nanos.tec.linutronix.de>
References: <20190716135917.15525-1-nhorman@tuxdriver.com> <alpine.DEB.2.21.1907161735090.1767@nanos.tec.linutronix.de> <20190716160745.GB1498@hmswarspite.think-freely.org>
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

Neil,

On Tue, 16 Jul 2019, Neil Horman wrote:
> On Tue, Jul 16, 2019 at 05:57:31PM +0200, Thomas Gleixner wrote:
> > On Tue, 16 Jul 2019, Neil Horman wrote:
> > > If a cpu has more than this number of interrupts affined to it, they
> > > will spill over to other cpus, which potentially may be outside of their
> > > affinity mask.
> > 
> > Spill over?
> > 
> > The kernel decides to pick a vector on a CPU outside of the affinity when
> > it runs out of vectors on the CPUs in the affinity mask.
> > 
> Yes.
> 
> > Please explain issues technically correct.
> > 
> I don't know what you mean by this.  I explained it above, and you clearly
> understood it.

It took me a while to grok it. Simply because I first thought it's some
hardware issue. And of course after confusion settled I knew what it is,
but just because I know that code like the back of my hand.

> > > Given that this might cause unexpected behavior on
> > > performance sensitive systems, warn the user should this condition occur
> > > so that corrective action can be taken
> > 
> > > @@ -244,6 +244,14 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
> > 
> > Why on earth warn in the interrupt delivery hotpath? Just because it's the
> > place which really needs extra instructions and extra cache lines on
> > performance sensitive systems, right?
> > 
> Because theres already a check of the same variety in do_IRQ, but if the
> information is available outside the hotpath, I was unaware, and am happy to
> update this patch to refelct that.

Which check are you referring to?

Thanks,

	tglx
