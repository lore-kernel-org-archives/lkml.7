Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D207C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9B20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMdlODbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfILJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:24:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32991 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730631AbfILJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:24:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so22924448ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jl+H0+uX1IOSI/fyzT/2iUsy9Q4lcJb9u/sfxFKGTJw=;
        b=hMdlODbj073dx02dv5oIX/qOGyDzwdmK3xTUiIzMW0bc2gUynMZWzxpECRwajafo7X
         7BnZKF1OSFqkNOcodg3mGbskxQ6FPHihOEbrnulie0o4zIaXH7UT0sHwzLABTGH7amSr
         9DJDa8ZZQUJjAPQs/nRD/86j6HmrGxm0SJJQN6gvI1Rhdn1miVW/QQ0bkEXSh3cYI6GP
         W6sqa/xdsGAfAFD4UsTJxK4AXx9jT/On2MquMiBT5GPY1aqiZw91X19r2xuUCiUvRcrr
         BvjDvbvX9ftWqOQvGoP8JCyEQbumy3VjIQK0QrTY0qBfkBU6j/iEyvS1xhywt8wLoSEb
         xDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jl+H0+uX1IOSI/fyzT/2iUsy9Q4lcJb9u/sfxFKGTJw=;
        b=RcPNTYEaCTkI4VvRMYApsK8kzLrf/24mN+iXC26EADnIKJjnt7Em0PvKQHJMJWZT6J
         auxtXZb7g8jbB+JXzBZbirHSdxQyFAnRkMz3EZj/rQ6lCqOiDJzzFvq8qJ2Ek5Vajdrt
         raydrxeSeXZBGILBYlqDpZgxd//dvP1NNC14B5aOH/28Y8dcL0c1uWYbd8nYd7XXZ/x2
         JIBpQDC2dLWi0imq2uqQ6tTmKlGngR5kV3KkAYquubrDYcsnV6vPKrXUExq4tbk5fpqB
         uYGf/QBPN3JUKULEKvuCQhJSZ745+psf7G6mpqVqBKp9+0tpTeyoVk6uwOle/P0riLF/
         LOGw==
X-Gm-Message-State: APjAAAU2MhsiR7DTDzW7CIoS/04Nq628M3PaZRsDLiFGKl+oQ3gjPmT0
        yQ7iZPJOhNA79uhXXni+EYEk1jTeKjk3AZV4EdochQ==
X-Google-Smtp-Source: APXvYqzeaMMjJTFhSN8F612U3D0kPm5YwPyNT+ELra/vDUKA/lIFZz6RClqk+CtlOJt5UfROulsYDvNlZq7t06R7XaE=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr22319922ljj.108.1568280236403;
 Thu, 12 Sep 2019 02:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190910170246.GA56792@dtor-ws>
In-Reply-To: <20190910170246.GA56792@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:23:44 +0100
Message-ID: <CACRpkdZLKriRzROqNyWE97n_gavWgZRXoqMMEyP_F9DFgYtobQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: da9211: fix obtaining "enable" GPIO
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 6:02 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This fixes 11da04af0d3b, as devm_gpiod_get_from_of_node() does
> not do translation "con-id" -> "con-id-gpios" that our bindings expects,
> and therefore it was wrong to change connection ID to be simply "enable"
> when moving to using devm_gpiod_get_from_of_node().
>
> Fixes: 11da04af0d3b ("regulator: da9211: Pass descriptors instead of GPIO numbers")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Mark: please tag both of these for stable.

Yours,
Linus Walleij
