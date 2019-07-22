Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D85BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8FA21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JWJk92tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfGVTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:19:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfGVTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TNYc36eeo7+eH1UK2QA3bSHuKOE1i689RAYqUbweNbU=; b=JWJk92tA4XpPNvxZQnxoWNjty8
        fRh65YWbLaeBsKrr+LDfExVgJXhRv4tbc6oVK7z4ly1AY5QQIbkXsVm/B0Y9+Ld8xu1/oqhOxqHN3
        Jn5buVo1qSc+WEHZEKR/6jTWOZbMD36E3dLZPs3qdtBUgU8oqK3t3K0SNjmZ0ZhnPEKX9bKSvX2Oj
        dPJbxC3F2Zbw0OCY2Zon41W7oodXkIKiWtSP4hJj21Jp7PXzwCzwgeFWoK/pPyxs97ENAP9Co+Kw0
        RTNYgvVwEZi/JGUzPC31rXbdkFrBTlzcqK3LVaR+X2kN6ljEO7e/qdpoDMpbIS3l9y2e4USQDttq2
        k7LOpnQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpdq9-0006Bf-Dm; Mon, 22 Jul 2019 19:19:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29C27980C59; Mon, 22 Jul 2019 21:19:14 +0200 (CEST)
Date:   Mon, 22 Jul 2019 21:19:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
Message-ID: <20190722191914.GE6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
 <20190719005837.4150-2-namit@vmware.com>
 <20190722182159.GB6698@worktop.programming.kicks-ass.net>
 <C93C241E-E078-4825-8C59-39C84D30F9CB@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C93C241E-E078-4825-8C59-39C84D30F9CB@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 06:34:22PM +0000, Nadav Amit wrote:
> > On Jul 22, 2019, at 11:21 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Thu, Jul 18, 2019 at 05:58:29PM -0700, Nadav Amit wrote:
> >> +/*
> >> + * Call a function on all processors.  May be used during early boot while
> >> + * early_boot_irqs_disabled is set.
> >> + */
> >> +static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
> >> +{
> >> +	on_each_cpu_mask(cpu_online_mask, func, info, wait);
> >> +}
> > 
> > I'm thinking that one if buggy, nothing protects online mask here.
> 
> on_each_cpu_mask() calls __on_each_cpu_mask() which would disable preemption.
> The mask might change, but anyhow __smp_call_function_many() would “and” it,
> after disabling preemption, with (the potentially updated) cpu_online_mask.

Ah, indeed, as long as we double check the state after disabling
preemption things should be fine.

> What is your concern?

Pavlov reaction to seeing a naked cpu_online_mask :-)

