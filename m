Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23377C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B6220863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkup03gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfCBQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:22:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36883 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfCBQWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:22:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id q206so473625pgq.4;
        Sat, 02 Mar 2019 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ntKPzUe7j7kGqDRoDP5v3yJz1xED3KNbkmElCBRICcw=;
        b=tkup03gwWhg7alEXd9dBQr/8qeu4UNdPOsEH9mupvGzV2tqGvse0Rh4Qy9/9VUAGLV
         ajx9bFdYJTLp8LgUBu1Z5RhgNhKMBJj6YEUNnNdY5doM9PwbwtY31zWOoPI1+Zj4jSAE
         /RJyRGeOgQg+866WfMk0e9fWAcSpDlOwB9ex/ssOJbIobEiQc3uS7moUcustjsCkUPp/
         SuSfEkdLaCB6jnhaHLzqcjKxWbYBz5yHZ5F3qdn2FrdvyMOQwXC51aVLA/xZv/kxUo1E
         lgTVFK2tvQdNaQAKLfOj8Tm5eDCcN6F7kN0XcX9fE5R55+T5Ah3iNJnM8ZWXGs+/NzBB
         LRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ntKPzUe7j7kGqDRoDP5v3yJz1xED3KNbkmElCBRICcw=;
        b=StUwxakeDIHxRlcEOC+N54hzQjf0IOffcqBZuOXYnqidX6T72Ryo1IUrmPogYY6pZR
         wmWexECOqQluWlhG6zESj7zheeeQ08/u69jcFoAWpVlU6RpacN8abXOPkUXTAQtxrxsL
         41PRPIfNNt2avunZlbA7rPP2PcVnRSUFBeE8P2/vHXehIFAjxqyhgf1aiAI/j+WYXI1e
         ja4+UP2PZwotcoA22/RdeXkNwJuOTMaF99Wfc8RDGq1hWZA4+y9/WBs1XJzpSqjdH9yd
         A7+7PvRT5g5wCV6Yik6o+WNWNlws6l/LwQU2F0+6X/t8baQRQ1wUgi70XAbQVnMY6yqE
         9sTQ==
X-Gm-Message-State: APjAAAUPZ/i9qXZxrDGsRGgOco/R7MCMe2PXlCOqkPnkPjRfog/ttra2
        ysgFTvNTlMVZ+Ehtk/ZqCemHfD1rCjKb382SRiI=
X-Google-Smtp-Source: AHgI3IYWrTK29a6ymihNOxsE5D23bOIcgTojJXTu73673TeXEkMx6H7EYxdSJBvl2koM47c/Hz21s492cSt29jRSxbA=
X-Received: by 2002:a62:5e41:: with SMTP id s62mr11253869pfb.232.1551543740539;
 Sat, 02 Mar 2019 08:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Mar 2019 18:22:08 +0200
Message-ID: <CAHp75Vc-WYUJgaDPuWUn-_0Cizq=MG7N2cdHJxaEbad+xntcjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] i2c: core: introduce atomic transfers
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 3:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> So, finally, here is the second RFC for supporting I2C transfers in atomic
> contexts (i.e. very late). This will need some text because I tried some things
> on the way but had to discard them. However, I think it is important to have
> that documented.

> Sorry, no TLDR; text here - I think this topic deserves a few words ;)

Thank you for this work! It was indeed interesting reading.
And since your series is targetting some exiting use cases, I would
drop as well academic variants of brain-damaged hw design, I think it
worth to go.

WRT patches,

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

for patches 1-2
and FWIW for patches 3-4.

For the individual drivers I can't say much, code looks good, but I
dunno if it's correct or not.

>
> Looking forward to comments, thanks!
>
>    Wolfram
>
>
> [1] http://patchwork.ozlabs.org/patch/1044789/
>
>
> Tero Kristo (1):
>   i2c: busses: omap: Add the master_xfer_irqless hook
>
> Wolfram Sang (6):
>   i2c: apply coding style for struct i2c_adapter
>   i2c: core: use I2C locking behaviour also for SMBUS
>   i2c: core: introduce callbacks for atomic transfers
>   i2c: demux: WIP: handle the new atomic callbacks
>   i2c: tegra-bpmp: convert to use new atomic callbacks
>   i2c: algo: bit: HACK! add atomic callback
>
>  drivers/i2c/algos/i2c-algo-bit.c      |  5 ++-
>  drivers/i2c/busses/i2c-omap.c         | 79 +++++++++++++++++++++++++++++------
>  drivers/i2c/busses/i2c-tegra-bpmp.c   | 27 +++++++++---
>  drivers/i2c/i2c-core-base.c           | 17 ++++----
>  drivers/i2c/i2c-core-smbus.c          | 25 ++++++++---
>  drivers/i2c/i2c-core.h                | 15 +++++++
>  drivers/i2c/muxes/i2c-demux-pinctrl.c |  3 ++
>  include/linux/i2c.h                   | 38 +++++++++++------
>  8 files changed, 162 insertions(+), 47 deletions(-)
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
