Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D4C28CBF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457A92085A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="c67OmT7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfEYLJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:09:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36424 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfEYLJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:09:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id y124so8878353oiy.3;
        Sat, 25 May 2019 04:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fa2wab8YpKsUwDpZ6LomoWPNcWTcG/N9TaMQ1o+zIL0=;
        b=c67OmT7BgSIatc+fEm5zkVjKvMjEwSFy5vAdHSlzMFO25BVsv0RZjruxNDkuzn2iLx
         klGHoFDq4TNqHvQ1LKtjckQh2sN0bJ1riF1s518ZE7aQtAZJT4/6SkFJcNS3hU6EJS40
         V3SrTBSGSQRf6tg3FUQmIJz6f5BJOLv6nGUUWxbqZpLyjO3b3QNugBptVaawlsUmjMb4
         tNmUb29hf5nj7bMpPfgbEkLEf1nQ2J3QSjxvQMQqZKA0+fVgzQx/mbzW9bfDLxsuEUrU
         YjN57innUMc3zgo620zmAMjqZPQ6GEhoIXqNGLnSaHAFhs+q1HQYUG/zq4T20X8MTle9
         jUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fa2wab8YpKsUwDpZ6LomoWPNcWTcG/N9TaMQ1o+zIL0=;
        b=MLJThN/aPcqHIfjsaGVlVby8ISwwT2cHKz0Nj6ZQdZFodOMih9AsbeyId3kKzlDZiZ
         9dbm9sdCrTvISFQpYMvwMPNTlOBXjRUEJJUzeP6GFjDD09iQOOvuXkj0VcdSojTg0ixo
         X/6XSMVRGgPoJff8HypafjtpebE1P6+z+BBxzFnOiGvib+BeWFhUwUOuKHe5zUmZia24
         ajozDq8IFRnxp6bH2axXwnToNuINizmsu2vaMhDr1iOmoGjN3h1uF3FJUaGOOsZX6a6E
         Un2i9jOn8RRc4kl+sGwodW0gctqT3GfHnUQKdVXXlA0Ve2XnFTE/Av5iP2ahB1w2qbu6
         M73w==
X-Gm-Message-State: APjAAAXapYzX4RWUCTxVGcCaycSmwks5asfAkLak8Fk451JhqbbU2ebM
        Sn7yu3FDAefVTINT2HooqLfR+oPGEfpWys4rXMrnibLGSpw=
X-Google-Smtp-Source: APXvYqxC8ae50HwEo+Xc34XhxDEEcl6oJoQQN+XKJjwNIs/j8rmSnhxVMwtlaFf+eLf3WdRuGsP210KJP9D4bZIv480=
X-Received: by 2002:aca:ab04:: with SMTP id u4mr2626924oie.15.1558782545011;
 Sat, 25 May 2019 04:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190524091532.28973-1-amergnat@baylibre.com>
In-Reply-To: <20190524091532.28973-1-amergnat@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 25 May 2019 13:08:54 +0200
Message-ID: <CAFBinCADSKoDc3cUofAtFxDMeQ819FsXe=ULtCmn1g0drSmtTA@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: g12a: fix hifi typo in mali parent_names
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:16 AM Alexandre Mergnat
<amergnat@baylibre.com> wrote:
>
> Replace hihi by hifi in the mali parent_names of the g12a SoC family.
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
this is "obviously correct" and double-checked with
buildroot-openlinux-A113-201901, so it's:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
