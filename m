Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBA220815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PW3JHgEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfCDMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:44:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43990 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCDMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dHofGZIDuuCTbB2DhNnvh5fldYsZAwGdXhdWGYPot98=; b=PW3JHgEcH1eOD07jpvH37I4TB
        HBWNgvyZ8TZr1NkrvHWrC5UZ00rzWMFmeFWIXhj5XMOQXMvjuaVsUR/4yrjAIBSAAVnS4jvemUYSJ
        NEZ7oIW1C7RbkZWGSDDO7goAzaPkM+0NbPbmjpdWLNliC/T0HN7Ucvvn25JFUM2FFnMq4Je3Q9j3Z
        4oTT6sgND1cuftPZB5ySTw8jbQQ32kgQH1Vuc76K44MGRGgZeui00RCVHqY+owZt3SzHitHtye9Of
        SXzgabJE9RuB5lVJQk1CIMnLp8/VjG7DLh72Wdif57jsKzVEiNiebrGGZR1I5PXI6lx8u1lFOvP30
        3XK3FCAgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0mxO-0004Me-DE; Mon, 04 Mar 2019 12:44:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D55820295395; Mon,  4 Mar 2019 13:44:33 +0100 (CET)
Date:   Mon, 4 Mar 2019 13:44:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 01/17] x86/common: Align cpu_caps_cleared and
 cpu_caps_set to unsigned long
Message-ID: <20190304124433.GE32477@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-2-git-send-email-fenghua.yu@intel.com>
 <461f162c-694f-2bb7-f9cb-55fa915434bc@redhat.com>
 <20190304101736.GC32477@hirez.programming.kicks-ass.net>
 <d1f6f2f1-60c9-9dc8-0ad5-14cf94e83487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f6f2f1-60c9-9dc8-0ad5-14cf94e83487@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:48:18AM +0100, Paolo Bonzini wrote:
> True that.  On the other hand btsl/btrl is also one byte smaller if no 
> operand is %r8-%r15.

Because then we loose the REX prefix, right. Now _that_ might actually
be a reason to do that :-)

> In any case, /me wonders if we should have a macro like
> 
> #define DECLARE_LE_BITMAP(name,bits) \
>         u32 name[DIV_ROUND_UP(bits, 32)] __aligned(sizeof(unsigned long))

 s/u32/__le32/

To go in bitops/le.h, sure, if there's enough users.
