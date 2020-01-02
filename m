Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC7C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B0D20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgABTbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:31:02 -0500
Received: from foss.arm.com ([217.140.110.172]:49508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgABTbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:31:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03130328;
        Thu,  2 Jan 2020 11:31:01 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9F863F703;
        Thu,  2 Jan 2020 11:30:59 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     Valentin Schneider <valentin.schneider@arm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e9cb0848-2808-1b96-4fc4-1f6eacbeb70f@arm.com>
Date:   Thu, 2 Jan 2020 20:30:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2020 14:22, Valentin Schneider wrote:
> On 02/01/2020 12:47, Zengtao (B) wrote:

[...]

>> From schedule view of point, lower level sched domain should be a subset of higher
>> Level sched domain.
>>
> 
> Right, and that is checked when you have sched_debug on the cmdline
> (or write 1 to /sys/kernel/debug/sched_debug & regenerate the sched domains)

You should even get informed in case CONFIG_SCHED_DEBUG is not set.

   BUG: arch topology borken

With CONFIG_SCHED_DEBUG (and a CPU removed from the cpu_mask (DIE level)
on an Arm64 Juno board) you get extra information:

   BUG: arch topology borken
        the MC domain not a subset of the DIE domain

> Now, I don't know how this plays out for the numa-in-package topologies like
> the one suggested by Sudeep. x86 and AMD had to play some games to get
> numa-in-package topologies working, see e.g.
> 
>   cebf15eb09a2 ("x86, sched: Add new topology for multi-NUMA-node CPUs")
> 

Yeah, the reason why we need this change would be interesting.

[...]
