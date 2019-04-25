Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A297C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1086F214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjhdE96R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDYIZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:25:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36439 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDYIZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:25:11 -0400
Received: by mail-io1-f68.google.com with SMTP id d19so14041186ioc.3;
        Thu, 25 Apr 2019 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ovx2woEvzuPd15BMR5ZVRc4UhyNcm+gqYTFhjJrx21I=;
        b=UjhdE96RPkyX082Em3CO9z3D+ynirdp40TXh8OFHAfxguy0ciJBCGiQA5ZrB1aI6Tb
         Xfz+rGk04jAIggJEFbvPDO+FJHGZrKiw8VB1AcrbeOgNxzz977uJIzRHfQCY4O5Y+f7L
         +ko5lRWj2I5uMuPN84KsNYsdlDU0VfEzfj3A46Re/Uis9tlp29xamVHrFwNHGm8h4rPz
         K/dWJolphYgV8fP5zopCf4rWEX6RcQAZU6e5EB++gdoEBWZKWVtgYc7Ofu7Hh1S33wws
         FAQHGwsepepikBp+pmk7ru01GBDuvgce8OB7wENNMUr07x9BRZrAAGATZqzGmo4HoyXd
         WEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ovx2woEvzuPd15BMR5ZVRc4UhyNcm+gqYTFhjJrx21I=;
        b=dUYSh1k1f0YA1/cFzrKjAEn+Pm6Ob15qUoOq7JyGKM6/etnlLRpnEItUEjcO3fmqK3
         l0mpvH8B0pUSERRKA98/yz+kKw9yrzRnkqm8lVI6tb7lbOX0384K8cBsm0tv8Khwwb0v
         7uEAtMrxNyIZm3i/WJ6FtE/pQ1iKROYrpT5d+4jC7W0fNkm3A9f26zN7H6iwWyTzhRZI
         gFPafQmVOOfr2Xl4wjo22CdHHmjRza96gG/43s6sqK3ymOv3x+7BPWqD7arkVcHtreWn
         F1kXxPekyNpLyrdc2vZAciFmk7cE0UxrOiRhZb8d4i+Ex5tBH3DVp23RX8fGZu7/CatH
         bWCg==
X-Gm-Message-State: APjAAAVVELNDNa0J8XlfvmMt54Kz8HoIrfIL2a5d6GOcv/a5ajQFoW2e
        8Mak+r++UOy6MnilL5ii2xYS2x24oyBMm8KJO5w=
X-Google-Smtp-Source: APXvYqxGvoLRsuH0Gaodr6+vbXxu7WzkvPMRcWsFDbF/Lt2fw7UTwjvsEmVFBT7wBB/oK34MdqLuzVwur0NkWg1BwTA=
X-Received: by 2002:a6b:ed0c:: with SMTP id n12mr3850165iog.259.1556180709831;
 Thu, 25 Apr 2019 01:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
 <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
 <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
 <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com> <CAO-hwJJkyK_qPEL37QLd3kLuwB2rFBk+5FWg1UCfgr-FzxZ5aw@mail.gmail.com>
In-Reply-To: <CAO-hwJJkyK_qPEL37QLd3kLuwB2rFBk+5FWg1UCfgr-FzxZ5aw@mail.gmail.com>
From:   =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date:   Thu, 25 Apr 2019 10:24:58 +0200
Message-ID: <CAM4jgCrLRxOx-qtq8Wfbc1xmYkNHG9vsRSk_BBK5OPgkLyVYnQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on
 Logitech mice
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 25 avr. 2019 =C3=A0 09:40, Benjamin Tissoires
<benjamin.tissoires@redhat.com> a =C3=A9crit :
>
> Hi Cl=C3=A9ment,
>
> On Wed, Apr 24, 2019 at 5:34 PM Cl=C3=A9ment VUCHENER
> <clement.vuchener@gmail.com> wrote:
> >
> > Hi Benjamin,
> >
> > I tried again to add hi-res wheel support for the G500 with Hans de
> > Goede's latest patch series you've just merged in for-5.2/logitech, it
> > is much better but there is still some issues.
> >
> > The first one is the device index, I need to use device index 0
> > instead 0xff. I added a quick and dirty quirk (stealing in the
> > QUIRK_CLASS range since the normal quirk range looks full) to change
> > the device index assigned in __hidpp_send_report. After that the
> > device is correctly initialized and the wheel multiplier is set.
>
> Hmm, maybe we should restrain a little bit the reserved quirks...
> But actually, .driver_data and .quirks are both unsigned long, so you
> should be able to use the 64 bits.

Only on 64 bits architectures, or is the kernel forcing long integers
to be 64 bits everywhere?

>
> >
> > The second issue is that wheel values are not actually scaled
> > according to the multiplier. I get 7/8 full scroll event for each
> > wheel step. I think it happens because the mouse is split in two
> > devices. The first device has the wheel events, and the second device
> > has the HID++ reports. The wheel multiplier is only set on the second
> > device (where the hi-res mode is enabled) and does not affect the
> > wheel events from the first one.
>
> I would think this have to do with the device not accepting the
> command instead. Can you share some raw logs of the events (ideally
> with hid-recorder from
> https://gitlab.freedesktop.org/libevdev/hid-tools)?

I already checked with usbmon and double-checked by querying the
register. The flag is set and accepted by the device and it behaves
accordingly: it sends about 8 wheel events per step.

hid-recorder takes hidraw nodes as parameters, how do I use it to
record the initialization by the driver?

>
> Cheers,
> Benjamin
>
> >
> > Le mer. 19 d=C3=A9c. 2018 =C3=A0 21:35, Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> a =C3=A9crit :
> > >
> > > On Wed, Dec 19, 2018 at 11:57 AM Cl=C3=A9ment VUCHENER
> > > <clement.vuchener@gmail.com> wrote:
> > > >
> > > > Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHENER
> > > > <clement.vuchener@gmail.com> a =C3=A9crit :
> > > > >
> > > > > Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcutts@chrom=
ium.org> a =C3=A9crit :
> > > > > >
> > > > > > Hi Clement,
> > > > > >
> > > > > > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > > > > > <clement.vuchener@gmail.com> wrote:
> > > > > > > Hi, The G500s (and the G500 too, I think) does support the "s=
crolling
> > > > > > > acceleration" bit. If I set it, I get around 8 events for eac=
h wheel
> > > > > > > "click", this is what this driver expects, right? If I unders=
tood
> > > > > > > correctly, I should try this patch with the
> > > > > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > > > > >
> > > > > > Thanks for the info! Yes, that should work.
> > > > >
> > > > > Well, it is not that simple. I get "Device not connected" errors =
for
> > > > > both interfaces of the mouse.
> > > >
> > > > I suspect the device is not responding because the hid device is no=
t
> > > > started. When is hid_hw_start supposed to be called? It is called
> > > > early for HID_QUIRK_CLASS_G920 but later for other device. So the
> > > > device is not started when hidpp_is_connected is called. Is this
> > > > because most of the device in this driver are not real HID devices =
but
> > > > DJ devices? How should non-DJ devices be treated?
> > >
> > > Hi Clement,
> > >
> > > I have a series I sent last September that allows to support non DJ
> > > devices on logitech-hidpp
> > > (https://patchwork.kernel.org/project/linux-input/list/?series=3D1635=
9).
> > >
> > > In its current form, with the latest upstream kernel, the series will
> > > oops during the .event() callback, which is easy enough to fix.
> > > However, I am currently trying to make it better as a second or third
> > > reading made me realized that there was a bunch of non-sense in it an=
d
> > > a proper support would require slightly more work for the non unifyin=
g
> > > receiver case.
> > >
> > > I hope I'll be able to send out something by the end of the week.
> > >
> > > Cheers,
> > > Benjamin
