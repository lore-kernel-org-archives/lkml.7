Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723E2C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499A72070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="p97UEoNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387860AbfG2LxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:53:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46110 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387482AbfG2Lw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:52:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id z23so33874233ote.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPGf0kPbvhe2HXNESzGCCBqYTl2vqafsajjrV11C25I=;
        b=p97UEoNg/4v5WyEnvrg6cBEmCngBnKeqFcpQlsDLMsJijmNXQOucbWp+t+TFovLOXZ
         qgqyVce9UCFzNi2sjQ7Zt9gV2tetGlakx45j63Mpcia5m09PM9omEz3/9LkbQmwePBL0
         VIF48g2yFADHWzzsSYLAgHOgCSTVNqoVcqaUU6txNjq6wdlFeZykRdbr6oFPL8FaU8+N
         dThYCT69kkPPeOrsWEGninxKcQ497ZwrJyIUU11P2AOJnQotM+PNQmu/63YJNzXRZwdv
         GLIEsRZvBtfJbs0do5wKLVvnCcRT1tm49qlpeRTJckOuQf8JWRg21d6AaUqUz4mY25if
         ZdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPGf0kPbvhe2HXNESzGCCBqYTl2vqafsajjrV11C25I=;
        b=s8ltYE/piqn903wCEAmKJIlWp026hMSIXRnR3ojuCjB2WtuiHwsPiR8j+tGuHY22Bl
         C53s1CdB4SdpPF/APwNjQ9ojTuOR4Po097bDDM2reFl9vvYcH6tuZr4cur0qzxJrJrao
         j9K9A7LtJvRCrVZe2KvOdmQryAsvjsHfhhWaG+BspjhqvZJTITY/K4m4+2p/5fdkm0G8
         e0/rSvXpMzKgjaO2WvZprObcg+IDKjWwXtCazSmKeCuqdS/TpPDRHqt0Nw623dxFeBnj
         NkEKU4UU4P1Dv2VCDFs+ptLbtve0xgMkeGrAhXHSJVuS935hNcu7o82IPJy0S1BrjBdo
         Zumg==
X-Gm-Message-State: APjAAAUTfjALc3xoww9yZvn646eCVvBcaAKK2jv6CSIv9QEy9n9KJfps
        MUJKPzCjWFNV2tcRxjc1JuMCCwCOmNTyDupGOW0IAw==
X-Google-Smtp-Source: APXvYqyS81a5YCskF+EiZflTcgNqYeRMHdvCBcOv1gxPheP1eba17RzCLqIog5cAcS4IbQhdIPt/ugH4upY8MEazw/A=
X-Received: by 2002:a9d:48f:: with SMTP id 15mr49061044otm.160.1564401178640;
 Mon, 29 Jul 2019 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190726133916.26186-1-hslester96@gmail.com>
In-Reply-To: <20190726133916.26186-1-hslester96@gmail.com>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Mon, 29 Jul 2019 13:52:47 +0200
Message-ID: <CAKKE0ZFgdiViNiHD2KXvJAW4MB+0T2BM0-k+2UYWubTRHN9Sww@mail.gmail.com>
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration API
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:39 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Reviewed-by: Patrick Havelange <patrick.havelange@essensium.com>

Maybe a bit too late, sorry for that. Thanks for the patch.

Patrick H.

> ---
> Changes in v2:
>   - Use devm_add_action_or_reset to keep
>     resource release order.
>   - remove() function is redundant now,
>     delete it.
>
>  drivers/counter/ftm-quaddec.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..4046aa9f9234 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -100,16 +100,18 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
>         ftm_set_write_protection(ftm);
>  }
>
> -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> +static void ftm_quaddec_disable(void *ftm)
>  {
> -       ftm_clear_write_protection(ftm);
> -       ftm_write(ftm, FTM_MODE, 0);
> -       ftm_write(ftm, FTM_QDCTRL, 0);
> +       struct ftm_quaddec *ftm_qua = ftm;
> +
> +       ftm_clear_write_protection(ftm_qua);
> +       ftm_write(ftm_qua, FTM_MODE, 0);
> +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
>         /*
>          * This is enough to disable the counter. No clock has been
>          * selected by writing to FTM_SC in init()
>          */
> -       ftm_set_write_protection(ftm);
> +       ftm_set_write_protection(ftm_qua);
>  }
>
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> @@ -317,20 +319,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>
>         ftm_quaddec_init(ftm);
>
> -       ret = counter_register(&ftm->counter);
> +       ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
>         if (ret)
> -               ftm_quaddec_disable(ftm);
> -
> -       return ret;
> -}
> +               return ret;
>
> -static int ftm_quaddec_remove(struct platform_device *pdev)
> -{
> -       struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> -
> -       counter_unregister(&ftm->counter);
> -
> -       ftm_quaddec_disable(ftm);
> +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
> +       if (ret)
> +               return ret;
>
>         return 0;
>  }
> @@ -346,7 +341,6 @@ static struct platform_driver ftm_quaddec_driver = {
>                 .of_match_table = ftm_quaddec_match,
>         },
>         .probe = ftm_quaddec_probe,
> -       .remove = ftm_quaddec_remove,
>  };
>
>  module_platform_driver(ftm_quaddec_driver);
> --
> 2.20.1
>
