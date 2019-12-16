Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4594FC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D0F206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvMSEBB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLPKjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:39:51 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42825 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfLPKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:39:51 -0500
Received: by mail-lf1-f65.google.com with SMTP id y19so3826041lfl.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eASUinPkaGZJHOgTIA6SaLKdBIe8ndKbRshIZuG4fiA=;
        b=gvMSEBB0eZnELFRmfIx+0Ef0369plyPv8mYJq1s4eaHxkEkW5VnmgwqeNz355t5TWl
         Sn+cFXB4DxEcHvFWI7u/LfZeMLEGqNlsyCnYcJp8bUraj4vhcVxezg0Dn86FM5UNxnmh
         FSOaLsLlCJHiE9/5Ins+lr6SDTlu88BPlvJwAG5AP7SlSiidb78l00dSDAhzJgtSnvX5
         lTut3TUCJ+O23llKsTL/fihV3fyGQQi4mkfQGkB5hadELN9w1ha3rPKL11fECr8lzCP9
         QhiWKUdJmBL98fMhEP1w1sU2at2NGKzQISN0OMgUzUCqFicb2X5kh7CXV543rRcmPfHq
         xygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eASUinPkaGZJHOgTIA6SaLKdBIe8ndKbRshIZuG4fiA=;
        b=FclZCrBCQeQ5QqZZGJxCAFcmNj7gN8Sl7p2P5AtkafRBT0ffaOtrEZVURLU7Ibivgn
         TFrmosXiBxrSjnuxVEOeUgovh1Sp1jVZRmjCCw1j8JNp0590XqqqEQbNCuMt7+/nRnc2
         hu9dMNngY8clIxY1OJjL8cpSPDNzFrP9nJAXYLt52GysBvC+WMP7Eah71cseXsYj++fC
         hDYRARZApnKiSPTwT4wOf59IX24AsPFVs0oZXbZvBiCfDrGoeGx4T9hmzih/F74aeac0
         Jh8dIFNtUsOeiys01gE6toatS5z9tEJMC4/4L2o7v5w2qZVZ018qDFsqyyZnCgUejWjl
         lXfQ==
X-Gm-Message-State: APjAAAXlOfuk1RXu45WNtHeOPP4TfppQYZNa2eCp50D+c0b4FlG1mq+Y
        ExvT8THJGJUjGJ/n9vIAs2yHxmx8ghvGEmHU4tLDhw==
X-Google-Smtp-Source: APXvYqxzt8KKeZI8wgfcQPj0YZ9QX8xthNB6bqmMjGdR0Pj43hONYwxcydmJ2yGX9OFyPLBM5DVYrwUa2gH8n7yfSjI=
X-Received: by 2002:ac2:5c4b:: with SMTP id s11mr15930092lfp.133.1576492788774;
 Mon, 16 Dec 2019 02:39:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com> <20191211192742.95699-2-brendanhiggins@google.com>
In-Reply-To: <20191211192742.95699-2-brendanhiggins@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 11:39:37 +0100
Message-ID: <CACRpkdaTJej2zFX0y7mAYymBdGNvHpp3VyU0kOd=ScA_gMAf-A@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] pinctrl: equilibrium: add unspecified HAS_IOMEM dependency
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 8:28 PM Brendan Higgins
<brendanhiggins@google.com> wrote:

> Currently CONFIG_PINCTRL_EQUILIBRIUM=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
>
> ld: drivers/pinctrl/pinctrl-equilibrium.o: in function `eqbr_pinctrl_probe':
> drivers/pinctrl/pinctrl-equilibrium.c:908: undefined reference to `devm_platform_ioremap_resource'
> ld: drivers/pinctrl/pinctrl-equilibrium.c:223: undefined reference to `devm_ioremap_resource'
>
> Fix the build error by adding the CONFIG_HAS_IOMEM=y dependency.
>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Patch applied but I augmented it with the recently added
OF dependency so it now says:
depends on OF && HAS_IOMEM

Yours,
Linus Walleij
