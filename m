Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C004C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5B2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EEB6oaRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1HbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:31:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1HbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oCk+i4hq5vijxIivxcdrfjI0pxP4TsAgmZkLFYI7q3M=; b=EEB6oaRM4obBeouuzjVic2pZy
        zW1Tr77WtwhSuhXfS1r6SI1lhsd8VD/MGZrOLRaOEkbTlf91s1yoZq9eeIqpCgLwIYW60xuvDiGK5
        VjItK6TkOgCmG2rcYXieRDklQVS0PW0wcARgIkGm2yvmv7xElUb8uK7TMwXZ9C1HR+zgOpe4dVGnM
        4c8O8C3XgcTNcg2uxCnL8KbwPiXg2b/fO3vprJDzxoY3tGwu3wMVHQLWxxXwj/nwv9JDMDlEjjN7z
        XQD4qikHzFFz41gCaE7tTQ0Z+7YHkV1vTpRw+x/4old7d2VV9JX2OeLhUH1n2Kt/vW3j1wMPocfWY
        QDLufRZgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2sPv-0007kc-7M; Wed, 28 Aug 2019 07:30:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51CFA307594;
        Wed, 28 Aug 2019 09:30:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 324492018508C; Wed, 28 Aug 2019 09:30:52 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:30:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH v2 0/6] Rework REFCOUNT_FULL using atomic_fetch_*
 operations
Message-ID: <20190828073052.GL2332@hirez.programming.kicks-ass.net>
References: <20190827163204.29903-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827163204.29903-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 05:31:58PM +0100, Will Deacon wrote:
> Will Deacon (6):
>   lib/refcount: Define constants for saturation and max refcount values
>   lib/refcount: Ensure integer operands are treated as signed
>   lib/refcount: Remove unused refcount_*_checked() variants
>   lib/refcount: Move bulk of REFCOUNT_FULL implementation into header
>   lib/refcount: Improve performance of generic REFCOUNT_FULL code
>   lib/refcount: Consolidate REFCOUNT_{MAX,SATURATED} definitions

So I'm not a fan; I itch at the whole racy nature of this thing and I
find the code less than obvious. Yet, I have to agree it is exceedingly
unlikely the race will ever actually happen, I just don't want to be the
one having to debug it.

I've not looked at the implementation much; does it do all the same
checks the FULL one does? The x86-asm one misses a few iirc, so if this
is similarly fast but has all the checks, it is in fact better.

Can't we make this a default !FULL implementation?
