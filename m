Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB72C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16142184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIzBGpzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDKLPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:15:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38600 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:15:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id d13so4858275edr.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMzOF4uSDEO2czI0u54xXAsMS0XJszj2itVS4kGxliE=;
        b=aIzBGpzEc+WkohNa9Z2aqEpD+O1b6cnlEt1JZ42UBLnEPAK5ueo66UUwQ/3uDaeSxt
         CAv2HaWP/4BrjgujYwvqBHpvBGVdlhfbPFql+Z+kidt4EmeC9c3R5JWjhJwCZq6vvVsV
         NMGmkGZGS/pJIs9cLnp70uyDsdBbaUJ6FO99Z9J6H0rHhGTVTQm1WauPAj3TkDZzt+1P
         +sZNna9PN0nRvNcrayjq8YJqAp48Y8GJatpCKBuqbyzvKiDiPq+zhDnrqkVUe8smF7jN
         +iRWRhJJ+ypexp5qB6xmmLttXirrM1lU/AuZY3UD+lL0P9Ptzvk7BX7pF3A5h1IY3K8z
         Jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMzOF4uSDEO2czI0u54xXAsMS0XJszj2itVS4kGxliE=;
        b=jkhIzllDhDCBWeBrb5vhmcl6BerjNJu6LxONili6bEsrKhsOSnBFY8MjyRnjPrE4E1
         CAyAYkE3LZYWtsvyztJiQYb9Md8FWmGfisJNlba1hbbTuuMHWW4F0s9+VALmdBQUni6V
         pBSceI9F8rhcDbj+U/tEzyAkWlbAYhk2eqkSJKo6Wi4Z0LAG06yG3VvhDJpjaUqFU6Qf
         k3LhFjS0iuNkhXG18nfBGF/aXOiaQ0GO8rTYGO0MFIratPLeZ7zuwQH/vz2DeczidUAj
         KILiAkcDcgfgUmjeUkwRxdqi7vdcG0FiknpKsfxGrWRQEZY4ou0587zQdpq410VF3uxL
         p9lw==
X-Gm-Message-State: APjAAAXjTfIOGYQGVTIhPkKEllRmg2+MoSgdaSVZbWOzq6L5u/7V79XH
        D1krT5lLick7cjlgOy8mYeNKJM01PuG/48/+Ou8=
X-Google-Smtp-Source: APXvYqwtFkdXzzznOt+LGqMT+WWQHuvaK5bL+8ulM1daZktTxcAkO+p9DA5+QKyNnw1BtNmN9qlbJ53aybHPgPqK3GI=
X-Received: by 2002:a05:6402:12d5:: with SMTP id k21mr16320470edx.75.1554981339790;
 Thu, 11 Apr 2019 04:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554975348.git.shengjiu.wang@nxp.com> <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
In-Reply-To: <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 11 Apr 2019 14:15:28 +0300
Message-ID: <CAEnQRZAQk1w79uqFCBCkFy=4_FQvxetfPsS10c+AMddJpc1VNg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

Mostly looking good. See few comments inline:

<snip>

> +/*
> + * Select the pre-processing and post-processing options
> + *
> + * Fsin: input sample rate
> + * Fsout: output sample rate
> + * pre_proc: return value for pre-processing option
> + * post_proc: return value for post-processing option
> + */
> +static int fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)

Lets be naming consistent here: Fsin -> fs_in, Fsout -> fs_out.

> +{
> +       bool det_out_op2_cond;
> +       bool det_out_op0_cond;
> +
> +       /* Codition for selection of post-processing */
> +       det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +                                       ((Fsin > 56000) & (Fsout < 56000)));
Remove outer parenthesis. Also should here be a logical or (||)
instead of bitwise or (|)?
Same for && vs &.

> +       det_out_op0_cond = (Fsin * 23 < Fsout * 8);

Remove outer parenthesis.
> +
> +       /*
> +        * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
> +        * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> +        * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> +        * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> +        * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout
> +        */
> +       if (Fsin * 8 > 129 * Fsout)
> +               *pre_proc = 5;
> +       else if (Fsin * 8 > 65 * Fsout)
> +               *pre_proc = 4;
> +       else if (Fsin * 8 > 33 * Fsout)
> +               *pre_proc = 2;
> +       else if (Fsin * 8 > 15 * Fsout) {
> +               if (Fsin > 152000)
> +                       *pre_proc = 2;
> +               else
> +                       *pre_proc = 1;
> +       } else if (Fsin < 76000)
> +               *pre_proc = 0;
> +       else if (Fsin > 152000)
> +               *pre_proc = 2;
> +       else
> +               *pre_proc = 1;
> +
> +       if (det_out_op2_cond)
> +               *post_proc = 2;
> +       else if (det_out_op0_cond)
> +               *post_proc = 0;
> +       else
> +               *post_proc = 1;
> +
> +       /* unsupported options */
> +       if (*pre_proc == 4 || *pre_proc == 5)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /**
>   * Request ASRC pair
>   *
> @@ -239,8 +278,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>         u32 inrate, outrate, indiv, outdiv;
>         u32 clk_index[2], div[2];
>         int in, out, channels;
> +       int pre_proc, post_proc;
>         struct clk *clk;
>         bool ideal;
> +       int ret;
>
>         if (!config) {
>                 pair_err("invalid pair config\n");
> @@ -289,6 +330,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>                 return -EINVAL;
>         }
>
> +       ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> +       if (ret) {
> +               pair_err("No supported pre-processing options\n");
> +               return ret;
> +       }
> +
>         /* Validate input and output clock sources */
>         clk_index[IN] = clk_map[IN][config->inclk];
>         clk_index[OUT] = clk_map[OUT][config->outclk];
> @@ -380,8 +427,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>         /* Apply configurations for pre- and post-processing */
>         regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
>                            ASRCFG_PREMODi_MASK(index) | ASRCFG_POSTMODi_MASK(index),
> -                          ASRCFG_PREMOD(index, process_option[in][out][0]) |
> -                          ASRCFG_POSTMOD(index, process_option[in][out][1]));
> +                          ASRCFG_PREMOD(index, pre_proc) |
> +                          ASRCFG_POSTMOD(index, post_proc));
>
>         return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
>  }
> --
> 1.9.1
>
