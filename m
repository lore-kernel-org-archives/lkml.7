Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C008CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CDF20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfCZLNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:13:09 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:58947 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCZLNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:13:09 -0400
Received: from [10.30.3.200] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137621757; Tue, 26 Mar 2019 12:13:06 +0100
Date:   Tue, 26 Mar 2019 12:12:56 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, thibodux@gmail.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190326121256.76ceed71@luca64>
In-Reply-To: <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
        <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
        <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
        <20190323114151.5cebf31b@sweethome>
        <20190325130530.56603806@luca64>
        <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
        <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 26 Mar 2019 10:13:32 +0100
Dario Faggioli <dfaggioli@suse.com> wrote:

> On Mon, 2019-03-25 at 09:43 -0400, Boris Ostrovsky wrote:
> > On 3/25/19 8:05 AM, luca abeni wrote:  
> > > 
> > > The picture shows the latencies measured with an unpatched guest
> > > kernel
> > > and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary
> > > small
> > > value :).
> > > All the experiments have been performed booting the hypervisor
> > > with a
> > > small timer_slop (the hypervisor's one) value. So, they show that
> > > decreasing the hypervisor's timer_slop is not enough to measure
> > > low latencies with cyclictest.  
> > 
> > I have a couple of questions:
> > * Does it make sense to make this a tunable for other clockevent
> > devices
> > as well?
> >  
> So, AFAIUI, the thing is as follows. In clockevents_program_event(),
> we keep the delta between now and the next timer event within
> dev->max_delta_ns and dev->min_delta_ns:
> 
>   delta = min(delta, (int64_t) dev->max_delta_ns);
>   delta = max(delta, (int64_t) dev->min_delta_ns);
> 
> For Xen (well, for the Xen clock) we have:
> 
>   .max_delta_ns = 0xffffffff,
>   .min_delta_ns = TIMER_SLOP,
> 
> which means a guest can't ask for a timer to fire earlier than 100us
[...]

I know this is not fully related with the current discussion, but in
these days I had a look at the code again, and...
The comment for TIMER_SLOP in arch/x86/xen/time.c says:
	/* Xen may fire a timer up to this many ns early */

Isn't the comment wrong? shouldn't it be "...many ns late" instead of
"early"?



			Thanks,
				Luca
