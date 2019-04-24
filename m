Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA95C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F5A20693
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 07:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfDXH5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:57:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33611 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXH5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 03:57:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so11782066qtc.0;
        Wed, 24 Apr 2019 00:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=za3ImLgInol4F4xHo1CFkwlCBDmGY2avkRiLnVrvH5A=;
        b=ib5ChvYaGdsKRsU9Hqz2u/usGMJ1VzlT7E6nE8RkMXkYZn0E4FswK91quS/vjrB11e
         wZ8YwPc4zRTSJsyCRNCTlidQO+0rYt4Zjt9hA9Zsdc6uLk7CW0yTaeCOJipg+JPwIZ0L
         d60dyRqfA+HxF4aXOcHzw38BnMi/EkMcXvzDqfXBiUtmyUodLWd+TRg8PDshAofOuvCj
         XptFRZmRzoaXWsIQMKopzMA1GUV3xP6AqViowarJYLPyEOm7Oip3Tezeva943kROMn7g
         Qrbbfv4jg1KRh12GqTWO/tTFd03pC/anEsyqqlHCjOPrGPF1ht2bUflOSuCzI0eRIPnx
         h9Gg==
X-Gm-Message-State: APjAAAVVGUi2w9lTBY8hTMtotb5RyeAN2E//LKll8/HZz7SSBoZnVbaS
        Jmk/4huycz0rYqUbF5xNR6XOwXrirwz8wn656no=
X-Google-Smtp-Source: APXvYqzyyIGMydgfSO8KDx1TcYnqfTiklDYBOVH1sRSE4rxA47D/N2jYbLhavwRKHuTuIyd+QZwe4HudYqKVkO2hRV8=
X-Received: by 2002:ac8:2924:: with SMTP id y33mr23556243qty.212.1556092664812;
 Wed, 24 Apr 2019 00:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
In-Reply-To: <CAD8Lp47JYdZzbV9F+asNwvSfLF_po_J7ir6R_Vb-Dab21_=Krw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Apr 2019 09:57:28 +0200
Message-ID: <CAK8P3a2cGnTP_Qr4AjPvLA8X7cP+u_dNQQWZsWreKkKkqOwLdw@mail.gmail.com>
Subject: Re: sg_dma_page_iter offset & length considerations
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Imre Deak <imre.deak@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:22 AM Daniel Drake <drake@endlessm.com> wrote:
> In drivers/mmc/alcor.c we're working with a MMC controller which
> supports DMA transfers split up into page-sized chunks. A DMA transfer
> consists of multiple pages, after each page is transferred there is an
> interrupt so that the driver can program the DMA address of the next
> page in the sequence. All pages must be complete in length, only the
> last one can be a partial transfer.
>
> I thought that the sg_dma_page_iter API looked like a great fit here:
> the driver can accept any old sglist, and then use this new API to
> collapse it into a list of pages that can be easily iterated over, and
> fed to the hardware one at a time.
>
> But looking closer I think I may have made some bad assumptions, and
> I'm left with some fundamental questions about this API.
>
> Specifically I can see userspace generates requests which present a
> sglist such as:
>  - first entry with offset=1536 length=2560
>  - 7 entries with offset=0 length=4096
>  - last entry with offset=0 length=1536
>
> I gather that dma_map_sg() will take care off the offsets, i.e. any
> physical address I get with sg_page_iter_dma_address() will already
> have the offset applied, so I don't have to worry about tracking that.
>
> But what about the length? For every page returned by the iterator, I
> can't assume that I am being asked to work with the full page, right?
> Such as the first and last page in the above example. I need to go
> back to the sglist to check the corresponding length variable, and
> having to go back to check the sglist seems to defeat the convenience
> of having the sglist collapsed into a list of pages by the iterator.
>
> Any comments?

I would assume that 4K aligned data is the common case, as that
is the smallest page size we allow in the page cache, and SDHC
cards expect FAT32 with at least 4K aligned clusters as well
in order to get into their fast path.

I'd keep that assumption by default, and would suggest you fall
back to to a kmalloc() bounce buffer if you get a buffer from user
space that is not fully aligned. I suppose the only way to create
those would be using O_DIRECT writes.

     Arnd
