Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0372CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958E62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7cKfUkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbfJ2OLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:11:08 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42338 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfJ2OLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:11:08 -0400
Received: by mail-vk1-f194.google.com with SMTP id r4so2886077vkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWQITowh2Q0URF8H93GkuN79IW7ti/9RamrrjfoRUVk=;
        b=h7cKfUkNWgcSbLAWYz4BISnFwmYI2VDiKZEN8ZZ7p8Ok5B9kE0GcFk5wg9OhEyRfac
         +uKRRnQaQQOKfcG+eve50vFu7RYt4z3rm0yYeMBRasVXEl8jYRtcOnGImEBJmF9NZ3/h
         knguFIME8HMdDm9vkd7xI1o4lOm80lT2wdyzpIrEQE6GTUBND9fq7u/0gtZ6xlgpW6Jq
         O4aSfkwK96xqCFtznzEnoDyw0A/A5nW5tbOv5coZSd272y0ZBl8Ls+Xykt4DdofuS5lz
         aAZ5B4454m8i+fvRh83Xg52rz9XpNmTe9kqLkotr0NyfKWeU/P83ZBQwJit3di2XrkI0
         aBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWQITowh2Q0URF8H93GkuN79IW7ti/9RamrrjfoRUVk=;
        b=Bsrlvw8q/iz/6AkUsZitlpzmUdtKU4hbp2/MCtNdRoj+OkliyTzsnktmQ0pIyz6aYB
         0PROX2sxLgLIhm0ZW0kvMLW6LTwUPcpQ2AtsdmoS39ovjTaJXacczsz64k1VmBzMSuJV
         z68x6ynFc73hcSjpdZbp5thfsOWOjX20q1R5suMo5h8nu0LphYIBX4IEHy3WB/Jo2hRD
         eWCmK3b5SJFs8Xil+OM0qCkobFkc1JAKlO6QfjdIB8M3WKXXk7HK6dlsAMDGdqGx64Zm
         RRzproYwviUfvLanyLKyAXaq729TUVQH6wg9F/N+l5WVlMe46Lqrn9mA5UTHkxBmHo5e
         geNw==
X-Gm-Message-State: APjAAAUld0fcmIWrMvRObQZJV/lrF5K0L/D6XhT/m3KwNv+cOmCEFhV4
        h6zLu2RnjTeN1PBonkpYwHUwYpIjiaw49pfZ2iMDSg==
X-Google-Smtp-Source: APXvYqyvtEDKet+g1asc4zUlmseGUxMCp1V2qq86jFU4KX0I6BOVylj6yFCCT+WvVq59xqCrit+FjGjmAUi3kzfzjVk=
X-Received: by 2002:a1f:7d84:: with SMTP id y126mr11721367vkc.99.1572358266851;
 Tue, 29 Oct 2019 07:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191021064413.19840-1-manivannan.sadhasivam@linaro.org> <20191021064413.19840-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20191021064413.19840-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Oct 2019 15:10:55 +0100
Message-ID: <CACRpkdYNB9RR2+u-yCPeyiKc56NTcSnkDZpvOz5gxXSSgjKbHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: gpio: Add devicetree binding for RDA
 Micro GPIO controller
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:44 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add YAML devicetree binding for RDA Micro GPIO controller.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
