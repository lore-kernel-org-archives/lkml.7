Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10EBC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774C32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfEuXg6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfKYPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:14:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35060 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728172AbfKYPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574694886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsViNUF8R5vNPI8HMF3+qgqlgoEtqHxa8xpNMwJsggY=;
        b=VfEuXg6B+36Xrcn6WpKnMMauy8CU10tnvyA3+RzZ69RgDjjQZ9QCI9EgU3e4kzV0vDvha9
        P8cH7ucbSz2LClDiVJAC2qFt3D9d9oxUrtTQBCiW84BRAw6m0EZHJDssjDUnoz3LkeqawM
        s1xzQJFd5gOJqobbqy4RGDlMkHY+iU8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-iBGJcOFXPhmAGMFXlhoblA-1; Mon, 25 Nov 2019 10:14:43 -0500
Received: by mail-qt1-f198.google.com with SMTP id f31so10454331qta.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8eb8wa21YsOeZ9EHNPAieCGqRK3RoFp6IWeODBsRdM=;
        b=kNK41jE2civhyhpv2vuIXAvy+dyi3kHIpOEKkBgTH2Ul9eItU2Rg/qHfh9oTv0MX/9
         jTdVKIqXyOHF6jxBp6BDtUt9nlOwkQ2JwF5Mr8DbWq2WEq5shPbqd5fspVoQcFcNQxJF
         qzjxs7sh28vPTfYRehma49WkSEU/L02FEqLUs/ccJ06MDEdxqWVFJxKDCQCnzsRa+3RI
         NKfN5juKa4meajF5y0f9FkuqMDWS7kcCd5y+5HU3XGBtDvWcf29jVhoWMz7L79SONHdx
         Izc2Fx6YM9D8f0A+YCTqhhK5s7fjMrni5ZWF/7ghOsWk4dVinx4DfuZ8X7ZEvE4eB3Eb
         CutA==
X-Gm-Message-State: APjAAAVqJQFB5NgT/3PBvNe4/5L4L/zCt5McT6BYLCdh1DGVwaF9SfEy
        Xu6bE+7Rt7CJ10MNrtPs8C7md17yEEgOUmIeY/h3lzx29mg2sJuyzZk0cKidhFgvC7puUNPYyAC
        3+TIf7rN4dKFrMBJMAErpkUYLABqfd9cinPcTnOiK
X-Received: by 2002:a0c:e085:: with SMTP id l5mr28250895qvk.138.1574694883176;
        Mon, 25 Nov 2019 07:14:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqz231nFYrEpCOtVtPCVvxtw8KqhWa9u2D2TL5w9YZ3DcpHEw3DlDKnUGv/FxcjKOG+Qo5fUmUbxnHwBsYq8Spw=
X-Received: by 2002:a0c:e085:: with SMTP id l5mr28250865qvk.138.1574694882877;
 Mon, 25 Nov 2019 07:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20191105141807.27054-1-tranmanphong@gmail.com>
 <CAO-hwJ+cydMPQE_otc8-67=SDKmjac5RXsLs-9x6dH4YqA+DVQ@mail.gmail.com> <0407e8bb-bbf5-ec64-cdac-ef266f1ab391@gmail.com>
In-Reply-To: <0407e8bb-bbf5-ec64-cdac-ef266f1ab391@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Nov 2019 16:14:31 +0100
Message-ID: <CAO-hwJ+r+n4Dy+jqSuCk-vApfP-PR4o2oTzt4XWxH5jUQOeFwA@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-lg4ff: Fix uninit-value set_autocenter_default
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot <syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com>
X-MC-Unique: iBGJcOFXPhmAGMFXlhoblA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 2:30 PM Phong Tran <tranmanphong@gmail.com> wrote:
>
> On 11/18/19 4:43 PM, Benjamin Tissoires wrote:
> > On Tue, Nov 5, 2019 at 3:18 PM Phong Tran <tranmanphong@gmail.com> wrot=
e:
> >>
> >> syzbot found a problem using of uinit pointer in
> >> lg4ff_set_autocenter_default().
> >>
> >> Reported-by: syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com
> >>
> >> Tested by syzbot:
> >>
> >> https://groups.google.com/d/msg/syzkaller-bugs/ApnMLW6sfKE/Qq0bIHGEAQA=
J
> >
> > This seems weird to me:
> >
> > the syzbot link above is about `hid_get_drvdata(hid)`, and, as I read
> > it, the possibility that hid might not have an initialized value.
> >
>
> In the dashboard [1] shows
> BUG: KMSAN: uninit-value in dev_get_drvdata include/linux/device.h:1388
> [inline]
> BUG: KMSAN: uninit-value in hid_get_drvdata include/linux/hid.h:628 [inli=
ne]
> BUG: KMSAN: uninit-value in lg4ff_set_autocenter_default+0x23a/0xa20
> drivers/hid/hid-lg4ff.c:477
> base on that I did the initialization the pointer in the patch.
>
> > Here you are changing the initialized values of value, entry and
> > drv_data, all 3 are never used before their first assignment.
> >
> > I have a feeling this particular syzbot check has already been fixed
> > upstream by d9d4b1e46d95 "HID: Fix assumption that devices have
> > inputs".
> >
>
> I think the commit d9d4b1 fixed this report [2] by syzbot.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D1234691fec1b8ceba8b1
> [2] https://syzkaller.appspot.com/bug?extid=3D403741a091bf41d4ae79

As you can see in my long discussion with syzbot today, d9d4b1 also
fixed that one.

https://groups.google.com/forum/#!msg/syzkaller-bugs/ApnMLW6sfKE/Qq0bIHGEAQ=
AJ

Cheers,
Benjamin

>
> regards,
> Phong.
> > Cheers,
> > Benjamin
> >
> >>
> >> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> >> ---
> >>   drivers/hid/hid-lg4ff.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> >> index 5e6a0cef2a06..44dfd08b0c32 100644
> >> --- a/drivers/hid/hid-lg4ff.c
> >> +++ b/drivers/hid/hid-lg4ff.c
> >> @@ -468,10 +468,10 @@ static int lg4ff_play(struct input_dev *dev, voi=
d *data, struct ff_effect *effec
> >>   static void lg4ff_set_autocenter_default(struct input_dev *dev, u16 =
magnitude)
> >>   {
> >>          struct hid_device *hid =3D input_get_drvdata(dev);
> >> -       s32 *value;
> >> +       s32 *value =3D NULL;
> >>          u32 expand_a, expand_b;
> >> -       struct lg4ff_device_entry *entry;
> >> -       struct lg_drv_data *drv_data;
> >> +       struct lg4ff_device_entry *entry =3D NULL;
> >> +       struct lg_drv_data *drv_data =3D NULL;
> >>          unsigned long flags;
> >>
> >>          drv_data =3D hid_get_drvdata(hid);
> >> --
> >> 2.20.1
> >>
> >
>

