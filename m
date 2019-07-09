Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FC0C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F0821537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrZHEjNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGIGIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:08:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43671 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIGIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:08:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so18278501ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 23:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDoNVvD7C6FVcsC+DxIkAkGU9HfgXYwnu4pCiukVnKg=;
        b=OrZHEjNOCtylYw84fC1KfxMdEzFsbZSw7fZg5zCvFhhJuUaGWEnLR27vQDCRcRwgaT
         9GyynzHzhdcKF9exXfKzTxPRivGNDDjDGrbHHWgqDp0fBCifMmRFsbrgAx/c4xtRvn0J
         i8nkczgxvAyBDj03wVyc96CnFZlm5En3admqzyz7Hseb3/h4PHpol8Yl8kB49PVpCafb
         b8tmwfctMyTprU7brLnvzEAdL9ma9n/Ks1xhjt4RAsVDju+0399Q/LtE1JOFHM7Y6W3H
         KfrxBZlKJRxcFS1uhvFnMjeWPr5e1nOQtbSgLJxuDN7/aIoAIUdA/esya9g2+p8ppoAH
         Iulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDoNVvD7C6FVcsC+DxIkAkGU9HfgXYwnu4pCiukVnKg=;
        b=LB5GXv17D80EQfU8fuOoBCI24br5JDQswFVKRwuCI6VJZtYX/0VqOrZA5UdtcqmmOw
         GHCqv6z14W039fcHbBsvTCiGoFJcOGP3FPGI+/yRDXBmmbvVyqa3Ujr0UiezdIY6RlMb
         7pEL7TPvOxgREHaKSpS/sNaSqr4OzKqCYYZPJwvuvx0YcUq8H4SCHa8HW+nKVph9pYio
         7SXQksqKLnSDnf6X0W6bOlzldGlwuAncqf/BYbI3Ey1y6h8YcyXUSQQsFUHj2bcSZ7RQ
         NiQzWzgKu/wvinGGSwEh8Ohk3lgMXZQkkvXmt6VGn7VcVcl9rt9nFfPhksClgXvqN4gv
         kxxQ==
X-Gm-Message-State: APjAAAUaw7M/rd66eLVzl/WOhkvezhjk/FyzfgH7MnAkMBgZjrKo4XHX
        Qm2xNMGcqg0FDqZ0yoqURkp54AB5dSJ1Sa5hWVU=
X-Google-Smtp-Source: APXvYqw7hzD5rcX0X5fJY2QJLnYDxenhwuSWFlNbLQLOvrGptJ4aoCEzYA8ep7K7I8g3JFw2VbutLGsDMzyoEzAhBUE=
X-Received: by 2002:a2e:92c6:: with SMTP id k6mr12837360ljh.148.1562652484113;
 Mon, 08 Jul 2019 23:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190708123952.3341920-1-arnd@arndb.de>
In-Reply-To: <20190708123952.3341920-1-arnd@arndb.de>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 9 Jul 2019 09:07:37 +0300
Message-ID: <CAFCwf12rQ8Rgr37qPOrN7k0Ru+_jJk-XnXEOGi4Vhp0S8iZB+Q@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use %pad for printing a dma_addr_t
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tomer Tayar <ttayar@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 3:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> dma_addr_t might be different sizes depending on the configuration,
> so we cannot print it as %llx:
>
> drivers/misc/habanalabs/goya/goya.c: In function 'goya_sw_init':
> drivers/misc/habanalabs/goya/goya.c:698:21: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
>
> Use the special %pad format string. This requires passing the
> argument by reference.
>
> Fixes: 2a51558c8c7f ("habanalabs: remove DMA mask hack for Goya")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/misc/habanalabs/goya/goya.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
> index 75294ec65257..60e509f64051 100644
> --- a/drivers/misc/habanalabs/goya/goya.c
> +++ b/drivers/misc/habanalabs/goya/goya.c
> @@ -695,8 +695,8 @@ static int goya_sw_init(struct hl_device *hdev)
>                 goto free_dma_pool;
>         }
>
> -       dev_dbg(hdev->dev, "cpu accessible memory at bus address 0x%llx\n",
> -               hdev->cpu_accessible_dma_address);
> +       dev_dbg(hdev->dev, "cpu accessible memory at bus address %pad\n",
> +               &hdev->cpu_accessible_dma_address);
>
>         hdev->cpu_accessible_dma_pool = gen_pool_create(ilog2(32), -1);
>         if (!hdev->cpu_accessible_dma_pool) {
> --
> 2.20.0
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

Thanks! applied to -next
