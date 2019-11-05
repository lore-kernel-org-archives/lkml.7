Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C875C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D7521D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nrLLcvG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389376AbfKENz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:55:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33320 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389325AbfKENzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:55:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id s1so21523652wro.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PyXIR+PmEYH6qf7Ne4Mnmzv5YmXO3mLrP9LUHKfXPGw=;
        b=nrLLcvG14uq+/X/VA+nQN9xUWpd5bUqLUw8+DW6y6mWEQ4kkljqlcZlkNd8Y+iazcv
         +Otpdi9PB8TpTEf+BFG7BRu6C4H0xn0dHbTE3b+kKAJd29FOhKhCjHTxH/azEtQ5h7yM
         JU8H+7stYX9tn4RyzLsIwaQkV/RGM9nY3vN8dU6dz5IS6JNCqCknbaBCAVYqyQVdnR+f
         FlSJALeQqX+R4CttbO/g8G95D3aRoVysHz6QIH+dvl/Vc7VapDBxyxp8BaFeF/NJQUUZ
         YHC1lBDlGm9cRdf4WRWjh21h9EazOfczbEmDkg2xuwtBQMxBLUXVrnprO1L3RlQFQ4V2
         4w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PyXIR+PmEYH6qf7Ne4Mnmzv5YmXO3mLrP9LUHKfXPGw=;
        b=NPzo82fm6eSpxT2FOvE1Vd5ci4er6RPiI55VTjCr/nnGU/Ml5NvkiP0ZlycRIdrxdW
         A7yWjOy9lDfXnNYoeel1gWXx2l0Pv7Pt+2xhYzAfgQL8HjkNGX9CpU2xhY/EwWC2aJ9Y
         JQJ9+vGUX5q9sC2Ksb7DsaKZ8PYILfnSErAAYJIBCx0DL6fmUd7rIvFCbaoBWLxZITNJ
         wgwEh8uMHuRXjZqpfpJ2fsdTGmWwr7a8UrqaBGY2YXktIs262pWWfITXbizpDcyJ0MMM
         RdRytZPCuVQK7eihgbXO349mr3eQQhWxZuAD0tymUHxFcnSvbBtZGQQIhf2WrNldyKGW
         uP+Q==
X-Gm-Message-State: APjAAAXzDydlrOWg19svcSHAfPP4MfjGFwWKkD2JXJbcvUfZAkwknKMd
        augrfXDeLfYOHsmUSH1SeBX3yiM/1BUHQ1sQL6uk0w==
X-Google-Smtp-Source: APXvYqxjj+8gPUXBhVJwTdgO3UqcgZSy680LmPK7WgNPjacYCgWg1+F0r9TqCmgpblipbvfcla37/3gcFs9fryeltdg=
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr7058466wrx.154.1572962120795;
 Tue, 05 Nov 2019 05:55:20 -0800 (PST)
MIME-Version: 1.0
References: <00000000000013c4c1059625a655@google.com> <87ftj32v6y.fsf@miraculix.mork.no>
 <1572952516.2921.6.camel@suse.com> <875zjy33z2.fsf@miraculix.mork.no>
In-Reply-To: <875zjy33z2.fsf@miraculix.mork.no>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 5 Nov 2019 14:55:09 +0100
Message-ID: <CAG_fn=XXGX5U9oJ2bJDHCwVcp8M+rGDvFDTt4kWFiyWoqL8vAA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in cdc_ncm_set_dgram_size
To:     =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+0631d878823ce2411636@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Greg K-H
On Tue, Nov 5, 2019 at 1:25 PM Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
> Oliver Neukum <oneukum@suse.com> writes:
> > Am Montag, den 04.11.2019, 22:22 +0100 schrieb Bj=C3=B8rn Mork:
> >> This looks like a false positive to me. max_datagram_size is two bytes
> >> declared as
> >>
> >>         __le16 max_datagram_size;
> >>
> >> and the code leading up to the access on drivers/net/usb/cdc_ncm.c:587
> >> is:
> >>
> >>         /* read current mtu value from device */
> >>         err =3D usbnet_read_cmd(dev, USB_CDC_GET_MAX_DATAGRAM_SIZE,
> >>                               USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_=
INTERFACE,
> >>                               0, iface_no, &max_datagram_size, 2);
> >
> > At this point err can be 1.
> >
> >>         if (err < 0) {
> >>                 dev_dbg(&dev->intf->dev, "GET_MAX_DATAGRAM_SIZE failed=
\n");
> >>                 goto out;
> >>         }
> >>
> >>         if (le16_to_cpu(max_datagram_size) =3D=3D ctx->max_datagram_si=
ze)
> >>
> >>
> >>
> >> AFAICS, there is no way max_datagram_size can be uninitialized here.
> >> usbnet_read_cmd() either read 2 bytes into it or returned an error,
> >
> > No. usbnet_read_cmd() will return the number of bytes transfered up
> > to the number requested or an error.
>
> Ah, OK. So that could be fixed with e.g.
>
>   if (err < 2)
>        goto out;
It'd better be (err < sizeof(max_datagram_size)), and probably in the
call to usbnet_read_cmd() as well.
>
> Or would it be better to add a strict length checking variant of this
> API?  There are probably lots of similar cases where we expect a
> multibyte value and a short read is (or should be) considered an error.
> I can't imagine any situation where we want a 2, 4, 6 or 8 byte value
> and expect a flexible length returned.
This is really a widespread problem on syzbot: a lot of USB devices
use similar code calling usb_control_msg() to read from the device and
not checking that the buffer is fully initialized.

Greg, do you know how often usb_control_msg() is expected to read less
than |size| bytes? Is it viable to make it return an error if this
happens?
Almost nobody is using this function correctly (i.e. checking that it
has read the whole buffer before accessing it).

> >> causing the access to be skipped.  Or am I missing something?
> >
> > Yes. You can get half the MTU. We have a similar class of bugs
> > with MAC addresses.
>
> Right.  And probably all 16 or 32 bit integer reads...
>
> Looking at the NCM spec, I see that the wording is annoyingly flexible
> wrt length - both ways.  E.g for GetNetAddress:
>
>   To get the entire network address, the host should set wLength to at
>   least 6. The function shall never return more than 6 bytes in response
>   to this command.
>
> Maybe the correct fix is simply to let usbnet_read_cmd() initialize the
> full buffer regardless of what the device returns?  I.e.
>
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index dde05e2fdc3e..df3efafca450 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -1982,7 +1982,7 @@ static int __usbnet_read_cmd(struct usbnet *dev, u8=
 cmd, u8 reqtype,
>                    cmd, reqtype, value, index, size);
>
>         if (size) {
> -               buf =3D kmalloc(size, GFP_KERNEL);
> +               buf =3D kzalloc(size, GFP_KERNEL);
>                 if (!buf)
>                         goto out;
>         }
> @@ -1992,7 +1992,7 @@ static int __usbnet_read_cmd(struct usbnet *dev, u8=
 cmd, u8 reqtype,
>                               USB_CTRL_GET_TIMEOUT);
>         if (err > 0 && err <=3D size) {
>          if (data)
> -            memcpy(data, buf, err);
> +            memcpy(data, buf, size);
>          else
>              netdev_dbg(dev->net,
>                  "Huh? Data requested but thrown away.\n");
>
>
>
>
> What do you think?
>
> Personally, I don't think it makes sense for a device to return a 1-byte
> mtu or 3-byte mac address. But the spec allows it and this would at
> least make it safe.
>
> We have a couple of similar bugs elsewhere in the same driver, BTW..
>
>
> Bj=C3=B8rn



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
