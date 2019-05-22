Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A500C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A3120868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qp7ksrqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbfEVVs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:48:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44456 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfEVVs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:48:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so3483100ljl.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iOQBrNwTYw1SJ63/WnHNyssBXV9YJJ2k4UCp73ToEmY=;
        b=qp7ksrqLx5ft/ImrAs4PupVHbiOySR7j6SkKW6uxuR8rBj9z12Uj+F7+UyVWnv3ZHz
         W/Ns+ZonjORK43hZe/WgphVUkLMjHRH7+C2CNrYMyTxOBeGlmhgZvFCL3PHMXZmIupnV
         Y2hwr1kXNAqp9r+XIOwauIZzoI8Lf/63GwjL23s1Vuiuc+XwA+i9mAAypjha7jlDGIAc
         X1S4iBB9s9w2hOve0jwvAT44+DQbAXUFZIBTrQLJLV064mcfUB8fUhoDVxPJogbRtnJH
         JgXNXOCEvNqmZWHkGd1aN6+yQ+zGUCJ4ndPiPzuSsnpNVvkz4tIcl79YBJdEbf44d11d
         JSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iOQBrNwTYw1SJ63/WnHNyssBXV9YJJ2k4UCp73ToEmY=;
        b=DQAaMD32P1KTmGEbOI7z5ceOLHrpRuwCWoZNznWHULwn6pnR6RFmJnASIEoLLIvNW4
         MSdQDEQOQtnNMJ7BYLf9+GWA0Nt/Je9QrlMguQSN+UM7hPWlo6gNYEZ6LvWCHC7DNikD
         rr7uCvADoc6FcLDv05OcBBGyLA/m5K97Ev1fbJmox4x9TpfKHy9yPFCRlaONeu+J1GL4
         9Cc0jFkrrFtnVt1Gf0rVnuHzuxH0WNYJRikOPWqb+Xn+Xp7CB/ynzlcHPlb1LnN/Sa1h
         ceAyzu8/L1gDaHTrK0HzGRD+k+Uo9eRAqCGKYweiB9XYxXPjNEXsejVF/43Z9o6BJlVw
         zHeQ==
X-Gm-Message-State: APjAAAUA5ehfwgaAIjFSsFjhoEacFjjTGm23fWsxqDWE3GcFblAMCbLI
        tsnRHyIScIaxGuRtRnHm2Hxo0ArBEmD8crh1XzhE3Q==
X-Google-Smtp-Source: APXvYqwn7Y1cj8wPhej94OTp0JB16CcRc/bDKnwG8PWg9M3eToMM02XbJOSHxYn9oeKK6KCeZ6o6KloIF4NRh2kbJzU=
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr24141079ljh.167.1558561737233;
 Wed, 22 May 2019 14:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <1558338735-8444-1-git-send-email-amelie.delaunay@st.com>
 <20190522054833.GB4574@dell> <eb8425ec-989a-9701-7fee-61bd1d2b93c1@st.com>
 <20190522084133.GF4574@dell> <bc1b5f1d-23b0-141d-f58f-b54ac303fe20@st.com>
In-Reply-To: <bc1b5f1d-23b0-141d-f58f-b54ac303fe20@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 May 2019 23:48:45 +0200
Message-ID: <CACRpkdYmdpwEvCBrL6i1V+Zxd0OSpZmD8BJPSZu9jYNeJkoimQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO is
 not defined
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 11:21 AM Amelie DELAUNAY <amelie.delaunay@st.com> w=
rote:

> ../drivers/pinctrl/pinctrl-stmfx.c:409:20: error:
> =E2=80=98pinconf_generic_dt_node_to_map_pin=E2=80=99 undeclared here (not=
 in a function)
>    .dt_node_to_map =3D pinconf_generic_dt_node_to_map_pin,
>
> OF_GPIO depends on OF.
>
> So either
>      depends on OF || (OF && COMPILE_TEST)
> or
>      depends on OF || (OF_GPIO && COMPILE_TEST)
>
> and
>
>      select OF_GPIO

I would use just:

depends on OF_GPIO

Because OF_GPIO already depends on OF, and
compile tests will not work without OF_GPIO which
require OF so...

Besides it is what most other GPIO drivers do.

So just keep that one line and drop the rest.

Yours,
Linus Walleij
