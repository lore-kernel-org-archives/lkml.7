Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E82A20449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfC0PUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:20:15 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40542 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbfC0PUM (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 27 Mar 2019 11:20:12 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 27 Mar 2019 16:20:10 +0100
Received: from [192.168.0.30] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 27 Mar 2019 15:19:46 +0000
Message-ID: <12fc5972c05b1bc2cbabe2c422e5541e154c3ad9.camel@suse.com>
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
From:   Dario Faggioli <dfaggioli@suse.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ryan Thibodeaux <thibodux@gmail.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Date:   Wed, 27 Mar 2019 16:19:37 +0100
In-Reply-To: <04ee9e67-5720-72df-9e2e-2ba42febf90f@oracle.com>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
         <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
         <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
         <20190323114151.5cebf31b@sweethome> <20190325130530.56603806@luca64>
         <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
         <a32c8b1d7866ee3b074b1d674b40e03e51dbd54a.camel@suse.com>
         <907547fa-a7e8-8dca-dabf-dd063705f196@oracle.com>
         <20190327100014.GA9663@centos-dev.localdomain>
         <04ee9e67-5720-72df-9e2e-2ba42febf90f@oracle.com>
Organization: SUSE
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 10:46 -0400, Boris Ostrovsky wrote:
> On 3/27/19 6:00 AM, Ryan Thibodeaux wrote:
> > On Tue, Mar 26, 2019 at 07:21:31PM -0400, Boris Ostrovsky wrote:
> > > On 3/26/19 5:13 AM, Dario Faggioli wrote:
> > > > 
> > > > And this is basically why I was also thinking we can/should
> > > > lower the
> > > > default value of TIMER_SLOP, here in the Xen clock
> > > > implementation in
> > > > Linux.
> > > What do you think would be a sane value? 10us? Should we then
> > > still keep
> > > this patch?
> > > 
> > > My concern would be that if we change the current value and it
> > > turns out
> > > to be very wrong we'd then have no recourse.
> > > 
> > Speaking out of turn but as a participant in this thread, I would
> > not
> > assume to change the default value for all cases without
> > significant
> > testing by the community, touching a variety of configurations.
> > 
> If we are to change the default it would be good to at least collect
> some data on distribution of delta values in
> clockevents_program_event(). But as I said, I'd keep the patch.
> 
I would definitely take/keep this patch. Choosing a more sane (IMO)
default and making things flexible and configurable are not mutually
exclusive things. :-)

I think that having this set to 100us stands in the way of a lot of
people wanting to do time sensitive stuff in Xen VMs. I'd at least
halve that to 50us, but 10us is even better.

But sure we can do this at a later point. And even at that point, a
patch like this is valuable, because there might be people that might,
probably after some testing of their own setup, want to lower it even
further.

> Also, as far as the comment describing TIMER_SLOP, I agree that it is
> rather misleading.
> 
> I can replace it with /* Minimum amount of time until next clock
> event
> fires */, I  can do it while committing so no need to resend.
> 
Yeah, much better, yes.

Dario
-- 
<<This happens because I choose it to happen!>> (Raistlin Majere)
-----------------------------------------------------------------
Dario Faggioli, Ph.D, http://about.me/dario.faggioli
Software Engineer @ SUSE https://www.suse.com/

