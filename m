Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8228C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C48820657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcoArsBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfFXSFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:05:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46658 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfFXSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:05:33 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so167262iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pg0U6unXfUxIT46wtst7onDuWrGrEtcBrNhAIvmz9K8=;
        b=TcoArsBAEXyEelQ9h6o1qMMz4D2AfWUgDduRJkZA/2pqgzvwg/gNkwAc9y4kpYMfxp
         WQ9ok0iDaU5tf2XSvUjpR/1CDaWF/yHHgK8oPQh/WcezgLXF1+C9Kru7aIGm5VjMSQxd
         pfChf1/c01HkBJdtJPdTFvR0ZfXyWuAzumbxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg0U6unXfUxIT46wtst7onDuWrGrEtcBrNhAIvmz9K8=;
        b=GAHHrK6dAVAPQ1z0akgCYskX4gkQJw52MGy6kw9T+Bu45MyRrbIWvNldsc6xrT6BjZ
         /20RFNUZQzfIORNcoV0SVeSK9P7NoQRjd8jVVcRxcGyhQBxPz/pu+eXt9NJRKrDLp0q+
         unZKco0wyp9aHU+AvESxS8//uGKa0Mgd2ykIYji0fOMHzTSMsDy3qFYfDNZRm+bAFPa2
         79uNNWdRZFOZ6AOF4EpLRWkZBvVjSp2LJqSzyGfAxH978vwt3rN6yX1RBS7wdFEBAO1c
         EAdKXgjX098ZWECyqujzZoRZV/sYg7Ny6upZCeDeEXqZuHWxKNwAL4/kjUzWndivdMTe
         fHpg==
X-Gm-Message-State: APjAAAV7TnVdVPvhCp7m7jX318Caqm6EYdItZuCidYI8XaVSQ70/RIl9
        5I0V+3O9IRBdVMmFU140NEfUCCM1dQQ=
X-Google-Smtp-Source: APXvYqxV4ZNJB26RU3kFYXMG+fafoVa0buYdpcu27xYAr257fMsvOUzkma5jPoBnsemY6b3z9VXe3w==
X-Received: by 2002:a5d:94d7:: with SMTP id y23mr2243409ior.296.1561399532475;
        Mon, 24 Jun 2019 11:05:32 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id e22sm14956677iob.66.2019.06.24.11.05.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 11:05:31 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id j6so2977125ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:05:31 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr1703630iol.269.1561399531202;
 Mon, 24 Jun 2019 11:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190621024106.158589-1-gwendal@chromium.org> <20190621024106.158589-2-gwendal@chromium.org>
In-Reply-To: <20190621024106.158589-2-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jun 2019 11:05:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoW7Yc8jET4AAu2jD2K1wm6W25KSKn8UbhZKxFLQsiHg@mail.gmail.com>
Message-ID: <CAD=FV=VoW7Yc8jET4AAu2jD2K1wm6W25KSKn8UbhZKxFLQsiHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 7:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> To allow cros_ec iio core library to be used with legacy device, add a
> vector to rotate sensor data if necessary: legacy devices are not
> reporting data in HTML5/Android sensor referential.
>
> On veyron minnie, check chrome detect tablet mode and rotate
> screen in tablet mode.

The above sentence is still a little strange.  You just took the
"TEST=" out but still left the testing instructions?  They sound odd
like this.  You could just drop it, or perhaps instead change to:

This change is part of a set of changes needed to let Chrome detect
tablet mode and screen rotation on rk3288-veyron-minnie.


> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>  2 files changed, 5 insertions(+)

I'm decidedly a non-expert here, but since I had nitpicks on patch #1
and my nitpicks have been addressed, feel free to add:

Douglas Anderson <dianders@chromium.org>
