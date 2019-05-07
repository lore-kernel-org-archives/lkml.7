Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A843AC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16820825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEGNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:48:57 -0400
Received: from foss.arm.com ([217.140.101.70]:54862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfEGNs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:48:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC84580D;
        Tue,  7 May 2019 06:48:56 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E32A3F5C1;
        Tue,  7 May 2019 06:48:54 -0700 (PDT)
Date:   Tue, 7 May 2019 14:48:52 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Luca Abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20190507134850.yreebscc3zigfmtd@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-2-luca.abeni@santannapisa.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506044836.2914-2-luca.abeni@santannapisa.it>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Monday 06 May 2019 at 06:48:31 (+0200), Luca Abeni wrote:
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index edfcf8d982e4..646d6d349d53 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -36,6 +36,7 @@ DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
>  
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  {
> +	topology_update_cpu_capacity(cpu, per_cpu(cpu_scale, cpu), capacity);

Why is that one needed ? Don't you end up re-building the sched domains
after this anyways ?

>  	per_cpu(cpu_scale, cpu) = capacity;
>  }

Thanks,
Quentin
