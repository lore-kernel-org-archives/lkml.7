Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98834C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D18120659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGBJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:34:59 -0400
Received: from foss.arm.com ([217.140.110.172]:46660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:34:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF98344;
        Tue,  2 Jul 2019 02:34:57 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 085A83F718;
        Tue,  2 Jul 2019 02:34:56 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2] sched/fair: fix imbalance due to CPU affinity
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
References: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <7111f9d1-62f2-504c-a7ba-958b1c659cc8@arm.com>
Date:   Tue, 2 Jul 2019 10:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2019 16:47, Vincent Guittot wrote:
> The load_balance() has a dedicated mecanism to detect when an imbalance
> is due to CPU affinity and must be handled at parent level. In this case,
> the imbalance field of the parent's sched_group is set.
> 
> The description of sg_imbalanced() gives a typical example of two groups
> of 4 CPUs each and 4 tasks each with a cpumask covering 1 CPU of the first
> group and 3 CPUs of the second group. Something like:
> 
> 	{ 0 1 2 3 } { 4 5 6 7 }
> 	        *     * * *
> 
> But the load_balance fails to fix this UC on my octo cores system
> made of 2 clusters of quad cores.
> 
> Whereas the load_balance is able to detect that the imbalanced is due to
> CPU affinity, it fails to fix it because the imbalance field is cleared
> before letting parent level a chance to run. In fact, when the imbalance is
> detected, the load_balance reruns without the CPU with pinned tasks. But
> there is no other running tasks in the situation described above and
> everything looks balanced this time so the imbalance field is immediately
> cleared.
> 
> The imbalance field should not be cleared if there is no other task to move
> when the imbalance is detected.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Does that want a

Cc: stable@vger.kernel.org
Fixes: afdeee0510db ("sched: Fix imbalance flag reset")

?

