Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E15C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB812067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3r+vw4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfLLKe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:34:26 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33282 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfLLKeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:34:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so1322647lfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ExYrHwIdHCQw2WEYskGLMt3e4iRrFiC/gjDbaG279k=;
        b=v3r+vw4bQ6LcEOVMLroVVNcC+2Y/AzPkE2LJq2f1Lot631cAshif/11f31CHbINpBZ
         fmYSCuW3Mz1prOo0bUtBy4htaY7FdZw8KE8xeeA/HrFGWHPc78FthcjLfD0qk2Qs/CS7
         xkIn9QGDritjyD0ervG/Um3166uG0YKmRkjZ20pdgisOimHnx48OYbokM/CRMnZpn/7M
         /0Xe+CxEXmAKAEIuiWVi+nam8Xc2D9V60tSyQ+M0GWZqTunhuvoWa7UY+C17G+jarcXv
         Pi8/R8LvY9oJTetJPpFtkaAbWYxz+0lGaUdC68k3ZvRfCDiDhZ9gyadW0bJucGfP95tS
         q0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ExYrHwIdHCQw2WEYskGLMt3e4iRrFiC/gjDbaG279k=;
        b=ksNxe1XTJlKUC+wWO+gisPysfcEwq0m1DI5GwiuQH2K2/N4xMC4Ew6++o4JZJV6X9b
         CYjB0b+xGAqveEFCjtxHU9k5UflzpNVg9DIbuVKjSDYx7Wp8XrKWdPZzLGdHErkrpwwB
         VJ92oRlubLxQt8vmfS/rGijZ8D1DMk3sG7efHpOkZZ33QtUOBDAE2g02Y56aQR0ngBFq
         xVxc/bKhFdXZ6T6urXlj3UJB2eWCdpdODOj2NljgRJOtxtJ46Z9viHe7E/0sF/vanSSt
         GU2pRwF1KkUNfWwXAqI8lbM+SvQWXFT998XyZCyuHUx42x9Kz54TT8KT9df9AkzS7kEM
         pAgg==
X-Gm-Message-State: APjAAAWuPHG4EbapTf3atK4CZ78K8CqTt771dLc3Lv0aY4Fr56xG9ha9
        Wfdwbksdm923+GGtJTtGyErpSnkHxkbreWjll50Utg==
X-Google-Smtp-Source: APXvYqwFQ1SvwLMAfhJKA9VEc7eUCJlGz9Lb+HFPgfR4cI1vkIqNPg8K3VY8f6gAcFuMk4OpAzItb0UELxQqJmkPvio=
X-Received: by 2002:a19:c0b:: with SMTP id 11mr5273188lfm.135.1576146863970;
 Thu, 12 Dec 2019 02:34:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574871463.git.nishadkamdar@gmail.com> <14bb695da50f7af8499e7dfc32c2ab753d92a3e9.1574871463.git.nishadkamdar@gmail.com>
In-Reply-To: <14bb695da50f7af8499e7dfc32c2ab753d92a3e9.1574871463.git.nishadkamdar@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 11:34:12 +0100
Message-ID: <CACRpkdZFH-5RuQ1yGape4j6ukVEY7u2s_TywLUNXnwx9jgHNwQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: stm32: Use the correct style for SPDX
 License Identifier
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 5:47 PM Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> This patch corrects the SPDX License Identifier style in
> header file related to STMicroelectronics pinctrl driver.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
>
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Patch applied.

Yours,
Linus Walleij
