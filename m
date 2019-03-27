Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE400C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7519B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="i4uee/3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfC0N47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:56:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0N46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:56:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so18747090wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fMFckguZXgCBh2fpmiV31UdhKalYHOcjL3vXDHS62ac=;
        b=i4uee/3qY6/Fdun+6Ou2KORn/mkm/aI6SYSrLDD4jQ4F9QKSNfl73qpSIEo19E3tUR
         6s85ThT2p5a4DFdC1CIy0W+oM8Qm/Gb5ZQ24w4fmEt9QNv18A0QGECe8G0A2jt7G5S/I
         TrMHYqH1Y3eoQ9y5E8YQQ8xjDB/DkNVT5AFSvWUKd79Mk51jLQAInde1hn3WYnGDKcMA
         joAghfRlg66MyqKZcouu4dlLsr01YJj8fZ1NG4pUvhYoLWKQUCUuUdiT2QfaD/FvQz5N
         15F3yiAWiI/9FjXcKP6iM1vO117qRU2h725/vF+ggBnIHouBsjmK/XkJUpPM392NNQN6
         eUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fMFckguZXgCBh2fpmiV31UdhKalYHOcjL3vXDHS62ac=;
        b=kmVuYU8aK0TetDyIsG4DaUfoweOjK/dahJebH5vxXtbuvdoAhs0iIkVuBoX5LSnJGH
         61Z6HwsqhqRduZ6zB43taaP3KJbnSPbGJmxs21l3cqm8D7/rFguodG0gMP+F6jqDcZ4p
         v0Jf27yV1rMC+SeAZenwncye7qf7MI/9BYksG7amtlr77fqbNCYdN/Fxr7Yu3PRcBAUq
         VBkomxr1kXANJ3aTp/nxr8vIFSoKZdsah8/2K3HhzW7lu8FhEnVW9rc0+xFpPLel36KW
         95p9TunkOs5iJ+UYjTGpN2h6kmI6AWwhJECms3gYDrYX9LRTJJ5Nj9gD4Nasc7DzCT8v
         hYpA==
X-Gm-Message-State: APjAAAX6BLj5i9Bm7smpxAZSbe0l0IL4D1Agquh2x/XlWe95FQUUc1T4
        svQ+iUxrjDbc+nKgnbroyA4ILzm8oH+DyYqvTghEmA==
X-Google-Smtp-Source: APXvYqwT5MkYaQ4ChB11wkDt6bZo+H8iOQXHDlQlkNKa0G5POZGqnMo+fOm1exkiUBQN8tM8DegEjioK92VjpBUvEeo=
X-Received: by 2002:adf:d081:: with SMTP id y1mr23272401wrh.283.1553695017236;
 Wed, 27 Mar 2019 06:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190325135557.3423-1-axel.lin@ingics.com> <CAMRc=MfvguEhfqXBWa8o12WF6xbHM7yEiOZC+N01UDAQYQs7Zg@mail.gmail.com>
 <CAFRkauAkN=QAdqF4Qrq=PRS29yifLegrjPTU2=ngZtrkLbY58w@mail.gmail.com> <CAMRc=MeN4W3iOc5+t+9b7knRJVx8vA+eb95bRHFBGZJvC0ffuQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeN4W3iOc5+t+9b7knRJVx8vA+eb95bRHFBGZJvC0ffuQ@mail.gmail.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 27 Mar 2019 21:56:45 +0800
Message-ID: <CAFRkauDMj_5p7yviNYsymj7P_qPfFC1crhiP5ouwEnp7jt_rPg@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77650: Convert MAX77651 SBB1 to pickable
 linear range
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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

Bartosz Golaszewski <brgl@bgdev.pl> =E6=96=BC 2019=E5=B9=B43=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> =C5=9Br., 27 mar 2019 o 11:17 Axel Lin <axel.lin@ingics.com> napisa=C5=82=
(a):
> >
> > > Hi,
> > >
> > > what tree is this patch based on, because it doesn't apply on top of =
v5.1-rc2.
> > Hi Bart,
> > You can use linux-next or regulator tree.
> > However,  due to build dependency you need to manually apply max77650
> > mfd drvier manually  because it's not exist in these tree.
> >
> > Alternatively, you can check the difference of your tree with
> > linux-next regarding max77650-regulator.c changes.
> > Then pickup related patches first so you can cleanly apply this patch.
> >
> > Regards,
> > Axel
>
> Can you push a branch you used somewhere public? It'll be faster that way=
.
I don't have public git tree for linux-kernel.
I think you should try linux-next tree, this patch can be applied to linux-=
next.
Other missing files should be all your patches:
https://patchwork.kernel.org/cover/10809945/

Regards,
Axel
