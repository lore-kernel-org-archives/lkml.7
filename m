Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05972C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 01:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E506E2077B
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 01:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ7XLlPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLNBiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 20:38:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34210 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfLNBiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 20:38:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so704820ljc.1;
        Fri, 13 Dec 2019 17:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/RAkFi6F4plFq+4FJ5FybixLxDkxXsHOnC0hMslJ0I=;
        b=GJ7XLlPchLiZoHNy58cony05pWue++ZdwsgetvvcxZLRhiuBZxltwBEowy/Z6R6oUk
         1uPpttPfg+mDoHbssJ/9j6X3uGcgTcAeUFk+WlFJ3SG8xEoknTey/BFICdKgbw1/0gmS
         aGsATQVDIo48ta0KJA8U9Ro9qVtXsY3tiLzL7/fVNZP7z2xe7B0dHGiXMNbrkjI06wGR
         Hmhk/sYYBzvVPO7jg3ogSvE3JTbGON3KqrkT/+hzq/QmdhGPd4ob9/t8T50HTXfTtdbo
         fkSsFAZHqlIwEeM1QHarDRPVvE7aX16QdBkIpnk1hvRGinAybHiumTemjT8yAse/DWgY
         7d0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/RAkFi6F4plFq+4FJ5FybixLxDkxXsHOnC0hMslJ0I=;
        b=XE8f84YRRlvQl0Ch+dbZWZVywxhJXBTKdcRpL+mrOOkcgsnCBcj1l9lcJJvIH3iLyW
         B5JwnO92J883P3FbPqfS7VNncK6vydBri0Nhd46mlnKt1JAezUFg62dLIPv2+IWykWks
         ESnYanUNd9ZZO2pvnwd0yFFNxa7k6WSHAzFYiBIvs0PNv9koMdAhtry08kwlBXjImof7
         vPg29SpmZYs071lNC9vwW3/3FxMCcwK6RMLqnvxu5QjgRZyAwYxyLgT0/8rG3LvjgG4N
         pYzLRAdfwMnFFJSY4RHoFJ0uDXKqrJAyTv26ZMj6S4YejQfDCjOSYyygG9FJsuPmEmxq
         m0bQ==
X-Gm-Message-State: APjAAAVH5svuJCHAX+2JIuondij503C2RKK8nfTes3RCA4+hyjN9aQCj
        UqWAe0WgtM9vuKMlEODok0M73cY6ovpUVG8L6mwp9z5J
X-Google-Smtp-Source: APXvYqwlPU13OUpguQIogzSIDZIM2JTdtVFfIdDJGtvg2VzMkk3HwNCTfZcE/eVyPnQ0uDjVJXc4Q0YpwqZTy3EmyAc=
X-Received: by 2002:a2e:2c0a:: with SMTP id s10mr11099051ljs.193.1576287482570;
 Fri, 13 Dec 2019 17:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20191213204936.3643476-1-arnd@arndb.de> <20191213205417.3871055-15-arnd@arndb.de>
In-Reply-To: <20191213205417.3871055-15-arnd@arndb.de>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sat, 14 Dec 2019 12:37:51 +1100
Message-ID: <CAGRGNgVCkyterFgOFL-WtHr4=tSnyr2TsYs5BQk+7FdtHjv4ow@mail.gmail.com>
Subject: Re: [PATCH v2 24/24] y2038: sparc: remove use of struct timex
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sat, Dec 14, 2019 at 7:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 'struct timex' is one of the last users of 'struct timeval' and is
> only referenced in one place in the kernel any more, to convert the
> user space timex into the kernel-internal version on sparc64, with a
> different tv_usec member type.
>
> As a preparation for hiding the time_t definition and everything
> using that in the kernel, change the implementation once more
> to only convert the timeval member, and then enclose the
> struct definition in an #ifdef.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sparc/kernel/sys_sparc_64.c | 29 +++++++++++++++--------------
>  include/uapi/linux/timex.h       |  2 ++
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
> index 9f41a6f5a032..1c85b0af4dfd 100644
> --- a/arch/sparc/kernel/sys_sparc_64.c
> +++ b/arch/sparc/kernel/sys_sparc_64.c
> @@ -548,34 +548,35 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
>         return err;
>  }
>
> -SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
> +SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
>  {
> -       struct timex txc;               /* Local copy of parameter */
> -       struct __kernel_timex *kt = (void *)&txc;
> +       struct __kernel_timex txc;
> +       __kernel_old_timeval *tv = (void *)&txc->time;
>         int ret;
>
>         /* Copy the user data space into the kernel copy
>          * structure. But bear in mind that the structures
>          * may change
>          */
> -       if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
> +       if (copy_from_user(&txc, txc_p, sizeof(txc)))
>                 return -EFAULT;
>
>         /*
>          * override for sparc64 specific timeval type: tv_usec
>          * is 32 bit wide instead of 64-bit in __kernel_timex
>          */
> -       kt->time.tv_usec = txc.time.tv_usec;
> +       kt->time.tv_usec = tv->tv_usec;

Am I mis-reading the patch, or is "kt" not defined?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
