Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1AFC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A35259FB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMg2lXOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfE3NzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:55:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34677 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfE3NzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:55:20 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so5138492iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HVD2RXBI0WS/MLgSm0+L8PqkmQX1tPuRizOW9v+Iyw=;
        b=iMg2lXOseJGxI43hPDJXB82bh96DcCBdC49rI50KQwye4O2w2olRrIBpHqVrrOWRgx
         pJO1YXxr9Aa2lkevLhDSlOdhnZOHfknTHJT6VpffRs4UPai/qNt0T/Cm1NdXF182oQJZ
         Pc6Sx/NSLzAyintsFL4++k8+aYqCsghpsK1xxRsCxwL8YYTnPBKQR7gyMUV+BojpP8HZ
         rrm5OuAjVSXt359EN2WPFHhVAjlO3jSVYuByJQGD5rA2cfe1kTzDK0XRUEsWN7/WzzkB
         bElJ43826DPfdelW/3D2t2BA0v1cK8aaY8EjtXAUxkPG3cW2r0kyN/qMPbQR1y0r5qcs
         CIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HVD2RXBI0WS/MLgSm0+L8PqkmQX1tPuRizOW9v+Iyw=;
        b=Rk4rMTXV7AMHWrm+0nXLbuqdCEdWzKlvKbZ/wQMl5mJ/kikE20CE4dXaAqGErJaEvh
         tL9HJWbuYxbXGrVoAaox/FRLpoyKUlV5UFLO+y9//y5EVFdv/FBekeCFWdSU+HAr6cf0
         OG3kPk8Tt3NdKvYj3spq+6dI/st10NUWOnP29bFARMZjOxOE8fScbNFp6DU/3C6Lpv+w
         UsFZ9NE4OlEru0/YxU9WQB3sB4Qs99DkTwluhcIhCqHCDmSPvlmsQMgSUycF8N5SfCzl
         69DpsQYP/W+wEF2Xurqk/7QMMeHDkusQ3PTcBIq7Zv8IWXr22gGfjRK1E68cpMReo1pN
         64cQ==
X-Gm-Message-State: APjAAAVfOYNKtl+xFjJOxdVXDSIM6kYCPfxj9Y2Qf+/rC0c3itQdSerx
        FFIeV3pvVQLrsv8tB44luwP1nwkIINhbfzuj1NHidQ==
X-Google-Smtp-Source: APXvYqy7QoEgb+iRHgEswU3vOPt9Pb5Cs7R6RI5mvq8Y/lm/f+gBZDm/c0bG6x1BLBF5Fh44knhM70ZkNLe8xJvce1c=
X-Received: by 2002:a5d:9d83:: with SMTP id 3mr2527743ion.65.1559224519316;
 Thu, 30 May 2019 06:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com> <CAKv+Gu-4KqcY=WhwY98JigTzeXaL5ggYEcu7+kNzNtpO2FLQXg@mail.gmail.com>
 <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 15:55:07 +0200
Message-ID: <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 at 15:53, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 30 May 2019 at 15:45, Iuliana Prodan <iuliana.prodan@nxp.com> wrote:
> >
> > On 5/30/2019 4:34 PM, Herbert Xu wrote:
> > > On Thu, May 30, 2019 at 01:29:41PM +0000, Iuliana Prodan wrote:
> > >>
> > >> I've tried coping the IV before the extended descriptor allocation, but
> > >> is not working and to make it work will need to make more changes in
> > >> CAAM. We need the original iv, and if we move it before
> > >> skcipher_edesc_alloc we lose it.
> > >> The fix exclusively in CAAM drv, to copy iv before DMA map, is more complex.
> > >
> > > Why doesn't it work (apart from the fact that this only makes sense
> > > for CBC and yet you're doing it for everything including CTR)?
> > >
> > > Cheers,
> > >
> >
> > On the current structure of caamalg, to work, iv needs to be copied
> > before memcpy(iv, req->iv, ivsize), from skcipher_edesc_alloc function.
> > For this we need edesc, but this cannot be allocated before knowing how
> > much memory we need. So, to make it work, we'll need to modify more in CAAM.
> >
>
> Would this work?
>
> diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
> index c0ece44f303b..2ef2f76a3cb8 100644
> --- a/drivers/crypto/caam/caamalg.c
> +++ b/drivers/crypto/caam/caamalg.c
> @@ -1832,22 +1832,25 @@ static int skcipher_decrypt(struct
> skcipher_request *req)
>         struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
>         int ivsize = crypto_skcipher_ivsize(skcipher);
>         struct device *jrdev = ctx->jrdev;
> +       u8 out_iv[AES_BLOCK_SIZE];
>         u32 *desc;
>         int ret = 0;
>
> -       /* allocate extended descriptor */
> -       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
> -       if (IS_ERR(edesc))
> -               return PTR_ERR(edesc);
> -
>         /*
>          * The crypto API expects us to set the IV (req->iv) to the last
>          * ciphertext block.
>          */
>         if (ivsize)
> -               scatterwalk_map_and_copy(req->iv, req->src, req->cryptlen -
> +               scatterwalk_map_and_copy(out_iv, req->src, req->cryptlen -
>                                          ivsize, ivsize, 0);
>
> +       /* allocate extended descriptor */
> +       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
> +       if (IS_ERR(edesc))
> +               return PTR_ERR(edesc);
> +
> +       memcpy(req->iv, out_iv, ivsize);
> +
>         /* Create and submit job descriptor*/
>         init_skcipher_job(req, edesc, false);
>         desc = edesc->hw_desc;

Umm never mind

/me hides in shame
