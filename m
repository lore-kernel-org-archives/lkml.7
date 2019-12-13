Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D7C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4A2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK4ZgQ3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfLMIto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:49:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34258 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLMItn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:49:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so1687997ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1JOZKU3xEudJiyZSdDJXezSL1VMnF9zJ7hQY77MyhE=;
        b=sK4ZgQ3I1MDMt1BJme+WWnKfSQHo54j1ZoLoWor4/ASvWr1mjNT7v7g0/BhdIeVyph
         Xm0WWDGOKCsOnB+Vb7zo5dqwk2cFqH5L5CMH9KG2WudlbpEhRAEFJM4l5AmOQFIwhq4e
         Z0PaSE44DFQmm1KxgwogrNgfaWXfE93iwQBGxWpqK7+/41s1D/oQ5Kw1ddlzVoq19xJs
         CW2LGsZI5i0XOQuL13yhuYRQj34gZrDOJmPs6ba4/LL6UTo+OeLdCBYkHdzy5xT9vmko
         MH9bMeGD8aZ/tVNSxW/yeEfjEo1kl2FDBmp5lHja+RYQz11gS1d/CkRiBmco5JvpKfCm
         J+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1JOZKU3xEudJiyZSdDJXezSL1VMnF9zJ7hQY77MyhE=;
        b=lEYT73nIGauUGH9VajyeSe1908LH4ryO+3qn8y6Ybrckx5nWdhb6Ov5bSwWZ/DxIRd
         XFGLaN9yIwiyQVCYrdb0IahYKr9UdsB1OVWugMaHghU4zOdhJmsmjAaF3suGoGrdDlGN
         lCoJkZocgao+1Yy+7ajgN0LAZZ4M3bgzmKsjcmv1Y2GCKZicLwTR2HtTwQwwxaro5/Al
         z9dXfHkvfLtTZIaY+E+P0UzJiIFLspYYEyFWHXHnOahJiEFw9ly4PaXmjz/XLP6BsVar
         1mJoxOiRw0DxjzZVO86akDRdkPMZMY1/Rdb7MXiMr9ntuu7vjulQ+YPtGTBm1PU+qjAJ
         C5mw==
X-Gm-Message-State: APjAAAUJHv9CnFzU+HoXnrsYihKHJ/ZEdomEx/FPnq0TYM7S7yp/p5gC
        OLRP+J4Pwt1DIvUpzXQZTR5a3RApl/nQGBwX/3yXzw==
X-Google-Smtp-Source: APXvYqw8R3tVL7YcPB1QUWAfPaywn/OZ8gj8e1LzTXq3Fsdndmc67+vCT3PwvhB0ehsJ2ot7As+6b33BkV5z0TC0TKk=
X-Received: by 2002:a2e:844e:: with SMTP id u14mr8785712ljh.183.1576226981672;
 Fri, 13 Dec 2019 00:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20191203141243.251058-1-paul.kocialkowski@bootlin.com> <20191203141243.251058-3-paul.kocialkowski@bootlin.com>
In-Reply-To: <20191203141243.251058-3-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Dec 2019 09:49:30 +0100
Message-ID: <CACRpkda-hDbC4bVihPO8RUogkFkPfsxVS13d_JJoFZLaPLQYcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: mfd: Document the Xylon LogiCVC
 multi-function device
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 3:13 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> The LogiCVC is a display engine which also exposes GPIO functionality.
> For this reason, it is described as a multi-function device that is expected
> to provide register access to its children nodes for gpio and display.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied to the GPIO tree unless Lee has objections.

Yours,
Linus Walleij
