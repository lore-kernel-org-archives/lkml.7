Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F2206A4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pCLRaYgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfKTLZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:25:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43963 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfKTLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:25:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id p14so955576qkm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rJPYiGKXpEMNQLJlyZqBJR8+8IIXsVVFLlcxm67gekc=;
        b=pCLRaYgg3Nv9opD/ko9q/x57IFuehCW8B0R9iex/5I6WfuOqky5d77IUALMAELT9w0
         pJc4AMzQ0WmWwsNoIE+6T0FbGI2vwggfY7Fj/IcDyselUqQfocP6+wGxPE9X+qNog/Uo
         y9iVORvDU5Qqijr6mVptLft/uRq443mEtBSqOKULLQfrHwRWynJGkiRmAwq9I2OfQuoM
         MpJCf7VpO9CMLZBey4HByRtgDU5qOi9psxPQH/QFCqrvxG1ioo1uqgzbrXjeOHIC1qzk
         JRqtHgqj3XWLCarXZ9b+K0i/2lb+8PmmEE6SmMWQ3x5qyqyZMQc5XRSNxwNdSJxHhzjD
         pVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rJPYiGKXpEMNQLJlyZqBJR8+8IIXsVVFLlcxm67gekc=;
        b=M+jfRQjqAR8xea21iMx0aakkPknMEqoCg8NTcjm6fOgwxJ3JVoIKa0aFfnYCqPpjWW
         CcURtrolYloKaJjsYBgVZ5YPQ4JiO8jd41ZXnZa4vLSu6+RJWniJ5xR3HD8Kj5YM9sD2
         ipNHUK4Rotfp4monFvSn2aLOAsoEI49DJ7WUnlj8xixThrEqE6TSA32w1TZTGxcbCU+2
         KuEk0eCV1d0tcHbMb8Woe0GFpdTx/hdnwdet9LXCMOmPF/9NpE08Wsk/AOMkHzPwMldm
         F89IO8oH3QpjTwqnPJ1VhgrZzNCDEV3v32A9vlB1o5pJH6tdWsZZoSlrFgRxjkhf5i/C
         r4Yw==
X-Gm-Message-State: APjAAAVWbAlmfntZPBoFLnXKyW6yiCoPY1M3y4ZQzvYwLinPes45g4An
        apDyY4EzesKHCIduL6zY0Gq5WVyjRo0QsobaPrHofg==
X-Google-Smtp-Source: APXvYqzRemX2gUI2dfzg9EB4iJ4ZW+AQz1OyJ3lVN80mBtOXR9+mvOOYM4TxKoQkM3DSiazNgDrC0xmNwDkyfBYXPzk=
X-Received: by 2002:a37:6156:: with SMTP id v83mr1789842qkb.43.1574249102312;
 Wed, 20 Nov 2019 03:25:02 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d9a391059713dc1f@google.com> <20191111160950.GA870254@kroah.com>
 <1574248737.14298.33.camel@suse.com>
In-Reply-To: <1574248737.14298.33.camel@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Nov 2019 12:24:50 +0100
Message-ID: <CACT4Y+ZQK4knKqPxESGspc1gBNA6rMTPW=28j3W-oexcyRRepw@mail.gmail.com>
Subject: Re: BUG: bad host security descriptor; not enough data (4 vs 5 left)
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg KH <greg@kroah.com>,
        syzbot <syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:19 PM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Montag, den 11.11.2019, 17:09 +0100 schrieb Greg KH:
> > On Mon, Nov 11, 2019 at 07:34:08AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    3183c037 usb: gadget: add raw-gadget interface
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12525dc6e=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D79de80330=
003b5f7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd934a903634=
6e0215d8f
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14ac740=
6e00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13eea39ae=
00000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
> > > Reported-by: syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com
> > >
> > > usb 1-1: config 0 interface 0 altsetting 0 has 3 endpoint descriptors=
,
> > > different from the interface descriptor's value: 4
> > > usb 1-1: New USB device found, idVendor=3D13dc, idProduct=3D5611,
> > > bcdDevice=3D2f.15
> > > usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=
=3D0
> > > usb 1-1: config 0 descriptor??
> > > hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> > > hwa-hc 1-1:0.0: FIXME: USB_MAXCHILDREN too low for WUSB adapter (194 =
ports)
> > > usb 1-1: BUG: bad host security descriptor; not enough data (4 vs 5 l=
eft)
> > > usb 1-1: supported encryption types: =EF=BF=BDS =D0=81=EF=BF=BD=EF=BF=
=BD=EF=BF=BD|c =D0=81=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDc =D0=81=EF=BF=BD=
=EF=BF=BD=EF=BF=BD
> > > usb 1-1: E: host doesn't support CCM-1 crypto
> > > hwa-hc 1-1:0.0: Wireless USB HWA host controller
> > > hwa-hc 1-1:0.0: new USB bus registered, assigned bus number 11
> >
> > wusb code, hah.  It's about to be deleted from the kernel because no on=
e
> > uses it and there is no hardware out there.  I wouldn't spend a ton of
> > time fuzzing it.
> >
> > One more good reason to just delete it soon...
>
> Unfortunately that is not an option for the stable trees. Before I try
> something quick and dirty here, I have a question for the testing team.
>
> What exactly crashed? There is nothing in the logs? Did you undergo
> an absolute freeze of the machine? Or do you tested for the word "BUG"
> in the logs?

Hi Oliver,

Yes, it's the "BUG:" on the console that's detected as kernel bug
(what's being produced by BUG_ON).

There are only 2 special bug types in syzkaller that are detected
based not on kernel output matching:
"lost connection to test machine":
https://syzkaller.appspot.com/bug?id=3Db97ec15bfe317ac1ddccb41f2a913d4f7a31=
c6d7
and "no output from test machine":
https://syzkaller.appspot.com/bug?id=3D0b210638616bb68109e9642158d4c0072770=
ae1c
(hopefully self-explanatory from the title).

The rest are based on output matching and what's matched is pretty
much the bug title/email subject.
