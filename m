Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A186DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B1B21773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wo8Bknhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfDETyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:54:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36294 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfDETyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:54:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id u197so2753587ywf.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05IzLo2frvVNvBEKd3bYgRKNJlb5qlRs1v7YI8VZimE=;
        b=Wo8BknhjvWIQKxCoM+UgIol18Wt9g/EloxHYjU9IIVcT+31tz1lhFpV6BaqUidrBZr
         BQIwjQ5mcA+34Uo5s9FUzpXSn1xw3VzpofYcIk8nF0uvRQOsLRjFcV/2VUCh7HuPQZzM
         yf8pVQ8CsL0YFdDYtqwkaZnuTnkyT29/tz+n8+rJu3FaJwv05GfhYv30SwbvNCcF6uup
         rotEuxpwwLgBfNtLK2liwo526FmYDS5emPJLb/A/ld2rS9eIugShurGKo1FaLPKWEz3G
         yk0oAxXGQJu45MecYIPLnNUjDun5KIfqoxMl6eNy5dh+n4DEAI7dtwYHds0lx5CRHdty
         Hd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05IzLo2frvVNvBEKd3bYgRKNJlb5qlRs1v7YI8VZimE=;
        b=iBWrRmFoE4m9pLwQc895+iIa4tcjuRU99D4j2mtP+xNMaGHr69/LelitKHsFPxLZNL
         M0kEBbZ2XSCBA5NXUqrwbK66p4zfnvwZFF5gyBxgvELnMCi9MQMjXvUPtz8qv166WAMW
         l4IEcQ7y+eQWijqfMwaQPjZ127QC2KKljlSVJZzkipBWU677S8bMBgPR71PCFZZvIEFt
         QcHhnkF+kR79+x6tKivIigrv0Fr215VHJIZk0t/Ax9yz9D7w3zcSpUqMKFLHcz9qGtCH
         Tc+ur+7PqMGjITk3X9d2nS5eEbBI5N9UgNTllI534/YUxYF+ix6o2FuWXJMPwzgdGmWb
         hvIQ==
X-Gm-Message-State: APjAAAW/393mpyRQk0xEnO8CpKNZHAr+CfMHQHAPXIw/zeQv4uO6MtjG
        qqC5z12cWg7BdRuUoCS/tuEAaZ0ru12BSWW2unSH+w==
X-Google-Smtp-Source: APXvYqxX687cUvkt0PMmF7iM5soMSkTJ0jNHXImj1UvjZcm87bztE93/x4SO7rwC/1Nvy37M98DoJaz/F8T7kDeMloM=
X-Received: by 2002:a81:7052:: with SMTP id l79mr12278024ywc.299.1554494092085;
 Fri, 05 Apr 2019 12:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190403135403.9472-1-enric.balletbo@collabora.com>
In-Reply-To: <20190403135403.9472-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 5 Apr 2019 12:54:41 -0700
Message-ID: <CABXOdTcaHCPJ18kEJopV6BsoeVvfX66s1v_kpdatgzaqBus7Gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: Add CrOS USB PD logging driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>, jflat@chromium.org,
        kernel@collabora.com, Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Apr 3, 2019 at 6:54 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> From: Guenter Roeck <groeck@chromium.org>
>
> The CrOS USB PD logging feature is logically separate functionality of
> the charge manager, hence has its own driver. The driver logs the event
> data for the USB PD charger available in some ChromeOS Embedded
> Controllers.
>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> [remove APPEND_STRING macro and minor cleanups]
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
[ ... ]

> +
> +static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
> +                                      ktime_t tstamp)
> +{
[ ... ]
> +
> +       pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03lld P%d %s\n",
> +               rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
> +               rt.tm_hour, rt.tm_min, rt.tm_sec,
> +               ktime_to_ms(tstamp) % MSEC_PER_SEC,

0day rightfully complains that this introduces a 64-bit divide
operation. I don't know if do_div() works here since it tries to
modify the first parameter. Maybe we need an interim variable to store
ktime_to_ms(tstamp). Something like

    s64 temp = ktime_to_ms(tstamp);
    ...
                    do_div(temp, MSEC_PER_SEC),

Guenter
