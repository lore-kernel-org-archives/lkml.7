Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D88C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D5921874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMiBtBQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfCUPPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:15:03 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40928 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfCUPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:15:03 -0400
Received: by mail-yw1-f68.google.com with SMTP id p64so4182535ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRbG0RYibZyaywKvdRwp7lmvR8o7k1rzzpeHp9SC+7k=;
        b=ZMiBtBQyEUjqffmLrMvbdTKK6nHJbkSlahFRFkTxSkXQ9fvH99UJZQKRQEKdiPZ1Nn
         U5ldvcmn1apSrSo62y95hQDIaLn8UqXlRwYbnOutFQOyMqf4oxmozs0IQ6zvbA8Tc4ZV
         JnbHD20ZPu8vjo4xhlJ/S8Rib3+ojIwFy5H9WxluinTd4SU+sUD5CJkHvyCXNFzSy87U
         9GjM9tpsgozn1H1H6TdF3kxUD/86OBEGHFQ/l6DBmt5FKfRdsPmaIz8Hlr4ArBf1RInz
         H51WdEi46b8XA69kSxlc/AvgrbFFF+U+0Vw7xCYYt+xzHWaM7xcoI/3gb8UtC8yK+ioH
         lehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRbG0RYibZyaywKvdRwp7lmvR8o7k1rzzpeHp9SC+7k=;
        b=hy6C6vkQ2B4lxTCzU+2fVvNhrmbIov/smIq0zNt21XS3AVfPrn1vn2KGyt5J8oZz4Q
         6Q7RfvQIry+TZMRu9vNbIlRNYFKWVDCoSzOCcBjDRXsl6Db72q0JBAqiTEe9GQavWj3i
         83ecCWUqWCO49kBodLb4Km+bgFF8cSJiCfhqguG8gfKlKFT1q1CHOlBO8Axdz5N2HOSS
         /UlyikrHfY/8EoQbVyVT7iPsC4S6wTKlysfl6GY3YZoYGlXF+bI9nl/VNiLnkBg3m8uW
         +1Jg0QutOv3KCa4uHMMvRKcl7VzSMwepZdyHe30YafQKXWLDp8UuEY5VCpzKONsxcMCu
         c1mQ==
X-Gm-Message-State: APjAAAUJcwpo2LeTjR/Qk0HlSmBaa83YzvZQW38nA2pXv4XukboBHilB
        IStWhMgX5z/GQWUjzSfq843Q2fhFuUDilctmzvEJDw==
X-Google-Smtp-Source: APXvYqz1XiPSrmk+icoaKpO060q8aa3Y7zGjHle9QPcAj5wGHZs7slv2e5d4vB095wlQVmNzQesP8EicyBnn4fpkqkw=
X-Received: by 2002:a25:b82:: with SMTP id 124mr3569830ybl.63.1553181301580;
 Thu, 21 Mar 2019 08:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190320212030.43682-1-evgreen@chromium.org> <20190320212030.43682-3-evgreen@chromium.org>
In-Reply-To: <20190320212030.43682-3-evgreen@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 21 Mar 2019 08:14:50 -0700
Message-ID: <CABXOdTfPfyxWfAvAaphfbhei4wuTxZLCbqS8gr=uCemepJRkkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: Add support for v1 of host sleep event
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 2:21 PM Evan Green <evgreen@chromium.org> wrote:
>
> Add support in code for the new forms of the host sleep event.
> Detects the presence of this version of the command at runtime,
> and use whichever form the EC supports. At this time, always
> request the default timeout, and only report the failing response
> via a WARN(). Future versions could accept the sleep parameter
> from outside the driver, and return the response information to
> usermode or elsewhere.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
>
> ---
>
>  drivers/mfd/cros_ec.c                   | 37 +++++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_proto.c |  9 ++++++
>  include/linux/mfd/cros_ec.h             |  2 ++
>  3 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 6acfe036d522..5305ea706aa9 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -75,20 +75,47 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
>
>  static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>  {
> +       int ret;
>         struct {
>                 struct cros_ec_command msg;
> -               struct ec_params_host_sleep_event req;
> +               union {
> +                       struct ec_params_host_sleep_event req0;
> +                       struct ec_params_host_sleep_event_v1 req1;
> +                       struct ec_response_host_sleep_event_v1 resp1;
> +               } u;
>         } __packed buf;
>
>         memset(&buf, 0, sizeof(buf));
>
> -       buf.req.sleep_event = sleep_event;
> +       if (ec_dev->host_sleep_v1) {
> +               buf.u.req1.sleep_event = sleep_event;
> +               buf.u.req1.u.suspend_params.sleep_timeout_ms =
> +                               EC_HOST_SLEEP_TIMEOUT_DEFAULT;
> +
> +               buf.msg.outsize = sizeof(buf.u.req1);
> +               buf.msg.insize = sizeof(buf.u.resp1);
> +               buf.msg.version = 1;
> +
> +       } else {
> +               buf.u.req0.sleep_event = sleep_event;
> +               buf.msg.outsize = sizeof(buf.u.req0);
> +               buf.msg.version = 0;

Unnecessary assignment (already 0).
> +       }
>
>         buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
> -       buf.msg.version = 0;
> -       buf.msg.outsize = sizeof(buf.req);
>
> -       return cros_ec_cmd_xfer(ec_dev, &buf.msg);
> +       ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
> +
> +       /* For now, report failure to transition to S0ix with a warning. */
> +       if (ret >= 0 && ec_dev->host_sleep_v1 &&
> +           (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> +               WARN(buf.u.resp1.u.resume_response.sleep_transitions &

Is WARN really appropriate here, or would dev_warn() do ?

> +                    EC_HOST_RESUME_SLEEP_TIMEOUT,
> +                    "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> +                    buf.u.resp1.u.resume_response.sleep_transitions &
> +                    EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> +
> +       return ret;
>  }
>
>  int cros_ec_register(struct cros_ec_device *ec_dev)
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 97a068dff192..78ceab659a36 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -414,6 +414,15 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         else
>                 ec_dev->mkbp_event_supported = 1;
>
> +       /* Probe if host sleep v1 is supported for S0ix failure detection. */
> +       ret = cros_ec_get_host_command_version_mask(ec_dev,
> +                                                   EC_CMD_HOST_SLEEP_EVENT,
> +                                                   &ver_mask);
> +       if (ret < 0 || !(ver_mask & EC_VER_MASK(1)))
> +               ec_dev->host_sleep_v1 = 0;
> +       else
> +               ec_dev->host_sleep_v1 = 1;

This is a boolean.
        ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));

> +
>         /*
>          * Get host event wake mask, assume all events are wake events
>          * if unavailable.
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index 8f2a8918bfa3..b6442201f77f 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -120,6 +120,7 @@ struct cros_ec_command {
>   * @pkt_xfer: Send packet to EC and get response.
>   * @lock: One transaction at a time.
>   * @mkbp_event_supported: True if this EC supports the MKBP event protocol.
> + * @host_sleep_v1: True if this EC supports the sleep v1 command.
>   * @event_notifier: Interrupt event notifier for transport devices.
>   * @event_data: Raw payload transferred with the MKBP event.
>   * @event_size: Size in bytes of the event data.
> @@ -153,6 +154,7 @@ struct cros_ec_device {
>                         struct cros_ec_command *msg);
>         struct mutex lock;
>         bool mkbp_event_supported;
> +       bool host_sleep_v1;
>         struct blocking_notifier_head event_notifier;
>
>         struct ec_response_get_next_event_v1 event_data;
> --
> 2.20.1
>
