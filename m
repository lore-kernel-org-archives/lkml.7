Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343EB218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdnQSfC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfCVOaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:30:11 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55734 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfCVOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:30:10 -0400
Received: by mail-it1-f193.google.com with SMTP id z126so3945439itd.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQyDvol/ZkwyON17LT8cc20UHU5oOrQXWuMB2vBnctg=;
        b=XdnQSfC162O8igMo/zEqPfkBfvLoNh86g0xKQ6BX8HRYfrJNrt8NFfMYgxBbgHhKVG
         0oskFSo4n1u5ig1D1ox6KoQl/VuKhXah0/C1iX43kLn22esHDqCrtkEXzg8hXki/d5lx
         rxh8aFM3JsqBg1YTPzO1GD4ltkd563oe7O8gELvkouu/VHUcYpIUA+OFY42eNrMXpgpg
         0FYNkNBn8aGEDN6/Yf2KzWFjXaCWASPCEMHwRFOYNNZ7vFH1kON737RBn/MfNK3dK1bu
         CLA4aSbnVbrjRVII2nwrIDK7j3NBQ80l7L8iV8+m5vJ5b1rnNxvpHenWn6YuAE0vGAsj
         wVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQyDvol/ZkwyON17LT8cc20UHU5oOrQXWuMB2vBnctg=;
        b=aJJlZ3mfyA7becB8vqlvJRlabLJZiHzRrEY19xZEF/SC15fdLpdxATeCwyxfODfeP+
         N8j+kHrgI2osKvYhVjYao1wWXdphb884S0czxl10Bfv5Wdk+h4IgggVgK3iWSVF9UiwT
         qyYzgAnuq9Iha7EameQHoNL+cG/3WkMr1wparbvuwUow6txbF1nlBZL1kGNPXvbLaBMI
         T4YPQ70aAxFKM3/mu1nBpvVw7/Ec+BKyVwypdt5wu2PBSrhMNIIbXsyIsL9NdwqiEnCT
         mQnOH/QzOPe6ZJ4dDpMuNb95QJDQpo/o5Gw+ztz+Aw8oeIJ5WOqoYU2FEyAlx+JnnA0t
         /Osg==
X-Gm-Message-State: APjAAAX1EcVkOJJysAB9A5cq9gNNR81iRQA2RhO6jUpJ1Ijm8MyVDLfr
        fRqC1a6nEU9nk4ef0rlodixpbvTQwK4PMR+xMe4bdQ==
X-Google-Smtp-Source: APXvYqyBmjP2AxLdNE2YqGAzlXblbXhOIundEM+pyuciGZoQJv28IVYV7+cIs8Ews56ZAGxP2p1OU2MpZg7RyHKl19s=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr4081052jal.2.1553265009899;
 Fri, 22 Mar 2019 07:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <5ef0cab4dee128058a43f43c723c13924662e80d.camel@perches.com> <20190322124331.s5iu4ontsakv7he5@gondor.apana.org.au>
In-Reply-To: <20190322124331.s5iu4ontsakv7he5@gondor.apana.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Mar 2019 15:29:59 +0100
Message-ID: <CAKv+Gu_SBkhV8SVXpOBDoPRBJYhFdmF3jJdZ5OPm3SrPBTSarQ@mail.gmail.com>
Subject: Re: [possible PATCH] crypto: sahara - Use #ifdef DEBUG not IS_ENABLED(DEBUG)
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Joe Perches <joe@perches.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 at 13:43, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Thu, Mar 07, 2019 at 04:15:55PM -0800, Joe Perches wrote:
> > Normal use of IS_ENABLED is with a CONFIG_<SYMBOL> and
> > there is no -DDEBUG in the Makefile here.
> >
> > Replace the IS_ENABLED(DEBUG) with #ifdef DEBUG/#endif
> > blocks.
> >
> > Miscellanea:
> >
> > o Move the sahara_state array into the function that uses it.
> >
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/crypto/sahara.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
>
> Even if this is correct this is way too ugly.  The original code
> at least compiled everything regardless of macros.  Your new code
> won't detect compile errors in debugging code unless debugging is
> enabled.
>

What's wrong with IS_ENABLED(DEBUG) anyway? It may not be 'normal use'
but it works fine.
