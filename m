Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767EC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RIE2jzyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfB1WXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:23:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42285 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfB1WXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:23:42 -0500
Received: by mail-lf1-f66.google.com with SMTP id p1so16481882lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtgftd5WMGLwdWpKZuUrLbmAgWOt1sYmFEGm2x+QBbY=;
        b=RIE2jzyiRxwQwUE2NIUrDU8+8CcC4A+jzPuG0P/C3KxK9xLsW49EYgFfCNA8j/tkUn
         FiFl0XLZ3FYFoQnQMs9Gc7AZExDtESduoD6r6j3h98eQZAJeTMghGMp+B9cN2OcshmLk
         tgYhB4UrY4TT1TJPOTIwJ2I2WYVM86QePgyNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtgftd5WMGLwdWpKZuUrLbmAgWOt1sYmFEGm2x+QBbY=;
        b=Q1kS7m1Cfnvhq5FlK6uoJRvGBTz0Lzt0ZMxYn+f1vb+2yRZBv0nXCLy3E+HamyYy88
         YhWtmp3nNiuosooKafp9cxEGDmAr7JPpnqIJJoIPYelO5N/JsYVKrQa1g365ZVzstUnI
         U5AqcT+LdYg5RbHoSoTPNh6yLNoOE6ceKGHWbzxyKVENqaKtlFvCp10BUlSihinMMlSZ
         PVTft3MhS3uFz9d0cd8im1GuWhrn6mAwfBYFnHxjGIvZA8da6gSKwzbPYYnTP2fM/vPM
         pUnmgWA7N1LWgnuK7/UivsKeMJxnUum3FrLGGIQ8ODXnd0yf9s9HueXmwM0LgStET33z
         PFoA==
X-Gm-Message-State: APjAAAUXJt18iPbQhPnCdwmYqnUIpPi/HKqlTDndAfSU9DEBQzuqKK6t
        OodN/tLiRd2yY7RpdIp9iEk/HR/lI5lbYQ==
X-Google-Smtp-Source: APXvYqzLtDBZfmM2GD/UaaOd4x3d8MvB7xHBx5vDepe4R9GiquJTU57wWr0efJoDs6ztvjZk0z1fqA==
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr1013062lfl.93.1551392619280;
        Thu, 28 Feb 2019 14:23:39 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id x19sm4800320lfe.42.2019.02.28.14.23.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 14:23:38 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id g12so16464770lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:23:38 -0800 (PST)
X-Received: by 2002:a19:c507:: with SMTP id w7mr1098004lfe.56.1551392617706;
 Thu, 28 Feb 2019 14:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20190228115256.5446-1-louis@kragniz.eu> <20190228122417.9318-1-louis@kragniz.eu>
 <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
In-Reply-To: <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
From:   Jon Flatley <jflat@chromium.org>
Date:   Thu, 28 Feb 2019 14:23:25 -0800
X-Gmail-Original-Message-ID: <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
Message-ID: <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
Subject: Re: [PATCH v2] wusb: use correct format characters
To:     Joe Perches <joe@perches.com>
Cc:     Louis Taylor <louis@kragniz.eu>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch and comments.

On Thu, Feb 28, 2019 at 1:53 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-02-28 at 12:24 +0000, Louis Taylor wrote:
> > When compiling with -Wformat, clang warns:
> > ./include/linux/usb/wusb.h:245:5: warning: format specifies type
> > 'unsigned short' but the argument has type 'u8' (aka 'unsigned char')
> > [-Wformat]
> >   ckhdid->data[0],  ckhdid->data[1],
> >   ^~~~~~~~~~~~~~~
>
> I think the message is somewhat misguided as all the
> vararg arguments have implicit integer promotions.

That's a fair point, but Clang checks the arguments against their
format specifier before they're promoted when using -Wformat. When
considering integer promotions it's difficult to say if this is
"wrong", but since 'unsigned char' corresponds to the "hh" length
specifier I don't think this is misguided. Otherwise, why use the "h"
length specifier at all?
>
> > ckhdid->data is unconditionally defined as `u8 data[16]`, so this patch
> > updates the format characters to the correct one for unsigned char types.
> []
> > diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
> []
> > @@ -240,8 +240,8 @@ static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
> >                                  const struct wusb_ckhdid *ckhdid)
> >  {
> >       return scnprintf(pr_ckhdid, size,
> > -                      "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
> > -                      "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
> > +                      "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx "
> > +                      "%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx",
> >                        ckhdid->data[0],  ckhdid->data[1],
> >                        ckhdid->data[2],  ckhdid->data[3],
> >                        ckhdid->data[4],  ckhdid->data[5],
>
> Better to use the vsprintf %ph extension insead.

Agreed, so I guess my previous comment is irrelevant in this scenario.
> ---
>  include/linux/usb/wusb.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/include/linux/usb/wusb.h b/include/linux/usb/wusb.h
> index 9e4a3213f2c2..8c39ddf62951 100644
> --- a/include/linux/usb/wusb.h
> +++ b/include/linux/usb/wusb.h
> @@ -239,17 +239,7 @@ enum {
>  static inline size_t ckhdid_printf(char *pr_ckhdid, size_t size,
>                                    const struct wusb_ckhdid *ckhdid)
>  {
> -       return scnprintf(pr_ckhdid, size,
> -                        "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx "
> -                        "%02hx %02hx %02hx %02hx %02hx %02hx %02hx %02hx",
> -                        ckhdid->data[0],  ckhdid->data[1],
> -                        ckhdid->data[2],  ckhdid->data[3],
> -                        ckhdid->data[4],  ckhdid->data[5],
> -                        ckhdid->data[6],  ckhdid->data[7],
> -                        ckhdid->data[8],  ckhdid->data[9],
> -                        ckhdid->data[10], ckhdid->data[11],
> -                        ckhdid->data[12], ckhdid->data[13],
> -                        ckhdid->data[14], ckhdid->data[15]);
> +       return scnprintf(pr_ckhdid, size, "%16ph", ckhdid->data);
>  }
>
>  /*
>
>
