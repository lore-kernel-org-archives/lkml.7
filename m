Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE72C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37B720640
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSjFsIys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfDYMfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:35:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33950 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYMf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:35:29 -0400
Received: by mail-it1-f193.google.com with SMTP id z17so1956895itc.1;
        Thu, 25 Apr 2019 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fOcYQHum18NNlljzaO1YwxdCM3i4CjuyZIdAXwLufoE=;
        b=aSjFsIys2J5esEsyzc79k1dG5qnmG8A2lXMTcUqO1ohPptp/oCwqsJ9e7kg8/fDxi3
         G/cLc9kGuFe4DwW7ntilekfTLvZ1KVavvvXqYdJTouOgMianjrSn7as6fkJgnhG4aUGg
         Pt/+IFTpb61/emS3jyVYl93lC0qymTl6Okf5W0xGcC7VOK/iX/nmnKdFt8+Saf+fAZZ3
         8R4T18hXWftlNb1XYERXsx5398G5xmzTdqDl9gj7uisqQfhJWuAXFVK+y3o67dIv4uDJ
         Kj2+MXUgpB+MHM3p9KLP9BaCwqzBpH5UJYhIax2dDToa+VGagCJGVG9psgeTjVjwsE/M
         mubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fOcYQHum18NNlljzaO1YwxdCM3i4CjuyZIdAXwLufoE=;
        b=k3UXmK9AkddBIbL4Ca4GIpHjjv+dNDyE2wOALRX88kYWjgcs1Vx3gtTG7TNxJR2pk2
         hrhLb1o+90OOdfdZnm8dMKPwHyJJrTwWuI6O6RaE5AyNRIGTZlBKz+hjRzZZORFnfMOi
         BjWbIbeK5OWio4PzXMA7owhJM4eXwX0b46LONUFUD7txUoYJSR+go8kXc5IMDWBLUwAD
         oWuK3HxT7LuLTcZTCUNkM76r4orsWapMXNrh+GkNF6c3/q6ZrgNm4WYMjbJ8u+2gaMby
         I0/2xYOqUZb61A4KCDIuLiyN5Y4sQ2vVIODOi4tl+vAU8DUBOmIG2khqPl6xl3zYFVIj
         +TZA==
X-Gm-Message-State: APjAAAW2gE7IGR7a995voyWGE7qM17oJkfCXBtrqgrKBh9J9PrMOuPba
        MBOpkQal2HGK6f9gvNtg1WHnKbSebVCYOOoOrLdCPoMS
X-Google-Smtp-Source: APXvYqzEMGNZ6CH/B6NGFe5XfAUjOP0LqY705BVWtVSqkxNMrnYVEP4GM5F15MG+hKgiEaHe5GtjIX6VG/bT5vAUSrY=
X-Received: by 2002:a05:660c:88d:: with SMTP id o13mr3713498itk.29.1556195728333;
 Thu, 25 Apr 2019 05:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
 <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
 <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
 <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com>
 <CAO-hwJJkyK_qPEL37QLd3kLuwB2rFBk+5FWg1UCfgr-FzxZ5aw@mail.gmail.com>
 <CAM4jgCrLRxOx-qtq8Wfbc1xmYkNHG9vsRSk_BBK5OPgkLyVYnQ@mail.gmail.com>
 <CAO-hwJ+r1TUQLZqdpNFD4AWC3URro3=Tc56gjV52i=aWrCbL8A@mail.gmail.com>
 <CAM4jgCrT7fAm1gi0L=Ux1GyxdH26cP8e_Dy36dEHF6Lf2F0rAQ@mail.gmail.com> <CAO-hwJKYtNMYEY1iFm-Nh0_+ZJBvPrXmBUPftwbuFd0ugqWVww@mail.gmail.com>
In-Reply-To: <CAO-hwJKYtNMYEY1iFm-Nh0_+ZJBvPrXmBUPftwbuFd0ugqWVww@mail.gmail.com>
From:   =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date:   Thu, 25 Apr 2019 14:35:17 +0200
Message-ID: <CAM4jgCpckiame+H4nXJ3iRQAP4BTKHVQCQxGA0xQ8TJf+-JY3Q@mail.gmail.com>
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

Le jeu. 25 avr. 2019 =C3=A0 11:35, Benjamin Tissoires
<benjamin.tissoires@redhat.com> a =C3=A9crit :
>
> On Thu, Apr 25, 2019 at 11:29 AM Cl=C3=A9ment VUCHENER
> <clement.vuchener@gmail.com> wrote:
> >
> > Le jeu. 25 avr. 2019 =C3=A0 10:45, Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> a =C3=A9crit :
> > >
> > > On Thu, Apr 25, 2019 at 10:25 AM Cl=C3=A9ment VUCHENER
> > > <clement.vuchener@gmail.com> wrote:
> > > >
> > > > Le jeu. 25 avr. 2019 =C3=A0 09:40, Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> a =C3=A9crit :
> > > > >
> > > > > Hi Cl=C3=A9ment,
> > > > >
> > > > > On Wed, Apr 24, 2019 at 5:34 PM Cl=C3=A9ment VUCHENER
> > > > > <clement.vuchener@gmail.com> wrote:
> > > > > >
> > > > > > Hi Benjamin,
> > > > > >
> > > > > > I tried again to add hi-res wheel support for the G500 with Han=
s de
> > > > > > Goede's latest patch series you've just merged in for-5.2/logit=
ech, it
> > > > > > is much better but there is still some issues.
> > > > > >
> > > > > > The first one is the device index, I need to use device index 0
> > > > > > instead 0xff. I added a quick and dirty quirk (stealing in the
> > > > > > QUIRK_CLASS range since the normal quirk range looks full) to c=
hange
> > > > > > the device index assigned in __hidpp_send_report. After that th=
e
> > > > > > device is correctly initialized and the wheel multiplier is set=
.
> > > > >
> > > > > Hmm, maybe we should restrain a little bit the reserved quirks...
> > > > > But actually, .driver_data and .quirks are both unsigned long, so=
 you
> > > > > should be able to use the 64 bits.
> > > >
> > > > Only on 64 bits architectures, or is the kernel forcing long intege=
rs
> > > > to be 64 bits everywhere?
> > >
> > > Damnit, you are correct, there is no such enforcement :/
> > >
> > > >
> > > > >
> > > > > >
> > > > > > The second issue is that wheel values are not actually scaled
> > > > > > according to the multiplier. I get 7/8 full scroll event for ea=
ch
> > > > > > wheel step. I think it happens because the mouse is split in tw=
o
> > > > > > devices. The first device has the wheel events, and the second =
device
> > > > > > has the HID++ reports. The wheel multiplier is only set on the =
second
> > > > > > device (where the hi-res mode is enabled) and does not affect t=
he
> > > > > > wheel events from the first one.
> > > > >
> > > > > I would think this have to do with the device not accepting the
> > > > > command instead. Can you share some raw logs of the events (ideal=
ly
> > > > > with hid-recorder from
> > > > > https://gitlab.freedesktop.org/libevdev/hid-tools)?
> > > >
> > > > I already checked with usbmon and double-checked by querying the
> > > > register. The flag is set and accepted by the device and it behaves
> > > > accordingly: it sends about 8 wheel events per step.
> > >
> > > OK, that's what I wanted to see.
> > >
> > > >
> > > > hid-recorder takes hidraw nodes as parameters, how do I use it to
> > > > record the initialization by the driver?
> > >
> > > You can't. But it doesn't really matter here because I wanted to chec=
k
> > > what your mouse is actually sending after the initialization.
> > >
> > > So if I read correctly: the mouse is sending high res data but
> > > evemu-recorder shows one REL_WHEEL event every 7/8 clicks?
> >
> > It is HID++ 1.0, there is no special high res data report, it sends
> > standard HID mouse wheel report, but more of them.
> >
> > To be clear, here is a recording using the modified kernel. I moved
> > the wheel one step up (8 events are generated), then one step down (8
> > events again + a 2-event bump).
> >
> > # EVEMU 1.3
> [snipped]
> > E: 1.975014 8 00 00 00 00 00 00 01 00
> >
> > The hi-res events should +/-15 instead of +/-120, and less REL_WHEEL
> > events should be generated. This looks like the multiplier is set to 1
> > instead of 8.
> >
> > kernel log shows the multiplier is set but only for one of the two devi=
ces:
> >
> > input: Logitech G500 as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C068.0006/i=
nput/input25
> > hid-generic 0003:046D:C068.0006: input,hidraw5: USB HID v1.11 Mouse
> > [Logitech G500] on usb-0000:00:14.0-2/input0
> > input: Logitech G500 Keyboard as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C068.0007/i=
nput/input26
> > input: Logitech G500 Consumer Control as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C068.0007/i=
nput/input27
> > hid-generic 0003:046D:C068.0007: input,hiddev97,hidraw6: USB HID v1.11
> > Keyboard [Logitech G500] on usb-0000:00:14.0-2/input1
> > input: Logitech G500 as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C068.0006/i=
nput/input30
> > logitech-hidpp-device 0003:046D:C068.0006: input,hidraw5: USB HID
> > v1.11 Mouse [Logitech G500] on usb-0000:00:14.0-2/input0
> > logitech-hidpp-device 0003:046D:C068.0007: HID++ 1.0 device connected.
> > logitech-hidpp-device 0003:046D:C068.0007: multiplier =3D 8
> > input: Logitech G500 as
> > /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C068.0007/i=
nput/input31
> > logitech-hidpp-device 0003:046D:C068.0007: input,hiddev97,hidraw6: USB
> > HID v1.11 Keyboard [Logitech G500] on usb-0000:00:14.0-2/input1
> >
>
> Oh, now I see. And yes you are correct.
>
> I wonder if we should not consider the mouse in hid-logitech-dj then.
> And let hid-logitech-dj merge the 2 nodes together into one hidpp
> device, and so we are facing a "regular" HID++ device which is
> consistent.

This would change how userspace see the devices, isn't it? And I don't
like the dj hidraw nodes, they mess with the device index: you get
answers with a device index different from the one used in the
corresponding request.

>
> Unfortunately, I am not sure I'll have the time to work on it this week :=
/
>
> Cheers,
> Benjamin
>
> > >
> > > > > > Le mer. 19 d=C3=A9c. 2018 =C3=A0 21:35, Benjamin Tissoires
> > > > > > <benjamin.tissoires@redhat.com> a =C3=A9crit :
> > > > > > >
> > > > > > > On Wed, Dec 19, 2018 at 11:57 AM Cl=C3=A9ment VUCHENER
> > > > > > > <clement.vuchener@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHEN=
ER
> > > > > > > > <clement.vuchener@gmail.com> a =C3=A9crit :
> > > > > > > > >
> > > > > > > > > Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcut=
ts@chromium.org> a =C3=A9crit :
> > > > > > > > > >
> > > > > > > > > > Hi Clement,
> > > > > > > > > >
> > > > > > > > > > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > > > > > > > > > <clement.vuchener@gmail.com> wrote:
> > > > > > > > > > > Hi, The G500s (and the G500 too, I think) does suppor=
t the "scrolling
> > > > > > > > > > > acceleration" bit. If I set it, I get around 8 events=
 for each wheel
> > > > > > > > > > > "click", this is what this driver expects, right? If =
I understood
> > > > > > > > > > > correctly, I should try this patch with the
> > > > > > > > > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > > > > > > > > >
> > > > > > > > > > Thanks for the info! Yes, that should work.
> > > > > > > > >
> > > > > > > > > Well, it is not that simple. I get "Device not connected"=
 errors for
> > > > > > > > > both interfaces of the mouse.
> > > > > > > >
> > > > > > > > I suspect the device is not responding because the hid devi=
ce is not
> > > > > > > > started. When is hid_hw_start supposed to be called? It is =
called
> > > > > > > > early for HID_QUIRK_CLASS_G920 but later for other device. =
So the
> > > > > > > > device is not started when hidpp_is_connected is called. Is=
 this
> > > > > > > > because most of the device in this driver are not real HID =
devices but
> > > > > > > > DJ devices? How should non-DJ devices be treated?
> > > > > > >
> > > > > > > Hi Clement,
> > > > > > >
> > > > > > > I have a series I sent last September that allows to support =
non DJ
> > > > > > > devices on logitech-hidpp
> > > > > > > (https://patchwork.kernel.org/project/linux-input/list/?serie=
s=3D16359).
> > > > > > >
> > > > > > > In its current form, with the latest upstream kernel, the ser=
ies will
> > > > > > > oops during the .event() callback, which is easy enough to fi=
x.
> > > > > > > However, I am currently trying to make it better as a second =
or third
> > > > > > > reading made me realized that there was a bunch of non-sense =
in it and
> > > > > > > a proper support would require slightly more work for the non=
 unifying
> > > > > > > receiver case.
> > > > > > >
> > > > > > > I hope I'll be able to send out something by the end of the w=
eek.
> > > > > > >
> > > > > > > Cheers,
> > > > > > > Benjamin
