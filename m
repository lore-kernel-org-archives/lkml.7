Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD610C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 20:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97779206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 20:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbFFD5EG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfFIUmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 16:42:44 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41131 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFIUmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 16:42:43 -0400
Received: by mail-yw1-f68.google.com with SMTP id y185so2979766ywy.8;
        Sun, 09 Jun 2019 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dHOuiC6jFhECkmRndI+3xRNUfQfecXP3FcFTB3ajICg=;
        b=mbFFD5EGsJnRs+WtuLfzRnsU7i83wTtVB8J5XF2rATaAIYVOgMz7F+JEZGNaHzUvfF
         u5YmOGLpbDkZeGXy6PutvA2NYPJD/76V68n75vw7IvryLqcXA8t6Mum9qFVRgLYgc+w3
         LfNNl6FRGbUzWpheasOWOowkbIvUWj3rKdMMZCdaKgHyzy+gIePTpGCuIoO8hd5/ho6F
         k+1i6cRy3eRvVKwhxiZZBmKsbDy6P0T5DlgkhIRp1GyhhxiQfy86M5t5Q9TnmQ4OJ8RB
         Ri2q95+a8BTeg3xz7IUwzBSXkLmM5ZZlb925gAjT8bg95v1qfPUsKXkWrsG1PwBMOVps
         8s5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dHOuiC6jFhECkmRndI+3xRNUfQfecXP3FcFTB3ajICg=;
        b=ZGWWTcfbhv2mj55vsa3Tj4MYcfMs9CRef/IzgI6PgNR4qC6YSrY+3T7DhVrZ4Xeg95
         4jNdb8eKBkMArmzazY4prEs1RMfGG5THSopksg4Le5tfWAG8S/mrCNMSc/ajnGQE/tPm
         1Aai0JhXG6XuZOIh9Qjf5ZGtMdADJD5bYOpxKA70sM8YHyWIcjelU0VhU6uxKw/Pgf6o
         gLpom67QrKVCWu+rNty/bmBHQruYwW2j+orwUDJgVU8WjFbBDfxBgr3rbq/QSbKxywsx
         n0UI8XQSo2DEKkYRbG/ADqipuWfjx+UNIALtxhLNy/eCCLU4keWWvLfpgslTuOxOi6+0
         aaGw==
X-Gm-Message-State: APjAAAXcQnwWjTAaIsjUbjWD5bIVeIsBue+yFUwVnjn6dVZ0jyG+iIXR
        flJ0J+ETV/syj9gCDRI/q700b07U8ZVaA1E9Ksc=
X-Google-Smtp-Source: APXvYqythVEaeiFW8xnZx3alFf6puC+4RKU77X/tV3b27TEXcp0Dskr/eyS/U9ZI1M0PKDZN+WyHQVOaeJi7ultK2nw=
X-Received: by 2002:a0d:edc3:: with SMTP id w186mr13821844ywe.306.1560112962176;
 Sun, 09 Jun 2019 13:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190527201459.20130-1-peron.clem@gmail.com> <20190528111024.gj25jh5vstizze74@flea>
In-Reply-To: <20190528111024.gj25jh5vstizze74@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 9 Jun 2019 22:42:31 +0200
Message-ID: <CAJiuCcebCkdkR9tDOUOEO+Rs-VuSUVLtDpqw3pWUX8o8aPtMsw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Allwinner H6 DMA support
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Tue, 28 May 2019 at 13:10, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Mon, May 27, 2019 at 10:14:52PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi,
> >
> > This series has been first proposed by Jernej Skrabec[1].
> > As this series is mandatory for SPDIF/I2S support and because he is
> > busy on Cedrus stuff. I asked him to make the minor change requested
> > and repost it.
> > Authorship remains to him.
> >
> > I have tested this series with SPDIF driver and added a patch to enable
> > DMA_SUN6I_CONFIG for arm64.
> >
> > Original Post:
> > "
> > DMA engine engine on H6 almost the same as on older SoCs. The biggest
> > difference is that it has slightly rearranged bits in registers and
> > it needs additional clock, probably due to iommu.
> >
> > These patches were tested with I2S connected to HDMI. I2S needs
> > additional patches which will be sent later.
>
> For the whole series,
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks, Is it ok to pick patch 5/6/7 to sunxi tree ?

Regards,
Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
