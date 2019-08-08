Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726CC214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoyThrHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403937AbfHHOM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:12:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39614 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403797AbfHHOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:12:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id u3so63100122vsh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6O0K0Lbnp4hA0AJPB0Knf0/Gqi93FxhoE5wp3HoaE0=;
        b=OoyThrHNHWSiQ2llrUFoT/+F6P++B3XNStkFuyZCAo4LzRZPqx505VtlW/Yybsuw2y
         0hRKq5rAOuYiOiKK2sm4nzPupAIIhQbbPKVP/xK2r/JDkwRotrfRn+lYZLAijjeCs4vL
         Nq9yxZiBrSP3acR/7iCX5KMrvNgaAZEQ/WPmMEwMjEK4Bl9shfsg/LG6Ex34KM2MiSnT
         5aKk543EBaWIh95X+tQpEFpipexilcO+1KEveDXDTR9eFMsefK6eUGrGRO+B+BRCZK8k
         UxwPJsjOCaFZIgW/LfntNyytKp1sEQJKnW4fiVd4c8hyMcpC002LNvuV5Z00/fv99muY
         Q7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6O0K0Lbnp4hA0AJPB0Knf0/Gqi93FxhoE5wp3HoaE0=;
        b=QKJ3aFRD2zielGCRl2EjcPKmgOoAN0kNjRJIc7issL9e104yBFgZmlvv24emfCJ1Vg
         TH0ZzK7TXO2RBYH8DAKBPVg3otvobSa5qruvjMXnGFFf1m20goSxugJTFh4y9LsjAV3d
         OtZ4ol4OuvRGmSWKRXElekuKs8Sm/8CI5T35Hq7qseuxtNQuSfzd1b13mrGmGJSSGnHY
         zZO3gslEfP2PSuOqpKHtxZw8BOAK+q5xC7Yciow35NvQD6+YICcUac0hwMlpMWC37e4E
         FR4m+1exQwpI1K/zAvb7g36DsO71tVgPm+vcyh1rY8VDNodgGLN3VUpLoIsYvibPTrgE
         75kw==
X-Gm-Message-State: APjAAAWxsn7J9tQJul3hVamOLMDiv+Vpw93cF3oiL31enkgFX3VozBvH
        vD5LfLfFc2/0bQRjXaElYf8oxahoa1M5HANot/mdXg==
X-Google-Smtp-Source: APXvYqzFM50V9Og3uLNsu+nyXdq5vyM3ZXqqtx4NOpbK5Y1y+kgRagpUs9tUh6+3XYi/f/0m9U33eEGw5XRPcLQhcow=
X-Received: by 2002:a67:e3d5:: with SMTP id k21mr9505435vsm.172.1565273544734;
 Thu, 08 Aug 2019 07:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190808122956.12789-1-ttayar@habana.ai>
In-Reply-To: <20190808122956.12789-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 8 Aug 2019 17:11:58 +0300
Message-ID: <CAFCwf13hN7TUWcdCf7d-6AumoQjHTVVHOSdDzeaznXmTogZ8Gg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Handle HW_IP_INFO if device disabled or in reset
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 8, 2019 at 3:30 PM Tomer Tayar <ttayar@habana.ai> wrote:
>
> The HW IP information is relevant even if the device is disabled or in
> reset, so always handle the corresponding INFO IOCTL opcode.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/habanalabs_ioctl.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
> index 3ce65459b01c..589324ac19d0 100644
> --- a/drivers/misc/habanalabs/habanalabs_ioctl.c
> +++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
> @@ -204,10 +204,21 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
>         struct hl_device *hdev = hpriv->hdev;
>         int rc;
>
> -       /* We want to return device status even if it disabled or in reset */
> -       if (args->op == HL_INFO_DEVICE_STATUS)
> +       /*
> +        * Information is returned for the following opcodes even if the device
> +        * is disabled or in reset.
> +        */
> +       switch (args->op) {
> +       case HL_INFO_HW_IP_INFO:
> +               return hw_ip_info(hdev, args);
> +
> +       case HL_INFO_DEVICE_STATUS:
>                 return device_status_info(hdev, args);
>
> +       default:
> +               break;
> +       }
> +
>         if (hl_device_disabled_or_in_reset(hdev)) {
>                 dev_warn_ratelimited(dev,
>                         "Device is %s. Can't execute INFO IOCTL\n",
> @@ -216,10 +227,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
>         }
>
>         switch (args->op) {
> -       case HL_INFO_HW_IP_INFO:
> -               rc = hw_ip_info(hdev, args);
> -               break;
> -
>         case HL_INFO_HW_EVENTS:
>                 rc = hw_events_info(hdev, args);
>                 break;
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
