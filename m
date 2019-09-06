Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E132E20640
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ko0EMTSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392539AbfIFHlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:41:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390377AbfIFHlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iJtXmWMKcn3iCXNa/Hctfd9mlp3VUMAuUJlQTpyeJJY=; b=Ko0EMTSFOIYfVQMqXEm3XgbLG
        s/6LDJnSDqs9gv/GTg44o8jGYklcj5DNtuR8z5TwUhn0dGyIQ2jB1Cf6mm/zlLHQCJrhGpMYFzidf
        OW6I0m1MSYLv623ElCTNPgMQprOz1+J9IgClyyYKZwb8NQEvp7NzGBm+W07L99QOGu8KHMQ/ul/lU
        0zOukNii4FV56Ep1Sf6zFAbcvgTWqnmLRm4mu+GEfxQ0Jz7z9AYD6ExKjbInyM7LnD074x91weZtm
        wAenRl5Df9j5VCoEnOdO6UlX6k+y9oXeAypXtDbVX60HIabxaaeWqS5DuYhHpjBYyHFQwhpLKoNjV
        6K6dJpwhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i68rj-0005fp-7T; Fri, 06 Sep 2019 07:41:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6B4D303121;
        Fri,  6 Sep 2019 09:40:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 044B229DE780A; Fri,  6 Sep 2019 09:41:04 +0200 (CEST)
Date:   Fri, 6 Sep 2019 09:41:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/4] Cleanup: sched/membarrier: only sync_core before
 usermode for same mm
Message-ID: <20190906074104.GT2349@hirez.programming.kicks-ass.net>
References: <20190906031300.1647-1-mathieu.desnoyers@efficios.com>
 <20190906031300.1647-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906031300.1647-4-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:12:59PM -0400, Mathieu Desnoyers wrote:
> When the prev and next task's mm change, switch_mm() provides the core
> serializing guarantees before returning to usermode. The only case
> where an explicit core serialization is needed is when the scheduler
> keeps the same mm for prev and next.
> 
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Cc: Chris Metcalf <cmetcalf@ezchip.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Kirill Tkhai <tkhai@yandex.ru>
> Cc: Mike Galbraith <efault@gmx.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/sched/mm.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 4a7944078cc3..8557ec664213 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -362,6 +362,8 @@ enum {
>  
>  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>  {
> +	if (current->mm != mm)
> +		return;
>  	if (likely(!(atomic_read(&mm->membarrier_state) &
>  		     MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE)))
>  		return;

So SYNC_CORE is about I$ coherency and funny thing like that. Now it
seems 'natural' that if we flip the address space, that I$ also gets
wiped/updated, because the whole text mapping changes.

But did we just assume that, or did we verify the truth of this? (I'm
just being paranoid here)
