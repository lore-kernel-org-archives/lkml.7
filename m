Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24313C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDAF21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4nI6sDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbfDXPey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:34:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36923 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfDXPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:34:53 -0400
Received: by mail-io1-f66.google.com with SMTP id a23so12443792iot.4;
        Wed, 24 Apr 2019 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jD2lPgbI29EFEHCKTFjIILuqrJGfKY3QLgT9o6pbl7Y=;
        b=i4nI6sDOQZpqMa0h7miMqwmFHQhI4YfnhgjIMsyO8XEUfWW9NySgnWNWp0X73kvptJ
         E6joTjYk/g/0Gu020KP4x4OMOzc5b+yUCL0Yq6380rrxGO7DnZYOEZstCrYE9SIouReI
         xNQHqP7auTPM2DJTZJvuCAt0lQ1Srjego2cGay9Ied0t2llPSKfY/ICLPkYod3j6HUcD
         Q91dnJpLTnnNvWX3P+5/M3ftwyGCRDDBOQNpGMI/YTU1HSEpQ7WnQp2a8trFW/VamjKR
         UBTxrOp2cYvjt6Emr17RyDc9F4POS5j57MsARj8O43z9qzq+s+UmF3QEcDkaS8aGF6ob
         ehwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jD2lPgbI29EFEHCKTFjIILuqrJGfKY3QLgT9o6pbl7Y=;
        b=QK6TAF+Mx6dbvoc3tbA8HD2SKD8x2FSMF+bo7ZdACAjhKKNbPvq+6zvgvGDBCRla8T
         YqPEctk5BJQQqe+jh8yGV7RTPbd8AGYXcJe08gEH/lVnSWNY7sONX3Y9pdrdct+Ddy7e
         yaYSwA6P/rIO1IoWx1rn6j8B1rZPq5qxB+y3J9SJ9HqetjuiMcehh5PrUtG7KyqoOmhv
         IW5rvZKIVnfJF/JjLTwkCkbYOIiPX3ba3tDNLnZpscjx57Cemg8JAOBZNaT6ZOw6c1GC
         yAYgmNaweJfNqSg1kJzUAnD8nw9MyST5Bp9KQLcQXUXHMY0rCaM3kxKVpSrXNhE+iRXW
         SO4Q==
X-Gm-Message-State: APjAAAV0Z6C+vXsNyblv4xhK2bkEFF8rEjOJzs6xVPS6O3lz1lolRFt1
        GdI2QN814y9foyfQyxFAl4/4bVM/Dl3wSlJdHMY=
X-Google-Smtp-Source: APXvYqyCEEBmt6Zqi/ABKCSbEy5jBYSwoW7pSEYJuZ5Z++60X0kI1AY1MPVHhJ7T0QjZa19RSq9Dmexjx2iGWJvUJGE=
X-Received: by 2002:a6b:ed0c:: with SMTP id n12mr758224iog.259.1556120092789;
 Wed, 24 Apr 2019 08:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
 <20181205004228.10714-8-peter.hutterer@who-t.net> <CAM4jgCqAh9Pck-9i8F5tO4-Kzpu+SjH-mQnGYThadSf-3b1ikw@mail.gmail.com>
 <CA+jURcuhBRYiqFYHDgK8dDycrPgvzkujTRZfnmYraiHvwE+e6w@mail.gmail.com>
 <CAM4jgCo483upCJWUnpP45zh2LzQWqAZmQREf2622p49a1vbnnA@mail.gmail.com>
 <CAM4jgCqj5gs-q7VKLm90p0a01k_tYAqxA=zxsmShxv4PSGBJ4A@mail.gmail.com> <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
In-Reply-To: <CAO-hwJK7pFvuYZJTKgwkj794=xinekDgN_eLBSViw3v_dWAecw@mail.gmail.com>
From:   =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Date:   Wed, 24 Apr 2019 17:34:41 +0200
Message-ID: <CAM4jgCrYBr+M+F2iAn8-pPFjiZQ-nPT_H16WcyPKp2PFCM=qhQ@mail.gmail.com>
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

Hi Benjamin,

I tried again to add hi-res wheel support for the G500 with Hans de
Goede's latest patch series you've just merged in for-5.2/logitech, it
is much better but there is still some issues.

The first one is the device index, I need to use device index 0
instead 0xff. I added a quick and dirty quirk (stealing in the
QUIRK_CLASS range since the normal quirk range looks full) to change
the device index assigned in __hidpp_send_report. After that the
device is correctly initialized and the wheel multiplier is set.

The second issue is that wheel values are not actually scaled
according to the multiplier. I get 7/8 full scroll event for each
wheel step. I think it happens because the mouse is split in two
devices. The first device has the wheel events, and the second device
has the HID++ reports. The wheel multiplier is only set on the second
device (where the hi-res mode is enabled) and does not affect the
wheel events from the first one.

Le mer. 19 d=C3=A9c. 2018 =C3=A0 21:35, Benjamin Tissoires
<benjamin.tissoires@redhat.com> a =C3=A9crit :
>
> On Wed, Dec 19, 2018 at 11:57 AM Cl=C3=A9ment VUCHENER
> <clement.vuchener@gmail.com> wrote:
> >
> > Le sam. 15 d=C3=A9c. 2018 =C3=A0 15:45, Cl=C3=A9ment VUCHENER
> > <clement.vuchener@gmail.com> a =C3=A9crit :
> > >
> > > Le ven. 14 d=C3=A9c. 2018 =C3=A0 19:37, Harry Cutts <hcutts@chromium.=
org> a =C3=A9crit :
> > > >
> > > > Hi Clement,
> > > >
> > > > On Fri, 14 Dec 2018 at 05:47, Cl=C3=A9ment VUCHENER
> > > > <clement.vuchener@gmail.com> wrote:
> > > > > Hi, The G500s (and the G500 too, I think) does support the "scrol=
ling
> > > > > acceleration" bit. If I set it, I get around 8 events for each wh=
eel
> > > > > "click", this is what this driver expects, right? If I understood
> > > > > correctly, I should try this patch with the
> > > > > HIDPP_QUIRK_HI_RES_SCROLL_1P0 quirk set for my mouse.
> > > >
> > > > Thanks for the info! Yes, that should work.
> > >
> > > Well, it is not that simple. I get "Device not connected" errors for
> > > both interfaces of the mouse.
> >
> > I suspect the device is not responding because the hid device is not
> > started. When is hid_hw_start supposed to be called? It is called
> > early for HID_QUIRK_CLASS_G920 but later for other device. So the
> > device is not started when hidpp_is_connected is called. Is this
> > because most of the device in this driver are not real HID devices but
> > DJ devices? How should non-DJ devices be treated?
>
> Hi Clement,
>
> I have a series I sent last September that allows to support non DJ
> devices on logitech-hidpp
> (https://patchwork.kernel.org/project/linux-input/list/?series=3D16359).
>
> In its current form, with the latest upstream kernel, the series will
> oops during the .event() callback, which is easy enough to fix.
> However, I am currently trying to make it better as a second or third
> reading made me realized that there was a bunch of non-sense in it and
> a proper support would require slightly more work for the non unifying
> receiver case.
>
> I hope I'll be able to send out something by the end of the week.
>
> Cheers,
> Benjamin
