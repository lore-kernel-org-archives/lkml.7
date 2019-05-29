Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B24C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BA20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfE2Kqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:46:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43322 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2Kqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:46:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F9D341;
        Wed, 29 May 2019 03:46:53 -0700 (PDT)
Received: from [10.1.196.108] (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E133F59C;
        Wed, 29 May 2019 03:46:51 -0700 (PDT)
Subject: Re: [RFC 4/7] arm64: pmu: Add function implementation to update event
 index in userpage.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org, mark.rutland@arm.com
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-5-raphael.gault@arm.com>
 <20190529094659.GK2623@hirez.programming.kicks-ass.net>
From:   Raphael Gault <raphael.gault@arm.com>
Message-ID: <42a937dd-5cf6-6738-6f69-005fce64138f@arm.com>
Date:   Wed, 29 May 2019 11:46:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190529094659.GK2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 5/29/19 10:46 AM, Peter Zijlstra wrote:
> On Tue, May 28, 2019 at 04:03:17PM +0100, Raphael Gault wrote:
>> +static int armv8pmu_access_event_idx(struct perf_event *event)
>> +{
>> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
>> +		return 0;
>> +
>> +	/*
>> +	 * We remap the cycle counter index to 32 to
>> +	 * match the offset applied to the rest of
>> +	 * the counter indeces.
>> +	 */
>> +	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
>> +		return 32;
>> +
>> +	return event->hw.idx;
> 
> Is there a guarantee event->hw.idx is never 0? Or should you, just like
> x86, use +1 here?
> 

You are right, I should use +1 here. Thanks for pointing that out.

>> +}

Thanks,

-- 
Raphael Gault
