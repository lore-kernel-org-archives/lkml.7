Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NO_DNS_FOR_FROM autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28126C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC8420863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfCYMGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:06:05 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:24045 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfCYMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:06:05 -0400
Received: from [10.30.3.184] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137593801; Mon, 25 Mar 2019 13:06:02 +0100
Date:   Mon, 25 Mar 2019 13:05:57 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, thibodux@gmail.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190325130530.56603806@luca64>
In-Reply-To: <20190323114151.5cebf31b@sweethome>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
        <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
        <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
        <20190323114151.5cebf31b@sweethome>
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

On Sat, 23 Mar 2019 11:41:51 +0100
luca abeni <luca.abeni@santannapisa.it> wrote:
[...]
> > > Is there any data that shows effects of using this new parameter?
> > >     
> > Yes, I've done some research and experiments on this. I did it
> > together with a friend, which I'm Cc-ing, as I'm not sure we're
> > ready/capable to share the results, yet (Luca?).  
> 
> I think we can easily share the experimental data (cyclictest output
> and plots).
> 
> Moreover, we can share the scripts and tools for running the
> experiments (so, everyone can easily reproduce the numbers by simply
> typing "make" and waiting for some time :)
> 
> 
> I'll try to package the results and the scripts/tools this evening,
> and I'll send them.

Sorry for the delay. I put some quick results here:
http://retis.santannapisa.it/luca/XenTimers/
(there also is a link to the scripts to be used for reproducing the
results). The latencies have been measured by running cyclictest in the
guest (see the scripts for details).

The picture shows the latencies measured with an unpatched guest kernel
and with a guest kernel having TIMER_SLOP set to 1000 (arbitrary small
value :).
All the experiments have been performed booting the hypervisor with a
small timer_slop (the hypervisor's one) value. So, they show that
decreasing the hypervisor's timer_slop is not enough to measure low
latencies with cyclictest.


				Luca
