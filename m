Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E28C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6829421479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568295153;
	bh=9mM3BMLFghazKVa4ITPL27kP5L6MutGjThJyUAY6ORY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R0R2o3XUtL+nfPO4cUGOe8kS7gST7vlmd8awFOSNXn3kMkgPq66irdAMCgmR6Y3sg
	 OCWVZZd/o/q1wEYzR+6DSpf4ZLCoxmVTieziI+P2nykZKGDDzbblijhgclZfeUIypX
	 DDcpSoYzWd5BLshhDCRQvnbRtpsSIUCogcpWwmjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732217AbfILNcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732126AbfILNcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:32:32 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE57F20830;
        Thu, 12 Sep 2019 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568295151;
        bh=9mM3BMLFghazKVa4ITPL27kP5L6MutGjThJyUAY6ORY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1W1/PCRaDcJ1pkRDt7vN5r0zzX07LEmhfgtlAK+JpEYqQ5sln8IwQyE4klxtz55AT
         DrvzAmrcsv9SpDUpHoRhKeTbkoO8iFEJSx4+6WtPgVBJeqc3ZkvBB8xkInGTH+09X6
         XU52e9zgwWoe5ACFM8ecD/bgFWbkXOPKzY5sFaSg=
Date:   Thu, 12 Sep 2019 14:32:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] doc:lock: remove reference to clever use of
 read-write lock
Message-ID: <20190912133226.oeo3eecvzfr52yv3@willie-the-truck>
References: <20190908062901.4218-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908062901.4218-1-federico.vaga@vaga.pv.it>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 08:29:01AM +0200, Federico Vaga wrote:
> Remove the clever example about read-write lock because this type of
> lock is not reccomended anymore (according to the very same document).

reccomended => recommended

> So there is no reason to teach cleaver things that people should not do.

cleaver => clever

> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  Documentation/locking/spinlocks.rst | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/Documentation/locking/spinlocks.rst b/Documentation/locking/spinlocks.rst
> index e93ec6645238..66e3792f8a36 100644
> --- a/Documentation/locking/spinlocks.rst
> +++ b/Documentation/locking/spinlocks.rst
> @@ -139,18 +139,6 @@ on other CPU's, because an interrupt on another CPU doesn't interrupt the
>  CPU that holds the lock, so the lock-holder can continue and eventually
>  releases the lock).
>  
> -Note that you can be clever with read-write locks and interrupts. For
> -example, if you know that the interrupt only ever gets a read-lock, then
> -you can use a non-irq version of read locks everywhere - because they
> -don't block on each other (and thus there is no dead-lock wrt interrupts.
> -But when you do the write-lock, you have to use the irq-safe version.
> -
> -For an example of being clever with rw-locks, see the "waitqueue_lock"
> -handling in kernel/sched/core.c - nothing ever _changes_ a wait-queue from
> -within an interrupt, they only read the queue in order to know whom to
> -wake up. So read-locks are safe (which is good: they are very common
> -indeed), while write-locks need to protect themselves against interrupts.
> -

With the typos fixed in the commit message:

Acked-by: Will Deacon <will@kernel.org>

Will
