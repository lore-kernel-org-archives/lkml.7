Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2269BC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BE02075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJTIq76U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfI3Vf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:35:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43479 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfI3VfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:35:25 -0400
Received: by mail-io1-f65.google.com with SMTP id v2so42215937iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5l+n2rw/iAlqfIRxbZZeFy6DYtAwztBk8k/LJBt7oE8=;
        b=bJTIq76UANeq3zxz1NT4vFNcGC1oVXaZtF7S8x6HgJyDLCgRYDzz5c88Qv/omqOG5f
         cOeKqWKbkd02ZUThbCe3A4aO/IZCJNqafo6/DoxsIQgdho+/6t05W6F7l23nB2qSEjv3
         Who5JsO3zs1gw9OyojdLC/aeK7NfZZq6jKbvsiEUVDYz7eatGoSl6vbO6Z7mL6TMDwYu
         F//sviWkyXOtVbnYJfg6WSpK48M4m3C9SjOh9TZp2vR7Cb42TUS3CQo5/CjidK1Rkoqn
         Nj2/IryA3j2VhqtGo+AUHQE5edmWEVBeiDFfe3dZMArTum2CobOQZ+yK9WQJzVne9UXf
         xBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5l+n2rw/iAlqfIRxbZZeFy6DYtAwztBk8k/LJBt7oE8=;
        b=nC6OLdBgMkl+fIl9RHQuttVRre22X1ZeLBx6VAKgYVOqzasBzOzZT+j7EMT5ulInOR
         ppWQRr7acSU33Mw881eIWpeSKlM5obMSgt+0XYJpxEROMsJ09bFuZRgcVtqRsI2+aA9G
         cqOHA7mFA7tXnVplHjw2Ys5zx0TcWY5w/vlXwfFrDyxU9+Pd+ML2EUFkthCyoAerWo94
         idVLqTK+20ginNNiLN8FjijTZ94IK/LwUzmVa6pPT7Zvkut6igeW/Ya490vy0jpfztI8
         0gC5wwQm7A08J1oQtjY92h9w56LTL4h/LNYjAn/TJCOMOHRKd19bk4rJ1emqQg8iK3qb
         6nqQ==
X-Gm-Message-State: APjAAAXCQORCymTErTTAirB5BmdAYaRenP/z2zfZSPY1nakLFHt3Wevn
        z4FwNAV2Dq5ehCbsKueqnzttDB1tg9Wd+jpuUL5WvQY9
X-Google-Smtp-Source: APXvYqz1tiK1Mxs3XfkgoniEC/dVCuoTbK/zeberVMZesyTKbgE8Rvrf6VbiQHdPCYTWFzQmSDeN8oktc8Q6CO/4N+k=
X-Received: by 2002:a02:ac82:: with SMTP id x2mr21524721jan.34.1569879324942;
 Mon, 30 Sep 2019 14:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190920025137.29407-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190920025137.29407-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon, 30 Sep 2019 16:35:14 -0500
Message-ID: <CAEkB2EQJDdE=0HDzL14WDHHuwuaNNjSXEGVm1p7MBopyDvzTzQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: fix multiple memory leaks on error path
To:     Colin Ian King <colin.king@canonical.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, kjlu@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you take a look at this patch and confirm it, please?

On Thu, Sep 19, 2019 at 9:51 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In rtl8192_tx on error handling path allocated urbs and also skb should
> be released.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index fe1f279ca368..b62b03802b1b 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1422,7 +1422,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>                 (struct tx_fwinfo_819x_usb *)(skb->data + USB_HWDESC_HEADER_LEN);
>         struct usb_device *udev = priv->udev;
>         int pend;
> -       int status;
> +       int status, rt = -1;
>         struct urb *tx_urb = NULL, *tx_urb_zero = NULL;
>         unsigned int idx_pipe;
>
> @@ -1566,8 +1566,10 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>                 }
>                 if (bSend0Byte) {
>                         tx_urb_zero = usb_alloc_urb(0, GFP_ATOMIC);
> -                       if (!tx_urb_zero)
> -                               return -ENOMEM;
> +                       if (!tx_urb_zero) {
> +                               rt = -ENOMEM;
> +                               goto error;
> +                       }
>                         usb_fill_bulk_urb(tx_urb_zero, udev,
>                                           usb_sndbulkpipe(udev, idx_pipe),
>                                           &zero, 0, tx_zero_isr, dev);
> @@ -1577,7 +1579,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>                                          "Error TX URB for zero byte %d, error %d",
>                                          atomic_read(&priv->tx_pending[tcb_desc->queue_index]),
>                                          status);
> -                               return -1;
> +                               goto error;
>                         }
>                 }
>                 netif_trans_update(dev);
> @@ -1588,7 +1590,12 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
>         RT_TRACE(COMP_ERR, "Error TX URB %d, error %d",
>                  atomic_read(&priv->tx_pending[tcb_desc->queue_index]),
>                  status);
> -       return -1;
> +
> +error:
> +       dev_kfree_skb_any(skb);
> +       usb_free_urb(tx_urb);
> +       usb_free_urb(tx_urb_zero);
> +       return rt;
>  }
>
>  static short rtl8192_usb_initendpoints(struct net_device *dev)
> --
> 2.17.1
>


-- 
Navid.
