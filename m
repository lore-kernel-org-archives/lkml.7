Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799FBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E8721743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BVI0+BiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfD3JEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:04:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfD3JED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4gQNip9X7+WtfQxxzoOVYIad3pYtgAPuwNAK/8FhDEU=; b=BVI0+BiEXLbfm/foPysxDMdiw
        i3wyMuYvfjxUHy4XmhGAzIjA+chi7eembXc9tMDt/xRfgZwGv3dKMk2YSRluWA9HvncksILQlTah6
        r+i8nA8+sBeTUbDR1972ePKeRiY8Pp/fp7E6tNPC/iqd9Ey7LNeN8j21lwFfEehTemwYDzdK6UInF
        oDRfL1/PtDSamrKk7sTKL6DEgG1xof73bhQmMylXxbQWAqIyfgtECukCONohQUuusyPIFaR7yrJBC
        oal0bx+AMHjcjGE6tAGaDi9ks7V9ZkAaq8oKGjE1XrbIMinDJFCxHoBWGLzYRJ9Btyh7zJHCvVYHE
        tTb6uau+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLOgC-00065D-AP; Tue, 30 Apr 2019 09:04:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B056829AAD2A8; Tue, 30 Apr 2019 11:03:58 +0200 (CEST)
Date:   Tue, 30 Apr 2019 11:03:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        eranian@google.com, tj@kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 3/4] perf cgroup: Add cgroup ID as a key of RB tree
Message-ID: <20190430090358.GL2623@hirez.programming.kicks-ass.net>
References: <1556549045-71814-1-git-send-email-kan.liang@linux.intel.com>
 <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556549045-71814-4-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 07:44:04AM -0700, kan.liang@linux.intel.com wrote:
> +static struct perf_event *
> +perf_event_groups_first_cgroup(struct perf_event_groups *groups,
> +			       int cpu, u64 cgrp_id)
> +{
> +	struct perf_event *node_event = NULL, *match = NULL;
> +	struct rb_node *node = groups->tree.rb_node;
> +
> +	while (node) {
> +		node_event = container_of(node, struct perf_event, group_node);
> +
> +		if (cpu < node_event->cpu) {
> +			node = node->rb_left;
> +		} else if (cpu > node_event->cpu) {
> +			node = node->rb_right;
> +		} else {
> +			if (cgrp_id_low(cgrp_id) < cgrp_id_low(node_event->cgrp_id))
> +				node = node->rb_left;
> +			else if (cgrp_id_low(cgrp_id) > cgrp_id_low(node_event->cgrp_id))
> +				node = node->rb_right;
> +			else {
> +				match = node_event;
> +				node = node->rb_left;
> +				}
> +			}
> +		}
> +		return match;
> +}

That's whitespace challenged.
