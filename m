Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D24DC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F921D80
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 05:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="E8oKqEdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411406AbfIYFAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 01:00:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35332 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392987AbfIYFAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 01:00:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so2809076wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCjUe0hDGDhMjnECf1F2ZQdV6LWs8J93Rkhj1cQXHGo=;
        b=E8oKqEdyG0bLy1YbJxVkgMWG5q1T851YJJLeEfwLZBcBzm/Z/rJFURALxIbiMzCeC6
         q4vrrUEPF7pfaObZleGRa4FaCj45G3Ud97aVzTOTTvst/+YIL/jQAVb+Ufw72IsVoVrO
         SDfYjZS5eKmEAeURuNg31P2jNvK3iguYv/xX2yw9wlsqE/Q9AAEaXDq3XkJw7typ0Sil
         KghJ4psNwURfLM98alBol1KgNc2xz7kwEbDt9qoJ1b+MjSh/y4Z+nGfiuKHZWX5Hw+Ru
         Sx/fwESJyNav3DjbOeDTzBG/ItKImxkNKo3AcmrAl6rDzni/9Yf2SaQlB7nJc3jwflHT
         BkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCjUe0hDGDhMjnECf1F2ZQdV6LWs8J93Rkhj1cQXHGo=;
        b=IH4uKbLRECCBKCBv5oSb+Jc0OzGhLnmV7hUGwrd4NojOmAq+AeTy/AwntyAECEh0VC
         IRh93o9WHNIIhkpqo4A0P1kRg+qTyiOwoPk2YPDGMA8JcMQDa+/Y2n5DAKKpYCo05JnK
         l6zYLY2ZoSzGKzbcDuQkNw25otJRpgKfGeyWg1NOrSYQsVPggSWMKxcsgYBuwnImSBI/
         r+JfFyAHjYyq+Karr3OB/fz4ZVfjMDU7vR4SbV/DUAS2ihNLS0FiXzARfqn36PZl81HW
         +lJHYKBhyPrGW/ZOPagB5HI+0niC0akW976fOGaKVyrR/k0ICfHHxLvwvfBw2SoOsdAD
         to4g==
X-Gm-Message-State: APjAAAV6Z85WV713RZFsZKsoJccW6T/u8WQCZ2m+JjGn90hhmdwr+UCo
        fxbqpK8LUgtY78ITvRBMbDd8FeJDLtg7S5EAyo4q7w==
X-Google-Smtp-Source: APXvYqy1vkOuGEDqTNg8aNO4jpgMMXEuZMX6RWQpVXhNioHmNHB+PBavw+PntxSsQx8Rbkok2+C/qrGdOpdJ96+qhew=
X-Received: by 2002:a1c:5451:: with SMTP id p17mr4901443wmi.103.1569387612159;
 Tue, 24 Sep 2019 22:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190925042912.119553-1-anup.patel@wdc.com> <20190925042912.119553-2-anup.patel@wdc.com>
 <20190925044308.GA1245729@kroah.com>
In-Reply-To: <20190925044308.GA1245729@kroah.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 25 Sep 2019 10:30:00 +0530
Message-ID: <CAAhSdy1Z09tpNtfS10gL5BXJ=1wydLy4nmtFyKQenAPDSyTLTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform: goldfish: Allow goldfish virtual platform
 drivers for RISCV
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Roman Kiryanov <rkir@google.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 25, 2019 at 04:30:03AM +0000, Anup Patel wrote:
> > We will be using some of the Goldfish virtual platform devices (such
> > as RTC) on QEMU RISC-V virt machine so this patch enables goldfish
> > kconfig option for RISC-V architecture.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  drivers/platform/goldfish/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
> > index 77b35df3a801..0ba825030ffe 100644
> > --- a/drivers/platform/goldfish/Kconfig
> > +++ b/drivers/platform/goldfish/Kconfig
> > @@ -1,7 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  menuconfig GOLDFISH
> >       bool "Platform support for Goldfish virtual devices"
> > -     depends on X86_32 || X86_64 || ARM || ARM64 || MIPS
> > +     depends on X86_32 || X86_64 || ARM || ARM64 || MIPS || RISCV
>
> Why does this depend on any of these?  Can't we just have:

May be Goldfish drivers were compile tested/tried on these architectures only.

>
> >       depends on HAS_IOMEM
>
> And that's it?

I think it should be just "depends on HAS_IOMEM && HAS_DMA" just like
VirtIO MMIO. Agree ??

Regards,
Anup
