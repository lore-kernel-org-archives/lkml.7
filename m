Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79403C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 21:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AC320848
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 21:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qswe4dgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDNVxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 17:53:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38945 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfDNVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 17:53:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id z9so11459062lfh.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpIeb//6Ka4hpMnT8cTSQA1HkcXYUkXt3zlTY9UdOnw=;
        b=Qswe4dgQ9C3C2lurf3YkYtU/vKm1L/bSN08R4SmBwCpiNkoFwRavtG2s9Z1jvufvGA
         FSiApPWyBVSDo3oZGUd5VgvRC02YsI/b2cbJfnTsZWvpcKt5HoBlzNNUCvcDKi0H1OiM
         iV9mdAsS6K1947MvuyK4kkkNex6lc3SIs9DwdguQpDLgXTpkEMpP279YoHsJJ17mS7UF
         w0Qrhwd8Et5LAu95p2HscgmkEoQy5Yj5p6DRioEoOebiveDOZnxiruTtj6M3S3L6cpT8
         LKXZzJFBOGEWLnv9qrybzc35JZxszczNiwxuSxuX2UgE+tqKbXohLOeeLGIYSJMDdysD
         HrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpIeb//6Ka4hpMnT8cTSQA1HkcXYUkXt3zlTY9UdOnw=;
        b=jl+oSzGdDqiJcBscKOYa0SdXbKmeuxLfWXwP5jgKwtFuH/vun4aQ6anSFZEjYhNLQM
         V9BGxhX9m5vh2WtuTJwV1PyhELs+rgX09nKW5+knx2rTjSMbXt9mPuVbEZ11+EUP7Gg/
         83luaNymPPTzag4f1jmsLeqtap8dvEbui42MSSu5c8PrwDfcA49gx2wSbW9PHowIr+LS
         PrqznODLOR28QDv4tVpAh7xKheeXxDKfnKVbbx7NiorX9S+lCuxBvuggpoPE9vClw4YY
         2gidbKO9Ez4pYaB3Is6Qzl/99h0okIFVW04SNIi2KHpOkwIf8aV1Ja8+V/Osm23YCEWz
         QdfA==
X-Gm-Message-State: APjAAAVUHtEgKADGXPJz58aSHphkeful/NvNLm1uyE2Vqm1v0YvmWzgm
        bVXT0lz/7N12YbB9O8iQgrfgRa3qpYGTKVMstFE=
X-Google-Smtp-Source: APXvYqyQ3fKpGThLNgUNFQM2GJ/9elYwCTp5imoEogWMj5xwYrrFtpvwo1xLuYv6TeidTCFk40fVcepD+ZGjs4/5mJY=
X-Received: by 2002:ac2:5313:: with SMTP id c19mr713689lfh.152.1555278817163;
 Sun, 14 Apr 2019 14:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190414191450.18377-1-andradanciu1997@gmail.com> <20190414191450.18377-2-andradanciu1997@gmail.com>
In-Reply-To: <20190414191450.18377-2-andradanciu1997@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 14 Apr 2019 18:53:37 -0300
Message-ID: <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     Timur Tabi <timur@kernel.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> As the file had no other license notice/reference, it falls under the
> project license and therefore the proper SPDX id is: GPL-2.0-only
>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  sound/soc/fsl/mpc5200_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> index 4396442c2fdd..ccf9301889fe 100644
> --- a/sound/soc/fsl/mpc5200_dma.c
> +++ b/sound/soc/fsl/mpc5200_dma.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL
> +// SPDX-License-Identifier: GPL-2.0-only

According to Documentation/process/license-rules.rst this should be:

// SPDX-License-Identifier: GPL-2.0
