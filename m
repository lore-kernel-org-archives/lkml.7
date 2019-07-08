Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD19C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF7D21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfGHPF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:05:59 -0400
Received: from foss.arm.com ([217.140.110.172]:50370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbfGHPF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:05:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CC312B;
        Mon,  8 Jul 2019 08:05:58 -0700 (PDT)
Received: from queper01-lin (unknown [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469E23F59C;
        Mon,  8 Jul 2019 08:05:56 -0700 (PDT)
Date:   Mon, 8 Jul 2019 16:05:55 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 1/6] sched/dl: Improve deadline admission control for
 asymmetric CPU capacities
Message-ID: <20190708150552.rjdjqnnwijmliaoe@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-2-luca.abeni@santannapisa.it>
 <20190507134850.yreebscc3zigfmtd@queper01-lin>
 <20190507162523.6a405d48@nowhere>
 <20190507143125.cjfhdxngcugqmko3@queper01-lin>
 <20190507164349.2823fdaa@nowhere>
 <3ddfc5ce-8870-a8d5-265a-462763fb348c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddfc5ce-8870-a8d5-265a-462763fb348c@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 Jul 2019 at 13:22:35 (+0200), Dietmar Eggemann wrote:
> On 5/7/19 4:43 PM, luca abeni wrote:
> > On Tue, 7 May 2019 15:31:27 +0100
> > Quentin Perret <quentin.perret@arm.com> wrote:
> > 
> >> On Tuesday 07 May 2019 at 16:25:23 (+0200), luca abeni wrote:
> >>> On Tue, 7 May 2019 14:48:52 +0100
> >>> Quentin Perret <quentin.perret@arm.com> wrote:
> >>>   
> >>>> Hi Luca,
> >>>>
> >>>> On Monday 06 May 2019 at 06:48:31 (+0200), Luca Abeni wrote:  
> 
> [...]
> 
> >> Right and things moved recently in this area, see bb1fbdd3c3fd
> >> ("sched/topology, drivers/base/arch_topology: Rebuild the sched_domain
> >> hierarchy when capacities change")
> > 
> > Ah, thanks! I missed this change when rebasing the patchset.
> > I guess this part of the patch has to be updated (and probably became
> > useless?), then.
> 
> [...]
> 
> >>> This achieved the effect of correctly setting up the "rd_capacity"
> >>> field, but I do not know if there is a better/simpler way to achieve
> >>> the same result :)  
> >>
> >> OK, that's really an implementation detail, so no need to worry too
> >> much about it at the RFC stage I suppose :-)
> 
> What about we integrate the code to calculate the rd capacity into
> build_sched_domains() (next to the code to establish the rd
> max_cpu_capacity)?

Right, that's also what Vincent suggested IIRC. I think that'd work :)

Thanks,
Quentin
