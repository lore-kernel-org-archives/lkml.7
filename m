Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93427C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F33820835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I89vLGSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbfDXTFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:05:17 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40667 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDXTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:05:16 -0400
Received: by mail-vk1-f193.google.com with SMTP id l17so4286008vke.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gp/6aiOgwCuUZZwIpCOM/3lPPaM1FZHxJCz2Nt+7++4=;
        b=I89vLGSuLKELhoRLQzX/y/2utZukhs7ixGcDl4q+IwsV+rJIX43dH1Cy1G6NQl0310
         TLw/WS8ed61d+8lWjBzqq8DByn1H4V56+Ode9ac9h+Mix6iqzi2+/a2V2krwheLx+FTw
         ISDAeIFLJLs2dAYkRThNmhQChhM5E62v7coUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gp/6aiOgwCuUZZwIpCOM/3lPPaM1FZHxJCz2Nt+7++4=;
        b=P2qQNMClPg51ErcbRNjA8Q7Q+9eKxbMK5VuYqyCNpRWxIJYMsyzDlw17JaO3a0cej4
         vGX7KpbjjRHJfVxT1uR5vhzDiZ3x/RqYjBm+yiGLYxV+wJFE4F+NPN1Ti21QUWvWYcNF
         yT56rALfggiWig7pfRTqOdaeXPuOAMrXegE3V0mz5hd7QTfVMiLIrWQ1LCADoT2qVrot
         xZaE7CKz3MgCLymlSDLoXA+xIulsieGqM/c7SsiGROjLOxWxjG2ztIkswnwDS1qwHGfX
         GOZaPm3Sfl9hQzA71QOSK2KbR6HZDluOJCS3fniXQV7AZXdCNWiHJz9S8Miz6qswrRch
         oRMg==
X-Gm-Message-State: APjAAAUCI7RC9ZTOvzde6A1qcq1rRvl0NZifpCKWXUHWh0FYX/37r5Rb
        TwM5P7N7rZ0at0cGDgTe/T+9lYdUKZE=
X-Google-Smtp-Source: APXvYqx0pNH7koHbjuBAYdn1k9yMACavXXGA3REV1eRZb4O2wzITiSVXETNBmbUCeAhCeOlxfRc4Sg==
X-Received: by 2002:a1f:a9c2:: with SMTP id s185mr18670821vke.5.1556132715164;
        Wed, 24 Apr 2019 12:05:15 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id c2sm6564008vsc.32.2019.04.24.12.05.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:05:13 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 195so4287154vkx.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 12:05:13 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr18400910vku.44.1556132713051;
 Wed, 24 Apr 2019 12:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190424181543.GA31200@embeddedor>
In-Reply-To: <20190424181543.GA31200@embeddedor>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Apr 2019 12:05:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKRO45m1TRDPA09sv0j+cZCC8e1w+oQty4YfOttKP3FYA@mail.gmail.com>
Message-ID: <CAGXu5jKRO45m1TRDPA09sv0j+cZCC8e1w+oQty4YfOttKP3FYA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:15 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/platform/x86/thinkpad_acpi.c: In function =E2=80=98thermal_get_se=
nsor=E2=80=99:
> drivers/platform/x86/thinkpad_acpi.c:6316:6: warning: this statement may =
fall through [-Wimplicit-fallthrough=3D]
>    if (idx >=3D 8 && idx <=3D 15) {
>       ^
> drivers/platform/x86/thinkpad_acpi.c:6322:2: note: here
>   case TPACPI_THERMAL_TPEC_8:
>   ^~~~
> drivers/platform/x86/thinkpad_acpi.c: In function =E2=80=98hotkey_notify=
=E2=80=99:
> drivers/platform/x86/thinkpad_acpi.c:4208:7: warning: this statement may =
fall through [-Wimplicit-fallthrough=3D]
>     if (tp_features.hotkey_wlsw &&
>        ^
> drivers/platform/x86/thinkpad_acpi.c:4216:3: note: here
>    default:
>    ^~~~~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> Notice that, in this particular case, the code comments are modified
> in accordance with what GCC is expecting to find.
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index 57d9ae9d8e56..826e9a276818 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -4212,7 +4212,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u=
32 event)
>                                 known_ev =3D true;
>                                 break;
>                         }
> -                       /* fallthrough to default */
> +                       /* fallthrough - to default */
>                 default:
>                         known_ev =3D false;
>                 }
> @@ -6317,8 +6317,8 @@ static int thermal_get_sensor(int idx, s32 *value)
>                         t =3D TP_EC_THERMAL_TMP8;
>                         idx -=3D 8;
>                 }
> -               /* fallthrough */
>  #endif
> +               /* fallthrough */
>         case TPACPI_THERMAL_TPEC_8:
>                 if (idx <=3D 7) {
>                         if (!acpi_ec_read(t + idx, &tmp))
> --
> 2.21.0
>


--=20
Kees Cook
