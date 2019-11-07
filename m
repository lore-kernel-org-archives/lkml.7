Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B8AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7020E21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2Ijhk3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfKGJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:10:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfKGJKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y9JOhqH6Yq7QewJpbraBcfattW1/jZsJvhDfOoY0UtI=; b=L2Ijhk3+qEb6iFeq7vfEvVcMQ
        nH6YvpTB0g7W72WJVIhOG1dqLdASImQsZEktgQFuppjBsNSUyk7CYeQC0ZxfCWLxhx9o57HtdLcb/
        XoqAM6IM5C4XHkW/eJnUxwyewRWfmMErmior5aFj2XCl1VMeI1F7hqPd4w06qZRxgKeAetaivGbCW
        WAGcPRafleR77a1UTBi+oW+pSnw+Htl3PYCXjjWkgUPMxOV/NDFdri22wjRb5lSG+wtdm264bHYQm
        Mtv1UvYFfqTXKXDlPnbEyhHZDJ8S/wEJMD6X8U90vfNY1mO8lKud0cruVOiKhlM1kWPKBsfnpm9iL
        V6t2kCirA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSdnO-00062Z-BH; Thu, 07 Nov 2019 09:09:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B466301A79;
        Thu,  7 Nov 2019 10:08:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A341D2B13B361; Thu,  7 Nov 2019 10:09:34 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:09:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 7/9] x86/iopl: Restrict iopl() permission scope
Message-ID: <20191107090934.GZ4131@hirez.programming.kicks-ass.net>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.425388355@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106202806.425388355@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 08:35:06PM +0100, Thomas Gleixner wrote:

Something like:

> @@ -379,7 +383,8 @@ struct tss_struct {
>  	 * byte beyond the end of the I/O permission bitmap. The extra byte
>  	 * must have all bits set and must be within the TSS limit.
>  	 */
> -	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];

#ifndef X86_IOPL_NONE
> +	unsigned long		io_bitmap_map[IO_BITMAP_LONGS + 1];
#ifdef X86_IOPL_EMLATION
> +	unsigned long		io_bitmap_all[IO_BITMAP_LONGS + 1];
#endif /* X86_IOPL_EMLATION */
#endif /* !X86_IOPL_NONE */

>  } __aligned(PAGE_SIZE);

Would allow us to reclaim those 8/16K bitmaps for LEGACY/NONE kernels.
