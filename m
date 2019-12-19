Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A7EC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B9624679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="PA7ZtiPC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLSTtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:49:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45032 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfLSTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:49:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so3553132oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 11:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WOYLYTznKDVctg0axb2JuhcSMnCkii9+HnV91/Ps1A=;
        b=PA7ZtiPCdpmB5ckpKUTuP9UiI4iO7Jaul4a4yyubl/SlGQ0UaA0mGUoBnRKuK/seFi
         m15W7cG674hpFWe3TsztGk6NA7feYoUmXiRZ3s4N6FNIntX5GCLlL8GKfFDplumUsVLY
         KDZZy3Mi37qz+Dj/MMzF+N6D2A1THGyHNowICPiEq3WG14wXd0lpIIc9c63kkH26kA1c
         m5W424gQGCjRKMyzabSnRk6pxYoX3++TEDpRU4r8Avl5rn/iDC7kIagD/xF2qvfIXM3j
         hoSgRc+bvbLi9hXAil0kfLUFQHRmCar9D4iR/BGmHos+ZjwqkLBnqNylxyTGRoT1UZAN
         PQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WOYLYTznKDVctg0axb2JuhcSMnCkii9+HnV91/Ps1A=;
        b=i3hlucyHyvvBcCmd6zvaHnDuFeyiDq94hPZFhbvc3WIU+FTqsbPl8Y7yuL/gTrYMbn
         8epqp37EB7lYVy5CXgMoINmJesXU2Zd0poQsoEXUac0OUS0/TyRNcpeLhrbjo6GyE4bg
         Zj4sJSsCr3gP26J+z8LoA2s0YjKAfNuzcJAsgDNhKLKfEoC/QFdiZ9JQNhumsg0Zq3fv
         BdR39lww1AXMubBRjRKNqExkANstWKsxRisvrZLmYKlbjThasWd/+eSUHd/1caKIL/9e
         gAnfoJYnkRN31NjZYYVVb7w5FtEcpt8y0aXkhYnzZPnnV+VEDuN8hMTqEkc5/u/J2LWq
         W82w==
X-Gm-Message-State: APjAAAVOeZHIwyK2bFjq0/+EpxeG/MLY/+NZUD7t2FBn0aGEekL4gcXO
        JonwebemJ8M2qraib1PzIX0B2MG8qqsWAPTksiIbV2db
X-Google-Smtp-Source: APXvYqyeGcSqxrWUGJoSElD4q/mqzurMZs+tkiQMyf8vBF9MThN5eDra5Iy1ZhiGqtvXuFyzQyb8v4YxqVb1PMEzM8U=
X-Received: by 2002:aca:4850:: with SMTP id v77mr2809560oia.70.1576784954413;
 Thu, 19 Dec 2019 11:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20191218123205.3fb9c793@canb.auug.org.au> <20191218124950.191d9df4@canb.auug.org.au>
In-Reply-To: <20191218124950.191d9df4@canb.auug.org.au>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 19 Dec 2019 11:49:03 -0800
Message-ID: <CAPcyv4jDozHaSCw26onPfmT1xefX2S2NB3RGL8pz1UWz=UDWWw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the generic-ioremap tree with the
 nvdimm-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Wed, 18 Dec 2019 12:32:05 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the generic-ioremap tree got a conflict in:
> >
> >   tools/testing/nvdimm/Kbuild
> >
> > between commit:
> >
> >   c14685547762 ("tools/testing/nvdimm: Fix mock support for ioremap")
> >
> > from the nvdimm-fixes tree and commit:
> >
> >   1188dd7d3fbd ("remove ioremap_nocache and devm_ioremap_nocache")
> >
> > from the generic-ioremap tree.
> >
> > I fixed it up (the latter is a superset of the former) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.
>
> The merge also needed this fixup (since both trees logically added the
> same small function):
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 18 Dec 2019 12:46:03 +1100
> Subject: [PATCH] generic_ioremap: merge fix for "tools/testing/nvdimm: Fix
>  mock support for ioremap"
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Hi Stephen,

Thanks for the heads up.

Christoph are you going to submit that for v5.5 or is that v5.6 material?
> ---
>  tools/testing/nvdimm/test/iomap.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index 27a9c5f3fcd0..03e40b3b0106 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -193,12 +193,6 @@ void __iomem *__wrap_ioremap(resource_size_t offset, unsigned long size)
>  }
>  EXPORT_SYMBOL(__wrap_ioremap);
>
> -void __iomem *__wrap_ioremap(resource_size_t offset, unsigned long size)
> -{
> -       return __nfit_test_ioremap(offset, size, ioremap);
> -}
> -EXPORT_SYMBOL(__wrap_ioremap);
> -
>  void __iomem *__wrap_ioremap_wc(resource_size_t offset, unsigned long size)
>  {
>         return __nfit_test_ioremap(offset, size, ioremap_wc);
> --
> 2.24.0
>
> --
> Cheers,
> Stephen Rothwell
