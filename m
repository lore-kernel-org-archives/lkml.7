Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE07C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E242A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLxa3328"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfDOVhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:37:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38488 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfDOVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:37:43 -0400
Received: by mail-yw1-f65.google.com with SMTP id m207so6574536ywd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbCx28Rx9/K0yaSt/RWbJk7kpozMNKJpZR+n35G+hhw=;
        b=uLxa3328epnBEJMvyER8u0iWUnqd/of6B8IoMUE2HCff3wHcnv0P0kfQ7zOu4fWKAn
         m6PF0WXYbv8l5xjc6KkMa+xfyt2QfKsBvKFdiSlXVFTtuvoM8fLjhXV+WFt1+KpFb92q
         nbjYlWaIexO9nu78L7MOL4vijd99BL0X+3I0/BWw1x83D9h4PJJWi18cPxCnSDwl3lEE
         N/gHUHCWQ0voEu9GV9j2Zr0eh24NnjYTwrauuQeQsuYPBFi1y4Fjh7PAR18B0vKidsLJ
         HghTAhsVLVxP+zhzHQc0XG3sz4p2oW2mqQ4pFAW7B/O/JaHwzzZKYqOVTwsQg8b+12ea
         vkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbCx28Rx9/K0yaSt/RWbJk7kpozMNKJpZR+n35G+hhw=;
        b=kGW5QP5h2ha8MbnZ5TEkLnc0ng/qvqUGwdIyIWFw1Xjl7B7udJlsnl77hPdNaDaJi3
         NXGvP1g8WB01saHZj84Gu4Y6z0rzkIjdaNmlzp2pUqTkk3cAVHDq1saRdWtm+p/kjOtu
         DG1tKD47R6c8eUaHor2yPWvvhU67m95Z7OJ8I6NFXKjUERVk2BFuA0OTR8rNU5ADqo5U
         3ggd4+PfimTIQ31g8j27Ub7E3iJR/7pGAne2TZHTEaA88dZpByq6GA/IhQWzMTEQSJUa
         mCQk7A6GWUgZdJhAuJMtrNzqx4yhxFwjxFKalrq1c5LHsdkv8Si8i3H67oAYvoqoLq8i
         vdnw==
X-Gm-Message-State: APjAAAXdctIQ20dx1e9aaY3g1a3S8wHI3Qx4WQkxfQHmQYJ3h634xkgV
        wFa410gb0+4GvkrvoKglVek5+Z3V+MhNNuNtDNqWJA==
X-Google-Smtp-Source: APXvYqyeuEq2gSOc+7cRmQ3JXWPVf+Vg/s+Z3lauwzYNuwAoQ7GvnDyRunITnqSc64DEV7Pc1JEFhdLOqd3qZnuMv98=
X-Received: by 2002:a81:a18b:: with SMTP id y133mr60559816ywg.64.1555364262035;
 Mon, 15 Apr 2019 14:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190415213506.27472-1-enric.balletbo@collabora.com>
In-Reply-To: <20190415213506.27472-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 15 Apr 2019 14:37:30 -0700
Message-ID: <CABXOdTffnp52t9hz7wE9JYTe5PU4_ovuMN6h7AZzcVu9kbY8qw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: Use cros_ec_cmd_xfer_status
 helper
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 2:35 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> This patch makes use of cros_ec_cmd_xfer_status() instead of
> cros_ec_cmd_xfer() so we can remove some redundant code.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
>  drivers/platform/chrome/cros_ec_debugfs.c | 30 ++++++-----------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index a712508e4646..0bd163723548 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -72,15 +72,9 @@ static void cros_ec_console_log_work(struct work_struct *__work)
>         int buf_space;
>         int ret;
>
> -       ret = cros_ec_cmd_xfer(ec->ec_dev, &snapshot_msg);
> -       if (ret < 0) {
> -               dev_err(ec->dev, "EC communication failed\n");
> -               goto resched;
> -       }
> -       if (snapshot_msg.result != EC_RES_SUCCESS) {
> -               dev_err(ec->dev, "EC failed to snapshot the console log\n");
> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, &snapshot_msg);
> +       if (ret < 0)
>                 goto resched;
> -       }
>
>         /* Loop until we have read everything, or there's an error. */
>         mutex_lock(&debug_info->log_mutex);
> @@ -95,16 +89,10 @@ static void cros_ec_console_log_work(struct work_struct *__work)
>
>                 memset(read_params, '\0', sizeof(*read_params));
>                 read_params->subcmd = CONSOLE_READ_RECENT;
> -               ret = cros_ec_cmd_xfer(ec->ec_dev, debug_info->read_msg);
> -               if (ret < 0) {
> -                       dev_err(ec->dev, "EC communication failed\n");
> -                       break;
> -               }
> -               if (debug_info->read_msg->result != EC_RES_SUCCESS) {
> -                       dev_err(ec->dev,
> -                               "EC failed to read the console log\n");
> +               ret = cros_ec_cmd_xfer_status(ec->ec_dev,
> +                                             debug_info->read_msg);
> +               if (ret < 0)
>                         break;
> -               }
>
>                 /* If the buffer is empty, we're done here. */
>                 if (ret == 0 || ec_buffer[0] == '\0')
> @@ -290,9 +278,8 @@ static int ec_read_version_supported(struct cros_ec_dev *ec)
>         params->cmd = EC_CMD_CONSOLE_READ;
>         response = (struct ec_response_get_cmd_versions *)msg->data;
>
> -       ret = cros_ec_cmd_xfer(ec->ec_dev, msg) >= 0 &&
> -               msg->result == EC_RES_SUCCESS &&
> -               (response->version_mask & EC_VER_MASK(1));
> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg) >= 0 &&
> +             response->version_mask & EC_VER_MASK(1);
>
>         kfree(msg);
>
> @@ -372,9 +359,8 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
>         msg->command = EC_CMD_GET_PANIC_INFO;
>         msg->insize = insize;
>
> -       ret = cros_ec_cmd_xfer(ec_dev, msg);
> +       ret = cros_ec_cmd_xfer_status(ec_dev, msg);
>         if (ret < 0) {
> -               dev_warn(debug_info->ec->dev, "Cannot read panicinfo.\n");
>                 ret = 0;
>                 goto free;
>         }
> --
> 2.20.1
>
