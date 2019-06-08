Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A366C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F72080C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 12:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfFHM0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 08:26:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37152 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfFHM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 08:26:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so4031093ljf.4;
        Sat, 08 Jun 2019 05:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u15W/fIrN+A+A9eO6bbIJS40eyoRKTuHsLVI7+OiKkE=;
        b=ZVEvN40tyxcGaMeNsi6HTZTnJmfTdSCgv38pnad2D2MO7lZ1RlJInpaM/yqcFuPPLD
         AkTLDygwEWuFoh0UgW0QQxXbQYHsL/xo6+eVkzNpIBwXwVVJJUHeigdmL65rmODnMKQl
         nJHHYmSbDF3XHtviLZo0DF2xHOAEYzPQRqYNhkNLVhCrismCujUomWKm/HwXrFOunrTO
         V9NDoL8uRq6AS8epfJGvnrJmpRscU1WnXpa4Q3ix74ypGkNbcANyk/El5o5cUb0ZMgyH
         sx3flI9eGqBXOsl3omqia/ZPYDteZRPOdw0FceVYcBPFN0+gRs49tPSy2WVHBtmMH/K5
         I9oQ==
X-Gm-Message-State: APjAAAWyFOQBnfjh0CyZga/JHr++P05MrBfkVthV9HW208mADYKs/3N0
        k/oVCr+l3dv5+bhTapGzpXAjrUxRYFSylBgohy+8Lyoe
X-Google-Smtp-Source: APXvYqxtBgVt8JYKOjfxltgTzlHN/+F0QTw5ymU3vxqSf6Szz1J/BFpi7y75dMnW+cchpDclTgjwvRMUXbiZXces1DU=
X-Received: by 2002:a2e:7f15:: with SMTP id a21mr12523097ljd.51.1559996780146;
 Sat, 08 Jun 2019 05:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190607115404.4557-1-embedded24@evers-fischer.de>
In-Reply-To: <20190607115404.4557-1-embedded24@evers-fischer.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 8 Jun 2019 14:26:08 +0200
Message-ID: <CAMuHMdVGhd3KfRq9F+-Qzc7q5kJyczG1RRQDpgs4FqJpPwK4QA@mail.gmail.com>
Subject: Re: [PATCH] sh: dma: Add missing IS_ERR test
To:     Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf,

Thanks for your patch!

On Fri, Jun 7, 2019 at 2:04 PM Rolf Evers-Fischer
<embedded24@evers-fischer.de> wrote:
> get_dma_channel may return ERR_PTR, so a check is added.

It may also return NULL...

> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
>         struct dma_info *info = get_dma_info(chan);
>         struct dma_channel *channel = get_dma_channel(chan);
>
> -       if (info->ops->get_residue)
> +       if (!IS_ERR(channel) && (info->ops->get_residue))
>                 return info->ops->get_residue(channel);

... in which case .get_residue() may crash, as some implementations
dereference the passed channel pointer.

Hence !IS_ERR_OR_NULL()?

I didn't check the other callers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
