Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3176DC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A60220883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8q/tqOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfFYJ04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:26:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42466 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfFYJ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:26:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so15495085lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4byL4wDiJYUKGPsHIZukI0edtzf1YSHKKJDe0YzOyvY=;
        b=O8q/tqOzSaf5wWt4sZORR/syqCreYpV4kYX98Cg3ijrUnSj0+jd2AOO3VRpqEG+kca
         dYBp9rZ9EnhVyfMuC5uMldims3Tw+GLc8400JOHb7hs8ohUrWiUVjZE29nzdE+Lly8Qr
         qCj00QXx+m/mHsiRBhZcgVRcdzcbnkxnYY5qVNkQ9SKfV6G2ydyR7brU4fsIkItfeRZh
         wjcB1dlth1P4yDJrAp6Dj3xwGWeJiz2eZa/Ecy2QVLLHMKUUZWk19Tz7+A88MAtvWPmU
         GA6xj1IVPfW2kp1jEgEcumXmu9VprQchpHLHyIRGzS2/967y2JVmW91i9L7U8eYJAHax
         7Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4byL4wDiJYUKGPsHIZukI0edtzf1YSHKKJDe0YzOyvY=;
        b=XwcIL+Jtukmn7aodgOOuOb5PU33J4Vn9V65JB6PQNLpS86Xk8KotrEd3mGBOcEmgLO
         jPtt36+5KdNWRoToAp+u4XzQbD0AJEaRjjaBz05jlUmGWjDlQ9aWk2ecTq/Ff7nKj0SW
         hGAaymUPmt7WwcHKu5u/j0pFyY0JAA5yFVx6FVkL1CsBCveymjpMB2e2Un5P88t9wpP0
         dxYyCcI5P47/EPlXGwl14r2LfUzJS0cwPnWJ0YuwE7EuQk1GGPogEgJfyxfU72vK3Bxf
         LFaC9B6mPXdsL2KwJQWTibs5fv0CVCm5jLsSs8W1LuVsgqI/CmpxZCqc+SH3Ia/R8/sD
         ly0g==
X-Gm-Message-State: APjAAAUKyD+Uoq9Z569NKt8bQCbLBFIcz+CizN9dSS9qc0+CQeanB8Tf
        JonePOwtxgHxwDI0hqcc2gQsAhsPGkNDnYjcd0HeJg==
X-Google-Smtp-Source: APXvYqzkx4OUewbxjhEdKUJvKf80Xc7mbiFbc7xrmGGm/hSU4bs7UGDZ7qeK1y7PT91tXdIs7xMyZrfBkdJz5us3gbk=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr61005450ljg.62.1561454814184;
 Tue, 25 Jun 2019 02:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <1561354834-22617-1-git-send-email-info@metux.net> <1561354834-22617-2-git-send-email-info@metux.net>
In-Reply-To: <1561354834-22617-2-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:26:42 +0200
Message-ID: <CACRpkdbZ68O41dx7uCccUF_jvmC3_YVvWEEo9igknMC95QEXhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] siox: add helper macro to simplify driver registration
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        t.scherer@eckelmann.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 7:40 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> From: Enrico Weigelt <info@metux.net>
>
> Add more helper macros for trivial driver init cases, similar to the
> already existing module_platform_driver() or module_i2c_driver().
>
> This helps to reduce driver init boilerplate.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Patch applied with Uwe's ACK.

Yours,
Linus Walleij
