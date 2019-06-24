Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D00C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0891D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfFXRYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 13:24:42 -0400
Received: from foss.arm.com ([217.140.110.172]:55380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfFXRYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:24:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15500360;
        Mon, 24 Jun 2019 10:24:39 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E30A3F718;
        Mon, 24 Jun 2019 10:24:38 -0700 (PDT)
Subject: Re: [PATCH] sched/core: silence a warning in sched_init()
To:     Qian Cai <cai@lca.pw>, mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <1561384781-12308-1-git-send-email-cai@lca.pw>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <83e9a20d-bec6-72dd-2210-e019339fdb2a@arm.com>
Date:   Mon, 24 Jun 2019 18:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561384781-12308-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2019 14:59, Qian Cai wrote:
> Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
> will generate a warning using W=1,
> 
> kernel/sched/core.c: In function 'sched_init':
> kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
> [-Wunused-but-set-variable]
>   unsigned long alloc_size = 0, ptr;
>                                 ^~~
> 
> It apparently the maintainers don't like the proper fix [1] which
> contains ugly idefs, so silence it by appending the __maybe_unused
> attribute for it instead.
> 

As you say, ifdefs are ugly. I try to stay away from them as much as
possible (as you may have noticed with the NOHZ stuff). They just make
code harder to read (I know someone who'd say "it's free code obfuscation"),
and that is especially true in the patch you reference where it conditions
variable declaration.

So it may not have been the "proper" fix after all...

> [1] https://lore.kernel.org/lkml/1559681162-5385-1-git-send-email-cai@lca.pw/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/sched/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 874c427742a9..9bbad91b3f01 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5903,7 +5903,10 @@ int in_sched_functions(unsigned long addr)
>  void __init sched_init(void)
>  {
>  	int i, j;
> -	unsigned long alloc_size = 0, ptr;
> +	unsigned long alloc_size = 0;
> +
> +	/* To silence a -Wunused-but-set-variable warning. */
> +	unsigned long ptr __maybe_unused;
>  

To be super nitpicky, I'd argue the __maybe_unused attribute should be
placed before the variable name - the kernel/sched/* code goes with
prefixing rather than postfixing (there is *one* exception in deadline.c),
and I personally prefer prefixing as well (it just reads better).

To be (still, but slightly less) nitpicky, I'd remove the added newline
(keep the variable declaration as a single block) and even remove the
comment - it's redundant with the attribute.

With those changes:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>  	wait_bit_init();
>  
> 
