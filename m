Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092FC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56F9208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FCl00sRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfFNJO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:14:27 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51513 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfFNJO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:14:26 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 71501d62
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jun 2019 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=DwB0m+ZKAlNI36vkOaVtsOJ7Lbw=; b=FCl00s
        RovZwBpL5wFf0ApsEYVnzuGnnvsEUSmMQsxLBIUSNlKGRguFcm1HQbPNEz4qJoqq
        YM63LIDfu3g4y1zRjDeZlm/VM4E6J5AVMFREnW7WC0lKD/dm4ajjdyiLtmnEEipr
        mElkkLlOazax6TFi0MLuXDPnZU3c5O62aMPW+AfjYfpwSjZJA4DwVS4/66FcN7dr
        kaiGMgHjuxgj5hZQ8FwsLATYy5qcqfNMEHj14xe0JHbAmAJY1d9ySLLG21uwc5+P
        ocDeLKm05/HtkOA+VkuVabrDFOtzU6bO7ScvFjmkRxB6+TSYO0WbS5iW/CphYvYE
        6eoeysT69WGTvTFA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e4c7ace (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jun 2019 08:41:55 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id s184so1432386oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 02:14:24 -0700 (PDT)
X-Gm-Message-State: APjAAAUS4Qlks0adeFcZWv9ukYAdk1i9CtZJIlaDay4tDwafRlsKXPNl
        wFNRUsQ7lOVlGnWbV9BXVnRx+22Cq3+0br9b5aM=
X-Google-Smtp-Source: APXvYqwr3bx7Z+kWv0UQCyRH9CX83lJaOFK37a0TlSG/R/SqEZIiSUHyE1yB0oYGXu8LbMm1TnVwImDUBwXeWRhRFao=
X-Received: by 2002:aca:3a0a:: with SMTP id h10mr1246888oia.52.1560503663539;
 Fri, 14 Jun 2019 02:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
 <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
 <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
 <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
 <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de>
 <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com> <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Jun 2019 11:14:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com>
Message-ID: <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
>         } while (read_seqcount_retry(&tk_core.seq, seq));
>
> -       return base;
> -
> +       return base + nsecs;

The rest of the file seems to use `ktime_add_ns(base, nsecs)`. I
realize, of course, that these days that macro is the same thing as
what you wrote, though.

I can confirm that this fixes it (see below), so you can add my
Tested-by if you want or care.

One thing I'm curious about is the performance comparison with various
ways of using jiffies directly:

ktime_mono_to_any(ns_to_ktime(jiffies64_to_nsecs(get_jiffies_64())),
TK_OFFS_BOOT)

Or really giving up on the locking:

ktime_to_ns(tk_core.timekeeper.offs_boot) + jiffies64_to_nsecs(get_jiffies_64())

Or keeping things in units of jiffies, though that incurs a div_u64:

nsecs_to_jiffies64(ktime_to_ns(tk_core.timekeeper.offs_boot)) + get_jiffies_64()

But since offs_boot is updated somewhat rarely, that div_u64 could be
precomputed each time offs_boot is updated, allowing hypothetically:

tk_core.timekeeper.offs_boot_jiffies + get_jiffies_64()

Which then could be remade into a wrapper such as:

get_jiffies_boot_64()

The speed is indeed an important factor to me in accessing this time
value. Are any of these remotely interesting to you in that light?
Maybe I'll send a patch for the latter.

Jason

8<-----------------

int __init mod_init(void)
{
  u64 j1 = 0, j2, k1 = 0, k2, c1 = 0, c2, l1 = 0, l2;
  for (;;) {
    j2 = jiffies64_to_nsecs(get_jiffies_64());
    k2 = ktime_to_ns(ktime_mono_to_any(ns_to_ktime(jiffies64_to_nsecs(get_jiffies_64())),
TK_OFFS_BOOT));
    c2 = ktime_get_coarse_boottime();
    l2 = local_clock();
    pr_err("%llu %llu %llu %llu\n", j2 - j1, k2 - k1, c2 - c1, l2 - l1);
    j1 = j2;
    k1 = k2;
    c1 = c2;
    l1 = l2;
    msleep(200);
  }
  return 0;
}

[    0.420861] wireguard: 17179569472000000 17179569472000000
312696682 420860781
[    0.628656] wireguard: 208000000 208000000 208000000 207791083
[    0.836591] wireguard: 208000000 208000000 208000000 207934734
[    1.044728] wireguard: 208000000 208000000 208000000 208137167
[    1.252593] wireguard: 208000000 208000000 208000000 207862974
[    1.460815] wireguard: 208000000 208000000 208000000 208223514
[    1.668667] wireguard: 208000000 208000000 208000000 207852437
[    1.876438] wireguard: 208000000 208000000 208000000 207773658
[    2.084627] wireguard: 208000000 208000000 208000000 208185643
[    2.292690] wireguard: 208000000 208000000 208000000 208063377
[    2.500672] wireguard: 208000000 208000000 208000000 207982209
[    2.708658] wireguard: 208000000 208000000 208000000 207986527
[    2.916686] wireguard: 208000000 208000000 208000000 208026945
[    3.124732] wireguard: 208000000 208000000 208000000 208046153
[    3.332684] wireguard: 208000000 208000000 208000000 207952302
[    3.540668] wireguard: 208000000 208000000 208000000 207978195
[    3.748633] wireguard: 208000000 208000000 208000000 207970981
[    3.956686] wireguard: 208000000 208000000 208000000 208053094
[    4.164690] wireguard: 208000000 208000000 208000000 207995376
[    4.372660] wireguard: 208000000 208000000 208000000 207978324
[    4.580787] wireguard: 208000000 208000000 208000000 208126491
[    4.788716] wireguard: 208000000 208000000 208000000 207930106
[    4.996685] wireguard: 208000000 208000000 208000000 207968555
[    5.204673] wireguard: 208000000 208000000 208000000 207988295
[    5.412676] wireguard: 208000000 208000000 208000000 207991396
[    5.620648] wireguard: 208000000 208000000 208000000 207983671
[    5.828822] wireguard: 208000000 208000000 208000000 208174230
[    6.036596] wireguard: 208000000 208000000 208000000 207773401
[    6.244615] wireguard: 208000000 208000000 208000000 208017986
[    6.452625] wireguard: 208000000 208000000 208000000 208011215
[    6.660678] wireguard: 208000000 208000000 208000000 208053134
[    6.868609] wireguard: 208000000 208000000 208000000 207929536
