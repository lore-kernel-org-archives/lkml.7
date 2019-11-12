Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1972AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E226121925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+qPl9Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKLJPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:15:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44806 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PLZnKnyjrvEEY3MNe1xQ1aX6JHwtmyTlZ7RAIiC0GHM=; b=m+qPl9DqhaFcbB555Gi1kONCV
        qe/8BUWg94E5vHtORxVetXUG+E7fLoMk93K7eJAXQBooGJLKOq1x5P82jGvV1nk0LkB8U1KwRLq5g
        p3eJJaIOKWhz46y7FIn7I3XIvoCkhOXMa4dkzBorxOMwbPySQckG/qhkX8WcL7AelvGorrjNzkMVM
        7oKoQ8jqEKfTIRiCfQ9cjskIgzdB32vhAt4McGb3LelGQeOCj/o5PqLXVe0cHjJ2bJOJZje1Hq72f
        dIdeVzncG6CGm1C9YcnHYggwU4Z4iTb0w1qk4tVIKp/OHy6XYBDoO4SNRMRob7hHqyvfoBbD9AEIz
        E9MAcHIxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUSGi-0005yb-JA; Tue, 12 Nov 2019 09:15:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E00C6305615;
        Tue, 12 Nov 2019 10:14:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8946B29BC818D; Tue, 12 Nov 2019 10:15:21 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:15:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V2 11/16] x86/ioperm: Share I/O bitmap if identical
Message-ID: <20191112091521.GX4131@hirez.programming.kicks-ass.net>
References: <20191111220314.519933535@linutronix.de>
 <20191111223052.603030685@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111223052.603030685@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:03:25PM +0100, Thomas Gleixner wrote:
> @@ -59,8 +71,26 @@ long ksys_ioperm(unsigned long from, uns
>  			return -ENOMEM;
>  
>  		memset(iobm->bits, 0xff, sizeof(iobm->bits));
> +		refcount_set(&iobm->refcnt, 1);
> +	}
> +
> +	/*
> +	 * If the bitmap is not shared, then nothing can take a refcount as
> +	 * current can obviously not fork at the same time. If it's shared
> +	 * duplicate it and drop the refcount on the original one.
> +	 */
> +	if (refcount_read(&iobm->refcnt) > 1) {
> +		iobm = kmemdup(iobm, sizeof(*iobm), GFP_KERNEL);
> +		if (!iobm)
> +			return -ENOMEM;
> +		io_bitmap_exit();
		refcount_set(&iobm->refcnd, 1);
>  	}
>  
> +	/* Set the tasks io_bitmap pointer (might be the same) */
> +	t->io_bitmap = iobm;
> +	/* Mark it active for context switching and exit to user mode */
> +	set_thread_flag(TIF_IO_BITMAP);
> +
