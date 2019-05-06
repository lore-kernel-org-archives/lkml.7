Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B697BC04AAE
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F620830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2L8hf9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEFHHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:07:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36224 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfEFHHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:07:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id y8so9884928ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 00:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwhE2uGZiLqXEkI99lHZnisKdDy8+j12/x0rEBhmeMM=;
        b=l2L8hf9litttSO44g7UtX5hvurVX6oUBgrgVujLll+Rl/TJbvf3yhbIMo9EhmEZ9Rk
         Wa2kzhcPXWJ1bcoLMsvfOY2kCOo0Dp9p+w3OEZsKkK4mKLpsiY1e935zU70ZGM5BvbjH
         WQHijhdwJToIsiTpW66nmXUpeAGgGsTgL2YH9b3xSEgDX996kJl1VxdiNLu3a54gq9y8
         s6bqhRSSGn90aGEWOpIXvBqEf1+xLT9YdV6OpKZyCSTnbF8IYG0R1/R/nVPrV3mzSSUr
         r+RrzSE2Cwn8yJsRl+MCGGc+Nv8WEiF/H4gRbUC007pQnjF5URyBaMLARwq1JvbYca1w
         IVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwhE2uGZiLqXEkI99lHZnisKdDy8+j12/x0rEBhmeMM=;
        b=Gf8fI3m5PYsP6vFqYULNrggym38/mg65ePEplTolbvn3inJSBqbMi4eDBqPTlwrLjU
         QvLiwrNp0np3HTsiOL5787lSWR22e0DXVyO1aWMysJqdsgfz6Wk9z6tc3bKavCYrB0U0
         zV9vhR/Ep2vQrqLCWbIYBYDK3Ucpl7SfUIsOZYChReMthj2B9EBwX4ZvzkIHEMR4Wr+g
         eJb7ME2T4XeFqox1YpiRzG3O9YI4Z853jY3q7vG/Xa1eeU+laOS7trriOe+1ofjH8qbW
         fs8EXRw+o6xOtvWNyDvMiYDFJSYyH3rRxyUhBWc/rlbLySFc31vahNML1m5eWFAcah1c
         YQcw==
X-Gm-Message-State: APjAAAVGbpROGidI9QXoa1+rLn/gAywBTL7NIMtdxPJFy8aJoarJxxWy
        tEoJUUGU1nqzaUKrwyd87yCfZOxZBz/5E0PnOJj9xQ==
X-Google-Smtp-Source: APXvYqy5QhAAjdwvG22vzOX8m6OHCd2VKpL1I6A8CX0v3BiwyS6su6YLuw04TDhpCSaHEIZ/H1RuHvzvAIH2QzK179o=
X-Received: by 2002:a2e:834d:: with SMTP id l13mr13133044ljh.97.1557126451228;
 Mon, 06 May 2019 00:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190505130413.32253-1-masneyb@onstation.org> <20190505130413.32253-5-masneyb@onstation.org>
In-Reply-To: <20190505130413.32253-5-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 May 2019 09:07:19 +0200
Message-ID: <CACRpkdY_SwZMudmKaC90Q8O4OnhjVLeGN2ZU29xGw3FGG3uYiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] ARM: dts: msm8974: add display support
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 5, 2019 at 3:04 PM Brian Masney <masneyb@onstation.org> wrote:

> Add the MDP5, DSI and DSI PHY blocks for the display found on the
> msm8974 SoCs. This is based on work from msm8916.dtsi and Jonathan
> Marek.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

From my limited understanding it looks good:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
