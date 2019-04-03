Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B70C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86A32133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mw3u0+xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDCSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:51:17 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46635 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:51:17 -0400
Received: by mail-yw1-f68.google.com with SMTP id v127so6298070ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfNEHNjY605qQjhYPcj4LI28R/YU9XBILkyg9b+w2eY=;
        b=mw3u0+xMlu981r0QvR0dhOsRLISQi3Kbft/8ppnT0jM2owhg7C+Ya6BTyarXRdGq1k
         UgY4BRkE4u9nUjSYGJ52pkBvkGYXlRJorDiywUInPc0vKRe43Lth0Ta/i2hr/gg+vdct
         XmORA85tVxiUW0opUsHB5i0bwyInhqlnN7sqBFkBjhEGgV/pmSMXwEdXwoXzKdk8IoV9
         mVmSUgUFx/kkHk+PHonfOI/75v3Mf3tiPu/BixA1ge7eG94NGB0/NsEj6U9UZUCLQNFd
         gNNdGisblpzwtGFoHkkbc59qRRWLqzdRq0HfBbXOAvIgFb/f1wEm+9l/Dpin5OQJOure
         r1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfNEHNjY605qQjhYPcj4LI28R/YU9XBILkyg9b+w2eY=;
        b=ghyk3DoxLszYtddyuhD0A+WFBfcMR1rdEyaNVX49Q0sFeO1A9ZdFX2eGOVyUfkyPYr
         w48qgAo/kIpNdJ6ZlG47CWyUljV+7mqYK2j0MFsNofbn0ixKmDMPQOgtRYlHN6dRqcuf
         bqpuBKgSY0uTwMEkx+vEclPA5sJYXBmj/fKcReuSdme2QxoGD+jeKIsYWkUbbrvE8yMP
         b2Pw2U3AVdVoD2tLQ/B7OC6gFNmpWLYIzTYv7ekBR1PsQF0oPXKrIUBARImKH/wd7/uM
         cTFPzA2RGFffqL4s/4rWii1nFemMEFPwyRaJPeCtWibuTslIpS72TnJlpVQVffXlXqAQ
         Gp9A==
X-Gm-Message-State: APjAAAWC+Fq+FA7pMku+Rs8AvGZKpxJVy8U66fVrr+jujUkrAfaaln8y
        Z+yhZF1Cqjuv5zHUZSUgmTMHdSDClXbshOoeY+THaQ==
X-Google-Smtp-Source: APXvYqyXNJ3Gxz3q5/I66Q0IFKNxk6Nu68DmuXc75XNpDxFNqULd62cazkN+/TWPAgzFS9xHKhpHflUlFI1yP0GNmbI=
X-Received: by 2002:a81:a18b:: with SMTP id y133mr941254ywg.64.1554317475839;
 Wed, 03 Apr 2019 11:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403183048.56750-1-egranata@chromium.org>
In-Reply-To: <20190403183048.56750-1-egranata@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 3 Apr 2019 11:51:03 -0700
Message-ID: <CABXOdTfvRryiMrFAe4wmvt5mm2k==b1BShbzHQ68vp5C3NFETA@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros_ec: check for NULL transfer function
To:     egranata@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 11:31 AM <egranata@chromium.org> wrote:
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
> index 97a068dff192d..953076ab401aa 100644
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

I am not personally a friend of networking-style multi-line comments.

> +               dev_err(ec_dev->dev,
> +                       "missing EC transfer API, cannot send command\n");

That message will be displayed each time a message is sent, ie in
practice for each message. Is there any value in that, other than
clogging the log ?

Guenter

> +               return -EIO;
> +       }
> +
>         ret = (*xfer_fxn)(ec_dev, msg);
>         if (msg->result == EC_RES_IN_PROGRESS) {
>                 int i;
> --
> 2.21.0.392.gf8f6787159e-goog
>
