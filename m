Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAC1C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33D72171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcWgpNxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbfHHMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:44:12 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42986 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:44:12 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so117963996otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqsGEn8rizmWX1sBUGJyfxqTVFx/hWSppDVhCUizhj0=;
        b=kcWgpNxuLsqlIeN+bHKdSpfWQbrD8oiKypyumjK3k5/kzTNxb3AQoURhbCK39Sd6Tc
         P5rMBeJI3GTVUEdTjw2Ifwpj3l/nEom6Jgx4X+YL156jCBD00jAI0I2cKV8c6i+6qb8F
         vNHLcXmorSzI7Dfa7JznfKLTfoeHKpwe8gofHHK4eBqZtBBm8VahkRj+Vh+D34k1eqJ4
         tzNdqSp5Eh5zcOp37YskGxl5BSW6zxhLQk2spv9GWA6zxBMUhk7zN6Cdx0tPNVpwYqwM
         HoFcYMwR+DLfqXHfC+UrFEtIa4lsexeV32EEKVgcaTpQqHC2YOY6sHkyE1s3I9dbiFpR
         PiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqsGEn8rizmWX1sBUGJyfxqTVFx/hWSppDVhCUizhj0=;
        b=FphR4Z9vXoPaqu2n5Q8w7nTMjpdB52G1dPvJMNvc2pfOgQO0A1ffh6u8o646aSgKuI
         NXWlFF7PbLfJlXxr1MSLeoaieNUwDhPdJ/bE5T3uysv0eaYX9GcvWeCorAbLQaknhomw
         d/96s6qDKMz1pJjujEmvhkwLBSx+MFbYNtuj2BJJC2jYkHqE4bpXaP1wrKPZeUPkieEC
         Djbw1HkJioBl9dcJG97wH0uUJW39r2RigLYva9W957PLQa9zcTm3SRrehFG61hMbo5eo
         TX/vUr2Rtu0488Bck8xOi/7gLT7X7lyRBhby/BxRqx48AnFkW2nkG90estS9qzl8tHSi
         dv6w==
X-Gm-Message-State: APjAAAVtuNURjTr49XMoFh5P5ZoiSF59IeT8EeeUzxPeTsTOFcCyuxPo
        4mOpcv5SRCNd1egI3CYYx1dgvT3W7SN5sOmTFoAj7Q==
X-Google-Smtp-Source: APXvYqz+ugusoV+l//v8/73/4cQcyL006ICoTXboeoL3XHGwudUfJ2JN8AStIr71ZDFwWW7X8uEwNh8LaUB2KOzjzis=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr15137157ior.231.1565268250720;
 Thu, 08 Aug 2019 05:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f365b6058f8b07ca@google.com> <Pine.LNX.4.44L0.1908071431050.1514-100000@iolanthe.rowland.org>
 <CAAeHK+xh6h=HBEpwPB7g2=a07+zZ9zS5Cuk0Tpo_+70Bf5j9Tw@mail.gmail.com>
In-Reply-To: <CAAeHK+xh6h=HBEpwPB7g2=a07+zZ9zS5Cuk0Tpo_+70Bf5j9Tw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 8 Aug 2019 14:43:57 +0200
Message-ID: <CACT4Y+ZD=YYvLER5jDAvCbw3kBKcNkQJEJN5yFc7O6aLaFORDg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 2:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Aug 7, 2019 at 8:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, 7 Aug 2019, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch and the reproducer did not trigger
> > > crash:
> > >
> > > Reported-and-tested-by:
> > > syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com
> > >
> > > Tested on:
> > >
> > > commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=132eec8c600000
> > >
> > > Note: testing is done by a robot and is best-effort only.
> >
> > Andrey, is there any way to get the console output from this test?
>
> Dmitry, would it be possible to link console log for successful tests as well?

Yes. Start by filing a feature request at
https://github.com/google/syzkaller/issues
