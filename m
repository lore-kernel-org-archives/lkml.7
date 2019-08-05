Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F664C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEC3214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKtNIrao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfHELUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:20:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41974 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHELUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:20:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id d24so78950955ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00opSjOUCt0nvHWrKUPJCC41uhCnbdAiE9Dvugabrgg=;
        b=bKtNIrao0IXWWGBcvE4CzCrr4sVoZERR4ON2NQ9OUZd3DlWEt0fbTvltfQc1fMItqO
         dsQMVhVznXe3BOPo/GY76BB+5MNqtZkga02sTaQ1B9i+FDp2i8IVn3oylXOL0YnNg/Xx
         kXJTbNyAfPcmDFWDUK+uXMPNY57GC1r8KIvEV9S4hJeXwQntlX9Gnc/yt0P3ZyAAyTM4
         EjnF26ghh5wVcfspBsS5Nx1tkhSHjb9v0fLoe6I1eAIPHzcb9esskISaj29AdtLbs96n
         bZXyOLAt6BOM/GcX02aJ7dOZ4K3EWGLWaZqArERR5HDprK7lppQ3olXrPFh6KSoN1lOd
         4nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00opSjOUCt0nvHWrKUPJCC41uhCnbdAiE9Dvugabrgg=;
        b=TzeWSUemkZswJVBnjpcWFcgpAB+rbS610K7RYdN/36EO/6v4ZcQ+rCNGvaRqFwVRlj
         C7AIcrXYzvhqVtQD85ymrjaCyb2Pbev8bhFd+rFXw2N5WufvXtuv535eHxx+WmSZwnLI
         2x1qk4KbosNLmAAEuLvHAH2ILcYk/H6u4n8NJ4AoDhnjaiebXlDP/sgbsQuXu2MX6+h7
         yQrhLIpJ9j92QNL8M6EVv04z4eO8dZE/l8l//hSV4gWq3Q4iinbr33DRsLUG4Jp9/Grb
         ro2jTdpmSj2W9A6Ka2oqdPo5wx8V1MPSL6CrPM8+FBb+RCIMYmnPX8s0w5LK8d5RzFqA
         NZkA==
X-Gm-Message-State: APjAAAXXHoUZgDz2mnujzGR5JwhZuUHg2gR3HVlzyF3AuxHzHYHOl7zR
        e7/N0UD6DcrXX9TiZ865jZGbKDYDDZ8yqRKYbxCELg==
X-Google-Smtp-Source: APXvYqxNKcddtNY/mJyk1N0KVe71/UAx4m9nnhShPcFo6aRkA1Y7BWTouzWMllsjsG48s3b89d8KGfW8kMTL85j8Ycc=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr47728ljg.37.1565004011463;
 Mon, 05 Aug 2019 04:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com> <1564465410-9165-4-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1564465410-9165-4-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:20:00 +0200
Message-ID: <CACRpkdb4xvUROYncrF4b+8t26A_8q3OEH9XD_tS51B6Z9Yc+tg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pinctrl: uniphier: Add 5th LD20 MPEG2-TS input
 pin-mux setting
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 7:43 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> The 5th serial TS interface uses the following pins:
>   hscin4_s: PCA[11-14]
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij
