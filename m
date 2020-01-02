Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35DCC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8BB20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgABNWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 08:22:22 -0500
Received: from foss.arm.com ([217.140.110.172]:47148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgABNWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:22:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 437CF1FB;
        Thu,  2 Jan 2020 05:22:21 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C13C3F703;
        Thu,  2 Jan 2020 05:22:20 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
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
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
Date:   Thu, 2 Jan 2020 13:22:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2020 12:47, Zengtao (B) wrote:
>>
>> As I said, wrong configurations need to be detected when generating
>> DT/ACPI if possible. The above will print warning on systems with NUMA
>> within package.
>>
>> NUMA:  0-7, 8-15
>> core_siblings:   0-15
>>
>> The above is the example where the die has 16 CPUs and 2 NUMA nodes
>> within a package, your change throws error to the above config which is
>> wrong.
>>
> From your example, the core 7 and core 8 has got different LLC but the same Low
> Level cache?

AFAIA what matters here is memory controllers, less so LLCs. Cores within
a single die could have private LLCs and separate memory controllers, or
shared LLC and separate memory controllers.

> From schedule view of point, lower level sched domain should be a subset of higher
> Level sched domain.
> 

Right, and that is checked when you have sched_debug on the cmdline
(or write 1 to /sys/kernel/debug/sched_debug & regenerate the sched domains)

Now, I don't know how this plays out for the numa-in-package topologies like
the one suggested by Sudeep. x86 and AMD had to play some games to get
numa-in-package topologies working, see e.g.

  cebf15eb09a2 ("x86, sched: Add new topology for multi-NUMA-node CPUs")

perhaps you need to "lie" here and ensure sub-NUMA sched domain levels are
a subset of the NUMA levels, i.e. lie for core_siblings. I might go and
play with this to see how it behaves.
