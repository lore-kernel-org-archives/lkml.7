Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C4C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C02D218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIqiaWuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfGDOJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:09:52 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:37131 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfGDOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:09:51 -0400
Received: by mail-ua1-f45.google.com with SMTP id z13so1181026uaa.4;
        Thu, 04 Jul 2019 07:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQ5m8rYbT8Z2US94ZaqcngLhWVtKzNxmo7qmupLUZ7w=;
        b=oIqiaWuC6upmXjZw83Sk7A7AN228dkex7qLAmW3GCy+0EdImPA38Kk1jNfvfdrZi3V
         bhdR7xb6+PRPFieFo6k5xXWKmR1zWZO2TNP+7r3I4FGpkkwc588AR5j7TJ2l9+07uWmG
         mptGkWYKyHhVPxQUywF6hQOLXeX4k+q4AzscwADbbBwmytmPpN1YtLs1e6RLR/uOVoJO
         e7Lqkp7Ol5BKEYqrzorBo+PvwCgZJrMN6FLWd5OgJgmMDIjmSC/Dtrvj0F6QbItWmz8Q
         GEnvd5zoUJsbxd7atboADB4j8JGLKNWGEET4JkCvbgvTP8bv1aeCrtb10TIA3tScAfw/
         lQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQ5m8rYbT8Z2US94ZaqcngLhWVtKzNxmo7qmupLUZ7w=;
        b=gr7gBeXUgzdM2gdkXeUVZsdvK9AAPNfQyrVbefbLO8jJLkZe3htlIHbWoan5Tx4X4I
         adN2RYWIWSED+iqVJ5ytmpN6Jme/3nxh8y8R9h382Y9GWkwjhxHNXNhNb+U36aaS4wKb
         EDUlEPxI1UKH3C8m5mbrXGMidjd1ysExXruqispVpta0m/lllt9Y9Fnm+ZtLwkk/N7xm
         3IaQ457Q6E2OrLpoz7+9nfDSMb6VAOki8XjDWPJK9ZwH8dw4qmTZUE4NWNFwr5VLhcO7
         0Pea+XHToos9XlZsH7gCaQhPsdyRg50Wq6466DIqeep6XxiRtfQuake6S60t0ppNM6NR
         1Zng==
X-Gm-Message-State: APjAAAV2gFnHqVihvaC76HDFWRlnKHn/I/rOlyx8KFJhW9+/UyN4bjt9
        xRU5ECS3w+mU8lQCMEfpQki8Mf2v2yXqqeKRjmf73Q==
X-Google-Smtp-Source: APXvYqw2dNxxbf+8Wi66NiMCCn2WzNJSfu4KOQyo4/Q4ZNqttIe/PSYYLn2ptK9W58HniHDZdcr9VegpbZ4mY00GnBg=
X-Received: by 2002:ab0:2556:: with SMTP id l22mr16501064uan.46.1562249390682;
 Thu, 04 Jul 2019 07:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190704023436.4456-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190704023436.4456-1-huangfq.daxian@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Jul 2019 15:09:59 +0100
Message-ID: <CACvgo50s0oh3tRjpUxeTkpFGJXahwB72hW=cc-de=2MG587m3Q@mail.gmail.com>
Subject: Re: [Patch v2 01/10] drm/exynos: using dev_get_drvdata directly
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     "moderated list:ARM/S5P EXYNOS AR..." 
        <linux-samsung-soc@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 08:26, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Several drivers cast a struct device pointer to a struct
> platform_device pointer only to then call platform_get_drvdata().
> To improve readability, these constructs can be simplified
> by using dev_get_drvdata() directly.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Thanks for the update. This patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
