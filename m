Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB433C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0w09Cc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfLGWy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:54:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33315 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfLGWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:54:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id y206so5258417pfb.0;
        Sat, 07 Dec 2019 14:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvfdz5udoYz82rV5IF60wkSHWqYMMiaRlZ1jxaHcNl8=;
        b=Z0w09Cc/v/rBnmUL5qWli1KSsd/0UP+Xl4IeCm9eIRXU/DnOHjVEPU2LfQ5iNvBAo0
         T7b/zuGJ60mh+3AORTe4fZq0mBKldd7dVw++08BGStRLS1QshGf+EnbdhqYJ5ZnC6cpn
         Lkmt81BIB8ax+WAMjXWXMCYxGjHZ6RlKe9EZ/ZrWBUZNbeFGrsN7zBmixvg7ZQ0b6ojn
         w0XnHlJ6tmpfgf0sVWDYAvv2V8d8LHSxFcPlb4CLeiPEPZpTE9chiGKn5p+lSTDxSDRX
         D5Wgj7quMyunmNdNNzPW2vRy/mE0GXX4sUOpxYOXO5ZAxOupgczHE4u5O4QaqjGK0pB9
         NbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvfdz5udoYz82rV5IF60wkSHWqYMMiaRlZ1jxaHcNl8=;
        b=UhLmD7BNdXZyydxxmjDE/vDi0HVDrpg61hYXSkB9214jesVtuwTEPMScLKaDubAiGW
         ZMAGmaXzvTghoTskxEI853E4h1DfcedOWwMj+y6Ok7yP73Deb9cs/nuVHVysrDeUj+4n
         5587FxFCw5RnMQVp2bTks3vtIZKE2WletwWZbW18+ztpnAHRwzjdTGz0g0PycTyXJyOB
         SGJH2CdK/s4Iinkr2pvokkDHYThuMm7fegMkiyQAe+ydl52hrNLYg8c5pdy+1wpupJ7Y
         tPHOnaYa1u+a1JhAO/MU5UEasBKnCCeqiSrzGUtVUBLyAg6LOYbpZPlAGzkW1KGltwZe
         rKig==
X-Gm-Message-State: APjAAAUPlL/Rx+d79equ7niFs14QdnDaiObDvWAH7jUHQeumGWJ39X+q
        C/KRDDMKWnlvj45pvPA2B8m6Sr6z
X-Google-Smtp-Source: APXvYqyAydU0GDvAjLvf7pXLtbLsOEH4iEst6lFRJS+pqD1M8CQzm5m7m/nzkhyAjsOLmRBoMraDWA==
X-Received: by 2002:a63:190c:: with SMTP id z12mr10313390pgl.1.1575759266370;
        Sat, 07 Dec 2019 14:54:26 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s22sm7407977pjr.5.2019.12.07.14.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Dec 2019 14:54:25 -0800 (PST)
Date:   Sat, 7 Dec 2019 14:54:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time: posix-stubs: provide compat itimer supoprt for
 alpha
Message-ID: <20191207225424.GA9476@roeck-us.net>
References: <20191207191043.656328-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207191043.656328-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 07, 2019 at 08:10:26PM +0100, Arnd Bergmann wrote:
> Using compat_sys_getitimer and compat_sys_setitimer on alpha
> causes a link failure in the Alpha tinyconfig and other configurations
> that turn off CONFIG_POSIX_TIMERS.
> 
> Use the same #ifdef check for the stub version as well.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 4c22ea2b9120 ("y2038: use compat_{get,set}_itimer on alpha")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  kernel/time/posix-stubs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
> index 67df65f887ac..20c65a7d4e3a 100644
> --- a/kernel/time/posix-stubs.c
> +++ b/kernel/time/posix-stubs.c
> @@ -151,6 +151,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
>  
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYS_NI(timer_create);
> +#endif
> +
> +#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
>  COMPAT_SYS_NI(getitimer);
>  COMPAT_SYS_NI(setitimer);
>  #endif
> -- 
> 2.20.0
> 
