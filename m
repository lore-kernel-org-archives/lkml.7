Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1ECC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779B42077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsztPq7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbfDXN66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:58:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40674 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730405AbfDXN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:58:57 -0400
Received: by mail-oi1-f194.google.com with SMTP id k10so3835974oik.7;
        Wed, 24 Apr 2019 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okrJ4ZXLaVHe1c4GxeRR9yA+jdOuvaoZmG8MKM9XeQ8=;
        b=WsztPq7XT1vOiNZebpbb5HGgY1L1oL5l7ygTjzMRYlF6scy4OsX5qBVCuZe2LhlZG0
         ca3Tn6UYwjpzq5EI5kxh3sAPnUult3Td9oN3+55PrFujaSwAZiNkKCfsvzrZRsn6PRpa
         APBgGHPxQWpuMe1cy4q872uoo1p1a4aGtA7zYKNbG+ToBxIQPX1/kQFleg7fo+U+yqBk
         4u3StMuPXfgtbmV02LsVWWplMM5+wyRTe+6O2G5Wqi5E2I5iRfrHoefQ3vowzAIKxZKE
         I3YcCfBoYdGSaEhCTdYtP9u264oYTmZm6q4K4W6L75q3+fKn322pIIDp/QujEn/jB4KY
         eazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okrJ4ZXLaVHe1c4GxeRR9yA+jdOuvaoZmG8MKM9XeQ8=;
        b=TRTcqNr2VF5W7VmbRTFpDizOxAX3BKnGWzaUP4gGVTcmwkd1Vv0JbU3HzW5T2VBLAY
         FQ4YvV0pUDznUv6tF6Cz0Bb5UhTCv1xyA9/eho5C1RLB5NLcuqENd/G7UNEoDybnL7Qn
         A8oq+MGtSX0BdhUpdt5egos7fUTBZSEZnKVS1jQydFhwHgsMcZkF6AlUwSRoukB8cvve
         KdxsbyaPghNWwEEryl8uocBmk3WynkO89DACnBmo3ACQWHUVEupXIYMCKjcUTYw01aJN
         +Q1hKQHvzSHhKBfqlO0Gp/yqpfJOvipkLo836YJhvj3SirGCjcYA52AfLsZgkvkaaoko
         pPHw==
X-Gm-Message-State: APjAAAUuqwmHMAWRorOm5Yt08wDqNTE5oYGh+6pDqXfpaor4i1rK6I5o
        oq3xkbPb/mVC7TKqMI4HiGD/M2IBwpLfqe+OGYg=
X-Google-Smtp-Source: APXvYqxFNyyoWFsx5EBfEumIUvcOYR/ENcLVKHUf4LznC2lMpLLkrV/165KCgT3k61xGBgP2Pekd8BcJfWwWlPy2kqA=
X-Received: by 2002:aca:4202:: with SMTP id p2mr5228679oia.169.1556114336612;
 Wed, 24 Apr 2019 06:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190416155618.1369-1-TheSven73@gmail.com> <20190416155618.1369-3-TheSven73@gmail.com>
 <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net> <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
 <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net> <CAGngYiUroMwErLugXeVXwHc37Nm+Bw4Tv5i1VUv8=qVcNbaSQQ@mail.gmail.com>
 <2630e582-cc4b-764e-9f20-f5a2905fa4ab@metux.net> <CAGngYiUWnFeHLee5c1=E6gS1mZtL9ferzaTdm0txFaG2wVCxpg@mail.gmail.com>
 <32fc1e18-ebd3-3c60-282d-0f8f94cdf5da@metux.net>
In-Reply-To: <32fc1e18-ebd3-3c60-282d-0f8f94cdf5da@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 24 Apr 2019 09:58:45 -0400
Message-ID: <CAGngYiUkQ5Ha5=kybYqtqKr+DBfq6jdyt_kYQeh6VPQqMK5ByQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 6:33 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> I don't like the idea of name changing *after* this went to mainline
> and people are actually using it. At that point, people might even
> already written their own drivers, so they'd have to change them, too.
>
> Please let's do that ASAP. It doesn't cost us much at this stage.
>
> > Greg KH has accepted the v11 patch set, so at this stage we can make
> > changes only by circulating patches on the mailing list.
>
> @Greg: is that already in your tree ? What do you think about doing
> the name change now ?
>

Greg KH has already taken the patch set.
If we annoy him too much with this niche subsystem, we run
the very real risk that he'll just throw it out.

So any changes (naming or otherwise) will need to follow
the tried-and-tested method of:
- cycling patches on the mailing list until fully cooked
- maintainer sending cooked patches upstream (i.e. Greg KH)

Sven
