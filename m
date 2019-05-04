Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BAC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 07:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D71F2084A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 07:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556954794;
	bh=7M8LWi4HCapsDw9sC9lfXVqB6NXjC4jpoo3wJEk0Y9U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=imyymGBbbMr/iuHCh8jZMpYnDPg+dMoYxYO7KfjbDXMpWB5W8L0zcaS6q8IVp0FDq
	 PAncnx6h57G926dORFR2ayjx4PdNf0jQ9Gkv4X+RRuakvqiIEozJXmywwU7EJHG7/n
	 3bIjOoqkrwbCJIlw/x2IJOtjVsAE4Vblq7773Mng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfEDH0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 03:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfEDH0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 03:26:30 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D90E20645;
        Sat,  4 May 2019 07:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556954790;
        bh=7M8LWi4HCapsDw9sC9lfXVqB6NXjC4jpoo3wJEk0Y9U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=yovRT7xNo6EJS5AH5pqX9Cc4Od3KFmo5LaqMcdp6FyopwPsLd2nTziHl/GpA+WBpU
         d4vFGD8Skpdj5ktfU/+OD9RfJD9aQqOy0Up285HuLdxvvBa5Qf4OgI47tV230FyQ7W
         eDAlNqmXnu+A8hJjiJWiGuDBog4HntdljGn1VLhE=
Date:   Sat, 4 May 2019 09:26:19 +0200 (CEST)
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
        stable@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Remove the _GPL from the kernel_fpu_begin/end()
 export
In-Reply-To: <nycvar.YFH.7.76.1905032044250.10635@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905040849370.17054@cbobk.fhfr.pm>
References: <761345df6285930339aced868ebf8ec459091383.1556807897.git.luto@kernel.org> <20190502154043.gfv4iplcvzjz3mc6@linutronix.de> <nycvar.YFH.7.76.1905032044250.10635@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2019, Jiri Kosina wrote:

> > Please don't start this. We have everything _GPL that is used for FPU
> > related code and only a few functions are exported because KVM needs it.
> 
> That's not completely true. There are a lot of static inlines out there, 
> which basically made it possible for external modules to use FPU (in some 
> way) when they had kernel_fpu_[begin|end]() available.

... any for many uses that's really the only thing that's needed.

	kernel_fpu_beign();
	asm volatile ("some SSE2/AVX/... math");
	kernel_fpu_end();

No other bits of the FPU API, so there is no way of getting anything wrong 
because of FPU intrinsic details really.

So I don't really see a problem with Andy's patch. If we want to annoy 
external non-GPL modules as much as possible, sure, that's for a separate 
discussion though (and I am sure many people would agree to that). 
Proposal to get rid of EXPORT_SYMBOL in favor of EXPORT_SYMBOL_GPL would 
be a good start I guess :)

-- 
Jiri Kosina
SUSE Labs

