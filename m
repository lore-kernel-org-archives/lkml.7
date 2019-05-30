Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38978C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1201A25C4D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 15:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRtzPA/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfE3PKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 11:10:20 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38803 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3PKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 11:10:20 -0400
Received: by mail-it1-f193.google.com with SMTP id i63so5642233ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 08:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyQxQxyVFskcDbp6ulz3dvZGpYPkncRLdMElYABwYhA=;
        b=NRtzPA/Hn8pbzqRibagEoNo/V5Qg/wwk5CxsPyGQLp27nnYx9FZsLehDiDxfTeJQfM
         IPqUUPUAGiEl8AnFLcbydcqSRLlHa5dPuJB7XsbC8VjM8C1srReM8d1wXLzqM/mOjjf+
         gm/ddtb0n3WuxxLY0OtXp58uh3qmum5BqTedbQFGzs3RzkL3yERijMRnCN2yMT1QIe1E
         UdiofLdkDlEbKDoIWWLZElMdTqPHwgFyWP+6I+uSlDgrfQtyW7tmayU70gOG+6BeX3uN
         uhx6HTzSIY/e1HUEaWoUXHrnJMU5t9LeUgVvQoXdkzvX4WqCFqrVEMIIAKl8MTcEtOIw
         QH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyQxQxyVFskcDbp6ulz3dvZGpYPkncRLdMElYABwYhA=;
        b=MB6f9dZUAopykgwVV6yMNxPqDko3+PfS8EN/tusosvZ03BFn1OFAd2Amu1O4WKxtKo
         9diYzBl+BvalErmjf8J57ND1ve3QHRJ99EuaAV6JaXR5evT0BxvGCkv4sJMKBgOuO3/k
         hZDHSl6FmGqCv+FLUlZNwU97tc93xVQLY9ybBI+S+sm4GGfxvNQEvTvah2kmKiEkZ7VQ
         BY+sibWFSAac7ucjO0JlgL32/pn8kmW6pwcWiklg/WSUpHuHlog7owi+2rQdD/MoNgEj
         7ZJqPNEUdupYlu5lNqzueYdW4Snh3S4BtaCo7DISWK//0qdIXbNk+xe64+WBaRLWY8Hn
         kRMg==
X-Gm-Message-State: APjAAAUZfvCyUi6qgMuW5jHDsQLjci/hNQbS6qSRKNsS1yYzO6I+tbD2
        J+HvyfJkpS8ODdSZl+mWkMN9cIVBCJu7bgtpjZUnww==
X-Google-Smtp-Source: APXvYqxp1MoBylNIkY2NH4ukDz3xswow/7OAoje8owcJBtlkgSz6gmoHvk2AJlQK7EpoAqj8yq1ltkK/3r3Ok/xm16c=
X-Received: by 2002:a02:b01c:: with SMTP id p28mr2837219jah.130.1559229019226;
 Thu, 30 May 2019 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR04MB44459EEF7BCD3458BB3D143D8C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <20190530133427.qrwjzctac2x6nsby@gondor.apana.org.au> <VI1PR04MB444562A2352FE4BAD7F681258C180@VI1PR04MB4445.eurprd04.prod.outlook.com>
 <CAKv+Gu-jTWQP0Zp=QpuzX41v8Eb5Bvd0O9ajwSnFkDO-ijBf_A@mail.gmail.com>
 <CAKv+Gu9JoC+GKJ6mMAE25mr_k2gbznh-83jApT4=FZsAW=jd8w@mail.gmail.com>
 <20190530142734.qlhgzeal22zxfhk5@gondor.apana.org.au> <CAKv+Gu8jJQCZwiHFORUJUzRaAizWzBQ95EAgYe36sFrcvzb6vg@mail.gmail.com>
 <CAKv+Gu-KBgiyNY2Dypx6vqtmpTXNfOxxWxJf50BTiF2rCOFqnw@mail.gmail.com>
 <20190530143438.d62y3woaogyivqpm@gondor.apana.org.au> <CAKv+Gu87wkLkZZLfsJwc02yuKpDx7Sa=Nx+1YW8pPE4DoWXGRw@mail.gmail.com>
 <20190530150642.fswcxt6m2y4pnjon@gondor.apana.org.au>
In-Reply-To: <20190530150642.fswcxt6m2y4pnjon@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 17:10:06 +0200
Message-ID: <CAKv+Gu-Z5Ayq4-M6Mwi34epoS3rzuc4=YYnq8P22_ULc3MXicg@mail.gmail.com>
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

On Thu, 30 May 2019 at 17:06, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, May 30, 2019 at 05:04:51PM +0200, Ard Biesheuvel wrote:
> >
> > But given your remark regarding CBC being the only algo that has this
> > requirement, I wonder if this might be sufficient as well.
>
> It's not that CBC is the only one with the requirement.  It's just
> that this is the wrong output IV for CTR.
>

Are there any generic templates relying on this for other algos than CBC?
