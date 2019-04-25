Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1F6C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A4214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSsSJbFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfDYJ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:29:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38219 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfDYJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:28:57 -0400
Received: by mail-io1-f68.google.com with SMTP id y6so10731895ior.5;
        Thu, 25 Apr 2019 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BDOLRzJRcMTas6Vac7mNo67kdh4c8ZW/9Eid5qKoZTA=;
        b=bSsSJbFRmxZ1PXlkuj8WeXaauvpXx3iWtmPxktyjeXyrkbeJDq9uRA/A2N6Q8/OBXa
         74ieeOOJUB3ZcCFIq9UgQZsDjMz+oSYTvPvHXZRoG9/fC2zltazT1nMcSmpHnf+szkwP
         VFf1JCdSnOI+KUYCWZJhNVl+xUiOGSCJ/TQlsBesrgDCNx78v6nIqzsJFGX8A38CQUk/
         98aBEyAgUEFppLcb2YgVeFdYGwPjxPAPddHd8K4TByO3ik7kgNBBgK6I/udIy5Cpayw3
         apGGj0EweT9EHVCh2fw+yTtw/gWIyS6FBe2qFoR8fA2kdTTpDVCxaxFuRtF9TLXZfPs/
         ZvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BDOLRzJRcMTas6Vac7mNo67kdh4c8ZW/9Eid5qKoZTA=;
        b=HCuMLW0Lfru+zufE5OCGNBrortrrR74tTPlxTMR+Zdn1uR7IHN/MQdBZ+UUPCq+7xU
         3hWW2s9OQ01xrBOtV9VG6+cnBGHalDCXVsap4VGRj0bpE94jxTErBLPXRZ+8z+QQrcXs
         J/BUi9v85fGK/KRBuqE2H8MeYvB410ZRFSh5gruGWi0gBS1WamexaqCW2tupNdsWkAys
         kKi5XcmE5r+e6IsRhmfCJLG/ik7h/wgF8yTxq0eWx4A6BCD2Af4VNedniWjWmayKXyKC
         upWe/YdeH765g/t/97gAxMlAg5NbVW4XP03ji9QoxseN/uoDewEZ5Us37Hg6jBwyOpzC
         Yu3A==
X-Gm-Message-State: APjAAAXCsjwwKwbaR/0VQaX+OWQit6vEPiLYT8I30seY1D9PWOZqWwxh
        HCrSVT3SYArBs+r+uT3hTfReS6jSeQLqXApGUlc=
X-Google-Smtp-Source: APXvYqwi78kU796u3Kh0bYkSsrQKK1OUf6yKRIlvYdX8tlBUaxfFghmU4LHmsGTw0bVUzpC0Fe1ehUXFEdPhfk2iuNk=
X-Received: by 2002:a5d:91c7:: with SMTP id k7mr7251918ior.237.1556184535886;
 Thu, 25 Apr 2019 02:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
 <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com>
 <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
 <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com>
 <CAO-hwJJkyK_qPEL37QLd3kLuwB2rFBk+5FWg1UCfgr-FzxZ5aw@mail.gmail.com>
 <CAM4jgCrLRxOx-qtq8Wfbc1xmYkNHG9vsRSk_BBK5OPgkLyVYnQ@mail.gmail.com> <CAO-hwJ+r1TUQLZqdpNFD4AWC3URro3=Tc56gjV52i=aWrCbL8A@mail.gmail.com>
In-Reply-To: <CAO-hwJ+r1TUQLZqdpNFD4AWC3URro3=Tc56gjV52i=aWrCbL8A@mail.gmail.com>
From:   =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date:   Thu, 25 Apr 2019 11:28:44 +0200
Message-ID: <CAM4jgCrT7fAm1gi0L=Ux1GyxdH26cP8e_Dy36dEHF6Lf2F0rAQ@mail.gmail.com>
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

Le jeu. 25 avr. 2019 =C3=A0 10:45, Benjamin Tissoires
<benjamin.tissoires@redhat.com> a =C3=A9crit :
>
> On Thu, Apr 25, 2019 at 10:25 AM Cl=C3=A9ment VUCHENER
> <clement.vuchener@gmail.com> wrote:
> >
> > Le jeu. 25 avr. 2019 =C3=A0 09:40, Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> a =C3=A9crit :
> > >
> > > Hi Cl=C3=A9ment,
> > >
> > > On Wed, Apr 24, 2019 at 5:34 PM Cl=C3=A9ment VUCHENER
> > > <clement.vuchener@gmail.com> wrote:
> > > >
> > > > Hi Benjamin,
> > > >
> > > > I tried again to add hi-res wheel support for the G500 with Hans de
> > > > Goede's latest patch series you've just merged in for-5.2/logitech,=
 it
> > > > is much better but there is still some issues.
> > > >
> > > > The first one is the device index, I need to use device index 0
> > > > instead 0xff. I added a quick and dirty quirk (stealing in the
> > > > QUIRK_CLASS range since the normal quirk range looks full) to chang=
e
> > > > the device index assigned in __hidpp_send_report. After that the
> > > > device is correctly initialized and the wheel multiplier is set.
> > >
> > > Hmm, maybe we should restrain a little bit the reserved quirks...
> > > But actually, .driver_data and .quirks are both unsigned long, so you
> > > should be able to use the 64 bits.
> >
> > Only on 64 bits architectures, or is the kernel forcing long integers
> > to be 64 bits everywhere?
>
> Damnit, you are correct, there is no such enforcement :/
>
> >
> > >
> > > >
> > > > The second issue is that wheel values are not actually scaled
> > > > according to the multiplier. I get 7/8 full scroll event for each
> > > > wheel step. I think it happens because the mouse is split in two
> > > > devices. The first device has the wheel events, and the second devi=
ce
> > > > has the HID++ reports. The wheel multiplier is only set on the seco=
nd
> > > > device (where the hi-res mode is enabled) and does not affect the
> > > > wheel events from the first one.
> > >
> > > I would think this have to do with the device not accepting the
> > > command instead. Can you share some raw logs of the events (ideally
> > > with hid-recorder from
> > > https://gitlab.freedesktop.org/libevdev/hid-tools)?
> >
> > I already checked with usbmon and double-checked by querying the
> > register. The flag is set and accepted by the device and it behaves
> > accordingly: it sends about 8 wheel events per step.
>
> OK, that's what I wanted to see.
>
> >
> > hid-recorder takes hidraw nodes as parameters, how do I use it to
> > record the initialization by the driver?
>
> You can't. But it doesn't really matter here because I wanted to check
> what your mouse is actually sending after the initialization.
>
> So if I read correctly: the mouse is sending high res data but
> evemu-recorder shows one REL_WHEEL event every 7/8 clicks?

It is HID++ 1.0, there is no special high res data report, it sends
standard HID mouse wheel report, but more of them.

To be clear, here is a recording using the modified kernel. I moved
the wheel one step up (8 events are generated), then one step down (8
events again + a 2-event bump).

# EVEMU 1.3
# Kernel: 5.0.0logitech+
# DMI: dmi:bvnAmericanMegatrendsInc.:bvr1.40:bd01/17/2019:svnMicro-StarInte=
rnationalCo.,Ltd.:pnMS-7B98:pvr1.0:rvnMicro-StarInternationalCo.,Ltd.:rnZ39=
0-APRO(MS-7B98):rvr1.0:cvnMicro-StarInternationalCo.,Ltd.:ct3:cvr1.0:
# Input device name: "Logitech G500"
# Input device ID: bus 0x03 vendor 0x46d product 0xc068 version 0x111
# Supported events:
#   Event type 0 (EV_SYN)
#     Event code 0 (SYN_REPORT)
#     Event code 1 (SYN_CONFIG)
#     Event code 2 (SYN_MT_REPORT)
#     Event code 3 (SYN_DROPPED)
#     Event code 4 ((null))
#     Event code 5 ((null))
#     Event code 6 ((null))
#     Event code 7 ((null))
#     Event code 8 ((null))
#     Event code 9 ((null))
#     Event code 10 ((null))
#     Event code 11 ((null))
#     Event code 12 ((null))
#     Event code 13 ((null))
#     Event code 14 ((null))
#     Event code 15 (SYN_MAX)
#   Event type 1 (EV_KEY)
#     Event code 272 (BTN_LEFT)
#     Event code 273 (BTN_RIGHT)
#     Event code 274 (BTN_MIDDLE)
#     Event code 275 (BTN_SIDE)
#     Event code 276 (BTN_EXTRA)
#     Event code 277 (BTN_FORWARD)
#     Event code 278 (BTN_BACK)
#     Event code 279 (BTN_TASK)
#     Event code 280 ((null))
#     Event code 281 ((null))
#     Event code 282 ((null))
#     Event code 283 ((null))
#     Event code 284 ((null))
#     Event code 285 ((null))
#     Event code 286 ((null))
#     Event code 287 ((null))
#   Event type 2 (EV_REL)
#     Event code 0 (REL_X)
#     Event code 1 (REL_Y)
#     Event code 6 (REL_HWHEEL)
#     Event code 8 (REL_WHEEL)
#     Event code 11 ((null))
#     Event code 12 ((null))
#   Event type 4 (EV_MSC)
#     Event code 4 (MSC_SCAN)
# Properties:
N: Logitech G500
I: 0003 046d c068 0111
P: 00 00 00 00 00 00 00 00
B: 00 0b 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 ff ff 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 01 00 00 00 00 00 00 00 00
B: 02 43 19 00 00 00 00 00 00
B: 03 00 00 00 00 00 00 00 00
B: 04 10 00 00 00 00 00 00 00
B: 05 00 00 00 00 00 00 00 00
B: 11 00 00 00 00 00 00 00 00
B: 12 00 00 00 00 00 00 00 00
B: 14 00 00 00 00 00 00 00 00
B: 15 00 00 00 00 00 00 00 00
B: 15 00 00 00 00 00 00 00 00
################################
#      Waiting for events      #
################################
E: 0.000001 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.000001 0002 000b 0120    # EV_REL / (null)               120
E: 0.000001 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +0ms
E: 0.042009 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.042009 0002 000b 0120    # EV_REL / (null)               120
E: 0.042009 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +42m=
s
E: 0.075016 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.075016 0002 000b 0120    # EV_REL / (null)               120
E: 0.075016 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +33m=
s
E: 0.107977 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.107977 0002 000b 0120    # EV_REL / (null)               120
E: 0.107977 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +32m=
s
E: 0.124979 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.124979 0002 000b 0120    # EV_REL / (null)               120
E: 0.124979 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +17m=
s
E: 0.141950 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.141950 0002 000b 0120    # EV_REL / (null)               120
E: 0.141950 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +17m=
s
E: 0.152950 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.152950 0002 000b 0120    # EV_REL / (null)               120
E: 0.152950 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +11m=
s
E: 0.170943 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 0.170943 0002 000b 0120    # EV_REL / (null)               120
E: 0.170943 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +18m=
s
E: 1.452035 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.452035 0002 000b -120    # EV_REL / (null)               -120
E: 1.452035 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +128=
2ms
E: 1.535031 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.535031 0002 000b -120    # EV_REL / (null)               -120
E: 1.535031 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +83m=
s
E: 1.574981 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.574981 0002 000b -120    # EV_REL / (null)               -120
E: 1.574981 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +39m=
s
E: 1.702039 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.702039 0002 000b -120    # EV_REL / (null)               -120
E: 1.702039 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +128=
ms
E: 1.713031 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.713031 0002 000b -120    # EV_REL / (null)               -120
E: 1.713031 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +11m=
s
E: 1.724036 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.724036 0002 000b -120    # EV_REL / (null)               -120
E: 1.724036 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +11m=
s
E: 1.731006 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.731006 0002 000b -120    # EV_REL / (null)               -120
E: 1.731006 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +7ms
E: 1.740043 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.740043 0002 000b -120    # EV_REL / (null)               -120
E: 1.740043 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +9ms
E: 1.765013 0002 0008 -001    # EV_REL / REL_WHEEL            -1
E: 1.765013 0002 000b -120    # EV_REL / (null)               -120
E: 1.765013 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +25m=
s
E: 1.975044 0002 0008 0001    # EV_REL / REL_WHEEL            1
E: 1.975044 0002 000b 0120    # EV_REL / (null)               120
E: 1.975044 0000 0000 0000    # ------------ SYN_REPORT (0) ---------- +210=
ms

Here is the corresponding hid-recorder:

D: 0
R: 67 05 01 09 02 a1 01 09 01 a1 00 05 09 19 01 29 10 15 00 25 01 95
10 75 01 81 02 05 01 16 01 80 26 ff 7f 75 10 95 02 09 30 09 31 81 06
15 81 25 7f 75 08 95 01 09 38 81 06 05 0c 0a 38 02 95 01 81 06 c0 c0
N: Logitech G500
P: usb-0000:00:14.0-2/input0
I: 3 046d c068
D: 0
E: 0.000000 8 00 00 00 00 00 00 01 00
E: 0.041957 8 00 00 00 00 00 00 01 00
E: 0.074966 8 00 00 00 00 00 00 01 00
E: 0.107932 8 00 00 00 00 00 00 01 00
E: 0.124933 8 00 00 00 00 00 00 01 00
E: 0.141897 8 00 00 00 00 00 00 01 00
E: 0.152900 8 00 00 00 00 00 00 01 00
E: 0.170892 8 00 00 00 00 00 00 01 00
E: 1.452000 8 00 00 00 00 00 00 ff 00
E: 1.535009 8 00 00 00 00 00 00 ff 00
E: 1.574928 8 00 00 00 00 00 00 ff 00
E: 1.702009 8 00 00 00 00 00 00 ff 00
E: 1.713009 8 00 00 00 00 00 00 ff 00
E: 1.724001 8 00 00 00 00 00 00 ff 00
E: 1.730963 8 00 00 00 00 00 00 ff 00
E: 1.740005 8 00 00 00 00 00 00 ff 00
E: 1.764977 8 00 00 00 00 00 00 ff 00
E: 1.975014 8 00 00 00 00 00 00 01 00

The hi-res events should +/-15 instead of +/-120, and less REL_WHEEL
events should be generated. This looks like the multiplier is set to 1
instead of 8.

kernel log shows the multiplier is set but only for one of the two devices:

input: Logitech G500 as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C068.0006/input=
/input25
hid-generic 0003:046D:C068.0006: input,hidraw5: USB HID v1.11 Mouse
[Logitech G500] on usb-0000:00:14.0-2/input0
input: Logitech G500 Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C068.0007/input=
/input26
input: Logitech G500 Consumer Control as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C068.0007/input=
/input27
hid-generic 0003:046D:C068.0007: input,hiddev97,hidraw6: USB HID v1.11
Keyboard [Logitech G500] on usb-0000:00:14.0-2/input1
input: Logitech G500 as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:046D:C068.0006/input=
/input30
logitech-hidpp-device 0003:046D:C068.0006: input,hidraw5: USB HID
v1.11 Mouse [Logitech G500] on usb-0000:00:14.0-2/input0
logitech-hidpp-device 0003:046D:C068.0007: HID++ 1.0 device connected.
logitech-hidpp-device 0003:046D:C068.0007: multiplier =3D 8
input: Logitech G500 as
/devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:046D:C068.0007/input=
/input31
logitech-hidpp-device 0003:046D:C068.0007: input,hiddev97,hidraw6: USB
HID v1.11 Keyboard [Logitech G500] on usb-0000:00:14.0-2/input1


>
> Cheers,
> Benjamin
>
> > > > Le mer. 19 d=C3=A9c. 2018 =C3=A0 21:35, Benjamin Tissoires
> > > > <benjamin.tissoires@redhat.com> a =C3=A9crit :
> > > > >
> > > > > On Wed, Dec 19, 2018 at 11:57 AM Cl=C3=A9ment VUCHENER
> > > > > <clement.vuchener@gmail.com> wrote:
> > > > > >
> > > > > > Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHENER
> > > > > > <clement.vuchener@gmail.com> a =C3=A9crit :
> > > > > > >
> > > > > > > Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcutts@c=
hromium.org> a =C3=A9crit :
> > > > > > > >
> > > > > > > > Hi Clement,
> > > > > > > >
> > > > > > > > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > > > > > > > <clement.vuchener@gmail.com> wrote:
> > > > > > > > > Hi, The G500s (and the G500 too, I think) does support th=
e "scrolling
> > > > > > > > > acceleration" bit. If I set it, I get around 8 events for=
 each wheel
> > > > > > > > > "click", this is what this driver expects, right? If I un=
derstood
> > > > > > > > > correctly, I should try this patch with the
> > > > > > > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > > > > > > >
> > > > > > > > Thanks for the info! Yes, that should work.
> > > > > > >
> > > > > > > Well, it is not that simple. I get "Device not connected" err=
ors for
> > > > > > > both interfaces of the mouse.
> > > > > >
> > > > > > I suspect the device is not responding because the hid device i=
s not
> > > > > > started. When is hid_hw_start supposed to be called? It is call=
ed
> > > > > > early for HID_QUIRK_CLASS_G920 but later for other device. So t=
he
> > > > > > device is not started when hidpp_is_connected is called. Is thi=
s
> > > > > > because most of the device in this driver are not real HID devi=
ces but
> > > > > > DJ devices? How should non-DJ devices be treated?
> > > > >
> > > > > Hi Clement,
> > > > >
> > > > > I have a series I sent last September that allows to support non =
DJ
> > > > > devices on logitech-hidpp
> > > > > (https://patchwork.kernel.org/project/linux-input/list/?series=3D=
16359).
> > > > >
> > > > > In its current form, with the latest upstream kernel, the series =
will
> > > > > oops during the .event() callback, which is easy enough to fix.
> > > > > However, I am currently trying to make it better as a second or t=
hird
> > > > > reading made me realized that there was a bunch of non-sense in i=
t and
> > > > > a proper support would require slightly more work for the non uni=
fying
> > > > > receiver case.
> > > > >
> > > > > I hope I'll be able to send out something by the end of the week.
> > > > >
> > > > > Cheers,
> > > > > Benjamin
