Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8212C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A428C2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfITNdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:33:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16433 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfITNdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:33:50 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28C303DE31
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 13:33:50 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id a4so2303007wrg.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Nx/aQvRelzeLvCi79YG6MG8KeIQqwCv6VmFW22dXX5s=;
        b=nJyjvuSQVSJmzkn10tG5ezJLnZBkHb9zT+vkaEhZXFMXoYhc0wVeoCLdDQpQocVyvS
         0LJ8C0/5vaxhByFtmr0lsn2q5rKgY9b8rOiOZuJkU8srklLRfPMU4TbawYJVFPH2CX1f
         nFjcZ42dZurtA5GNGh841fQH3N4fgauXaxkhyV+gl2mh3yr0JICnR6UB04YzJ6FjY+Gv
         xEbfvULAtyux91sZHC4LeRlZYXUUuHmhGAEeWcNzlKefKldoq3hULU1VeFjgFAJaQSc5
         jXA76M39+1M+raajCj4GZhS3srwk8k1MiJoZ/7udLq61DMo+NSw3kFkadOclTiT3UjJW
         Ki8A==
X-Gm-Message-State: APjAAAX8hSu1NKXKxAyTzC72pgaUGoVLDIBV7gP4f7Y4hqoP+dGxdiuP
        zLTGK8h4lDQP3RFtlUxfOOpe2Vz8yLFrt2/L3xJhDXFppEy3q/Bagk//AG66Fjvae45CrQmOxqy
        e1WG7prEXbw7cjRvOzaU7kLIv
X-Received: by 2002:a1c:608b:: with SMTP id u133mr3588938wmb.27.1568986428854;
        Fri, 20 Sep 2019 06:33:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxK0NaSgNeM2SWzbThQeAoHLMH7PRhHAfioEXu+xSV+Ql4+lSoQwnNXX4A4YPUbKk9NRokT7A==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr3588918wmb.27.1568986428623;
        Fri, 20 Sep 2019 06:33:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c1sm1536496wmk.20.2019.09.20.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 06:33:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Suleiman Souhlal <suleiman@google.com>
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de
Subject: Re: [RFC 2/2] x86/kvmclock: Use host timekeeping.
In-Reply-To: <20190920062713.78503-3-suleiman@google.com>
References: <20190920062713.78503-1-suleiman@google.com> <20190920062713.78503-3-suleiman@google.com>
Date:   Fri, 20 Sep 2019 15:33:47 +0200
Message-ID: <87woe38538.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suleiman Souhlal <suleiman@google.com> writes:

> When CONFIG_KVMCLOCK_HOST_TIMEKEEPING is enabled, and the host
> supports it, update our timekeeping parameters to be the same as
> the host. This lets us have our time synchronized with the host's,
> even in the presence of host NTP or suspend.
>
> When enabled, kvmclock uses raw tsc instead of pvclock.
>
> When enabled, syscalls that can change time, such as settimeofday(2)
> or adj_timex(2) are disabled in the guest.
>
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> ---
>  arch/x86/Kconfig                |   9 +++
>  arch/x86/include/asm/kvmclock.h |   2 +
>  arch/x86/kernel/kvmclock.c      | 127 +++++++++++++++++++++++++++++++-
>  kernel/time/timekeeping.c       |  21 ++++++
>  4 files changed, 155 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4195f44c6a09..37299377d9d7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -837,6 +837,15 @@ config PARAVIRT_TIME_ACCOUNTING
>  config PARAVIRT_CLOCK
>  	bool
>  
> +config KVMCLOCK_HOST_TIMEKEEPING
> +	bool "kvmclock uses host timekeeping"
> +	depends on KVM_GUEST
> +	---help---
> +	  Select this option to make the guest use the same timekeeping
> +	  parameters as the host. This means that time will be almost
> +	  exactly the same between the two. Only works if the host uses "tsc"
> +	  clocksource.
> +

I'd also like to speak up against this config, it is confusing. In case
the goal is to come up with a TSC-based clock for guests which will
return the same as clock_gettime() on the host (or, is the goal to just
have the same reading for all guests on the host?) I'd suggest we create
a separate (from KVMCLOCK) clocksource (mirroring host timekeeper) and
guests will be free to pick the one they like.

-- 
Vitaly
