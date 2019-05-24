Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D7D2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzxkgAyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbfEXFyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:54:20 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42923 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387703AbfEXFyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:54:19 -0400
Received: by mail-oi1-f196.google.com with SMTP id w9so6164915oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 22:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ebgv3UeXA0WytHreGCVh/7DQkPpVomBIGZeLwu/7es=;
        b=WzxkgAyRBYozpQ9xwmo4jx8O4OFRtPU6J0nptXrnuf+XflBtgcZgTRHwcpnbhEmVAv
         usBq5i6iGIoTGhH3T4ughQUWoLxun4lJZmnw1D8s4AkM/5A9zCYhUuMJBwBaLG+74xd9
         cAJfKD65CbgSvqMGfCS9b1xHDIkd6gZI3ar5Z0XvUqUhAaBYVGsX6H7b5uccDJt4eySU
         MYSo6jGHbKD9L9dnKS05g0Qm1ycdhH2tguBQh9rWV2gyIdEYwANqfWndBfUxBDYMSXb/
         AzwcI7cP0mhIZnAUnajbr1n0shjsHYdDtiW7moPVVpFA5DhZpV4qTI20AA2LFMx70I7h
         zf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ebgv3UeXA0WytHreGCVh/7DQkPpVomBIGZeLwu/7es=;
        b=lWJrUSZgLwx/8JX0drSJPJtanmgG6nLKh0skloAkQr2mgCJGOVc6cWMAZhkeMoQ1av
         gciPogQTt1gPqlED7Prsq5qwhpFjc/OpmC2b5nMd09cXu6S2mec+290oBJ1ToXMrBhbi
         92IqlgZiLc4G68+r/Zw6kDWYRdsqgsuCe8hV0cUnPp0b/TQ0uC7wcktEaEQI4fhXxltj
         anu68r3SCWnyC2xjf5z+0uW3eK8rAiKt53L8yzLkL/UQMIBMLZKOg62nmii+uZNIxK6M
         CTdhvHlx4nkI9A//dEYwkmulHCkSI7v6+SZI6ptcU6R4ROawE14GBkPbqZvl4s/rieY/
         SuLA==
X-Gm-Message-State: APjAAAVqZD+k3vNV+yid0uLOyx88sB4oAmn/jdoaZ7MDCxIvRDdLd9Ib
        8qOGw5YbXDPLUEZyv7xftTUkpQlUkdjBYbP7tHA=
X-Google-Smtp-Source: APXvYqxMC+I6BinOmBqmotSjJts4Ix18CeAG/RSOJyQ2f/Fct4fsBMOH+wWVl8C6cc2AOAkKi/k7adx3Cjy6I0Xu97w=
X-Received: by 2002:aca:3c85:: with SMTP id j127mr5285364oia.29.1558677259014;
 Thu, 23 May 2019 22:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190523183510.GA12942@hari-Inspiron-1545>
In-Reply-To: <20190523183510.GA12942@hari-Inspiron-1545>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 24 May 2019 07:54:08 +0200
Message-ID: <CAMhs-H9222OXrqWh4W-D7pFV6FXbhLVVGXz-29gO-Qo0eQaTvQ@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-pci: pci-mt7621: Remove unneeded variable err
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        NeilBrown <neil@brown.name>,
        Peter Vernia <peter.vernia@gmail.com>,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hariprasad,


On Thu, May 23, 2019 at 8:35 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> devm_request_pci_bus_resources function will return -EBUSY/-ENOMEM
> in fail case and returns 0 on success.
>
> So no need to store return value in err variable.
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
> index 03d919a..bc2a3d1 100644
> --- a/drivers/staging/mt7621-pci/pci-mt7621.c
> +++ b/drivers/staging/mt7621-pci/pci-mt7621.c
> @@ -596,17 +596,12 @@ static int mt7621_pcie_request_resources(struct mt7621_pcie *pcie,
>                                          struct list_head *res)
>  {
>         struct device *dev = pcie->dev;
> -       int err;
>
>         pci_add_resource_offset(res, &pcie->io, pcie->offset.io);
>         pci_add_resource_offset(res, &pcie->mem, pcie->offset.mem);
>         pci_add_resource(res, &pcie->busn);
>
> -       err = devm_request_pci_bus_resources(dev, res);
> -       if (err < 0)
> -               return err;
> -
> -       return 0;
> +       return devm_request_pci_bus_resources(dev, res);
>  }
>

In the patch title, the "mt7621-pci" is repeated twice. With that changed:

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

>  static int mt7621_pcie_register_host(struct pci_host_bridge *host,
> --
> 2.7.4
>
