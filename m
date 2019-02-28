Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C023CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DB8218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTYXrZHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfB1Rv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:51:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732473AbfB1RvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/nFivKn/yKzgEdB0TtiAWyukhOTQvHlX4n/85BeDHJM=; b=nTYXrZHAxNtSzPUCc99RYYuuo
        yAFK8mqbydWuyxQ2lsc6MEEyEm9ZujymeCOlLe6AgSpWYy6ixLk9lZ3ezMJOu50xnRgmhYiKvViEj
        j5uM0ij9UBWONC3N4/5ZdjS9F5BSbmGfEuiWY1x+LgpoGJhSqrIFXg+gh55hCfQwg7nxMKNKhsOfq
        Y/xski3cGEGihdnDkH5GPmDnzwRvcFsYAT3uQGSoOKzIlqKabTs4R0PwIquvgyplJWNuodvUsVjX9
        T5s2MRC4DkpLByo0cQXsbUCqzPmSzv6Wz63ofFrUWcAu+utGZQxF+7FCYyHU9kEkv/ddiYl+oeVjs
        3o61Juzcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzPq1-0006fK-DC; Thu, 28 Feb 2019 17:51:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E6C16202C2DA7; Thu, 28 Feb 2019 18:51:14 +0100 (CET)
Date:   Thu, 28 Feb 2019 18:51:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 6/8] i915,uaccess: Fix redundant CLAC
Message-ID: <20190228175114.GG32494@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.540038736@infradead.org>
 <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgsSXxL5c2Lbmbai=bcCgN0G=jPO+gWhQ3a+wx-LTaFkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 08:49:57AM -0800, Linus Torvalds wrote:
> Yes, it is redundant (but harmlessly so) if no fault occurs.

Oooh, there's a label hidden in unsafe_put_user()...

And yes, objtool seems to miss that, damn. I'll go stare at that.
