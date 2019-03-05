Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BF32087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b9LMNNek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfCEMdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:33:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfCEMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8r7yyoZkGPpqeJakxKdeZnV8kOzpJx8bvTvkqExhPjs=; b=b9LMNNek8JWyfSwbWDVAwFy3a
        0U9Be0jIF5cWcdZEd1LPGrwLyxexd0tTlX5JXu2YrUr9TjthUf459wDC49c3+1fjNDdHyaOVPp/bP
        AgxmbDGjqaRentWlfmDgRLZT5BLKOlUUU/Y5ZZrwG/ZRwH/uT3STB6HEfGB1fdnO/+BoJQux3gmoT
        WFWdGBVinAIjK4b/Hrk4TxqoLKZv2ZVOy/54ydQDN043VP9opS0rMGcQVe2hfgm27FqcWwTkFdMws
        lYF/hQrInh/gW4/dPvEWFu5RLkQuzbSi2W5Kfi/DH8PDomg3QGPfR943rKNQP/37b1vUIBYkwWZOd
        +chFxWFlA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h19GE-0002pw-Qi; Tue, 05 Mar 2019 12:33:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4628A20135F52; Tue,  5 Mar 2019 13:33:29 +0100 (CET)
Date:   Tue, 5 Mar 2019 13:33:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        devel@linuxdriverproject.org
Subject: Re: [PATCH v2] x86, hyperv: fix kernel panic when kexec on HyperV
Message-ID: <20190305123329.GK32477@hirez.programming.kicks-ass.net>
References: <20190305121703.29769-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305121703.29769-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 08:17:03PM +0800, Kairui Song wrote:
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7abb09e2eeb8..34aa1e953dfc 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -406,6 +406,12 @@ void hyperv_cleanup(void)
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  
> +	/* Cleanup hypercall page reference before reset the page */
> +	hv_hypercall_pg = NULL;
> +
> +	/* Make sure page reference is cleared before wrmsr */

This comment forgets to tell us who cares about this. And why the wrmsr
itself isn't serializing enough.

> +	wmb();
> +
>  	/* Reset the hypercall page */
>  	hypercall_msr.as_uint64 = 0;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);

That looks like a fake MSR; and you're telling me that VMEXIT doesn't
serialize?
