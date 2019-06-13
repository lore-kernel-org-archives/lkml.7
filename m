Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08372054F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JTnkx83H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbfFMPTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:19:16 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:47523 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbfFMPTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:19:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8dd8cd0f
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=IAVCCS320fW5nK70HtpClSnY8p0=; b=JTnkx8
        3HuaxMfKdmhnPo8lhGCCDKxes06nNtTr+O8Xi8husYwx6dSPgMMeZWqZM+b9BHoE
        L62nHqtQNxxwj0MZEXd6mHp+aDylO9cYUSjNNUvjHvOuI9yC5PMvQU7uZvmXPYST
        zDbecZ8823XLex/wsikSRnQ4l9ztvZvvTVaZ/nbmLAxMVZKoMyReX+6DLOSskOKe
        ckhB1RrqmT0aLwKSmZPARcr7bE5neTQjaC2AXntO9psISzuyJghn5vNMPvSWqQxY
        WWYMyrfrd1n8WKFX5tqt3WXd1E5geuArThVKXqzkeJkNgS9ixTwFSwJ9rnTM+MMx
        pr0FwOBU0NQy9C1A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4a92703c (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 14:46:40 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id r21so19336674otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:19:03 -0700 (PDT)
X-Gm-Message-State: APjAAAX1XVH9y0CgM8RUXBlz0/oosL/H/lRP/CCPUDg/o/0TVbdzxusJ
        d8XjNOdwAY5X73Buu4pYiK7zYn655vZyUIYm3po=
X-Google-Smtp-Source: APXvYqyWZVyM2WCmnNwS9pZTtS//ET5gOmZLwl9q3yeM7B4zTKNJEofcunCCvj/1+7DJO1irtvV+v5CcbduZDIRybWc=
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr25573348otn.243.1560439141927;
 Thu, 13 Jun 2019 08:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
In-Reply-To: <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Jun 2019 17:18:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
Message-ID: <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd, Peter,

On Wed, Jun 12, 2019 at 4:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Documentation/core-api/timekeeping.rst describes the timekeeping
> interfaces. I think what you want here is ktime_get_coarse_boottime().
>
> Note that "coarse" means "don't access the hardware clocksource"
> here, which is faster than "fast", but less accurate.
>
> This is updated as often as "jiffies_64", but is in nanosecond resolution
> and takes suspended time into account.

Oh, thanks. Indeed ktime_get_coarse_boottime seems even better. It's
perhaps a bit slower, in that it has that seqlock, but that might give
better synchronization between CPUs as well.

Peter - any immediate downside you can think of compared to local_clock()?

Jason
