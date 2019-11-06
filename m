Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4F1C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A6821882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjFJBlz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfKFIyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:54:44 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39969 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfKFIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:54:44 -0500
Received: by mail-pl1-f196.google.com with SMTP id e3so8985588plt.7;
        Wed, 06 Nov 2019 00:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6GjS6HuTnbZ88vQVj4JSFkPPvT/i5ODPCza1wsk6Lc=;
        b=YjFJBlz0++/RfQRFL30Y70Clnu/B5Hp9fXIBT1QrAOFMv/NsaZC2Flm5rjoMJ20tlw
         f5e0FEe+rH0OW3NB8daQp/K0Bs8KgObrXvagmBkyDglxa3uFIHg+axqXP935hwlBBBEQ
         HT6WSpSUcMTsASmr4ElQU7ydbAHQjyqz0F+akDk0u3WSqKoW/bjFKuZkgj8PLWk3upfl
         i/KjRmaEVmEkXQjWyQ+9zpLOwWPbUvtdZVpM6mlmKK2Fc12N1nMb+ZULqUPr9XXzr+Ql
         iYdtfEtxgoUHDjMSISrzU291orjEHaXndF3Uhq8yEI/JFXiVeNmv81Jxan2aSkTGWK6Q
         5+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6GjS6HuTnbZ88vQVj4JSFkPPvT/i5ODPCza1wsk6Lc=;
        b=CiK9fnFs0/0HZw+dpmx//EYDn9YvaaQwpUgPFbjYUJL5otIUFSZgCQ0NRshbv5MYD1
         mC62gDwJMD8wZ8/DEaXGaXbN3FwovB60ylgqxD9rgfw5iRjepnc5eUaOoI5REJYeyY7H
         t9C0kWcIrSu711fPBS0hjx6B7RIhY5w1K4eIyJRyz8OmgjhM04PL6Ts5I7+uqBA79sm/
         flRq8RrwxEYBYIy0Cx0L/c6P/sDMGC1C05cqJT8VaorXGPzRQk4pLDfWV6i7oEEEzOqr
         x4QoTrQb6ZvGyUIcst6oUUR695qrZrdjG33b2tELRQ9AArOA5awJyXCtZanSIJkW8GMS
         lFSw==
X-Gm-Message-State: APjAAAVzYuxL2QBSsWtSjR+TvJoDbILU4cH7DSXEywLZmI61DN8UzTES
        AJ9nbdAowskRCfYRCDkTlZLnD6jRLocnl28qiX0=
X-Google-Smtp-Source: APXvYqxFnaPObwnV4COxhNQXBd8N5/3daW/8Ez/WckSwKSEWB7RTX/MES+iZPC3KFUYBE1ai/zETl1cz5ChX9RR8Tos=
X-Received: by 2002:a17:902:b40e:: with SMTP id x14mr1434268plr.262.1573030482891;
 Wed, 06 Nov 2019 00:54:42 -0800 (PST)
MIME-Version: 1.0
References: <1573029503-18369-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1573029503-18369-1-git-send-email-bianpan2016@163.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Nov 2019 10:54:32 +0200
Message-ID: <CAHp75VeQ_3mConCN=u9O_Ckz9O+awHU=s+d3Kn6R35ZfzzAJKg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: pch_udc: fix use after free
To:     Pan Bian <bianpan2016@163.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 10:41 AM Pan Bian <bianpan2016@163.com> wrote:
>
> The next field of the DMA descriptor is written after releasing the
> descriptor, which may result in a use-after-free issue. Set the value of
> the field before it is released to fix the bug.
>

Had you chance to read the discussion [1]?
I Cc to Gustavo to hear from him about destiny of the change.

[1]: http://lkml.iu.edu/hypermail/linux/kernel/1702.1/00843.html

> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/usb/gadget/udc/pch_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/pch_udc.c b/drivers/usb/gadget/udc/pch_udc.c
> index 265dab2bbfac..c5b8ec908aab 100644
> --- a/drivers/usb/gadget/udc/pch_udc.c
> +++ b/drivers/usb/gadget/udc/pch_udc.c
> @@ -1518,8 +1518,8 @@ static void pch_udc_free_dma_chain(struct pch_udc_dev *dev,
>                 /* do not free first desc., will be done by free for request */
>                 td = phys_to_virt(addr);
>                 addr2 = (dma_addr_t)td->next;
> -               dma_pool_free(dev->data_requests, td, addr);
>                 td->next = 0x00;
> +               dma_pool_free(dev->data_requests, td, addr);
>                 addr = addr2;
>         }
>         req->chain_len = 1;
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
