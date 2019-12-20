Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098EDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA002465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLTJUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:20:45 -0500
Received: from foss.arm.com ([217.140.110.172]:48540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfLTJUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:20:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D8130E;
        Fri, 20 Dec 2019 01:20:44 -0800 (PST)
Received: from [10.37.12.112] (unknown [10.37.12.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501863F718;
        Fri, 20 Dec 2019 01:20:43 -0800 (PST)
Subject: Re: [PATCH 1/2] include: trace: Add SCMI header with trace events
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rostedt@goodmis.org
References: <20191216161650.21844-1-lukasz.luba@arm.com>
 <20191218120900.GA28599@bogus>
 <7b59a2f1-0786-d24f-a653-76a60c15a8ae@broadcom.com>
 <CA+-6iNxn29WpUrbc9gL4EMTJfZj7FRCeO-_QaUqbjJYd1JAEKA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7fe599d3-1ce2-1fde-2911-9516a26090b6@arm.com>
Date:   Fri, 20 Dec 2019 09:20:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+-6iNxn29WpUrbc9gL4EMTJfZj7FRCeO-_QaUqbjJYd1JAEKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On 12/19/19 4:32 PM, Jim Quinlan wrote:
>> I also see a stretch of over 100 (contiguous) of these
>>
>> ... scmi_rx_done: transfer_id=48321 msg_id=7 protocol_id=128 seq=0 msg_type=0
>> ... scmi_rx_done: transfer_id=48322 msg_id=8 protocol_id=128 seq=0 msg_type=0
>> ... scmi_rx_done: transfer_id=48323 msg_id=7 protocol_id=128 seq=0 msg_type=0
>> ... scmi_rx_done: transfer_id=48324 msg_id=8 protocol_id=128 seq=0 msg_type=0
>>
>> which I cannot explain -- perhaps ftrace doesn't work well in interrupt context?
> 
> Hello,
> Please ignore my previous results; I've switched to using 'nop' as the
> current_tracer and the above issue has cleared up.  I now get traces
> like below:
> 
>            <idle>-0     [000] d.h.   907.608763: scmi_rx_done:
> transfer_id=10599 msg_id=7 protocol_id=128 seq=2 msg_type=0
>         t1-sensor-1817  [003] ....   907.608879: scmi_xfer_begin:
> transfer_id=10601 msg_id=6 protocol_id=21 seq=1 poll=0
>           t0-brcm-1815  [000] d.h.   907.614133: scmi_rx_done:
> transfer_id=10600 msg_id=7 protocol_id=20 seq=0 msg_type=0
>           t0-brcm-1815  [000] ....   907.614189: scmi_xfer_end:
> transfer_id=10599 msg_id=7 protocol_id=128 seq=2 status=0
>           t0-brcm-1815  [000] ....   907.614215: scmi_xfer_begin:
> transfer_id=10602 msg_id=8 protocol_id=128 seq=2 poll=0
>            <idle>-0     [000] d.h.   907.616380: scmi_rx_done:
> transfer_id=10601 msg_id=6 protocol_id=21 seq=1 msg_type=0
>          t2-clock-1818  [003] ....   907.616418: scmi_xfer_end:
> transfer_id=10600 msg_id=7 protocol_id=20 seq=0 status=0
>          t2-clock-1818  [003] ....   907.616440: scmi_xfer_begin:
> transfer_id=10603 msg_id=7 protocol_id=20 seq=0 poll=0
>         t1-sensor-1817  [003] ....   907.616474: scmi_xfer_end:
> transfer_id=10601 msg_id=6 protocol_id=21 seq=1 status=0
>            <idle>-0     [000] d.h.   907.616478: scmi_rx_done:
> transfer_id=10602 msg_id=8 protocol_id=128 seq=2 msg_type=0
>           t0-brcm-1815  [000] d.h.   907.616526: scmi_rx_done:
> transfer_id=10603 msg_id=7 protocol_id=20 seq=0 msg_type=0
>           t0-brcm-1815  [000] ....   907.616559: scmi_xfer_end:
> transfer_id=10602 msg_id=8 protocol_id=128 seq=2 status=0
>           t0-brcm-1815  [000] .n..   907.616588: scmi_xfer_begin:
> transfer_id=10604 msg_id=7 protocol_id=128 seq=1 poll=0
>         t1-sensor-1817  [003] ....   907.616628: scmi_xfer_begin:
> transfer_id=10605 msg_id=6 protocol_id=21 seq=2 poll=0
>          t2-clock-1818  [003] ....   907.616660: scmi_xfer_end:
> transfer_id=10603 msg_id=7 protocol_id=20 seq=0 status=0
>            <idle>-0     [000] d.h.   907.616665: scmi_rx_done:
> transfer_id=10604 msg_id=7 protocol_id=128 seq=1 msg_type=0
>          t2-clock-1818  [003] ....   907.616673: scmi_xfer_begin:
> transfer_id=10606 msg_id=7 protocol_id=20 seq=0 poll=0
>           t0-brcm-1815  [000] d.h.   907.618782: scmi_rx_done:
> transfer_id=10605 msg_id=6 protocol_id=21 seq=2 msg_type=0
>         t1-sensor-1817  [003] ....   907.618829: scmi_xfer_end:
> transfer_id=10605 msg_id=6 protocol_id=21 seq=2 status=0
>           t0-brcm-1815  [000] dnH.   907.618834: scmi_rx_done:
> transfer_id=10606 msg_id=7 protocol_id=20 seq=0 msg_type=0
>           t0-brcm-1815  [000] .n..   907.618855: scmi_xfer_end:
> transfer_id=10604 msg_id=7 protocol_id=128 seq=1 status=0
>           t0-brcm-1815  [000] .n..   907.618873: scmi_xfer_begin:
> transfer_id=10607 msg_id=8 protocol_id=128 seq=1 poll=0
>          t2-clock-1818  [003] ....   907.618890: scmi_xfer_end:
> transfer_id=10606 msg_id=7 protocol_id=20 seq=0 status=0
>         rcu_sched-7     [000] d.h.   907.618898: scmi_rx_done:
> transfer_id=10607 msg_id=8 protocol_id=128 seq=1 msg_type=0
>           t0-brcm-1815  [000] ....   907.618934: scmi_xfer_end:
> transfer_id=10607 msg_id=8 protocol_id=128 seq=1 status=0
>           t3-brcm-1819  [003] ....   907.618958: scmi_xfer_begin:
> transfer_id=10608 msg_id=7 protocol_id=128 seq=0 poll=0
>            <idle>-0     [000] d.h.   907.618974: scmi_rx_done:
> transfer_id=10608 msg_id=7 protocol_id=128 seq=0 msg_type=0
>           t3-brcm-1819  [003] ....   907.619005: scmi_xfer_end:
> transfer_id=10608 msg_id=7 protocol_id=128 seq=0 status=0
>           t3-brcm-1819  [003] ....   907.619013: scmi_xfer_begin:
> transfer_id=10609 msg_id=8 protocol_id=128 seq=0 poll=0
> 
> And with V2 having the added xfer id allows me to more easily post
> process the above with a script and highlight messages that took too
> long (round trip times > 3msec get a double asterisk):
> 
>       10585      0.02 ms  proto=128  cmd=8  seq=0
>       10586      2.16 ms  proto= 21  cmd=6  seq=0
>       10587      0.87 ms  proto=128  cmd=7  seq=1
>       10588      0.02 ms  proto=128  cmd=8  seq=0
>       10589      0.05 ms  proto=128  cmd=7  seq=0
>       10590      2.15 ms  proto= 21  cmd=6  seq=1
>       10591      2.19 ms  proto=128  cmd=8  seq=0
>       10592      2.13 ms  proto= 21  cmd=6  seq=0
>       10593      0.03 ms  proto=128  cmd=7  seq=0
>       10594      0.02 ms  proto=128  cmd=8  seq=0
>       10595      0.02 ms  proto=128  cmd=7  seq=0
>       10596      0.02 ms  proto=128  cmd=8  seq=0
>       10597  **  7.16 ms  proto= 20  cmd=7  seq=0
>       10598  **  7.12 ms  proto= 21  cmd=6  seq=1
>       10599  ** 11.58 ms  proto=128  cmd=7  seq=2
>       10600  **  9.28 ms  proto= 20  cmd=7  seq=0
>       10601  **  7.60 ms  proto= 21  cmd=6  seq=1
>       10602      2.34 ms  proto=128  cmd=8  seq=2
>       10603      0.22 ms  proto= 20  cmd=7  seq=0
>       10604      2.27 ms  proto=128  cmd=7  seq=1
>       10605      2.20 ms  proto= 21  cmd=6  seq=2
> 
> So I do find the extra msg id helpful as well as the extra traceprint.

Thank you for sharing your experiments and thoughts. I have probably
similar setup for stressing the communication channel, but I do also
some wired things in the firmware. That's why I need to measure these
delays. I am happy that it is useful for you also.

I don't know if your firmware supports 'fast channel', but please keep
in mind that it is not tracked in this 'transfer_id'.
This transfer_id in v2 version does not show the real transfers
to the firmware since there is another path called 'fast channel' or
'fast_switch' in the CPUfreq. It is in drivers/firmware/arm_scmi/perf.c
and the atomic variable is not incremented in that path. Adding it also
there just for atomic_inc() probably would add delays in the fast_switch
and also brings little value.
For the normal channel, where we have spinlocks and other stuff, this
atomic_inc() could stay in my opinion.

Regards,
Lukasz

> 
> Regards,
> Jim Quinlan
> 
