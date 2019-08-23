Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07852C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C7233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfHWCFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:05:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33669 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733086AbfHWCFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:05:22 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0ywy-0000pN-VG; Fri, 23 Aug 2019 04:05:13 +0200
Date:   Fri, 23 Aug 2019 04:05:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com
Subject: Re: [PATCH V2] perf/x86: Consider pinned events for group
 validation
In-Reply-To: <20190822185522.GE5447@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1908230404190.31055@nanos.tec.linutronix.de>
References: <1566488866-5975-1-git-send-email-kan.liang@linux.intel.com> <20190822182227.GD5447@tassilo.jf.intel.com> <alpine.DEB.2.21.1908222029210.1983@nanos.tec.linutronix.de> <20190822185522.GE5447@tassilo.jf.intel.com>
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

On Thu, 22 Aug 2019, Andi Kleen wrote:
> On Thu, Aug 22, 2019 at 08:29:46PM +0200, Thomas Gleixner wrote:
> > On Thu, 22 Aug 2019, Andi Kleen wrote:
> > 
> > > > +	/*
> > > > +	 * Disable interrupts to prevent the events in this CPU's cpuc
> > > > +	 * going away and getting freed.
> > > > +	 */
> > > > +	local_irq_save(flags);
> > > 
> > > I believe it's also needed to disable preemption. Probably should
> > > add a comment, or better an explicit preempt_disable() too.
> > 
> > Preemption is implicit disabled by disabling interrupts.
> 
> Yes it is, this is more for documentation.

Comment, yes. An explicit preempt_disable() surely not.

Thanks,

	tglx
