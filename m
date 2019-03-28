Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F2FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299BC20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQwjEraY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfC1Kyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:54:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47077 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1Kyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:54:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so22412236qts.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mwMb7tnYbxwk1LZ+nI20Y251vz9HoXxrjMipuNnuZ00=;
        b=eQwjEraYeujUqbSDlrogMLQggk6AM0cD83qneoj/kf7hbMv2ZLLyV699K9piY6XHWw
         1NYvYR/SboIz5oiLom0ZyPPSCFy0wjAUPGO/nqkWT35jU3ER+PoeJ6QJ5ow6A4JnBEGB
         5XF/d8kzg4bNGaGLcjxVWf51LL2VSzNoJ0jhMwIkfUxLsNhSYPuQprPJMAqZEhQRfXsM
         x0LEG0C/E78xYjzLo34Y5z8QFPaMWKyyeGXEKifAwI/qBMS/nvHn9pv8HX0r/TZGxkz1
         9wYcZMp5U28bzmsSsM86YNB4o0vgtuN/zIGRIiwOz6Ztv4UFMnLpCV+4P3/V1nNfzRFj
         vGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mwMb7tnYbxwk1LZ+nI20Y251vz9HoXxrjMipuNnuZ00=;
        b=GI74SHJtiMI+FixA9jMa3W4ULdOcBkFSLAd1NWMbt8qpb2CiMAoXs49WGoku27AySo
         rlISUSvNO0TW2i+vsmsbwupgKCSViiv2iw87qk1RG1wKSDw8+jRkno1DTyx/jpEahhko
         mSUgJvJPygC6EnkweYZbB5yPaYZ6q6k2Ql4CfC39P2BRkO9CuIfPhPrpSwthj8K2rnag
         NASltOmuK4WGVE3rzng7DYsmmsbmkFfcHpx0mpbjBwsw9m+r6MRXmWyR5wHGq8Lr4fx8
         FeKNDBl6B3yfO9GS4ECzMZetfYtq4NtIR9wQ3D0BSjRVWc8h8vw8Jta/+YMfAi1OpmWF
         h87Q==
X-Gm-Message-State: APjAAAVbPwrVrXGPrPhGGMJze2iK/YGEsQBm5ZgJ6ILzEKJceXdTmzlp
        pfsEFDQGwqbtCSqzMzWSxMlANbKVD+4nnUGZWz4=
X-Google-Smtp-Source: APXvYqy65UA33hXdTSJCfIozDBa9SQTZpv6dPhhCBQv0Mq15kkP6dvapBUo41WqEAKlgQ8nm7fkCjzYh1ziXoM0lrNI=
X-Received: by 2002:ac8:3782:: with SMTP id d2mr35488085qtc.170.1553770484229;
 Thu, 28 Mar 2019 03:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190327051450.16222-1-pihsun@chromium.org> <20190327051450.16222-8-pihsun@chromium.org>
In-Reply-To: <20190327051450.16222-8-pihsun@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Mar 2019 11:54:32 +0100
Message-ID: <CAFqH_50sRWxYAy3tvFMPkce_NQSSqwT8z7-ASgiba2RxQ8DqdA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] cros_ec: differentiate SCP from EC by feature bit.
To:     Peter Shih <pihsun@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for submitting this upstream. Some few comments below.

Please prepend the subsystem for the commit. I.e:

mfd: cros_ec: differentiate SCP from EC by feature bit.

Missatge de Peter Shih <pihsun@chromium.org> del dia dc., 27 de mar=C3=A7
2019 a les 6:18:
>
> From: Pi-Hsun Shih <pihsun@chromium.org>
>
> Since a SCP and EC would both exist on a system, and use the cros_ec_dev

Could you also explain what an SCP is?

> driver, we need to differentiate between them for the userspace, or they
> would both be registered at /dev/cros_ec, causing a conflict.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v6:
>  - No change.
>
> Changes from v5:
>  - No change.
>
> Changes from v4:
>  - No change.
>
> Changes from v3:
>  - No change.
>
> Changes from v2:
>  - No change.
>
> Changes from v1:
>  - New patch extracted from Patch 5.
> ---
>  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
>  include/linux/mfd/cros_ec.h          |  1 +
>  include/linux/mfd/cros_ec_commands.h |  2 ++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d275deaecb12..da2f2145d31d 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -418,6 +418,16 @@ static int ec_device_probe(struct platform_device *p=
dev)
>         device_initialize(&ec->class_dev);
>         cdev_init(&ec->cdev, &fops);
>
> +       /* check whether this is actually a SCP rather than an EC */

Capitalize the phrase.

> +       if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
> +               dev_info(dev, "SCP detected.\n");

dev_info(dev, "CrOS SCP MCU detected.\n")

To be coherent with other messages like this that are already sent upstream=
.

> +               /*
> +                * Help userspace differentiating ECs from SCP,
> +                * regardless of the probing order.
> +                */
> +               ec_platform->ec_name =3D CROS_EC_DEV_SCP_NAME;
> +       }
> +
>         /*
>          * Add the class device
>          * Link to the character device for creating the /dev entry
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 8f2a8918bfa3..a971399bad82 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -24,6 +24,7 @@
>
>  #define CROS_EC_DEV_NAME "cros_ec"
>  #define CROS_EC_DEV_PD_NAME "cros_pd"
> +#define CROS_EC_DEV_SCP_NAME "cros_scp"
>
>  /*
>   * The EC is unresponsive for a time after a reboot command.  Add a
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cro=
s_ec_commands.h
> index fc91082d4c35..3e5da6e93b2f 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h

Remove this change and base your work on top of [1]

> @@ -856,6 +856,8 @@ enum ec_feature_code {
>         EC_FEATURE_RTC =3D 27,
>         /* EC supports CEC commands */
>         EC_FEATURE_CEC =3D 35,
> +       /* The MCU exposes a SCP */
> +       EC_FEATURE_SCP =3D 39,
>  };
>
>  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
> --
> 2.21.0.392.gf8f6787159e-goog
>
Thanks,
 Enric

[1] https://lkml.org/lkml/2019/2/27/723
