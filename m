Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325802070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iUTyqVOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfDBH1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:27:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52626 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfDBH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MRFaojMCQHp8ppKkLxqzrHcu9vpPjPvvh2iWAMwllvk=; b=iUTyqVOLIsfDZ5mBQz1jzJ+do
        zqc3kBrKe5/sLljS9mH1GfOU1QWSaoNjkHuIzw7LDWveY6nqNJ5VTex1yVIjAmgamPv72L3qVWSRy
        qMgCyXfI1oHJgrpDGQKjgEKJt+VMKkF/k03culYksLjFlAGMJzIsraUwE9vnkUReWr10pH6m/YFFL
        rAXSom4Ke96AHR5oJ5+96OYErpk4HvKhNY4W/SvmtfdaY9XcL40CflB0QyIJaRJgXCAY38c0zTyZR
        L52nG4snoV3GbBsd6hfX8FsITJ62pGkHn3X6MHSJAy2ZPj2SkYfl7mTNeELEvNh86m+Ej13J2Pr5s
        ytLVHIAQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBDoy-00008J-Si; Tue, 02 Apr 2019 07:27:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B1F12994D1A6; Tue,  2 Apr 2019 09:26:59 +0200 (CEST)
Date:   Tue, 2 Apr 2019 09:26:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     paulmck@linux.ibm.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, jyknight@google.com, x86@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH] x86/asm: use memory clobber in bitops that touch
 arbitrary memory
Message-ID: <20190402072659.GH12232@hirez.programming.kicks-ass.net>
References: <20190401162408.249668-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401162408.249668-1-glider@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Apr 01, 2019 at 06:24:08PM +0200, Alexander Potapenko wrote:
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index d153d570bb04..20e4950827d9 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -111,7 +111,7 @@ clear_bit(long nr, volatile unsigned long *addr)
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: BITOP_ADDR(addr)
> -			: "Ir" (nr));
> +			: "Ir" (nr) : "memory");
>  	}
>  }

clear_bit() doesn't have a return value, so why are we now still using
"+m" output ?

AFAICT the only reason we did that was to clobber the variable, which
you've (afaiu correctly) argued to be incorrect.

So whould we not write this as:

	asm volatile (LOCK_PREFIX __ASM_SIZE(btr) " %[nr], %[addr]"
		: : [addr] "m" (*addr), [nr] "Ir" (nr)
		: "memory");

?

And the very same for _all_ other sites touched in this patch.
