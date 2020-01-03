Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA97CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDD421D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgACMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:14:38 -0500
Received: from foss.arm.com ([217.140.110.172]:55160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgACMOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:14:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B681FB;
        Fri,  3 Jan 2020 04:14:37 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 172583F237;
        Fri,  3 Jan 2020 04:14:36 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
Message-ID: <66943c82-2cfd-351b-7f36-5aefdb196a03@arm.com>
Date:   Fri, 3 Jan 2020 12:14:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7b375d79-2d3c-422b-27a6-68972fbcbeaf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2020 10:57, Valentin Schneider wrote:
> I'm juggling with other things atm, but let me have a think and see if we
> couldn't detect that in the scheduler itself.
> 

Something like this ought to catch your case; might need to compare group
spans rather than pure group pointers.

---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..c4151e11afcd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1120,6 +1120,13 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 
 		sg = get_group(i, sdd);
 
+		/* sg's are inited as self-looping. If 'last' is not self
+		 * looping, we set it in a previous visit. No further visit
+		 * should change the link order, if we do then the topology
+		 * description is terminally broken.
+		 */
+		BUG_ON(last && last->next != last && last->next != sg);
+
 		cpumask_or(covered, covered, sched_group_span(sg));
 
 		if (!first)
