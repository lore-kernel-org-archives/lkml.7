Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E45C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDF120B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="auXDGfby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfFZLyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:54:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37895 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:54:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so1885070ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O68+gWYy+AAHpHVbze86ikYo+1+/Ck9AaofTpRQedkU=;
        b=auXDGfbyfXKdkslrXQ3vyDA6Do1xehiwmgcsq+apkyS6KFRp4gvGgxSNpUggbe7lGP
         +OjWq/S6lK4gUEcRir7c1ieo9YSoSK6X7kqb7A+Rsvk7DtVq7d+M9a0OfLgequxAuw0R
         J18f9O34hClg3SQNfGBUPiAN4Q4RkNTEPeU0nTBRQo3rRtoy9n9NrWsaXXaveSl784KT
         rf0/2ZrmA5rLeUMoUrHQhfKp1AA7z7TrR34tU9B+8WpY3QE9afY8/NybnGsIghwZuUad
         jcIFnEjyahkVTsKkjYtGI5/YO9bNH+/yR5F71SY2fQzAJt1IMwSejwdjs3lJ3IlAhOTY
         zeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O68+gWYy+AAHpHVbze86ikYo+1+/Ck9AaofTpRQedkU=;
        b=PZLFWxoJ3ofwTU8TUaX3LLsVS3IJ/6bjUHYsMvPC7mIQksPHQJKWnIhxkDaPoe/olc
         8HI8WLTDmk9j3ZhSyjNTjymS7U84o53MAHOvgbRpIJe3QNG5d21M4zZzYQMxCAgqoNT6
         m5WFYTkIepQIiI2U8u+ibvH/+aj2AKQ9ASF1Lq2uROVQTw+4hh2EWFCsBz2qMS2InTDk
         oqkCqbckv40/6J9fz1Nr8QGlD/6H9ub6rhQ7MSUU4tGnKVfSicgdFJyoI0Q39skXqCm9
         xgUbpZhe25YRee4JMD4zGrAGOiGs1u5n59WUIlcAiOrEGuQbpvmgwWg+mWUpjPXG/uma
         Qxbg==
X-Gm-Message-State: APjAAAUx1S35McVUDllaNzJpp+F7Kkwb9D/ZP7rttYDYfZCSWP3E7CR+
        D/OgjkJXW/3Afs2W38VEZLrWDdezNx/qwFcSXaECWg==
X-Google-Smtp-Source: APXvYqyUysv3OBilFHl0NElzx3G/IF+JCRwcIQ/ctFIklfhsx8tecZrt6RY8uuYINYKFtanN3OMzdtNH5QKw7QHsogU=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr2665141ljs.54.1561550070403;
 Wed, 26 Jun 2019 04:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190626084557.11847-1-brgl@bgdev.pl>
In-Reply-To: <20190626084557.11847-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Jun 2019 13:54:19 +0200
Message-ID: <CACRpkdZXtFUimMATgKA6Qdo4-mTLW5xV3XvdcBShpO9c32_gbQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: mockup: no need to check return value of
 debugfs_create functions
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Bamvor Jian Zhang <bamv2005@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [Bartosz: removed one more check for debugfs return value]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> v1 -> v2:
> - fix build warning found by kbuild
> - fix build error found by kbuild
>
> v2 -> v3:
> - remove one more unnecessary ifdef

Looks good
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Will you send me this in a pull request with the rest of
the stuff you have queued?

Yours,
Linus Walleij
