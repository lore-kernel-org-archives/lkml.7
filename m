Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F4DFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D9120650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv5WRXVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405861AbfJPPv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:51:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405514AbfJPPv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:51:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so20580277otu.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/sC5t5Telanb+Whfg1izOfbj9GvpmoEXVoH0REuP7x8=;
        b=jv5WRXVOVyiic7g3B6hzLWwoGmFzH9DJdzlqxWKAWzstDRy++d1ruHya3dqcZfm8Hg
         9Rudmq17u3E2k67xCXAr5jpMRggU2FxRcFoykd59F+54u5feq/Skr8jY5/WM5aXNzhR1
         Gu3x6o7GyLyWxzU6UmHflZ+/keES8JPUxcPr+81tTJ7H0Glo8DLSgyKYhVYN1PthKAtP
         iDbCnY6amhxSMndZEidLBMj4YuHRZt7cX9keNKkICxWeVvcOoHgpMqR+9uAeAZph0Qsu
         pjYqXJKQUB2zoAUbExrG0HaOJvkvhwaUOOfM40SIKJiMjBGKfaktJXyppAQXCK9iBeuf
         e1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/sC5t5Telanb+Whfg1izOfbj9GvpmoEXVoH0REuP7x8=;
        b=qN/CtHtgws8IdrOiRmHhEe+UV79IWROu4keOHlmJ3zTkXmsh8ENSM8eXzn3iKp8qwf
         iw7Hgd6GTIVIrztTDDMfVduT6ywRtWL3gAeTCCwdsdJ3I5aM2UniYzqnxjrERI7XHta+
         EVWMu0hmfZ8TCD1L+FxBNJXmhnENkOq73snDPgBMc9X99h6/ZoqFv7mtqyYfxkfvdKTd
         FJkE67AICQ0JgbNFcmLM6WnlcCZvCsFi+AfXy5Dp7tB7bPr9QXqo6PA9Z3anbFAPoQqj
         y80qad3q9zsL3+o69orHeWyAy3SESfSLGL/8sj+JydcGBYOIeL3NPxNQfR402twBNmC/
         L3RQ==
X-Gm-Message-State: APjAAAX1X+aMHgbeFN9pmmGEcoagfVLaKyok22OSjtx3EKdCNXJGe+EG
        yeDjDMp5AWKhU8WLcK/T7Y5HhbhK
X-Google-Smtp-Source: APXvYqxYktwrr28slQB53InWNZbt9qZC1OePYPQ0XWGAnQ9+4+SfHMLN5d01QoN/5tuE1e+21JABtg==
X-Received: by 2002:a05:6830:119a:: with SMTP id u26mr8734058otq.166.1571241116924;
        Wed, 16 Oct 2019 08:51:56 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y30sm7512305oix.36.2019.10.16.08.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 08:51:56 -0700 (PDT)
Date:   Wed, 16 Oct 2019 08:51:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] arm64: mm: Fix unused variable warning in
 zone_sizes_init
Message-ID: <20191016155154.GA55959@ubuntu-m2-xlarge-x86>
References: <20191016031107.30045-1-natechancellor@gmail.com>
 <20191016144713.23792-1-natechancellor@gmail.com>
 <20191016150846.GO49619@arrakis.emea.arm.com>
 <83c223c14c55aff1c8c9b30b0760c7e13c928209.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c223c14c55aff1c8c9b30b0760c7e13c928209.camel@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 05:09:30PM +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2019-10-16 at 16:08 +0100, Catalin Marinas wrote:
> > On Wed, Oct 16, 2019 at 07:47:14AM -0700, Nathan Chancellor wrote:
> > > When building arm64 allnoconfig, CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32
> > > get disabled so there is a warning about max_dma being unused.
> > > 
> > > ../arch/arm64/mm/init.c:215:16: warning: unused variable 'max_dma'
> > > [-Wunused-variable]
> > >         unsigned long max_dma = min;
> > >                       ^
> > > 1 warning generated.
> > > 
> > > Add __maybe_unused to make this clear to the compiler.
> > > 
> > > Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > 
> > Thanks. Queued on top of Nicolas' patches for 5.5. I also added Nicolas'
> > reviewed-by from v2 as I suspect it still stands.
> 
> Yes, thanks!
> 

Thank you both for reviewing the patch and picking it up!

Cheers,
Nathan
