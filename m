Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2BFC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4DA217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B87X4ShB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391016AbfEXLSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:18:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37968 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390903AbfEXLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:18:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id 14so8325668ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2peW6HqQkWUW+gSiVSqq2LhrRA/8zFUHT/OOexWrJ7U=;
        b=B87X4ShB9NkC+MOPhwk8HPyvcO3PkkdHwojp6+E8o0MihsFdKTzu2Yw53JssT8Z+MV
         e0reDyN/FTfF4UpHMln9YociCvietZjQasoDoIUDSibkaYEpwvA28ZcZGVbU+qJA4bqe
         nSg5CPHzl7Histd1kA/d5W4KfXURvZNGpFdsTnc4/SxZLF3kWoXRcr7IxDK/uImTZnoN
         8SO67f3NrXVdhCsjy3YMOpsWpj26WL4oveV6iT+EAoes4YL3jdUjhWi9CgRl7WuMaZ0c
         qgcJCIhg/A1p4IeVwptdAejJqoZaPvH066EfOj8qKiTUUx33oQyFMo2q7Cg23b5KfK2G
         YDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2peW6HqQkWUW+gSiVSqq2LhrRA/8zFUHT/OOexWrJ7U=;
        b=EWldgvwBy4DEUAiqa1BggGVpCwjvKB/YRH1sS+js2IdA45xx0Gri+yLGm6yjd6VinV
         mkLzL/vws/U0SjOGDTB0AGsLpRtEYHylhXtTFdjkB1Eb7vW3YRXCXi6xWhZLusqRz0Ma
         1HIUWlzvDDkvwsF1+k5xv4iXlYNzIycYENWU3u279I2d6l0HfTta+ItGXpG5MudHu41R
         h+HuNog8hosNNw4OBz5twYNESyAZjreMA8sciTtzfZfeeBhvnQWurVfp9L+yAV7MoEs1
         5EC4A2TUwlGw4pIsYSNRKrW47PRdP3DhFl44899dJ74+oTCxxifu1DGP0YGrYxebNjvV
         4Ifw==
X-Gm-Message-State: APjAAAWd6w6KSMD8weVNUvAMipEKAFE5+KfEu+EWXlciCzjpweFsqL7u
        PzB4Z81dqZL0+wLhgsCL+T9uR2VIFmURUpEABdMQvixt
X-Google-Smtp-Source: APXvYqySUTFUwtqsVu7peqTFry7ckapDnXMraEZeN13DWhiqn0x6IoFkQd+OxM0zC+G9OLOSMAE0+m/N2T6BVnhx0XA=
X-Received: by 2002:a2e:9456:: with SMTP id o22mr2546591ljh.56.1558696726287;
 Fri, 24 May 2019 04:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <1558007594-14824-1-git-send-email-kyarlagadda@nvidia.com> <1558007594-14824-3-git-send-email-kyarlagadda@nvidia.com>
In-Reply-To: <1558007594-14824-3-git-send-email-kyarlagadda@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:18:33 +0200
Message-ID: <CACRpkdYqFn0sdLcQgiSJyOXH0nFrHNsOkMBjO9H2aD9Eedr-tw@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] pinctrl: tegra: Add Tegra194 pinmux driver
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

All looks good to me but it would feel so much better if Thierry
or Jonathan ACKed this patch set before I merge it.

Yours,
Linus Walleij
