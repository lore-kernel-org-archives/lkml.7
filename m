Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5E221537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KagjoOje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfFTAxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 20:53:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32891 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfFTAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:53:04 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so429130iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 17:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li+r14SDKIqHJv4KbOac1fTpdYEcS5HP4GgaJBk2r/o=;
        b=KagjoOjeKfrvmdNtVCxeZybLpwXlC7xn3JvOMLWm/KbGu+x1paZeaqkEEznWDOifOK
         ihkAfAuE5QPJHKSRWCTW7aCpMcv7djUgSexcx0RA5xbUPeEnssVWKnMM+tVSTRdNvvQ0
         yG5QonqnbhbqOLY7LumoWJyDvdx5UsxyXmbeHqnGl2K1GnJ4SOPSmKu6fGU6XMrDyI40
         FBtU0ahfRdDg180uuZzC8q/yIbWEDaBEm4mtq4DcswSl2nR/CflmZjthI20mi3BNILaV
         1vd1YVT0ODGFR5pl5aYXwNsLW9YK525rLsPe1El6SYpYRuSHsy39pT3RvHIaHbzBIvbd
         cl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li+r14SDKIqHJv4KbOac1fTpdYEcS5HP4GgaJBk2r/o=;
        b=omL1nTBO0bIWnfgttF8il+ioq+GoR8WCKB6KRbctEkNb5WfiF8d4cUbwEAth884UQH
         QWFv5S4GIG7MxSCF7U8Hw4q8uf4LkFMYVSpel0kziCcV1JqeT/qKr1cLpOGXrSzZB7Gj
         XHUFEkJu8voMdvqIxT6Zxp7ShapRilyVmi4tK+vB80nC8RAP6MMW8+ttp01Lg3N6HEFU
         g1pLK6IpVJcvq51LttRa+8+Wj8f84S13sy7oVziwedCkcThkx0b1YN5j5tkenjkbrapv
         S5TkB9iyMTCc6LTZTtpZD6dp8ddSvKlnZBnVCDA3+t0QDP/yoTwd4UJKpJJx83A84usq
         zxyg==
X-Gm-Message-State: APjAAAWZbknotwoPnPb3SR04iZAHgza0NY56b/r+l2PgSiYdKAkmTzxn
        Iba637vux9Ahk+xBmB0GhDylwjbJx8aWTB60zT8=
X-Google-Smtp-Source: APXvYqwkGwzSMQwks/z00/F8glQdMrPUwzjON21KAQbpE9JI43ZzKc6ZCqOWItnUvf2c17deO83TSZpkNUzWw8VsL2U=
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr7415199iog.43.1560991983500;
 Wed, 19 Jun 2019 17:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190618185502.3839-1-krzk@kernel.org>
In-Reply-To: <20190618185502.3839-1-krzk@kernel.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 20 Jun 2019 08:52:52 +0800
Message-ID: <CAKGbVbuai1sBvqovBQZg8BfqEKqFPnKO5YRs-yd_JKXijEHRLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/lima: Mark 64-bit number as ULL to silence Smatch warning
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

I'll apply it to drm-misc-next.

Regards,
Qiang

On Wed, Jun 19, 2019 at 2:55 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Mark long numbers with ULL to silence the Smatch warning:
>
>     drivers/gpu/drm/lima/lima_device.c:314:32: warning: constant 0x100000000 is so big it is long long
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpu/drm/lima/lima_vm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_vm.h b/drivers/gpu/drm/lima/lima_vm.h
> index caee2f8a29b4..e0bdedcf14dd 100644
> --- a/drivers/gpu/drm/lima/lima_vm.h
> +++ b/drivers/gpu/drm/lima/lima_vm.h
> @@ -15,9 +15,9 @@
>  #define LIMA_VM_NUM_PT_PER_BT (1 << LIMA_VM_NUM_PT_PER_BT_SHIFT)
>  #define LIMA_VM_NUM_BT (LIMA_PAGE_ENT_NUM >> LIMA_VM_NUM_PT_PER_BT_SHIFT)
>
> -#define LIMA_VA_RESERVE_START  0xFFF00000
> +#define LIMA_VA_RESERVE_START  0x0FFF00000ULL
>  #define LIMA_VA_RESERVE_DLBU   LIMA_VA_RESERVE_START
> -#define LIMA_VA_RESERVE_END    0x100000000
> +#define LIMA_VA_RESERVE_END    0x100000000ULL
>
>  struct lima_device;
>
> --
> 2.17.1
>
