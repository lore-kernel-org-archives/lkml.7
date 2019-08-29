Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4686C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9612A2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 09:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="18iUK6Bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfH2JbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 05:31:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56298 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2JbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rCGISQyK/CqSKT+aR9Rsl5/9L4NcBCG9bnaseeSeY1Y=; b=18iUK6BiAKQ7aTuYvA36ir/D2
        QTVoOmvI3b0nQn49YFDhLADhEXBOsvt2/sEDyBpWqI9XTZRDpAcZNWm6xDqz/kDt+xL/ZoPs8arGm
        qHKWzieqhODRlc3qWvVa1XAcqN+goAcGqXnih9AhAT7LiQ6PRbz5JccICBNHkVbPU73tSz/xEKe0S
        SCsmV5DwUDUzg0HfDICOswzc7/8pcH/9LropZKkJKpBnOxZk1RDiYaDAZSojA+Y4tmn+lKrG6CN+l
        M43KU8hjS2cTUwC/b1d/cqF6KvGbzOprs+iAX+B6x1ri051YontGpJ1sLvump5rKKXsV8wsKfNSlS
        ZPZ4f0NZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3Gla-0000ms-Sa; Thu, 29 Aug 2019 09:30:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40D11307138;
        Thu, 29 Aug 2019 11:30:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 681352235E598; Thu, 29 Aug 2019 11:30:53 +0200 (CEST)
Date:   Thu, 29 Aug 2019 11:30:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        x86@kernel.org
Subject: Re: [PATCH] x86/math64: Provide a sane mul_u64_u32_div()
 implementation for x86_64
Message-ID: <20190829093053.GR2386@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-4-kan.liang@linux.intel.com>
 <20190828151921.GD17205@worktop.programming.kicks-ass.net>
 <20190828161123.GQ2386@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828161123.GQ2386@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:11:23PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 28, 2019 at 05:19:21PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 26, 2019 at 07:47:35AM -0700, kan.liang@linux.intel.com wrote:
> 
> > > +	return  mul_u64_u32_div(slots, val, 0xff);
> > 
> > But also; x86_64 seems to lack a sane implementation of that function,
> > and it currently compiles into utter crap (it can be 2 instructions).

This one actually builds defconfig :-)

---
Subject: x86/math64: Provide a sane mul_u64_u32_div() implementation for x86_64
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Aug 28 17:39:46 CEST 2019

On x86_64 we can do a u64 * u64 -> u128 widening multiply followed by
a u128 / u64 -> u64 division to implement a sane version of
mul_u64_u32_div().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/div64.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index 20a46150e0a8..9b8cb50768c2 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -73,6 +73,19 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 
 #else
 # include <asm-generic/div64.h>
+
+static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 div)
+{
+	u64 q;
+
+	asm ("mulq %2; divq %3" : "=a" (q)
+				: "a" (a), "rm" ((u64)mul), "rm" ((u64)div)
+				: "rdx");
+
+	return q;
+}
+#define mul_u64_u32_div	mul_u64_u32_div
+
 #endif /* CONFIG_X86_32 */
 
 #endif /* _ASM_X86_DIV64_H */
