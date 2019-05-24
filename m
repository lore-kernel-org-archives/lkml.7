Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42D8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A16521841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqFzBgdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbfEXLtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:49:16 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41108 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390772AbfEXLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:49:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id q16so11907ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOvtRlpgwrennubIJ2Y/ol1Fu3d5Vq/WpGfePTtRPuA=;
        b=kqFzBgdp+KA8oZ07ITq8Vy9oGfQPEKsOwl/CwI541Nc8qn68LWFMJoH4xxcPFYHbOf
         BBSOhvUgvgJH705+GF2itw1f+g81VrnNQyEjiPsudL6kbamAcHWjvip6WBJLR4yk7A5m
         UrNlKRknWbO5tAhNGmhZLpsI/GaNM+T2bbKk/VqHAZFUrEtKa8Ru+eIbTnUE5DOGCatL
         aI4bNiNMKwwkUprr5vmFCjo655fsZOLkLll6AjPi/CkJX3woHsMdyyN6kC8kQ+ji6+vJ
         udk6IW9q4oJGvWOCjvOgZcBpgGXIE/ZR0Eg5TbaVqpfmW2NJaM8rIlCcHgg8H6TbEhhX
         P19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOvtRlpgwrennubIJ2Y/ol1Fu3d5Vq/WpGfePTtRPuA=;
        b=Z9E+KTmCoHlCO8fIa6f6IxcTvk0Q1nWQRMKeJZsHmmn7Jkt+Qqno6z1gyJ+Uhe4nbT
         a+nhQuOujyMxVZfghgqHD50kD6IMr8XE5H9ibSpx5rYgWt/wAhgBFaGnUHmmW++mXmqg
         hM5pXCpG111ZNWWk9en3zyE9AsPE54pJu4QOycKzAu3ZZk+srHXj0m2uc7Xpy59EJrWM
         VEYTkpbbHK7VJhKgevXUGcdkU4zWvsZUASwOaCrjcbeSmcKgKohpSVwPAovme33jqT5W
         yaKwfbv5ninfNZHzxpLfzfIUB9hWs13ZXohu4SA5Wt+LToQS4XLctfoEERBMLkEnhhlJ
         dikw==
X-Gm-Message-State: APjAAAWg1lleAgaBqVVoBtUsGxSYTaDlZ0JtTicq8Wu8UMbB8nVpfleH
        X8PtiXpNvL/wNNESU1NmNweVf8CAi0+8s5jm4FNLRw==
X-Google-Smtp-Source: APXvYqx12Jd/oGdeYccOTNL544l6qLoeJ1js/R4g159jdpy6s0xveqSPxI2AZMsqesCBeYpmFKamqshKWqG/AN7gB/A=
X-Received: by 2002:a2e:89cc:: with SMTP id c12mr44977574ljk.90.1558698553619;
 Fri, 24 May 2019 04:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190516151339.25846-1-jbrunet@baylibre.com> <20190516151339.25846-2-jbrunet@baylibre.com>
In-Reply-To: <20190516151339.25846-2-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:49:02 +0200
Message-ID: <CACRpkdaKDXCbR9di6upx_iezGfajGbqw7Y3p+LZnwYWdJ5dJRA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: meson: add output support in pinconf
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 5:13 PM Jerome Brunet <jbrunet@baylibre.com> wrote:

> add support for the pinconf DT property output-enable, output-disable,
> output-low and output-high in the meson pinctrl driver.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Only standard properties so patch applied as obviously correct.

Yours,
Linus Walleij
