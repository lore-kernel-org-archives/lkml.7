Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8722BC04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 01:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C6021881
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 01:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ipXGRA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfERBxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 21:53:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40272 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfERBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 21:53:36 -0400
Received: by mail-ot1-f65.google.com with SMTP id u11so8389691otq.7;
        Fri, 17 May 2019 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nQoQJoHpzJQYSi8VTTlyTdi+eKb5pb19O1ImUVZ7ifQ=;
        b=l4ipXGRAjIUzrlrkNvaTG2k7I+bCkITMEedVuFdJU25ONJvkJw5RSmJ17hfa8hOlTj
         mNz+//ZqwGZCy+TvYGRK0bDw0eTbWJ5r+kSSmDLPhgun28oX3ZxMC7XPRpjVdYpkMDni
         omHVPXuYpg8wrhglnXxlow1lzLh96xxBmyWiMeoD+1gwQZWGntUKXA5decjWwKiBG/lx
         axYgdvPwoEQZka/tB8jXG2WFzWSkSZWogp1PycM1fBN5M8h783W4P4NzgFB5oWuHQYP5
         lBWYYo1w+qK5lL3mmcj3Y+cilEa1QO9YPKCKkewslqpnFc3OzC0DSNTcs5DiBqIFGYFw
         0goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nQoQJoHpzJQYSi8VTTlyTdi+eKb5pb19O1ImUVZ7ifQ=;
        b=PID6GIxodNvBJofQ+/f8ZwwvS5fpSt4SAl8XZQdXSpWLXmlwAHm5lvS8L8EyTnXSzg
         Tq+btrFrAeq4oTFq++mTDEPGWowiNBK/tII8nFEEPSf4KKsbR3mu9X8l0Ked3B2O2+eJ
         z+iJwyE+e/XK49l4thn/J5P/e1dMQNd1vPREBRn482N6poVx48p2WrGIDlyw8UIXJcub
         Xzyh2zoWhgLwzeJlYUh/BVGiBi+9jp+cn/34OT4Q5RofxYQQi28eUw04XNao4lcV8Zib
         jf7AMPhy+a+I9Xs4Y2TE6+HaOdaEej9MpEKZN6EWNGBj5Qgjhdj0QmYFiT35UovnqAuq
         vYxw==
X-Gm-Message-State: APjAAAV+4r1/FA6Kskfsuaruw15W4oy6GGG5dIELWia+ItSE4gma8LTO
        nRWtHcyA4FFe9rf1ifHT4YNMneHMrHUxguArwFM=
X-Google-Smtp-Source: APXvYqzakSouikJDjGU/ZZDMXGyP5yHiZqGJqzz077iJsfIXTiPOTHYX631z9th9Ri2xS+j3CwbDVfry70noOTIRAQs=
X-Received: by 2002:a9d:4808:: with SMTP id c8mr3385903otf.316.1558144416123;
 Fri, 17 May 2019 18:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
 <20190517163420.GG31704@bombadil.infradead.org>
In-Reply-To: <20190517163420.GG31704@bombadil.infradead.org>
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Sat, 18 May 2019 10:53:03 +0900
Message-ID: <CAJrd-UuCMpuSDh6Sx24=aesK38XSB5ys2pHCT4K-O0VSj4ewkA@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaewon Kim <jaewon31.kim@samsung.com>, ytk.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment.

In ARM64 architecture, default CMA region is commonly activated and it
could be used
if no specific memory region is defined. The USB driver in my platform
also uses the
default CMA region as DMA allocation. If using the CMA to do DMA
allocation is improper,
then do you think that the USB driver for my platform should be
changed not to use CMA?

According to my understanding, in CONFIG_DMA_CMA on both v4.14 and v5.0,
__GFP_DIRECT_RECLAIM will try CMA allocation first instead of normal
buddy allocation.
Then it will get default CMA region through dev_get_cma_area API.
Please refer to
dev_get_cma_area code below though I am using v4.14 for my platform.

git show v5.0:include/linux/dma-contiguous.h
 61 #ifdef CONFIG_DMA_CMA
 62
 63 extern struct cma *dma_contiguous_default_area;
 64
 65 static inline struct cma *dev_get_cma_area(struct device *dev)
 66 {
 67         if (dev && dev->cma_area)
 68                 return dev->cma_area;
 69         return dma_contiguous_default_area;
 70 }

Thank you

2019=EB=85=84 5=EC=9B=94 18=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 1:34, M=
atthew Wilcox <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, May 18, 2019 at 01:02:28AM +0900, Jaewon Kim wrote:
> > Hello I don't have enough knowledge on USB core but I've wondered
> > why GFP_NOIO has been used in xhci_alloc_dev for
> > xhci_alloc_virt_device. I found commit ("a6d940dd759b xhci: Use
> > GFP_NOIO during device reset"). But can we just change GFP_NOIO
> > to __GFP_RECLAIM | __GFP_FS ?
>
> No.  __GFP_FS implies __GFP_IO; you can't set __GFP_FS and clear __GFP_IO=
.
>
> It seems like the problem you have is using the CMA to do DMA allocation.
> Why would you do such a thing?
>
> > Please refer to below case.
> >
> > I got a report from Lee YongTaek <ytk.lee@samsung.com> that the
> > xhci_alloc_virt_device was too slow over 2 seconds only for one page
> > allocation.
> >
> > 1) It was because kernel version was v4.14 and DMA allocation was
> > done from CMA(Contiguous Memory Allocator) where CMA region was
> > almost filled with file page and  CMA passes GFP down to page
> > isolation. And the page isolation only allows file page isolation only =
to
> > requests having __GFP_FS.
> >
> > 2) Historically CMA was changed at v4.19 to use GFP_KERNEL
> > regardless of GFP passed to  DMA allocation through the
> > commit 6518202970c1 "(mm/cma: remove unsupported gfp_mask
> > parameter from cma_alloc()".
> >
> > I think pre v4.19 the xhci_alloc_virt_device could be very slow
> > depending on CMA situation but free to USB deadlock issue. But as of
> > v4.19, I think, it will be fast but can face the deadlock issue.
> > Consequently I think to meet the both cases, I think USB can pass
> > __GFP_FS without __GFP_IO.
> >
> > If __GFP_FS is passed from USB core, of course, the CMA patch also
> > need to be changed to pass GFP.
>
>
