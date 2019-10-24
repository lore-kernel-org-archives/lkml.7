Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA3CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9B620659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393992AbfJXQpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:45:34 -0400
Received: from foss.arm.com ([217.140.110.172]:56604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390181AbfJXQpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:45:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1589F328;
        Thu, 24 Oct 2019 09:45:18 -0700 (PDT)
Received: from [10.1.194.37] (unknown [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637533F71F;
        Thu, 24 Oct 2019 09:45:16 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] sched/topology: Don't try to build empty sched
 domains
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        stable@vger.kernel.org
References: <20191023153745.19515-1-valentin.schneider@arm.com>
 <20191023153745.19515-2-valentin.schneider@arm.com>
 <27d8a51d-a899-67f4-8b74-224281f25cef@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7e20f309-3ca0-b916-b703-052ab8284012@arm.com>
Date:   Thu, 24 Oct 2019 17:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27d8a51d-a899-67f4-8b74-224281f25cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2019 17:19, Dietmar Eggemann wrote:
> Sorry for being picky but IMHO you should also mention that it fixes
> 
> f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting
> information")
> 

I can append the following to the changelog, although I'd like some
feedback from the cgroup folks before doing a respin:

"""
Note that commit

  f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")

introduced a similar issue. Since doms_new is assigned to doms_cur without
any filtering, we can end up with an empty cpumask in the doms_cur array.

The next time we go through a rebuild, this will break on:

  rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;

If there wasn't enough already, this is yet another argument for *not*
handing over empty cpumasks to the sched domain rebuild.
"""

I tagged the commit that introduces the static key with Fixes: because it
was introduced earlier - I don't think it would make sense to have two
"Fixes:" lines? In any case, it'll now be listed in the changelog.

