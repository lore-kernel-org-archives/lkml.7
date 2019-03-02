Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A98C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE93820857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 15:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYF8RWQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfCBPrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 10:47:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42221 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCBPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 10:47:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so440448pgl.9;
        Sat, 02 Mar 2019 07:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H5x6yUPDSEfuUmzgNfhpIBJ31W2TdYRTPk6RCnWC0aM=;
        b=XYF8RWQABgPdoz7XTuxY4a8IidQSfdBQrw2Kf1+u8jrVLe/3GIcWxUmE1RNo9fgzP0
         nMym/jw6nHj8Phi5D0bHuLFxOJ5JOqM6f7tq2kGv6BCTB2IoW0lofR89qmw3rmECvEnu
         JNc+/YLARV9ypHS98IpD3E5wuGPwlOfFvsSZXcbuUPhhQ5vt867wsbqpXX8L084sX10o
         yCYZmmCjnIryB3+kS6HARIv8I66w/OiGXoiHGjXBSuuCnMnrdw1vDrXT6dhUx8PM9ZSG
         vmOxGiIXAcEv2HH6B9DA/MxyowOQFhJwJRPpVLK9siHgiMvY3IAGIWeUnPCnIKL04TnN
         I0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H5x6yUPDSEfuUmzgNfhpIBJ31W2TdYRTPk6RCnWC0aM=;
        b=OwQRwqyHz4B+bB0TrBldM5H9DdeOsBEKbAAuI5kNwACVrA/IPGFKgMGjGE7gGubCpp
         cIqhikLI6UfmERXqGucWUAq4W8qubbFiJDtxUMmLEyH3RXUBY3X0CX4rNIgYpeELHePj
         YB+mPU5tals9K1Z+QOjWpf9Z6jgj6P+PXDVBZdMBEIdGQNx0tunvId6H0tN2/weSAHyt
         7IC0byElszwSasHI3BgKf7Gw4NnUv3KTSG3mW7dUxIXDudswT0Qig2p9oGfwM3B1Yd5h
         o+OPsCqSleBDA8ONySTPPMGUqvO5RsZqJPvwcCYUM2vF5BFJ+HDFZP6Ay48Qg/oTTFoc
         KZXg==
X-Gm-Message-State: APjAAAXiKI68YKIz8q6Cp+vU0vz6QevzbWplfBynIrfn6NEnsaLdA7Z1
        tzIiUhAOIdYV5jjqyarFHJqo4SC29zspuMifTd0=
X-Google-Smtp-Source: APXvYqyj6R9ZhVqit4g5CWHmPODnXbUyJ05s+mpbuk1jecWB+PDzpan7jDfh/hb8KZdlkFipQwZihyzImtKQII10Wdw=
X-Received: by 2002:a63:2004:: with SMTP id g4mr10296840pgg.337.1551541655455;
 Sat, 02 Mar 2019 07:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-7-chenyu56@huawei.com>
In-Reply-To: <20190302090505.65542-7-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Mar 2019 17:47:23 +0200
Message-ID: <CAHp75Vd+wPU_QvaWHanpG6hjnUj6==4Y3YiOtZnWpk0kyFUQ4A@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] usb: dwc3: Increase timeout for CmdAct cleared
 by device controller
To:     Yu Chen <chenyu56@huawei.com>
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com,
        Yao Chen <chenyao11@huawei.com>, fangshengzhou@hisilicon.com,
        lipengcheng8@huawei.com, songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, xuyoujun4@huawei.com,
        yudongbin@hisilicon.com, zangleigang@hisilicon.com,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 11:06 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> It needs more time for the device controller to clear the CmdAct of
> DEPCMD on Hisilicon Kirin Soc.
>

5x times more? Can you provide more specific details on that?

> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
>  drivers/usb/dwc3/gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 6c9b76bcc2e1..84d701b37171 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -270,7 +270,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
>  {
>         const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
>         struct dwc3             *dwc = dep->dwc;
> -       u32                     timeout = 1000;
> +       u32                     timeout = 5000;
>         u32                     saved_config = 0;
>         u32                     reg;
>
> --
> 2.15.0-rc2
>


-- 
With Best Regards,
Andy Shevchenko
