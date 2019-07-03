Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E663C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E57218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBKUEIk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfGCMfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:35:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33346 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:35:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so1677115lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yjZLyM9JOHe1yZ3T3nibJuov33+lgCxQ34IkJ3YWoQ=;
        b=MBKUEIk7naz4Y3fvvU65OzmlKtCI30NENWTo+afhiNMK5znd4Y1eQOnkDJOcg0aY+v
         ++7it044iEA0/FnqXRy9uVMCF6MR0sNynwBDdD22xtV+hNHMNNgjCEQ7U9rlh2JYeWWM
         ewuMGRi59rNUvNyn7PxpkrglasWGXAJsTnxIqrYGrHBtU2YQ1mcV/erApCDaFvkfJ6DQ
         i31VHZa80MLy32I5VNuyfBI7GYE900zLgxPQbbTlZ40LoCUOyotjP3R5q6l7SryAy4qi
         WQevM0L80vkOVIsX3mZUNJ2TZL463RUKjeI7Cpcgj//LRodNH7QyTRygpFWHsLjxAtqT
         qOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yjZLyM9JOHe1yZ3T3nibJuov33+lgCxQ34IkJ3YWoQ=;
        b=VFxi38D7DNjOV103fMShd+q52JuA0QdVUUDHRTKxU4DDGLcEgmXmTzUATKU0dNs9GV
         JB9JPt0Ar23jVHtIk+LrVN9D3rsoiI3+BLjtcLz/c3pP3mAIzt0bmQZKNr+XokuqbZfH
         8jfYZS5H1p5zpbbeHlIy75Lyzlgpjcii6pKumXgYTQgio4VOiTgPygpVzQNzGB1X+WHC
         2m+noAyUN1JWdwgpFRYppYqfJGZWceZ1F5BOubsTfQCmZiIamZEKVADpgk/mmDaRnRey
         3V6iL/WTDHPkT727idKrgF7KnhMJPUCZno8ez4DvSHjYn3ORF55Axle/yVIg3EZHwHBX
         wg2A==
X-Gm-Message-State: APjAAAXS3RoaPMO5BkBzuO4TCMC09OrRLwhgF3Gx1RMQYaYaJxNh5o9g
        wOskXq9fQAui6Lb+ImYNzsA9A8o0BZ8wO0+0BfxltA==
X-Google-Smtp-Source: APXvYqz7dH1dOhL9GPZ3rezQELsJyZdenNecNAinD3cs2wH7cnyReBlZqciqoJFvA3uBaX6sgLuWduWNDyfTkk2F5yk=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr5964199lfn.165.1562157333469;
 Wed, 03 Jul 2019 05:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <1562146944-4162-1-git-send-email-info@metux.net>
In-Reply-To: <1562146944-4162-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Jul 2019 14:35:22 +0200
Message-ID: <CACRpkdbtwXYiKOo6LwNm2bQnEMSUoi2UutP4DKXzt=_jOcRkLg@mail.gmail.com>
Subject: Re: [PATCH] gpio: pl061: drop duplicate printing of device name
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 11:42 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> The dev_info() call already prints the device name, so there's
> no need to explicitly include it in the message for second time.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

True. Patch applied.

Yours,
Linus Walleij
