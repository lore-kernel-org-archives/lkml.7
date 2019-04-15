Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B55FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05D2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjDRWsx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfDOH1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:27:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35563 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:27:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so461525ede.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZs1t7dzptvM8+UvWwUnA1FIOgorbXKUPYsdSd5YMlg=;
        b=UjDRWsx2/8KT65imliIICFTyn9za7WkCkdX4dNbGXlsi8Y4TXF084nZjB1w+D5Zv+v
         e6b78n8hgX25KmF5G+ZY2nLBtLIg4bsFrXmnRQUbV6KJyRNX54pKHBSV0/gsZDFN3fC4
         5AuKQQzPgxj9IExk+84rBPLZsirzoLfpOFs3Gp7WJpWn2+PuulQsqjEHZIUygz0uYnvR
         oAPKjN+nGX2ItZ/yc2UWbxfFtxKeP9sBhd1TOM8FDTp9CLpHRT5l3tf/RDtTrfsLPWFB
         asSOzuhTjfJnMahs3w81X0gmmtU4H6V1tyY4RUYEtwAuJlXniSKRtsRyEhCi+QiP+YLw
         fLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZs1t7dzptvM8+UvWwUnA1FIOgorbXKUPYsdSd5YMlg=;
        b=U0js8k61QoIOiN7yxCOAhjsoDwZD0t9MI2Fg7FVLj1ik5kHCYw3DD5X3oZB1dXfb1l
         oVEXRXQprVCFqrKEM1NG7BV2xE/bY+CxF66ZzZIjucpnMu6iJNWvOpMhA6FMVGz3dgNU
         SFuejnoRXmxXVda/4p3uD84/u2gLjibR2pzYYFg1TURMu+dGGGx4qbOTCNQxxBavttZi
         zykxCBUycBUM2rYd8LB14kcEt21d8O8DdaG9wAGXkawe5cN1VM+AGsC7sMZXqFXrV0pi
         TFWbtGLSJzX6chxEMNAC1FAMr+4fu6eGXI/E4qVaojsLSasFieJ6nd0WOHg3e/sSXvnr
         VU6A==
X-Gm-Message-State: APjAAAXCIszh3iOeTJ+On07vig2QypoA+lWNdCVlmyGyTHx73qrWi5Vu
        fcQ3JCL87JCdpfcgIy1nEx6LTkvvA4YdupaJpRk=
X-Google-Smtp-Source: APXvYqxHfMUzdZo3n/YAwd+9RzuAEF6B3wFCmP8V7JFd6g7AiuXXisPrtTrT/2yO4R7m1dWvx3Ppu89kUROufhXRRxI=
X-Received: by 2002:a50:ad58:: with SMTP id z24mr7201898edc.75.1555313225459;
 Mon, 15 Apr 2019 00:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190414191450.18377-1-andradanciu1997@gmail.com>
 <20190414191450.18377-2-andradanciu1997@gmail.com> <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
In-Reply-To: <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 15 Apr 2019 10:26:54 +0300
Message-ID: <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
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

On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> >
> > As the file had no other license notice/reference, it falls under the
> > project license and therefore the proper SPDX id is: GPL-2.0-only
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> >  sound/soc/fsl/mpc5200_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > index 4396442c2fdd..ccf9301889fe 100644
> > --- a/sound/soc/fsl/mpc5200_dma.c
> > +++ b/sound/soc/fsl/mpc5200_dma.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL
> > +// SPDX-License-Identifier: GPL-2.0-only
>
> According to Documentation/process/license-rules.rst this should be:
>
> // SPDX-License-Identifier: GPL-2.0

Actually
