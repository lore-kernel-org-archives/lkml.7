Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C0C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BD620874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkw2vw78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407842AbfFLIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:50:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43843 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407695AbfFLIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:50:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so11424804lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vuhsj8ps7SoI8pHZaVFcrUKuy0qDciUA894xP8DRI1c=;
        b=lkw2vw781vVGMyosGrYdwEiUBnJCuHpUhii52spA1D374RnIXXcbWHhULpE9Cz5fmz
         jmB85H+7KSiCEmERTaGMa22EZKTl+3OYa8g0MsTQWD2uhjj/d5zIh3qg1+DMlc+4sK8Q
         mTgvWQZp4q10h23z1ayCPZIN3/NdXQys7b/IO4fiusknTFklvF1liA0BZAmhOCz3sFq6
         5Zah77HNqQZvTtXyZ2ccq5Eq8FftXW2Jr+J2H96Hi4sxFkZO9MjnuM0Rbc4Mr0Vdl8Rj
         9rXkL9rlg8PznPdeZHTFsQ71gEW2TvVtfPsHYmHcBeeSGoxKAsB+7Ke4HUnrh2Sx77Hg
         /DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vuhsj8ps7SoI8pHZaVFcrUKuy0qDciUA894xP8DRI1c=;
        b=ceHe1aq9AjF2SPHb+R1s57uPmQNxz8FZnFhzE/fX1+di8LzFhAA82ivWurLrI2fVYY
         oQIlFwfXk38sPXaH/E7LDDCx1n0q3c7DyKRPhuShaFspZLqQ7YXPkpuYkd0MQ4JxtSx6
         8tldJ2OK6vxu5R3gdWzUHJcpZzbNBlecyAwOs+yV0s0soPP9A/n22v6L7qG35es/V2H6
         7Jnz1yfsxYwf3BTkQDwH1dA0b3UymnaI346KPJrpmU7CvW7LAix/PVa0aCCWDG9B8jb6
         j0woowYh3sOHRC45RKjgZfI6IDR0YOFQlNXQu5fZNCNbAII/RdbjmKN4lA1nRqgbGpuF
         yuXQ==
X-Gm-Message-State: APjAAAVzu13koTnprFshF1r9GyYSxKG78XZU1Jct4Zqdiecx/NfbUI+H
        9tgAWRehmnsAO7b6sHfdgEFESxfETwXz3cBzU7Wr6g==
X-Google-Smtp-Source: APXvYqx/Pz3jSzEmkSAKK/Db6SB9B240P45Yftu+HhZmeHD4XRNwcE1mRWbkkKG0GpZQ7u52u6oeOPXCKenRxEnY3+M=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr39731956lfh.92.1560329422587;
 Wed, 12 Jun 2019 01:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-10-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-10-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:50:11 +0200
Message-ID: <CACRpkdYWjOx_=CTq0uHPD0eQhKytQSMwpkK7cFOC65v_ebPwWQ@mail.gmail.com>
Subject: Re: [PATCH-next 09/20] gpio: gpio-omap: simplify get_multiple()
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> There is no reason to have helper functions to read the datain and
> dataout registers when they are only used in one location.  Simplify
> this code to make it more readable.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
