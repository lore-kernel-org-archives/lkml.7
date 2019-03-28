Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6FAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067852075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfC1JhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfC1JhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07C5031688E3;
        Thu, 28 Mar 2019 09:37:04 +0000 (UTC)
Received: from [10.36.112.59] (ovpn-112-59.ams2.redhat.com [10.36.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 018C71001DCC;
        Thu, 28 Mar 2019 09:36:57 +0000 (UTC)
Subject: Re: [PATCH] watchdog: Respect watchdog cpumask on CPU hotplug
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
References: <alpine.DEB.2.21.1903262245490.1789@nanos.tec.linutronix.de>
 <20190327151653.GA23811@redhat.com>
 <alpine.DEB.2.21.1903272009000.1789@nanos.tec.linutronix.de>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <34bbf93b-608f-b1ee-7b20-acb0def240a1@redhat.com>
Date:   Thu, 28 Mar 2019 10:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903272009000.1789@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 28 Mar 2019 09:37:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/19 8:10 PM, Thomas Gleixner wrote:
> On Wed, 27 Mar 2019, Oleg Nesterov wrote:
>> On 03/26, Thomas Gleixner wrote:
>>>
>>> The rework of the watchdog core to use cpu_stop_work broke the watchdog
>>> cpumask on CPU hotplug.
>>>
>>> The watchdog_enable/disable() functions are now called unconditionally from
>>> the hotplug callback, i.e. even on CPUs which are not in the watchdog
>>> cpumask.
>>>
>>> Only invoke them when the plugged CPU is in the watchdog cpumask.
>>
>> IIUC without this fix an NMI watchdog can too be enabled at boot time even
>> if the initial watchdog_cpumask = housekeeping_cpumask(HK_FLAG_TIMER) doesn't
>> include the plugged CPU.
> 
> Yes.
> 
>> And after that writing 0 to /proc/sys/kernel/nmi_watchdog clears
>> NMI_WATCHDOG_ENABLED but this can't disable NMI watchdog's outside of
>> watchdog_allowed_mask.
> 
> Correct
> 
>> So may be this can explain the problem reported by Maxime ?
>> See https://lore.kernel.org/lkml/b99c5a25-a5fe-18dd-2f1d-bdd6834f03e5@redhat.com/
> 
> That looks so.

I had a trial with your patch, and I can confirm it fixes my issue:

Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

> Thanks,
> 
> 	tglx
> 
