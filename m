Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B82CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F4C20679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfJ3Pyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:54:36 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:50861 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728347AbfJ3Py3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:54:29 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 4D25E987E2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 15:54:27 +0000 (GMT)
Received: (qmail 12748 invoked from network); 30 Oct 2019 15:54:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.19.210])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Oct 2019 15:54:27 -0000
Date:   Wed, 30 Oct 2019 15:54:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com, parth@linux.ibm.com, riel@surriel.com
Subject: Re: [PATCH v4 05/11] sched/fair: use rq->nr_running when balancing
 load
Message-ID: <20191030155424.GK3016@techsingularity.net>
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <1571405198-27570-6-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1571405198-27570-6-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:26:32PM +0200, Vincent Guittot wrote:
> cfs load_balance only takes care of CFS tasks whereas CPUs can be used by
> other scheduling class. Typically, a CFS task preempted by a RT or deadline
> task will not get a chance to be pulled on another CPU because the
> load_balance doesn't take into account tasks from other classes.
> Add sum of nr_running in the statistics and use it to detect such
> situation.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Patch is ok but it'll be easier in the future to mix up sum_nr_running
and sum_h_nr_running in the future. Might be best to make sum_nr_running
sum_any_running and the hierarchy one sum_cfs_running. I don't feel
strongly either way, because it's almost certainly due to the fact I
almost never care about non-cfs tasks when thinking about the scheduler.

-- 
Mel Gorman
SUSE Labs
