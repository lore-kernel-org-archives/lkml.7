Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1772E20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfB1Lbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:31:33 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45878 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfB1Lbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:31:32 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so22949427qtg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 03:31:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUmAzlYItQXjPtNNrpRGAfU8/QYiBC57p5S99Cf7ZHw=;
        b=pobWGdU0WiCeXp0TEl+nd8U3SMa+NV2iIXUZBXSZ3pa+H5X7iHPU5+Dn5nCbizjvZ+
         d0vNPed0XKG099Jp+Zmw5AnLFWSayDvUAKDdiPXxbsZHy1I9ErbNA2vVw42wHrymrxqJ
         MwJTs7Vy34KkeP2NhMi8ga064aJQ9QWniZ+Z/PaIIPLeZ8DJtNooNX3tkeBGCl+JWQHP
         9B+b/ssGl/848wRUkzwOAbOI/U/kNASoECaZme6pMgSv2LWNzXf/s5LVfeks+EuVgsmP
         raO8htKXPRt+YINHc3v9VxYJPbD+T26iHv+tfKHGgl6OhMmfj0hseTMsGUPbiRG4lxQ4
         moMQ==
X-Gm-Message-State: APjAAAV3beP4kuVAeNJOHhYuAen2XiINFHathTgmrDnu8WGBx9Dsy+iZ
        ODSN3ZskF9Jn3ucU94t5Db35oqmBy1WH8EpHOOs=
X-Google-Smtp-Source: APXvYqwUOU7pnW1FEF840fVRyyLZUShsK441/GOJ1O7j/BFyWm6WYbwREF4LCzy8zikAWj+nqtblKfp3M4Pz3YPahFo=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr5883929qve.149.1551353491785;
 Thu, 28 Feb 2019 03:31:31 -0800 (PST)
MIME-Version: 1.0
References: <1551253922-3307-1-git-send-email-wangxiongfeng2@huawei.com>
 <CABeXuvoJ3oKRp0z=CO_8kPhZ+-AHGwTaDBqzK2FuC_v5t6kU=A@mail.gmail.com>
 <CAK8P3a0ip8+UaqnjGsC8GVY8CSEtccB4uUB-b5Zk1nrVqcY0eQ@mail.gmail.com> <alpine.DEB.2.21.1902281123550.1821@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902281123550.1821@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Feb 2019 12:31:14 +0100
Message-ID: <CAK8P3a3BkQaE_abWsE_gVszhnLsgzT7xvt5LdvbuZDUzh2w_-Q@mail.gmail.com>
Subject: Re: [PATCH v2] posix-cpu-timers: Avoid undefined behaviour in timespec64_to_ns()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 28 Feb 2019, Arnd Bergmann wrote:
> > On Thu, Feb 28, 2019 at 5:25 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > On Tue, Feb 26, 2019 at 11:52 PM Xiongfeng Wang
> > > <wangxiongfeng2@huawei.com> wrote:
> > I think returning EINVAL here is better than silently truncating, we
> > just need to
> > document it in the Linux man page.
> > Note that truncation would set the time to just before the overflow,
> > it bad things
> > start to happen the instant after it returns from the kernel. This is possibly
> > worse than setting a random value that may or may not crash the system.
>
> Not necessarily. On the hrtimer based side, we clamp the values to
> KTIME_MAX. That means in theory the overflow could happen when the timer
> expires and the interval is added. There are two things which prevent that:
>
> 1) The timer expires in about 292 years from now, which I really can't be
>    worried about
>
> 2) The rearming code prevents the overflow into undefined space as well.
>
> So, it's not unreasonable to do clamping as long as the handed in value is
> at least formally correct.
>
> Of course we need to look at the posix-cpu-timer side of affairs to ensure
> that the limits are handled correctly.

Ah right. I had misread timer_settime() for clock_settime(), which
would have a problem if it were lacking the timespec64_valid_strict()
check that it has.

However, I see that the man page for clock_settime() fails
to mention the EINVAL return code, so I suppose we should
add that. I still plan to update the man pages to mention
the time64 versions, and can do that at the same time.

      Arnd
