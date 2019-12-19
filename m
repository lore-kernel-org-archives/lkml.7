Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC77F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLSOXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:23:37 -0500
Received: from foss.arm.com ([217.140.110.172]:39144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLSOXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:23:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E2A231B;
        Thu, 19 Dec 2019 06:23:36 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5CA73F6CF;
        Thu, 19 Dec 2019 06:23:34 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, pauld@redhat.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20191218154402.GF3178@techsingularity.net>
 <8f049805-3e97-09bb-2d32-0718be1dec9b@arm.com>
 <20191219100232.GY2844@hirez.programming.kicks-ass.net>
 <83a9363b-a044-845a-d37c-bf2ca7c8a09e@arm.com>
Message-ID: <019ceada-998c-8e5e-74fa-9606c922e096@arm.com>
Date:   Thu, 19 Dec 2019 14:23:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <83a9363b-a044-845a-d37c-bf2ca7c8a09e@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2019 11:46, Valentin Schneider wrote:
> As for picking values, right now we have
> 
>   125 (default) / 117 (LLC domain) / 110 (SMT domain)
> 
> We could have
> 
>   >> 2 (25%), >> 3 (12.5%), >> 4 (6.25%).
> 


Hmph, I see that task_numa_migrate() starts with a slightly different value
(112), and does the same halving pattern as wake_affine_weight():

  x = 100 + (sd->imbalance_pct - 100) / 2;

The 112 could use >> 3 (12.5%); the halving is just an extra shift with the
suggested changes.

> It's not strictly equivalent but IMO the whole imbalance_pct thing isn't
> very precise anyway; just needs to be good enough on a sufficient number of
> topologies.
> 
> 
> 
>>> +				env->imbalance = 0;
>>> +
>>>  		return;
>>>  	}
>>>  
