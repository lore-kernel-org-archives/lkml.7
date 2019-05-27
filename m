Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E7EC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A20821734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c4uyFO9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE0JPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:15:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0JPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=afce9BX+KBRkdHnIunqFc4NYfkLDXj/i7H6nj375lY8=; b=c4uyFO9tXoK3szqSD8sM1mtTS
        iFPY9f8UfI79TXxIgo6vEBxhSTGKb/krRiR77Aie7aiv3wmFnlXA4dlKiVe42ZHnShTzZv2jndM+S
        QD9eJaSWdDN8OkSwMio9dMeODUCcMbGFH6fBirHWp9Wl5XDn/Td3Cmf7IVv3jUxrs/NgsG5B2lSTC
        vcr2HNrRBnmyERHBPKDnQef0F1n8fOgFn5Y8XLC06nh5IAoKz8HwZBgB9/CjlZQIu2ByHFHDqXG2N
        X2ICBpcN63319KU3QCg3rxsK9CQgBLr9gLJlupef1pqr+wLY5pOxc1WsMMqGf6Hc5IyQpWqoEk1SD
        i3q+qDM8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVBjD-0003kP-Vm; Mon, 27 May 2019 09:15:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D0A42071511B; Mon, 27 May 2019 11:15:34 +0200 (CEST)
Date:   Mon, 27 May 2019 11:15:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 3/6] smp: Run functions concurrently in
 smp_call_function_many()
Message-ID: <20190527091534.GS2623@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
 <20190525082203.6531-4-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525082203.6531-4-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		/*
> +		 * Choose the most efficient way to send an IPI. Note that the
> +		 * number of CPUs might be zero due to concurrent changes to the
> +		 * provided mask or cpu_online_mask.
> +		 */

Since we have preemption disabled here, I don't think online mask can
shrink, cpu-offline uses stop_machine().

> +		if (nr_cpus == 1)
> +			arch_send_call_function_single_ipi(last_cpu);
> +		else if (likely(nr_cpus > 1))
> +			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
> +	}
