Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D256C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFFC20803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjK94ZRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfLDM5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:57:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33668 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfLDM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:57:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so8541235wrq.0;
        Wed, 04 Dec 2019 04:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WX9DsnxjR1TLkIQAS0BjsZD23PSgQu93DSuzJlaRss8=;
        b=CjK94ZRk2M/LKqEEX5rm/3WkZf/HiI3Q+vVXDbZOZxQNFGaqW6DwTHkkkx84vRfS+M
         U4ORtkjPBA9iSMbi9wpu7YmMFTp+pNz3ylxcjalwvJv2KZQBId8X2noNPl++SsRNODK7
         QHPvskaMNV5R762Lpb7nY4iTA+SdVhlMhJxfRgfvM6jxwD1ZNI97gcI1rUhzyzNaVE+Q
         k0Bc2/yGbWtp6U/eTSBRlksg5lobZN4iEcrEFCI2rqfgwYhIgxNwI1rIPCeNNltPaVVM
         rHvfdkl+vcc+QKkCwM59zcflNAcevYc8jww4nTJSaG3Zq6ZEE7D6XZBEvNXC3R/zck1W
         +j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WX9DsnxjR1TLkIQAS0BjsZD23PSgQu93DSuzJlaRss8=;
        b=pxgNVOgwIvkOfmoXERfwOH0Kiku7SN/V9+mRNatB+tUZlpcj0uYwx5WnpaNTD/h+Bd
         FdO7FGNayoTnSeKaMPfDIUIXSSeA7nmuZCyWmKzmCw2FcB3v4lR7G/zKeimLjUfAiz7A
         Q2VD6++zB64LPRbGsrpdkOzZSSHvLQvPyKyZl6ISblWtB72CYBcpCxbFqp9NmQARmOyE
         4tNKgnF6F+CHHulI5AHx3fnf3odzuVoecz2oG/+592xMabSrd0c/h5eUH1c0jIf+QRtd
         XbeGBNNUBzhauA4atFhpwvDRAoKCd74vw33T4c76gOTH36Q10/A6S6PCU6BmM734gnrA
         wJ3A==
X-Gm-Message-State: APjAAAUfurpV8ZteyShaiPCn2cp8mPWYI9Py+2MaEZqvrtBKcn7EglMl
        1NQpLXO8iycKOaavmZ+Zx2n59nnzmR3CQucjwSM=
X-Google-Smtp-Source: APXvYqzndsNueQS92Xe4B1d71REsjlvqx9ynvD8CvVkru+ORVDr1gVmjag6dLc6gMBN+1fpeYUjla8YjTCCO/YsvQMA=
X-Received: by 2002:adf:dd52:: with SMTP id u18mr3950790wrm.131.1575464228649;
 Wed, 04 Dec 2019 04:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20191204124816.1415359-1-colin.king@canonical.com>
In-Reply-To: <20191204124816.1415359-1-colin.king@canonical.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 4 Dec 2019 14:56:57 +0200
Message-ID: <CAEnQRZAEExdNS+=aSFb86OCgWfezEFHYvoAJBV4=DshEprRGrA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: imx8: fix memory allocation failure check on priv->pd_dev
To:     Colin King <colin.king@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 2:49 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The memory allocation failure check for priv->pd_dev is incorrectly
> pointer checking priv instead of priv->pd_dev. Fix this.
>
> Addresses-Coverity: ("Logically dead code")
> Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Good catch! Thanks Colin!

> ---
>  sound/soc/sof/imx/imx8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
> index cfefcfd92798..9d926b1df0d7 100644
> --- a/sound/soc/sof/imx/imx8.c
> +++ b/sound/soc/sof/imx/imx8.c
> @@ -209,7 +209,7 @@ static int imx8_probe(struct snd_sof_dev *sdev)
>
>         priv->pd_dev = devm_kmalloc_array(&pdev->dev, priv->num_domains,
>                                           sizeof(*priv->pd_dev), GFP_KERNEL);
> -       if (!priv)
> +       if (!priv->pd_dev)
>                 return -ENOMEM;
>
>         priv->link = devm_kmalloc_array(&pdev->dev, priv->num_domains,
> --
> 2.24.0
>
