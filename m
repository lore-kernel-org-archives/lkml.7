Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A69C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E6208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfH2Kia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:38:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbfH2Ki3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:38:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D896B360;
        Thu, 29 Aug 2019 03:38:28 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE9F53F59C;
        Thu, 29 Aug 2019 03:38:27 -0700 (PDT)
Subject: Re: [PATCH 1/1] sched/rt: avoid contend with CFS task
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Qais Yousef <qais.yousef@arm.com>
References: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d5100b2d-46c4-5811-8274-8b06710d2594@arm.com>
Date:   Thu, 29 Aug 2019 11:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567048502-6064-1-git-send-email-jing-ting.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 04:15, Jing-Ting Wu wrote:
> At original linux design, RT & CFS scheduler are independent.
> Current RT task placement policy will select the first cpu in
> lowest_mask, even if the first CPU is running a CFS task.
> This may put RT task to a running cpu and let CFS task runnable.
> 
> So we select idle cpu in lowest_mask first to avoid preempting
> CFS task.
> 

Regarding the RT & CFS thing, that's working as intended. RT is a whole
class above CFS, it shouldn't have to worry about CFS.

On the other side of things, CFS does worry about RT. We have the concept
of RT-pressure in the CFS scheduler, where RT tasks will reduce a CPU's
capacity (see fair.c::scale_rt_capacity()).

CPU capacity is looked at on CFS wakeup (see wake_cap() and
find_idlest_cpu()), and the periodic load balancer tries to spread load
over capacity, so it'll tend to put less things on CPUs that are also
running RT tasks.

If RT were to start avoiding rqs with CFS tasks, we'd end up with a nasty
situation were both are avoiding each other. It's even more striking when
you see that RT pressure is done with a rq-wide RT util_avg, which
*doesn't* get migrated when a RT task migrates. So if you decide to move
a RT task to an idle CPU "B" because CPU "A" had runnable CFS tasks, the
CFS scheduler will keep seeing CPU "B" as not significantly RT-pressured
while that util_avg signal ramps up, whereas it would correctly see CPU
"A" as RT-pressured if the RT task previously ran there.

So overall I think this is the wrong approach.

> Signed-off-by: Jing-Ting Wu <jing-ting.wu@mediatek.com>
> ---
