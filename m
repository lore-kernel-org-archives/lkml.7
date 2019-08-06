Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F63C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49C2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732237AbfHFIKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:10:00 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45192 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHFIJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:09:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id m206so65316807oib.12;
        Tue, 06 Aug 2019 01:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HI/+7QvjOEEoVFOc4ETmV3V160VHifVAi0bhs8u9DNc=;
        b=UYwidAN0xHPrmfsQe1KwrXow2KnQBEm63yvsRL61+T4QMyWhjbpPiyYx4A55H/kdt8
         Kd7zZb2TIzbbjQR/jsjkaHA0su3r1DaKvNEyav0SEaaaWIMKgxRafbIj0UV3UPyFGidE
         shnBgAxpCSBtT6NhZDfb2OVwFD3/nzYnZ4P7ifab0W+NYF8ARlI2QmnPjCQCrCn/nInd
         jS/4K5IodgOd6yoFIuvnv3QGcMAT/1SBuJg7KMjbpwrW+vRiZhiqDp6TVZF2sALfYquW
         rhuSsnCORkDKdpkW6u1p4tRodr35h4eqI9uvzy6tZvOoXHXQ05t6oPSBIznWgwmQnzta
         Gz9g==
X-Gm-Message-State: APjAAAVQz1KgaPOzxOGq93ik4lF/m4nS6tQNvJ59cVbWjwkBoImSPKn8
        py7N0bjI/BCcp7EFNcGBRye4v5+R4LuS/VCGGLA=
X-Google-Smtp-Source: APXvYqz1js8z8HnmSWxxKzsp2msa061pGX5lcuBT8TeExknala5sT01XRBUZ9FPRw+Q+arpqH93gKXBN9yl3l+BsKBw=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr1824672oie.102.1565078998482;
 Tue, 06 Aug 2019 01:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190802100349.8659-1-frieder.schrempf@kontron.de> <20190802100349.8659-3-frieder.schrempf@kontron.de>
In-Reply-To: <20190802100349.8659-3-frieder.schrempf@kontron.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 10:09:47 +0200
Message-ID: <CAMuHMdWoyfkyytRz8BJztpeAKLRY45UKLuy5hNU0e7QYYQYJ9Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] serial: sh-sci: Don't check for mctrl_gpio_init()
 returning -ENOSYS
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 12:04 PM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
> if CONFIG_GPIOLIB is disabled, we can safely remove this check.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
