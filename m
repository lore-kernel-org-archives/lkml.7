Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE78C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB33218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtDbAv/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfGDHg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:36:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39118 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfGDHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:36:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so5131342ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=No6cj2+2BiAzZgEaW7OR6lOBDi4yBK1px+PdIr3VDOE=;
        b=GtDbAv/IywE7PhRXWvUqOmx6Q9KsGCjBkwVjNNZQn3OSO4kPiJdSc/neYupU6Ali0O
         UbWtMNsjN5dA0o9BErBrLkAM6b5kOaVuviAGj8KSUEv8kvjyAhlM9qBTi7iXw3XkLgqp
         YfoWUmPTQFROGFGgcmYd8X/YekHU5gr4qcfjGr83vYcuYlMTf8f3sZIQgZ99gnSuNANX
         csoDmXLfQiptAmrO4UHttoP+TLhmTf9bRgmJNba64R0+gsYwzB9RDfwfZX18iUJs3ktM
         inPp9tccKf/ggtgEbUiTkqrIuuZAZY6Uc0oBjVm2KGYIlVIpfit9axQDfjVG6QcaV5X9
         497A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=No6cj2+2BiAzZgEaW7OR6lOBDi4yBK1px+PdIr3VDOE=;
        b=KKqRAh8vXo917K7o+xG0odMc9Q1mKlmeNMvpZJSryEhB0oJDPKNHYe+5pcsYZB6z/w
         15xuq5K18ygT1p+NijtNEKTWOWlMpt0y4akJdM/JA4NWoqbfkQvc8ZhF+TVsRzImec6k
         Ay/CC8JfEVZ+Lf3NkJJYCCcUu7jJVYYc5vRNbkFhXwpqmuSIPtpnOQe0OBM1OPrFEk1w
         6d6qTRXHbLQi3qUcUD+Ia/ZjFIy5CAboPlwj6ENr2Z0cNwfPZTYheuDpQq9VP6tM1r78
         A8LMZLyfAklPI+5BEpHJ0hJ0Fo6dY5Tfba/SbaQn++aBSMIvMGP7lpNC+yczgZIfAIS7
         vFmg==
X-Gm-Message-State: APjAAAXXBoxnZHvukq6sqCQbZ2gs6gWJOkpVggOAq6UCiUIAKUYypnB0
        1hsC5sGwjnGK3d3EhtDDBDaGhNcg+07J4z2zSF2kXQ==
X-Google-Smtp-Source: APXvYqwy+fMPKbIq3hb8mThiboctfMy+7wT11Xd72UUmGoH+spjBrnQdiTIhpdn0Y+RZYg8pm1e2gKBDV8gGrOyFLM8=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr23689446ljb.28.1562225808477;
 Thu, 04 Jul 2019 00:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190701142809.25308-1-geert+renesas@glider.be>
In-Reply-To: <20190701142809.25308-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:36:37 +0200
Message-ID: <CACRpkdZh2u8KnNofVYPN09aFuHOkXbXmkvJP9C3w+kUNQHBsww@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Clarify use of non-sleeping functions
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 4:28 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Obviously functions that are safe to be called from atomic contexts, can
> be called from non-atomic contexts, too.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
