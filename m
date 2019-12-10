Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A090C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504682073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfLJIHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:07:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35787 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfLJIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:07:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id k196so9022674oib.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 00:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RAW380bDza2LKCex9KQLfz6c9wFFEA3z1oJn/Qeiu0=;
        b=QWPwSTzsMNeiyfzCnFf22C8sBQJKZm/7e17UQSo4Fa91U0Q3SeTXOrk6bbgqJ1AwiI
         GSu1TqeLzpMEO+QlfZudYvp4qGyewV/Rx6qZl/a04oh6/lH0F/S8batCS+l3nNvLG/3C
         6r+8VVDbN4S5w5Yz27w/pTQFOP5P4y9/6yFa5KlR8J42gejtR9Q/HmEMC4YLvGF7uSOL
         VZ6iJrJTva+GvgbN3tdxf89BEkaLbVe8jRieRFps510SrQmo1GGRh7DSRB1myVYdCHpL
         laRkbHDWAbo8h3oRb2yOv7Gm9AtWS9AELKnRq/olDrTV3uDw+h96uglILnMVCRIeud04
         M+1g==
X-Gm-Message-State: APjAAAW9Yo+C+fy02sPI8VC0O0LTI9cw7SFTRvnIH3fzZKY4ibYyP0RP
        9+IYIV5QnDjk4y1q1kQRKYhH6NRfGVmp0UuGgBs=
X-Google-Smtp-Source: APXvYqzu673xkLxZjGzcFmP2gnpxWBzLKC06UrqBZdREMME4Qz3IlhXWOgDHBacKONSO+XGhYQ2ODK0lnzpRKQ2r+Sw=
X-Received: by 2002:aca:4e87:: with SMTP id c129mr2806009oib.153.1575965228901;
 Tue, 10 Dec 2019 00:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20191016210629.1005086-1-ztuowen@gmail.com> <20191016210629.1005086-3-ztuowen@gmail.com>
 <20191111084105.GI18902@dell>
In-Reply-To: <20191111084105.GI18902@dell>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Dec 2019 09:06:57 +0100
Message-ID: <CAMuHMdXVGuu5ZpwA-H=1QJ4PHZeH22CG_AU71nJDYqro3pz6hQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] lib: devres: add a helper function for ioremap_uc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Tuowen Zhao <ztuowen@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        acelan.kao@canonical.com, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 9:45 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 16 Oct 2019, Tuowen Zhao wrote:
> > Implement a resource managed strongly uncachable ioremap function.
> >
> > Cc: <stable@vger.kernel.org>
> > Tested-by: AceLan Kao <acelan.kao@canonical.com>
> > Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  include/linux/io.h |  2 ++
> >  lib/devres.c       | 19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+)
>
> Applied, thanks.

This is now commit e537654b7039aacf ("lib: devres: add a helper function
for ioremap_uc") in upstream.

Do we really need this? There is only one user of ioremap_uc(), which
Christoph is trying hard to get rid of, and now you made it mandatory.
https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
