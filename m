Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8134C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBE52089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYjOHKu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFUOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:51:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37084 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfFUOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:51:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so4850373oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPOaRO8S8j6POsMNSOTvAi8picol4QkFsiK82NYjeMA=;
        b=RYjOHKu4v4FBjwrmpg/XxNrJWp9TG6JbyeCz1eQLWDQoOGdY/5iG65aqUI3F3KnXts
         2celWDauYGUjP7iRcdEXGRR6dI9+w4gvjojJfTAj7Ilijq64pMIXsOouT8SPWDshlgUo
         s57tD5x+JoSF8tbpkbb+vX2hBvX3BiF1lMA98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPOaRO8S8j6POsMNSOTvAi8picol4QkFsiK82NYjeMA=;
        b=T3XX7Q3FSx0qa9geWJD/Aun+oHrvw65UfVDlC7e6nuPouOLSXvtVbsNRSr2E8P1z4o
         u+z9BkhnpbTZgJspr5XcAQ4SqXQOT9nOKutG/3Ja4Xr/vCNcmhAMW+OKPHFiV/a/8qC8
         vtN6qBKHfiSVJox4k6k9ZmpmBAvjsyqJLE7Mi1SEkrczxoabt5QWBDxOeRK8G+sE+P5B
         7ZLSd9y7ducwYPo6QTovAg2Ss0JFvjTwFWVPQ8GMkvn9sXUMx8/zXS902b/Sv7CIwDof
         EDEMfYHEWDDow5qY3zRsCfQjRE4I3Ban7ywiRlxadMuWcV5Z3bR6CDElOZAf4V/g4Xd6
         laBg==
X-Gm-Message-State: APjAAAXGU71EFJYqSuiUH2uFFMxM9eyjcbTW5NHtYcoO4w29Xpi41G4S
        igrYcfan3n48XbOER7xxXXexurmtQxc=
X-Google-Smtp-Source: APXvYqyaLFKgT90jHd8R6Izrq/VfOAhnLK891hRVMkSAkPh59R7JOlycns53KXdbg/PIn/DSXJd5xQ==
X-Received: by 2002:aca:de46:: with SMTP id v67mr2859259oig.167.1561128670496;
        Fri, 21 Jun 2019 07:51:10 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id a12sm1175989oiy.23.2019.06.21.07.51.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 07:51:09 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id l15so6533291otn.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:51:09 -0700 (PDT)
X-Received: by 2002:a9d:2c41:: with SMTP id f59mr53563597otb.268.1561128669207;
 Fri, 21 Jun 2019 07:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190621135907.112232-1-yuehaibing@huawei.com>
In-Reply-To: <20190621135907.112232-1-yuehaibing@huawei.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 21 Jun 2019 08:50:57 -0600
X-Gmail-Original-Message-ID: <CAHX4x86qUKPTkRFWvWMgTMh1VY8ogJfr55khsSJTakS0emiyFA@mail.gmail.com>
Message-ID: <CAHX4x86qUKPTkRFWvWMgTMh1VY8ogJfr55khsSJTakS0emiyFA@mail.gmail.com>
Subject: Re: [PATCH -next] platform/chrome: wilco_ec: Use kmemdup in enqueue_events()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Yue, looks good to me.

Nick

On Fri, Jun 21, 2019 at 7:59 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Use kmemdup rather than duplicating its implementation
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/platform/chrome/wilco_ec/event.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> index c975b76e6255..70156e75047e 100644
> --- a/drivers/platform/chrome/wilco_ec/event.c
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -248,10 +248,9 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
>                 offset += event_size;
>
>                 /* Copy event into the queue */
> -               queue_event = kzalloc(event_size, GFP_KERNEL);
> +               queue_event = kmemdup(event, event_size, GFP_KERNEL);
>                 if (!queue_event)
>                         return -ENOMEM;
> -               memcpy(queue_event, event, event_size);
>                 event_queue_push(dev_data->events, queue_event);
>         }
>
>
>
