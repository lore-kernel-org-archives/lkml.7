Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30397C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CAA20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfCHJPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:15:04 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46325 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCHJPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:15:04 -0500
Received: by mail-vs1-f67.google.com with SMTP id b17so4390928vsr.13;
        Fri, 08 Mar 2019 01:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smtJkTEvYhLXfvJ7j6ud+jvOAh89eegxegFHjehZDxE=;
        b=tvw72b/sQcHwkKj2bEYYP6uxXDs2fOsbE0yNXIO1z/YoWSBblYJI8DVjdy99TzyP8h
         9Q954xfdPcAmAQiFoOKcQ83YCX3gwG21BlYjGv+mpyxJI4n95752/Okh8H0hDNeWInGU
         /8+rOaMmTwhFhvRIm/aJMTSHAQPe8Tpw5Ip/Nv1iZHTAy8tiVejk0mpJEkdl8pGrBA++
         CUcSm96wIRFHY8jlfO9+7+jLOd9toVNuYklecqgGSQIjBsi7bwArAHR+1PFeU3M+ex9G
         dsC4KDvIwLO3UKavryfTbWbFJB7c+iiTc6a0SUF/O/+zwZby8XoTyYdE0wQQ9PJ0bCIu
         7rDQ==
X-Gm-Message-State: APjAAAXxxpvBI5vAZ/RWXEVnKYT43eSIm/3ImK5ILJUfjutQJpG33qyE
        DSNX5OWYI6V1Q0ikO/fPomo1hl9iOcaOkYG0CysbPA==
X-Google-Smtp-Source: APXvYqxMqsnuoK6kIm+5BVKa13o0JgfUUC4xZ6uDtozvce8nseRY/LDUUdrAnTWTuiB2yrrVLmAEgvk0FkGp9ly3h8Y=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr8326567vsc.96.1552036502736;
 Fri, 08 Mar 2019 01:15:02 -0800 (PST)
MIME-Version: 1.0
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw> <0c54ee2c-016a-bc8e-33ae-fbd04191cc49@cogentembedded.com>
In-Reply-To: <0c54ee2c-016a-bc8e-33ae-fbd04191cc49@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Mar 2019 10:14:51 +0100
Message-ID: <CAMuHMdVjgWNw4fnzJV=Qxs6zyNiBPubJUL-4WDOy26N4TkQ4gQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On Thu, Mar 7, 2019 at 6:50 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01/28/2019 09:49 AM, Mason Yang wrote:
> > Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> >
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
> > diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> > new file mode 100644
> > index 0000000..ea12017
> > --- /dev/null
> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,804 @@
> [...]
> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> > +{
> > +     //
> > +     // NOTE: The 0x260 are undocumented bits, but they must be set.
> > +     //      RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> > +     //      0x0 : the delay is biggest,
> > +     //      0x1 : the delay is 2nd biggest,
> > +     //      On H3 ES1.x, the value should be 0, while on others,
> > +     //      the value should be 6.
> > +     //
> > +     regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> > +                               RPC_PHYCNT_STRTIM(6) | 0x260);
> > +
> > +     //
> > +     // NOTE: The 0x1511144 are undocumented bits, but they must be set
> > +     //       for RPC_PHYOFFSET1.
> > +     //       The 0x31 are undocumented bits, but they must be set
> > +     //       for RPC_PHYOFFSET2.
> > +     //
> > +     regmap_write(rpc->regmap, RPC_PHYOFFSET1, RPC_PHYOFFSET1_DDRTMG(3) |
> > +                  0x1511144);
> > +     regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> > +                  RPC_PHYOFFSET2_OCTTMG(4));
> > +     regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> > +                  RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> > +     regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> > +                  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> > +                  RPC_CMNCR_BSZ(0));
> > +}
>
>    We clearly need runtime PM get/put() calls around this code. Otherwise,
> we're dependant on U-Boot leaving the clocks enabled...

Even that would be futile, as the common clock framework disables all
unused clocks at late boot time.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
