Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9CDC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472BE25AF5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMmhaKbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfE3ObX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:31:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45260 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfE3ObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:31:23 -0400
Received: by mail-io1-f66.google.com with SMTP id e3so5200522ioc.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9z/WdVRRf6vdfFIoG1dq2l7RwLG3vNFiWTkrU7D/nk=;
        b=ZMmhaKbW4Cn70U73eCpnJ5yejbxfst26fJzumTLlslyElxjp9fcBkEGZMScFosMuxt
         zMqAo9SQrjNXO8KxO2H+kxjnhJcY3+kkQYiVcuxufFL7Br8UIF0OwfjgyL3cnUKajLhO
         kPVG1au5pp50+mX1/xRxiYbNt/wgI04qCbadJs17CI0/TW7wWEnxAZCuG0L5giUOMJ8O
         kqzTB/SZRhWy1++ixHA48Ev+SNsjJCQIUT6oDhK8GjehQl04JmiS2VTiNwVJJjIM89jh
         +YXHQgdHpTxC+L7J7BE7ir3kiMivB1cSlkY+dyxYxDJ9vq+uVwWEKU45lzb3RN6QqEaI
         ug+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9z/WdVRRf6vdfFIoG1dq2l7RwLG3vNFiWTkrU7D/nk=;
        b=pHHkSN3/v9ErvOn+Qf0Mc7NygOvMuGfWUbHxwzSJALPFyxPDsDZc3g7IAEeCX8aJCU
         0AnAZ2DSCBQMW5kPLj4JxR6TX2IkKWIuoh93aO2cI6BsH6F3MFimwFoxCdczoaUxZvQq
         2SeSIWmFtyi6NYFk5GVBNlOkg7jo+5tKSBbHcCZtQeT3DWAoDPGSlC8SzM1B3Jx+BeLx
         4Zmp9kv/YsIjvGIJ2DKOl/8dQdSe+Q40LG7LccbKtomsmDOHEO66Y15yvn+T4ewWUDp5
         ZRWyJahVPspDDWtW51CuuQT2/n+yLA/NLlecJ2g4DO3DmQpVJnxDiUpBbcHbBAJq6Oq5
         OsuA==
X-Gm-Message-State: APjAAAXbKY6N5b99n4HUp5Bh4F/H7RKiDgrTFrn1j2eolavIfanIEy87
        dy6vkSORMhUrEW0mnDAaUHpQwWtKYdDFfCzCHlsDJg==
X-Google-Smtp-Source: APXvYqw2ZOeAk7/M9AocUjdj8Q8DzEH6NvT4LDK/kImOQw6jI/g3st7gLmFsFKinsTrKkizGVdQsp1Aah7WCK7DFWdg=
X-Received: by 2002:a5d:9402:: with SMTP id v2mr2780864ion.128.1559226682223;
 Thu, 30 May 2019 07:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <1559149856-7938-1-git-send-email-iuliana.prodan@nxp.com>
 <20190529202728.GA35103@gmail.com> <CAKv+Gu-4KqcY=WhwY98JigTzeXaL5ggYEcu7+kNzNtpO2FLQXg@mail.gmail.com>
 <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au> <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 16:31:09 +0200
Message-ID: <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com>
Subject: Re: [PATCH] crypto: gcm - fix cacheline sharing
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
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

On Thu, 30 May 2019 at 16:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 30 May 2019 at 16:27, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > On Thu, May 30, 2019 at 03:55:07PM +0200, Ard Biesheuvel wrote:
> > >
> > > > Would this work?
> >
> > I see.  You need to preserve the original IV.
> >
> > > > diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
> > > > index c0ece44f303b..2ef2f76a3cb8 100644
> > > > --- a/drivers/crypto/caam/caamalg.c
> > > > +++ b/drivers/crypto/caam/caamalg.c
> > > > @@ -1832,22 +1832,25 @@ static int skcipher_decrypt(struct
> > > > skcipher_request *req)
> > > >         struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
> > > >         int ivsize = crypto_skcipher_ivsize(skcipher);
> > > >         struct device *jrdev = ctx->jrdev;
> > > > +       u8 out_iv[AES_BLOCK_SIZE];
> > > >         u32 *desc;
> > > >         int ret = 0;
> > > >
> > > > -       /* allocate extended descriptor */
> > > > -       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
> > > > -       if (IS_ERR(edesc))
> > > > -               return PTR_ERR(edesc);
> > > > -
> > > >         /*
> > > >          * The crypto API expects us to set the IV (req->iv) to the last
> > > >          * ciphertext block.
> > > >          */
> > > >         if (ivsize)
> > > > -               scatterwalk_map_and_copy(req->iv, req->src, req->cryptlen -
> > > > +               scatterwalk_map_and_copy(out_iv, req->src, req->cryptlen -
> > > >                                          ivsize, ivsize, 0);
> > > >
> > > > +       /* allocate extended descriptor */
> > > > +       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
> > > > +       if (IS_ERR(edesc))
> > > > +               return PTR_ERR(edesc);
> > > > +
> > > > +       memcpy(req->iv, out_iv, ivsize);
> > > > +
> > > >         /* Create and submit job descriptor*/
> > > >         init_skcipher_job(req, edesc, false);
> > > >         desc = edesc->hw_desc;
> > >
> > > Umm never mind
> > >
> > > /me hides in shame
> >
> > So why doesn't this work?
> >
>
> Because the memcpy() occurs while the buffer is mapped for DMA, so it
> suffers from the exact same problem.

This might work:

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index c0ece44f303b..3d313d2a279a 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -1661,7 +1661,8 @@ static int aead_decrypt(struct aead_request *req)
  * allocate and map the skcipher extended descriptor for skcipher
  */
 static struct skcipher_edesc *skcipher_edesc_alloc(struct
skcipher_request *req,
-                                                  int desc_bytes)
+                                                  int desc_bytes,
+                                                  u8 const *input_iv)
 {
        struct crypto_skcipher *skcipher = crypto_skcipher_reqtfm(req);
        struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
@@ -1745,7 +1746,7 @@ static struct skcipher_edesc
*skcipher_edesc_alloc(struct skcipher_request *req,
        /* Make sure IV is located in a DMAable area */
        if (ivsize) {
                iv = (u8 *)edesc->hw_desc + desc_bytes + sec4_sg_bytes;
-               memcpy(iv, req->iv, ivsize);
+               memcpy(iv, input_iv, ivsize);

                iv_dma = dma_map_single(jrdev, iv, ivsize, DMA_TO_DEVICE);
                if (dma_mapping_error(jrdev, iv_dma)) {
@@ -1801,7 +1802,8 @@ static int skcipher_encrypt(struct skcipher_request *req)
        int ret = 0;

        /* allocate extended descriptor */
-       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
+       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ,
+                                    req->iv);
        if (IS_ERR(edesc))
                return PTR_ERR(edesc);

@@ -1832,13 +1834,11 @@ static int skcipher_decrypt(struct
skcipher_request *req)
        struct caam_ctx *ctx = crypto_skcipher_ctx(skcipher);
        int ivsize = crypto_skcipher_ivsize(skcipher);
        struct device *jrdev = ctx->jrdev;
+       u8 in_iv[AES_BLOCK_SIZE];
        u32 *desc;
        int ret = 0;

-       /* allocate extended descriptor */
-       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ);
-       if (IS_ERR(edesc))
-               return PTR_ERR(edesc);
+       memcpy(in_iv, req->iv, ivsize);

        /*
         * The crypto API expects us to set the IV (req->iv) to the last
@@ -1848,6 +1848,11 @@ static int skcipher_decrypt(struct skcipher_request *req)
                scatterwalk_map_and_copy(req->iv, req->src, req->cryptlen -
                                         ivsize, ivsize, 0);

+       /* allocate extended descriptor */
+       edesc = skcipher_edesc_alloc(req, DESC_JOB_IO_LEN * CAAM_CMD_SZ, in_iv);
+       if (IS_ERR(edesc))
+               return PTR_ERR(edesc);
+
        /* Create and submit job descriptor*/
        init_skcipher_job(req, edesc, false);
        desc = edesc->hw_desc;
