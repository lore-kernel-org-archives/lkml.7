Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF2520811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L+CH6hrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCMNZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:25:00 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:38600 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:24:59 -0400
Received: by mail-it1-f176.google.com with SMTP id k193so2803004ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rPxTEzqdND7tXogwvkstTPqUI10vrZG5bl4hmfU6CkY=;
        b=L+CH6hrckGEQGLcyAvii5uRlLTEe9k0/OP3bS8dR9zjT4UikO7q9Z8wJMJSJjP3uAC
         UPdMGsw2QiILJ7LW7nm71lioO2v3HPA8KCnm6jh/gQK9Z8DeM5ufi0yxsKveIO9k9Sh7
         +TsdxVCLHu6Mg8P40DFMTyZlJcTY/Wl7LKzVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rPxTEzqdND7tXogwvkstTPqUI10vrZG5bl4hmfU6CkY=;
        b=c+/4o39JjBUkY/B/APcwQtOPIszMiv96mxqynSw9SNv319IEFvUvyl+ji1YJMBNRDX
         wxS1X12iRvBLSK/jiXKXcgA0e1FcyC6Di54P1KKBm5YXH0x1NQ2y6kWLMWjV9IDKiQae
         syqeGRBYEfxgpxwtWy+W9EhFF16BBUNQIC1gS2Of9+AL9NtGOi/zGa3dYFxyxlPhF6SO
         Rs9qfPJC+ul6ADjlMKNmopS1aCWGOac5Zmy3YJCkKdWSCfVpeI/pm2wL2mLUnL5zHxPB
         4GB4GEAluXgLuS6Irii2bujVGNf112h1ZZrkVcfNrNeGfqhEJcqcNaD1nyje8kxT6TXo
         kP5Q==
X-Gm-Message-State: APjAAAWN08GYh6tGMHw9luQ0xHECsPErtdcIY7HK29mcey+lfs7TyP9K
        PMFd80GbNCMRDEkVjzik1q6kUAMp1Yd791MbBe1cCw==
X-Google-Smtp-Source: APXvYqymRVLVsLh59LMPopHl60sLOeMxsVDauWEPUtQIXarUrqSu5w7Oii7MiV8KgdYSByNsYZ/t3OsdQweY7FdX/pY=
X-Received: by 2002:a24:4161:: with SMTP id x94mr1627411ita.69.1552483498279;
 Wed, 13 Mar 2019 06:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <4603533.ZIfxmiEf7K@blindfold> <1852545.qrIQg0rEWx@blindfold>
 <CAJfpegvrG4LfnuC62JNtdXpCf4vb+aEiDre5YCxe7xUSQP8yjw@mail.gmail.com> <1854703.ve7plDhYWt@blindfold>
In-Reply-To: <1854703.ve7plDhYWt@blindfold>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 Mar 2019 14:24:47 +0100
Message-ID: <CAJfpegtgfuAkgv26QH6Ht25OeMiev-QvEf7ror4KAbud7FADgg@mail.gmail.com>
Subject: Re: overlayfs vs. fscrypt
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 2:00 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Mittwoch, 13. M=C3=A4rz 2019, 13:58:11 CET schrieb Miklos Szeredi:
> > On Wed, Mar 13, 2019 at 1:47 PM Richard Weinberger <richard@nod.at> wro=
te:
> > >
> > > Am Mittwoch, 13. M=C3=A4rz 2019, 13:36:02 CET schrieb Miklos Szeredi:
> > > > I don't get it.  Does fscrypt try to check permissions via
> > > > ->d_revalidate?  Why is it not doing that via ->permission()?
> > >
> > > Please let me explain. Suppose we have a fscrypto directory /mnt and
> > > I *don't* have the key.
> > >
> > > When reading the directory contents of /mnt will return an encrypted =
filename.
> > > e.g.
> > > # ls /mnt
> > > +mcQ46ne5Y8U6JMV9Wdq2C
> >
> > Why does showing the encrypted contents make any sense?  It could just
> > return -EPERM on all operations?
>
> The use case is that you can delete these files if the DAC/MAC permission=
s allow it.
> Just like on NTFS. If a user encrypts files, the admin cannot read them b=
ut can
> remove them if the user is gone or loses the key.

There's the underlying filesystem view where admin can delete files,
etc.   And there's the fscrypt layer stacked on top of the underlying
fs, which en/decrypts files *in case the user has the key*.  What if
one user has a key, but the other one doesn't?  Will d_revalidate
constantly switch the set of dentries between the encrypted filenames
and the decrypted ones?  Sounds crazy.  And the fact that NTFS does
this doesn't make it any less crazy...

Thanks,
Miklos
