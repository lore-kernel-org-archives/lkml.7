Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D13A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPvyn03i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfC1RAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:00:53 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46488 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfC1RAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:00:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id k23so8992844lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqIxHMb/GEWiIrlFi4HhXDWxY+Io9KA3r8QmA1FcvcU=;
        b=wPvyn03i+qzm61G/fOgmnoLVw6psaDK/7zTq4Xpkd85LspY3KQuhMsTgA2VCS8SEwI
         NVu1cY6mkFLTfSMO71RC7yHVpD54nbwvTYlO5JdH/+/kAFVoLt4VenaLmdaTCu3mXkQ0
         15rPthSeRdwUGlhcpg0VkZAAJo/BjGXDofL5CtQiSnYG5AzAqxF83NdbdR6KveectRIe
         8v3VXF8Pu1lbCsXauue6Qu4hKzorRsmoj4OsqP3zg97M2/K3NlQC0IWY/omfNFneUalM
         oVkFJwX/HbLTfKTidYRgwOMljNoolXBoN4gAmOHhWODL4lTI5cDCyPU/5K3AZQ7d0n+K
         PFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqIxHMb/GEWiIrlFi4HhXDWxY+Io9KA3r8QmA1FcvcU=;
        b=bRhyDh9CX6pTS76uzQJ8wOw0IHXyWUfVm0B31dYDKnfT64XyTCA68aqAOx20LMM9sz
         8KfRuyxyKDNGNbsa10ZxudUPU4bWp6/urEbwG6f1z7mG49RfohIyld2kDo2qIXt7+lO5
         J4p6wRV+qFyY8K+xDnDdJRqG3t6ndV6QpHghb+r6c8b7ZwWi1MRg/eDmVOWg4PwgNCVc
         1OIvGFErb+shJr8NZd+A7WSJbRMPppG0yrRiTS25rtc15GmjoeXGJJ5B0uILchMlbIgs
         jzVD2HDnZAi4xKv/B33cvUtf+TooNz8b1g5I8ZmnKhKCA1aLhCc05jMbQBX4IHrs0jCm
         HunA==
X-Gm-Message-State: APjAAAUrZvU4DMzQji/J8xu6EOxM7tx+5qK/RmLStpHepgjSsCOOEfkd
        E4RqUpWT88DzU8Gh95X98mtSVIs3nLuvqxG+94Kz3Q==
X-Google-Smtp-Source: APXvYqxHeL5mrOqPNkHs22CXzwhpll10M6WUMBRhPN5MGabAYtksSDIZk62QRLp6jSnzwkgZ4jPs2afx/jJdcTSCfMc=
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr1556306lja.107.1553792450241;
 Thu, 28 Mar 2019 10:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190328131349.18838-1-geert+renesas@glider.be> <20190328131349.18838-4-geert+renesas@glider.be>
In-Reply-To: <20190328131349.18838-4-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 18:00:38 +0100
Message-ID: <CACRpkdZfXnwd1Onm7YgBi89GfC_jtSEAy0GrRHuQhBddaFL_VA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: Remove obsolete comment about
 gpiochip_free_hogs() usage
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 2:13 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> gpiochip_free_hogs() was always called from gpiochip_remove(), not
> of_gpiochip_remove().  It is now also called from the failure patch in
> gpiochip_add_data_with_key().
>
> Fixes: f625d4601759f1cf ("gpio: add GPIO hogging mechanism")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied for v5.2.

Yours,
Linus Walleij
