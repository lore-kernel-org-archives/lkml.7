Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4366AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B312087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkLIWjLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfDHPT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:19:26 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39328 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfDHPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:19:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id z9so5057548ywd.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seLIeujnJ/97W6aKuEt/5fGzufr2q1aYL8/2sgWfl4s=;
        b=qkLIWjLNxIxeuArJU220WQ8rBC1HFeYyPGukVk7UmKIcdEQPzgu93DQnw07qzE2+M3
         No5cBWwlUXU4eFt6MuI2mGsxhSZYKo8O1V/kgFf8LlEvprgOMTsKsASm9vMv6CBM33gY
         uMBq7HLhlpUPapssTXIh3Y6c/WVZqrWK5Wo2X9CqqeqUr4GtacoKx3bsyYgZgkJySg2G
         KaBdeJsV6T0OCBkQ6J7p+B7hHv8Fdj+I1160qIlSE458awNwrioFu5MArgRGXiuY+/zL
         tiX0bjl6RBFt94xitEQKjxn6TsZgDBHmpt67B74GogrsYtjZd8RzYVicZ797mmd1GjHn
         5qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seLIeujnJ/97W6aKuEt/5fGzufr2q1aYL8/2sgWfl4s=;
        b=RVH/8pAAD8Jbb3GiEg1y7dK4UogiFLMyYwyCiPTskC7dehbg/XbLtMYEVY37Kqwopj
         jwU3j6UC9pqLGq9kHnEz0dhEPA4g9tfZHA3SIXelfMH4Y2iZELRXutY0CRWkFVNKqrnF
         gcKHu9puGMvgAtnuS6bOaiveMefkqxaa10Ls5VhINhMl2KhURCrkhpI/txJ7LZWov3cZ
         QTR2AoHT4Ma4vlwi0IMPubZjrwNr9dYKP+8yU/b8y2cdH3a8NUCLEHMal/i7uPlv2uV1
         8Y82bVoNY9gh+EwYB4QROOhI8we4P6l+hCM/RY9LoQ4U71zMphxk8jWi33GCrdMNfcOP
         auGQ==
X-Gm-Message-State: APjAAAWxYCVB3x0ALmSkww/7L2keTUo6jEmRhqgss7cD6qZ4fnLCSZWM
        7wJiZ8o49EhqR6F3xWGRLxkyo1OL5BnM3P+QSt/GCQ==
X-Google-Smtp-Source: APXvYqx9TqqqUhagp0wym2mapptAadf0l8uwN8A2Jv2Pju5M4RuCxwa8np0YaBapP1559sZXzCE3+5s7+bECX7wNYOk=
X-Received: by 2002:a0d:e403:: with SMTP id n3mr24801131ywe.408.1554736764989;
 Mon, 08 Apr 2019 08:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190408150538.8115-1-enric.balletbo@collabora.com>
In-Reply-To: <20190408150538.8115-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 8 Apr 2019 08:18:42 -0700
Message-ID: <CABXOdTc8+6azVQ_MR91hrYoN_nKnY-o66hB8vpiz28P8_D3Vuw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: no need to check return
 value of debugfs_create functions
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        twawrzynczak@chromium.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 8:05 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>
>  drivers/platform/chrome/cros_ec_debugfs.c | 35 ++++-------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index f0de1991b688..a712508e4646 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -337,12 +337,8 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
>         mutex_init(&debug_info->log_mutex);
>         init_waitqueue_head(&debug_info->log_wq);
>
> -       if (!debugfs_create_file("console_log",
> -                                S_IFREG | 0444,
> -                                debug_info->dir,
> -                                debug_info,
> -                                &cros_ec_console_log_fops))
> -               return -ENOMEM;
> +       debugfs_create_file("console_log", S_IFREG | 0444, debug_info->dir,
> +                           debug_info, &cros_ec_console_log_fops);
>
>         INIT_DELAYED_WORK(&debug_info->log_poll_work,
>                           cros_ec_console_log_work);
> @@ -390,13 +386,8 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
>         debug_info->panicinfo_blob.data = msg->data;
>         debug_info->panicinfo_blob.size = ret;
>
> -       if (!debugfs_create_blob("panicinfo",
> -                                S_IFREG | 0444,
> -                                debug_info->dir,
> -                                &debug_info->panicinfo_blob)) {
> -               ret = -ENOMEM;
> -               goto free;
> -       }
> +       debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
> +                           &debug_info->panicinfo_blob);
>
>         return 0;
>
> @@ -405,15 +396,6 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
>         return ret;
>  }
>
> -static int cros_ec_create_pdinfo(struct cros_ec_debugfs *debug_info)
> -{
> -       if (!debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
> -                                &cros_ec_pdinfo_fops))
> -               return -ENOMEM;
> -
> -       return 0;
> -}
> -
>  static int cros_ec_debugfs_probe(struct platform_device *pd)
>  {
>         struct cros_ec_dev *ec = dev_get_drvdata(pd->dev.parent);
> @@ -428,8 +410,6 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>
>         debug_info->ec = ec;
>         debug_info->dir = debugfs_create_dir(name, NULL);
> -       if (!debug_info->dir)
> -               return -ENOMEM;
>
>         ret = cros_ec_create_panicinfo(debug_info);
>         if (ret)
> @@ -439,9 +419,8 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>         if (ret)
>                 goto remove_debugfs;
>
> -       ret = cros_ec_create_pdinfo(debug_info);
> -       if (ret)
> -               goto remove_log;
> +       debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
> +                           &cros_ec_pdinfo_fops);
>
>         ec->debug_info = debug_info;
>
> @@ -449,8 +428,6 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>
>         return 0;
>
> -remove_log:
> -       cros_ec_cleanup_console_log(debug_info);
>  remove_debugfs:
>         debugfs_remove_recursive(debug_info->dir);
>         return ret;
> --
> 2.20.1
>
