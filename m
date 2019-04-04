Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B1F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRihCIzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfDDQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:00:13 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37859 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:00:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id v84so2333700oif.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKZUuNxE2XJZtIURFNQMaVLPXWArE1bGhRGvq9+Yjsk=;
        b=lRihCIzmEYvDVh/7D3Secm48UdD4EZ2zyNzAEhZxgfwc/NLBuTNV9YVqgnWvgKG5DC
         PGcESvwjTBLG1ECExKz1QcVkZ2o5UtDJZnpEkAKHkFAChUY9lTmT29K3w4ZgLddUvou7
         6+ZUjp+159HWT82yq6/egeHOt6kITdDWJjBySs1axjrtW592jvezJX/I5rP/0w1ErOYY
         /DGxhJ8d+sPNoXFZG3E5QCx7Zne5PkU7K4OrriYn8bKpOVKwuASgN/p73NBYKIsKfh40
         6kGROwpKC/84WNb7LEEbMEViljgH5wDDLMn+P36MD9yABWuDkd/NHbPT/FDY9C3+gUHR
         ykJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKZUuNxE2XJZtIURFNQMaVLPXWArE1bGhRGvq9+Yjsk=;
        b=NPfacrBXcGccY2Ggo/yMvH7z3opYPvEWNbfVPDaPTzVSUahk5sugTbTkAi1A3bDkQk
         w0cMCiL0eoTVaQrgOuj3/Dcgn344ALyW1LjMS6LsyY8UEM5r6QOSK2aD7qoBaWHNaqbR
         HZ7wV+oovn1nannOouiPKtuUO+I2s9RUgdyWey5sKgbJvqYP//m5Fk2doqJpHqGYnq2j
         10iw+vWO9qk4UKc2RUDICN1bvFKyt3covoL/DKgSuM37rUXLsUr7LeVFjFCVCcD8OALz
         UgUEeOukOJ6aUo+mjyVRwQkEKjhWFlSVX/X58i7/phtceJ4Fs3deWWnoG4CFrMT/Q2OE
         RQ4Q==
X-Gm-Message-State: APjAAAUu7Gn0wXxYQZJDtBhveaI95rPgdEHnHu4uuhXsDDfeGN9d/Bb5
        jFfsuL7+cAr/2gwTsUWAEx+iRxwvyAepJ7fhKegIDA==
X-Google-Smtp-Source: APXvYqz9h+vKCqyRQnYKcR3VxUHdHUvReWq1I4PJvPYiwelMLFx20qnH3g3V01Z4IbXoCvFw6o2ZTSrB5LoOttvmzyo=
X-Received: by 2002:aca:3c8a:: with SMTP id j132mr3663926oia.38.1554393612328;
 Thu, 04 Apr 2019 09:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABXOdTeE5=iF24+2JxwjvGtVtFmneYJWC4yXgX1Ah4y+=+ecEg@mail.gmail.com>
 <20190403224036.203632-1-egranata@chromium.org>
In-Reply-To: <20190403224036.203632-1-egranata@chromium.org>
From:   =?UTF-8?Q?Jett_=E2=9C=88_Rink?= <jettrink@google.com>
Date:   Thu, 4 Apr 2019 10:00:00 -0600
Message-ID: <CAK+PMK7cGVy-o_GX_p4asEMSsB9KoNK+x5WdNo2b+pXUFzJZGw@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros_ec: check for NULL transfer function
To:     egranata@chromium.org
Cc:     Guenter Roeck <groeck@google.com>,
        Benson Leung <bleung@chromium.org>, gwendal@chromium.org,
        amstan@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Jett Rink <jettrink@chromium.org>

On Wed, Apr 3, 2019 at 4:40 PM <egranata@chromium.org> wrote:
>
> From: Enrico Granata <egranata@chromium.org>
>
> As new transfer mechanisms are added to the EC codebase, they may
> not support v2 of the EC protocol.
>
> If the v3 initial handshake transfer fails, the kernel will try
> and call cmd_xfer as a fallback. If v2 is not supported, cmd_xfer
> will be NULL, and the code will end up causing a kernel panic.
>
> Add a check for NULL before calling the transfer function, along
> with a helpful comment explaining how one might end up in this
> situation.
>
> Signed-off-by: Enrico Granata <egranata@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 97a068dff192d..55691656a3c27 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -56,6 +56,16 @@ static int send_command(struct cros_ec_device *ec_dev,
>         else
>                 xfer_fxn = ec_dev->cmd_xfer;
>
> +       if (xfer_fxn == NULL) {
> +               /* This error can happen if a communication error happened and
> +                * the EC is trying to use protocol v2, on an underlying
> +                * communication mechanism that does not support v2.
> +                */
> +               dev_err_once(ec_dev->dev,
> +                       "missing EC transfer API, cannot send command\n");
> +               return -EIO;
> +       }
> +
>         ret = (*xfer_fxn)(ec_dev, msg);
>         if (msg->result == EC_RES_IN_PROGRESS) {
>                 int i;
> --
> 2.21.0.392.gf8f6787159e-goog
>
