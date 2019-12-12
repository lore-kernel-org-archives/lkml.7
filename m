Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F597C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0DA206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkjBzwQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfLLOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:54:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfLLOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g2WAPCffaDSa5XZ/+/8mSxwtz/ygAOx7fwf+HEIeSBg=; b=hkjBzwQO+J4wtlwwBA6daxDQD
        2Lmz6jeYlULJ6AqVdN4Iqt/7P+4s1Dgqs9n6L7jr12D/gsGrXlqnAsv6KFai8JntV5Q/4mEAuapuT
        bK+eKjT4fBa9297FvVDG4XtTgrY5eA+GJvejZMmcE+g9XSvJgnGG8EfAyPayNvX3DSwf1IpYaq2cq
        +klAZby68snnb60ykLtvfUuOvaKvFeWf65NjkNMrH5rbKa0mWePtV4iCLYnxRxDclzNk1Z+r92lMz
        4cuDbq/05AbMfzWH/ux1oKzt3DzO8+0yEPjyYM4rOzwVTuzUfHgSMWAHCVo6kgR+95j9X50rjK42B
        N3qqnLwIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifPrM-0004WV-Es; Thu, 12 Dec 2019 14:54:32 +0000
Date:   Thu, 12 Dec 2019 06:54:32 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Mike Travis <mike.travis@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: avoid unused variable warning
Message-ID: <20191212145432.GA15634@infradead.org>
References: <20191212135815.4176658-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212135815.4176658-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of that maybe_unused mess please just use good old ifdefs.

>  	if (hubless)
> -		proc_version_fops.open = proc_hubless_open;
> +		proc_create_single("hubless", 0, pde, proc_hubless_show);
>  	else
> -		proc_version_fops.open = proc_hubbed_open;
> +		proc_create_single("hubbed", 0, pde, proc_hubbed_show);
>  }

Or someone could figure out what happens if we turn the
proc_create_single stub into an inline function instead of the
define.  That makes it used at a syntactic level, the big question is
if the compiler is smart enough to optimize away the unused callback
still.
