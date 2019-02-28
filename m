Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9881320C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+ZxOcOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbfB1PYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:24:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfB1PYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OnzIEkEBATHkZivcKQpN7ok4Kr8ltm6V0tbX8NyGRd4=; b=K+ZxOcOszaX6bmpGJaOfoyQBV
        fagvnoo5tP/VGKqNyVghrKPi/JduHyol97HIrL2CkLKmBrcFQY8f/e1sIjGeGf+rzeFrTnwIDc1wY
        PXQY4LybqziqVO3nedEnAxrt98Gxx7Jp/Z1AW0u+YoHTYslhNc+s4se+I6UEnsbsZVAkXL7Q7ECnD
        V/Q+RC81PVvRgqjYtBXLL3Kd61r1GKBBpumLaUD73X4qSQ581BQ4Y0bw2JAgRxMQiplEhbMhe7y72
        jldg/S2D1JZAOMZWecoihFoEcyovftwMwohZfRAjhpRlxCChD7jkjKM76Y2yHfv/+QzNtb3MBJldx
        Qe5YUFXCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzNY1-0004cV-Qi; Thu, 28 Feb 2019 15:24:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E6ED202C2DAB; Thu, 28 Feb 2019 16:24:32 +0100 (CET)
Date:   Thu, 28 Feb 2019 16:24:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     bp@alien8.de, brgerst@gmail.com, catalin.marinas@arm.com,
        dvlasenk@redhat.com, hpa@zytor.com, james.morse@arm.com,
        jpoimboe@redhat.com, julien.thierry@arm.com, luto@amacapital.net,
        luto@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, valentin.schneider@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Message-ID: <20190228152432.GC32494@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <155136664389.5847.6200085578174808757@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155136664389.5847.6200085578174808757@skylake-alporthouse-com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:10:44PM +0000, Chris Wilson wrote:
> Quoting Peter Zijlstra (2019-02-28 14:54:56)
> > drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x3c: redundant UACCESS disable
> > drivers/gpu/drm/i915/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x66: redundant UACCESS disable
> > 
> > AKA. you don't need user_access_end() if user_access_begin() fails.
> 
> Cool, I had no idea if it was required or not. The closest to
> instructions on how to use user_access_begin() is in
> arch/x86/include/asm/uaccess.h ... which I guess is earlier in this
> series!

Ah, I don't think I put the rules in a comment; that would've been
useful I suppose ;-)

I did teach the rules to objtool though, and that is in the next patch:

  https://lkml.kernel.org/r/20190228150152.635362492@infradead.org

so at least it will yell at you during compile time when you get it
wrong.

> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks!
