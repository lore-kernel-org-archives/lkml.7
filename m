Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92723C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9432087F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfCWKmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:42:13 -0400
Received: from mail.sssup.it ([193.205.80.98]:35249 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfCWKmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:42:12 -0400
Received: from [151.40.136.78] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137564061; Sat, 23 Mar 2019 11:42:08 +0100
Date:   Sat, 23 Mar 2019 11:41:51 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, thibodux@gmail.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190323114151.5cebf31b@sweethome>
In-Reply-To: <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
        <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
        <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, 23 Mar 2019 03:58:16 +0100
Dario Faggioli <dfaggioli@suse.com> wrote:

> On Fri, 2019-03-22 at 18:10 -0400, Boris Ostrovsky wrote:
> > On 3/22/19 2:29 PM, thibodux@gmail.com wrote:  
> > > From: Ryan Thibodeaux <ryan.thibodeaux@starlab.io>
> > > 
> > > The original timer slop value has not changed since the
> > > introduction
> > > of the Xen-aware Linux kernel code. This commit provides users an
> > > opportunity to tune timer performance given the refinements to
> > > hardware and the Xen event channel processing. It also mirrors
> > > a feature in the Xen hypervisor - the "timer_slop" Xen command
> > > line option.  
> > 
> > Is there any data that shows effects of using this new parameter?
> >   
> Yes, I've done some research and experiments on this. I did it
> together with a friend, which I'm Cc-ing, as I'm not sure we're
> ready/capable to share the results, yet (Luca?).

I think we can easily share the experimental data (cyclictest output
and plots).

Moreover, we can share the scripts and tools for running the
experiments (so, everyone can easily reproduce the numbers by simply
typing "make" and waiting for some time :)


I'll try to package the results and the scripts/tools this evening, and
I'll send them.



				Luca


> 
> What I think I can anticipate is that having such a high value for
> timer slop in the kernel, for the Xen clockevent device is (together
> with the also quite high default value of timer_slop in Xen itself)
> responsible for really high vcpu wakeup latencies.
> 
> Lowering those two values, reduces such latencies dramatically.
> 
> Regards,
> Dario

