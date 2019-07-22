Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC53C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E9C218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K64SEYcl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfGVOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:36:40 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:38148 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGVOgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:36:40 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x6MEaU6s027805
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:36:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x6MEaU6s027805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563806191;
        bh=97xkgWS+1emOr9o4Y+tbx8rUVVkeFCfWt/pH2eQTRwY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K64SEYclpAkwxjkXxXgCfY4/t/xjClYY37/tL4YdsmsM74m7r5YaMU8rM+c7Z5lA7
         6DvXrxYQAmxDII+tlzNl4f7F3AgAvz+jKud0lLA/jqWoXMouKRN+EEypIC2vQ653Bo
         pOZSrNQ0yu1dbsvpA6PrkvVi3OTOsaWN9VnDuaKQtU/k9RViDEAzUlnbMy7lTB4Gp9
         thvBPg3175J362C/9ckxVtCLgu6nyws/yw2zx3wPXk3ILqmF9jxVqQPeD5pFHtdxuW
         Q6//I5c8MC0gStLL3FG7n/aNg950wzGBOkpDy2frOzAsr9BnsXg1IrCzJbWoE3He9D
         s6GIxg28Mq8Wg==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id a186so24612749vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 07:36:31 -0700 (PDT)
X-Gm-Message-State: APjAAAXYjJu6Y2dgJqKHp8HzvWvF2a/yq7dlqymTSsJgvwMeHVkcX2Ix
        SRolLWfeQu60hoMQ3cUSfoc0gPx9W3pNcMr/bNc=
X-Google-Smtp-Source: APXvYqyAnMeozdA27fgOHdSsZiQ81FCIIL8bkY8/1xNO//qimbuzyBzmbPcQGvwOpaXgOQDbcMrVdz2BRZZSK6Fup0Y=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr42296834vsl.155.1563806190088;
 Mon, 22 Jul 2019 07:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190721142308.30306-1-yamada.masahiro@socionext.com> <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
In-Reply-To: <CAK8P3a01MzCTJnk_fuMgWsRBa3u_CEZegZqH37G7qLiquHWncA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 22 Jul 2019 23:35:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATSrD-toRZFmQw8cO4D2mRomc=Xw=topA1Ry-0yM=ackg@mail.gmail.com>
Message-ID: <CAK7LNATSrD-toRZFmQw8cO4D2mRomc=Xw=topA1Ry-0yM=ackg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: use __u32 instead of uint32_t in uapi headers
To:     Arnd Bergmann <arnd@arndb.de>
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

On Mon, Jul 22, 2019 at 10:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jul 21, 2019 at 4:25 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> >  struct snd_sof_blk_hdr {
> >         enum snd_sof_fw_blk_type type;
> > -       uint32_t size;          /* bytes minus this header */
> > -       uint32_t offset;        /* offset from base */
> > +       __u32 size;             /* bytes minus this header */
> > +       __u32 offset;           /* offset from base */
> >  } __packed;
> >
>
> On a related note: Using an 'enum' in an ABI structure is not portable
> across architectures. This is probably fine in a UAPI as long as user
> and kernel space agree on the size of an enum, but if the same
> structure is used to talk to the firmware, it won't work on architectures
> that have a different size for the first field.

Both comments from Arnd make sense.

If this header does not need to be in uapi/,
moving it out is fine.

But, looks like Mark has already picked up this.
(His review is so quick)




--
Best Regards
Masahiro Yamada
