Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60BCC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987902073F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="objLnNse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfK0H6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:58:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38285 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfK0H6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:58:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so12784892ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbcrs/kI0pTK9FOJP+Wv13rPCiF+hN+1C4Agw6T2rIU=;
        b=objLnNseuznC0txiinrwy8QyrEZ7UyuUmwPV5oF+NR+gEsYfrAO9zBx4pXg3v02RzZ
         66UzhBrJ4DhcGoHcDweZQR+pXwfUft7Y/5oXtR9jKLVACnNWPl6wRNPKcTRb+M4oSADb
         hiCUuDJ3UTk5a5VtPSAYiV74J/W2qqcsFC+uClQvY7supDZ0zRvwRHWbHu2xjiOZN03K
         e+XcZNPaJHI7ykrJwuWsLLicrxelKYjFioS+0cIW1Zsffhp+EpDOUud2r9nL4a9tQ5x2
         Z26EfqUe/52WwFLQgEjxn71xn4bT3SIyxINqbkDXay/Gm0xxjAiaQ0499fIsMAQ5XffC
         HBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbcrs/kI0pTK9FOJP+Wv13rPCiF+hN+1C4Agw6T2rIU=;
        b=g9fV/s2MGy5L8xUYB2X6pDA00HufncmP/JW3yRK+hQ4tKlZTbk5WYFeNz8cxw4IvF8
         uehOyxWofnuR4P9AHX1aMqwUU2TJMBq5SLR8+K5PDliVqdwkbALdKAQN3fx7fpMeFbUg
         RIxYh3a1JG41FFAafGRM+BFIoEVcim92M8jyLIKdpUvJC4aX1dgHnfnfSVz+llECurQb
         gOiry4T8cTET/Ii8G3rbctMyXL8t3kp1sEUuOSwaso0X8eEzPbdfkhXM0lG5jhBKWYqz
         VkCddhi0gSHDsAVzfj79LENFgYKuoeBcl0bXJ25AxQQdQO7yZbUTey4cAD0b9KF+NDOc
         79oQ==
X-Gm-Message-State: APjAAAU4GlUvIKyavNwM/ZMBdGXRJiu9/LPBsLcsjkZGVnqCz72z/0Vm
        kDQA+ytB28y98pV+ztMDy6g8P59PPMR7Fd+ZiR7PGg==
X-Google-Smtp-Source: APXvYqwXokp6S08/9H2q2tiKF4c70CagV2hXIPK2TWYczw+i5IFfpgrIPZDP3kFvcpNvJhRVZ4WRkmYWwtH3POwkE5w=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr17213389ljm.218.1574841510592;
 Tue, 26 Nov 2019 23:58:30 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191121072643epcas2p452071a503725c7764acf5084d24425b1@epcas2p4.samsung.com>
 <001001d5a03d$05de1f70$119a5e50$@samsung.com> <CAJKOXPckbRowhCmnJfT8-DT3gYaTpDOf0wVxmxdf-tZpOyM5ew@mail.gmail.com>
 <028901d5a3f6$e2d72310$a8856930$@samsung.com>
In-Reply-To: <028901d5a3f6$e2d72310$a8856930$@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 08:58:18 +0100
Message-ID: <CACRpkdbX-RQY+0Sa6x3BFeovNb3vSkTTnZjcXDDFEyDQWms6zg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: modularize samsung pinctrl driver
To:     Hyunki Koo <hyunki00.koo@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 2:14 AM Hyunki Koo <hyunki00.koo@samsung.com> wrote:

> I would like to apply GKI on the pinctrl driver
> So I would like to cut off dependency from ARCH_EXYNOS.

If the pins need to be configured for the system to boot that needs
to be in the big kernel image anyway. And then it should be bool.

Example: to mount the root filesystem on external flash pin
configuration needs to happen.

There is a slight paradigm shift sometimes: in distribution
kernels it might be required that necessary modules are
included in an initramfs attached to the kernel. I do not know
if we want to encourage that type of configuration for embedded
ARM.

Yours,
Linus Walleij
