Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63471218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 07:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w3VFws0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfCUH6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:58:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59252 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbfCUH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 03:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BCYTt+DVMwc6+hCDhi6nLX8WjMnsxzYSVrapY6kMfCw=; b=w3VFws0FH3JukYL56y7250J6z
        2LM10/hp2jhDUc38Axbn2PKNOpkUQeMT0P/WTKiPhePL/zi4G0Lv7KQ0N9Zybi6dVaBxiFzVZg2WN
        tOYMF5qnyvMKMiBM0tzH5EQDaHtauIfYYwcb/5MtiCgDCJkABSxEb5XwjTPzWtnXZ95rAV2O1545z
        /LTbz0sajwVhd7VXeMvozwNnkHF4l3TIVSPkmwJisq7/OiMkx2J8JfTchi8ajxBydcnrGseZTswHi
        zx8bAykin2/87ozUTunMXMtLXLQHmzK615q5qbnFiNYTohEqu2y1SKcnTMn+oxRUwty+on6DlgCsf
        V+OWjlGoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6saW-000832-Q7; Thu, 21 Mar 2019 07:58:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55EDB2391A9A9; Thu, 21 Mar 2019 08:58:07 +0100 (CET)
Date:   Thu, 21 Mar 2019 08:58:07 +0100
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
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Message-ID: <20190321075807.GK6058@hirez.programming.kicks-ass.net>
References: <2816566.rddYshD6lm@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2816566.rddYshD6lm@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:00:52AM +0100, Rafael J. Wysocki wrote:
> + * The Performance and Energy Bias Hint (EPB) allows software to specify its
> + * preference with respect to the power-performance tradeoffs present in the
> + * processor.  Generally, the EPB is expected to be set by user space through
> + * the generic MSR interface (with the help of the x86_energy_perf_policy tool),
> + * but there are two reasons for the kernel to touch it.

So I hate /dev/msr with a passion. It is absolute atrocious crap.

Please, just make a real interface for this if it is important.
