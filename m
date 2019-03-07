Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E6C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFE420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCGPT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:19:59 -0500
Received: from foss.arm.com ([217.140.101.70]:47142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCGPT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:19:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88E68EBD;
        Thu,  7 Mar 2019 07:19:58 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5813F706;
        Thu,  7 Mar 2019 07:19:56 -0800 (PST)
Date:   Thu, 7 Mar 2019 15:19:54 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>
Cc:     quentin.perret@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190307151954.GB5778@e107155-lin>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:57:53PM +0530, Lingutla Chandrasekhar wrote:
> If user updates any cpu's cpu_capacity, then the new value is going to
> be applied to all its online sibling cpus. But this need not to be correct
> always, as sibling cpus (in ARM, same micro architecture cpus) would have
> different cpu_capacity with different performance characteristics.
> So updating the user supplied cpu_capacity to all cpu siblings
> is not correct.
>
> And another problem is, current code assumes that 'all cpus in a cluster
> or with same package_id (core_siblings), would have same cpu_capacity'.
> But with commit '5bdd2b3f0f8 ("arm64: topology: add support to remove
> cpu topology sibling masks")', when a cpu hotplugged out, the cpu
> information gets cleared in its sibling cpus. So user supplied
> cpu_capacity would be applied to only online sibling cpus at the time.
> After that, if any cpu hot plugged in, it would have different cpu_capacity
> than its siblings, which breaks the above assumption.
>
> So instead of mucking around the core sibling mask for user supplied
> value, use device-tree to set cpu capacity. And make the cpu_capacity
> node as read-only to know the assymetry between cpus in the system.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

IIRC this was added for 2 possibilities though I don't completely agree
no one had any objections(including me though I wonder how/why I missed
to notice it now, anyways it's too late)

1. For systems that don't provide this information via device-tree/any
   firmware though that's the highly recommended way. With more complex
   topologies in horizon, I can't think of fetching/deducing this
   information *correctly* in any other sane way.

2. For some sort of tuning(avoid rebuild and reboot), but that's
   questionable as this is not a software characteristic. It's more
   like deriving hardware characteristics using software experiments.
   So, for me, we can compare this with some hardware latencies we have
   like CPU idle entry/exit latencies. They are tuned but not in
   production kernels. So if there's a case for adding this back as
   write capable sysfs, I would prefer that in debugfs and this sysfs
   is read-only ABI.

Hope that helps.

--
Regards,
Sudeep
