Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12816213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1mbYUFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfFYNio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:38:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33963 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbfFYNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:38:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id y198so12679480lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSvTpOLyyXh49qYBGomCHftsOmnYZkhBKlFO4JP7Wco=;
        b=M1mbYUFtUWy7KV2CuQ8M5nj8o/ooJsFihAJz7osC5AgX0PriOKLOv/57c+Ud2pPZYz
         WabUrZRYC8iJuFTzI+CQWCu+xBqiuAf8oRQcslmGumQMVZ8/HwBktQVUQspZBYce1zfd
         taGw+T6bJepqGs0Y5bw2kZRLDxW4ifJKz3myqKSs5EOoMyqCaY61mJtrIZyu7pBjOPZg
         m6FQARBJw27QQbskEvQ3AdcukASou0VIzpTSRdz1ayrC68xRuw55bhY/bfgKdqRJoDng
         cO9dQwy4TpzMe3SEJovusplELhe37+JoMC9g22TShMSob/tkCjfUqp2LJKCayQgtTFzk
         DOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSvTpOLyyXh49qYBGomCHftsOmnYZkhBKlFO4JP7Wco=;
        b=U6JWw2fLFn3llKpQLmUlMoS6T9o8Q3ECCjNRM42g3dE6i6jwDql9DI9ejjUQm5gy8G
         ZH4v4qbFcmi89xksmZD8p2TQkF32W2yMTIXgn4sAlbVgZUK78Dtcxilhc8HeBDY2Y+bJ
         GEW0l1BYCkNOk4h4XLvfLYkWse2M8lZeS97+xhFdaNXIZ+p4NYbX+MaKQ3Y9CWxOoHJo
         qEZe3l86XzenqAgkukS1uBXw9wCgQx/R6QSfgglZ9g0HoTaEoWgqq2OtZW1WePCERUNN
         dFe122RSu9CMIhqe4Uif5pZaDkwziCg6NI7vfFmz1By8uzV90yoFtL6mj0k91StURfCM
         gvpA==
X-Gm-Message-State: APjAAAVxJ9qqM+2y4DzjiremvqxtV8BaRrtXGsT8tXIGkp2gBsVWT/LB
        PzURRAnRDuPYW08J5GlRdNRdjgrNJKkejnZNBSe6yw==
X-Google-Smtp-Source: APXvYqw1szRm5IYELBubgoE074wOtxRYIQ93MVfFMiHW+jrrnby9r1otXbCpvLC/2ZO07gSJ2SF1xJN/82oqxqNsyBo=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr25221480lfm.61.1561469921507;
 Tue, 25 Jun 2019 06:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <1561345379-2429-1-git-send-email-skomatineni@nvidia.com> <1561345379-2429-4-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1561345379-2429-4-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 15:38:29 +0200
Message-ID: <CACRpkda0=HeRco8kExdf6TmiLOnCec3Ek06s-MdjNJvVGw3ZNQ@mail.gmail.com>
Subject: Re: [PATCH V4 03/18] gpio: tegra: use resume_noirq for tegra gpio resume
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 5:03 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:

> During SC7 resume, PARKED bit clear from the pinmux registers may
> cause a glitch on the GPIO lines.
>
> So, Tegra GPIOs restore should happen prior to restoring Tegra pinmux
> to keep the GPIO lines in a known good state prior to clearing PARKED
> bit.
>
> This patch has fix for this by moving Tegra GPIOs restore to happen
> very early than pinctrl resume.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Can this patch be applied in isolation from the other patches?

WOuld be nice to have at least Thierry's ACK on it before I
apply it.

Yours,
Linus Walleij
