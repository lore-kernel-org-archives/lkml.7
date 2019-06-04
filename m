Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60851C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307CF24A11
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hSXkGU4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFDJDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:03:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34316 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFDJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Or4/2JAPsb187Uokb8j1G0UQQ7PWFIwAaNG4qlTSero=; b=hSXkGU4Eth1Uzo+CeRZUuf64v
        7KAbn3S7L65x3C2i+8eMVUbE8zPK3EaLKphBrhcDB/uSOLijheaL98jKYKG/NHp8YEn/3mR+aLSVe
        rz+SB7rVXavRdrbUNQOCoNoUHYxw/0u5D48Hokb46ryfztQU9MzHD9Xi52d6uhc02fSEN0wdZLITN
        lnVho1O7RpIUrnjb9o33a0KJGdMDl7HZcLCZ04P/74UkOehIowRHaYjdn5owVAaGrAD9vVNDxs8RY
        qB2biiliLpF/Kv0pPu6IRqjW4ZE0/7TCDo+wNX8jT4uLBLRVCfTOe1bqRD1B4uOORThIvMLotDgxC
        A4A6u37EA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY5Lb-000308-7f; Tue, 04 Jun 2019 09:03:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBBF12083FE27; Tue,  4 Jun 2019 11:03:09 +0200 (CEST)
Date:   Tue, 4 Jun 2019 11:03:09 +0200
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
Subject: Re: [PATCH v8 14/19] locking/rwsem: Enable time-based spinning on
 reader-owned rwsem
Message-ID: <20190604090309.GG3402@hirez.programming.kicks-ass.net>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-15-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520205918.22251-15-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:59:13PM -0400, Waiman Long wrote:
> +static inline void rwsem_set_nonspinnable(struct rw_semaphore *sem)
> +{
> +	long owner = atomic_long_read(&sem->owner);
> +
> +	while (owner & RWSEM_READER_OWNED) {
> +		if (owner & RWSEM_NONSPINNABLE)
> +			break;
> +		owner = atomic_long_cmpxchg(&sem->owner, owner,
> +					    owner | RWSEM_NONSPINNABLE);
> +	}
> +}

--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -206,12 +206,13 @@ static inline void rwsem_set_nonspinnabl
 {
 	long owner = atomic_long_read(&sem->owner);
 
-	while (owner & RWSEM_READER_OWNED) {
+	do {
+		if (!(owner & RWSEM_READER_OWNED))
+			break;
 		if (owner & RWSEM_NONSPINNABLE)
 			break;
-		owner = atomic_long_cmpxchg(&sem->owner, owner,
-					    owner | RWSEM_NONSPINNABLE);
-	}
+	} while (!atomic_long_try_cmpxchg(&sem->owner, &owner,
+					  owner | RWSEM_NONSPINNABLE));
 }
 
 /*
