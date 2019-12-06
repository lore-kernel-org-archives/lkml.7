Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DE7C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B342173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575628380;
	bh=G7R6QhJH44Vhq98I1nfWwTO2dy+llq99SePGB4Glvc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qh4Qu3ySzAFF97aKpTYSmKmRtvBGIu9iPenJb4fXKlo51p9r62rp9N3b2wZ5pMP4Y
	 31NE/VB/ebvdTIbVW9U8Q/Q9Se+fH2xCpoyVlQSQgVGk7vekZUqtdbHPoJu3SWiGDI
	 QdAPiWdAYT/sABHW9bAsVJ7k7mraEMBbOVyb/bDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLFKc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:32:59 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:40205 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLFKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:32:58 -0500
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xB6AWePs002653
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 19:32:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xB6AWePs002653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575628361;
        bh=TDjawUlmNNXUEMf1DhyFf5MKCPPn8CovJxPUOaAc2oc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KZyQL6sGwHXlLzRXNDrEfVVY/yjlfYCq7MzavV7PX1RuVzFueZSpOf2mPLxMRVv85
         aGkC/fD/tc/OpmZEy6sb79o+2vMjdS/Q5j10G0mo2Y4h94AoLHe7r5ln30/U6AgAxq
         eW2YmGIc6OWse24f3kiMVjsjGrpVmBq+emlp0lA+RPmMYxdTPitjF9oZDy90XlOZ0x
         X8fEGtT5DA/J/u7li8NExtHJoHN972riTh051J6JpRZSu8CXiKRwIuIfOqiudlzXhW
         rf9NEx6crIpcRHcX7FiXmFEfhU763PQVAsnVPxSzKfUMjwodF4N1JROiqL4hucpAPY
         MNSPYHZ+mySWg==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id i18so2087017vkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:32:40 -0800 (PST)
X-Gm-Message-State: APjAAAXHsN4i4JkG3x4ROAPcwQpKhKQdMzX97ask2Q3p3ag7wY0VAxmN
        B1bgv1TQUOu+yHLv+FkMCCsEp7tvohLi8ENo8b4=
X-Google-Smtp-Source: APXvYqy7cm748UdnM90CLgAG1ZA9MFTcYgJ8zjVaMoKjzv6tyXiBABFAld7eOFcOIfoKfcf84Pbg2MdfjRn/7lkZDw0=
X-Received: by 2002:a1f:5447:: with SMTP id i68mr10722286vkb.66.1575628359661;
 Fri, 06 Dec 2019 02:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20191206075432.18412-1-hslester96@gmail.com>
In-Reply-To: <20191206075432.18412-1-hslester96@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 6 Dec 2019 19:32:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsK5JD-qeBugp9mn8DgW+SYttp5AwZ_ht5KY2MhPe-Ew@mail.gmail.com>
Message-ID: <CAK7LNAQsK5JD-qeBugp9mn8DgW+SYttp5AwZ_ht5KY2MhPe-Ew@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: denali: add missed pci_release_regions
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, Dec 6, 2019 at 4:54 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> The driver forgets to call pci_release_regions() in probe failure
> and remove.
> Add the missed calls to fix it.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---

This patch looks equivalent to what I submitted,
then was rejected a couple of years ago.
https://lists.gt.net/linux/kernel/2557740



>  drivers/mtd/nand/raw/denali_pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/denali_pci.c
> index d62aa5271753..ca170775b141 100644
> --- a/drivers/mtd/nand/raw/denali_pci.c
> +++ b/drivers/mtd/nand/raw/denali_pci.c
> @@ -77,7 +77,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>         denali->reg = ioremap_nocache(csr_base, csr_len);
>         if (!denali->reg) {
>                 dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
> -               return -ENOMEM;
> +               ret = -ENOMEM;
> +               goto out_release_regions;
>         }
>
>         denali->host = ioremap_nocache(mem_base, mem_len);
> @@ -121,6 +122,8 @@ static int denali_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>         iounmap(denali->host);
>  out_unmap_reg:
>         iounmap(denali->reg);
> +out_release_regions:
> +       pci_release_regions(dev);
>         return ret;
>  }
>
> @@ -131,6 +134,7 @@ static void denali_pci_remove(struct pci_dev *dev)
>         denali_remove(denali);
>         iounmap(denali->reg);
>         iounmap(denali->host);
> +       pci_release_regions(dev);
>  }
>
>  static struct pci_driver denali_pci_driver = {
> --
> 2.24.0
>


-- 
Best Regards
Masahiro Yamada
