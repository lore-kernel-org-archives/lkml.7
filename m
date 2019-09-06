Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B91C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F98020650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gD6uj9FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404844AbfIFWVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:21:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38854 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404739AbfIFWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:21:02 -0400
Received: by mail-ot1-f67.google.com with SMTP id h17so3382554otn.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VyMJWBEPsB7vao4ptT8RBaxxk1IW+CWAUFgT/wMlCo=;
        b=gD6uj9FTM1zXkzTJ+OUwUcDlALNeiHFkbM3CnaFLa8BvcQ4a4QsqVBHYsnzO0FKw2V
         rTp56bUhzcVir8mOzoYyCEFnSVeygTamYbat9gR9BwgainOiYe5dV3fV33xMT09CdtwW
         6zXX8AYgrqtVhj5Bp/50WCV2xl04hPKQfgcg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VyMJWBEPsB7vao4ptT8RBaxxk1IW+CWAUFgT/wMlCo=;
        b=hlbHRJou3eU9tXkZaVHZFRId3F+NceelC05Vewb5Xf9iFA6p1tpECE4D5FFgckpwaV
         tQNE/0vsP7xq/cn4YpPryI/W4WXT/TL/xlT7g2JLaKfIok4uLV7ioh1OOAXun6CmCq4M
         cc8flkfa6kSMARfVfavSDVqLKQyrVkWlbpVbD+dGXVHvNGzCnYs4P/ONByWfVoK2qbN+
         vNUBnhKECLReOlhMd+3xspDF8kYZZkQwpBV25sUcby1S4NRGOAGAMpkRI4Eblr3nVZHY
         9/uRauj7aEfLYf31Se/H85xxtYV/wxYNeUHYuIZQUgKT8k8GGLpYZG98csi4XO2ZQKVO
         oj/g==
X-Gm-Message-State: APjAAAUK4R6gR9NkAZ1rO6lcXCVXMeoK+evPTzSzmP9nhedIg2qwoydb
        TqmTWuldUTwi+wNYokOJPUk+P24nHE0=
X-Google-Smtp-Source: APXvYqw5ybuC3Z7hRju/I4JZkDs888j0tEqd01HinoZMreZ1VrDqB9mJjDaNIUrHw5RgafUd1LWrsw==
X-Received: by 2002:a9d:7305:: with SMTP id e5mr8989616otk.252.1567808460474;
        Fri, 06 Sep 2019 15:21:00 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id m17sm2504792otr.51.2019.09.06.15.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 15:20:59 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id g128so6329917oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 15:20:59 -0700 (PDT)
X-Received: by 2002:aca:7509:: with SMTP id q9mr7434568oic.111.1567808459054;
 Fri, 06 Sep 2019 15:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190906204205.50799-1-campello@chromium.org>
In-Reply-To: <20190906204205.50799-1-campello@chromium.org>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 6 Sep 2019 18:20:51 -0400
X-Gmail-Original-Message-ID: <CAHX4x84w1xf9RL_rK4PiMrW2uhVkNFeU5GrW_BYfs8B5NKG9jg@mail.gmail.com>
Message-ID: <CAHX4x84w1xf9RL_rK4PiMrW2uhVkNFeU5GrW_BYfs8B5NKG9jg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add debugfs test_event file
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Trent Begin <tbegin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch Daniel! A few thoughts that I didn't
have on the review on Gerrit, sorry :) After those changes,

Reviewed-by: Nick Crews <ncrews@chromium.org>

On Fri, Sep 6, 2019 at 4:42 PM Daniel Campello <campello@chromium.org> wrote:
>
> This change introduces a new debugfs file 'test_event' that when written
> to causes the EC to generate a test event.
>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/platform/chrome/wilco_ec/debugfs.c | 33 +++++++++++++++++-----
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> index 8d65a1e2f1a3..2103c3ed8385 100644
> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> @@ -160,29 +160,29 @@ static const struct file_operations fops_raw = {
>
>  #define CMD_KB_CHROME          0x88
>  #define SUB_CMD_H1_GPIO                0x0A
> +#define SUB_CMD_TEST_EVENT     0x0B
>
> -struct h1_gpio_status_request {
> +struct ec_request {
>         u8 cmd;         /* Always CMD_KB_CHROME */
>         u8 reserved;
>         u8 sub_cmd;     /* Always SUB_CMD_H1_GPIO */

This comment should be removed.

>  } __packed;
>
> -struct hi_gpio_status_response {
> +struct ec_response {
>         u8 status;      /* 0 if allowed */
>         u8 val;         /* BIT(0)=ENTRY_TO_FACT_MODE, BIT(1)=SPI_CHROME_SEL */

This comment should be moved to h1_gpio_get().

>  } __packed;
>
> -static int h1_gpio_get(void *arg, u64 *val)
> +static int write_to_mailbox(struct wilco_ec_device *ec, u8 sub_cmd, u64 *val)

What about send_ec_cmd() or similar? Something that communicates that
we are sometimes telling the EC to do something, and sometimes reading something
back. Also, since we are adding in another layer in here, we can fix
the signature from
the one required by a debugfs attribute. Use "ret" instead of "val"
and make it a u8*.

>  {
> -       struct wilco_ec_device *ec = arg;
> -       struct h1_gpio_status_request rq;
> -       struct hi_gpio_status_response rs;
> +       struct ec_request rq;
> +       struct ec_response rs;
>         struct wilco_ec_message msg;
>         int ret;
>
>         memset(&rq, 0, sizeof(rq));
>         rq.cmd = CMD_KB_CHROME;
> -       rq.sub_cmd = SUB_CMD_H1_GPIO;
> +       rq.sub_cmd = sub_cmd;
>
>         memset(&msg, 0, sizeof(msg));
>         msg.type = WILCO_EC_MSG_LEGACY;
> @@ -201,8 +201,25 @@ static int h1_gpio_get(void *arg, u64 *val)
>         return 0;
>  }
>
> +static int h1_gpio_get(void *arg, u64 *val)
> +{
> +       return write_to_mailbox(arg, SUB_CMD_H1_GPIO, val);
> +}
> +
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
>

A one line comment as to what test_event does?

> +static int test_event_set(void *arg, u64 val)
> +{
> +       u64 ret;
> +
> +       return write_to_mailbox(arg, SUB_CMD_TEST_EVENT, &ret);
> +}
> +
> +/* Format set to NULL since it is only used on read operations which are
> + * forbidden by file permissions.
> + */
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_test_event, NULL, test_event_set, NULL);
> +
>  /**
>   * wilco_ec_debugfs_probe() - Create the debugfs node
>   * @pdev: The platform device, probably created in core.c
> @@ -226,6 +243,8 @@ static int wilco_ec_debugfs_probe(struct platform_device *pdev)
>         debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
>         debugfs_create_file("h1_gpio", 0444, debug_info->dir, ec,
>                             &fops_h1_gpio);
> +       debugfs_create_file("test_event", 0200, debug_info->dir, ec,
> +                           &fops_test_event);
>
>         return 0;
>  }
> --
> 2.23.0.162.g0b9fbb3734-goog
>
