Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CE5ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC76420854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svu2xTrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbfJPDId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:08:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37028 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfJPDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:08:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id k32so18862793otc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7A21E/smP9/Sv5xhwv/46RtfLPTPabv+1Tv1kRSD6w=;
        b=Svu2xTrsQ8/7CF7+WC9aHOaFTooX/VO00gDOMlbo5ewHqzh0xf6e3QdDX3K1wx4UmN
         kdSJ5h1SfNfv4F9dITWIqrZg/rGgQS5dKTWEOrD497Rn860YblJFQxj5L4+rWGgx6Ver
         sFu2Ag5GtKJb0R+1t6HZ5sygjZmq+qFrlexFDVfMm1QRY3IV/1yvvQS3fOBYdkdJ9dUu
         TUrZ8lu52XGnRyEjHitMIF+mWvkPTQ/68uLiGwM0kGYnMqOdeHvnb7aZYCxpBR6vGf9I
         NVZ9+iWPgZk6qExrUniq/D3+HxFOwC061r6wtTwjZQYlBCSDgiU3+v+Koj/bSKK22aAE
         jhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7A21E/smP9/Sv5xhwv/46RtfLPTPabv+1Tv1kRSD6w=;
        b=oAT6Pwz6IwG+wV8ylA9ryRcq3g7OGbg+4TToLfaGD00DqDM24N4rnrLKmpsBmjbjTl
         EiXqtj7Doyw7Atnbg8brY8uV5bswTdD3SgYV5rKD1pOiJb3xD/PZ2iT+TP7P5c6dqGEo
         PkR+9KW1uAM9PS55s3KxqX/CiuUTMW3EhA0VE+7XBYuq79JPWnpTE2Ch7bXur9ktm74t
         l44MIQOkAn/ntQ1b+U9nloW3J0KaicpDlXg4GW1Nn/H4XhzRdSTXrGgYl84M+5DJT46b
         PjszdyziPVQJT0cj/dGrocW7h8JPQEODr/hg3de1AbfaZuu+0Zk7Razer/4dgaV0Lqs/
         YQ/A==
X-Gm-Message-State: APjAAAUzXOQ4AjQyk8XXHvKqJHImwiWpTR29vEmNOJi5VmQb1FXGoIKS
        OtlXmz0if7W42C5gn/6Y1pc=
X-Google-Smtp-Source: APXvYqzyG/+zSpTve/uxIbZ/lZlB9loL2gTNw0pjEs6B5o26I1bQ8I0VxLfBMHsQHI9fTqhYnxKAgw==
X-Received: by 2002:a9d:6b19:: with SMTP id g25mr31065283otp.12.1571195312149;
        Tue, 15 Oct 2019 20:08:32 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k34sm7200224otk.51.2019.10.15.20.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2019 20:08:31 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:08:30 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64: mm: Fix unused variable warning in
 zone_sizes_init
Message-ID: <20191016030830.GA29527@ubuntu-m2-xlarge-x86>
References: <20191015224304.20963-1-natechancellor@gmail.com>
 <20191016030051.4di67v6swlkz2wzy@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016030051.4di67v6swlkz2wzy@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:00:52AM +0100, Will Deacon wrote:
> On Tue, Oct 15, 2019 at 03:43:04PM -0700, Nathan Chancellor wrote:
> > When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> > get disabled so there is a warning about max_dma being unused.
> > 
> > ../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
> > [-Wunused-variable]
> >         unsigned long max_dma = min;
> >                       ^
> > 1 warning generated.
> > 
> > Add an ifdef around the variable to fix this.
> > 
> > Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/arm64/mm/init.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 44f07fdf7a59..c3d6657b9942 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -212,7 +212,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >  	struct memblock_region *reg;
> >  	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
> >  	unsigned long max_dma32 = min;
> > +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA)
> >  	unsigned long max_dma = min;
> > +#endif
> 
> This looks bogus to me :/ You're referring to CONFIG_ZONE_DMA twice, and I
> can't see how that symbol even exists on arm64.
> 
> Will

Gah, sorry, one of those CONFIGs should be CONFIG_ZONE_DMA32. I will
send a v2 to fix that shortly.

Note, this patch is targetting for-next/zone-dma, which reintroduces
CONFIG_ZONE_DMA. Sorry if the patch tag and Fixes tag didn't make that
clear, let me know how I can better convey that in the future!

Cheers,
Nathan
