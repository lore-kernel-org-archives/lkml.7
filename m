Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BAC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A592208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZCKuRAAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfE2Mip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:38:45 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33964 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfE2Mip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:38:45 -0400
Received: by mail-oi1-f193.google.com with SMTP id u64so1901802oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FDUDeCcdkQRbyuDM8qhH2Znf4RJm622zVFVk61i9LUg=;
        b=ZCKuRAAryeW8Ea5a25JWdvwmbrdGZA5xPyltiLcgx4QtORZxZ6KJmJtbQxtoNP19Wo
         Xg/dLGf55jPQVSu5FE5JfFK7fc0xjH0pJJreCdlCoRyFKz1S/c3xX7x4shGTa6cUqGTp
         oKnE3uqlDQkPvz9on04775F383vDunb9m+/zLQD6JDlSiH24sbrzBPKZNp3EvsYjVGVi
         Cc5R78VuDWIlrimSCIawnfCim8ruhA683p9xsCjmSGXf5CCEqHbNvBge06/nfVQsMrgB
         FRpBhADe6tsO9JhX7ewzY9eZg/ESAX6zHUISb4osC6OllGV3iXF9sfvcuTLkaZ4LocgQ
         GxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FDUDeCcdkQRbyuDM8qhH2Znf4RJm622zVFVk61i9LUg=;
        b=SJOzftZAysCrEGjYTv5KD3VkNxCq9FgK/kp9Fu8+5dxSmrK2TiK1/zgLoARbseQHv+
         576bbLNe/IAXDhGosOWwy2R9ON7sfsvUtu3oji67WX3crBQvsNYSMhcV5JffCU2zZJ86
         OZR/bAe3IQ7YS2qO/b4Vg/nOtPLTqk4ZDPYO2luKEzQTV5C00jKpu3iJ9ZHHaiKS0SBF
         FfVmzi03WV2rTTjWEmXKLnTwzm/GrcXpax27d7iHBE6DgZpEgdZ5Amc3eOJF5nTx5HMB
         GyE/C2piotu941s9k86EwNbBJZ+H1GDXR2+1kaHiJe2d4kaHMD4W2PfzKLkVtgX380sx
         WOMQ==
X-Gm-Message-State: APjAAAUrTRlWBCSU/doOLTt/pdMalGAu1yCQkYzQGhBh7W2vc+zzxGQX
        uH6PYUuXwbFajiwQV1Qa/jZyQy1rws4g2CYnlFRlqA==
X-Google-Smtp-Source: APXvYqwJ2gAc1xrWfg14y07pweZqCRi8/M2bmVC0WruolqfhcH6WYYDvGNBDBrird7ra9WnVYsJgm/yAFEM1C3i9OeY=
X-Received: by 2002:aca:f308:: with SMTP id r8mr1273650oih.39.1559133524190;
 Wed, 29 May 2019 05:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com>
 <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org> <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
In-Reply-To: <7cac8be1-1667-6b6e-d2b8-d6ec5dc6da09@physik.fu-berlin.de>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 14:38:17 +0200
Message-ID: <CAG48ez1xe0MFrECFHAtiiTn1V0+yvJazuCNEiWWAm-kvUwG4nQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 2:32 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 5/28/19 12:56 PM, Greg Ungerer wrote:
> >> Maybe... but I didn't want to rip it out without having one of the
> >> maintainers confirm that this really isn't likely to be used anymore.
> >
> > I have not used shared libraries on m68k non-mmu setups for
> > a very long time. At least 10 years I would think.
> We use shared libraries in Debian on m68k and Andreas Schwab uses them
> on openSUSE/m68k.

And you're using FLAT shared libraries, not ELF / FDPIC ELF shared
libraries? See <https://lore.kernel.org/lkml/20190524201817.16509-1-jannh@google.com/>
for context - this thread is about CONFIG_BINFMT_SHARED_FLAT.
