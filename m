Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B25DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B349520663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LNsSJhxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDCQZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:25:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46076 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDCQZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:25:16 -0400
Received: by mail-yw1-f66.google.com with SMTP id j128so6126478ywg.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVVw3qbg/Fp4CEaSknTsTfR8s3vLGPQqXlU2IVwRpNg=;
        b=LNsSJhxsAdf6HArV3HrcCzpUdmHhWwM3wFQg6ty399acDR17cqBStBSOdWMMqv1VaN
         CyYeE464MAI4j3mT8vMMLOkvV3hED4YeifevdGFWRU48G0kotylBh9AiUFJQzXj2K1Cr
         tOgzvavTyTCOIMXUXJvX32W6GaRLuvsyGwGGKbpi4aweNIsV9+363AfAqbie6fZt7wpw
         eBl5NHl0G5VKxNP6v8nJyrVzXA6BBMkw8Dy007ynpjfOBAEPfIOtJtzOoaf0ZsHy4TMD
         WMtu3VXKgAuXLxv6BCHUo7+RHX5ajkXq4KCG8KziwyuviU/N0tLhnyoTJ/kf7uXirW2/
         Mq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVVw3qbg/Fp4CEaSknTsTfR8s3vLGPQqXlU2IVwRpNg=;
        b=KveJo5PxyXKdH9zfGdTP1+rpb8MQcPABEMe5csQdNsvyzKD5TpP2AWCBTegxO0XWtr
         xlUQ8wghtTbwXViTUyuFZPtdDuqOhH8eR3EZev+IoskdTUjPWeXbG94W/rPJGRcocIRO
         JxLhlsx9+fgK5/QD9LvdqzlGlkeip3jVg93sO8bBZcFuLSpOdGDTAWrNG3U7zKVisC9m
         JUcv05hcH90RQLmS82IQXutmEdJvVfXZxrL7UJVo+OhL/OUCA/Kys3LZS8z7XCL1ykt+
         xZWkpIDjT76Ac7K9b/MJHM2cxoVXraMsb07kgkZ4IErJ7Tx89k8jeHydJJUZkrqdS/7A
         qCVg==
X-Gm-Message-State: APjAAAUgizoNO1sdXI9N8ZxrKOfcj3YGUQgCfCBD7K3unT3D2L1cphvE
        7v/jtiNGL7O9euKnrBada6OcRhBjFIkE3Fn6XJea7g==
X-Google-Smtp-Source: APXvYqz/Zv+FJzLDoE2KiyvKYWylmkDGL+0MxYKurF0v7/4+Zz8f1AUP+8pmrVMqY1hHOX+4TtQBbNenX5tjdh/R5+k=
X-Received: by 2002:a81:7052:: with SMTP id l79mr205141ywc.299.1554308715275;
 Wed, 03 Apr 2019 09:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403135123.8723-1-enric.balletbo@collabora.com>
In-Reply-To: <20190403135123.8723-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 3 Apr 2019 09:25:04 -0700
Message-ID: <CABXOdTe3sYq2bKPEajHu9LzMLXhEbABQAAGc8OfcYU3Z9LY7xQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Also return invalid
 command in cros_ec_cmd_xfer_status
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 6:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The commit 9798ac6d32c1 ("mfd: cros_ec: Add cros_ec_cmd_xfer_status()
> helper") was introduced to remove duplicated code in several users of
> the cros_ec_cmd_xfer function. The idea behind that commit is mask all
> the EC errors as protocol error when the EC command fails, what is
> really useful because as a user you probably don't care of the exact
> error reported by the EC, you only want to know if the command succeeded
> or not.
>
> That works for most of the errors returned by the EC, but we might be
> also interested on report the EC_RES_INVALID_COMMAND, which happens when
> the command is not supported by the EC. An use case for this is when you
> need to show/hide a sysfs attribute for a specific command and you don't
> have a EC feature flag that tells you that the command is supported or
> not.
>
> While here, also document properly the cros_ec_cmd_xfer_status
> function.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_proto.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 97a068dff192..a4e0d3a6d891 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -478,6 +478,16 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
>
> +/**
> + * cros_ec_cmd_xfer_status() - Send EC command.
> + * @ec_dev: EC device.
> + * @msg: EC message data for request and response.
> + *
> + * Return:
> + * 0 - OK
> + * -EINVAL - Invalid command.
> + * -EPROTO - Protocol error.
> + */
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>                             struct cros_ec_command *msg)
>  {
> @@ -486,6 +496,11 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>         ret = cros_ec_cmd_xfer(ec_dev, msg);
>         if (ret < 0) {
>                 dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> +       } else if (msg->result == EC_RES_INVALID_COMMAND) {
> +               dev_dbg(ec_dev->dev,
> +                       "Command %d not supported for this device\n",
> +                       msg->command);
> +               return -EINVAL;
>         } else if (msg->result != EC_RES_SUCCESS) {
>                 dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
>                 return -EPROTO;
> --
> 2.20.1
>
