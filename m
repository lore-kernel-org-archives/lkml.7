Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DFDC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E0B20657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 02:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bCy177hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFUCZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 22:25:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38246 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfFUCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 22:25:28 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so618560ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mg7oGXJCAj6FFdmzHQTcSzEM3alTCYySY13IsZcgBXo=;
        b=bCy177hm6MGkspKujaBsBUY7rKVKgbYxxOIr7sZWTcjLi9+g3ISleyYYiBfdlGuIUt
         8cftWHwVhB9uOsYNFXViGJrK8613Tv14P8xmDj8NiGoFhYuU2IHQnklXoMUE6ZdKvlvc
         DVQD98YjxAG4UhSjPtmi4BRWMQ9QW8SO9lmnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mg7oGXJCAj6FFdmzHQTcSzEM3alTCYySY13IsZcgBXo=;
        b=NEyvwulYolyuJyLT3CrsyozoTqgf9kiqkwglar5cGbl6ZB8hWcompj2rINB3NWlyE/
         yNFGJdGPKl/kbpdbP1J/+eITg9Tnw0f1vUs/OjXroHvjGKFVuAy5PFXiKFL+qm2A4Xth
         01yf/Wln5y79HviRV0GwtKttQCDsNRDfB+9HK+xWVE+6lKjgwL+3UME93UbsUjl4dToX
         H4Iz2T2QIog7pkVbD+x5M6JyN5exn38c/4AdBYfxbJfrLfDjS8u7+hkLJD9O4V+qZNpG
         LBY+YVr1oUQJE/4JvT4Q6c2Tt9mI3ms1uupp1yNfV5tMc6ZSuHg0FpHaUfZ11hMXQK2+
         5X+A==
X-Gm-Message-State: APjAAAXXMEy6CQ7OkkMP3ltXOOSHVtJH3uDDDRCq45SW5IDGg/tVqWIK
        +S1M4zX1RKkb2UkG6a7fLr8oQlgT2LICcLghH3q3FQ==
X-Google-Smtp-Source: APXvYqzsblSMSNfJa2OjLLVCvs/q+ylTG1px2/TuD3C3Sn0F74SKDSD/Zx/MUoyF+OPtwFhs1nsm39Z6bvd2FoW4CZA=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr23020507ioo.237.1561083927275;
 Thu, 20 Jun 2019 19:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620185259.142133-1-gwendal@chromium.org> <20190620185259.142133-2-gwendal@chromium.org>
 <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
In-Reply-To: <CAD=FV=VPK4fQeYGFh2wzxgwt5Wo7hK6JpQ9sN7QM9Q0_w7AALw@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 20 Jun 2019 19:25:16 -0700
Message-ID: <CAPUE2utxbVPyj6F2uV95CmT7aF0=ZyNN7bS97ynL1quFiDq+FQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
To:     Doug Anderson <dianders@chromium.org>
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

On Thu, Jun 20, 2019 at 2:46 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Jun 20, 2019 at 11:53 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > To allow cros_ec iio core library to be used with legacy device, add a
> > vector to rotate sensor data if necessary: legacy devices are not
> > reporting data in HTML5/Android sensor referential.
> >
> > TEST=On veyron minnie, check chrome detect tablet mode and rotate
> > screen in tablet mode.
>
> TEST= doesn't belong in an upstream patch.
>
>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
> >  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 719a0df5aeeb..1b2e7a8242ad 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -66,8 +66,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                 }
> >                 state->type = state->resp->info.type;
> >                 state->loc = state->resp->info.location;
> > -       }
> >
> > +               /* Set sign vector, only used for backward compatibility. */
> > +               memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
> > +       }
> >         return 0;
>
> Normally there's a blank line before the "return".  There was before
> your patch.  Why did you remove it?  It'll make your diff cleaner if
> you keep it.
Will fix these issues in next patch.
>
> Also, should you be basing your patch atop +Fabien's series?  I notice
> you got a conflict when you picked this into the Chrome OS tree, but
> maybe you wouldn't have if you had based atop
> <https://lore.kernel.org/patchwork/patch/1090463/> AKA
> <https://lkml.kernel.org/r/ac3cdc104e59565d178dfa86f2727045224dc4da.1560848479.git.fabien.lahoudere@collabora.com>
I did not based on top of Fabien's patches because this change is
orthogonal to Fabien's. Moreover a new set of patches is needed as the
attributes added (min_freq, max_freq) do not match the current sysfs
ABI.

Gwendal.
>
>
> -Doug
