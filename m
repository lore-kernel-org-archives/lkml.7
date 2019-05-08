Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8AEC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DE620989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 11:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AB4wC32n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfEHL7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 07:59:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfEHL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 07:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E9zW2CJ7wPCUDe/dPpC8R4CIQgXrvuLGroF8bFweZOY=; b=AB4wC32nzQX1oMvaZP8h7mnPB
        zdawYfvajr0Fepltw61wBBZUUoKNukjUQz+Kju64NNJWnTndq3OEGO7HxSwd30czthdGOh/kkpTML
        ++c21m5og+eJPjl42z5AAFE7PrYcEY2TPpxP5n01Uv2LzvueWk6Jxu+YAhUEsIO3YdyP9r2ZQpO7b
        7PZ/q5TEZsWZzvO/XjX2LIyZMg0TQt6fZ2m6g3G5Gg8T+8MZOL2K+RNM+X5QSLpbggont5k/KKP2N
        F376iNhCHlN0apuNwBL9n5omyUoBKU/6j/x2FmYUoZshcNa6LDG1QOpoonL2gX69FSV4OOTeoWCct
        pw7lKf6dA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOLEi-0002e5-3q; Wed, 08 May 2019 11:59:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 770F82029F884; Wed,  8 May 2019 13:59:46 +0200 (CEST)
Date:   Wed, 8 May 2019 13:59:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        acme@kernel.org, eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH 0/6] Perf uncore support for Snow Ridge server
Message-ID: <20190508115946.GL2606@hirez.programming.kicks-ass.net>
References: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556672028-119221-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:53:42PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The patch series intends to enable perf uncore support for Snow Ridge
> server.
> 
> Here is the link for the uncore document.
> https://cdrdv2.intel.com/v1/dl/getContent/611319
> 
> Patch 1: Fixes a generic issue for uncore free-running counter, which
> also impacts the Snow Ridge server.
> 
> Patch 2-6: Perf uncore support for Snow Ridge server.
> 
> Kan Liang (6):
>   perf/x86/intel/uncore: Handle invalid event coding for free-running
>     counter
>   perf/x86/intel/uncore: Add uncore support for Snow Ridge server
>   perf/x86/intel/uncore: Extract codes of box ref/unref
>   perf/x86/intel/uncore: Support MMIO type uncore blocks
>   perf/x86/intel/uncore: Clean up client IMC
>   perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge
> 
>  arch/x86/events/intel/uncore.c       | 122 +++++--
>  arch/x86/events/intel/uncore.h       |  41 ++-
>  arch/x86/events/intel/uncore_snb.c   |  16 +-
>  arch/x86/events/intel/uncore_snbep.c | 601 +++++++++++++++++++++++++++++++++++
>  4 files changed, 737 insertions(+), 43 deletions(-)

Thanks!
