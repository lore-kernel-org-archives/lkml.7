Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83E5C49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A271220717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB/L6dgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfKEJVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:21:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36771 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfKEJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:21:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so8822447lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 01:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/CqzVlG8zZAxxKu0vX1NdhVqqh2p9Uh91d/oE5bEMc=;
        b=cB/L6dgy3oPjI3dV+qGMCvc4MOdB5pQERdwKy0ik6L9roaBW6UIyW2VEtSjvxT9yC5
         sn48tazf1Tx/XEX0UzchEkwheBAraWYqFdbbBVS/CQQWWsmqt0Zi0mECdk9PRbeLD3gw
         3PIs8WRvvJqRv4HAbYDqEkLcsHOfv7rJfVS5txO6KwIqN+rbja0ui/iLe3v3a0BH1IQY
         qnBmhU7rltn+IcsBboFu3T3puSPhwhyu/knnR7iAEvpqoGXcc4EPkZe54WJ+GTNGvypy
         NxYDE4Ox6omwzjNIQbrC7ZIGduIYLK2eG6n4vsDSUabJpjE9MLcFvS+U5K88rcs0DD2i
         yDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/CqzVlG8zZAxxKu0vX1NdhVqqh2p9Uh91d/oE5bEMc=;
        b=NHavk4PxSycnmKs9/1wXwmTS/jYccjGcLSO5LOo8hIncfmGLuXp6/CPROMGjFdEgrg
         sKBGbmTQtbdhbuFcyBKhl6koypX63QxHwCLQ/wHC4511ErwyAhXUP8g0yBSGL0V0K4NE
         mU+VN9gaW9VOYcN4ePiZxtAJr8H28lx0wHxdw6pcUczo1c3NvjwEV+KPmkFDiuDBLesK
         scrPxBnRyfWr6/aaSa8evelwFXj+u8n5VpHclIcLl72gZ8ugYTm1pNcejL79w+zgRqzS
         1AKh3ldXsEp+ip6MVA4N6lzMlvWo1QrEdprBZLfXeohk62TQJD+NY4xHxfxDYbNWim4D
         k+pw==
X-Gm-Message-State: APjAAAWiyeTeDVQjLUxXrCZ4om3jJC2CRykRR4ReAGWKY8DELfPgcvcd
        ONIMxy/bh37oqDJBR4imXZyTV0kDsEOp3UzQ6QqQ7g==
X-Google-Smtp-Source: APXvYqwmMv3t6J3okAPckGlL9lzAur03q2Mfx8rqE3VQcM3317qB2lKyitRE461c8i9EOJ6uFvuH5xh8sDJfPyofi9c=
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr21359472ljb.42.1572945700516;
 Tue, 05 Nov 2019 01:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-22-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-22-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 10:21:29 +0100
Message-ID: <CACRpkdZT_3fV+u6aLk_w453XdgLF7KbQMzPB5ZJ4xd8V-LvoqA@mail.gmail.com>
Subject: Re: [PATCH 22/46] ARM: pxa: eseries: use gpio lookup for audio
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The three eseries machines have very similar drivers for audio, all
> using the mach/eseries-gpio.h header for finding the gpio numbers.
>
> Change these to use gpio descriptors to avoid the header file
> dependency.
>
> I convert the _OFF gpio numbers into GPIO_ACTIVE_LOW ones for
> consistency here.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This is consistent with the way I imagine it should be done so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
