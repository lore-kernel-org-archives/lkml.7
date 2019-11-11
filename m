Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F7AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37322184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xR/rfmwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfKKLll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:41:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52102 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKLll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:41:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so12964900wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QrjCfBQcJwKIUUDAjSOiaKTYkFf5ndTaGfgn7ED2v/8=;
        b=xR/rfmwJkeoO0nfTViXcVfHVxtjQPIw+/g/mwtDyiWl0xvZzkju6l8kehaXwzlh2hE
         N1caFwcFkMVVjG7mM4hS1Blyhb6dQzMq3+L4kUjJL7APe9OhT789Q95imMdQbJBfa0pQ
         vSqM98PXFHwYP30Pq63EGCZNqrne1AYiDuqsb+LDO5ixEeUtq3iWulMX0I0BfR1te1hR
         Am4LMzfA9QgqbhrIfmXKSTmNE5mYxbuQVgCl78YPyliG86quWG85iMrVE6FPq8mHZZWB
         sux1xYxifK6ex8Q9BAODwMIaAlOmKV8P9Sc/tZOdcAfUTD3EagSv9YO0fIxUmlGiDJfy
         8isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QrjCfBQcJwKIUUDAjSOiaKTYkFf5ndTaGfgn7ED2v/8=;
        b=YKBHLlgmSgAZrDmNI25gQtN169nECuW20itQys9jQrIBOT/H2SY2aqQZko/y+4LLQg
         fFt7fhmMEk0eq0sx48TEqp8N2TbzcNA7YijOn2Bn0f4ACXGHgRA3PMcll6bRUG750eai
         Hkf25+vmbnXW77gwo4q8akwCKeTKiEpIoYcXpqEDugsPKGLUFqemGnBWoPKZQKmX6MBx
         r2qGVNWLo3wPVIGIylt5gXV3S3QK0ymzhOtGUhYoxVXUbUY2Q3hZ/cxVGCzZpTt1jKGL
         K0zgRZfnxre1iBUZHqg1CxSORlR2kbr/9FqGgMcG8Au3Z+mXc+O5T3TT954z615QH+hz
         ZXgw==
X-Gm-Message-State: APjAAAXN9hT60CluYlupfS7GYopp2UETO2/RZNcCHTEb6729Q9qO6IG2
        8Px/szcK8mnEGn2uChjY22u90Q==
X-Google-Smtp-Source: APXvYqzVlKEucZs/sDv+ll++yan1K7OhNmoAUm0WJEXWNZIj5Q9haqGMCwNCLqw05ElIJj46eF9uUw==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr9278569wmc.164.1573472498674;
        Mon, 11 Nov 2019 03:41:38 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id g8sm15865768wmk.23.2019.11.11.03.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:41:38 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:41:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-ID: <20191111114130.GL3218@dell>
References: <20191022083630.28175-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022083630.28175-1-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> While working on my other series related to gpio-backlight[1] I noticed
> that we could simplify the driver if we made the only user of platform
> data use GPIO lookups and device properties. This series tries to do
> that.
> 
> First two patches contain minor fixes. Third patch makes the driver
> explicitly drive the GPIO line. Fourth patch adds all necessary data
> structures to ecovec24. Patch 5/9 unifies much of the code for both
> pdata and non-pdata cases. Patches 6-7/9 remove unused platform data
> fields. Last two patches contain additional improvements for the GPIO
> backlight driver while we're already modifying it.

All applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
