Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51985C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ECA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnx+CuUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbfFLI6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:58:32 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41512 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731402AbfFLI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:58:31 -0400
Received: by mail-lj1-f171.google.com with SMTP id s21so14409562lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKauJBPQOqxGtVzNuf3fprEZzBxC6KXL4WG2Nxgkiks=;
        b=nnx+CuUK3eR2qMPr6GAKKvG0mkxPze1gLGjt+fq4RsDs4UUOoegAmM8XnLC3fnGQgW
         GTyqhslKNfo/iN3MHt0Zkvz4IqfR0N6rbMucbW0h2QpKLOE1944ZRLyzomjSZPncB4oB
         JdxHik6NRZooJbbcRYM8KsNh2VMSsKY6Br4iawfVt6D/w+eqx+VC7seuAfYo8l2rkyNY
         n6E0NgG//tOXiD7O6bo+tDyHU269Jh7/rKJm27EMXHQ4E4e4uoqiXyod6YS8/FQRssQq
         RxZZWrIoYGP/LrZaJcCtp3zHGIRLVAMIifqQZht5xZ4udl03rTMJAqgboklPlsWDanWr
         rwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKauJBPQOqxGtVzNuf3fprEZzBxC6KXL4WG2Nxgkiks=;
        b=A4EP6FRjp+KjAfkOrYnPNV9o0vebkodal3uegTIyFYYFbGepH/vv+wdgiTWXbGUF+D
         fCpRI8YXMBBd3luJPuVr9N3QgcAGCqjKFqvbtt6tKV+Zd/Rs8q38P52vXSJzd/nJUDi1
         61zdWICUAVer4thR0V9j8tPMk1IPpHfd4TkoBN+08UynC7NXd6waN3DJL01eqsA3R0hY
         LoixbnoxAblUMZlo5UZVVJC1h3p/ptzugBVCk7kE3HoG3dXjWxF/yJ3V73l9XZSVyrGT
         9ZfotnEhlX09Q5H6f+xrMC0qboy0UHCAUADW8wDPYdYToGFaGlwewZmFJACtiU8lU++q
         5lQA==
X-Gm-Message-State: APjAAAXPG+XjP4VzcF6Rc+WeRbiht4MpGXdTjjJqPLmgoAhEb98o++Z7
        Ld8eCpWKLh9lY2KzXOp6xJSCvCf/mM/UxgKpt22tgw==
X-Google-Smtp-Source: APXvYqzAY9mtYPmypf1H3gmCAmSQiLenTibAeELDBFfuArXscCYTvhyZ71qp7kWngsG+U17kzAzSUBBfpqdbrkoZuoc=
X-Received: by 2002:a2e:2f12:: with SMTP id v18mr42095554ljv.196.1560329909819;
 Wed, 12 Jun 2019 01:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-19-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-19-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:58:18 +0200
Message-ID: <CACRpkdbELs-gZVeCCnFBaXOqzWQ74E+SF2ZCXOy4deGA+Bx9Tw@mail.gmail.com>
Subject: Re: [PATCH-next 18/20] gpio: gpio-omap: clean up wakeup handling
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

On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
