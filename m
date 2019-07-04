Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F8FC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C28E21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDeGfm7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGDN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:29:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43391 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfGDN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:29:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so2951716pfg.10;
        Thu, 04 Jul 2019 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9nYYPGFN2sur273z7hz65ldIN9k8hRrfQwOs933zXk=;
        b=WDeGfm7y9Z5pD5tfAOROWbXklf+ZhVhBMBbKxHjzDqIOadUbWYkwKM8nJjPHF9lxZY
         8z12rV73sM7U+heuw1WFMDG4gKL8uV/GRYcmjDJAIaopAFXr85GqoG+wpG5Dk9NfGKrh
         AylgSUM8DaB+RPtpoz9Cl+xLpJIFtGQgYsDiSD9DesY81Ity0aDKa599O5PFCDBZmLJx
         8AuUfKOgbwdf8TYH61WTddtVAoH8w6q/W/ZHyYAGatgAYyn3rdSvLjPOSvvE97qQL8Rw
         yYDRB7enaUgrK2nx3LTJyYuAhAvIbMd4trJh23hOR2O+aUaT5nmfjdoDP2ajLK9lU1Wm
         ks9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9nYYPGFN2sur273z7hz65ldIN9k8hRrfQwOs933zXk=;
        b=QuPr25Eok+pFDhJrkInYJYWpjeOmGvloqtajAHCgAvu9vRZ9+omFemjD/abCiDousn
         1ySwp5R/nw75xKQs3+sdwVT+6S1gTFYc4kNZDbFBxrbvk8iM3nSJqjkNtxJTljciJBZA
         XOG0E2fKLIEID1Pefb6nPsuDK/gJA9vnIGq1tPj0O70w8jujV2zZpERhCYZk99bWjGMF
         xhCZNc35L2WJRiM1jJHuJclK3IM312sY+GS2wMCazd4dg38mwZ4o4z+pkpQnYmJiC/YI
         NKwNEDm1RR4cLzbRDGyF6ndll+krC2L4WJIgw+YARBjHaZGZGBi3vbyz3XDZcf6ngVQm
         lEsA==
X-Gm-Message-State: APjAAAUvu9k0wJ/5dDK/ejURLeFOGoh+3/0aMqt75EfX613vBm3GIO2R
        Hvq0o/Azy1E7IFmaVBhBi2EDJjnYTyOZkixbnDo=
X-Google-Smtp-Source: APXvYqy7Gj9e13Isl7g2mz8ctwnskLJ4/FWL693f2FT9yYL9DiNq8ur1erA5fQUIsvg0VaynGRSJ+6MRp+TyMuxDH1Q=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr24862233pgc.74.1562246991813;
 Thu, 04 Jul 2019 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190704084617.3602-1-gregkh@linuxfoundation.org> <20190704084617.3602-8-gregkh@linuxfoundation.org>
In-Reply-To: <20190704084617.3602-8-gregkh@linuxfoundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jul 2019 16:29:40 +0300
Message-ID: <CAHp75Vd7+Kg0paJ-eMNR2_AViW3mYgOCUqqPXS=eT8eY_J6xZA@mail.gmail.com>
Subject: Re: [PATCH 07/11] video: fbdev: wm8505fb: convert platform driver to
 use dev_groups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 11:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a sysfs file.
>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org

Is it correct Cc list? Looks like a typo to me.

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/video/fbdev/wm8505fb.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
> index 8f0d5379861d..3b826da97035 100644
> --- a/drivers/video/fbdev/wm8505fb.c
> +++ b/drivers/video/fbdev/wm8505fb.c
> @@ -184,6 +184,12 @@ static ssize_t contrast_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(contrast);
>
> +static struct attribute *wm8505fb_attrs[] = {
> +       &dev_attr_contrast.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(wm8505fb);
> +
>  static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
>  {
>         chan &= 0xffff;
> @@ -369,10 +375,6 @@ static int wm8505fb_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       ret = device_create_file(&pdev->dev, &dev_attr_contrast);
> -       if (ret < 0)
> -               fb_warn(&fbi->fb, "failed to register attributes (%d)\n", ret);
> -
>         fb_info(&fbi->fb, "%s frame buffer at 0x%lx-0x%lx\n",
>                 fbi->fb.fix.id, fbi->fb.fix.smem_start,
>                 fbi->fb.fix.smem_start + fbi->fb.fix.smem_len - 1);
> @@ -384,8 +386,6 @@ static int wm8505fb_remove(struct platform_device *pdev)
>  {
>         struct wm8505fb_info *fbi = platform_get_drvdata(pdev);
>
> -       device_remove_file(&pdev->dev, &dev_attr_contrast);
> -
>         unregister_framebuffer(&fbi->fb);
>
>         writel(0, fbi->regbase);
> @@ -402,6 +402,7 @@ static const struct of_device_id wmt_dt_ids[] = {
>  };
>
>  static struct platform_driver wm8505fb_driver = {
> +       .dev_groups     = wm8505fb_groups,
>         .probe          = wm8505fb_probe,
>         .remove         = wm8505fb_remove,
>         .driver         = {
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
