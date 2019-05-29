Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B717D2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 09:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OSsvfdXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfE2JrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 05:47:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2JrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 05:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UKyuDAkPKwwSacsWVLKxWWxL9wOlFAut+2qC4adY+g4=; b=OSsvfdXoF+PKP3Ps79Tocy7ZF
        0NxLVYGDnDwqwOnRMnQgZKSLNAO3uPwcCV7wvnvIEbGlkpbS6BFpA1i3qGsWFq1EMlLbgG2Bqb21F
        UsiBSXwQOWQ63zCkfquOdf1UpQLXmHGnuKsAlyM5ziWogY05bTf04/tJuEKkXJ/KjXFEAEgAFuBBC
        4wptVKi0WRDAEZ7/HrenNxIk9WhNwRQtUOZT/vEJeexx8784DYbvGikfyHQhWek8MbhJ47d3r/DKm
        iHiofNg4NDTIQd4+O9WGrbSpUlfQNPtHr0b7nre2swHdpMwICPsCSdsHgszNGje4a82P6stlW5QyC
        vdNZ5WMsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVvAj-00036F-S6; Wed, 29 May 2019 09:47:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7F5A4201A7E42; Wed, 29 May 2019 11:46:59 +0200 (CEST)
Date:   Wed, 29 May 2019 11:46:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        acme@kernel.org, mark.rutland@arm.com
Subject: Re: [RFC 4/7] arm64: pmu: Add function implementation to update
 event index in userpage.
Message-ID: <20190529094659.GK2623@hirez.programming.kicks-ass.net>
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-5-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528150320.25953-5-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 04:03:17PM +0100, Raphael Gault wrote:
> +static int armv8pmu_access_event_idx(struct perf_event *event)
> +{
> +	if (!(event->hw.flags & ARMPMU_EL0_RD_CNTR))
> +		return 0;
> +
> +	/*
> +	 * We remap the cycle counter index to 32 to
> +	 * match the offset applied to the rest of
> +	 * the counter indeces.
> +	 */
> +	if (event->hw.idx == ARMV8_IDX_CYCLE_COUNTER)
> +		return 32;
> +
> +	return event->hw.idx;

Is there a guarantee event->hw.idx is never 0? Or should you, just like
x86, use +1 here?

> +}
