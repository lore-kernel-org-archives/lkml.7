Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3791AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35621848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwDOYcsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbfHZUH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:07:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34835 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbfHZUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:07:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id l14so16295178lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c92BjnNVgfZLXIOhyylGapSRsNCPw3Ef4tEA7baXWu4=;
        b=hwDOYcszyJaq1djxoAsdgpjbWsdRoqL2rImR8JYo1xsvaWTITMH1YxHFoOBwvqOrCl
         j/0Tu9nOLnidmXQ5JMdF5eCalrFwl0Wmma+QSb6T0rB6zcHnw/wys2fLX/R6tPBvjyND
         6OzpjAFOpH+p05WdCN+87pcKOvokk8AXb5B46UwNKSmu3smjEu+Hjm42BhXKsPmlXe/E
         mFuB572S+TVAYHaFvRHQjhwCf/1LikKsk/z2zlT13bZJ3HgaeFp7ORZAlUUBs3qZhu/n
         GJGutHBCfkjfRMKTG1ec4OeOGZ/nfPtICyw7rH1EYnqedHkCizIBj9RlYF+yUEsuRflI
         brDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c92BjnNVgfZLXIOhyylGapSRsNCPw3Ef4tEA7baXWu4=;
        b=gZxeIIbUcFEBrHOljk2PoCrVejo+EcexgkDLPI4S9LUy8mC1rvHr9RKECF+KitSKiv
         Shdt+jXHK1DjTRptlOIyq6UpUOyg46rpgbImrtruD1Xy7TQrbrixlv0WfaV6hgsPc+35
         4K6visJbXukDytP5jGwdmkZdOqicNo76ey9p+GlANZAcrRwqjWU7sOpducbI0iepg/3Z
         kpOmneTkxoinMyzmHklQOktDE20bIADWoVXJVcJ+VR+5aJ8ONbSNIQPFOiVj2SqPb6tV
         O4Iny5WIEHuGP+4K/25Ij6J53ZWakWF6lRrpDuu/f5EeywJh3gIaohsSYgKOsbMD+h0d
         GXcA==
X-Gm-Message-State: APjAAAXQnmD37fttzvk0vz7KXCy/W4C5sAK+1MsoHKW/Qk6iOMQXF0P1
        DEoMEU3Ruedk2Ge8ExzSjg9DprmY9iKfKrzR2Wo6/Q==
X-Google-Smtp-Source: APXvYqwdVacdkkTIiNc4ej4zpP7wnFPalWn8AKBHdtMHls322lhjb0Nzh2G0ic8+a/WiIiu09L5/nD3J/b59IQOVLBA=
X-Received: by 2002:a2e:781a:: with SMTP id t26mr4564513ljc.28.1566850073876;
 Mon, 26 Aug 2019 13:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190822211518.5578-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20190822211518.5578-1-christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 26 Aug 2019 22:07:42 +0200
Message-ID: <CACRpkdb0CuPVby066zjqLX1rRuc6KDL7jvt3KaCpEWgEFvp+Mg@mail.gmail.com>
Subject: Re: [PATCH] drm/mcde: Fix an error handling path in 'mcde_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 11:15 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> If we don't find any matching components, we should go through the error
> handling path, in order to free some resources.
>
> Fixes: ca5be902a87d ("drm/mcde: Fix uninitialized variable")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied!

Yours,
Linus Walleij
