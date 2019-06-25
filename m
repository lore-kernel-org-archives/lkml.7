Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8CDC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA53D208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZpWrOyNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfFYJM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:12:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45249 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfFYJM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:12:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so15432581lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwnVDgu7cxDgh+7o1y+6rFPyKnwN8aXJSKEBzNlYRcQ=;
        b=ZpWrOyNQCqP49tiHyPuuCPEgUimdp9Xdbj6ODVd6x+t8ZnEYlMSuoMtV4DL3glA8k0
         WEAJKctXijVfP69IryTxkOrjVhvTkEm5X1a8bYWgqM7EyR6a/VkHWe0DV4Eb++DYf3Jl
         5L4oujBhgcCnN2X1PGv7+IWpgsXlDiazxZ++BXX4b8zyut6KsyEGkkEiIEyyhZwtZ87D
         SZ2ZvpxUjvH5GnKN56+m2zq4Fj4UlFZtJ+oMfI0brEIvScS53jBeShOCNOIeps2wIMuf
         RJrWv0R0+H1ZCrNREZQ7ZTANHp/q+mbld98tmDQUyVTfFiWOlUOBy/Bhs/t0wfo6e9LF
         4mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwnVDgu7cxDgh+7o1y+6rFPyKnwN8aXJSKEBzNlYRcQ=;
        b=CesFq77wfVycVYRnsshfKoMFWaKA+FdbZamP+gqlWtzeGVlg74X+oYud5JuZWc2mRi
         2j6j3L7+GArabJYMbzTNTqwWxO+B7xZDZQenXF1IS+42zO3gSHfC4OrhcxLPlZbcfFDJ
         XlyhlnXm7UTgt9VF2scWCXbwkjtzUZ1fgB2AHZvx7ylTWf3etcCaRbVg3fnK3FW6jI9Z
         3h30CCAoK2hgFoS5EgdaFEDWUVVPnwwQcGvv2oYnxt9/nVP1Rfnfj7AK5AMAeACKwhzU
         +uKxXKNHe9TncXI94lh5gj7LqFTfCfUpKbVjyKR1dqOQR/v68R1XONzRj2Tl36dM0uOG
         lXMg==
X-Gm-Message-State: APjAAAUYquQeiSz2aRgcla9VqUMoHVh3EPYO41JDhejPNo+snn5RMYsl
        iiuJsgdqGY/ukoA1zGjF9mHBgqaZUjaog2w4+2tzxw==
X-Google-Smtp-Source: APXvYqxbOkGclXqNTDfoJhNi3bCl/YUQljV/FA4qbEQSOtH0TEx8A89uKABkZtrdtTW9HQvDgYnj5AHhdffx8NZz/fA=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr15201086ljs.54.1561453975476;
 Tue, 25 Jun 2019 02:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net> <1560790160-3372-3-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-3-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:12:43 +0200
Message-ID: <CACRpkdZ1KRd2XkDSjc4h-55MN1q9fvk6KPCfxE2dT3vjZaX_3w@mail.gmail.com>
Subject: Re: [PATCH 3/7] drivers: gpio: eic-sprd: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied with Baolin's review tag.

Yours,
Linus Walleij
