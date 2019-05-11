Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F200C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43888217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tk+Cia6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfEKAdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 20:33:09 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43041 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfEKAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 20:33:08 -0400
Received: by mail-yw1-f67.google.com with SMTP id t5so233110ywf.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 17:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ye4xjLBtskl0qaTIrAIO0OuPNKdvzfw2Zbbyb7AMX+0=;
        b=tk+Cia6LQWUyTR2QMWtaxW4xlLnam23BiAPZUU497NNekR9TLFNsc1GQjiOqvwJsUK
         pjqKmrZUuYrzIK7JIClULwKQP+798D8yl3A3DUjbdS0ftesLBYyvWtozavQK3YYGJwrw
         JZPXFPBFF0aUjzuP2ygJ8/VhrH9g6bA1XsXhXnT0MBh4AvNDL0qgZmnOFN/IDbnLerZ0
         d9c7SqY/0cxMjhF+qX8cJRxQ/6utbLyCH3NTvbdqtAjJBHDu9y2CDKEzpR7x1OQKibPF
         7AZiaZL85aRsBGJ+Kb4ynkyXbkfUhLQfFG8PZ3HG1+YpXRYsziNC+J4bQshJb5zrcy36
         L4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ye4xjLBtskl0qaTIrAIO0OuPNKdvzfw2Zbbyb7AMX+0=;
        b=HFVMgdmH4V27g9Z75kA1aDXMrHufVBjtK1CkIrXdJMTH7av7c7QUuGH84wr1GCWlAz
         9M1vw+17LOkdBPPyZB7vzDTo4TrkuF+Uo6ysPgOMff16gyNFO0gNc+zK+9jkCuZdIo+Y
         e3RysyOjs/lPicKT4TLvTI24nHznKrYnwJhh45O6RrVV1uBDe3/f/1WiftOV5wMuqIzP
         RfNE8YZ45HpgU70BeluteI52J+3OkSceMqBXFZVu6uCZfOf4kPwznGZpPfF0eJk/X2o2
         0XD5CkLoY3bV/os3rpLbIPER7bSCbhAXZ34eviPoaBXxlitP7EZvqS4PpVAKJ2QBXlc7
         +/mg==
X-Gm-Message-State: APjAAAUt7loeK0kVwcVimBmGi4LCwhVsC2OgunDOTLBrq4YKjSrQADuo
        GB7PqvqlfqevqXnjF8KBc44vGVOvqyhDvVrpkiTG4g==
X-Google-Smtp-Source: APXvYqzXf5QXyZblKWUlxEvpqIOeU0JlCpHdy7/HAbwCQeXRVq6sHeM47rrhypwookSlCy+pVIIa/ci8nY9S8yxXwtg=
X-Received: by 2002:a5b:404:: with SMTP id m4mr7375530ybp.282.1557534787785;
 Fri, 10 May 2019 17:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-5-dianders@chromium.org>
In-Reply-To: <20190510223437.84368-5-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 10 May 2019 17:32:57 -0700
Message-ID: <CABXOdTcNJNKfOj8e5TGPmCRZsZS8UQGwqC42hrOjm9t216c9JQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] Revert "platform/chrome: cros_ec_spi: Transfer
 messages at high priority"
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>
Date: Fri, May 10, 2019 at 3:35 PM
To: Mark Brown, Benson Leung, Enric Balletbo i Serra
Cc: <linux-rockchip@lists.infradead.org>, <drinkcat@chromium.org>,
Guenter Roeck, <briannorris@chromium.org>, <mka@chromium.org>, Douglas
Anderson, <linux-kernel@vger.kernel.org>

> This reverts commit 37a186225a0c020516bafad2727fdcdfc039a1e4.
>
> We have a better solution in the patch ("platform/chrome: cros_ec_spi:
> Set ourselves as timing sensitive").  Let's revert the uglier and less
> reliable solution.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_spi.c | 80 ++-------------------------
>  1 file changed, 6 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 757a115502ec..70ff1ad09012 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -75,27 +75,6 @@ struct cros_ec_spi {
>         unsigned int end_of_msg_delay;
>  };
>
> -typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
> -                                 struct cros_ec_command *ec_msg);
> -
> -/**
> - * struct cros_ec_xfer_work_params - params for our high priority workers
> - *
> - * @work: The work_struct needed to queue work
> - * @fn: The function to use to transfer
> - * @ec_dev: ChromeOS EC device
> - * @ec_msg: Message to transfer
> - * @ret: The return value of the function
> - */
> -
> -struct cros_ec_xfer_work_params {
> -       struct work_struct work;
> -       cros_ec_xfer_fn_t fn;
> -       struct cros_ec_device *ec_dev;
> -       struct cros_ec_command *ec_msg;
> -       int ret;
> -};
> -
>  static void debug_packet(struct device *dev, const char *name, u8 *ptr,
>                          int len)
>  {
> @@ -371,13 +350,13 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
>  }
>
>  /**
> - * do_cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
> + * cros_ec_pkt_xfer_spi - Transfer a packet over SPI and receive the reply
>   *
>   * @ec_dev: ChromeOS EC device
>   * @ec_msg: Message to transfer
>   */
> -static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> -                                  struct cros_ec_command *ec_msg)
> +static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> +                               struct cros_ec_command *ec_msg)
>  {
>         struct ec_host_response *response;
>         struct cros_ec_spi *ec_spi = ec_dev->priv;
> @@ -514,13 +493,13 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
>  }
>
>  /**
> - * do_cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
> + * cros_ec_cmd_xfer_spi - Transfer a message over SPI and receive the reply
>   *
>   * @ec_dev: ChromeOS EC device
>   * @ec_msg: Message to transfer
>   */
> -static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> -                                  struct cros_ec_command *ec_msg)
> +static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> +                               struct cros_ec_command *ec_msg)
>  {
>         struct cros_ec_spi *ec_spi = ec_dev->priv;
>         struct spi_transfer trans;
> @@ -632,53 +611,6 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
>         return ret;
>  }
>
> -static void cros_ec_xfer_high_pri_work(struct work_struct *work)
> -{
> -       struct cros_ec_xfer_work_params *params;
> -
> -       params = container_of(work, struct cros_ec_xfer_work_params, work);
> -       params->ret = params->fn(params->ec_dev, params->ec_msg);
> -}
> -
> -static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
> -                                struct cros_ec_command *ec_msg,
> -                                cros_ec_xfer_fn_t fn)
> -{
> -       struct cros_ec_xfer_work_params params;
> -
> -       INIT_WORK_ONSTACK(&params.work, cros_ec_xfer_high_pri_work);
> -       params.ec_dev = ec_dev;
> -       params.ec_msg = ec_msg;
> -       params.fn = fn;
> -
> -       /*
> -        * This looks a bit ridiculous.  Why do the work on a
> -        * different thread if we're just going to block waiting for
> -        * the thread to finish?  The key here is that the thread is
> -        * running at high priority but the calling context might not
> -        * be.  We need to be at high priority to avoid getting
> -        * context switched out for too long and the EC giving up on
> -        * the transfer.
> -        */
> -       queue_work(system_highpri_wq, &params.work);
> -       flush_work(&params.work);
> -       destroy_work_on_stack(&params.work);
> -
> -       return params.ret;
> -}
> -
> -static int cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
> -                               struct cros_ec_command *ec_msg)
> -{
> -       return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_pkt_xfer_spi);
> -}
> -
> -static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
> -                               struct cros_ec_command *ec_msg)
> -{
> -       return cros_ec_xfer_high_pri(ec_dev, ec_msg, do_cros_ec_cmd_xfer_spi);
> -}
> -
>  static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>  {
>         struct device_node *np = dev->of_node;
> --
> 2.21.0.1020.gf2820cf01a-goog
>
