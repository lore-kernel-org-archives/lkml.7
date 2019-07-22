Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A875DC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86072216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfGVNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:40:13 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33764 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGVNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:40:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so34305311qtt.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv3Di5zFjee/5uIy87kvMrew8FbfGsaqzmofrRO1ci8=;
        b=KeT1FRww1t5+RU0+oNWrn6e0LWw6bSDpnhPvKIeC+yqgstV9tRPKFpV0U3IOAZrEF1
         9Vu9OCM63w+3c0xHaOO1R4G6s2t9Z5luyTS0wCTWqDvAeNcWUPFxzXAwb0Gdld9Znl1e
         7MMoe2OdNxor4ILq80R7By0EvjPLIUMVMPv3akSuWhslz4FxmN4Y4+bVPyjP3diLLXgO
         els6w6HuI5opPPh48GVIFVY52h+wsBGE7jTR5M01ZFZYnLgPtG0I4dEMfskDjEdSMp9i
         e0fsQ/cNmSowDBMNgmO1qXkUYX36jElgw+setYb2B9zjvguiDMynuc6M7SYyS0aUPpgN
         7Qdw==
X-Gm-Message-State: APjAAAWD9nlpWJBGV3okqHUEEbUraLOZaZtby8bTsixrHAqBJOkT64a2
        END+hNhQLrsuWlsDFv872DNJ9qpg+ap5RyH8D7YmtH5d
X-Google-Smtp-Source: APXvYqyTuLcNdosoh+LeAl/GQzQpUZHJkEpjoi8KGP5gY16F6IIHBf+uq9kFjJjVY+hCkSQkeUo0n/D6sYOhRmZsPIs=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr50452880qve.45.1563802811962;
 Mon, 22 Jul 2019 06:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190721142308.30306-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190721142308.30306-1-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Jul 2019 15:39:55 +0200
Message-ID: <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: use __u32 instead of uint32_t in uapi headers
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 4:25 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>  struct snd_sof_blk_hdr {
>         enum snd_sof_fw_blk_type type;
> -       uint32_t size;          /* bytes minus this header */
> -       uint32_t offset;        /* offset from base */
> +       __u32 size;             /* bytes minus this header */
> +       __u32 offset;           /* offset from base */
>  } __packed;
>

On a related note: Using an 'enum' in an ABI structure is not portable
across architectures. This is probably fine in a UAPI as long as user
and kernel space agree on the size of an enum, but if the same
structure is used to talk to the firmware, it won't work on architectures
that have a different size for the first field.

       Arnd
