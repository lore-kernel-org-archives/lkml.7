Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E60C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CF420708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LqvBMHhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKVJgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:36:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37400 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfKVJgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ko1Cym1MHkI3Oi6J857m4byDichSMwjr8wmTfeyd95c=; b=LqvBMHhhrlSdZthYGRo6fzBd/l
        Vo0prc56fCFRvdHqBRkCwIay9zPX9UcxAl4pm9n6GJOd1vAZpABA/qyzVbE35Zq6HY1SMDgoIUaVi
        GXDIy/udvzyi92x1jn68sfGvbimPdzkaHiYBXR20bdFsRcAmFVXfh9cFR6ufcOwRt0rexn8yCRZLn
        ZEQzKPAL18OUDkOqeBcJjl5JEuTkkIdjEdrqPb+z0wF01K5+WmRW2UqWvRoKRZf1xB6LLqo8wRL7g
        Y7V56kPxWS/YLbG0zg/5mK/BnSakWxCEBxpPmu3CIUT1hq9mfrlOX0nqWpM8krgEl9xYg4USHXdas
        n04udC2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iY5Mf-0006ml-OJ; Fri, 22 Nov 2019 09:36:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37324300606;
        Fri, 22 Nov 2019 10:35:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6899420321C89; Fri, 22 Nov 2019 10:36:32 +0100 (CET)
Date:   Fri, 22 Nov 2019 10:36:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191122093632.GB4097@hirez.programming.kicks-ass.net>
References: <20191121195634.GV4097@hirez.programming.kicks-ass.net>
 <066A48B7-296F-4953-89A6-588509FC0303@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <066A48B7-296F-4953-89A6-588509FC0303@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 01:01:08PM -0800, Andy Lutomirski wrote:
> 
> > On Nov 21, 2019, at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > ﻿On Thu, Nov 21, 2019 at 09:51:03AM -0800, Andy Lutomirski wrote:
> > 
> >> Can we really not just change the lock asm to use 32-bit accesses for
> >> set_bit(), etc?  Sure, it will fail if the bit index is greater than
> >> 2^32, but that seems nuts.
> > 
> > There are 64bit architectures that do exactly that: Alpha, IA64.
> > 
> > And because of the byte 'optimization' from x86 we already could not
> > rely on word atomicity (we actually play games with multi-bit atomicity
> > for PG_waiters and clear_bit_unlock_is_negative_byte).
> 
> I read a couple pages of the paper you linked and I didn’t spot what
> you’re talking about as it refers to x86.  What are the relevant word
> properties of x86 bitops or the byte optimization?

The paper mostly deals with Power and ARM, x86 only gets sporadic
mention. It does present a way to reason about mixed size atomic
operations though.

And the bitops API is very much cross-architecture. And like I wrote in
that other email, having audited the atomic bitop width a number of
times now makes me say no to anything complicated.
