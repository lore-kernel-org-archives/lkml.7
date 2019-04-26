Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B85CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B95206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDZObr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:31:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43759 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:31:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id u15so2779020otq.10;
        Fri, 26 Apr 2019 07:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sd7oA/eUZwyT6bDYGO1ecdsCnjVS89IyAYizV+dMWRk=;
        b=dAcAaz/N7sDBIGG8BKsWVXciYTzSwsmd/9Wf5v6qzRp+WirFgEAQB0gzB2whm24NWs
         Qt4ME2Etl4b/6pJKVppWQ08GYX2OsAHMYYLq5jFHG+HtQQe2m2zDokiC/wfLvP5lU3ic
         cBCG46zITBBly/yP1oT45NOitSONyksMGB4gbmV1jb+cMfb0nCCeIvemg6m+kgrjPSae
         dL4/J/gl6ZxwqE57AW79s6jzKP7T+rhrBfgydsX52aEBUuLrBfRnSxV9ZjHsKQCsBHlb
         /RAUwS3bvgvYfED1k0BYGSm4gDE2XNShv5JMbeC6WDYK7/GA/ulxkEOxJFtt53Eu85Nl
         kTPg==
X-Gm-Message-State: APjAAAVWb64bVW9PHOBxGT5fwdska70CBwyF8vMVzKW7uoJXFlTJ8UmK
        8LOBHELOHe9epuQxy3uLmX9BIZS5xGYXglfHpMU=
X-Google-Smtp-Source: APXvYqy8DsXkxkfoVySSPYqIKtcGcsjx2AVNWNCo2LGIutD5B9Wogt5tV+El9CycyMHNnYcU7qYpSkKw9sEyl++rFcc=
X-Received: by 2002:a9d:6355:: with SMTP id y21mr4815374otk.354.1556289106475;
 Fri, 26 Apr 2019 07:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190418100045.29288-1-alexandre.belloni@bootlin.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 26 Apr 2019 16:31:35 +0200
Message-ID: <CA+7wUsxD1ydvS3yA_ZTvTRXZcg8F4SFTwa2yArq7J00KxFZgiw@mail.gmail.com>
Subject: Re: [PATCH 1/7] rtc: jz4740: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:01 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> RTC_SEC is a 32-bit seconds counter.

For the entire series:

Tested-by: Mathieu Malaterre <malat@debian.org>

Arch is MIPS Creator CI20

>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-jz4740.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index d0a891777f44..079469627bd7 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -348,10 +348,18 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
>
>         device_init_wakeup(&pdev->dev, 1);
>
> -       rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> -                                       &jz4740_rtc_ops, THIS_MODULE);
> +       rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
>         if (IS_ERR(rtc->rtc)) {
>                 ret = PTR_ERR(rtc->rtc);
> +               dev_err(&pdev->dev, "Failed to allocate rtc device: %d\n", ret);
> +               return ret;
> +       }
> +
> +       rtc->rtc->ops = &jz4740_rtc_ops;
> +       rtc->rtc->range_max = U32_MAX;
> +
> +       ret = rtc_register_device(rtc->rtc);
> +       if (ret) {
>                 dev_err(&pdev->dev, "Failed to register rtc device: %d\n", ret);
>                 return ret;
>         }
> --
> 2.20.1
>
