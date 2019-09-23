Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E58C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DBA20835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfIWQGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:06:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387866AbfIWQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:06:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9D61000;
        Mon, 23 Sep 2019 09:06:11 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6D73F67D;
        Mon, 23 Sep 2019 09:06:10 -0700 (PDT)
Subject: Re: [PATCH] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        shikemeng <shikemeng@huawei.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
 <1568535662-14956-1-git-send-email-shikemeng@huawei.com>
 <5dfd4844-6c36-3b8d-203b-564d7ad7103d@arm.com>
 <40680310-60b3-589a-d0e8-b4dd723db10a@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1d8e6aab-5258-494c-c4cd-1802eda34d59@arm.com>
Date:   Mon, 23 Sep 2019 17:06:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <40680310-60b3-589a-d0e8-b4dd723db10a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2019 16:43, Dietmar Eggemann wrote:
> I'm not sure that CONFIG_DEBUG_PER_CPU_MAPS=y will help you here.
> 
> __set_cpus_allowed_ptr(...)
> {
>     ...
>     dest_cpu = cpumask_any_and(...)
>     ...
> }
> 
> With:
> 
> #define cpumask_any_and(mask1, mask2) cpumask_first_and((mask1), (mask2))
> #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p),
> (src2p))
> 
> cpumask_next_and() is called with n = -1 and in this case does not
> invoke cpumask_check().
> 

It won't warn here because it's still a valid return value, but it should
warn in the cpumask_test_cpu() that follows (in is_cpu_allowed()) because
it would be passed a value >= nr_cpu_ids. So at the very least this config
does catch cpumask_any*() return values being blindly passed to
cpumask_test_cpu().

Calls to cpumask_any*() without relevant return value check can easily be
spotted by the coccinelle snippet I sent earlier. If this one fix gets
merged, I'll go and stare at / fixup the others (and maybe add the semantic
patch to coccicheck).

> ---
> 
> BTW, I can recreate the issue quite easily with:
> 
>   qemu-system-x86_64 ... -smp cores=64 ... -enable-kvm
> 
> with the default kernel config.
> 
> 

Might want to send your tested-by to [1] then :)

[1]: https://lkml.kernel.org/r/1568616808-16808-1-git-send-email-shikemeng@huawei.com

> 
