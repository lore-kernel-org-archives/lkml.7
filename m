Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06EEC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9547222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2Tn4fYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfKLXLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:11:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37494 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:11:25 -0500
Received: by mail-lj1-f195.google.com with SMTP id d5so343829ljl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tvqr7Enmi/ocfgyYnlGqiPzgim6aB1Y8HMuhsyaz+1w=;
        b=B2Tn4fYYTM5wjuJbkUXQ/aZsUJCZagjIoofBHyG9XGuS6huwxn+NT/c21aOLx3Ns1A
         fbf8EXVwP1/r8dh7qggQQEsV8nmGPxeNeP2Ln7RxFSCV+foMB7IlY9pnMabajCGj+LYD
         rM8BOrOC4rcPFI+scgGEMMpRzf4b1Y+MOz4CZMl8LCs7Oru7L9CD5eYBDoc9xZheHpdT
         6gkXvVSv0JFwwthrGvV+e56ZMTendxbU4fxtH6Y+3i6+ECSzrSItfRNURo8JYNSUPrTU
         Uo1dUwtjIh1BeMGbBbdk+k95ztODpSUKnU/sGOaHywltcGXpq5FmKqi7jsj3+Tm/HePc
         Xllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tvqr7Enmi/ocfgyYnlGqiPzgim6aB1Y8HMuhsyaz+1w=;
        b=erMk/hTyrVSrDWit95MTdBjcA7WnmWiO380f9ALYJKkJ8CiKRD4eedsW45xG2WROmK
         Vo+974an2tgX2YhvHT/R5MiQ9jrpXX+ChCLbMBQTRie42hMNOlgDpzlyzHYG7zq1r2eq
         UQ4ntUXEu6xsVDLbQC/nU4I2c3EthHKCjTaPoJv0eTr4J5RqRIZDErrA9lG18wMmTUa0
         9FaK1+LY8/j9X5SCnF5mPGVBLcS/NBh0e2/ywpQpVJw0CiiBNeTQnLwlxjYLa/QOOXgj
         hR6JsURvNC2pPWRQRgECFylw53MMkRFfQl736TcwflfV9stzXl4EuVVEFLdjsd9fjcDo
         jj7w==
X-Gm-Message-State: APjAAAXFnmf9v8f+c2OAos+zrtr2qUH790Obtes+VrtZKzAG05gwNKTs
        kMJKNFx+PP1+5zLjfWmNFP9Ej6PbsaIzmH8ZS00qjg==
X-Google-Smtp-Source: APXvYqw7QDA1w5xtLQcUrrOL5Jz7y1c4OMfpHVZeNsT9aMfYuRsXUGzKt70JLZYhPoRVIzWv0w75TLlzz7akYxQc8hc=
X-Received: by 2002:a2e:90b:: with SMTP id 11mr152843ljj.233.1573600283271;
 Tue, 12 Nov 2019 15:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20191105055015.23656-1-erosca@de.adit-jv.com> <20191105062223.GB1048@kunai>
 <20191105083213.GA24603@vmlxhi-102.adit-jv.com> <20191107003907.GA22634@bogus>
 <20191112211950.GB3402@kunai>
In-Reply-To: <20191112211950.GB3402@kunai>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 00:11:11 +0100
Message-ID: <CACRpkdYyYAaW8AYqpC3E7eBx25-3yJqitSE=0yVfxCDtM-CwqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add 'fixed-emmc-driver-type-hs{200,400}'
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh@kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:19 PM Wolfram Sang <wsa@the-dreams.de> wrote:

> What I have seen so far: setting drive strength alone is more on the
> rare side. Setting specific values for default and HS200/400 seems even
> more rare to me. With this patchset, it is the first time I hear about
> it.

Like I wrote to Eugeniu this sounds like some kind of errata
for the eMMC ext CSD and should likely be a card quirk rather
than some generic device tree properties.

I might be wrong, we'll hash it out.

Yours,
Linus Walleij
