Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35702C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CD12075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c8a8dxty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfECPVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:21:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38536 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfECPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0dOyCd2KmgfDQI7XulixUQBVA6MGUC34ow1CgeTC6o0=; b=c8a8dxtycof8ie8Ma+bZ4dcvE
        kofQOWfhtNGkj0lyzq2hTtS57+nrltGQdPts4T//rSVCH1wdTsw/V3/5BoVYA+pujrZZ77DgCaQmG
        yVBknHm1ryt1/CLdCFBgvTaeX9XukgqhrfMWrhNIOOMmQX41GYLpf2r5HwNNGC5gCpGCFdyDvt+0x
        qUNsaiipzzV74f9GJQiYZRLJJKx9NzCiMfSgDPoUPOuN089rBwY6gsSyP4l9Jvh49AC8nT2XGvWd3
        e1jy3qm977LbuIxhA80lATnnhFI8F9OpfAOS7OS+DdyPyU0pYjEWYGe5KgPmM/JcJdtzHZwuG9DrM
        CEl/HuzfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMa07-0000KL-EU; Fri, 03 May 2019 15:21:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3F33214242EE; Fri,  3 May 2019 17:21:25 +0200 (CEST)
Date:   Fri, 3 May 2019 17:21:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v7 12/20] locking/rwsem: Clarify usage of owner's
 nonspinaable bit
Message-ID: <20190503152125.GH2623@hirez.programming.kicks-ass.net>
References: <20190428212557.13482-1-longman@redhat.com>
 <20190428212557.13482-13-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428212557.13482-13-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 05:25:49PM -0400, Waiman Long wrote:
> Bit 1 of sem->owner (RWSEM_ANONYMOUSLY_OWNED) is used to designate an
> anonymous owner - readers or an anonymous writer. The setting of this
> anonymous bit is used as an indicator that optimistic spinning cannot
> be done on this rwsem.
> 
> With the upcoming reader optimistic spinning patches, a reader-owned
> rwsem can be spinned on for a limit period of time. We still need
> this bit to indicate a rwsem is nonspinnable, but not setting this
> bit loses its meaning that the owner is known. So rename the bit
> to RWSEM_NONSPINNABLE to clarify its meaning.
> 
> This patch also fixes a DEBUG_RWSEMS_WARN_ON() bug in __up_write().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/rwsem.h  |  2 +-
>  kernel/locking/rwsem.c | 43 +++++++++++++++++++++---------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 148983e21d47..bb76e82398b2 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -50,7 +50,7 @@ struct rw_semaphore {
>  };
>  
>  /*
> - * Setting bit 1 of the owner field but not bit 0 will indicate
> + * Setting all bits of the owner field except bit 0 will indicate
>   * that the rwsem is writer-owned with an unknown owner.
>   */
>  #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)

As you know, I'm trying to kill that :-)
