Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B29AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FA22087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfCYOHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:07:09 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:43764 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfCYOHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:07:09 -0400
Received: from [10.30.3.184] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137597243; Mon, 25 Mar 2019 15:07:08 +0100
Date:   Mon, 25 Mar 2019 15:07:03 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Dario Faggioli <dfaggioli@suse.com>, thibodux@gmail.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190325150703.3774b92d@luca64>
In-Reply-To: <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
        <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
        <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
        <20190323114151.5cebf31b@sweethome>
        <20190325130530.56603806@luca64>
        <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Mar 2019 09:43:20 -0400
Boris Ostrovsky <boris.ostrovsky@oracle.com> wrote:
[...]
> > http://retis.santannapisa.it/luca/XenTimers/
> > (there also is a link to the scripts to be used for reproducing the
> > results). The latencies have been measured by running cyclictest in
> > the guest (see the scripts for details).
> >
> > The picture shows the latencies measured with an unpatched guest
> > kernel and with a guest kernel having TIMER_SLOP set to 1000
> > (arbitrary small value :).
> > All the experiments have been performed booting the hypervisor with
> > a small timer_slop (the hypervisor's one) value. So, they show that
> > decreasing the hypervisor's timer_slop is not enough to measure low
> > latencies with cyclictest.  
> 
> 
> 
> I have a couple of questions:
> * Does it make sense to make this a tunable for other clockevent
> devices as well?
> * This patch adjusts min value. Could max value (ever) need a similar
> adjustment?

Sorry, I do not know much about clockevent devices, so I have no answers
to these questions...

What I can say is that when I repeated the cyclictest experiments on
VMs using a different clockevent device (lapic) I did not measure large
latencies.
So, I guess the "lapic" clockevent device already defaults to a smaller
min value (not sure about other clockevent devices, I do not know how
to test them).



				Luca
