Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB04C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E212173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eM+r0Sc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfC1XVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:21:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45431 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC1XVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:21:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id e5so325281otk.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lrIHuY9fD/UPR5Age0eP8PxWjndHGiSHD27i6LQR14=;
        b=eM+r0Sc/VkAbhK/bPOgcTLEVbXf0Ez6Yqv0TjTM5+gZQL9qF8mmNibiOzNkLhc5HAv
         gI3v85YnV/Y6f2+Zt0tncyGJDv8bpGZIA/0XXxK9mAeVAY8OpqOqqbX8Rltlk0EM0sHK
         ZFPsPgTSWinToNx6CfmBB2EUo7gajLhPLsU7iWk2PV03TTvmsdbCtLNwe9iQEIaFXmCN
         u5y1Y/Guat9oPq/5qYtcCSLTwqMS/9GJOukcHLcw8wCvzjsocT46I+nQRwHjGwK7saOy
         suyog+byj28e6B1Ha5TuSixW2Z2Nq/LhSmWr7FF+v+/SihT4z3F44np8TmfikGBBSzs8
         Zw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lrIHuY9fD/UPR5Age0eP8PxWjndHGiSHD27i6LQR14=;
        b=YZo1ONsTTONVoGtBNadAtWL673HBmfBTQfXP+QrKhwAUu5vrNMPVyJ2gfSpC9lIqm0
         dDWhP+/+GURN/A4xvljQgJsfztDCBywz3AOBooPbd3oZSZBqlRMOq5DCON1k5xhCEu2e
         5BPFEtiTHtr34oSLUcwXAmubZMzOq0+B6PXtSmCsOZyi9av4R0AOcbyZwEzXDL/QRYjO
         guxF5NDlU+hJu2gUgwnmuW+wrSR9O0w7MU8rbj8LPvvbI6jAyq1o4E2DJsekDvcjtB21
         o4Vg0jEXY936jprJdsyeeZ7JBwLhCVQ0cB46d/+PRXpj3f7yPZjCHach5C/IdfBT4Ewq
         bHdw==
X-Gm-Message-State: APjAAAWiH8cyP5iRvBRLFzy/nqOcpQPAxePFbhdgR91Oliu6BRGmiI77
        7mDcIyrMCCGv41xxhgCpFtBismJSucv5omGh1HLOwQ==
X-Google-Smtp-Source: APXvYqzCZnM1lVu/xws9rDcFXq5U0cvAhkMgEF/N2p9L0WtVItB1svcSaV+lRNCs92JDq+mpSQ82ArSepCH1S5kliGU=
X-Received: by 2002:a9d:6b97:: with SMTP id b23mr12731178otq.113.1553815311761;
 Thu, 28 Mar 2019 16:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190328231317.330699-1-tmaimon77@gmail.com>
In-Reply-To: <20190328231317.330699-1-tmaimon77@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 28 Mar 2019 16:21:40 -0700
Message-ID: <CAFd5g44h8J9VV84QbbEeE9U-=2kpOk-vgqCnmLV_=0uMu20MZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] MAINTAINERS: fix bad pattern in ARM/NUVOTON NPCM
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 4:13 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> In the process of upstreaming architecture support for ARM/NUVOTON NPCM
> include/dt-bindings/clock/nuvoton,npcm7xx-clks.h was renamed
> include/dt-bindings/clock/nuvoton,npcm7xx-clock.h without updating
> MAINTAINERS. This updates the MAINTAINERS pattern to match the new name
> of this file.
>
> Fixes: 6a498e06ba22 ("MAINTAINERS: Add entry for the Nuvoton NPCM architecture")
> Reported-by: Joe Perches <joe@xxxxxxxxxxx>
> Signed-off-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>

Hmm...looks like you just copied the text from Spinics, because the
email addresses are x'ed out.

You can download the patch here: https://lore.kernel.org/patchwork/patch/996114/

> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..8b305d2f2a8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1900,7 +1900,7 @@ L:        openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:     Supported
>  F:     arch/arm/mach-npcm/
>  F:     arch/arm/boot/dts/nuvoton-npcm*
> -F:     include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
> +F:     include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
>  F:     drivers/*/*npcm*
>  F:     Documentation/devicetree/bindings/*/*npcm*
>  F:     Documentation/devicetree/bindings/*/*/*npcm*
> --
> 2.14.1
>
