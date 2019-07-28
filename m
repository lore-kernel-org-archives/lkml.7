Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A409FC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658D02077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBszeDWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfG1N3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 09:29:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37206 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1N3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 09:29:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so57075337eds.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvXJ3/c4rpFRGGh2Wow0lkZGjKN4V1iCfYC7Oigz+iA=;
        b=WBszeDWnp4ZcGvcJBBrX+sXfsbbQGBMwyvnvu5/GlXW+VqkFGoJ8GdKapq1oALPyLs
         G13dv5CGaW0XI9qGkQjgfORNTLQSkyLQBRt4yga/lHpBKVCHdP0ISR+gjVgNVHf7jz/J
         1FOV6JAnaQz1URcB+qsDQwlchxqMm5zXThFNYTPPRz97RXNFYqpxpkgOj4bbxWbgu6w9
         k0Oiu87maWJR/CL23+qO++5TWMr7OI5On+em7+hrcB8JfxQEqx3evrr5ovkdhrHXHk58
         ZvD1rxgN9YY2VsQu7k7jHc4IOUtWyDvAgJS2gHt7VV1y7O5ondyGju0TCnndQoRw4g/k
         UDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvXJ3/c4rpFRGGh2Wow0lkZGjKN4V1iCfYC7Oigz+iA=;
        b=p420u5oLzH69FNeJHcTVGjpemsaXOM3RxWy2Us1IjwR7gTU5ifJ6FX4WzcYEvdjnHB
         UHCupMZ0Pe0nS/4jYYx6VvSj3rj5wWmJqs/NB3osV5e+gUZGe1LV9lcO7G+C4qwS9qrB
         8lQqdDZJnW3fIuYAjohUii9S1Asw5jPENMyJ2OtqkeT8UR+eSs7mzwSs+Vt44g8Y57dI
         7YJjH7pjzBXdOcVyYV0a6HkDTUd9d9dGz0kPE/Jr9PavuU0lHmLBXXthTzhdJwje/ujb
         1mRzujUGxmKD9ZldUPZy+6j+BHoFpQNpLYvAfvdo4gpb5sWDaJHbxqfmUIB44SjsxvMu
         x8gA==
X-Gm-Message-State: APjAAAUkHBQtFjnIBCGdAcMEmRk7EPwI8dscETknoLaNK8br4WYI+4/y
        lz8fhw0EdurHXk5UXG1s3OtUtWX4Fjgs8KZmpPM=
X-Google-Smtp-Source: APXvYqzUHdn0K/6jv1Ayf0caTyzE54mDGtV0LNSQdgaxs59ZSKla4UqaBrYnMXVctxpaI0W6SGAuv6R1sbGMKAUdF+Y=
X-Received: by 2002:a50:ad01:: with SMTP id y1mr89286757edc.180.1564320592940;
 Sun, 28 Jul 2019 06:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1907251535421.32766@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907251535421.32766@viisi.sifive.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 28 Jul 2019 21:29:42 +0800
Message-ID: <CAEUhbmUeAFtmFci78phyLdxTFwh4rfztsMZAy5ekfbmyX1VZeA@mail.gmail.com>
Subject: Re: [PATCH] riscv: defconfig: align RV64 defconfig to the output of
 "make savedefconfig"
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 6:36 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
>
> Align the RV64 defconfig to the output of "make savedefconfig" to
> avoid unnecessary deltas for future defconfig patches.  This patch
> should have no runtime functional impact.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  arch/riscv/configs/defconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
