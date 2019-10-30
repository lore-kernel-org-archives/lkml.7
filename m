Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF0CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFC02080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfJ3QHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:07:54 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:36232 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfJ3QHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:07:53 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 94FEF98765
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 16:07:51 +0000 (GMT)
Received: (qmail 18503 invoked from network); 30 Oct 2019 16:07:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 16:07:51 -0000
Date:   Wed, 30 Oct 2019 16:07:49 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com,
        rong.a.chen@intel.com
Subject: Re: [PATCH] sched/fair: fix rework of find_idlest_group()
Message-ID: <20191030160749.GN3016@techsingularity.net>
References: <1571405198-27570-12-git-send-email-vincent.guittot@linaro.org>
 <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571762798-25900-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 06:46:38PM +0200, Vincent Guittot wrote:
> The task, for which the scheduler looks for the idlest group of CPUs, must
> be discounted from all statistics in order to get a fair comparison
> between groups. This includes utilization, load, nr_running and idle_cpus.
> 
> Such unfairness can be easily highlighted with the unixbench execl 1 task.
> This test continuously call execve() and the scheduler looks for the idlest
> group/CPU on which it should place the task. Because the task runs on the
> local group/CPU, the latter seems already busy even if there is nothing
> else running on it. As a result, the scheduler will always select another
> group/CPU than the local one.
> 
> Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

I had gotten fried by this point and had not queued this patch in advance
so I don't want to comment one way or the other. However, I note this was
not picked up in tip and it probably is best that this series all go in
as one lump and not separate out the fixes in the final merge. Otherwise
it'll trigger false positives by LKP.

-- 
Mel Gorman
SUSE Labs
