Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE5920700
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WkbpgOHY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XUq5OqQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfC2Mol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:44:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbfC2Mok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:44:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8497761196; Fri, 29 Mar 2019 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553863479;
        bh=X5EtW+vRpA+9PlReb6dckuvDaJoYTBL7NCn8yr0Xaug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WkbpgOHY0wYDkG5t5VKkY7r5n8YA7U3wv3P48yHd9KpIwB8zCchy0PMYOtjd/E20b
         ZAr35l3kIz0Ue1v1VKdrdH//FUgGGK8Ympgu+/pqT7Z9oMl9cDkFnWFVZT3y5Lt5Zm
         wt3xurcXxihrJEvVD1yWMVJhCPwHzoVQUVrMIMP8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00CF861891;
        Fri, 29 Mar 2019 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553863475;
        bh=X5EtW+vRpA+9PlReb6dckuvDaJoYTBL7NCn8yr0Xaug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XUq5OqQIYc/BsHt/PcQGZbN9hhI/wNqTuA9ViL+4+/wObRzrcS/vOI/7i/DikW+l5
         XPt9Odttccy1GdowDedN9EbJp0jIN2AgkW9IS2no9MATNRnUN253skbkorI9WVK21s
         m6S24LsNQ/j7+QTj2ZGUtpmZIud1Ec9OGuXJDL/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00CF861891
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] tick/broadcast: Fix warning about undefined
 tick_broadcast_oneshot_offline()
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org
References: <20190329110508.6621-1-bp@alien8.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6451ced9-1e65-d146-ac9b-a83f32c97685@codeaurora.org>
Date:   Fri, 29 Mar 2019 18:14:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329110508.6621-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 4:35 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>
> Randconfig builds with
>
>    CONFIG_TICK_ONESHOT=y
>    CONFIG_HOTPLUG_CPU=n
>
> trigger
>
>    kernel/time/tick-broadcast.c:39:13: warning: ‘tick_broadcast_oneshot_offline’ \
> 	  declared ‘static’ but never defined [-Wunused-function]
>
> due to that function's definition missing.
>
> Move the CONFIG_HOTPLUG_CPU ifdeffery around its declaration too.
>
> Fixes: 1b72d4323798 ("tick: Remove outgoing CPU from broadcast masks")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: x86@kernel.org


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   kernel/time/tick-broadcast.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 0283523de045..7541cbca695e 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -36,12 +36,16 @@ static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
>   static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
>   static void tick_broadcast_clear_oneshot(int cpu);
>   static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
> +# ifdef CONFIG_HOTPLUG_CPU
>   static void tick_broadcast_oneshot_offline(unsigned int cpu);
> +# endif
>   #else
>   static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
>   static inline void tick_broadcast_clear_oneshot(int cpu) { }
>   static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
> +# ifdef CONFIG_HOTPLUG_CPU
>   static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
> +# endif
>   #endif
>   
>   /*
