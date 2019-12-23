Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5722C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B224D20715
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLWPjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:39:14 -0500
Received: from foss.arm.com ([217.140.110.172]:46964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfLWPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:39:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C9491FB;
        Mon, 23 Dec 2019 07:39:13 -0800 (PST)
Received: from [10.37.12.81] (unknown [10.37.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA2613F6CF;
        Mon, 23 Dec 2019 07:39:11 -0800 (PST)
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org
References: <20191216161650.21844-1-lukasz.luba@arm.com>
 <20191218120900.GA28599@bogus>
 <7b59a2f1-0786-d24f-a653-76a60c15a8ae@broadcom.com>
 <CA+-6iNxn29WpUrbc9gL4EMTJfZj7FRCeO-_QaUqbjJYd1JAEKA@mail.gmail.com>
 <7fe599d3-1ce2-1fde-2911-9516a26090b6@arm.com>
 <9befbc13-ba00-094d-0064-0d97c1ccbb63@broadcom.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <abad5f94-ce0d-99c9-bb9a-754c56849aee@arm.com>
Date:   Mon, 23 Dec 2019 15:39:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9befbc13-ba00-094d-0064-0d97c1ccbb63@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/20/19 4:24 PM, Jim Quinlan wrote:
> 
>> Thank you for sharing your experiments and thoughts. I have probably
>> similar setup for stressing the communication channel, but I do also
>> some wired things in the firmware. That's why I need to measure these
>> delays. I am happy that it is useful for you also.
>>
>> I don't know if your firmware supports 'fast channel', but please keep
>> in mind that it is not tracked in this 'transfer_id'.
>> This transfer_id in v2 version does not show the real transfers
>> to the firmware since there is another path called 'fast channel' or
>> 'fast_switch' in the CPUfreq. It is in drivers/firmware/arm_scmi/perf.c
>> and the atomic variable is not incremented in that path. Adding it also
>> there just for atomic_inc() probably would add delays in the fast_switch
>> and also brings little value.
>> For the normal channel, where we have spinlocks and other stuff, this
>> atomic_inc() could stay in my opinion.
>>
>> Regards,
>> Lukasz
> Hi Lukasz,
> 
> We currently do not use "fast channels" - although it is possible we might someday.
> I find the transfer_id useful per your v2 even if it doesn't cover FC.  Thanks for
> submitting and discussing this!

Thank you for cooperation.

Regards,
Lukasz

> 
> Regards,
> Jim Quinlan
> 
