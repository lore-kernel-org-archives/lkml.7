Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DEC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9122133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfFNLSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:18:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45591 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfFNLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:18:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id j19so1925922qtr.12;
        Fri, 14 Jun 2019 04:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8gOzj/0iaKEW/FuOeafI+Xij04aXDRYI8cWh89Rv7s=;
        b=tUWrBplWcnUjCM6XmMG0Qyd1x1O6Pe2yqfR1DVFgbDyejzJljH+t0+IGalITzqyEJx
         bY1uXF9alGFOwsabcGSidfvWmfX1Xnx0n6LcOIQF1Gtybj478AnDM/RjbGBeh37F6Kfr
         UOjChGDcJOfsvNDXprlzrmUkxyaMmY1Z47pdaak3lZj6fQfa0Tbxxn2LhQKC8G8eRXLe
         4tgOUj08kDTDGbxkDk9yPdXDK4Xma41SAFYmyD6ZwJHoN52D4fD62vCGeaGdjs65E/Gz
         JeDCgYmOYBZwiE2w2BDfg5dzPJ/f+5/sTOlVEXnvmg6wz3nsoqLruKfTGipMOPVayX9S
         m5qA==
X-Gm-Message-State: APjAAAXwfYWdM170nk3y4pxYByRVMi1sBzRvOYUXIL79MUBoEGNsytzx
        zEfY63T5tkfPhEH/ZdB9GPqUZGZ34qSKgpevfro=
X-Google-Smtp-Source: APXvYqxrEJym0N3dYI9kPadDKhabD1ieuT1hlgPR8Ypg/DjmrfRHfhrc8seXeOU0D1r1jgk6Ns+Mpo3R6kOLQGu6Qt0=
X-Received: by 2002:a0c:87bd:: with SMTP id 58mr7648651qvj.62.1560511111118;
 Fri, 14 Jun 2019 04:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de> <tip-e3ff9c3678b4d80e22d2557b68726174578eaf52@git.kernel.org>
In-Reply-To: <tip-e3ff9c3678b4d80e22d2557b68726174578eaf52@git.kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Jun 2019 13:18:14 +0200
Message-ID: <CAK8P3a0B2NSdVf+qOrg=ds7_mhJqBTCqznALQpNQuQ-fNDR+wg@mail.gmail.com>
Subject: Re: [tip:timers/urgent] timekeeping: Repair ktime_get_coarse*() granularity
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Clemens Ladisch <clemens@ladisch.de>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 11:55 AM tip-bot for Thomas Gleixner
<tipbot@zytor.com> wrote:
>
> Commit-ID:  e3ff9c3678b4d80e22d2557b68726174578eaf52
> Gitweb:     https://git.kernel.org/tip/e3ff9c3678b4d80e22d2557b68726174578eaf52
> Author:     Thomas Gleixner <tglx@linutronix.de>
> AuthorDate: Thu, 13 Jun 2019 21:40:45 +0200
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Fri, 14 Jun 2019 11:51:44 +0200
>
> timekeeping: Repair ktime_get_coarse*() granularity
>
> Jason reported that the coarse ktime based time getters advance only once
> per second and not once per tick as advertised.
>
> The code reads only the monotonic base time, which advances once per
> second. The nanoseconds are accumulated on every tick in xtime_nsec up to
> a second and the regular time getters take this nanoseconds offset into
> account, but the ktime_get_coarse*() implementation fails to do so.
>
> Add the accumulated xtime_nsec value to the monotonic base time to get the
> proper per tick advancing coarse tinme.

Acked-by: Arnd Bergmann <arnd@arndb.de> (too late, I know)

I checked what code is actually affected. Fortunately there are only
a very small number of callers that I could find:

arch/powerpc/xmon/xmon.c:        ktime_get_coarse_boottime_ts64(&uptime);
drivers/iio/industrialio-core.c:        return
ktime_to_ns(ktime_get_coarse_real());
drivers/power/supply/ab8500_fg.c:    time64_t now =
ktime_get_boottime_seconds();
drivers/net/wireless/intel/ipw2x00/ipw2100.c:    time64_t now =
ktime_get_boottime_seconds();

Only two of these even read the sub-second portion, and the
iio file only calls this function if CLOCK_REALTIME_COARSE
was passed from user space.

I don't think any harm was done so far by this bug, so it's not surprising
we never noticed.

         Arnd
