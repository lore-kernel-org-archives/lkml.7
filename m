Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24270C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D6F20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfCFKjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:39:11 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42339 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfCFKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:39:11 -0500
Received: by mail-qk1-f194.google.com with SMTP id y140so6477409qkb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 02:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH7x2NxCJ4HeJQoPWtgT6Cteu8ROwNt0tHf78QfanhI=;
        b=rZLG5wp/LIKLKgtNt9zsuTDpDq1Wi2sjQzDa6EJARsJhoqgi2uyTrH/6x2cmUj45Lj
         CCJcfnbcEIlvirAk6qGywJHf0f0v1wpxJRCVqAzmGIJ/7W+LGWEAxmqzPmrulk3+ZMLx
         n8Ds1nFPC/vcVBap1ek/64F27j5rZBY0rR7eErd8dlAavWGkLy5TWedoR/hk0srUKMI8
         8P9Vmc3ou8nboffaOR3/6nV4NYtH4A4Z57ptajI5Zva6TjyDVE2BfUSNqQ7rUK5CF60T
         70OZvtRti2qH9yjje/L2GCCdjEkfDlA32nRUXa2XG/PwKcEvAqVl7KLaUpt003uxouo2
         DzgA==
X-Gm-Message-State: APjAAAWVNl5oVHG+NFjcEJ9auYVF0zqeiv3nGefvhdENBupAoWIxiVBc
        osHOsQyR26bbM/6V5wLp7SFTzDIvicG4XN4fMuU=
X-Google-Smtp-Source: APXvYqyxpxfCR7cJqWhwx1VHHf9FNvlTMtJYhaHZ2ksKZXc+0Q9booHL901MB6SUGvOOELuLORIABNVfrbmdZJJVUs4=
X-Received: by 2002:a37:8dc5:: with SMTP id p188mr5013978qkd.330.1551868750032;
 Wed, 06 Mar 2019 02:39:10 -0800 (PST)
MIME-Version: 1.0
References: <1551861646-52541-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1551861646-52541-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 11:38:53 +0100
Message-ID: <CAK8P3a2VicE7e8pU8UD9UwEmr_wb9GdxKWdE64mKGkvU4Ac37A@mail.gmail.com>
Subject: Re: [PATCH v3] posix-cpu-timers: Avoid undefined behaviour in timespec64_to_ns()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:41 AM Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 0e84bb7..4b57566 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -856,6 +856,10 @@ static int do_timer_settime(timer_t timer_id, int flags,
>         if (!timespec64_valid(&new_spec64->it_interval) ||
>             !timespec64_valid(&new_spec64->it_value))
>                 return -EINVAL;
> +       if (new_spec64->it_interval.tv_sec > KTIME_SEC_MAX)
> +               new_spec64->it_interval.tv_sec = KTIME_SEC_MAX;
> +       if (new_spec64->it_value.tv_sec > KTIME_SEC_MAX)
> +               new_spec64->it_value.tv_sec = KTIME_SEC_MAX;
>

I looked at the calculation we do later, and I think this can still overflow
if tv_nsec is too large. The largest timespec value we can support is

(struct timespec64) { .tv_sec = 9223372036, .tv_nsec = 854775807 }

Your patch caps the tv_sec value to 9223372036, but it does not
cap the tv_nsec. The easiest fix would be to always set tv_nsec
to 0 if tv_sec>=9223372036, or a more correct calculation would
have to limit tv_nsec if tv_sec==9223372036. I don't know if that
matters or not (it should not, unless we explicitly compare the
ktime_t for equality with KTIME_MAX later).

     Arnd
