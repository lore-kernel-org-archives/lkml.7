Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70DFC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DBB264E2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZT3pn2ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEaHKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:10:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43632 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:10:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id i8so8170370oth.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SOmVWYigVGsToAZpGfMDTQAnehJ0f9re7zn6YJSQLfU=;
        b=ZT3pn2ikV0jHN4MRBiHkiYL3yJyW5FsKEpezrCbovLUh9a6uA6vZ4QV6bC9OnQjq7L
         O5kZ1nnU8f5Rx6CQZiKSMH+rP4AK23uv5ZoxI1giu6dIBVV1SoZiPhF+ieImzqn3sujy
         dPTLCtHFrwbLzSxetRbpLhsGR5JjOv9v6sInLDSTns8bZpGLF0utWrjelvG8fi0CVzwr
         BiM0e+Pq6hJQ4DOiCWOQOMdwaK0k2ZZI7LUDVvPs80wMPDqO9Bs0GaFvNOsuZz6yZx84
         MiG+/MA3ul/j77G/90TiTEWxgCRNO/nezpetzB9fLv3HCSMv6siUAfltRqQVvtvpkYlx
         vm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SOmVWYigVGsToAZpGfMDTQAnehJ0f9re7zn6YJSQLfU=;
        b=Dmsimb7ghAI0jmrZ+jrWb2HU6i01R8YFfpq1+Pj7nD1PUMAZwUnEJjCON+X8p97pcW
         4+SQtWNvEWqgRYPE2zEs+jsKhCSiA6wwq5dwhYLY/5wRw0et8+5yiPbDG6aBdLZRQqLN
         l+kFeIWc2ocaEfasykQkYjlqX66CQ1IXRntoPOcgX//3hZuRcXU7ySRofixNcUZmiZIb
         SgHldV80da34HQKY34va1GfGtLG1KvyrLVuFSpBxxfswh51mb5DMu7YCL6bmz8pfC1Xp
         SzE6oCesg4gK99A7c1eJgkcGs160HdJsA65RfxTSmbkXnzP30b4uZO595lg3M4fHixf+
         QdJA==
X-Gm-Message-State: APjAAAU2EpbY/C24tUEunT6kiLfw685zNIhJtzDyD6mEnEYP/HruQrva
        9oYx/KtOkhPrjddbZJn7tSg0pN6vW+QwWrBarlZtCdUo
X-Google-Smtp-Source: APXvYqyRXwcncc9wKbYIrRZ44NAbKVsWaJ0j9o3Ps+2zQPp0tmPC5rbaCeAv9MpbLcmDl4VcxeUoZ+6MRXl9Scj9iCs=
X-Received: by 2002:a9d:5cb:: with SMTP id 69mr684652otd.292.1559286617625;
 Fri, 31 May 2019 00:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190529163052.GA29158@embeddedor>
In-Reply-To: <20190529163052.GA29158@embeddedor>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 31 May 2019 09:10:06 +0200
Message-ID: <CAMpxmJV_RQ-V8DMfsOSqRjY_HAys4cpmppUCffCwDWCrFchmLQ@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: use struct_size() in devm_kzalloc()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 29 maj 2019 o 18:30 Gustavo A. R. Silva <gustavo@embeddedor.com>
napisa=C5=82(a):
>
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>
> size =3D sizeof(struct foo) + count * sizeof(struct boo);
> instance =3D devm_kzalloc(dev, size, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>
> instance =3D devm_kzalloc(dev, struct_size(instance, entry, count), GFP_K=
ERNEL);
>
> Notice that, in this case, variable at24_size is not necessary, hence it
> is removed.
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/misc/eeprom/at24.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index ba8e73812644..78ba6b1917a8 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -568,7 +568,6 @@ static int at24_probe(struct i2c_client *client)
>         unsigned int i, num_addresses;
>         struct at24_data *at24;
>         struct regmap *regmap;
> -       size_t at24_size;
>         bool writable;
>         u8 test_byte;
>         int err;
> @@ -652,8 +651,8 @@ static int at24_probe(struct i2c_client *client)
>         if (IS_ERR(regmap))
>                 return PTR_ERR(regmap);
>
> -       at24_size =3D sizeof(*at24) + num_addresses * sizeof(struct at24_=
client);
> -       at24 =3D devm_kzalloc(dev, at24_size, GFP_KERNEL);
> +       at24 =3D devm_kzalloc(dev, struct_size(at24, client, num_addresse=
s),
> +                           GFP_KERNEL);
>         if (!at24)
>                 return -ENOMEM;
>
> --
> 2.21.0
>

Applied, thanks!

Bart
