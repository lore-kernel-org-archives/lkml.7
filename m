Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96508C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE732133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3SENBXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGDHja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:39:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39427 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfGDHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:39:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so5138683ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVYvH6yPxNlvAG5cJftwWiP3xNZgU2eViTDVr4W3YCw=;
        b=R3SENBXntvfHZIhABiAhLiXIF/IgyJU3n1f0FHPe5YRFFsc4xu3L0WX9avUUev/i0B
         ovJirlT4blG1yRpNu0i8qVqMGsOKoLPvnytcsmlvBWYAYoOBBgi9bYFJxoRpkWr8KCfm
         tE9IMbqEy0mEShd0+tOIqBa9TDbUWlxWdam1aRBh+ne0QL4mgfQXVZdEpRvZe8CIpBOk
         CSBhyl9lIhLqEyqZJ2k6QJQoGYbn9GpOmf/EUw2RchnhfenuVwLaYB8JqmDg+sNEZqUu
         qWbAkUHQXEujNK5odoqO0mDmiuMoMgkQB/1SldPHrLTv90pQCQiltB55IOzpeM5TuU/+
         bx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVYvH6yPxNlvAG5cJftwWiP3xNZgU2eViTDVr4W3YCw=;
        b=Yn2GqgsvN8M6WKOeijL+cMRM6fQW++Rj0dzWg6NneeZiyjn5h+OLiON4sminhgdXa4
         JSBGQcbOyERmeSxCXQy23vgQdnmaAl16h2CJ6TJLbA+n+BQfwcJJuO1SUCf4gDnPm0FV
         d/Q+r7WNAs415xXKbgBbhnJeNdj3Xi4T/ebkaHAPc9t3pid/n257UcCCyszo0MISOp8s
         sprPlDE6W0JyO+HoiOO9N/+DCWMsH0gEY/qruEelWmfOA+vj3VGz3RCZ4ZpIAAtLCBhN
         BsNBX25wu+WOnwbuL4l1PIPvO6Z49wrdiqbHdEYt8OoQnVCSR/l/fowhsakqOi2IGeqa
         Pulg==
X-Gm-Message-State: APjAAAWKAR8DnGQiJmhqUUx619IJz8yGnh/4z8OKeMZEBGip4AkNEH1i
        5YQPJDVTJ7gC8ulz3kprH613g9ZY7ULdXHQjBUi8Qg==
X-Google-Smtp-Source: APXvYqwVwvcJEtr7A/kJye84Su6CfIIOAGLONLWgC7XTlGMnxZhELFzYhqS/HwFA+jzsM2qiOl/B/R7D9khsFU8knys=
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr24144037ljm.69.1562225967852;
 Thu, 04 Jul 2019 00:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190702223248.31934-1-martin.blumenstingl@googlemail.com> <20190702223248.31934-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190702223248.31934-2-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:39:15 +0200
Message-ID: <CACRpkdZqGqwRY1X_frEd0z6QeyO2KQf9vZ9UPRkLSowYLF4e-A@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: stp-xway: simplify error handling in xway_stp_probe()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        dev@kresin.me,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 12:33 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> Return early if devm_gpiochip_add_data() returns an error instead of
> having two consecutive "if (!ret) ..." statements.
>
> Also make xway_stp_hw_init() return void because it unconditionally
> returns 0. While here also update the kerneldoc comment for
> xway_stp_hw_init().
>
> These changes makes the error handling within the driver consistent.
> No functional changes intended.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Patch applied.

Yours,
Linus Walleij
