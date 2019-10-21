Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC87CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885B12084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woqRl8XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfJUPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:21:37 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40163 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfJUPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:21:37 -0400
Received: by mail-ua1-f67.google.com with SMTP id i13so3917472uaq.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HvOcHe5sgnM2Ih10HPGzGtz2+0bgk7nxRpCIIRNQM7A=;
        b=woqRl8XYxFpkzjzJqhbqZ/o37KeoHSE0zn/+EdUQU4kQK467JyEQRZgquspYLySMJZ
         vCMxtniRWFfq8PVlZ9OGFFzdq97rjpzYh2Im6/ZIWGl0l35q9u2nYtQ5qwKUF7FS4wL7
         2P0Kj/jEd3jg7Ez+ToqzRJnuVTDh8d3UGFwF8JzCSQDbp3qtYPyET4z/jfS7ij6tJ/hf
         7GL4CWrXtUAiwDnyu7Ne2DqOG71Tws7noIZu7fb3BkqnZcwLLw0UoXtQrahfr6Jjm7pn
         eNodA3bDqT/zML97urY/UvCPJ49M4R8UgiqBKA69H/qeXbtrLLspLWYcCBKJrcF67F5G
         dokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HvOcHe5sgnM2Ih10HPGzGtz2+0bgk7nxRpCIIRNQM7A=;
        b=HMjBflvOsmT0n+amkFBg5CF9hkeT0HWO/L5pzSyBvq5qjL5tSieriq/pKzGFjbbDpv
         eDKGcYR4l+O+Hn9/GAW5kUEs/z6YAQj7goXzpdBWunze5iqxLDPpwsEiX9pDJA+cPWCw
         TRecfRN86j/xNF+7PHX65CzEL8Gwiu4GkH2hUofFtHrec7clFAUfuDc8Ch+eNa/xXdUS
         Nt4Tx1gLXQ5TFLJTkOs01Mhl5ga0fyqW51mHECxlu24lDPrI8BsFNkoHGkPfNl5UThpN
         ZdHLLawZ7ndPsTcKViq0mMom1WrTnP9B4Yh0LXDUOHoSyQtC9XGn/A2qrJObKjnAXzXB
         x4Yw==
X-Gm-Message-State: APjAAAU0Uh9rkxG33negCLAVLSTMdjssOz3ec3RtoD1vrRhppQrWfIG5
        l26PvWdeUhmK1njw2DV7nqNd5IsBOrudCFJOnNLO9Q==
X-Google-Smtp-Source: APXvYqzhMXR2NneFdAKl7YDt/OnBvYSd12yNpMMH2svyTHRBphhTEAUOoTgn9L00HK1pOKlkytzxjOdn37raM4VctCE=
X-Received: by 2002:ab0:331a:: with SMTP id r26mr6180177uao.104.1571671295461;
 Mon, 21 Oct 2019 08:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191021143742.14487-1-geert+renesas@glider.be>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Oct 2019 17:20:59 +0200
Message-ID: <CAPDyKFr5H5x9LRjvVsDbNoGgZx-EnZGgUD9fEt=esN8HumNDHQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] debugfs: Add and use debugfs_create_xul()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 at 16:37, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
>         Hi all,
>
> The existing debugfs_create_ulong() function supports objects of
> type "unsigned long", which are 32-bit or 64-bit depending on the
> platform, in decimal form.  To format objects in hexadecimal, various
> debugfs_create_x*() functions exist, but all of them take fixed-size
> types.
>
> To work around this, some drivers call one of debugfs_create_x{32,64}(),
> depending on the size of unsigned long.
> Other driver just cast the value pointer to "u32 *" or "u64 *",
> introducing portability bugs or data leaks in the process.
>
> Hence this patch series adds a debugfs helper for "unsigned long"
> objects in hexadecimal format, and converts drivers to make use of it.
> It also contains two cleanups removing superfluous casts, which I added
> to this series to avoid conflicts.
>
> Thanks for your comments!

The mmc changes looks good to me. I guess we could funnel via Greg's
"debugfs" tree?

In such case, feel free to add my ack for the mmc changes.

Kind regards
Uffe

>
> Geert Uytterhoeven (7):
>   debugfs: Add debugfs_create_xul() for hexadecimal unsigned long
>   mac80211: Use debugfs_create_xul() helper
>   net: caif: Fix debugfs on 64-bit platforms
>   mmc: atmel-mci: Fix debugfs on 64-bit platforms
>   mmc: atmel-mci: Remove superfluous cast in debugfs_create_u32() call
>   mmc: dw_mmc: Fix debugfs on 64-bit platforms
>   mmc: dw_mmc: Remove superfluous cast in debugfs_create_u32() call
>
>  drivers/mmc/host/atmel-mci.c   | 10 +++++-----
>  drivers/mmc/host/dw_mmc.c      | 10 +++++-----
>  drivers/net/caif/caif_serial.c |  4 ++--
>  include/linux/debugfs.h        | 10 ++++++++++
>  net/mac80211/debugfs_sta.c     | 17 +++--------------
>  5 files changed, 25 insertions(+), 26 deletions(-)
>
> --
> 2.17.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
