Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8BBC2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DE320725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZR1bDqm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLPIQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:16:34 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:47012 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfLPIQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:16:33 -0500
Received: by mail-vs1-f65.google.com with SMTP id t12so3549391vso.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNL/md3eBXURlPuzMpt+NNW2vHDC+deKynwVOIfF2jc=;
        b=ZR1bDqm1sBrbGQOrhQCGhzMkwGgIGGPWNy0UiW+R03u70yVQeYsJ+q09N5CsZm8+H4
         u5rqgmSwDu/1esfl/LXurubXpL+IaO6DEgbsWCM4V8Pp2qgrlRIPIukat/vWCWbUzzNy
         7iAUp1hPK+wphwibDujKFThkphRiHjPDrpuK96gq5dWkK83EAYHTjt422DRW9Q5NHUWA
         UVpxKcEFKlsjWFKl6H+pMIJ1PHHfnzNEx7bUvXjd8focSsTWq63mulVF0jJKU0Bj7o7P
         KCdhgL78MZfjZHzx4bvLZKnxeIG1t8r24zj2Zq8O8hYlTdTnoe+eiQpzQWh5iXwSoLVx
         /DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNL/md3eBXURlPuzMpt+NNW2vHDC+deKynwVOIfF2jc=;
        b=cVqJSoYj1CA3PK3Bxo3k3JqsSkwyrrDDEjGDvQLAJA6TjjgWb+Bmz8SRG189VQN5hO
         Z/+2E1i3LDSQ7l5cpEH5o0xYE9WoasrxmXcdgv1t8AvtyE2SgVNxaiN8hqoe82GwxC6J
         h5oVh+C/icTq29GbK8ViKpjr4Oq4Yq1uwQArIFqhW5lSy2uWgL0C0iYtfAS8Ihlf7Mkx
         fxPNCXtwkvBHHA+nVKG0CxQk9sAGUiJ6YT+6o8MOe3cuuPNq2OwlH4NBsR9F1m/2pdQG
         sWMmVocACIueqD3r8Tfq2KZZiPd/te5r7DjBywS7sFWCxW7XUpUfyJ3SbCTAVjSYt5JV
         Dk1g==
X-Gm-Message-State: APjAAAUzyPQaqbF+h4uYXUaN83rZxeZFyo4hEhbEDFGHRJ2BoqaKrTmH
        BbOFYjkfJiOCrZtzDWcHV+/pnYjK/OaZDvfVQRvSVQ==
X-Google-Smtp-Source: APXvYqxZgmG+r2lTV8LKe+Xl0XG0KMUrLOVjhm5O5XKw+42XV8qr8FSzvIn12G9bZTlTbNGjb2WiK96uAA1oxkXvC7Y=
X-Received: by 2002:a67:d592:: with SMTP id m18mr20632386vsj.85.1576484192909;
 Mon, 16 Dec 2019 00:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20191210195853.883483-1-arnd@arndb.de>
In-Reply-To: <20191210195853.883483-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:16:22 +0100
Message-ID: <CACRpkdb88egVZr400QaAL=B_2qx3W2FsdWPZzZMWcB1u-R0YKg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: equilibrium: add CONFIG_OF dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 8:58 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Without this, randconfig builds get a link failure
>
> drivers/pinctrl/pinctrl-equilibrium.o: In function `pinconf_generic_dt_node_to_map_all':
> pinctrl-equilibrium.c:(.text+0x96d): undefined reference to `pinconf_generic_dt_node_to_map'
>
> Fixes: 1948d5c51dba ("pinctrl: Add pinmux & GPIO controller driver for a new SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Rahul sent an identical patch that was previously applied,
but thanks anyways!

Yours,
Linus Walleij
