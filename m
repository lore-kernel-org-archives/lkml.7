Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52029C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197A627747
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WerUmUvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFARfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:35:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34873 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfFARfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:35:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id h11so12577527ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owmhC4nkQ++0XWcQKeCbAiLKodtwVwoOL0lLVZVcgyE=;
        b=WerUmUvFuVb1ad6IAGBDRNrocbnRRe/ludsVjfZCo7EVt4en/Ja8o70U0DMLbhvG20
         sk9Ry7wH0dKBjHUAuIMonGzsi/O5gR0QAf34QQl+i4YRH5jyZUcXmHYnsUGS6KHDbHM9
         DJjELC2evjoStf0LYeAFVEfWL0dnLm88pVHlmUiLBTUk0U8JLPkxjpxzujDTTKXI2AIp
         nEj5ui2QIbFv5tqVv/BrJi5wzVULfQ8NIpuDZhRNJkWG57ZMXOwo37eDsa2K3tlQzGo9
         6EEmeBbimUfiJ+R/kstgGxrxMYMv7Xo9vBZRhNAe63uDyH0exAXY2I7sEBevheD9mKAZ
         N/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owmhC4nkQ++0XWcQKeCbAiLKodtwVwoOL0lLVZVcgyE=;
        b=TkGtGRz/801YzDFIuL/Y2xZP0AcvM5RuBoZLpFKIuNhS+fVxUltkkJZ6LkYPI90bRH
         4w8QIVKWavCeMso51J5L4TcslcTdmsUXvQy1TvwvNGoa+Lu1Ylfw1+P9EoJDgcIPsZfs
         JUAP7dOhXyfON/AiwaCfG/N3BkGn10w0bImz3pDNLIf5KKw9tSRN7TR0+i7jQcYxJRku
         S1VMfYq2c3+WaCy4lFLJ7av28C3QqIKZxP6yqwJf1SPStPRoyJJM3stBR80TpzKwAghj
         m5wVNqSnzlZ8e9ycQ3n69vrYygcDhZJoRnaLJDAN0cpGeJ4EpHAmlA//PD6CLMF7F/pJ
         qLbA==
X-Gm-Message-State: APjAAAWTmmVjYXUKCYXZwaEJ5I3k0o2/9CSN4KHDbziAIaczudB9A/rG
        Zdl/UXDVXxeiRqp/tTOFiAyyYDyHjE1ah36EdJRatdTZ
X-Google-Smtp-Source: APXvYqzq9gTWZsAaPSchU/CdBc50ntEnexEA2Elo8kyp/1cSgd9LzQr3i7TrIBqh5qaIoJg1bUhCfWWkTV+Bw7CC2tY=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr289291lje.46.1559410521088;
 Sat, 01 Jun 2019 10:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190520144108.3787-1-narmstrong@baylibre.com>
In-Reply-To: <20190520144108.3787-1-narmstrong@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:35:09 +0200
Message-ID: <CACRpkdZ6PBMPDie4RyuPfzfhs3W5XunZMqa6cG4bg7+kEhUegg@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl: meson: gpio: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 4:41 PM Neil Armstrong <narmstrong@baylibre.com> wrote:

> Update the SPDX Licence identifier for the Amlogic Pinctrl drivers and
> the corresponding GPIO dt-bindings headers.
>
> Neil Armstrong (5):

All 5 patches applied, I took a quick look in mainline and it appears those
files were not hit by the large scripted conversions to SPDX that tglx did
recently.

Yours,
Linus Walleij
