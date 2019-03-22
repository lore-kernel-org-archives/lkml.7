Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C875C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127D8218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0FE4OOn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfCVPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:00:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfCVPAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dYjCVcv6V5v51cbzYdQl2UO0Sx67KxhRWRVbVYjb8Wc=; b=0FE4OOn29jCGsibK0eOvjADdg
        V7+Yom5ubyTxHfy2Dcf2fUCVB57MT9GnPxv8DCvR4+jLz/c66LO1G2KsiJeSvp2n6O/6A0qwX7lUt
        hOnlCaVRhLTFV5o2NMYwOv0xKrapTpzSMvkCg2YmTWWme1gQP8YuPHWH2hNw2oRmz0dQngNLRVt8h
        BZSa7n1sB0/cgrF8rkrc0xBMxGVFYX89BOOsBI62kQtxWQuH9grMu3Up6UzYejV5sNuZ5jKdUY5H4
        k1RKEHQle4cgznGwq6/I7WBKrILD9sio1sqpCbPTuKk16gqebqWct98l52gOJiWYAvZBaZx4Qcjuv
        uMfK6fHhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7LeU-0002Ou-W8; Fri, 22 Mar 2019 15:00:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72E99287233CD; Fri, 22 Mar 2019 16:00:09 +0100 (CET)
Date:   Fri, 22 Mar 2019 16:00:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Message-ID: <20190322150009.GY6058@hirez.programming.kicks-ass.net>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762575.ER2xjzr9E1@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> +	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
> +			    (epb & ~EPB_MASK) | val);

That's two back-to-back IPIs and a giant waste.

If you'd use a proper msr shadow variable, you'd not have to do the
rdmsr_on_cpu :-)
