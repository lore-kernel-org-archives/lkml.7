Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD6CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F379206F2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfwhHm7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfKMWIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:08:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45120 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMWIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:08:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so4319333ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 14:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHfag9uJv/TYaItpMIVcEE99FJGP5gU8YagFEMRguHo=;
        b=tfwhHm7ryihIXBq1nz07y3pFRgkaMqvzUrJ96OCp1fBOyrIkZr/7ZLYmjDeZG03aWM
         Tsjq4iZsO46hQTdbqQWkXVHuG2E7tGWAX7fdM328O6R5xCGnVK2AwppTNJrWvM7/eLQT
         8ROPhq0ddGuCRRmPvVdCKeb05OPmDn8eptdv7RAw0gUtnpRq7v7yMxX/7vKwxY2/l/JW
         4dPbLoINt21ANbgAz0dZSRnAmshfL/YL69LOmk4oRA6Q1yk9+xXthgsKEWeJSCdIDtlh
         Yu5sLoFf0gQ9Nva+kjUeXf882qRwIAQsFUOtKSscbg44nizAQqJv13LPa0vzYy04HzYC
         Pr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHfag9uJv/TYaItpMIVcEE99FJGP5gU8YagFEMRguHo=;
        b=LnKwaUuh+q7lo4JXmHrY8cJWrZweCLiMxmblJ83ejxDeYFJII+7Ic/JBhhXOyVVmGE
         DRIdYKq8vOZA/p/m4ASQLjMS2L4kXTEgnY9tMuksdU0unKdWTv2JlCfw/v8tDpqsS8sL
         VmIBZeF4hPYfHxQwL1wAQYgUP/My/i94DTTJ6QKuTKICVhvRXjnXE7tZRWcUlHngMPFl
         XtnusHGgutn/CyjVrEt+RWvKLAYu6BFzz/uIRXV/G2nlSsqg2jlQmeYCHAktihelzGJR
         dI/lPjA+keOqhpF0QPAUffnltpT+nuYYuldGJKwSlWCfHCordnTeE+GTscfMN5e8zl1E
         iTOQ==
X-Gm-Message-State: APjAAAUyVd11bX2lp9kv83jQvqPSet6BBzpGhZcwURV2/nOhp1/pJFEq
        LENOmRX9UxlR5WNmEKFj0pnVsh529/xOXdyOGPZWGKUGt/g=
X-Google-Smtp-Source: APXvYqxR4BBWrQ23UMju73EpOAQ/mHqvkz3ckbI5YrShb3DERU3bkSGvpyvgweNKSGHg6ygLr/3x07L1QnrBulWdPJM=
X-Received: by 2002:a2e:9784:: with SMTP id y4mr4213595lji.77.1573682895024;
 Wed, 13 Nov 2019 14:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20191113131629.3861-1-brgl@bgdev.pl>
In-Reply-To: <20191113131629.3861-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 23:08:03 +0100
Message-ID: <CACRpkdad3viHWn+mwxuLT5SBggRvQB61hE3V2rjHgx6pgF6Q7Q@mail.gmail.com>
Subject: Re: [TRIVIAL PATCH] gpiolib: fix coding style in gpiod_hog()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jiri Kosina <trivial@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 2:16 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> There should be spaces between logical operators and their operands.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied.

Yours,
Linus Walleij
