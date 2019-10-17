Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4363ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6F321848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfJQNCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:02:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33914 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728923AbfJQNCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:02:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id f18so1151407qkm.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 06:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tc37Pb9q6dE/zT3Ycpn//EMDbegOyEk2q1pX9+DJhEk=;
        b=SESw4Tfv8Mfu0s1PL5CqgougsyQEsacsXelf0dSE/DncaQFPJXBxY5YhRXSsNTBNJM
         wL8SMcZSWDu0+bvtpmgKz+9dDu48sPTXaDVonTJxx8FeiUK3rNWBfNPG+UloVz+vJ0IA
         ArnzrCoe+o3jwHP0TsLntYJJ6Ise6Rxph+rVBeuSk1yenyZPzHlGxc2zCIlhawQJvzDI
         9yCMWmHn8fqGYC0Dw4cBKkgZBpOgS3IhuO1HNvdZ17V6ALhjZYw7Nvb7+dx33UgTIZbZ
         1deumTYnriD8rV7uNt4a4U4LP18YUeVKD0xc3Z6ovOb489iHExbM7mMA9fAfa+pFkTly
         vRtQ==
X-Gm-Message-State: APjAAAWavVe+khO7j9sWZNG4xMEbbCb0Z+zR42nCjmq1sn90UOEPGaGT
        G2z9qe+NPE6JvDNlIhN0aw55yCzZWC2HIvA19ygpzFn6
X-Google-Smtp-Source: APXvYqxpviHKOBocuedDoRJVvpksKm61tNm1y7WWnjqU07w4dzxJBEu7vqLfmAn3UiT+CILsxUWbdd1MVQU89/WZ/HI=
X-Received: by 2002:a37:9442:: with SMTP id w63mr3106804qkd.138.1571317358971;
 Thu, 17 Oct 2019 06:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061617.10296-1-daniel@0x0f.com> <20191014061617.10296-2-daniel@0x0f.com>
 <CAK8P3a2U7U31eF_POU2=eCU+E1DH-wnR2uHr-VZYWLy25hLjKg@mail.gmail.com> <20191016203219.GA5191@shiro>
In-Reply-To: <20191016203219.GA5191@shiro>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Oct 2019 15:02:22 +0200
Message-ID: <CAK8P3a2Tqpwg6=3N2DhcDj9JMo6jt0sY+sYmnNmzZ5Rcao=iMA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: mstar: Add machine for MStar infinity family SoCs
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:32 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> > > +
> > > +static void __init infinity_map_io(void)
> > > +{
> > > +       iotable_init(infinity_io_desc, ARRAY_SIZE(infinity_io_desc));
> > > +       miu_flush = (void __iomem *)(infinity_io_desc[0].virtual
> > > +                       + INFINITY_L3BRIDGE_FLUSH);
> > > +       miu_status = (void __iomem *)(infinity_io_desc[0].virtual
> > > +                       + INFINITY_L3BRIDGE_STATUS);
> > > +}
> >
> > If you do this a little later in .init_machine, you can use a simple ioremap()
> > rather than picking a hardcoded physical address. It looks like nothing
> > uses the mapping before you set soc_mb anyway.
>
> I've moved this into infinity_barriers_init() using ioremap() as suggested.
> I'd like to keep the fixed remap address for now as there are some
> drivers in the vendor code that might be useful until rewrites are done but
> are littered with hard coded addresses.

Maybe keep the infinity_io_desc as an out-of-tree patch then? You can
simply do both, and ioremap() will return the hardcoded address.

> >    Not sure if it matters in practice, as almost nothing uses fiq any more.
> >    OTOH, maybe the lock is not needed at all? AFAICT if the sequence
> >    gets interrupted by a handler that also calls mb(), you would still
> >    continue in the original thread while observing a full l3 barrier. ;-)
>
> I've taken the lock out and tested that the ethernet isn't sending garbage
> and everything looks good.

I would not expect a missing spinlock to have an observable effect, the
question is more whether it's correct in all rare corner cases where
the barrier is interrupted and the interrupt handler uses another barrier.

I think it is, but I would recommend adding a comment to explain this if
you drop the spinlock. (or a comment about why this works with fiq if you
keep the lock).

     Arnd
