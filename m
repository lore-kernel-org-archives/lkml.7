Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1031BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5665216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qi8bFNJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK2P4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:56:45 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44620 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfK2P4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:56:44 -0500
Received: by mail-yw1-f68.google.com with SMTP id p128so11105221ywc.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIVjF1a6UBeMBa5jStnnwJLmBmNIBGhSUW6xgbSdn9o=;
        b=Qi8bFNJXs12GbKmWJI0T55gEsd1wU704U2bjjUo0DWc3SvJUMefCjTGMzhNi+dHboO
         lHGyaFSEAnrbu+jcpfpUEAai6H5vuemEjf4TMPqt8E+4p+TT84gUuMRcwQLlBtERec/a
         +7a5Y3Qx/ahjAmP/Y1IZzyncY+9+zinrHlirK1ti20BKmrDCBHOFit4Yh1E4vc1cDj0V
         tBVXupA6jA6W7O8j/K5dCik+bpfihONcVonM48Wli0HC4IDkaMdvjalmp2e2Jx6M5zKF
         I6vXJAWwiBAgb+r34bPYh0wVd1l1LcDpdUfgV+Jku3btSlPiBwvcMmR/Mb5WXzcXd7Vr
         YObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIVjF1a6UBeMBa5jStnnwJLmBmNIBGhSUW6xgbSdn9o=;
        b=tFzxT/8ud2Q+EuKnZ0r4WQr01v6hUKmVCP7ItufiecghECYRCwl4fSjaY5FLPCHGHk
         PzWz2L1I3dR0UlzQ+EehCapuMho2n2ltJ4QIKVku/PyZVbGEmA1vMuKqRj9LEIXlwp2t
         zBbjQT3pU0l8wTvAP2pHS5ZMI4i4vU2HtRyr3FbYa1XLk35Gqtakne1jfppMSiMZpAKD
         DLa/AZtOoWn0fPPhJr8kq8ThpcJIq2soQglzfrjmbJhLbrkGvpdcpNLdh9rJcxcRnqc8
         FmTP+uG7JlDpl3zOeV+6SEDvbX8H4KWpDujD1KtBzxPrpD7uPPt8nNWZwOvRJjPhsM+O
         w3eg==
X-Gm-Message-State: APjAAAXF7cY9efNqpofRkcjyJqb6tQ8jCn7djFozgsAfw6GqpfYTIYUV
        Q3vSP7l83YujyUsT8PM4OHrSwGc154kghe1xSa1U7Q==
X-Google-Smtp-Source: APXvYqwIinbvIW6BD+6alw9KukPZfCKUYfM+lZgWJ+BuPuzAfFoCl/Ei1sdGGrQ95HNToEjGM9cU6hL8jvcBfew8ysY=
X-Received: by 2002:a81:2781:: with SMTP id n123mr12836330ywn.70.1575043001775;
 Fri, 29 Nov 2019 07:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20191129102254.7910-1-enric.balletbo@collabora.com>
In-Reply-To: <20191129102254.7910-1-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 Nov 2019 07:56:30 -0800
Message-ID: <CABXOdTd8b+Lshh_Kf2fjeErrAyQcgZVgLNx3_cpW42Dh8YCN=Q@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Use platform_get_irq_optional()
 for optional IRQs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 2:23 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> As platform_get_irq() now prints an error when the interrupt does not
> exist, use platform_get_irq_optional() to get the IRQ which is optional
> to avoid below error message during probe:
>
>   [    5.113502] cros_ec_lpcs GOOG0004:00: IRQ index 0 not found
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_lpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index dccf479c6625..ffdea7c347f2 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -396,7 +396,7 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>          * Some boards do not have an IRQ allotted for cros_ec_lpc,
>          * which makes ENXIO an expected (and safe) scenario.
>          */
> -       irq = platform_get_irq(pdev, 0);
> +       irq = platform_get_irq_optional(pdev, 0);
>         if (irq > 0)
>                 ec_dev->irq = irq;
>         else if (irq != -ENXIO) {
> --
> 2.20.1
>
