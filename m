Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D72BECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5250121835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="eTxNXnOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437204AbfJPUcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:32:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33796 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfJPUcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:32:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so11822159pll.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QJRz2ZBCOtaw3AEGb2XPo0CsgmmvmJQzag5UcwcjBaw=;
        b=eTxNXnOKCPKxxsn3bIBFR7anyKEgL2XRidpZv+WcTa38kItiezDEvD5JjvGCCSs+7p
         +c34Om1neANbjcBKask22h+B+A3rhLuHHzMnshEbgfYHvGRFjxBlYir3+KZNj9PD7+bw
         6i0iBA2daqj6El0RLjyBLVcQSmMveditUQHZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QJRz2ZBCOtaw3AEGb2XPo0CsgmmvmJQzag5UcwcjBaw=;
        b=NDRGM5hJVdbLEbnnkjUgoEqqa66wSG8MTAN+vh1f9lnq3hkJlwJyeZ60koLnMm0GnW
         EeMzf3vRRzVjn+o39imtR2L+s9ny/Vf7NANEwVkr2UIzxrJoFEYdk5Ft3oYiC1ZdDVoj
         kM5HLr1L7Vk+wyn044+8dOtawCM+vva5HIH/F9Qxbzgw2rZoy+JGNX5oS+c7+uTh1wzs
         qFgLAOJP6ZFEngfT42LvubNlY60/huXEC1JKFMR/ql5NzrJntxfn1+F1DZSco0JpYt4O
         SVJ6cCuUik+8SnM73Qwj0Rcze2P//DycIVUFrxZgTAVqj6t7AAuSA4kEJ6xmYgk2scAs
         AuGg==
X-Gm-Message-State: APjAAAUqQGcoR8wElzxmhuVgPY3wwtxP/sIDlvkcVJEZQFUMu/Fo+JDT
        DVNFb2uk5zYuFIg7lVKdylo2JkvlDhD9vg==
X-Google-Smtp-Source: APXvYqyUc62vDZ/uWYv8OWO99Dvo9BD5ZJfTxm2G0UESZVycda+kmxA41w91q7dN5a7I8vv61of8rA==
X-Received: by 2002:a17:902:bc48:: with SMTP id t8mr116238plz.255.1571257947335;
        Wed, 16 Oct 2019 13:32:27 -0700 (PDT)
Received: from shiro (p1092222-ipngn200709sizuokaden.shizuoka.ocn.ne.jp. [220.106.235.222])
        by smtp.gmail.com with ESMTPSA id k95sm32839pje.10.2019.10.16.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:32:26 -0700 (PDT)
Date:   Thu, 17 Oct 2019 05:32:20 +0900
From:   Daniel Palmer <daniel@0x0f.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: mstar: Add machine for MStar infinity family
 SoCs
Message-ID: <20191016203219.GA5191@shiro>
References: <20191014061617.10296-1-daniel@0x0f.com>
 <20191014061617.10296-2-daniel@0x0f.com>
 <CAK8P3a2U7U31eF_POU2=eCU+E1DH-wnR2uHr-VZYWLy25hLjKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2U7U31eF_POU2=eCU+E1DH-wnR2uHr-VZYWLy25hLjKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +static void __init infinity_map_io(void)
> > +{
> > +       iotable_init(infinity_io_desc, ARRAY_SIZE(infinity_io_desc));
> > +       miu_flush = (void __iomem *)(infinity_io_desc[0].virtual
> > +                       + INFINITY_L3BRIDGE_FLUSH);
> > +       miu_status = (void __iomem *)(infinity_io_desc[0].virtual
> > +                       + INFINITY_L3BRIDGE_STATUS);
> > +}
> 
> If you do this a little later in .init_machine, you can use a simple ioremap()
> rather than picking a hardcoded physical address. It looks like nothing
> uses the mapping before you set soc_mb anyway.

I've moved this into infinity_barriers_init() using ioremap() as suggested.
I'd like to keep the fixed remap address for now as there are some
drivers in the vendor code that might be useful until rewrites are done but 
are littered with hard coded addresses.

> > +static DEFINE_SPINLOCK(infinity_mb_lock);
> > +
> > +static void infinity_mb(void)
> > +{
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&infinity_mb_lock, flags);
> > +       /* toggle the flush miu pipe fire bit */
> > +       writel_relaxed(0, miu_flush);
> > +       writel_relaxed(INFINITY_L3BRIDGE_FLUSH_TRIGGER, miu_flush);
> > +       while (!(readl_relaxed(miu_status) & INFINITY_L3BRIDGE_STATUS_DONE)) {
> > +               /* wait for flush to complete */
> > +       }
> > +       spin_unlock_irqrestore(&infinity_mb_lock, flags);
> > +}
> 
> Wow, this is a heavy barrier. From your description it doesn't sound like
> there is anything to be done about it unfortunately.

It's possible there is a better way once I can find out what the L3 bridge
actually is. There is a small amount of documentation for the miu (DDR
controller) that says it has an 8 or 4 operation configurable pipeline but
this flushing bit is in a totally different area that's only documented
by the comment about it in u-boot.

> Two possible issues I see here:
> 
> * It looks like it relies on CONFIG_ARM_HEAVY_BARRIER, but your Kconfig
>   entry does not select that. In many configurations, CACHE_L2X0 would
>   be set, but there is no need for yours on the Cortex-A7.

Fixed.
 
>    Not sure if it matters in practice, as almost nothing uses fiq any more.
>    OTOH, maybe the lock is not needed at all? AFAICT if the sequence
>    gets interrupted by a handler that also calls mb(), you would still
>    continue in the original thread while observing a full l3 barrier. ;-)

I've taken the lock out and tested that the ethernet isn't sending garbage
and everything looks good.

I'm still hoping for some feedback on the other parts of the series.
I'll post a v2 series in a few days.

Thanks!

Daniel
