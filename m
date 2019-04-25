Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923B62236D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="yVeHH28M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbfDYM1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:27:18 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35302 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbfDYM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:27:17 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2C09B2E0B04;
        Thu, 25 Apr 2019 15:27:14 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id WWLudDTxMW-RDUOHDrB;
        Thu, 25 Apr 2019 15:27:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1556195234; bh=hiubUxF2p1tg6zFzAm2GbGex+r0a5gleB4Vu5UFdnuk=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=yVeHH28MX8kPfHNIoHm5BrMh64/hHpZjqK1GbOoPH8QKndafP8jc7RGSBci8fzOhb
         g4FwSWuUc9XV6KWu1V5IlDcFzxvBgSDFMEmXp1v45menJI1jy2nIDWTf64dUINlXJG
         RKiv+KqP6GWP37+VbKsUkcm4qEyES6UUp3QzZpYo=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:547a:aec1:8b2f:9dac])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xWsTxfSsVe-RD5WuSoP;
        Thu, 25 Apr 2019 15:27:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] x86 / CPU: Add cpu isolation flag for avoiding
 disturbance from aperfmperf IPI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
References: <155618921176.2006.3031084313219003524.stgit@buzz>
 <20190425114503.GP4038@hirez.programming.kicks-ass.net>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8b54ebf5-7daf-2760-7210-e0e945014c9e@yandex-team.ru>
Date:   Thu, 25 Apr 2019 15:27:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425114503.GP4038@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.2019 14:45, Peter Zijlstra wrote:
> On Thu, Apr 25, 2019 at 01:46:51PM +0300, Konstantin Khlebnikov wrote:
>> Sensitive workloads like DPDK polling do not like any interrupts.
>>
>> This patch adds flag 'freq' for boot option 'isolcpu': isolcpu=freq,<cpus>.
>>
>> Users like show_cpuinfo() fallback to frequency from generic cpufreq
>> policy if arch-specific requesting method returns 0.
> 
> Then don't touch that sysfs file?

What sysfs file?
I mean many applications read /proc/cpuinfo and this triggers IPI to all cpus.

> 
> I really hate having an option for just this.
> 

This could be generalized to 'isolate cpu from unnecessary IPI'.
Something like mm pagevec drain also could be avoided.
