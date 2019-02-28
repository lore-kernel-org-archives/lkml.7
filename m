Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2270C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7172F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfB1Iou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:44:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37925 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfB1Iou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:44:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id p15so11598356qkl.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 00:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5kwBGJvOewBDChV9seYnSkUiyXY2vxNNbNPiECI+j8=;
        b=AZWECewspEfeVOy25+r175XwMy69kgA+Le5HHibMyqW9Jczrkc9i4MFABzjlGGnr4j
         K+OnGmNVmYv2Pjoq6hoBCXViLU59o92KV/1EwWR3m7Cthwv+SbaSqI7z5m7UBi5IOlb5
         GiUoIB9MKtLRW+SXe3+10Ac4qbETkkykXPET2CE8poXMyIeJgluT6+FkBzAcQjd+wTf6
         2BQxIZwkAsSJASVumZmarajLMFr1iPkrZG9b0BVSoMcPIkpD5AfeOsD04iE/7C6H72H9
         hW9pxVWch9qTWahCsuviH3AnuxGDvZXHTvvIsZ+XKpy/xUQIf0hYhZK3P/BGI7Tiv/ZS
         jdBA==
X-Gm-Message-State: APjAAAUcCU3QCgSsdB5o4u9NxisRDr6W5BYg3VN843datlB6I8RU80Mp
        ANnxSSDgr8tW3VUe2stQ87+Xo5DEJRCac0OfdjU=
X-Google-Smtp-Source: AHgI3IaOLIQIPsQcXMqTw87W0qL5jq+ZdyZZm1b9ecRGbnmlLizhHIiR73P0Pw17dDouXF5E5BxAZQYpPZaKX9i8+rg=
X-Received: by 2002:a37:8dc5:: with SMTP id p188mr5465375qkd.330.1551343489403;
 Thu, 28 Feb 2019 00:44:49 -0800 (PST)
MIME-Version: 1.0
References: <1551253922-3307-1-git-send-email-wangxiongfeng2@huawei.com> <CABeXuvoJ3oKRp0z=CO_8kPhZ+-AHGwTaDBqzK2FuC_v5t6kU=A@mail.gmail.com>
In-Reply-To: <CABeXuvoJ3oKRp0z=CO_8kPhZ+-AHGwTaDBqzK2FuC_v5t6kU=A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Feb 2019 09:44:32 +0100
Message-ID: <CAK8P3a0ip8+UaqnjGsC8GVY8CSEtccB4uUB-b5Zk1nrVqcY0eQ@mail.gmail.com>
Subject: Re: [PATCH v2] posix-cpu-timers: Avoid undefined behaviour in timespec64_to_ns()
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 5:25 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 11:52 PM Xiongfeng Wang
> <wangxiongfeng2@huawei.com> wrote:
> >
> > +++ b/kernel/time/posix-timers.c
> > @@ -853,8 +853,8 @@ static int do_timer_settime(timer_t timer_id, int flags,
> >         unsigned long flag;
> >         int error = 0;
> >
> > -       if (!timespec64_valid(&new_spec64->it_interval) ||
> > -           !timespec64_valid(&new_spec64->it_value))
> > +       if (!timespec64_valid_strict(&new_spec64->it_interval) ||
> > +           !timespec64_valid_strict(&new_spec64->it_value))
> >                 return -EINVAL;
> >
> >         if (old_spec64)
>
> sys_timer_settime() is a POSIX interface:
> http://pubs.opengroup.org/onlinepubs/7908799/xsh/timer_settime.html
>
> The timer_settime() function will fail if:
>
> [EINVAL] The timerid argument does not correspond to an id returned by
> timer_create() but not yet deleted by timer_delete().
>
> [EINVAL] A value structure specified a nanosecond value less than zero
> or greater than or equal to 1000 million.
>
> So we cannot return EINVAL here if we want to maintain POSIX compatibility.
> Maybe we should check for limit and saturate here at the syscall interface?

I think returning EINVAL here is better than silently truncating, we
just need to
document it in the Linux man page.
Note that truncation would set the time to just before the overflow,
it bad things
start to happen the instant after it returns from the kernel. This is possibly
worse than setting a random value that may or may not crash the system.

      Arnd
