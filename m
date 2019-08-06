Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E297C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E95F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yTIiTkxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfHFOYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:24:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32908 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfHFOYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:24:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so61410716lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KGG719xZSycBl1aYVzQyMnG/L43I/ijsETlyDRRcYc=;
        b=yTIiTkxCvQFirZoL2g4NxWxSfeFOfSnpWZMRidamnND+iAdhGzIbYEkAnOu35NJ/+q
         vcIXYVXPFin5bg8EinvGE7meb+lgl/5Q7mGF7ZMO0ypdz2e0/cN+EPC2fjoC0LX1LZef
         jqXUUuAhKDPm5QHsb1JuM1g9TckmUyRG59RUS6H4ZjsD0/UcPnCj7XyAEMC2svFyA23V
         Xnr+aL0HgAVkW358ylJUu5ZpnZg65x9X5NCRz5IFbGOjzBXinPtcsfTJ8m76RzJfmCHe
         zx2BGACg2jcONC63ODETKPaF/2nXAme+M7DYaJFNCwvNxjCcR2GP+UHFdyorGwPUiYD+
         awHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KGG719xZSycBl1aYVzQyMnG/L43I/ijsETlyDRRcYc=;
        b=U84kp1N2AWfJ8cGd5fYpnQeVduh42IEhRBEbv8+OWAgGeQyd6VLGV9/W+u/1zvpxek
         oo6wjtWTORaP+RRN8MLbKuDLUETBejz2wgvmSgJa9zuYyWhWTVmijVhaBQFMXgYZTFCS
         dTtAhM1Kdc9mqWqvHRMbFNlak08aevARP1+WH5tdRM8CIH0aJaNSdaDVdmdvvMWt0mxs
         oLyQnInfTRw1Sg+sCU6VMzuKi5kT9SDU1oG6S56PdfsEmY6QsiGAP4qhiqnbOl3zw/Xd
         pIWQdYKIkPNTSKT3HjauJ5eYlyBCKrfX09+GQwGw9FeasxrcFIYsRMDyVAcOhm4Clept
         W6rA==
X-Gm-Message-State: APjAAAX2C6RGXY0pUKCs9X5q4gn6L/vMGXTKsTfm+VFAkDaBs0nJnYQt
        3uP+BNHN2/Y1yvioYQ6Rn1o0u/qLhrQ30IvJpe+70Q==
X-Google-Smtp-Source: APXvYqxqUtbC+Q7kC70bhYhYPCnMDetkHk8OUMT/4x4VUQhSCJ8j/U+NOYQNmhER8KejXrU7Y0oN8CVqjEaLDvR+dSc=
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr2628851lfq.92.1565101449387;
 Tue, 06 Aug 2019 07:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190806114151.17652-1-brgl@bgdev.pl>
In-Reply-To: <20190806114151.17652-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Aug 2019 16:23:57 +0200
Message-ID: <CACRpkdZq-AURpgjoXpZ4_w-_8K9KenUh8Bk8JVM0-MsmMy9+dw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: never report open-drain/source lines as 'input'
 to user-space
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 1:41 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> If the driver doesn't support open-drain/source config options, we
> emulate this behavior when setting the direction by calling
> gpiod_direction_input() if the default value is 0 (open-source) or
> 1 (open-drain), thus not actively driving the line in those cases.
>
> This however clears the FLAG_IS_OUT bit for the GPIO line descriptor
> and makes the LINEINFO ioctl() incorrectly report this line's mode as
> 'input' to user-space.
>
> This commit modifies the ioctl() to always set the GPIOLINE_FLAG_IS_OUT
> bit in the lineinfo structure's flags field. Since it's impossible to
> use the input mode and open-drain/source options at the same time, we
> can be sure the reported information will be correct.
>
> Fixes: 521a2ad6f862 ("gpio: add userspace ABI for GPIO line information")
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Patch applied for fixes!
Good catch.

Yours,
Linus Walleij
