Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD03C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0CB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHLKsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:48:22 -0400
Received: from foss.arm.com ([217.140.110.172]:48192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfHLKsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:48:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5A5A15AB;
        Mon, 12 Aug 2019 03:48:21 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 111603F706;
        Mon, 12 Aug 2019 03:48:20 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: Serialize enabling/disabling a link device.
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     yabinc@google.com, mathieu.poirier@linaro.org,
        alexander.shishkin@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190809214538.29677-1-yabinc@google.com>
 <056f411f-eef2-752e-0c02-2e5ed803cc62@arm.com>
Message-ID: <606aaae4-3f26-7a58-3276-f4c5e3f8d17d@arm.com>
Date:   Mon, 12 Aug 2019 11:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <056f411f-eef2-752e-0c02-2e5ed803cc62@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yabin,

On 12/08/2019 11:38, Suzuki K Poulose wrote:
> 
> Hi Yabin,
> 
> On 09/08/2019 22:45, Yabin Cui wrote:
>> When tracing etm data of multiple threads on multiple cpus through perf
>> interface, some link devices are shared between paths of different cpus.
>> It creates race conditions when different cpus wants to enable/disable
>> the same link device at the same time.
>>
>> Example 1:
>> Two cpus want to enable different ports of a coresight funnel, thus
>> calling the funnel enable operation at the same time. But the funnel
>> enable operation isn't reentrantable.
>>
>> Example 2:
>> For an enabled coresight dynamic replicator with refcnt=1, one cpu wants
>> to disable it, while another cpu wants to enable it. Ideally we still have
>> an enabled replicator with refcnt=1 at the end. But in reality the result
>> is uncertain.
>>
>> Since coresight devices claim themselves when enabled for self-hosted
>> usage, the race conditions above usually make the link devices not usable
>> after many cycles.
>>
>> To fix the race conditions, this patch adds a spinlock to serialize
>> enabling/disabling a link device.

Please could you also add :

Fixes : a06ae8609b3dd ("coresight: add CoreSight core layer framework")

Suzuki
