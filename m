Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC47C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6FC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="u6bjfZ05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfC0OAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:00:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43216 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0OAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:00:37 -0400
Received: by mail-io1-f68.google.com with SMTP id x3so14131541iol.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4eaYV44n02KoZ86ikbKAtTZ/w88VzhWRtMepkedVXAE=;
        b=u6bjfZ055Sdk+C1Gbi6ow0CJe/01XeGjX+juwOpnaRogRV3vU95JmhCGiO2C0XExNw
         9WMEjv+Uazj8oOwxFclQMsFqCBsoDCwY98nSij0rh0KxE7g92y3F6XE/s1+gyj09jtCc
         h0v9FJU5y1yBhqvg57LKqe44KC5qzCpDxFqWTIoToUDowpHt9E05aGQZgKf56ioHk8pd
         K5CPzqFUJwjuPlkzMFSeaKB7SPbcBu72mo1XTs4zuKEdU4uEcw0Q18saSBeVZCmhFwt0
         +tBPBTpb+jgail6gWDoA2NoXTJ1/8RH+1rR4DimaYzSzBdHlIr5UAs3f7zAveJF3qd+c
         LymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4eaYV44n02KoZ86ikbKAtTZ/w88VzhWRtMepkedVXAE=;
        b=JJkPg/2OwYGjixVnzdKLPNvtIoN8gaOhkjSJjU3GRZkotIRz/c+TN+Zdpxuul06MYq
         t3Xtnmmrej0yglDAMZChgO3xeTDkk3BdLAm96wq9c1qA2QIZOgA2zv/fymdTRdFRt79i
         a/eEGW4dr+hpMLsPq10rcXwYY2aTskteVLMiYEx8ronduIAUSA6J4TizbOGvjiq/APv6
         SfGdR6RGi0svwGQtEygbHfcfheY+tCbdObGcEi8GmA9/Yga1Kk2U32UJAh1Dnj38F8d9
         6EUNgzdqGSSXdgd7DjM8EOOyQMCJtz/m3o0+GJqb0EAMWvcuAa6u8nF7/RNQ5GWuHagl
         8EnQ==
X-Gm-Message-State: APjAAAXBZFnQB7yVVNZfYdP/ZlgbSyeiFM67vti3kdCKfdn6Uo13li+I
        /iLNjaM0bCMDZNol3PVVq/kAjZx2c38g7YS1tmf/yw==
X-Google-Smtp-Source: APXvYqyZn9f9ZLF+ivoNUFFH5WtiNf80R21MeNYA8vPfKLozCSmQvLfd+94wrmHQMbl2yyA6uGCY0YnxdAOI+t6O2RQ=
X-Received: by 2002:a6b:6e0f:: with SMTP id d15mr27150695ioh.111.1553695236662;
 Wed, 27 Mar 2019 07:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190325135557.3423-1-axel.lin@ingics.com> <CAMRc=MfvguEhfqXBWa8o12WF6xbHM7yEiOZC+N01UDAQYQs7Zg@mail.gmail.com>
 <CAFRkauAkN=QAdqF4Qrq=PRS29yifLegrjPTU2=ngZtrkLbY58w@mail.gmail.com>
 <CAMRc=MeN4W3iOc5+t+9b7knRJVx8vA+eb95bRHFBGZJvC0ffuQ@mail.gmail.com> <CAFRkauDMj_5p7yviNYsymj7P_qPfFC1crhiP5ouwEnp7jt_rPg@mail.gmail.com>
In-Reply-To: <CAFRkauDMj_5p7yviNYsymj7P_qPfFC1crhiP5ouwEnp7jt_rPg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 27 Mar 2019 15:00:25 +0100
Message-ID: <CAMRc=McRKEP1ro4tWkXbyJKRJeaab9HL1r4cj9H9XBjjA2r6vA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable
 linear range
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 mar 2019 o 14:56 Axel Lin <axel.lin@ingics.com> napisa=C5=82(a=
):
>
> Bartosz Golaszewski <brgl@bgdev.pl> =E6=96=BC 2019=E5=B9=B43=E6=9C=8827=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:08=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > =C5=9Br., 27 mar 2019 o 11:17 Axel Lin <axel.lin@ingics.com> napisa=C5=
=82(a):
> > >
> > > > Hi,
> > > >
> > > > what tree is this patch based on, because it doesn't apply on top o=
f v5.1-rc2.
> > > Hi Bart,
> > > You can use linux-next or regulator tree.
> > > However,  due to build dependency you need to manually apply max77650
> > > mfd drvier manually  because it's not exist in these tree.
> > >
> > > Alternatively, you can check the difference of your tree with
> > > linux-next regarding max77650-regulator.c changes.
> > > Then pickup related patches first so you can cleanly apply this patch=
.
> > >
> > > Regards,
> > > Axel
> >
> > Can you push a branch you used somewhere public? It'll be faster that w=
ay.
> I don't have public git tree for linux-kernel.
> I think you should try linux-next tree, this patch can be applied to linu=
x-next.
> Other missing files should be all your patches:
> https://patchwork.kernel.org/cover/10809945/
>
> Regards,
> Axel

What do you mean you don't have a public git tree? Can't you create a
gitlab account and just push the tree there? Alternatively, given the
amount of patches you send, I doubt the kernel.org maintainers would
refuse if you asked for an account.

Frankly, this week is quite busy for me, so if you want me to play
with pulling random patches, then the test will have to wait until
next week.

Best regards,
Bartosz Golaszewski
