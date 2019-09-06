Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2876C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B45206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqTvZMOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbfIFM1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:27:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40652 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403993AbfIFM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:27:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so5804804ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voMncQMQ4YdYJSbQPybIZCy/AcK0j9pgJUBzJv0XJ0A=;
        b=sqTvZMOg0FK+tbQ5Twd8lIUIdl5cRw7f3mUvyMcKovHkLwtCNr+KhR8ryq4wVIDwmE
         MrBFX2gvgSY3HU2O7p/fa3kIFtwabChkkv1UJeIL2HzkjG5QPDhFYHq8EkK3B24Bgydv
         Fi2qkSQYUx9TdJxWg4stgkl9/pi/wDuDnFFyyRBx/kMYn9jJS/zdvJSGTuo1h2Temozf
         Nvf/Hnfjf2PuJ6a6jToQHWZwxuQcOEfdbQhKzPmea0lJsU/ZNqvBUb+imGx19W9r0HCK
         Hyvu0+zXQQzELhka7MTfPB6km6DSDMOt5IvIpqPyjyiI/acvmccpl7me4YJqAOCRVfA5
         PFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voMncQMQ4YdYJSbQPybIZCy/AcK0j9pgJUBzJv0XJ0A=;
        b=fdyinHi4RT1h+axEEgCnHjUM8u0ggEZctV89BXyqKth1uwPxoHib5HwUl5Z8Ccj3Zb
         4rbaZGngK83HSJNKdtnf4n8oGaY93qpB+aZQKtYCiOS4OsZ6E/9uZrtCd6Z2V+zglBMC
         7s7K2m/09wmntEfGkhvzAC79DpQqrUsABpzfHcDsqZJUHlS4facrZXQn6BnlHFx0KezW
         X28WaJCcLaa9rrgXYS/3SCQKAzhJbp7as+wkAD3jy0Ab650yIBArBrodvoVaFWjMdXak
         zQHrWn0VJ4RXo6jrtAXdgciYLHcJ9Awv4+a0EtBbMLnvjWkRl8CJlgXCYTPB3l990OKx
         tFNw==
X-Gm-Message-State: APjAAAVWDw9DbeVW4LiVrqNiHbmqgc+McTusq/3onzgkKjRQC+XI+9Rs
        1Cb1fivz84Yy5rYrznbI+4q2Q34Hf6YaOzxyUac=
X-Google-Smtp-Source: APXvYqyqVi6A3SK9ZHo9Lzs4psldtYUrV3ugRoL85TI5Orqgiv42bAur5gdeHYcDQujEI1t/u7SSENxNihK+5Pwaths=
X-Received: by 2002:a2e:9602:: with SMTP id v2mr5657222ljh.215.1567772850472;
 Fri, 06 Sep 2019 05:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 6 Sep 2019 17:57:19 +0530
Message-ID: <CAFqt6zYkFk55gzmfwMFzpWiOp0xP3DXdmWyO2Ce8+mqYW12SNw@mail.gmail.com>
Subject: Re: [PATCH v2] swiotlb-xen: Convert to use macro
To:     konrad.wilk@oracle.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 2:04 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Rather than using static int max_dma_bits, this
> can be coverted to use as macro.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

If it is still not late, can we get this patch in queue for 5.4 ?

> ---
>  drivers/xen/swiotlb-xen.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index ae1df49..d1eced5 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -38,6 +38,7 @@
>  #include <asm/xen/page-coherent.h>
>
>  #include <trace/events/swiotlb.h>
> +#define MAX_DMA_BITS 32
>  /*
>   * Used to do a quick range check in swiotlb_tbl_unmap_single and
>   * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
> @@ -114,8 +115,6 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
>         return 0;
>  }
>
> -static int max_dma_bits = 32;
> -
>  static int
>  xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
>  {
> @@ -135,7 +134,7 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
>                                 p + (i << IO_TLB_SHIFT),
>                                 get_order(slabs << IO_TLB_SHIFT),
>                                 dma_bits, &dma_handle);
> -               } while (rc && dma_bits++ < max_dma_bits);
> +               } while (rc && dma_bits++ < MAX_DMA_BITS);
>                 if (rc)
>                         return rc;
>
> --
> 1.9.1
>
