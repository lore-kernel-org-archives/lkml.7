Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7DFC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FA220850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neiuuyf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKVne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:43:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40818 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:43:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so8966911qts.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t4hUGWrDhFAsjaNw1f8IgQBrbwKZIbLE47to0O20WXE=;
        b=neiuuyf6CoEUizs0gmN3xZNZ9D8rrB+t5mopGVsNEM2gohKk23oHr6/Iol16SLud6y
         OANJR9ulHV5Zocdiciz4pHHbuTAlbutzVpx4dy4xEp/PX12t52iHp7aRyEs/2R6JUIzK
         Ys1F5RXvfSUgEmMG39pbYTAySfy002DbdARrQXm0jU1Ar/SLGHiZhBZ8+bus75c7Cees
         J7MBIW4EjVN2cWKyRU+3WP/r9aJznIoFXuoDvX1lXDFAm8w9xQu1TTvQj/H80QWfEk69
         cu+5hz0HPz6z077yNXW2Za4Ops7/BOI7e/xYBENfQPN0ot1nd5aiUNMPw8W6kmg7rTk6
         EDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t4hUGWrDhFAsjaNw1f8IgQBrbwKZIbLE47to0O20WXE=;
        b=Q7/UwoVCu8PrgI9XfT7n/GdO79pYdXfs+Qd4nAPFDnLfgUEFjgd0HxWM/qm/3VqA3u
         hj9pG7cNiBU5Ema4LHOC+G8kB5R0AjqsYXttQ1OWLu+wVrjK5Q+TcJgOB8wKR8erHzWB
         doyapyIa4DxhIMS3lzlmatkSTI7EROBoCRi3/LfgYrgcn4Ix+9lGY5gutgP7KgncLPrR
         l3J+6XRgCMlKKj+HA9UnnUQosVUXOWhCddee1tp98VK83IvW3FH6Jnaq9zL3zxRVucU3
         BsFi6J2JZT6h16wz+OGK9JACSiYY67bItqRZxwkaeVeS0srgsD9jBw/1uueEiRUOi/7T
         6HMA==
X-Gm-Message-State: APjAAAX/mOZJQoFsARLhswVC4l2rfljWwQ2QoXt2QxXPCGxi3ZxDxrzL
        wh7eEWjVAjAg0JPk05Ti35Zcyi5BRtK8EWvvtvwjSTiu
X-Google-Smtp-Source: APXvYqx9yviwukj20Bk/fl9XZAb6pl28uVpRzxYzCeGLizUR7QyMar1W8e/UWYWhERpISpPQhEy4Nlif32V5Q3u7YH8=
X-Received: by 2002:ac8:85c:: with SMTP id x28mr44823545qth.90.1555019012447;
 Thu, 11 Apr 2019 14:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190410220703.51627-1-ncrews@chromium.org>
In-Reply-To: <20190410220703.51627-1-ncrews@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 11 Apr 2019 23:43:20 +0200
Message-ID: <CAFqH_52Yy8U6RFf3brOb7A0U173Z8PDcF=j9_RhwfDu0CegGYw@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: wilco_ec: Add h1_gpio status to debugfs
To:     Nick Crews <ncrews@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, alevkoy@chromium.org,
        keithshort@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Some comments below ...

Missatge de Nick Crews <ncrews@chromium.org> del dia dj., 11 d=E2=80=99abr.
2019 a les 0:09:
>
> As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
> tests, we need to ensure that the H1 chip is properly setting
> some GPIO lines. The h1_gpio attribute exposes the state
> of the lines:
> - ENTRY_TO_FACT_MODE in BIT(0)
> - SPI_CHROME_SEL in BIT(1)
>
> There are two reasons that I am exposing this in debugfs,
> and not as a GPIO:
> 1. This is only useful for testing, so end users shouldn't ever
> care about this. In fact, if it passes the tests, then the value of
> h1_gpio will always be 2, so it would be really uninteresting for users.
> 2. This GPIO is not connected to, controlled by, or really even related
> to the AP. The GPIO runs between the EC and the H1 security chip.
>
> Changes in v3:
> - Fix documentation to correspond with formatting change in v2.
> Changes in v2:
> - Zero out the unused fields in the request.
> - Format result as "%02x\n" instead of as a decimal.

I don't really mind, but wouldn't be more clear prefix with 0x (0x%02x)?

>
> Signed-off-by: Nick Crews <ncrews@chromium.org>
> ---
>  drivers/platform/chrome/wilco_ec/debugfs.c | 64 +++++++++++++++++++++-

ABI documentation missing.

>  1 file changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platfor=
m/chrome/wilco_ec/debugfs.c
> index 17c4c9068aaf..1b93243c8954 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright 2019 Google LLC
>   *
> - * There is only one attribute used for debugging, called raw.
> + * The raw attribute is very useful for EC debugging.
>   * You can write a hexadecimal sentence to raw, and that series of bytes
>   * will be sent to the EC. Then, you can read the bytes of response
>   * by reading from raw.
> @@ -30,6 +30,16 @@
>   * Note that the first 32 bytes of the received MBOX[] will be printed,
>   * even if some of the data is junk. It is up to you to know how many of
>   * the first bytes of data are the actual response.
> + *
> + * There is also another debugfs attribute, called h1_gpio.
> + * As part of Chrome OS's FAFT (Fully Automated Firmware Testing)
> + * tests, we need to ensure that the H1 chip is properly setting
> + * some GPIO lines. The h1_gpio attribute exposes the state
> + * of the lines:
> + * - ENTRY_TO_FACT_MODE in BIT(0)
> + * - SPI_CHROME_SEL in BIT(1)
> +
> + * Output will formatted with "%02x\n".
>   */
>
>  #include <linux/ctype.h>
> @@ -189,6 +199,56 @@ static const struct file_operations fops_raw =3D {
>         .llseek =3D no_llseek,
>  };
>
> +#define CMD_KB_CHROME          0x88
> +#define SUB_CMD_H1_GPIO                0x0A
> +
> +struct h1_gpio_status_request {
> +       u8 cmd;         /* Always CMD_KB_CHROME */
> +       u8 reserved;
> +       u8 sub_cmd;     /* Always SUB_CMD_H1_GPIO */
> +} __packed;
> +
> +struct hi_gpio_status_response {
> +       u8 status;      /* 0 if allowed */
> +       u8 val;         /* BIT(0)=3DENTRY_TO_FACT_MODE, BIT(1)=3DSPI_CHRO=
ME_SEL */
> +} __packed;
> +
> +static ssize_t h1_gpio_read(struct file *file, char __user *user_buf,
> +                           size_t count, loff_t *ppos)
> +{
> +       struct h1_gpio_status_request rq;
> +       struct hi_gpio_status_response rs;
> +       struct wilco_ec_message msg;
> +       char buf[4];
> +       int ret;
> +
> +       memset(&rq, 0, sizeof(rq));
> +       rq.cmd =3D CMD_KB_CHROME;
> +       rq.sub_cmd =3D SUB_CMD_H1_GPIO;
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.type =3D WILCO_EC_MSG_LEGACY;
> +       msg.request_data =3D &rq;
> +       msg.request_size =3D sizeof(rq);
> +       msg.response_data =3D &rs;
> +       msg.response_size =3D sizeof(rs);
> +       ret =3D wilco_ec_mailbox(debug_info->ec, &msg);
> +       if (ret < 0)
> +               return ret;
> +       if (rs.status)
> +               return -EIO;
> +
> +       sprintf(buf, "%02x\n", rs.val);
> +
> +       return simple_read_from_buffer(user_buf, count, ppos, buf, sizeof=
(buf));
> +}
> +
> +static const struct file_operations fops_h1_gpio =3D {
> +       .owner =3D THIS_MODULE,
> +       .read =3D h1_gpio_read,
> +       .llseek =3D no_llseek,
> +};
> +

I think that I'd use the DEFINE_DEBUGFS_ATTRIBUTE here.

>  /**
>   * wilco_ec_debugfs_probe() - Create the debugfs node
>   * @pdev: The platform device, probably created in core.c
> @@ -210,6 +270,8 @@ static int wilco_ec_debugfs_probe(struct platform_dev=
ice *pdev)
>         if (!debug_info->dir)
>                 return 0;
>         debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw=
);
> +       debugfs_create_file("h1_gpio", 0444, debug_info->dir, NULL,
> +                           &fops_h1_gpio);
>
>         return 0;
>  }
> --
> 2.20.1
>

Thanks,
 Enric
