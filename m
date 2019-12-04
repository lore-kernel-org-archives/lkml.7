Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B969C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A261206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WTwIE3gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfLDPUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:20:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33694 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfLDPUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yiprBM4pnUJfI31vGfj4fHwfpxRYZZwpzxRmiG1S3HI=; b=WTwIE3gxa1EquaNTLr65hTH4g
        KUkaAEDw30+vsSg8eCo8diNZYmmgNDqjNm39jU3yxsfdPnlXQ7BquCg7y7WQKH+iT/2ZotJaCoN6G
        oBGeiuxzgFYKVwAbVw8U2uujn62/5TrYM4oPYtxE8oFienZuqjIUuUSe+PlQiAuHCKKe6rpPZwH7/
        kxAC3xh1lX9jNGR5qw8Bya6/ucu2FNGqFXg5hjKDwWX5PYYCnegef1dYZ35IxOcqBpQLVN3Y8XpaV
        oBLCiZLXtILP3RDmXm+8cRY6uV+L9YN2QkWYkKmC5/KXolZ6eIhHzIyHfIqQiUurOHn1Ph1q8JzgJ
        dELYRhyQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icWRK-0001dR-Df; Wed, 04 Dec 2019 15:19:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 94B843011E0;
        Wed,  4 Dec 2019 16:18:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D99E20D1A242; Wed,  4 Dec 2019 16:19:40 +0100 (CET)
Date:   Wed, 4 Dec 2019 16:19:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Fenghua Yu' <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] drivers/net/b44: Change to non-atomic bit
 operations
Message-ID: <20191204151940.GY2844@hirez.programming.kicks-ass.net>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
 <1574710984-208305-2-git-send-email-fenghua.yu@intel.com>
 <7cbe0135c6234700bebdefd0fdaa4f6a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbe0135c6234700bebdefd0fdaa4f6a@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 09:49:08AM +0000, David Laight wrote:

> >  	memset(ppattern + offset, 0xff, magicsync);
> >  	for (j = 0; j < magicsync; j++)
> > -		set_bit(len++, (unsigned long *) pmask);
> > +		__set_bit(len++, (unsigned long *)pmask);
> 
> While this stops the misaligned locks, the code is still horribly borked on BE systems.

Quite so.

> The way pmask is used definitely wanst a u32[] not a u64[] one.

Not sure, the code seems fairly consistent in using u8[].

And I suppose we can write the above like:

	pmask[len >> 3] |= BIT(len & 7); len++;

instead.
