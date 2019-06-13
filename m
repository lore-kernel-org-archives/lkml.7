Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E5DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296ED20644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bCpFEBnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfFMQSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:18:08 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53807 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731118AbfFMQSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:18:06 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 0c2c6c51
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZtKcLIe9xSGOyWd+OOk7fGBXeNU=; b=bCpFEB
        nrXKDiy8HwyxBJCTvQgIfnU+sHwPPWr1dWmCcU+JVdlZgjAyQucuQnBupJchfC4O
        PeSRwHd4VkzQNhPKdTxX+dlCqyK+wT2+2x6ZqoZw1fu4fLYbiy3xSz76RAjPTlQ/
        UPS8DCBMOEjbFLU84FSYgonE1/IoE+oLCuhktuOrTmOgbho517TMbh5GhZN2k4MB
        VFEQ+dJgPf8KIPlgSoRj3KpVCAY68yoqIOgBg9M2ZTFrQuOWequ2rXUpGMG7uHPB
        GPIhgK10bOUMoBjOJomWe3D0Kf+zJ11/SEEFz5FKWxoQ3L3S0Wx/bQHgI14CEM81
        kdHyfMic7IZKGdig==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c2ec9c6f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jun 2019 15:45:40 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id r6so15235805oti.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 09:18:04 -0700 (PDT)
X-Gm-Message-State: APjAAAWtEtugNpB9WyfKNcfG3Pfqs3ggL97C0/6hS3cukTqdwDua/kAB
        cuH/LmjwDRhiSDpCBwqGZ7I7Thwcs9TcrIRN1/4=
X-Google-Smtp-Source: APXvYqwUgln7TE6c+9UQAQp4xqQDgMD0g+/7+3FdAzVlYUyYUygDyqZxn5HHn1NcJhw91s6BCv8fynZ7MX3taRPvWIs=
X-Received: by 2002:a9d:7a82:: with SMTP id l2mr8403770otn.120.1560442683162;
 Thu, 13 Jun 2019 09:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
 <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com> <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
In-Reply-To: <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Jun 2019 18:17:50 +0200
X-Gmail-Original-Message-ID: <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
Message-ID: <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
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

Hey Arnd,

On Thu, Jun 13, 2019 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> A seqlock is a very cheap synchronization primitive, I would actually
> guess that this is faster than most implementations of sched_clock()
> that access a hardware register for reading the time.

It appears to me that ktime_get_coarse_boottime() has a granularity of
a whole second, which is a lot worse than jiffies. Looking at the
source, you assign base but don't then add ns like the other
functions. At first I thought this was an intentional quirk to avoid
hitting the slow hardware paths. But noticing this poor granularity
now and observing that there's actually a blank line (\n\n) where the
nanosecond addition normally would be, I wonder if something was lost
in cut-and-paste?

I'm still poking around trying to see what's up. As a quick test,
running this on every packet during a high speed test shows the left
incrementing many times per second, whereas the right increments once
per second:

static int x = 0;
if (!(x++ % 30000))
     pr_err("%llu %llu\n", local_clock(), ktime_get_coarse_boottime());

Jason
