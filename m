Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A54AC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE120856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 21:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4niO4pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfGEVxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 17:53:39 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36720 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 17:53:39 -0400
Received: by mail-lj1-f182.google.com with SMTP id i21so10507119ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVhp9sD9l1Fh7vJIHE7psd1pUKNZ7W5F8oACMY7W1Ao=;
        b=c4niO4pwvEQah4Pqnn/zl8+RVdfUUI7KIaDriNJQXwu/NGLs+eKeEfhNIT5aKEFnpU
         8dKRem6sGATIv5K6eC5hslEcP89oNCvTA9tQjCFQP3c+ZsOeZBRr4xoGHdnap7qYt40+
         RSEFWpx1kIpDnp44Xq1yGGB1hPu8ZFWLi6D/PzEbrpcRUWgc+bVuMUXe2SJIaFSmmG80
         AIQWTczh30g4eDExPEn5Fy+v40KPPncvAG1TIGbeGm4Y7Muij2PeOgZwMWUiiVf1h9ON
         EwtL/Zhhg8C1NL02TPLu3uy5e9L21J3977O1+lFWXijJLztCXwe8qeO+ckjktx3NWXZ4
         x2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVhp9sD9l1Fh7vJIHE7psd1pUKNZ7W5F8oACMY7W1Ao=;
        b=IgtAZbwlo2iQEqCHCH9kN/eRaqietBAk4R4ksDyOGefL1AawJyIp5ruuNGsePQ8ZL6
         kiWX65DnB5MvUhj58Vs6Eq/wFDUPpdG31+ti8nGc2GQiEWx5is8OmRBQiJaqesJhUdoq
         AeBJcVUpkwrpGg6FlZk0ZtQZXdby5EhMz4FyTfsqIWx8t41qNswh+0XIOwC6486crfwF
         04z4zDXQAkauAraR/TZbSPquNHy0vezsCBc4RSPfn4BHfEHiHDqPu4/UEjDWtJVJzpv3
         7EV+lN1TjwcAiDYrir50K6s674+iuonX5ymy5nWU5TZPROCnGm1cs6kalMhdL6L+wkcx
         H4FA==
X-Gm-Message-State: APjAAAWzrCjYtjG5eQRvgqoVc8ndq5X6LSrnPmDPZCuDtICcXb7Hs7IF
        0HQyiVZplieUN2yfBL76NtYuKlBmor/c3ZPw/PrmOA==
X-Google-Smtp-Source: APXvYqwaGrH2h+Z98/ELblKzu4yMSF6RGFMj6RI688gHIeWsG2kw7fK8UUVt72WdXfpVrC4bXciBwl2IVtwAYJ/zDKs=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr3282903ljb.28.1562363617011;
 Fri, 05 Jul 2019 14:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <d4724d7ec8ab4f95884ea947d9467e26@svr-chch-ex1.atlnz.lc>
 <CACRpkdZD7x1eeatXRTtU5k7Zoj5tfG8V98SjaO=xubwaa9teTQ@mail.gmail.com>
 <f9eb3387ed384676b0b298e4da7eeaf0@svr-chch-ex1.atlnz.lc> <755abbb5b984414a966367c323f62e59@svr-chch-ex1.atlnz.lc>
In-Reply-To: <755abbb5b984414a966367c323f62e59@svr-chch-ex1.atlnz.lc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 Jul 2019 23:53:25 +0200
Message-ID: <CACRpkdYzXEKVzmq_wimvbeMmOqnW8okyK09V-RpzdoesmC4P7Q@mail.gmail.com>
Subject: Re: gpio desc flags being lost
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 11:30 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:

> The problem is caused by commit 3edfb7bd76bd1cba ("gpiolib: Show correct
> direction from the beginning"). I'll see if I can whip up a patch to fix it.

Oh. I think:

               if (chip->get_direction && gpiochip_line_is_valid(chip, i))
                        desc->flags = !chip->get_direction(chip, i) ?
                                        (1 << FLAG_IS_OUT) : 0;
                else
                        desc->flags = !chip->direction_input ?
                                        (1 << FLAG_IS_OUT) : 0;


Needs to have desc->flags |=  ... &= ~

if (!chip->get_direction(chip, i))
    desc->flags |= (1 << FLAG_IS_OUT);
else
    desc->flags &= ~(1 << FLAG_IS_OUT);

And the same for direction_input()

Yours,
Linus Walleij
