Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3727C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A1F206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uudRipsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfHMM4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:56:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41308 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfHMM4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:56:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so49083462pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyW2erMceipu5+F3zK5iDrdeNg1j5OVxw2XccM0V1Fk=;
        b=uudRipsgcfwoVFpRdCAbA5VHfkL8DiwXzc3CXG9MgdcYAB8oOgP9Zw5M0kN2uM2MME
         T4c4vWzHOftNixTato2mzY2oluD2mchP/tRn78x3LUb3N9RSuL4E92s/CZCOq14eKni2
         CyrttUkEZqWslPyOONBhjuyVeH0V4UTcOV+RfR7BwIzQmj/fVhiMYIbVLNUo52X/rS9/
         WpzY1ja67SIsdnZ2mZJS7dOBRhXJr96kq4oCFoIu861SUg9VeUUTqx6Xt6cdWGDS/cIC
         11s7jLsye2sSkYy+WJoz0oJFf4N/MY9S8I4Nxdigx4xNwKkyOtbKUMwJrB/fZ1djeFYh
         ZOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyW2erMceipu5+F3zK5iDrdeNg1j5OVxw2XccM0V1Fk=;
        b=E+/6DtxHX0kR/JV95fZY2f2urVigjF56y92Lyh2Se5Hmwm+nIZ0gowwEAT1hdpT5mk
         fMBkvWeznBc+ulFAPqS2bIaHXa9BJBoswOqTtKx2Xhu/kmnbwVqWFaow72rmDCrGn/eb
         A5SM24zTv+M62OdGWgdNBQXmK7nX4aLjafR/K0X7LKV6FsKqYJ91QzlnPmuZc49hkJNY
         tVlFBIBWGE7OFdDGMUTTFswgx9zsZo185XGnm+67iBeXspatt3jAwQ655Fqkm5EMsTx3
         kmiVoTnEuQRFyq15SWho12+njdnlVw4FrKPKLWYUxvpSGunCZLQm0BzgQpS+Bkt18+Nh
         /reg==
X-Gm-Message-State: APjAAAXtMvBULTqSescX25UWh1Y7Rn3fKiEIP71oxXJ3ySakxSvYsccF
        yZFYy9x9XFgS/Yt3tyxqYvHQdVOeYrwwYCvcJ2xRcHu2K34=
X-Google-Smtp-Source: APXvYqzyEAzRCTSpb8f6lxsYDA4oFJPcgDBjdknx5kDmUayS0YWoPu1UlifodZNAHiF44f7+PtshPaG8+0FfBEyby+c=
X-Received: by 2002:a17:902:bb94:: with SMTP id m20mr5195508pls.336.1565700962846;
 Tue, 13 Aug 2019 05:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190429210917.GA251866@gmail.com> <Pine.LNX.4.44L0.1904301007320.1465-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904301007320.1465-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 14:55:51 +0200
Message-ID: <CAAeHK+y2G4rSCqwhuF102gNyVbGCEx6bXY=o9pGMhGNRvgjFDw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hex_string
To:     Alan Stern <stern@rowland.harvard.edu>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 4:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 29 Apr 2019, Eric Biggers wrote:
>
> > On Mon, Apr 29, 2019 at 04:07:04PM -0400, Alan Stern wrote:
>
> > > Accessing beyond the end of the descriptor.
> > >
> > > #syz test: https://github.com/google/kasan.git usb-fuzzer
> > >
> > > --- a/drivers/video/fbdev/udlfb.c
> > > +++ b/drivers/video/fbdev/udlfb.c
> > > @@ -1511,6 +1511,7 @@ static int dlfb_parse_vendor_descriptor(
> > >     char *buf;
> > >     char *desc_end;
> > >     int total_len;
> > > +   int width;
> > >
> > >     buf = kzalloc(MAX_VENDOR_DESCRIPTOR_SIZE, GFP_KERNEL);
> > >     if (!buf)
> > > @@ -1529,9 +1530,10 @@ static int dlfb_parse_vendor_descriptor(
> > >     }
> > >
> > >     if (total_len > 5) {
> > > +           width = min(total_len, 11);
> > >             dev_info(&intf->dev,
> > > -                    "vendor descriptor length: %d data: %11ph\n",
> > > -                    total_len, desc);
> > > +                    "vendor descriptor length: %d data: %*ph\n",
> > > +                    total_len, width, desc);
> > >
> > >             if ((desc[0] != total_len) || /* descriptor length */
> > >                 (desc[1] != 0x5f) ||   /* vendor descriptor type */
> > >
> > >
> >
> > Why not write just:
> >
> >                 dev_info(&intf->dev,
> >                          "vendor descriptor length: %d data: %*ph\n",
> >                          total_len, min(total_len, 11), desc);
>
> I did consider doing that.  In the end I decided adding an extra
> temporary variable made the code a little more readable.  (For some
> reason, extra recursion -- a function call embedded in a function
> argument -- seems to demand more mental effort than an extra
> temporary.  Maybe my brain is just getting old...)
>
> > Also, aren't there more out-of-bounds reads in the code just after?  It only
> > checks for at least 1 byte available, but then it reads up to 7 bytes:
> >
> >               while (desc < desc_end) {
> >                       u8 length;
> >                       u16 key;
> >
> >                       key = *desc++;
> >                       key |= (u16)*desc++ << 8;
> >                       length = *desc++;
> >
> >                       switch (key) {
> >                       case 0x0200: { /* max_area */
> >                               u32 max_area = *desc++;
> >                               max_area |= (u32)*desc++ << 8;
> >                               max_area |= (u32)*desc++ << 16;
> >                               max_area |= (u32)*desc++ << 24;
> >                               dev_warn(&intf->dev,
> >                                        "DL chip limited to %d pixel modes\n",
> >                                        max_area);
> >                               dlfb->sku_pixel_limit = max_area;
> >                               break;
> >                       }
> >                       default:
> >                               break;
> >                       }
> >                       desc += length;
> >               }
>
> Quite right.  Please feel free to submit a patch fixing all these
> problems.
>
> > Also I couldn't help but notice it's also using 'char' rather than 'u8',
> > so bytes >= 0x80 are read incorrectly as they're sign extended...
>
> As I recall, the C standard doesn't specify whether char is signed or
> unsigned; it can vary with the implementation.  However you are
> certainly correct that to ensure there is no sign extension, the code
> should use unsigned char or u8.

Hi Alan and Eric,

Have any of this fixes been submitted anywhere? This bug is still open
on syzbot.

Thanks!
