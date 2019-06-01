Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7DC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC33027749
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 17:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPmBq1NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfFARY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 13:24:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40661 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfFARY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 13:24:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id a9so9013049lff.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 10:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuie0203UXl1EhtYs+4s8DTcltYAks3UNrsXRKDCuXo=;
        b=XPmBq1NBztKl9h2OOkgjFr670HW0d3Fst639RYgRfAhNmUKHRr1yLI55TperxgF7X4
         E0E3jutauutH4fLPWST1kn6JgAE1DFEJq+Je90Abqu8BJFPnB1bherfdKjCg+uM4D+iq
         /HuKazRmqtZrXX3SzlpM9g2ITI4NicyvVjjY81FB3/2aE/A/NrknoQlIA5483bcccQVZ
         SEvSxugbl5JWwRlrnWQr10as0cXiJ0ASRkHk0HdqsmJDQV+m+HaIh9PeY2scc+MguR5A
         3jgGQl3QNPPz4XZjk0KliN9m0qSfgR7TM4yIe0VaA2PnjAOYIWUoEcjl9xp3kvQwgjhj
         E43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuie0203UXl1EhtYs+4s8DTcltYAks3UNrsXRKDCuXo=;
        b=smWQT92n528LOE0G+icW789cMYKYF9JfG2Iio9M6P0efcnmlKWFL820LNN2DHx7W6o
         a50zngASj0a1YvJ9M5VApEckzMZBYFKcAgZRHhyyZdBvZ68bzPF9RlaDsBaEDsOsrl4V
         HYtV80iPn+SHzEaDLZU+AyUHxBYaIchyFb6dNGP/13phusqjYBVA3ZpSY3IPdPJ0Mx2T
         TbgqR0HxU+itml+zaYHwGQf08fCRNzLaCKYxdxGdVx6u4otL8/0V8ili+3fj+vdkO6SH
         AxqeqpfnFAhaDsODG1OZcxaoiG03PtUL8X1vAERgyJXpOz+dMXrx4bt4ZKwhm045PRxL
         T/gA==
X-Gm-Message-State: APjAAAUsL8zRLWaAKMYKBET8zQ6E2l+E0njOfLMEUl0Va05fr4KjxzRn
        9Z0QnnF1yEe6Mf5tdQnrGjPrIjgl/GzmEnTz7WSPKQ==
X-Google-Smtp-Source: APXvYqxb3y703ROFiT/Kq4eV8XekHFlVPe2tMH65/jmgknO5EWQZHb0HYAaMXHfSQqrbXmFPvFCj9gTMQrSPEx37/HQ=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr8983626lfh.92.1559409897755;
 Sat, 01 Jun 2019 10:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <1558007594-14824-1-git-send-email-kyarlagadda@nvidia.com> <1558007594-14824-3-git-send-email-kyarlagadda@nvidia.com>
In-Reply-To: <1558007594-14824-3-git-send-email-kyarlagadda@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 Jun 2019 19:24:46 +0200
Message-ID: <CACRpkdYyOxYkiYXufUVVm3-v2a6xUGxS=DnqzAR_bdARspW5Sg@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] pinctrl: tegra: Add Tegra194 pinmux driver
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>, vidyas@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 1:54 PM Krishna Yarlagadda
<kyarlagadda@nvidia.com> wrote:

> Tegra194 has PCIE L5 rst and clkreq pins which need to be controlled
> dynamically at runtime. This driver supports change pinmux for these
> pins. Pinmux for rest of the pins is set statically by bootloader and
> will not be changed by this driver
>
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Signed-off-by: Suresh Mangipudi <smangipudi@nvidia.com>
> ---
> Changes in V3:
> Fix build issue observed with previous version

Patch applied with Vidya's Test tag.

If the maintainers have comments they had two weeks to answer
to the patch and if there are still issues I am pretty sure they can
be fixed with follow-up patches in that case.

Yours,
Linus Walleij
