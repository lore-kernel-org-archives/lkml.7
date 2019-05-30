Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F19C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C41025734
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSOwA/nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfE3PRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:17:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34329 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfE3PRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:17:52 -0400
Received: by mail-it1-f193.google.com with SMTP id g23so8436829iti.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wq0gDRXoB+fFwn+DMVyrEr6yiz7qhgabqKtwG147DjE=;
        b=mSOwA/nucZz1z9Z1hvH0Pfe8nhgkuSdvbqGrleEuMgKVSjqVUgrS/N2WL+M37yIoGQ
         8SyS9IlFnvv3mni24KAglddm+PVUGU3wJdgsRNrcb8VR/RGjfG7n6x60787X4G8dedlx
         a4X6Aq8DkfExxfhSFuflQsycI/8fqEHZ5URCzRfps13uftpbWwkMoquEzITbHe7fKqtn
         6mKE4XYqqRWFSbbfDsfiTXQGfmjIj5ozunQP7ZiL0k5cLz8rhTTpQ8DbFr8RmAI/EyGv
         rpkdSLkogWnXXO/ZTiLd7n55tZwiLIfDqsfcBCou6MR26eoF0QqrAVPtoGCAeJdVVP4g
         fQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wq0gDRXoB+fFwn+DMVyrEr6yiz7qhgabqKtwG147DjE=;
        b=ui6X0qXQdXFLrjTnTe2TYi8QdkqRKLGVOi3Z7mfRVst+3kvoQZBQsZC/P+J5htG+vP
         uY1PID2gyQQinf5NJvMI77/5fIlal9oZsiP8KwYfKDg4OyqnzmC+KPQeNDbUAH6eoNzv
         8H/CTygtwR7FSHu3qaEOJMj9Whogb1tcLzMNEpfmoGsLLksvAP0/TP3ktrMFEIxAUf85
         /xHv4qRIcqPa9i/HUEjiKBRwCe33SsyPYKTUK1/a7vgSuA7frZBk6fACTiIz4B3XFALz
         9veIBGUH5mF8lj2WrZH2P9cL4FRtxUKJzP3IiwDuv8q8RX/Mb+fPfmHg98pPJdoOdO+4
         9o4Q==
X-Gm-Message-State: APjAAAXDcozbw+FQavV4q+KCpXsoxEwuBxEgBWc502f70No4r+Z/27Xo
        rl0NXaBtJDwGlUYYuOqVdE/RVUY6qLvEWq/v9nwaTg==
X-Google-Smtp-Source: APXvYqxRNBxWFV0sGvUlqkfsVwDglIohBoDqFx+fHfAb8Pd4U/s8UmS6hhUsFhQFPwy6JIrPZB26rBIcKvIlEr8FH1c=
X-Received: by 2002:a24:910b:: with SMTP id i11mr3572217ite.76.1559229471525;
 Thu, 30 May 2019 08:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au> <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
 <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com>
 <20190530143438.d62y3woaogyivqpm@gondor.apana.org.au> <CAKv+Gu87wkLkZZLfsJwc02yuKpDx7Sa=Nx+1YW8pPE4DoWXGRw@mail.gmail.com>
 <20190530150642.fswcxt6m2y4pnjon@gondor.apana.org.au> <CAKv+Gu-Z5Ayq4-M6Mwi34epoS3rzuc4=YYnq8P22_ULc3MXicg@mail.gmail.com>
 <20190530151345.l3lx4etd7pp45xfb@gondor.apana.org.au>
In-Reply-To: <20190530151345.l3lx4etd7pp45xfb@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 17:17:38 +0200
Message-ID: <CAKv+Gu_uqybr87uyYKvppvjFJtR_rNxhxCoFiA+o_fXWo5jZag@mail.gmail.com>
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

On Thu, 30 May 2019 at 17:13, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, May 30, 2019 at 05:10:06PM +0200, Ard Biesheuvel wrote:
> >
> > Are there any generic templates relying on this for other algos than CBC?
>
> algif_skcipher relies on this.
>

I see.

In any case, that one line patch would still make things substantially
better, given that the output IV is already wrong for all algorithms
except CBC anyway, but with the patch applied, at least it no longer
corrupts the decrypted plaintext when using GCM or CCM.
