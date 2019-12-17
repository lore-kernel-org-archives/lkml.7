Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E1C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32C02072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmixie/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLQI7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:59:05 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51660 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfLQI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=umUpQwNCFcx4pJ445vi4RUlvQ3RCBfh2CumoCKRy+mk=; b=dmixie/nerThIK4dsyBBVW4EI
        eYS7fSANuZVJl7nMZkU+KmMDZgIrp7uFvjbNKnCto4kwOuUvebXu7miWQjkatuoUKChmlGdg7LNB+
        5I8HS7wI1IVkTYfF26Q96j89zUo+N4dddai0r7GnJtXnnH1gBHPdt0sMxmFsNZ8AaBuA2aeVUI0LA
        KzRV5OW6rp0WgrpGx0PQbZqH+VtItNULFEfyhl8Ku9WQF5UKRC4pqJCBpgrOJCHjusjwr5JXNCI8J
        KWSYIhRRu8LAF7Pqo6BE0WwAuk6Bl/omWYsAOQFfvGYB1Fssr992VAjtBT4h5bfpsEarqEVPtiYkM
        W0v6zSaTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih8gz-0001jU-7R; Tue, 17 Dec 2019 08:58:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE79E3007F2;
        Tue, 17 Dec 2019 09:57:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F36782B3D7E90; Tue, 17 Dec 2019 09:58:54 +0100 (CET)
Date:   Tue, 17 Dec 2019 09:58:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 2/2] mm/mmu_gather: Avoid multiple page walk cache
 flush
Message-ID: <20191217085854.GW2844@hirez.programming.kicks-ass.net>
References: <20191217071713.93399-1-aneesh.kumar@linux.ibm.com>
 <20191217071713.93399-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217071713.93399-2-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:47:13PM +0530, Aneesh Kumar K.V wrote:
> On tlb_finish_mmu() kernel does a tlb flush before  mmu gather table invalidate.
> The mmu gather table invalidate depending on kernel config also does another
> TLBI. Avoid the later on tlb_finish_mmu().

That is already avoided, if you look at tlb_flush_mmu_tlbonly() it does
__tlb_range_reset(), which results in ->end = 0, which then triggers the
early exit on the next invocation:

	if (!tlb->end)
		return;
