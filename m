Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E609BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA0920644
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5GgF7uE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfH1Qbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:31:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35495 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfH1Qbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:31:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so169721lje.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjXiz0jtJWGT4cEckFQPpVyw/lRnuMBErWmMi5AhrWA=;
        b=E5GgF7uEiUS4O03g81yoi6j0NmHdf4h5a677oc0l/9oNnv0vPvwDHY9bBDT7sfZWMO
         rtsogJ+CsbQsVUNcCCnRHsk9EWzhAL6ZAKvbAkIGd3LbnZ9GbTX5hpb5oa1NrfnQCDQD
         85jxjR9VZDrJIS3b4zWx5d3/+VcTuqraAY6MfUm0HRhJ88NUTZw3xDXtM5agrv/wXgTK
         4OEFhl9VwwKoRXdkm56/y0MiVOG/BysRAFp+oFrmld0FBfH7Wc6WzPLGLl/lz1dZz4pY
         cQR2OdKQ1dpLW+E67rY2iNc+/jXps0kUscsilbRR/9V3g+yKEWUcVcl6Q4w3/v7MaUkX
         iQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjXiz0jtJWGT4cEckFQPpVyw/lRnuMBErWmMi5AhrWA=;
        b=sUOAC/JvjNv5YmwGWotUkvExmADcRFGfhoNAcPY9us6jnzDaWXYiKwqEXmireNDw8z
         d5zLPnrIn6aFJA6ZA2RbQAQODLyUfpb6G0jxtr1bY2WNoTyhMwymvP6DLRvIVA3gUPG5
         No0Pz8F9pIVCoPX2wrnYOP6obQ0AdXgfXmYDJhaBWPJxa5rL999Ilbwi4idLZAJLdPDq
         HyAkvTaWGICSQX52+dcoM3PA06fvo3rVVB3hqAQ1qteP8QkjyTMifqMJLI5+clAQ4N+8
         9oAg4ubvba367lHa8GZNGvc7G4ANPuk/uw3x4x1RE0UP7wdpdbI+CXpyRv0WZKDrvWtH
         Bhgw==
X-Gm-Message-State: APjAAAU2GY8gQXspJJa5Arc9ZlMwdpWkmsTc7sx/J5xffmP0w+lJSQ9K
        QVYnD5f3eLTY/U7onMpkUtWcwxQ78YxtXoRuBG2m4w==
X-Google-Smtp-Source: APXvYqxAHfxii1r8G4uA4TRksDr+gKgKoYBl4Hdl6wuwPpbFwpxiCpD0ZSA802wdhf0b6NWeu0VbqDNspGN9n84/Rjg=
X-Received: by 2002:a2e:9f0f:: with SMTP id u15mr2559887ljk.54.1567009891738;
 Wed, 28 Aug 2019 09:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190724082508.27617-1-brgl@bgdev.pl> <CAMRc=Mex_Ricd+C4F7nGLmpBggO-hWwJDB6duX8kFpPEeaTDjQ@mail.gmail.com>
 <CAMRc=Mci4ncbDmns=0uL8hsAGz1Wvd5bgK4yxTF8QQQitXDv0g@mail.gmail.com>
 <CAMRc=McUEgm6yH7enwHuHxVTL41dmb5KAY_pxTmSr3vctCs2xg@mail.gmail.com> <CAMuHMdV3obGtQ7qohNedQNgpvZvyL9xjH0HUiBKD6b8Ou5F+XA@mail.gmail.com>
In-Reply-To: <CAMuHMdV3obGtQ7qohNedQNgpvZvyL9xjH0HUiBKD6b8Ou5F+XA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Aug 2019 18:31:19 +0200
Message-ID: <CACRpkdbgZhgSvicq2XG0n2hiKA9K8VFmvCPn3W9oXgSLrZiw=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] backlight: gpio: simplify the driver
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:36 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> CC the pour soul with the ecovec board.

With great power comes great responsibility ;)

Yours,
Linus Walleij
