Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABFC31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1FA208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfFSSvs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:51:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36526 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:51:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id i21so246650ljj.3;
        Wed, 19 Jun 2019 11:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7ya7a7DboiXIT6zCKu4epQy9R8h+sqP7HJzHJQtqZNU=;
        b=Ze20Ntu7phPAEwu+k5Gouo2ySWRfTks37icGKuczg/GbJCPU3HY6yT4pVmdcv+0p9m
         YIAXihhGcYun1xQemly8ZeJG36kt2CguA8lIvbLyM5zrPXzVunGXxL1nRi8veNNg+0IN
         YP3vCKU5B2gsXknPhQgye72OJBHisB2U8mzs/oyef4UVR5mQ49S9WYCYjw8TJpFV/O/+
         z1eRttk3so31wb4zvu5An/QP5Ec7y4l99tzK4hjPYTBrgBCLPqyuQGrCQxDi3d7KOJaG
         JwtDQAQzd2OUvd/tE6ZmJiNOFtRqaYyilhUpHdEH2vaQSPMi2ENXpdctNXVg7J/PyibQ
         BuJg==
X-Gm-Message-State: APjAAAUzGsy2yS5R2mEnLhFPBCm6b6cjOuclDdkFnrecwFEl/rElKXAw
        rm++F+PEFHknXPEk1/Jc87RQacp9ZRSZ7UMEpdtuBSaZ
X-Google-Smtp-Source: APXvYqwHsmNBGQcwjUpM9diIc7ODooJrd9PMVkfDhLSl7CsKfIuFjHsj8ZcODmGk8/umDC2vZ9olN/utvcqOFuavtkg=
X-Received: by 2002:a2e:9685:: with SMTP id q5mr18634627lji.227.1560970305391;
 Wed, 19 Jun 2019 11:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <c57fe97b-ad4a-874e-663f-7f3a737824c9@microchip.com>
 <20190610062351.24405-1-tudor.ambarus@microchip.com> <CAMuHMdW3=fzFvt+ZmC2B6qf0zEwfvV--HVEoxa06Tk=a=Q1cWA@mail.gmail.com>
 <02babf5a-2a50-848c-27d9-9f810078cbcf@microchip.com>
In-Reply-To: <02babf5a-2a50-848c-27d9-9f810078cbcf@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jun 2019 20:51:30 +0200
Message-ID: <CAMuHMdXi1W1RU8obRUVr=tgsytb=rCV1T+pA=pBxykxHv_WW+A@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: use 16-bit WRR command when QE is set on
 spansion flashes
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "R, Vignesh" <vigneshr@ti.com>, Jonas Bonn <jonas@norrbonn.se>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Wed, Jun 19, 2019 at 5:47 PM <Tudor.Ambarus@microchip.com> wrote:
> On 06/11/2019 11:35 AM, Geert Uytterhoeven wrote:
> > On Mon, Jun 10, 2019 at 8:24 AM <Tudor.Ambarus@microchip.com> wrote:
> >> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> SPI memory devices from different manufacturers have widely
> >> different configurations for Status, Control and Configuration
> >> registers. JEDEC 216C defines a new map for these common register
> >> bits and their functions, and describes how the individual bits may
> >> be accessed for a specific device. For the JEDEC 216B compliant
> >> flashes, we can partially deduce Status and Configuration registers
> >> functions by inspecting the 16th DWORD of BFPT. Older flashes that
> >> don't declare the SFDP tables (SPANSION FL512SAIFG1 311QQ063 A ©11
> >> SPANSION) let the software decide how to interact with these registers.
> >>
> >> The commit dcb4b22eeaf4 ("spi-nor: s25fl512s supports region locking")
> >> uncovered a probe error for s25fl512s, when the QUAD bit CR[1] was set
> >> in the bootloader. When this bit is set, only the Write Register
> >> WRR command format with 16 data bits may be used, WRR with 8 bits
> >> is not recognized and hence the error when trying to clear the block
> >> protection bits.
> >>
> >> Fix the above by using 16-bits WRR command when Quad bit is set.
> >>
> >> Backward compatibility should be fine. The newly introduced
> >> spi_nor_spansion_clear_sr_bp() is tightly coupled with the
> >> spansion_quad_enable() function. Both assume that the Write Register
> >> with 16 bits, together with the Read Configuration Register (35h)
> >> instructions are supported.
> >>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >> Geert, Jonas,
> >>
> >> This patch is compile-tested only. I don't have the flash, I need your
> >> help for testing this.
> >
> > Thanks, this revives access to the s25fl512s on Koelsch.
> >
> > Fixes: dcb4b22eeaf44f91 ("spi-nor: s25fl512s supports region locking")
>
> I didn't add the Fixes tag because this commit helped us discover a case that
> has not been taken into consideration before. It didn't introduce a bug, but
> rather revealed one. However, it's not the time to walk over this thin line, so
> I'll add it, thanks!

Good. Fixes also serves as an indicator that if dcb4b22eeaf44f91 is
backported to stable, the "fix" must be backported, too.

> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>Hi Tudor,
> >
> > Two questions below...
> >
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >
> >> +static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
> >> +{
> >
> > [...]
> >
> >> +        * When the configuration register QUAD bit CR[1] is 1, only
> >> +        * the WRR command format with 16 data bits may be used.
> >
> > s/WRR/WRSR/?
>
> S25FL512S named it "Write Registers" command and chose the "WRR" acronym.
> JESD216D names it "Write Register" command and doesn't suggest an acronym. I'll
> s/"WRR"/"Write Register command", to use the JESD216D naming and avoid confusion.
>
> I also forgot to describe int (*clear_sr_bp), v2 will follow. Will keep the R-b
> and T-b tags since I'll just update comments.

OK. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
