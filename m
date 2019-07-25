Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF9C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C9229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOk4uiXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfGYSAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:00:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40487 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfGYSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:00:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so23126575pfp.7;
        Thu, 25 Jul 2019 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkbSE3RdaT/xlwRWfygAS7qrLOgOFCk6GjaRtQ17bf0=;
        b=nOk4uiXheReqndfr+Tg9sozfodE3OaQ7tjITYaaJroJvb5solIuADVcDtduQJv8G6d
         B8wJnKCiFIMedtHCBqcFfMSVLyP1xpWBEmtssk+BXH3MgCs/KFd3F0H6vWMuJwB1i24V
         UL7OtrqXO9w24mMgFs/Uaa6PSSAhUFB9EXMcjgxoHwGlIunJNvkAEDhFGOFsMZpzDc5M
         6pYZR8oPZMKnI8QSnMlU0hcrXLcGPlRCDmXpfxQLrM0vvPOJNvRD3d5G+PyYq8+RgU7+
         XhNKGBTT7CUylc+W9X55IutZunNIyzMCBBXDgrOZRSv+0PbpYx7ug9RoGXRDrW1x97y8
         aKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkbSE3RdaT/xlwRWfygAS7qrLOgOFCk6GjaRtQ17bf0=;
        b=lpzwzNlfqwfQ3QyM2qlc8tyORRjHt4fvteGcHPgdZy+xCtvUNyLEc2McMPM2/zr8KE
         SvPlCPYlDVMu+yr/yvlpn0yUp4GDqaTF7ZyNuA0DgGL5xLAjSNVF8cMuPidfl3bqYgUU
         Gx5eqvEoaujZsxCNwG1rNf7w3yLS7oJzsMv8R7igo89SZ62o/fpgqwVGDjoQXmSn2/up
         NY9cOEXKoTfM3B2J3BDEkPcPtGaa1FLz9nK2KkIS3woGLSBCS4vj2S3iAW/26mwvg9uL
         ApC7hk0cntr4agQ+G9VhM0Wz/3Nmo96MT3/b0BzdakuSbKwZbtTAdaio6Wp2iQOaFx/I
         RO7g==
X-Gm-Message-State: APjAAAUh860NGwd+7YDAvgkcB8Q0uKQ7qaOKFHWwklf+8d05SpuvWTvR
        Hfm0n+s+b2h6SmnZGtJrKsmvi3Rd2+KEIe5JNAg=
X-Google-Smtp-Source: APXvYqx0difdyVJDhDzSkpgfiycWSK0ExGTDazCU2rXXycdMIJWEADCKHoTvnnjJoxsnarGzcviRx9LIoDA/s3BaAmQ=
X-Received: by 2002:aa7:9713:: with SMTP id a19mr5170pfg.64.1564077608092;
 Thu, 25 Jul 2019 11:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190724081415.8926-1-rhyskidd@gmail.com> <20190724081415.8926-3-rhyskidd@gmail.com>
In-Reply-To: <20190724081415.8926-3-rhyskidd@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:59:57 +0300
Message-ID: <CAHp75VdwQZtjus58gbUo1DtAehU_m8KKpEhNfgkMvkjKcJ7GYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: Use existing defined
 KBD_LED_* magic values
To:     Rhys Kidd <rhyskidd@gmail.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:14 AM Rhys Kidd <rhyskidd@gmail.com> wrote:
>
> These values have already been defined in platform/x86/dell-smbios.h
>

Pushed to my review and testing queue, thanks!


> Signed-off-by: Rhys Kidd <rhyskidd@gmail.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
> index 68a8a4eba4e3..fc33c38f5f82 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -311,13 +311,13 @@ static const struct key_entry dell_wmi_keymap_type_0011[] = {
>         { KE_IGNORE, 0xfff1, { KEY_RESERVED } },
>
>         /* Keyboard backlight level changed */
> -       { KE_IGNORE, 0x01e1, { KEY_RESERVED } },
> -       { KE_IGNORE, 0x01e2, { KEY_RESERVED } },
> -       { KE_IGNORE, 0x01e3, { KEY_RESERVED } },
> -       { KE_IGNORE, 0x02ea, { KEY_RESERVED } },
> -       { KE_IGNORE, 0x02eb, { KEY_RESERVED } },
> -       { KE_IGNORE, 0x02ec, { KEY_RESERVED } },
> -       { KE_IGNORE, 0x02f6, { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_OFF_TOKEN,      { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_ON_TOKEN,       { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_AUTO_TOKEN,     { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_AUTO_25_TOKEN,  { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_AUTO_50_TOKEN,  { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_AUTO_75_TOKEN,  { KEY_RESERVED } },
> +       { KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>  };
>
>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int code)
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
