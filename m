Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209CCC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EDD20679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bvXgKKP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1Hsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:48:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfH1Hsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/01L4IPm4amKPtYv6NSrVKnaf1j+9soOwRRt3v0Kb0E=; b=bvXgKKP/sqmbnCKKVuDqMvxLQ
        51iyqj+uJEij2+NB9Ojwt60pu3Db9VOqkDUXSNdd5xac9G3IRi0Dp0E6zbCRt3tkQ4Hg22125hUFf
        p/9vc5ggjg+QOGWKzAoKYnL2isn3HGFd71vaLIQZrZeafaspKWvmTESznofZsp5Lfjrrs4sIX4+Hb
        bMS1SIDI3mmz0ogakmJ3AXAkdSYn6/nNzZry4pmDL1nh6FVEwg/UEuZ5DsrKNJ0ZEkz3GhOFmrAaE
        3NzmdqASE6y9+0lznRdJRYmKP7A5kIGI/A41XPkURya1yeSnKNPZZkjEyID2pWXzm/vdFmjmPa5bM
        /LAxlZCdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2sgz-0007DZ-I9; Wed, 28 Aug 2019 07:48:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25968307594;
        Wed, 28 Aug 2019 09:47:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E7A320230B04; Wed, 28 Aug 2019 09:48:32 +0200 (CEST)
Date:   Wed, 28 Aug 2019 09:48:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V3 2/8] perf/x86/intel: Basic support for metrics
 counters
Message-ID: <20190828074832.GA2369@hirez.programming.kicks-ass.net>
References: <20190826144740.10163-1-kan.liang@linux.intel.com>
 <20190826144740.10163-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826144740.10163-3-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 07:47:34AM -0700, kan.liang@linux.intel.com wrote:
> Move BTS index to 47. Because bit 48 in the PERF_GLOBAL_STATUS is used
> to indicate the overflow status of PERF_METRICS counters now.

> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 457d35a75ad3..88a506312a10 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -175,11 +175,56 @@ struct x86_pmu_capability {
>  /*
>   * We model BTS tracing as another fixed-mode PMC.
>   *
> - * We choose a value in the middle of the fixed event range, since lower
> + * We choose value 47 for the fixed index of BTS, since lower
>   * values are used by actual fixed events and higher values are used
>   * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
>   */
> -#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
> +#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 15)

Can be its own patch.
