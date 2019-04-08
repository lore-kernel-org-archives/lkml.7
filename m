Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877612147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LsxpmR0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfDHOzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:55:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfDHOzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FCbUGhNoYA820stJOEekOHfj0GOo0wpw/xkTJUhphOQ=; b=LsxpmR0eccPe+uJuQtk1FTCyp
        PfXRjVq+jci1hMeXTnjQAVKGE5SF1z1CNDDZ4P7cFg1ztp+rq8Mu2z36WG9I7TKGXaqNbe5zrSGEx
        P1ljaSB4FviEk2qJa0yspYsOeDjLr9Es/3JNMfFxw/GajP4Ydtwh/v1MFX4rc/mmiHKuQFOPOcj/p
        XN/aMV//h41aGEOygWO09ZL9VWvkVwYwOpcCOZTH6E/dEXKFyrr3DtbxRHqdTQjqsA+aImKJZooXJ
        IOCdjmNEBC+CRm+vuZhtQmmGOs5tXsqeZdhCMlBaQSmqKCIPHhnbuCKPUFx2gmGttN2puzEVDiZe8
        MWV2ANthw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDVfx-0007WE-L3; Mon, 08 Apr 2019 14:55:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E583B2030C798; Mon,  8 Apr 2019 16:55:07 +0200 (CEST)
Date:   Mon, 8 Apr 2019 16:55:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 05/12] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190408145507.GU12232@hirez.programming.kicks-ass.net>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-6-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402194509.2832-6-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:45:02PM -0700, kan.liang@linux.intel.com wrote:
> +static u64 pebs_update_adaptive_cfg(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	u64 sample_type = attr->sample_type;
> +	u64 pebs_data_cfg = 0;
> +	bool gprs, tsx_weight;
> +
> +	if ((sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) ||
> +	    attr->precise_ip < 2) {
> +
> +		if (sample_type & PERF_PEBS_MEMINFO_TYPE)
> +			pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
> +
> +		/*
> +		 * Cases we need the registers:
> +		 * + user requested registers
> +		 * + precise_ip < 2 for the non event IP
> +		 * + For RTM TSX weight we need GPRs too for the abort
> +		 * code. But we don't want to force GPRs for all other
> +		 * weights.  So add it only collectfor the RTM abort event.
> +		 */
> +		gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
> +			      (attr->sample_regs_intr & 0xffffffff);

did that want to be:

			(attr->sample_regs_intr & PEBS_GPRS_REGS);
?

> +		tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
> +			     ((attr->config & 0xffff) == x86_pmu.force_gpr_event);

Why does that force_gpr_event exist? and why isn't it called
rtm_abort_event?

Also did that want to be:

			(attr->config & INTEL_ARCH_EVENT_MASK)
?

> +		if (gprs || (attr->precise_ip < 2) || tsx_weight)
> +			pebs_data_cfg |= PEBS_DATACFG_GPRS;
> +
> +		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> +		    (attr->sample_regs_intr >> 32))

Surely, you meant:

		(attr->sample_regs_intr & PEBS_XMM_REGS)
?

> +			pebs_data_cfg |= PEBS_DATACFG_XMMS;
> +
> +		if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +			/*
> +			 * For now always log all LBRs. Could configure this
> +			 * later.
> +			 */
> +			pebs_data_cfg |= PEBS_DATACFG_LBRS |
> +				((x86_pmu.lbr_nr-1) << PEBS_DATACFG_LBR_SHIFT);
> +		}
> +	}
> +	return pebs_data_cfg;
> +}
