Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D947C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC90206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjDPRXWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfEWISk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:18:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33156 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWISk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:18:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id w1so4630301ljw.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mYyAF+Hnh5b5m8fm6hqJdeNUx/XFi2YtL8HXbo6MIQ4=;
        b=ZjDPRXWojXAS6NqPEz8JB/OA8f1NvfH0idz/DYqPNKOIwEnxvT9rxLaT2Dtp1Z5DKO
         lc1+9om+ogwDFs8c/NxPujzlRuHpuAqwqpugZqGGmU8N+VbjkrF+V22SOt++6PSEIrI9
         qpQA9ItNygk6fuyOzlcd+RJMS03m7NUPj3dxo2Kop/7NZx4/0ddV1TSmQTRatZLOiUFB
         lfgXKMLFrTesdMiF1fPZ03rx3ze/lt+LMEShvoc2aopH7MALrcdfhiz10XdPlfAdYj0J
         ZrRhfmTygEfaaL/c73qutQ9HnNot9FX5xO12fNz8xqQjOpPNgu8ZZZgwt6eqLCjYlUM7
         o/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mYyAF+Hnh5b5m8fm6hqJdeNUx/XFi2YtL8HXbo6MIQ4=;
        b=azbwgsAPlDLdq3GG36pzjypIcs3x0lrU372MTibz6zLg6E3RkvUPqJdu5vJklPYcGB
         tg6rKCDee/vlZOyLlHRvmDHkiElP0dEBSFTgwj2sTxGPFBu+Q4KeO/Y+aV/jZXq2gTEK
         G2BJncTsf9v6pSfrCM3kjivkhTmySJme1Kzge9+KB1Wgu5XpHV12Am75SzwjOVuFVEOs
         yZ3QEvxk6+drVmkYh12vXL5bdJ5Gcc1X7uXV6s/ZavA8qJSsMRCA/zzLJXJK2ZPIUPEU
         ASXAdDLBaOztgTx3fUtlHfmBBcBWUCGW1pmZYsnIGRvEW+L076lVRsUWuuz8Eo2+11Tx
         XfGQ==
X-Gm-Message-State: APjAAAU6ZYtQ1AnBJDDFoZqLIik0N+K1X347M6hPnvZwgAWyh33sC59C
        JAHRIvCQfU2AnU+aw8grvcjU5Ur65PUS6gy6kHo=
X-Google-Smtp-Source: APXvYqzsAPpwyOgIxyKg8x8DgDkMHfvnWyh/9KO9xyg6RktSSvHLFevnN5h7MBc8VqCySevMyfohAviKSv6snXhYE2I=
X-Received: by 2002:a2e:900e:: with SMTP id h14mr28081740ljg.77.1558599518508;
 Thu, 23 May 2019 01:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com> <20190521085547.58e1650c@erd987>
In-Reply-To: <20190521085547.58e1650c@erd987>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 23 May 2019 13:48:26 +0530
Message-ID: <CAFqt6zZA32QA-6VtaKcrEtq=qkoGLHpirSvXb5wt7-wd_-74hQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Robin van der Gracht <robin@protonic.nl>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:24 PM Robin van der Gracht <robin@protonic.nl> wrote:
>
> On Mon, 20 May 2019 21:00:58 +0530
> Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > While using mmap, the incorrect value of length and vm_pgoff are
> > ignored and this driver go ahead with mapping fbdev.buffer
> > to user vma.
> >
> > Convert vm_insert_pages() to use vm_map_pages_zero(). We could later
> > "fix" these drivers to behave according to the normal vm_pgoff
> > offsetting simply by removing the _zero suffix on the function name
> > and if that causes regressions, it gives us an easy way to revert.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/auxdisplay/ht16k33.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> > index 21393ec..9c0bb77 100644
> > --- a/drivers/auxdisplay/ht16k33.c
> > +++ b/drivers/auxdisplay/ht16k33.c
> > @@ -223,9 +223,9 @@ static int ht16k33_bl_check_fb(struct backlight_device *bl, struct fb_info *fi)
> >  static int ht16k33_mmap(struct fb_info *info, struct vm_area_struct *vma)
> >  {
> >       struct ht16k33_priv *priv = info->par;
> > +     struct page *pages = virt_to_page(priv->fbdev.buffer);
> >
> > -     return vm_insert_page(vma, vma->vm_start,
> > -                           virt_to_page(priv->fbdev.buffer));
> > +     return vm_map_pages_zero(vma, &pages, 1);
> >  }
> >
> >  static struct fb_ops ht16k33_fb_ops = {
>
> Acked-by: Robin van der Gracht <robin@protonic.nl>

Miguel, Ack from Robin is missing in linux-next-20190523 when applied.
