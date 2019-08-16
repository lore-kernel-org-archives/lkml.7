Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A458C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D82206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCj+GOx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfHPIbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:31:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHPIbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:31:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so759038wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMteWjiol09LnNTGAtg+qqwxoUC+aePsLIm1kIpTrJs=;
        b=oCj+GOx8zj3DZDR8aTDgqrL6lshNRYHcEJ9xc7u/k5AAXmEozG5CiyjIcN62uoR4yk
         /dZXF2qmsL6jlDXs1GlkR2A/kSPm/FFMDejUbnIKqNjQtHvOcl4zAg6VDFE80jvid6MD
         52rJCbC9f15qQ3tWLYI9mE+Qjr2VSBI/Xc+5cXxFil0vTyG3GnDha7zPP8OJddjUr/Hq
         kon3JPJo1IcTbdJL2KaVY8vLnRPATMCLI5ZJACiqczFx0h7wXsZNpPh56pMC+YTAO9cW
         6XPg2vjaqtITAY9hZVyE6bhzL/BLKppzKSylT9ZNyy0Rn17zbVd0dOqMqj5AMFhpoO7L
         oyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMteWjiol09LnNTGAtg+qqwxoUC+aePsLIm1kIpTrJs=;
        b=kz5/LQ/ADf0AiGZf4lUkOgxYGg6acmIiM9Xxl9m3Rz48Jbi5tfjkFM3372JCW4KZyC
         1uD/CZKFRKu5TK2+Lu4jXHADM/RcrlggmD+lmCWyd0wtZvZx75GCYauUoznnXpPMWt/8
         Wh+cJlyFZ/+PnAB9fpgVU5wQk4++QTEsjDp4s+muYZ2lVViP7MY7y3RzSvR1In4J696b
         GaWF1HjcCdLWApAglRgh6HFYUiFCqK3YoJI1tsg82GQN1XIdX0berC9CWPITB/zsf831
         YbDabLKa6dMYqkbOqXjpAfhh4C8LTUqEzZyAyrW6UjX97XCunTY6MyqOfYPuFC8x2IWO
         inKQ==
X-Gm-Message-State: APjAAAXnfZU6Im4riOaiE/UJK5nVtWhXN5mRc7oDm4jZzvKfkPtkgc+q
        8NXtOYZqa8WwTqfvN+n2fkT6qZYsoVjy9C5OkY0gLA==
X-Google-Smtp-Source: APXvYqwh5XDkO7F2xERL7f+E+ehgrXGdbgDaiyV9najpnyy1GfPAMnxMomE45gSsbegm0OpSlpcxM0Q0s5kDUvwvH7k=
X-Received: by 2002:adf:e8c2:: with SMTP id k2mr9106596wrn.198.1565944291339;
 Fri, 16 Aug 2019 01:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190816065936.12214-1-contact@christina-quast.de>
In-Reply-To: <20190816065936.12214-1-contact@christina-quast.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 16 Aug 2019 11:31:23 +0300
Message-ID: <CAKv+Gu-qbwCJzH2TMpe5hEh8UAO3XQ66Zzf9Nx4UqBXd3Lr79w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Use ccm(aes) aead transform in staging drivers
To:     Christina Quast <contact@christina-quast.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anushka Shukla <anushkacharu9@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zach Turner <turnerzdp@gmail.com>,
        "<linux-wireless@vger.kernel.org>" <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 at 10:00, Christina Quast
<contact@christina-quast.de> wrote:
>
> Use ccm(aes) aead transform instead of invoking the AES block cipher
> block by block.
>

Thanks! This eliminates another two users of the bare cipher API,
which is not the right abstraction for drivers to use.

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I don't have the hardware, so I can't test this.

> Christina Quast (2):
>   staging: rtl8192u: ieee80211: ieee80211_crypt_ccmp.c: Use crypto API
>     ccm(aes)
>   staging: rtl8192e: rtllib_crypt_ccmp.c: Use crypto API ccm(aes)
>
>  drivers/staging/rtl8192e/Kconfig              |   1 +
>  drivers/staging/rtl8192e/rtllib_crypt_ccmp.c  | 187 ++++++++----------
>  drivers/staging/rtl8192u/Kconfig              |   2 +
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 187 ++++++++----------
>  4 files changed, 159 insertions(+), 218 deletions(-)
>
> --
> 2.20.1
>
