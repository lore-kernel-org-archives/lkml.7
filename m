Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E50C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D81120851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VC3Z4uSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfCAPXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:23:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCAPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RENNXA18DGifZQijxXwuGGbhsgk/71mdLoQmjbY05Nc=; b=VC3Z4uSSzfkZ0eLvEX4mMNZTu
        omZdTJujAQ+XNQzpNcMIF3d4ZYcJWrVkfl8xTfcnxvmWzL7NqKOZYUSan/UHmqjfXBPgUy6zt1QcR
        YNEJM9V/45O4630BXRJXtiJjaB7InNS48Yz5px/UcdcQ9DN84nAlszhnSBcoJu0tQloFNdlwNGCTr
        VgXm4PvtWSqs+LwPJnlpdciVYtUrdawtQJCSpkDnXSALZGwIl6F41Zpvv2eFFe/4+SGgnUZ23ATKS
        zGp9/j2qTrE/nztJ1sFFbDaChpb3HRNjKRzby/XAF8b0pZSkhWR/ttRmUwrb4uo1ObUIlMb1g7kmo
        Ut8By4Q8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gzk0A-0000SH-Qx; Fri, 01 Mar 2019 15:23:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4074F203CCAB3; Fri,  1 Mar 2019 16:23:05 +0100 (CET)
Date:   Fri, 1 Mar 2019 16:23:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:06:17PM +0100, Dmitry Vyukov wrote:
> It involves asm, hardware exceptions, UD2 instructions. It also seems
> to use arch-dependent code in arch-independent files: there is no RSI
> on other arches, does this compile on non-x86?

> > +#ifndef kasan_report
> > +#define kasan_report(addr, size, is_write, ip) __kasan_report(addr, size, is_write, ip)
> > +#endif

Should build; but I've not tried yet.

I'll push the lot out to 0day, that'll yell loudly if I messed that up.

But yes, I'll try some annotation, see what that looks like.
