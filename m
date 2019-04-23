Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE63AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B740218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R71P1EHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfDWK0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:26:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37542 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:26:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so437841ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FroAomXJaDKJahsq0GryFxVKyy+ztefG4XwsaWwQLQ=;
        b=R71P1EHtE9ho7Q7VaICQcQfxwqZxvTIIoMzw3gql1mrrGGSUukyBT6JAymY6q8nFRd
         AekCHr6FRxyNKtmnj0b52GWN93roohjUvmdUEtBMNtd9SPDv0Rl+CZG2qkK/Qdq3pLpq
         ILNlgEgewBdvOZNx7LJOdRl3+AVEc9fshal3/fcJ1X0gULtD+QaQOY5gFTe6UDWCSgny
         Q2ezjf0z6XsHHW2lw18lwGk5LOwsaZR6UK9YG/g6VZl0g+9NHWEvBJjwJAOPzWuUBska
         JooQNKqfWDYfBDjNJVkQl3RpxYhJ6fATqku8Ay5l0YwG/tVUBKgc8Tc6uu9nlnXdLkL2
         2Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FroAomXJaDKJahsq0GryFxVKyy+ztefG4XwsaWwQLQ=;
        b=ulwd4jozBxHkQ9IysmrbCNdZBZpsSZJj05h3DkqYzzhOOsoTARUCcU+w2MPM4RrjS+
         g+ASw5cxaB7q0ux+CFGxdkr8aAXgzho9WhK0z3gWvG5D5kxOLJ/w09bTEqYsheOWoBYI
         2m+X/kG0RXdnSVGOHbYVJCxY5VWLdy+coya5Q56EYxN2IEq6zzumt7uWEJcpR8xAfHDV
         0HYd2xpT2192+OgJ60MklyX9jt5uzt26yfQsOEVd4ea93WnGXAh3ug04+7rPRIJyYPzG
         LhYkGbyh0Zh4Qznh5drjN5vykE+0PRIllPQdL5qzxPIXgsyZRY7FHcWaEmLVW5tWhipg
         ESYA==
X-Gm-Message-State: APjAAAVPcZo8usut+pnnwJrevJazwQeBCOBM8rGMTZ7GGYY/k4Y/crbW
        rBOSZGZghbJm/Stxi09ElIASNaHzA47wnkcqrpcMdQ==
X-Google-Smtp-Source: APXvYqy1KhtlaeUH//E9N6SAdKJvZtTMP6eUA5vssp6lV0Aoj05LJ++zPDdRuPPv5R+y2Et7LCBBq7eDGMc9rZA8yW4=
X-Received: by 2002:a2e:8703:: with SMTP id m3mr12709901lji.107.1556015211519;
 Tue, 23 Apr 2019 03:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <1555139666-948-1-git-send-email-hofrat@osadl.org> <1555139666-948-9-git-send-email-hofrat@osadl.org>
In-Reply-To: <1555139666-948-9-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 12:26:40 +0200
Message-ID: <CACRpkdbtzzYpS1wC8JpgMdgbez3mrYC+05u3vvPgXVU1GM2QSA@mail.gmail.com>
Subject: Re: [PATCH] ARM: u300: add missing check for kmalloc
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

thanks for your patch!

On Sat, Apr 13, 2019 at 9:20 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:

>  kmalloc return for bigrxbuf_virtual was not being checked - in case
> of failure set status, cleanup bigtxbuf_virtual and baile out.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: c7c8c78fdf6e ("ARM: 5667/3: U300 SSP/SPI board setup and test")

This code is deleted from the kernel and the code had
zero users before that, so no need to fix it! Sorry for your
trouble!

Yours,
Linus Walleij
