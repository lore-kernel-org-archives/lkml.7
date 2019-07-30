Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F5C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C98205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0wh7sV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfG3O2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:28:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51646 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfG3O2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:28:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so57392704wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=drd2LNgj2u9n38kicYZLHSfSh0oWvDUVZyGUG2VJqr0=;
        b=I0wh7sV7Cx3IpITr4GHeKMa23hytZP0JMl1EgCUzYsdsJD0aU7BqagmuSep7vB3QwQ
         FmCb1oxMnT2mJ4h8pWSBnGmuI6Yqso21kPc9Uvp1yEKPka2JkdYxBN2gKyVLqeUpzRd+
         0juG+wDLUllnR3Hu8srp10tIvP03sjQiADQTzEC89VwZa5FakbdkTqOGHCT1swRZazEB
         7bmcrDeN14qzlvjuYLLVpNr6T2w2wLHHPuna6zuh6Oza7PTBJqh9Acm7wzG0bEREWoCX
         Uv/xWlkOIku5P896JXFnq4ggbQBwwMT3Vv9d0StWjmX1zxsFFvV6anKviwNDgI6C1DP8
         h9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=drd2LNgj2u9n38kicYZLHSfSh0oWvDUVZyGUG2VJqr0=;
        b=ZGliaotDSftZaqamX4oODOH6G2SBbgy+PhZgeDQkW40X2ukyFT0aP7xwsv0T9xQ7+z
         nIEdzXj90DXBYM02ZVX36SaKKYCfGnqeGXAhBRCyTQUICtSdtt1pOKmGBR+eRVNoRfbG
         s9Ii7LSBWiMi+QCNZ+gHYzIHWzYI1a+8fRBjNIk7ii18NN/IeinN2ANfwk47SiZRrkTi
         tv49ugmM/tnRM9KaUv5IwOeY4B8+IigP/oMkY7SMyA5sxFUaJUWsfnTejMqlDgO3rPLc
         2M/VnwgU8Go20G0aQVlL1uE7n9wV5zc5cj4YxIIdqp4/0dVfUwOkdwsZrmaV3cfIC5M/
         t74g==
X-Gm-Message-State: APjAAAUWPlmvVnrXdNCEoO9u7PP/HVo1TvIm+6M2e2LEnso3lYjeox79
        sE2I28eb4a38yfCiLYd3W/OC3QSB/g4X2gBg54iGcg==
X-Google-Smtp-Source: APXvYqwNQph3+WP4wHWEnFcQvKMAPHapuue2F4bVj/8qJxiAU7k1P9fbW9Mp30FpN8ondlpPukDfXy0jbCMN4Vg8Ng8=
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr105995463wmd.131.1564496924133;
 Tue, 30 Jul 2019 07:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014c877058ee2c4a6@google.com> <Pine.LNX.4.44L0.1907301011100.1507-100000@iolanthe.rowland.org>
 <CAAeHK+wnhfMvoMbuv3Oco1eH35BL5tdR9-X5erEJmKLS1finAg@mail.gmail.com> <CAAeHK+z50rsvQypF5AivYJh0wQ04XAueC=Ms2cPt3+QuN1+KGg@mail.gmail.com>
In-Reply-To: <CAAeHK+z50rsvQypF5AivYJh0wQ04XAueC=Ms2cPt3+QuN1+KGg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 30 Jul 2019 16:28:31 +0200
Message-ID: <CAG_fn=XOZVRkG+RLRsfn2Y4JNz+ovyjkA=Jf9TK5ttunmuNvmA@mail.gmail.com>
Subject: Re: KMSAN: kernel-usb-infoleak in pcan_usb_pro_send_req
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 4:22 PM 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Tue, Jul 30, 2019 at 4:20 PM Andrey Konovalov <andreyknvl@google.com> =
wrote:
> >
> > On Tue, Jul 30, 2019 at 4:17 PM Alan Stern <stern@rowland.harvard.edu> =
wrote:
> > >
> > > On Tue, 30 Jul 2019, syzbot wrote:
> > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_wa=
rn_rate..
> > > > git tree:       kmsan
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13e9518=
3a00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D40511ad=
0c5945201
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D513e4d098=
5298538bf9b
> > > > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > > > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17eaf=
a1ba00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17b8798=
3a00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the =
commit:
> > > > Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
> > > >
> > > > usb 1-1: config 0 has no interface number 0
> > > > usb 1-1: New USB device found, idVendor=3D0c72, idProduct=3D0014,
> > > > bcdDevice=3D8b.53
> > > > usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=
=3D0
> > > > usb 1-1: config 0 descriptor??
> > > > peak_usb 1-1:0.146: PEAK-System PCAN-USB X6 v0 fw v0.0.0 (2 channel=
s)
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50
> > > > drivers/usb/core/urb.c:405
> > >
> > > What does "kernel-usb-infoleak" mean?
> >
> > That means that the kernel put some uninitialized data into a request
> > that was sent to a USB device.
>
> Here's a better report for this bug:
Yes, for some reason syzkaller lost half of the original report when
reproducing the bug.
> https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D11dae8ec600000
>
> This is a real bug, I was able to reproduce it with a hardware
> reproducer and leak some kernel pointers AFAIR.

> >
> > >
> > > Alan Stern
> > >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CAAeHK%2Bz50rsvQypF5AivYJh0wQ04XAueC%3DMs2cPt3%2BQuN1%2BKG=
g%40mail.gmail.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
