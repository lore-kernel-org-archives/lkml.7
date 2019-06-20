Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B030C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E53206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ThEa4Zgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFTVqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:46:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35791 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfFTVqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:46:53 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so1082958ioo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD/sPbt5AG02OSpSDC1IGFx0HbwrZQWPg/7TsPaRSVQ=;
        b=ThEa4ZglSkds8WdcJKNus0VVSVjFEFqJbFHI/ujfqslJqLtrYv0SOA/AEj+QSw8s49
         HWZpvD4AKGmBe7vU5/r6Qyk6D56XFzM7kc1LmltZ14VhpbZpUG/BU8x7UHvO0rbxUCnF
         Pyso3ubEKg1h1u9dgN4wr9EkwX4s/HNPKRR3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD/sPbt5AG02OSpSDC1IGFx0HbwrZQWPg/7TsPaRSVQ=;
        b=MPnE0uJPtxe1NBM2gshMx1fbl/iPUsZkqS2iF3oQERxL8TKxuFpfHdg0kQX+KSbEar
         oJczsXUXXEcLvIIXmI/BeoKMKCKi2V67nt1WCG+/GeHZEZyZtD2S0UpLpyp0VgZ8ynoJ
         MqtGgV3yy7VRodljE2MQMRaz+m0VqVuB0rBU+pFhv6HaYHZ76vPoXhsXm+j0Qx1eedC2
         H+TBmAjJWEJvEYtVKYfggEpARrnAjue8Urf2o7AzuYO9JkViy961vgx8cCOuy0CP9DUh
         CTvUPydoj73NDiE6kNIR1FXzhTQuB8HL+KhwpcA7Bz4m238Rr2q9mOlMpbQ1DCZ75wQ4
         tvdQ==
X-Gm-Message-State: APjAAAWej668pyNcwoDj0I4vq+0RV66xDALT+wuet+3U2mBdtWgLc5j8
        7OlwFP061naCuVCFuDfiFLui3/wa4tc=
X-Google-Smtp-Source: APXvYqyDzUYSF9rLlCMNRE3Wcj6J3kC7xtVomV4betiphOAG9xMdMkyjaVUu3k8pj3PGuIWzHH1uvQ==
X-Received: by 2002:a6b:7602:: with SMTP id g2mr3409340iom.82.1561067212941;
        Thu, 20 Jun 2019 14:46:52 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id p9sm725267ioj.49.2019.06.20.14.46.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:46:52 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id j6so105097ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 14:46:52 -0700 (PDT)
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr21337944jan.90.1561067211854;
 Thu, 20 Jun 2019 14:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190620185259.142133-1-gwendal@chromium.org> <20190620185259.142133-2-gwendal@chromium.org>
In-Reply-To: <20190620185259.142133-2-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jun 2019 14:46:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
Message-ID: <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 20, 2019 at 11:53 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> To allow cros_ec iio core library to be used with legacy device, add a
> vector to rotate sensor data if necessary: legacy devices are not
> reporting data in HTML5/Android sensor referential.
>
> TEST=On veyron minnie, check chrome detect tablet mode and rotate
> screen in tablet mode.

TEST= doesn't belong in an upstream patch.


> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 719a0df5aeeb..1b2e7a8242ad 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -66,8 +66,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                 }
>                 state->type = state->resp->info.type;
>                 state->loc = state->resp->info.location;
> -       }
>
> +               /* Set sign vector, only used for backward compatibility. */
> +               memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> +       }
>         return 0;

Normally there's a blank line before the "return".  There was before
your patch.  Why did you remove it?  It'll make your diff cleaner if
you keep it.

Also, should you be basing your patch atop +Fabien's series?  I notice
you got a conflict when you picked this into the Chrome OS tree, but
maybe you wouldn't have if you had based atop
<https://lore.kernel.org/patchwork/patch/1090463/> AKA
<https://lkml.kernel.org/r/ac3cdc104e59565d178dfa86f2727045224dc4da.1560848479.git.fabien.lahoudere@collabora.com>


-Doug
