Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7220663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tK3d0A+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCQYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:24:06 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:45461 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:24:05 -0400
Received: by mail-yb1-f195.google.com with SMTP id b18so6427308yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+U6MGH1YJJ39uI2yfqcw9B9OS2tBB3klG3IML0XpjoU=;
        b=tK3d0A+sI/AhCemvdOtCJ1zj5Oo/m6RUmdSv5wa4zeM5MZe1bxaspGAH18KglpVKWi
         Foguz3lFT96P6R/nBANawsOq6TujolookGtgY9tF4ooaUlw067owVf3EKu/veCpkyYjY
         uhJ23Z1fxeKiO2g/SOKr4kxPOWsC1+NzzGKMYDq+gXPFnAub4aGI7jJgLphSMMz7pHWu
         fXOdo4j3uHQRNbUiOWKhffU/44kUGotNFJPLM81KTNTV4pBQN0fBrkazoRk/Gz9dtXTS
         qEtpTckjV8zxsP34q6feU7FMhqKYOXzHOkJUKxIILGGG8vwdxOoiu23VC2qZRK90PDev
         9PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+U6MGH1YJJ39uI2yfqcw9B9OS2tBB3klG3IML0XpjoU=;
        b=itHcNBxVOvLx1066DyZ1qekBJFDPIf79Mqt1WTHa91+1guP3s0e9ecNycpRXhtE+Ti
         bjHkluhO4LWZ/1bM249z/s0b7+aH0PpwnWUiNm0CdeEeS2X8/ZRXtz8FCUUJe15S/t5r
         CJ1o2GaHu9iQm7KH3L2oeEQcEZWh1An+Lif7idI6FdYe6A0w4h/UZQ8r0hsNxSTgWgFP
         5w+OC/RyscJ/NgiFWo9BnUPoFrFzT/d26rtBOQ4+0TP2ySpxJktPmBVxDfvD53NgU0Vb
         VKACf1vKub9wPvz07RaRiUK79iyLQnesfZmAf6kjP+vZvuqdDFrUnIIeuppJNFB7XqsG
         VRdA==
X-Gm-Message-State: APjAAAUuUb/sUcH7h611ZJjysIpkOHqXGISGNiQLy0xPUpKa/zqow6gC
        k1H6KObQhwIjQ67pL7qR6kqqosip64FiQNTlx3gTMg==
X-Google-Smtp-Source: APXvYqyMQjEiDSYq+QWK6uFBo/EMEXof5U2Yadyc8cmmgAA+VpArThy2cdZ0rhVKXmKYz6jdKJOR3qB0dP4IFhLJypA=
X-Received: by 2002:a5b:5ca:: with SMTP id w10mr781004ybp.133.1554308644842;
 Wed, 03 Apr 2019 09:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190403134718.6874-1-enric.balletbo@collabora.com>
In-Reply-To: <20190403134718.6874-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 3 Apr 2019 09:23:53 -0700
Message-ID: <CABXOdTfV2n594=xmrL+zW3fDRLG1=pTW-JFUJZoMmp9Pc7NFrA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: Remove dev_warn when
 console log is not supported
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

On Wed, Apr 3, 2019 at 6:47 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> If the debugfs interface is enabled, every time a CrOS device is
> instantiated a warning like this can appear for every probed device.
>
>  "device does not support reading the console log"
>
> The warning message adds nothing, rather it is source of confusion as
> this is expected on some cases. For example, on Samus, that has a
> cros-ec and a cros-pd instance the message appears twice, and I suspect
> this will happen also on those devices that has a non-standard EC.
>
> If the command is not supported just return silently and don't print the
> warning, otherwise the code will already print an error.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_debugfs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 71308766e891..f0de1991b688 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -306,11 +306,12 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
>         int read_params_size;
>         int read_response_size;
>
> -       if (!ec_read_version_supported(ec)) {
> -               dev_warn(ec->dev,
> -                       "device does not support reading the console log\n");
> +       /*
> +        * If the console log feature is not supported return silently and
> +        * don't create the console_log entry.
> +        */
> +       if (!ec_read_version_supported(ec))
>                 return 0;
> -       }
>
>         buf = devm_kzalloc(ec->dev, LOG_SIZE, GFP_KERNEL);
>         if (!buf)
> --
> 2.20.1
>
