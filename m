Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3882C46470
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA3C21479
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 18:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556909352;
	bh=KGeziaPtUPNmb1W4HZA4UsYcNlgAPR6LLCaYja2jOI0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=cBIpLGSrxk0e5Ll4kUJAz/kdUqPnRJh8UeYqx2rMKLY9uz82yt0g/IB3YGQZUsOvr
	 WMqno2i+XP8B0LkFUnlUgv/BE6hwoFCfQxfM4XKdd2wdHB/32bM4wRMbA0+T/tch4K
	 n7NIGpBTN947SS2s9mRSkLBXcuryqq5m0DjkSNjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfECStL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 14:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfECStL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 14:49:11 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4B342075E;
        Fri,  3 May 2019 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556909350;
        bh=KGeziaPtUPNmb1W4HZA4UsYcNlgAPR6LLCaYja2jOI0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=a6WHutb8yyJeTowNbUA9CnGwkEfxZjeofA38FDIxS5Gg23KjOr4kO2SXW0CNomKEZ
         M50naF6JDjC5LIgJZnEZE1+wjTwURLekRH/z/YigcLqD8HqQV7pKueBxH2rZqMUMUk
         XFI83FcU348qcOtojOq6MG0+ML7p2H/cCB+EG8vo=
Date:   Fri, 3 May 2019 20:49:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        stable@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] x86/fpu: Remove the _GPL from the kernel_fpu_begin/end()
 export
In-Reply-To: <20190502154043.gfv4iplcvzjz3mc6@linutronix.de>
Message-ID: <nycvar.YFH.7.76.1905032044250.10635@cbobk.fhfr.pm>
References: <761345df6285930339aced868ebf8ec459091383.1556807897.git.luto@kernel.org> <20190502154043.gfv4iplcvzjz3mc6@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019, Sebastian Andrzej Siewior wrote:

> Please don't start this. We have everything _GPL that is used for FPU
> related code and only a few functions are exported because KVM needs it.

That's not completely true. There are a lot of static inlines out there, 
which basically made it possible for external modules to use FPU (in some 
way) when they had kernel_fpu_[begin|end]() available.

I personally don't care about ZFS a tiny little bit; but in general, the 
current situation with _GPL and non-_GPL exports is simply not nice. It's 
not really about licensing (despite the name), it's about 'internal vs 
external', which noone is probably able to define properly.

If it would be strictly about license compatibility, that'd at least make 
us somewhat deterministic.

-- 
Jiri Kosina
SUSE Labs

