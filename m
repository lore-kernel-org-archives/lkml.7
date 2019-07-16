Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FF4C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620FB2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfGPQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:08:24 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40117 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbfGPQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:08:24 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:405a::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hnPzz-0001za-Tr; Tue, 16 Jul 2019 12:08:22 -0400
Date:   Tue, 16 Jul 2019 12:07:45 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, djuran@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86: Add irq spillover warning
Message-ID: <20190716160745.GB1498@hmswarspite.think-freely.org>
References: <20190716135917.15525-1-nhorman@tuxdriver.com>
 <alpine.DEB.2.21.1907161735090.1767@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907161735090.1767@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 05:57:31PM +0200, Thomas Gleixner wrote:
> Neil,
> 
> On Tue, 16 Jul 2019, Neil Horman wrote:
> 
> > On Intel hardware, cpus are limited in the number of irqs they can
> > have affined to them (currently 240), based on section 10.5.2 of:
> > https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-vol-3a-part-1-manual.pdf
> 
> That reference is really not useful to explain the problem and the number
> of vectors is neither. Please explain the conceptual issue.
>  
You seem to have already done that below.  Not really sure what more you are
asking for here.

> > If a cpu has more than this number of interrupts affined to it, they
> > will spill over to other cpus, which potentially may be outside of their
> > affinity mask.
> 
> Spill over?
> 
> The kernel decides to pick a vector on a CPU outside of the affinity when
> it runs out of vectors on the CPUs in the affinity mask.
> 
Yes.

> Please explain issues technically correct.
> 
I don't know what you mean by this.  I explained it above, and you clearly
understood it.

> > Given that this might cause unexpected behavior on
> > performance sensitive systems, warn the user should this condition occur
> > so that corrective action can be taken
> 
> > @@ -244,6 +244,14 @@ __visible unsigned int __irq_entry do_IRQ(struct pt_regs *regs)
> 
> Why on earth warn in the interrupt delivery hotpath? Just because it's the
> place which really needs extra instructions and extra cache lines on
> performance sensitive systems, right?
> 
Because theres already a check of the same variety in do_IRQ, but if the
information is available outside the hotpath, I was unaware, and am happy to
update this patch to refelct that.

> The fact that the kernel ran out of vectors for the CPUs in the affinity
> mask is already known when the vector is allocated in activate_reserved().
> 
> So there is an obvious place to put such a warning and it's certainly not
> do_IRQ().
> 
Sure

Thanks
Neil

> Thanks,
> 
> 	tglx
> 
