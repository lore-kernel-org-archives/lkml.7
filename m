Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEAFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E0206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFAZy3XY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfDDMJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:09:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36189 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDMJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:09:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so1869603ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYO7EPqOGrMp9edmk6y6YZ57MeWm04v2p4X6gCHxcfI=;
        b=jFAZy3XYIUaD5PMKk6OmWwxnhtAn4LbS8jnDhZ5+4zi1EYVcWHR+dkQ3gVAyXlwKAo
         XKlGLibgCQzUzUrmN+QU+Q/l7mS0219mkVhyB4w4LBTNYz3pTKWQsKKfu/psM4FQdXoq
         qtYgq/yLfB4Idag0Cq5tk3OEZBSkcnmtToqyfttpLRpb1R1IjDLXnQeF8TQc1TvmhFvB
         DreUA9de5fNze0FaqP8ZgNIj9XZhTy/BRkIhlpqDw4bNROrdDK2kXIdR2Ws7lOtqpZen
         vXKw0Y3aXxz0zZbxDQkWHTu2BXaTLSlQAyJ7euBknM0QaLc6AEMlXN3gEbzfGeNWeQVY
         VIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYO7EPqOGrMp9edmk6y6YZ57MeWm04v2p4X6gCHxcfI=;
        b=YOCEKk3iLITZUDgD0Jsxm3uQUWVTFM0aQY44qQ9NG+QlRf+WOdo8ETxLKapVM/YAos
         pydGwCn4P2MyJMCa4+tN5VSJPdki36yIK8il3Ky8qsqR8MgmfxtYo9FbvgY3UEyarVHA
         j3jsn6YLjmO7uS0yd2DiCJN5TNueITDZqXDiqYdFOGR86AbS7AqqCwTHzrcf1ZSGGdh4
         RiOpbKQmvF4GvZdBBpRF0wn0cbxwzrXFtIu9jsR5SgXCeTW13xnjBEQ7PfD3IVWzNvbC
         1UuawdU5TpavoF+o3uY5zl5binUx0Ar3qW8mQLCUgXQeN+Af5cYiIaAdXL9d5VcXtOeP
         hzzQ==
X-Gm-Message-State: APjAAAWT4eKO4KuRmBwQMLCtbIKeJ/s5gtccTFgm4BqzLt/7C3jfAGTE
        Zb12yHec9pSVgErvFqbYzOAzLMzlvZnyEF7ciiM=
X-Google-Smtp-Source: APXvYqzfpOqi0nj6BABzdoP8u97h7uqVwbsYo1cPe05sB0MMfAEQFpyBjwI5zGiG6n47VBZDG7Ve7E6/LeBh0XN4olI=
X-Received: by 2002:a2e:7215:: with SMTP id n21mr3398436ljc.105.1554379767063;
 Thu, 04 Apr 2019 05:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190404120703.30054-1-andradanciu1997@gmail.com>
In-Reply-To: <20190404120703.30054-1-andradanciu1997@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 4 Apr 2019 09:09:17 -0300
Message-ID: <CAOMZO5Co=+0wwXzfkc8aGAC7d6Dm7PsHBQcLyx2VVZjkcKrsVQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-pcm: Switch to SPDX identifier
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     timur@kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
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
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 9:07 AM Andra Danciu <andradanciu1997@gmail.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  sound/soc/fsl/imx-pcm.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index 133c4470acad..3ce2f437e645 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -1,13 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

This is not correct...

>  /*
>   * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
>   *
>   * This code is based on code copyrighted by Freescale,
>   * Liam Girdwood, Javier Martin and probably others.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.

as it does not match with the original license text.

You should use:

/* SPDX-License-Identifier: GPL-2.0+ */
