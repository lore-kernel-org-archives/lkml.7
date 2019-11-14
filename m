Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAA8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991A5206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNQDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:03:53 -0500
Received: from foss.arm.com ([217.140.110.172]:45590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfKNQDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:03:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4531328;
        Thu, 14 Nov 2019 08:03:52 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717EF3F52E;
        Thu, 14 Nov 2019 08:03:51 -0800 (PST)
Subject: Re: [PATCH v2] sched/topology, cpuset: Account for housekeeping CPUs
 to avoid empty cpumasks
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20191104003906.31476-1-valentin.schneider@arm.com>
Message-ID: <d7ed40aa-1ac1-a42d-51eb-b1bd9f839fb1@arm.com>
Date:   Thu, 14 Nov 2019 16:03:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104003906.31476-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 00:39, Valentin Schneider wrote:
> Michal noted that a cpuset's effective_cpus can be a non-empy mask, but
> because of the masking done with housekeeping_cpumask(HK_FLAG_DOMAIN)
> further down the line, we can still end up with an empty cpumask being
> passed down to partition_sched_domains_locked().
> 
> Do the proper thing and don't just check the mask is non-empty - check
> that its intersection with housekeeping_cpumask(HK_FLAG_DOMAIN) is
> non-empty.
> 
> Fixes: cd1cb3350561 ("sched/topology: Don't try to build empty sched domains")
> Reported-by: Michal Koutný <mkoutny@suse.com>

Michal, could I nag you for a reviewed-by? I'd feel a bit more confident
with any sort of approval from folks who actually do use cpusets.

> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
