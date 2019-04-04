Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7041C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95CA20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWAdzXR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfDDSjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:39:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45359 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDSjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:39:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id 5so2509994lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vHYvpsESJHESOW0Op1N1a8DNWBLxQ+6ptTfC/LRS+RY=;
        b=iWAdzXR5mbkZQmazMpU1pxC3r86khjU/AKTlt4lbdTBbfpfD+CKXNDozFi16rzi1Qf
         9ZkxhDVk44DqyFpVJ2DcmSP0jtG0ykqiCEEGYboyZaZR4UaoXlHdaxpAI86FA5LhVvTd
         tjTR9jM+ExMRAI1YHGFOVlH77zFVpXETLMd2GpLSrLTsqUBy8U9JWhJdFgVgDloPVnA+
         wKqDqvDXmQEawts/9w03P7TKviK9l+m0sl/8u5TY0ZEa9J76Nv/98F77ssPf0FPwZniP
         aUblWU4AvKNSAM0cef55IGc58Dro1z3dKQlBUeGLYC9NIvmccOlLF9pIA6Pg7j3h4R0M
         zFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vHYvpsESJHESOW0Op1N1a8DNWBLxQ+6ptTfC/LRS+RY=;
        b=Pmh5o/BE175BamKlrZYjMP6JdSlcEaKcSqBbBHI/mPo1y/TTXzvZjui81vOSia0Fj+
         gMS6hftKNreQB5jOJTu7s2apWlVSXwaAsYDTwAZamvZD1axKgiTfX46wV3zEC2kpIxp1
         34sKdsO9tLbJ2ngt0CdjLJVJzq3uDfIlzbhZ/ZqSiucjIpR2AcLvymuvPiyWjCxEcBn4
         fhpzOGYO8fIJC3EBHaZxYM2rpQ+4EoICJ2Y3YfjJd6HSkRYYCuTbBgtXLfM5Dn6g/zw+
         DX2aB0iY7mJOvDnogEinmOSbbvfWExri3eix+Q+vsGR6ezIV9HEi9HC+3yiuPne7HIj9
         xIew==
X-Gm-Message-State: APjAAAXeU6nbUP0NkM12PsTlj4EPj58SqjaUlX49aR245hdoWNbayFvE
        q1SRT1IHE5+o2ETEtfTrDrVfts44HroqUUeDctW8Ng==
X-Google-Smtp-Source: APXvYqxSORX+ODqnopi0u7RGPJ5zViLanpQIZ6PCVGP8uZXqJnIgDEeJ04zOhfI9kY2Uu9NLwIZsYiFK8JdH0jd5AlQ=
X-Received: by 2002:ac2:5a0e:: with SMTP id q14mr4028946lfn.47.1554403143130;
 Thu, 04 Apr 2019 11:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190403213428.89920-1-evgreen@chromium.org> <20190403213428.89920-3-evgreen@chromium.org>
In-Reply-To: <20190403213428.89920-3-evgreen@chromium.org>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 4 Apr 2019 11:38:26 -0700
Message-ID: <CACK8Z6Ev-7Yikmdhy89hWuCr-Lj3=ZGaK_eCyrdUzL17dVaCHQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] platform/chrome: Add support for v1 of host sleep event
To:     Evan Green <evgreen@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 2:34 PM Evan Green <evgreen@chromium.org> wrote:
>
> Add support in code for the new forms of the host sleep event.
> Detects the presence of this version of the command at runtime,
> and use whichever form the EC supports. At this time, always
> request the default timeout, and only report the failing response
> via a WARN_ONCE(). Future versions could accept the sleep parameter
> from outside the driver, and return the response information to
> usermode or elsewhere.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rajat Jain <rajatja@chromium.org>

>
> ---
>
> Changes in v3:
> - Consolidated boolean logic for host_sleep_v1 (Guenter)
>
> Changes in v2:
> - Removed unnecessary version assignment (Guenter)
> - Changed WARN to WARN_ONCE (Guenter)
> - Fixed C code to use anonymous unions
> - insize is only bigger for resume events.
>
>  drivers/mfd/cros_ec.c                   | 39 +++++++++++++++++++++----
>  drivers/platform/chrome/cros_ec_proto.c |  6 ++++
>  include/linux/mfd/cros_ec.h             |  2 ++
>  3 files changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index 6acfe036d522..bd2bcdd4718b 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -75,20 +75,49 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
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
> +               buf.u.req1.suspend_params.sleep_timeout_ms =
> +                               EC_HOST_SLEEP_TIMEOUT_DEFAULT;
> +
> +               buf.msg.outsize = sizeof(buf.u.req1);
> +               if ((sleep_event == HOST_SLEEP_EVENT_S3_RESUME) ||
> +                   (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME))
> +                       buf.msg.insize = sizeof(buf.u.resp1);
> +
> +               buf.msg.version = 1;
> +
> +       } else {
> +               buf.u.req0.sleep_event = sleep_event;
> +               buf.msg.outsize = sizeof(buf.u.req0);
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
> +               WARN_ONCE(buf.u.resp1.resume_response.sleep_transitions &
> +                         EC_HOST_RESUME_SLEEP_TIMEOUT,
> +                         "EC detected sleep transition timeout. Total slp_s0 transitions: %d",
> +                         buf.u.resp1.resume_response.sleep_transitions &
> +                         EC_HOST_RESUME_SLEEP_TRANSITIONS_MASK);
> +
> +       return ret;
>  }
>
>  int cros_ec_register(struct cros_ec_device *ec_dev)
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 97a068dff192..52ca564a64e7 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -414,6 +414,12 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         else
>                 ec_dev->mkbp_event_supported = 1;
>
> +       /* Probe if host sleep v1 is supported for S0ix failure detection. */
> +       ret = cros_ec_get_host_command_version_mask(ec_dev,
> +                                                   EC_CMD_HOST_SLEEP_EVENT,
> +                                                   &ver_mask);
> +       ec_dev->host_sleep_v1 = (ret >= 0 && (ver_mask & EC_VER_MASK(1)));
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
