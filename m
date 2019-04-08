Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB532C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4D321473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHY2aZyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfDHPHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:07:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfDHPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6d9mR4p7vs7OsmiaEc7Ha2nAzVtyWfYKDp8ELxTJV7Q=; b=oHY2aZyVAkJ/tu31jCXw+fyda
        iJfGHG0GUxDFZX48MmsBs8GIQpn/LHNVjKz00cEnzSS7MXf0qzaka/T0QkanePGeNuNGrLeI/4Hkv
        enlAODK+wAycHjRSmFX+so4O74DmFb901Lv0MgJCJW+yoiCTRH+L2dBHI+SWmq4+uNDK4x9UiqbP/
        pDcOwOXdO1A7hBzkcOJKoytOrcRwSUUe8iAVNrWOYf21Z4M0/vNChJS5/PFSkhD6trPiitiDq2AXQ
        W99oKC4Ur5eJzWsOy9R22AjG1y/3rqauQytUBhNQVHRe8FG5P4cKCZN/bS+j0gu/bJuE+dYTak5Ka
        PftnhS7YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDVrN-0007c0-T3; Mon, 08 Apr 2019 15:06:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 05C9629B0DE15; Mon,  8 Apr 2019 17:06:55 +0200 (CEST)
Date:   Mon, 8 Apr 2019 17:06:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 08/12] perf/x86/intel: Add Icelake support
Message-ID: <20190408150654.GV12232@hirez.programming.kicks-ass.net>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190402194509.2832-9-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402194509.2832-9-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:45:05PM -0700, kan.liang@linux.intel.com wrote:
> +static struct event_constraint *
> +icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
> +			  struct perf_event *event)
> +{
> +	/*
> +	 * Fixed counter 0 has less skid.
> +	 * Force instruction:ppp in Fixed counter 0
> +	 */
> +	if ((event->attr.precise_ip == 3) &&
> +	    ((event->hw.config & X86_RAW_EVENT_MASK) == 0x00c0))
> +		return &fixed_counter0_constraint;

Does that want to be:

		event->hw.config == X86_CONFIG(.event=0xc0)

?

That is, are there really bits we want to mask in there?

> +
> +	return hsw_get_event_constraints(cpuc, idx, event);
> +}
