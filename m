Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D693C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E72B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbfC0K4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:56:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52618 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbfC0K4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:56:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA236A78;
        Wed, 27 Mar 2019 03:56:45 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256363F557;
        Wed, 27 Mar 2019 03:56:44 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:56:42 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>
Cc:     sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190327105640.ibiw5mvuggp35msl@queper01-lin>
References: <df8c3952-b1ab-bc15-ccb7-e4a5d7d54bf8@arm.com>
 <1552048728-29657-1-git-send-email-clingutla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552048728-29657-1-git-send-email-clingutla@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 08 Mar 2019 at 18:08:48 (+0530), Lingutla Chandrasekhar wrote:
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
> While at it, remove cpu_scale_mutex usage, which used for sysfs write
> protection.
> 
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>

Reviewed-by: Quentin Perret <quentin.perret@arm.com>
Tested-by: Quentin Perret <quentin.perret@arm.com>

Thanks for doing this,
Quentin
