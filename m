Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81830206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDZO3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:29:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44112 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfDZO3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:29:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id t184so571178oie.11;
        Fri, 26 Apr 2019 07:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7A3wX9Vh2AgcHoWr8dHqm+DNgNpMHbfOJfSTbrG+yU=;
        b=qF6QTiRydy5nRBzy4hyI7hR9GtG3e+UVUePQFapDVTtWGCzsDX1JJpyraVoV6+MO4P
         xj/DO4MnFXDoo2Xc+KJdv8yvNyo+T+H3bn0LzcK8TbJ00eaayS9iWHMSQd1ozZSbWHHC
         +ZGNVUz3XOOJJeLdAJr0NKp6kqA3m77XRJjfnAbt0jX97jmWRbggbLq4ORF16DvwDr+4
         y7t0IkzGYerfDfw5R4AU4aGzGXc+8KTDCITBweZcbcr+tSJkiVMjdkJmkuDc9HdCR95M
         yH3RKjAHCzkwtn5Cg7Edbceesz4NVLF1Kudi8csLYtE+p9vfov5NY41yl7p8rHV1p3E0
         0i4w==
X-Gm-Message-State: APjAAAXiMmbg5KR4j1LLze14M5d3qOvql9xCVyt3bc1s2ZpfXAKO0hlx
        JXVFtHN95RycSV+25nXIbddEMVXsJ4XDHZ9tG/M=
X-Google-Smtp-Source: APXvYqworjkfZ9A1S7q8YaFhAjk/bTSgZkbLeKusc9k80jXzTs63gSBf9t7mnr/1pn27oFekfPL6dlidf7t3GzWsRp8=
X-Received: by 2002:aca:ed82:: with SMTP id l124mr3940402oih.141.1556288987853;
 Fri, 26 Apr 2019 07:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190418100045.29288-1-alexandre.belloni@bootlin.com> <20190418100045.29288-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190418100045.29288-2-alexandre.belloni@bootlin.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 26 Apr 2019 16:29:36 +0200
Message-ID: <CA+7wUswt4mEyrrVugOMgjC=jTnQwf1cTeVwd9BtZtApjmo8gGQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] rtc: jz4740: switch to rtc_time64_to_tm/rtc_tm_to_time64
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 12:00 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Call the 64bit versions of rtc_tm time conversion now that the range is
> enforced by the core.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-jz4740.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index 079469627bd7..15b6832f3931 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -171,7 +171,7 @@ static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
>         if (timeout == 0)
>                 return -EIO;
>
> -       rtc_time_to_tm(secs, time);
> +       rtc_time64_to_tm(secs, time);
>
>         return 0;
>  }
> @@ -196,7 +196,7 @@ static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>         alrm->enabled = !!(ctrl & JZ_RTC_CTRL_AE);
>         alrm->pending = !!(ctrl & JZ_RTC_CTRL_AF);
>
> -       rtc_time_to_tm(secs, &alrm->time);
> +       rtc_time64_to_tm(secs, &alrm->time);
>
>         return rtc_valid_tm(&alrm->time);
>  }
> @@ -205,9 +205,7 @@ static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>         int ret;
>         struct jz4740_rtc *rtc = dev_get_drvdata(dev);
> -       unsigned long secs;
> -
> -       rtc_tm_to_time(&alrm->time, &secs);
> +       unsigned long secs = rtc_tm_to_time64(&alrm->time);

nitpick: all other declarations are done with uint32_t, so to make it
clear (maybe) with something like:

uint32_t secs = lower_32_bits(rtc_tm_to_time64(&alrm->time));

Technically I would have stored the full time64_t here and put a
WARN_ON(secs > U32_MAX) but I am not sure what other driver are
supposed to do in this case.

>
>         ret = jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC_ALARM, secs);
>         if (!ret)
> --
> 2.20.1
>
