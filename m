Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B65C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBB12077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfLKIjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:39:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35262 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:39:53 -0500
Received: by mail-oi1-f193.google.com with SMTP id k196so12561888oib.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 00:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mq+nJWNrU10kDl2/GzcnaogYUfjOD4ecwSEbpxiarc4=;
        b=mlVlEnU9J9JMh3/ZRp9xBfq3FC4Rg0VO7Uh/3+VqTdpKDldAUwMtLi6t1yA03ZpILo
         8bp6sMixPZSPtQ09xK1al+2b1jeBqOmRhEzVWnbVHiiqSMnTVyaNwIVBNbb2SBmTgPBX
         aMiKrPCMTtIjdnOueHrJZKX84lCezkAWwe/kPTTMXoqOa7iFwMLRvWDWCWi8CpYhQlFr
         fltpXX7vtL5kI0uDyhAunCHf8iaS50nXPnoYob8IT+EuHn2XFg+j2T1x98sT9p1Ewl03
         pYxvXwQ+SVf3B2OaS6u3tbmFOXoR/F1KOfbExEJvkfulBRPT3NjkAULrvPG3DW3P99y6
         kO1w==
X-Gm-Message-State: APjAAAWv6urBPMrVNo3b9AYTiCWFHU5cROfo8LmFRuLFhYoTt051O/yA
        BzhG99FTsw2uGtEQappvzMCCtXcgKhG3BC4elHvVSwB/
X-Google-Smtp-Source: APXvYqxIsG86kgBilRQBdKKrWwzgfwKqOs9z8nWWpdZuWkCuANAZE1sBk07t6w7+r4AIumoCnXkRxblAO1YsWJlBUNY=
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr1735907oic.131.1576053591964;
 Wed, 11 Dec 2019 00:39:51 -0800 (PST)
MIME-Version: 1.0
References: <20191210212108.222514-1-brendanhiggins@google.com>
In-Reply-To: <20191210212108.222514-1-brendanhiggins@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Dec 2019 09:39:41 +0100
Message-ID: <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        davidgow@google.com, linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brendan,

On Tue, Dec 10, 2019 at 10:21 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
> UML_NET_PCAP; this is because glibc tries to load NSS which does not
> support being statically linked. So make CONFIG_STATIC_LINK depend on
> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>
> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 2a6d04fcb3e91..1ddc8745123f2 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -63,6 +63,7 @@ source "arch/$(HEADER_ARCH)/um/Kconfig"
>
>  config STATIC_LINK
>         bool "Force a static link"
> +       depends on !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP

"depends on !FORBID_STATIC_LINK"?

Then all the drivers that are incompatible with static linking can just
select FORBID_STATIC_LINK in their own Kconfig block.

>         default n
>         help
>           This option gives you the ability to force a static link of UML.
> @@ -72,6 +73,9 @@ config STATIC_LINK
>           Additionally, this option enables using higher memory spaces (up to
>           2.75G) for UML.
>
> +         NOTE: This option is incompatible with some networking features which
> +         depend on features that require being dynamically loaded (like NSS).
> +
>  config LD_SCRIPT_STATIC
>         bool
>         default y
> --
> 2.24.0.525.g8f36a354ae-goog

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
