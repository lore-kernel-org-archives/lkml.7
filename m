Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20C0214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfDYHka convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:40:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37892 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfDYHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:40:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so23356963qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1yolvFw/SUs+tH7rUzcdF9KefyG3PS9LXfWTPlo2Nik=;
        b=mubzm+WF4QecRvMyaItsUbdJG+rj8LjMfragoUFhqc9XGnWqrrxHxmNZYODG56zCU+
         P2wviPimzPq3OeLXGRndCwfeWYeh3xC0fZ8bFrxhuLUvYjDaFysgBm9P3YrkAWdddV7B
         qQCFI1YLLQ1Rk4o8AxyJ98dWWS6HyY3ggSAX8uPYHQIPcOPXeng87AWJSzzF2ZLG319/
         9oriU9AR1FANu60/bz+qQmEcrgv+cxMIZ9L/3bNZFvKHyuzKXqwuKF8aMgAganL2w+oC
         N1/S8oLcaqv9e9aRMGRH3kuRrKrcbu164jv/w8fPGFwaI8myc2rlTqisou4Lrmie33SF
         76UA==
X-Gm-Message-State: APjAAAVb7zdX+D+kTCtZMFEtCHIQt4EGIEPtadGN1bMfP/U1HNZHAOdf
        iimyN5vXUdoMlgAUkqVW+OCJLAj4Pegp2n5NfIaDKQ==
X-Google-Smtp-Source: APXvYqwT/zphsqcV1CHNT8gZS0nwgmWzN6e1bzzvCNdQfYJW/vDXIkn5Cd/AeMBERhrcgTFEgHGvEZULGkIlgM+bQxs=
X-Received: by 2002:a0c:9810:: with SMTP id c16mr29956112qvd.192.1556178029302;
 Thu, 25 Apr 2019 00:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
 <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
 <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com> <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com>
In-Reply-To: <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 25 Apr 2019 09:40:17 +0200
Message-ID: <CAO-hwJJkyK_qPEL37QLd3kLuwB2rFBk+5FWg1UCfgr-FzxZ5aw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc:     Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Wed, Apr 24, 2019 at 5:34 PM Clément VUCHENER
<clement.vuchener@gmail.com> wrote:
>
> Hi Benjamin,
>
> I tried again to add hi-res wheel support for the G500 with Hans de
> Goede's latest patch series you've just merged in for-5.2/logitech, it
> is much better but there is still some issues.
>
> The first one is the device index, I need to use device index 0
> instead 0xff. I added a quick and dirty quirk (stealing in the
> QUIRK_CLASS range since the normal quirk range looks full) to change
> the device index assigned in __hidpp_send_report. After that the
> device is correctly initialized and the wheel multiplier is set.

Hmm, maybe we should restrain a little bit the reserved quirks...
But actually, .driver_data and .quirks are both unsigned long, so you
should be able to use the 64 bits.

>
> The second issue is that wheel values are not actually scaled
> according to the multiplier. I get 7/8 full scroll event for each
> wheel step. I think it happens because the mouse is split in two
> devices. The first device has the wheel events, and the second device
> has the HID++ reports. The wheel multiplier is only set on the second
> device (where the hi-res mode is enabled) and does not affect the
> wheel events from the first one.

I would think this have to do with the device not accepting the
command instead. Can you share some raw logs of the events (ideally
with hid-recorder from
https://gitlab.freedesktop.org/libevdev/hid-tools)?

Cheers,
Benjamin

>
> Le mer. 19 déc. 2018 à 21:35, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> a écrit :
> >
> > On Wed, Dec 19, 2018 at 11:57 AM Clément VUCHENER
> > <clement.vuchener@gmail.com> wrote:
> > >
> > > Le sam. 15 déc. 2018 à 15:45, Clément VUCHENER
> > > <clement.vuchener@gmail.com> a écrit :
> > > >
> > > > Le ven. 14 déc. 2018 à 19:37, Harry Cutts <hcutts@chromium.org> a écrit :
> > > > >
> > > > > Hi Clement,
> > > > >
> > > > > On Fri, 14 Dec 2018 at 05:47, Clément VUCHENER
> > > > > <clement.vuchener@gmail.com> wrote:
> > > > > > Hi, The G500s (and the G500 too, I think) does support the "scrolling
> > > > > > acceleration" bit. If I set it, I get around 8 events for each wheel
> > > > > > "click", this is what this driver expects, right? If I understood
> > > > > > correctly, I should try this patch with the
> > > > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > > > >
> > > > > Thanks for the info! Yes, that should work.
> > > >
> > > > Well, it is not that simple. I get "Device not connected" errors for
> > > > both interfaces of the mouse.
> > >
> > > I suspect the device is not responding because the hid device is not
> > > started. When is hid_hw_start supposed to be called? It is called
> > > early for HID_QUIRK_CLASS_G920 but later for other device. So the
> > > device is not started when hidpp_is_connected is called. Is this
> > > because most of the device in this driver are not real HID devices but
> > > DJ devices? How should non-DJ devices be treated?
> >
> > Hi Clement,
> >
> > I have a series I sent last September that allows to support non DJ
> > devices on logitech-hidpp
> > (https://patchwork.kernel.org/project/linux-input/list/?series=16359).
> >
> > In its current form, with the latest upstream kernel, the series will
> > oops during the .event() callback, which is easy enough to fix.
> > However, I am currently trying to make it better as a second or third
> > reading made me realized that there was a bunch of non-sense in it and
> > a proper support would require slightly more work for the non unifying
> > receiver case.
> >
> > I hope I'll be able to send out something by the end of the week.
> >
> > Cheers,
> > Benjamin
