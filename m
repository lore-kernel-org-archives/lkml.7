Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EBCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0BF2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuiWoi1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfC1Q64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:58:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33127 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfC1Q6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:58:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so18339821ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/+W0P06r1ff8sv+FbAjmdA7UJFrLZb33lSPw5SxP4g=;
        b=UuiWoi1s/L5/cyb01/8JLu1dY0rcWmeHpaQy1bC3k3mN6X9Oe/TbQt2tHv/P92T+uO
         3AtV2Kfi/WBqLWbDiOL5SM50AN18SK0BDkkC2qzeJN7w1YTfRImlcwuIjJH7cIuGhgH/
         DLT3dYL23vriwWvZ1u5EzgtTKuqLdCxaZCALD2bN+JOKimMcxwN4k68mWMjq1lt8zhHJ
         Mw85YgfPcqBwMxu6OwzgTboUCBf3WWKSNcSbcDHQbi8mtBvV/Ku7XnvTvjIrdFTBhZeK
         HVqamBTsIKcabdR1m75FUl2l2uCOdw1vkPktIMMv8wq45v3ZL6SUrWVCZfCeFZUAI5+q
         dkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/+W0P06r1ff8sv+FbAjmdA7UJFrLZb33lSPw5SxP4g=;
        b=fXIOyYVIwgzV6HXw+Wi2GMqCvab80y/+YyhAq6pe9yz+MYvcoF2lvDfcEoluIpMREK
         UqyYNBC4FeQwJl0vk87xo91Z6x6p/UTZSN/QY8Vks2lKMShY2qUS1wwDC5A2rYvKvkQv
         +dfCjVcX9QwcmMZmH5TQIJIHFdygZg7Aq9OjVYWvzzPK2tCcP6rE8yS1C9gDuVKBVUMh
         bH//1zQXJ+xsCDnfpmoaSTl2HEJMwKRzZ0bBo+JItjRbChgqomRosraWkYYAfj3a8MUx
         Nh3IKfP6hRb8c8j+gUx8Q7NKliSkFEdyOv+Xa2jqZOXdAl3POxBn2KplYagzMG8nauP0
         DQmw==
X-Gm-Message-State: APjAAAWREQXGUXD1jcgaKaIkqqHqU1D2nOGEnr7iBcu5JUW6n6RR51/l
        b+86kDqdEYuKDUGmST2siLjwtw1hq9k5yC8VN06ZpQ==
X-Google-Smtp-Source: APXvYqwochsyI0jPR66nBSmI719NyXz6BBBfbRKq+KQxR8FLRkq+9BfX5EvNXKkROA+69A/pzCSTI3QbnRdgXUlnCaM=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr9423324ljc.126.1553792333782;
 Thu, 28 Mar 2019 09:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190328131349.18838-1-geert+renesas@glider.be> <20190328131349.18838-2-geert+renesas@glider.be>
In-Reply-To: <20190328131349.18838-2-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:58:28 +0100
Message-ID: <CACRpkdbjwp6MRT17GKHubv_Tvo+A=vSNdatsyx7Anbugi+7mQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: of: Fix of_gpiochip_add() error path
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 2:13 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If the call to of_gpiochip_scan_gpios() in of_gpiochip_add() fails, no
> error handling is performed.  This lead to the need of callers to call
> of_gpiochip_remove() on failure, which causes "BAD of_node_put() on ..."
> if the failure happened before the call to of_node_get().
>
> Fix this by adding proper error handling.
>
> Note that calling gpiochip_remove_pin_ranges() multiple times causes no
> harm: subsequent calls are a no-op.
>
> Fixes: dfbd379ba9b7431e ("gpio: of: Return error if gpio hog configuration failed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
