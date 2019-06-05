Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2454BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034662075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFEL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:58:20 -0400
Received: from foss.arm.com ([217.140.101.70]:58612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbfFEL6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:58:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A2F80D;
        Wed,  5 Jun 2019 04:58:19 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68E173F5AF;
        Wed,  5 Jun 2019 04:58:18 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:58:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seqlock: mark raw_read_seqcount and read_seqcount_retry
 as __always_inline
Message-ID: <20190605115815.GG15030@fuggles.cambridge.arm.com>
References: <20190603091008.24776-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603091008.24776-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 11:10:08AM +0200, Anders Roxell wrote:
> If CONFIG_FUNCTION_GRAPH_TRACER is enabled function sched_clock() in
> kernel/time/sched_clock.c is marked as notrace. However, functions
> raw_read_seqcount and read_seqcount_retry are marked as inline. If
> CONFIG_OPTIMIZE_INLINING is set that will make the two functions
> tracable which they shouldn't.

Might be nice to elaborate a bit here on what goes from specifically for
seqlocks. I assume something ends up going recursive thanks to the tracing
code?

With that:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
