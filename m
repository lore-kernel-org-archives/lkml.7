Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3362FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B7623407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W5Mq4jZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfH2Ovi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:51:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43348 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfH2Ovc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so2207310pfn.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=os7g5YCFkp5+ztstInB9OjtEfDLOFJwY4UcZDxztTP0=;
        b=W5Mq4jZ6OnI3djKJXoHup8cLbqgXTDsAAE2TRF9ZSV2Cr/h6sqogbMRnUJSUUitK1s
         NWfXcDxhgnz1UUH/+NCk2WBDD/6MDwJgOW+IFXUOIGOmr3gtNLF6DEGVUkW9+rMDwcC7
         kvPsZySJpT4wvpp7T/lIYNVWAK1MhXTqML2UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=os7g5YCFkp5+ztstInB9OjtEfDLOFJwY4UcZDxztTP0=;
        b=arkkkx40GuVR+k6qoFViB47Pdxcvc0toq3Foo+bIYFifwkBg+/j4vBrTzym9yQf7GI
         UNAjYgtyhXDaf/86BDWG0T6fidGP1KACoOGuWKrb22U7e9IDYcPwxr6+u5IpaSkqo/Fb
         TjpaL/eKRQ/70dKSAi6kEmJ1GGXskJr/w2SWq0sUoEABDKJ+qtJpgdV5fVYoMJxtpVtg
         9n95J+9IUDRskn6g5I0hgRCQmw24hDPqDe2yU1m5ylUZjD5n0iOc1boMvGaucRJ2su9u
         n6S5btTKoygJsqD3OiUXUvrleZMuUyMz0dxUUNyAAKGosWrckHYLGl0D9K5OEQ3Caf0B
         0zaw==
X-Gm-Message-State: APjAAAV9X4El+gdyIXk+3s2bDUMhou6ciU9vhm77LBo8sDI4f03yaDnn
        ZL14OpCRsWfd0qF6/i9XVdS1ug==
X-Google-Smtp-Source: APXvYqwbR0cZc/YmOKXENPhPJYGdkUuvFpj5SGbTdwPLno00gjgPGh6igtTOlA+nU1P8qab+3GVasQ==
X-Received: by 2002:a63:f357:: with SMTP id t23mr8867138pgj.421.1567090291673;
        Thu, 29 Aug 2019 07:51:31 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t70sm2627916pjb.2.2019.08.29.07.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:51:31 -0700 (PDT)
Message-ID: <5d67e673.1c69fb81.5f13b.62ee@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190829114547.9957-1-hungte@chromium.org>
References: <20190829112407.GB23823@kroah.com> <20190829114547.9957-1-hungte@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] firmware: google: check if size is valid when decoding VPD data
To:     Hung-Te Lin <hungte@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 07:51:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hung-Te Lin (2019-08-29 04:45:43)
> The VPD implementation from Chromium Vital Product Data project used to
> parse data from untrusted input without checking if the meta data is
> invalid or corrupted. For example, the size from decoded content may
> be negative value, or larger than whole input buffer. Such invalid data
> may cause buffer overflow.
>=20
> To fix that, the size parameters passed to vpd_decode functions should
> be changed to unsigned integer (u32) type, and the parsing of entry
> header should be refactored so every size field is correctly verified
> before starting to decode.
>=20
> Fixes: ad2ac9d5c5e0 ("firmware: Google VPD: import lib_vpd source files")
> Signed-off-by: Hung-Te Lin <hungte@chromium.org>
> ---

Two minor nitpicks, otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/goog=
le/vpd_decode.c
> index 92e3258552fc..7a5b0c72db00 100644
> --- a/drivers/firmware/google/vpd_decode.c
> +++ b/drivers/firmware/google/vpd_decode.c
> @@ -9,8 +9,8 @@
> =20
>  #include "vpd_decode.h"
> =20
> -static int vpd_decode_len(const s32 max_len, const u8 *in,
> -                         s32 *length, s32 *decoded_len)
> +static int vpd_decode_len(const u32 max_len, const u8 *in, u32 *length,
> +                         u32 *decoded_len)

Nitpick: Can you leave the first line alone? Just change types from s32
to u32 on the same line so that this hunk clearly shows that the
function name and other arguments aren't changing.

>  {
>         u8 more;
>         int i =3D 0;
> diff --git a/drivers/firmware/google/vpd_decode.h b/drivers/firmware/goog=
le/vpd_decode.h
> index cf8c2ace155a..b65d246a6804 100644
> --- a/drivers/firmware/google/vpd_decode.h
> +++ b/drivers/firmware/google/vpd_decode.h
> @@ -25,15 +25,14 @@ enum {
[...]
> =20
>  /*
>   * vpd_decode_string
>   *
>   * Given the encoded string, this function invokes callback with extract=
ed
> - * (key, value). The *consumed will be plused the number of bytes consum=
ed in
> + * (key, value). The *consumed will be plused by the number of bytes con=
sumed in
>   * this function.
>   *
>   * The input_buf points to the first byte of the input buffer.

This part can be a different patch that also converts this to kernel-doc
style. See Documentation/doc-guide/kernel-doc.rst for more info.

