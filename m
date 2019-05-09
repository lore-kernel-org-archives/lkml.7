Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF64C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A67217D6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntoALUF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfEIVX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:23:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40895 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfEIVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:23:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so4855243wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CR9C9z5AdFq92j3t78GsabgrWeXl10dvuT3JtPOaD1A=;
        b=ntoALUF/JU3ofU0TKIgWzSKb9pRV9bI8FWErlamPKlSm0SQ6RANs6nELfUnpyo+NEP
         UXG2Lp+1PyrZvrTLSrUwkosUXKh1sjT/utTSeMfdNZsVIPxzB3KiLC0PlQIz0kg4SZZ0
         psG61f7nG8pSWv59IY6sh35d0gl3WkSIBbROPfL1pMeqctf/EGhvs1ELqqPR7vMXT6+3
         y/ZEID3goR73Vg1ouVMu7BqPbUe8vT1cGu/CMOnSFY6GEFvJVzcHQYRxYiZ1DkDmpQaK
         mIe6gFHtIWZVlfUsbhXt/vTWhzOzKKpdjWjjhfN3JDlvUSRDkeO2cisdRxvsm7KJ+CpS
         ClPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CR9C9z5AdFq92j3t78GsabgrWeXl10dvuT3JtPOaD1A=;
        b=T40Zo9K2ASdH1iG0LKDMDPJvd48M5UpnB3QqFuRi8nCTPquFipI24fPCa72B1ghP/2
         xDXqp3AeWcgLOqFDQmU+d/mWgIHt6dIZLfrQFoAAb3dgswGfzW2xDZyYjNM47soLPkKD
         CeaKzu2OPKKubr3PEZbS790k+cCPleBT5nQi4bHoQergJZyJkJk5mJW7+FhZGcKPlBCU
         9wnwk57Km1zvrG5KldceqTVJq37Qn4X08l7mNOvxKh5UPFjZ2zn4KmcPa6zh/4O6VQqK
         TsOBkaGwaNVzqBvXWrzBBrihnj4CAV+vR4NLfAY2rHBIA4wTCtBJRt6qmHyO3N8Np7th
         pHTw==
X-Gm-Message-State: APjAAAXoN+27IExo47MZ63iTP2oQXNTPfFpoQO7+IccwvtiPT8LecWUm
        JDY6WMVPwj5Mn7/mbyViNfZYHvQnqBL16d/EDfxL1hhLuVU=
X-Google-Smtp-Source: APXvYqw4zUtQN7ytmBorNIoFIXqLjxW5iogMUT4wSwWIQ7ocfG1Y5VWjXe7SF2mrLHXGt+qNjG/aBtYSARjyzYXsikc=
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr4642556wmi.9.1557437036779;
 Thu, 09 May 2019 14:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com> <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
In-Reply-To: <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 9 May 2019 14:23:44 -0700
Message-ID: <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     Felipe Balbi <balbi@kernel.org>, "Yang, Fei" <fei.yang@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 11:25 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, May 9, 2019 at 7:02 AM Andrzej Pietrasiewicz
> <andrzej.p@collabora.com> wrote:
> >
> > Hi John,
> > W dniu 08.05.2019 o 04:18, John Stultz pisze:
> > > Since commit 772a7a724f69 ("usb: gadget: f_fs: Allow scatter-gather
> > > buffers"), I've been seeing trouble with adb transfers in Android on
> > > HiKey960, HiKey and now Dragonboard 845c.
> > >
> > > Sometimes things crash, but often the transfers just stop w/o any
> > > obvious error messages.
> > >
> > > Initially I thought it was an issue with the HiKey960 dwc3 usb patches
> > > being upstreamed, and was using the following hack workaround:
> > >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey960-5.1&id=dcdadaaec9db7a7b78ea9b838dd1453359a2f388
> > >
> > > Then dwc2 added sg support, and I ended up having to revert it to get
> > > by on HiKey:
> > >    https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/hikey-5.1&id=6e91b4c7bd1e94bdd835263403c53e85a677b848
> > >
> > > (See thread here: https://lkml.org/lkml/2019/3/8/765)
> >
> > So the thread says there are problems at boot, but here you mention about
> > adb transfers, which must obviously be happening after the board has booted.
> > Do you experience problems at boot or not?
> >
> > If a crash happens, what is in the log?
>
> So, yes.  Sorry, I am maybe muddling two issues (though they both seem
> to be tied to f_fs sg).  On dwc2, with the current code, we often (but
> not always) crash as soon as adb starts up in the boot process. Thus
> I'm running with a revert of "usb: dwc2: gadget: Add scatter-gather
> mode" to get by.
>
> As for example crashes, there is a crash in the thread linked above
> (https://lkml.org/lkml/2019/3/8/765) and also the one I sent yesterday
> when testing with your zlp patch. Let me know if you're looking for
> something more specific.
>
> One thing I didn't do, but I should is run w/ the zlp + your
> memset/kzalloc patch. See if that helps get dwc2 further along at
> least.  I'll test that shortly here and get back to you.

Ok. Apologies for earlier confusion.

So the kzalloc/memset fix you sent for f_fs.c does seem to avoid the
crash on bootup I was seeing w/  HiKey/dwc2 (previously I had only
tested it on HiKey960/dwc3).

However with that patch, I still see tranfer problems with adb, unless
I comment out setting sg_supported in dwc2/gadget.c (in the same
fashion I have to with HiKey960/dwc3).

The dwc2 zlp patch doesn't seem to affect things much either way in my
testing. But maybe I'm just not tripping on that issue yet.

So yes, the kzalloc/memset patch is a clear improvement, as it avoids
the bootup crash on dwc2, and seems like it should go in.

However, there is still the outstanding issue w/  functionfs sg
support stalling on larger transfers.

thanks
-john
