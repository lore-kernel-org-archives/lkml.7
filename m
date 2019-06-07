Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B2C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8A720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rqrv2fw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFGWE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:04:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40217 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfFGWE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:04:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so2699606lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSGQwLEBuCK9zP7NpUSQEjWlt9syiyScK1Qv82y9zDY=;
        b=Rqrv2fw0OYkyZCGgpZZfV8pHIKnnDqeqwB/GSfmW0R1GWq17BPPCFxCOmyyKhSmTAC
         iJ+sTJVzs1dN0I5UydjVGQ/TqRBiXREqAbxKmvClzTTM48MzK67ENGlUmnLCepOJMIOw
         Z7nx0Vp+Bh+nyEcsbhQrrLRhtFtXmrRcFUrF0qok9m27CoHzyIS5dsfr8ZcX1kL5yBkG
         7aqg+uWDat7P7iT6MkrjKUrlMppj8gQPtNFAaujnmx3ebL2sKEbPHsIT+TPGjMXGefUi
         BWB2G69ZLk6Qc+TeqJcVwk54B4r6gqFueiRlVhZwcClRpV5B7PZa4B4PmArip/cFaRUz
         LquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSGQwLEBuCK9zP7NpUSQEjWlt9syiyScK1Qv82y9zDY=;
        b=QQSqIphg+JzyTGTpA0EVKL8UIWlGn+qxYFDXQ8YeCPX2uTfJFWz+81BR2qNh9sJpsb
         UjOC8vM2VnBMxfxiSl65W0DVqn8e8gZBUMk+FaytYCLG7B8q3LwZM1kFj0HtHw28YZwG
         Q7b4ZBQlIlIpJI0EVNX8cEgxmlu1XEvEKg6ODdO7zT9DZc2BdcCjEWJVFLMzht86agm5
         VS5PysG9h0T6X1CUfiVYgf83OCt2gkxUFHtcI6nDO5uaG3ssFgYWzgDkFYVyOWBDQDbW
         AVhvrjADr7OhkFl7hieQKXDLXZxO6EPBxX/UZqD4oxVxxKLlcxj4qcH0IGqsvPmmX1zw
         p57g==
X-Gm-Message-State: APjAAAV+pKbFt2ga+QCSbJBrSA34s6uqZkBL9i/ZSgnn77EsO7WjWFGr
        1Etie9Cb5eOHN5H+73xr/tlypaecK870iZkfr01yEg==
X-Google-Smtp-Source: APXvYqwVpDLv8iqMxP0olSZYnqLx5zmax/077YaDYBmmnV4PB62sxN/GRgbQx9K+fhcwLTxaiRy5bNBfMaxV6Y9CtKo=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr26914521lfn.165.1559945064357;
 Fri, 07 Jun 2019 15:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <9bb9ca6102e795dc2495d92b7b661779509adebc.1559651758.git.hns@goldelico.com>
In-Reply-To: <9bb9ca6102e795dc2495d92b7b661779509adebc.1559651758.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:04:15 +0200
Message-ID: <CACRpkda6Hk1hE322KGC==0OFr5YZ+Qsvh6Dird_xjS5xop4bEw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: hack to fix 24 bit gpio expanders
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 2:36 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> 24 bit expanders use REG_ADDR_AI in combination with register addressing. This
> conflicts with regmap which takes this bit as part of the register number,
> i.e. a second cache entry is defined for accessed with REG_ADDR_AI being
> set although on the chip it is the same register as with REG_ADDR_AI being
> cleared.
>
> The problem was introduced by
>
>         commit b32cecb46bdc ("gpio: pca953x: Extract the register address mangling to single function")
>
> but only became visible by
>
>         commit 8b9f9d4dc511 ("regmap: verify if register is writeable before writing operations")
>
> because before, the regmap size was effectively ignored and
> pca953x_writeable_register() did know to ignore REG_ADDR_AI. Still, there
> were two separate cache entries created.
>
> Since the use of REG_ADDR_AI seems to be static we can work around this
> issue by simply increasing the size of the regmap to cover the "virtual"
> registers with REG_ADDR_AI being set. This only means that half of the
> regmap buffer will be unused.
>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch queued for fixes, let's think about better solutions going
forward.

Yours,
Linus Walleij
