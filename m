Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E55CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF8521D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="UVm8WGJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394383AbfJYJiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:38:03 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:55362 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbfJYJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:38:02 -0400
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 6619B9F64C;
        Fri, 25 Oct 2019 09:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1571996280; bh=3q0asO118tF1DALeYypzSAxsX3AgnykiKoF4WVnAhMk=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=UVm8WGJMD0FTuKmVfovQfnJa6AG7n9u5+ujc9faJRaNhjORK+A1BzW65fGe5l7HYD
         kCrzw1sSBFUQ3k8KUJFF1w0VJzH/sjSQ7Y2ZUIwXJ3iixPwsgLEanPzVt+1hwZwuiY
         0OCOM0ocPn4Qcfogk8ChIpv5DOvw5YYggER36tLc=
Subject: Re: [PATCH v2 1/1] xfrm : lock input tasklet skb queue
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Tom Rix <trix@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACVy4SUkfn4642Vne=c1yuWhne=2cutPZQ5XeXz_QBz1g67CrA@mail.gmail.com>
 <20191024103134.GD13225@gauss3.secunet.de>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <ad094bfc-ebb3-012b-275b-05fb5a8f86e5@jv-coder.de>
Date:   Fri, 25 Oct 2019 11:37:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191024103134.GD13225@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I always expected this to be applied to the RT patches. That's why
I originally send my patch to to Sebastian, Thomas and Steven (I added
them again now. The website of the rt patches says patches for the
CONFIG_REEMPT_RT patchset should be send to lkml.

I hope one of the rt patch maintainers will reply here.

Jörg

Am 24.10.2019 um 12:31 schrieb Steffen Klassert:
> On Tue, Oct 22, 2019 at 05:22:04PM -0700, Tom Rix wrote:
>> On PREEMPT_RT_FULL while running netperf, a corruption
>> of the skb queue causes an oops.
>>
>> This appears to be caused by a race condition here
>>          __skb_queue_tail(&trans->queue, skb);
>>          tasklet_schedule(&trans->tasklet);
>> Where the queue is changed before the tasklet is locked by
>> tasklet_schedule.
>>
>> The fix is to use the skb queue lock.
>>
>> This is the original work of Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> https://lkml.org/lkml/2019/9/9/111
>>    xfrm_input: Protect queue with lock
>>
>>    During the skb_queue_splice_init the tasklet could have been preempted
>>    and __skb_queue_tail called, which led to an inconsistent queue.
>>
>> ifdefs for CONFIG_PREEMPT_RT_FULL added to reduce runtime effects
>> on the normal kernel.
> Has Herbert commented on your initial patch, please
> fix PREEMPT_RT_FULL instead. There are certainly many
> more codepaths that take such assumptions. You can not
> fix this by distributing a spin_lock_irqsave here
> and there.
>

