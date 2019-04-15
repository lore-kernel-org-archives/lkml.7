Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE25C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCF420881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxY4w9hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDOH3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:29:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35777 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfDOH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:29:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so466475ede.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 00:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZ7qWGoPqWcS4YQFz4saWhW/MfiFjngdMn05tjxAgyo=;
        b=pxY4w9hVemR/TFA30aSbZt7AX3XXLMpRPG7KP1pwTxr6ROfoW/fLNjOg+4BNDIOGAa
         rtmyS4RZgxP1SXpnxU9LechxQ0RXGsS49e7MlMJI5Z+hvW6sK8hcqgwO/JvRwK8+dIrE
         gMFIp9XDFg08+BWoH2li7Sc1ZL8WiPXkuF2NL4hhIwa/PGNZVy1AIR6d5oPCJANso6UI
         3BwoPh9lLXmI1zBa0wPnyHMhhs9iNHlJwR2Pn5VWQROMo3Ajrz7nFwWKXWWtQDLEMlCw
         71OL6zisbrj6uriSnmCLQEFlSg0oQi831X+QUUGA6jeWCBc7HZhT9OE/sb1HYVHvTOKA
         7wOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZ7qWGoPqWcS4YQFz4saWhW/MfiFjngdMn05tjxAgyo=;
        b=hxWh18yGJkZGcMWaSdrnzCWKLZHquQhZzYSVHl0jNm3mEcJ/2sU4YlywAmuGPc63Eq
         DCrW6tRrDZpPfZRvkhNuJMcJ+MJhrPY0e8a/pggd24VvI130U+lghNWvu1IkErrcY5YB
         BhvFvOxz4JMwQkUeFySWmxJx2Kmi0r1PklA867MAHzwkNpvi6v+7uXD7RTvb7IEowgqu
         Hm3RW+L0pW4gcbp8P5RZueDdFKC3+gEisemAME9jGEOxcb2XjT833awuBFi2C6hIABMr
         xL1di40ljSnRrWu9HwcMR27FOyJ9Kp0NTIhvP3nYw5ahAXWtsEmqx2G87aZrDi158Kcv
         keaw==
X-Gm-Message-State: APjAAAX/hgGeCycWOvluNzwBoS4px6lHa9udOB1QbOTLmfhT4u117nQ5
        ewR1jm4dLSRBYFVmY6YOrqlMsPuWZe7Nv9K6P5I=
X-Google-Smtp-Source: APXvYqyHD18l5R0sZwnSODvLqhzvz0Gu56qQ+RIn13F2VREKVTwjZg2GDgICzoVehCK9WmHSYQi6S00RLwBgHiWDl+o=
X-Received: by 2002:a17:906:950f:: with SMTP id u15mr40804205ejx.118.1555313358469;
 Mon, 15 Apr 2019 00:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
 <20190414191450.18377-2-andradanciu1997@gmail.com> <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
 <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
In-Reply-To: <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 15 Apr 2019 10:29:07 +0300
Message-ID: <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andra Danciu <andradanciu1997@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:26 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> > >
> > > As the file had no other license notice/reference, it falls under the
> > > project license and therefore the proper SPDX id is: GPL-2.0-only
> > >
> > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > > ---
> > >  sound/soc/fsl/mpc5200_dma.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > > index 4396442c2fdd..ccf9301889fe 100644
> > > --- a/sound/soc/fsl/mpc5200_dma.c
> > > +++ b/sound/soc/fsl/mpc5200_dma.c
> > > @@ -1,4 +1,4 @@
> > > -// SPDX-License-Identifier: GPL
> > > +// SPDX-License-Identifier: GPL-2.0-only
> >
> > According to Documentation/process/license-rules.rst this should be:
> >
> > // SPDX-License-Identifier: GPL-2.0
>

Actually, according to

https://spdx.org/licenses/GPL-2.0-only.html

GPL-2.0 is another name for GPL-2.0-only
