Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD0ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E472190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewhBCjlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfJKIyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:54:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34636 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726397AbfJKIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570784071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqByrLt5Vdti/Qv9DsLf8UE4W1FmXeVxkyclk9rGeTo=;
        b=ewhBCjlSyoYni7FZ4mjVogXwvqXeL+POI5VpfPaRIh7NehkHhi5aPgEGTxU7xHC+UerP4s
        h37ZQIU36RgOMDALgqsaiSRB8Glq1liyq+sj1u6BxkU/qKau58liZRDiBUsb8GOc9krCKB
        /sLYwQTlijzBMcYyMNLjArzYAlSEWYM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-8Gfy7x_-PwOUaMJspJUgyQ-1; Fri, 11 Oct 2019 04:54:28 -0400
Received: by mail-qk1-f200.google.com with SMTP id v143so8203635qka.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 01:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eqByrLt5Vdti/Qv9DsLf8UE4W1FmXeVxkyclk9rGeTo=;
        b=sFn2jHq20X7vgK6/hFnNeeeKHMs01v1BzA3/FXo/bCuZGfvUeW3P2J9xyNH9WE3p/3
         HqNv1R14aWgyw3mdgaVRsJHWQc8Wok352lQRFK7S25OYBzqFkL9YTcwGhV0XtbUh0Cg+
         +yFEG4YOi9O47dGwzO2+Yy8kBdwrdtnGGJQ/xiyA/41kSfxT6a+dbY+kcgs+zTz0yJ32
         +WCEjhMVPbsZvXUt6ZyVoOuJ8KVfpPAvEn+RXXwQKhxP3qMti4Pd8x6/QcbdvSzTyt5Z
         B8jI0ZzTbmx5q2G7sU8PHKFUYUX79W1l6GHSeySQ5JvMnUpj3frrkMSTUnPxAnNi5J+M
         NI0g==
X-Gm-Message-State: APjAAAUR2F+HnbW0QnCPd2l6rdVT38yrL7XzEyIyEpcJWrEMb5r3gmjB
        K/n+X3LGIjYppSxKKAscGY7qo9hmDN6bsfqTWmU2x4a9CmM5h24k2IjnpSRikRKaCkp6jN2m4+j
        vDIlUnumB2JBsbYv3/HkFc+tgPh5wbGWQwedfeMTY
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr15568222qtm.294.1570784067989;
        Fri, 11 Oct 2019 01:54:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz/V9+A0WSqZaDO7OFXISc9+GZq/Vzaj7Pjxou3mKbEZVfAG4wXOTvSoN+Hl6CCsx6TQjBqFMcXfero/+VIBpA=
X-Received: by 2002:ac8:1e83:: with SMTP id c3mr15568215qtm.294.1570784067809;
 Fri, 11 Oct 2019 01:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
 <403b3e7f6d276e47c447e6ea56a3370b03c3298c.camel@archlinux.org>
In-Reply-To: <403b3e7f6d276e47c447e6ea56a3370b03c3298c.camel@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 11 Oct 2019 10:54:16 +0200
Message-ID: <CAO-hwJK+V=CE8_NjqRszPA6dbGq1yNJAtOAm2qmqVjgK_XzEHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] HID: logitech: Add MX Mice over Bluetooth
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Mazin Rezk <mnrzk@protonmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-MC-Unique: 8Gfy7x_-PwOUaMJspJUgyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:49 AM Filipe La=C3=ADns <lains@archlinux.org> wr=
ote:
>
> On Fri, 2019-10-11 at 00:57 +0000, Mazin Rezk wrote:
> > On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <
> > mnrzk@protonmail.com> wrote:
> >
> > > This patch adds support for several MX mice over Bluetooth. The
> > > device IDs
> > > have been copied from the libratbag device database and their
> > > features
> > > have been based on their DJ device counterparts.
> >
> > No changes have been made to this patch in v4. However, it should be
> > noted
> > that the only device that has been thoroughly tested in this patch is
> > the
> > MX Master (b01e). Further testing for the other devices may be
> > required.
> >
> > Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index 0179f7ed77e5..85fd0c17cc2f 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -3773,6 +3773,24 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >       { /* MX5500 keyboard over Bluetooth */
> >         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
> >         .driver_data =3D HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> > +     { /* MX Anywhere 2 mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { /* MX Anywhere 2S mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { /* MX Master mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> > +     { /* MX Master 2S mouse over Bluetooth */
> > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> > +       .driver_data =3D HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> >       {}
> >  };
> >
> > --
> > 2.23.0
> >
>
> The series now looks great, thanks!
>
> Benjamin, I can confirm that up to now all BLE devices don't have short
> reports. I am not sure if you still want to only enable tested devices
> but from an architectural standpoint everything here should be fine.

Unfortunately yes, we need actual device tests:
- this series enable 0x2121 on all of those devices (is it correct?)
- we are not shielded from a FW error and something that goes wrong
when enabling one of those mice with hid-logitech-hidpp.c. All of
those mice works fine with hid-generic, and if we oversee one tiny
bit, we'll regress for no good reasons.

Cheers,
Benjamin

>
> Mazin, you can have my
>
> Reviewed-by: Filipe La=C3=ADns <lains@archlinux.org>
>
> for the series.
>
> Thank you,
> Filipe La=C3=ADns

