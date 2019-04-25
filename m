Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E19C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B9C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="iLk0Ehxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfDYHi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:38:58 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37800 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfDYHi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:38:58 -0400
Received: by mail-qk1-f180.google.com with SMTP id c1so12472674qkk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfvjY+zDqv6pZ1IB6rCy8tV4fyw/efPkbRlraVU4XAU=;
        b=iLk0EhxoyNOLXrk91r7oQEoj8JysVGxcc3JYPy7RLgkDym3NcZQNhss7hAYCwVn4Ry
         b+pqPcJf5XhW3oi0D5lmScAoB2LJoPQC+89DZibUsl80eVbzaNwkEH14zOsuJD6taHhl
         bnXvadM4JcMnvDkecSgx23eNdnE1VY6eT5jOOnSqX3DIdvDirDrpgDVTsPLSPB7Evvel
         Vb1mF8TX6EUJEXpfZaAaWA5zU3OBHbNoS4CRdnOTtw0IZgrAcPhU812h7n9kplcoUAOQ
         SDwxZ9siGrr7LYTTgIniVan03o2o/KFDq3CpvBgX8qI8+fVodV7AYx4DNgMIpCjkkVMo
         jbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfvjY+zDqv6pZ1IB6rCy8tV4fyw/efPkbRlraVU4XAU=;
        b=JGPuVizOIu0EehSgJn+mlJj9+v8myAduk66oJyLMKZ+1Lm52epdyLx/QR5+xdzH+YQ
         6xqfaGNXpdN1UO8WLjut19KNKD4yPChnuBPGwcJwUL8W6XITOrWjdGt1yAC2PtBd46co
         DR//Bfp/kU+nUi8nqkcN3A7wtNl7O9e8CubR3AhLZkTswGMq6fwrcS4zPLvuDwjyGvcz
         i8rg37sFIZ00LoTnx3AUh6gQzidM65an5qkO6YeTd4BmQuONZnszcOO//QyVu4kYoXP4
         oQUyQHvk6ta0n+ocN6//c7j6PlT63P90FqO91NHA6PBKsPOHwnpyhNQvvTs1QLcJ3vxd
         Cxbw==
X-Gm-Message-State: APjAAAV33COFEFyvMAII9ZHwLYSnVQ5ttSnIVCPrU8f79EnbRBx20pzf
        NYPhcOgeaUud6ehE1cbit1407e2QV+/+YhK8C7Ie2w==
X-Google-Smtp-Source: APXvYqyFkuYiZW++luERGRFMhrxkRmsn6Fuso9f/wgvJVWlG9sYuxmBgjCmy2l6w5kgoU2nkMsC9T35tktP5PyzDpHs=
X-Received: by 2002:a05:620a:35c:: with SMTP id t28mr28046449qkm.24.1556177936957;
 Thu, 25 Apr 2019 00:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
 <20190424112153.GB16077@mellanox.com>
In-Reply-To: <20190424112153.GB16077@mellanox.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 25 Apr 2019 15:38:45 +0800
Message-ID: <CAD8Lp47uacAFKTz8dtpDq3AXuQE9UKoBtw9VqxZdLeL5UoHCXA@mail.gmail.com>
Subject: Re: sg_dma_page_iter offset & length considerations
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "imre.deak@intel.com" <imre.deak@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 7:22 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> A driver that simply wants a SGL with a capped max size (ie 4k?)
> should use the dma_set_max_seg_size() API and just never get a SGE
> with a larger length.

That sounds like exactly what we want here. However I tried that
function and it seems to have no effect. Larger SGEs still appear just
as readily as before.

I tried to find the code that honours the value set here, but didn't
find anything. Sure there are some non-x86 archs and some iommu
drivers that appear to do something with it, but in this case
(standard Intel x86_64) it seems like nothing observes/honours this
value.

That did lead me back to the similarly-named mmc_host.max_seg_size
though, which is passed through to blk_queue_max_segment_size().
That is documented as "Enables a low level driver to set an upper
limit on the size of a coalesced segment", but perhaps I don't fully
grasp what it means by "coalesced segment".

The alcor driver currently has:
    mmc->max_segs = 64;
    mmc->max_seg_size = 240 * 512;

which I had interpreted to mean "we can accept a sglist with maximum
64 entries, and if you sum the size of all entries in that sglist, the
total must not exceed 240 sectors". i.e. with "coalesced" referring to
the overall sum; the description does not suggest to me that we can
influence the size of an individual segment here.

Other mmc drivers may also share a similar interpretation, e.g. see atmel-mci.c:
    mmc->max_seg_size = mmc->max_blk_size * mmc->max_segs;

but I just experimented with the driver again, and setting
mmc_host.max_seg_size to 4096 does seem to do what we want here. Now
we get multi-entry sg lists but each sge is max 4096 bytes in size.

I'll do some more verification and then send a patch along these
lines. Thanks for your comments!

Daniel
