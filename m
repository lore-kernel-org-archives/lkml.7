Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B086CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B1E204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfEHOMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:12:18 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:36413 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEHOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:12:18 -0400
Received: from [83.43.182.198] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138932507; Wed, 08 May 2019 16:12:15 +0200
Date:   Wed, 8 May 2019 16:12:08 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 4/6] sched/dl: Improve capacity-aware wakeup
Message-ID: <20190508161208.108caf26@nowhere>
In-Reply-To: <20190508131018.GJ6551@localhost.localdomain>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-5-luca.abeni@santannapisa.it>
        <20190508090855.GG6551@localhost.localdomain>
        <20190508112437.74661fa8@nowhere>
        <20190508120526.GI6551@localhost.localdomain>
        <20190508144716.5cc8445d@nowhere>
        <20190508131018.GJ6551@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Wed, 8 May 2019 15:10:18 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> On 08/05/19 14:47, luca abeni wrote:
> 
> [...]
> 
> > Notice that all this logic is used only to select one of the idle
> > cores (instead of picking the first idle core, we select the less
> > powerful core on which the task "fits").
> > 
> > So, running_bw does not provide any useful information, in this
> > case; maybe this_bw can be more useful.  
> 
> Ah, indeed.
> 
> However, what happens when cores are all busy? Can load balancing
> decisions based on deadline values only break capacity awareness?  (I
> understand this is an RFC, so a "yes, something we need to look at" is
> OK :-)

I have no definitive answer about this :)

If we do not want to break EDF and its properties, migrations have to
be performed so that the "global EDF invariant" (schedule the m tasks
with earliest deadlines) is not broken (and capacity-based migrations
for non-idle cores risk to break this invariant).

In theory, we should do something like "schedule the earliest deadline
task on the fastest core", but this would require too many migrations
(and would require to migrate a task while it is executing, etc...)

I am convinced that doing the capacity-aware migrations when we have
idle cores helps to reduce migrations (avoiding "useless migrations")
when there are no idle cores, but I have no proof about this (just some
simple examples); this is why I say that I have no definitive answer...



				Luca
