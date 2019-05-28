Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D322BC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9329214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wIhuxC/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfE1Nq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:46:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38568 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfE1Nq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:46:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so8217342lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uimJHxg6x5yQ0SkHYR4jhNo2jzcs/560scjjidJxXaA=;
        b=wIhuxC/qafCCzj9xj0e1GyrPTHQ9LBOu5VnQiwMSnJKjudJatYnjbRzVzl7upG0ngG
         cWtzKZmvp4vPIiRmvem2OWDEplCrgRfOuYzeq7EjL6eblc1GzwDuuKZ/uZmXUkyNAH6M
         h9ICrKl5D7CVaL58rjVCvLBqaPUOu/RAf73EcQDaGcodz0JIMVeJAaFbOlYrV7vaY7hb
         QOvaCL5bfa8tmpaGCOdUxmeU8tEyo+OhnsBwZdL+LTvxyjKmLP60bPkiyBYGH1eR6nw8
         87ZbuRmU9ShywtYnKzjS+OIQJmbJ9jsjjuUx2i0hIDJr5LWtHvg2bAOY8ivWaoxDmWM0
         b3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uimJHxg6x5yQ0SkHYR4jhNo2jzcs/560scjjidJxXaA=;
        b=gN8b2pLVkvpLKz2mc3+OExPveAaEo5q5pMp4ySRhLsvwHM/oSzxSlLwJO1KPKv5rYS
         yux/SDLdrEmKcia3W/+2OHoXwvbc9A6oy4yaEnvUTWYbUciimR/EqZeINaqHiVlqD0sL
         ljUWo6eQKDGUoCXRGO7D2tYGTfIeDKDSTCSrW1frixwQXGt5+QIkwyUYm6obsQG6jrM2
         /sH3JuQZ8hMZ/YFgd2ViXNrr4yxXwtcxurKilhE0F740gzhhQ+tIVCxGwPchOoj+qu1Q
         bOsMi09ojgUtMZZ/vfueEEd/yC/95gcWatoWS8yAg63qOTq6/vJ1qmsY5CY+eC/c05Sl
         oV1A==
X-Gm-Message-State: APjAAAV14K1H1Y7MGeO/IJ5ItqklAQkpdqH6FOf/MOrxuvPh2NYaR292
        hpqTUQcgx2Ec8VltK5Y5v2xWfzNUEumr2U0LVWXsOw==
X-Google-Smtp-Source: APXvYqy4gMwzBlvFh/Ib5gpRrpfYM0F0Z553OBKhHwqFjc4A6FVcEqQkL1jjwcIYhdWJgpLzcJ0GmyoVFzYPjUkcRek=
X-Received: by 2002:ac2:48ad:: with SMTP id u13mr33425124lfg.60.1559051186146;
 Tue, 28 May 2019 06:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190509020352.14282-1-masneyb@onstation.org>
In-Reply-To: <20190509020352.14282-1-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 15:46:14 +0200
Message-ID: <CACRpkda-7+ggoeMD9=erPX09OWteX0bt+qP60_Yv6=4XLqNDZQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] ARM: qcom: initial Nexus 5 display support
To:     Brian Masney <masneyb@onstation.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 4:04 AM Brian Masney <masneyb@onstation.org> wrote:

> Here is a patch series that adds initial display support for the LG
> Nexus 5 (hammerhead) phone. It's not fully working so that's why some
> of these patches are RFC until we can get it fully working.
>
> The phones boots into terminal mode, however there is a several second
> (or more) delay when writing to tty1 compared to when the changes are
> actually shown on the screen. The following errors are in dmesg:

I tested to apply patches 2-6 and got the console up on the phone as well.
I see the same timouts, and I also notice the update is slow in the
display, as if the DSI panel was running in low power (LP) mode.

Was booting this to do some other work, but happy to see the progress!

Yours,
Linus Walleij
