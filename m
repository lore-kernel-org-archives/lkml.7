Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE516C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51F621928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ySUqRbbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbfKEPYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:24:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42020 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389546AbfKEPYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:24:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id n5so11295555ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfNcf4S6DpXFZYs4x9NDwQ36QzUQXx6HDc+b9FaYu1c=;
        b=ySUqRbbwqp5Yv1jmBGz6tsBBUEedPIvlw99Fk6vU0QkyQrkAZNmDoPeADtuckZagJd
         G95809sEAn6+ITZK5qlcNJqcN3q5ZI5qwqHRxUgjoHLvk+4Qyw7b3wwm+GlIDAxceNyQ
         hBHUNz195VuKzeF9l1YNf5yS9uHplt1vVH/O0srgiJp70gFVEyz11+mDnKSBpPYiBSch
         4S3AeKMFkUQtY2GVwetLGftWSD52rLOsdTfmyB9Eyu5BclFARq7zkSFKaalF1adVG20F
         Wixi+hGRSWvQyL0auGt6JRTZSquv+iQZgqRHRHgmX5FqXuRuaCMqb0PH8fQ0CsHeTEZA
         V1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfNcf4S6DpXFZYs4x9NDwQ36QzUQXx6HDc+b9FaYu1c=;
        b=afTTNQhjP2bKLoBg+Ucw27f5dubIOohhVu02JaMnOi2RyyvuMfIFazwd4xpysnar5O
         NtVVJbDG8tHl0ftCrKf9oqZ9+JBRna+IjLgI7+4IkvyCwj1YUW1wZGAoeoagTlVqCx/v
         HPQ8y0obdYHWHmpEsME+khrzXuLJxXovV6JTVznAiO4PjjD0zYRqL81IcdCWhaH0Z5wW
         F5SCOu15SrOPfXcxSfxHE47pDet6YkBFhQ7q3sy3bG1IQShsgpaPSgKIqjlPgaxAn0+z
         mUcSnDkcxcxS8E2P1AVlimBDbGz/yqN5+hbHn6x6NsJxwuuBantpsTucpdJUcbfRs8Lk
         4ZnQ==
X-Gm-Message-State: APjAAAX34GmDQSnOHAu0ImphTLOyZh0/BCL8LlKuhBwsqyUZkJj/zQYt
        T5zwkdgOZkAgy6W2i/yBrD3zs5HZGIdCD9iMs1myQw==
X-Google-Smtp-Source: APXvYqwsA6UpjgTbiUM/08Cv5/UXnvvBZ+9Vzl45plS0dW+kWsNO4C0lW9LFg2GcNPjN3YCAHhIliUHlKPNTHbw6A0M=
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr23609324lja.218.1572967448955;
 Tue, 05 Nov 2019 07:24:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572945605.git.matti.vaittinen@fi.rohmeurope.com> <d25edcc3a5d912be9d7c3a927bad6baf34a1331e.1572945605.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <d25edcc3a5d912be9d7c3a927bad6baf34a1331e.1572945605.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 16:23:57 +0100
Message-ID: <CACRpkdav+Sz04WE6N5KkKMQLOtx2BZrjWrEin06yPZQ31a47hg@mail.gmail.com>
Subject: Re: [PATCH 02/62] gpio: gpio-104-dio-48e: Use new GPIO_LINE_DIRECTION
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 11:10 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> It's hard for occasional GPIO code reader/writer to know if values 0/1
> equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
> GPIO_LINE_DIRECTION_OUT to help them out.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Please merge all of these patches 2-n into one to avoid patch bombs
and just make one technical step.

Oh the patch bomb already dropped, hehe. Anyways I want one
big patch to apply. Please make sure it applies on the GPIO tree's
"devel" branch.

Collect any ACKs and drop most from the CC else the driver
maintainers may get annoyed.

Yours,
Linus Walleij
