Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862B82083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFB5pYUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDIKJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:09:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40394 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfDIKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:09:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so14388373edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 03:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mr+UjOk5eBPIlJTqvJkBS7d2+nG7TIj/ncHy/1Hc4O0=;
        b=dFB5pYUb8ioF7ELqO8UytNYkqIaVyUnLp8SkgGMDyWEVOjIMLMp8vnSd7myddYLiCQ
         gwGEh5LKkLI6ro8arOSTWhTlOfNjgmgCNP4DOD1noHS8+qTM6W23glBhe2haDjDfa/f/
         Xw6ndu95Xen9ftUWD6BY6WtROG1Po0gXH6Gn7VbgOLP3/SlO0F0vQvGb3gYJ4wcrmt/A
         LnykNV6dWMdQJDjkkyBImD5Hb8SVskbgu7pchdzjBRdO7PXdvHFv6ZiHdp5gvI30v9PC
         jqXV8vahiuSV+19SjxsShTbnHDH8dsJ9jfunM4koOTxeuioNbNSf49kJCRX3sK6Vn+Oa
         u5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mr+UjOk5eBPIlJTqvJkBS7d2+nG7TIj/ncHy/1Hc4O0=;
        b=RhSAijdRoT8dUwhFSDRe7koSlo8lSNZWORcn9K5NSapf/lHl4ELiOO6E/aNYimGrSv
         rR3flpVU1Xv66ozUEABsoySgtRO1F4rjOQAStreRnoodJm+ripHMZr8egkzeRBifOCSS
         GJU5fLeQLkH5I6DbKS4QhnGJG9akZGirbYpkJKcvka+3EPIx1fOW7rPVXBz2nO+gl49H
         ADvvMHCKZH9xgEKwdzs3q3RUWE88ncuQkbaYGKtm69DFccF7jrR2/mseE+WWOzEsAig7
         m8O2AQpCSE/zCMKO5E5yCuO8Gp35SHfe9wTu/iT9+vd4u1u/9Tzh5+TnY0CgFKK0ZJbd
         APmg==
X-Gm-Message-State: APjAAAVvvYm4fTETVJQn4IjOXzWntCE/Ugc8dkSsc/tvS8zCjMRqH/c+
        Z8ux+v5zy6vXR81m7ufAsFp6lFzcenWHdYTpFAk=
X-Google-Smtp-Source: APXvYqwX5ZHbTLEAFnXBhWCLHakyFxqmoaR6Kt4to0CnsX/Dsv+RpDTYx5tMLyyNiZKuZt/ISlkpgkp4jeiC7PCb/jM=
X-Received: by 2002:a17:906:8281:: with SMTP id h1mr20048731ejx.124.1554804538919;
 Tue, 09 Apr 2019 03:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com> <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
In-Reply-To: <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 9 Apr 2019 13:08:47 +0300
Message-ID: <CAEnQRZDQRTy+D0ntbTh2OCPfBM_N=yFP-k_JXmF7p-5vsku-ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: imx-audmix: fix object reference leaks in probe
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:36 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Please add here the Reported-by tag pointing to Julia.

> ---
>  sound/soc/fsl/imx-audmix.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
> index 7983bd3..7c24095 100644
> --- a/sound/soc/fsl/imx-audmix.c
> +++ b/sound/soc/fsl/imx-audmix.c
> @@ -20,10 +20,7 @@
>  #include "fsl_audmix.h"
>
>  struct imx_audmix {
> -       struct platform_device *pdev;
>         struct snd_soc_card card;
> -       struct platform_device *audmix_pdev;
> -       struct platform_device *out_pdev;

I am not sure why are you removing these members here. It doesn't seem to match
with patch description. If these are needed to simplify the code please do it in
another patch.

This patch should only fix one problem and that is the refleak.

thanks,
Daniel.
