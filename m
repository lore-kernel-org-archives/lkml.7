Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B1C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2644C2339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbfHVIju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbfHVIju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:39:50 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3B57859FB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:39:49 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id x12so2863143wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 01:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1G74LHLrsWvUSFOFRiuwPg31y9BxmHy+eemqbD81aoo=;
        b=Y8mL4AbbYrm3GoQnjqmrm69UzLd4YnYPv3n4yaZbwDorKojBh/cEKd98oKR3d0wHKl
         fi+1ktQOD6aPbrWT8KS4s8OsNzXDovjIZAFiiuJp91yGyFbh6nPM1Ur0mP4Zr0z4JMqO
         wNFxmmFHOhK5hdppMnKTFp1rO0BSF88W+WEvX+9+DHS4dzgGysz9bW04ymUe1oCDkAmi
         gpetnenVLhucTgOpA3EmjUpmDHbukgY6YX5WwpgaSVKPSZ3lVGRBUXPmRLc9NjKHckxq
         sbDb31M3wbPUzpPvZsz40bIU9jGDy7iVcF4U3UGAOHSMs6YnZ5N8V73Y2AZC56f2ciDK
         7nOw==
X-Gm-Message-State: APjAAAUQA2wXD9srUOv5dvIMswQmuRJ4KF0kiFdJyMQ1aoaPaM344K24
        5w9pfK9nr6rOtCeX+N8sTD3Cdgep4mCgJXZQSSTkV8ryz5gWoBRdTA+h9XXwNrVpMJq6msLj1+c
        Gzw6dGZYACttTJ3NFO7lc5vvI
X-Received: by 2002:a1c:a584:: with SMTP id o126mr4930142wme.147.1566463188407;
        Thu, 22 Aug 2019 01:39:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2J+YaWKSPJhnayRR+gWUpkar/H3AzFK5rRtAD4OK1TGp8qXqYF0ivcPwnqhAMmghUwtqNNQ==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr4930111wme.147.1566463188178;
        Thu, 22 Aug 2019 01:39:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q20sm77625914wrc.79.2019.08.22.01.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 01:39:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        daniel.lezcano@linaro.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix build error with CONFIG_HYPERV_TSCPAGE=N
In-Reply-To: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
References: <20190822053852.239309-1-Tianyu.Lan@microsoft.com>
Date:   Thu, 22 Aug 2019 10:39:46 +0200
Message-ID: <87zhk1pp9p.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Both Hyper-V tsc page and Hyper-V tsc MSR code use variable
> hv_sched_clock_offset for their sched clock callback and so
> define the variable regardless of CONFIG_HYPERV_TSCPAGE setting.

CONFIG_HYPERV_TSCPAGE is gone after my "x86/hyper-v: enable TSC page
clocksource on 32bit" patch. Do we still have an issue to fix?

>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> This patch is based on the top of "git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> timers/core".
>
>  drivers/clocksource/hyperv_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index dad8af198e20..c322ab4d3689 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -22,6 +22,7 @@
>  #include <asm/mshyperv.h>
>  
>  static struct clock_event_device __percpu *hv_clock_event;
> +static u64 hv_sched_clock_offset __ro_after_init;
>  
>  /*
>   * If false, we're using the old mechanism for stimer0 interrupts
> @@ -215,7 +216,6 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
>  #ifdef CONFIG_HYPERV_TSCPAGE
>  
>  static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
> -static u64 hv_sched_clock_offset __ro_after_init;
>  
>  struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>  {

-- 
Vitaly
