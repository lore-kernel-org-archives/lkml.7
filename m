Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16FEC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52CB214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561464992;
	bh=SB2Z4PP4lJ0nZgvBug7Olk0/lIXmzn+RPwhB66whhkk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=MVFc4p1VttRiPrRunJDcRSTv8eKBp9Ls6UW01pMuHbyDH5ZYac0iRe8pidbY97Mjy
	 6fHWaGzLCMV01edgerxpWCdpSh+bkONccRAcmdgr3YSTY8K3/NTFJ2aFKvnu8fGxiI
	 Gvmoc9mbmgT4/cpFZJCrSAeOyElTiCGWaU0LhZBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfFYMQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbfFYMQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:16:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 284C4204EC;
        Tue, 25 Jun 2019 12:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561464990;
        bh=SB2Z4PP4lJ0nZgvBug7Olk0/lIXmzn+RPwhB66whhkk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=1JBeGd3X7kw35jgFrw7T+ev4OPiwTpfyIGpJcptFBFGTewPY5BvqrMEPnTsKwG6Ez
         XnywTQaxLdTf6qiHp88RGJRrmhAjln5WndwzyqDp8AYpYPF7A0N45aLZSgQLoagqle
         T3IhYe6waiuGVn3hzhapCXyYTGZvX3Q84e9STLwk=
Date:   Tue, 25 Jun 2019 13:16:25 +0100
From:   Will Deacon <will@kernel.org>
To:     will.deacon@arm.com, tglx@linutronix.de, frederic@kernel.org,
        mingo@kernel.org, longman@redhat.com, bvanassche@acm.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, duyuyang@gmail.com, torvalds@linux-foundation.org,
        hpa@zytor.com
Subject: Re: [tip:locking/core] locking/lockdep: Move mark_lock() inside
 CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Message-ID: <20190625121624.nypo3qmbtfpl5f4r@willie-the-truck>
References: <20190617124718.1232976-1-arnd@arndb.de>
 <tip-886532aee3cd42d95196601ed16d7c3d4679e9e5@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-886532aee3cd42d95196601ed16d7c3d4679e9e5@git.kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:46:07AM -0700, tip-bot for Arnd Bergmann wrote:
> Commit-ID:  886532aee3cd42d95196601ed16d7c3d4679e9e5
> Gitweb:     https://git.kernel.org/tip/886532aee3cd42d95196601ed16d7c3d4679e9e5
> Author:     Arnd Bergmann <arnd@arndb.de>
> AuthorDate: Mon, 17 Jun 2019 14:47:05 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue, 25 Jun 2019 10:17:07 +0200
> 
> locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
> 
> The last cleanup patch triggered another issue, as now another function
> should be moved into the same section:
> 
>  kernel/locking/lockdep.c:3580:12: error: 'mark_lock' defined but not used [-Werror=unused-function]
>   static int mark_lock(struct task_struct *curr, struct held_lock *this,
> 
> Move mark_lock() into the same #ifdef section as its only caller, and
> remove the now-unused mark_lock_irq() stub helper.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yuyang Du <duyuyang@gmail.com>
> Fixes: 0d2cc3b34532 ("locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
> Link: https://lkml.kernel.org/r/20190617124718.1232976-1-arnd@arndb.de
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  kernel/locking/lockdep.c | 73 ++++++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)

Hmm, I was hoping we could fold in the simplification that Arnd came up with
yesterday:

https://lkml.kernel.org/r/CAK8P3a2X_5p9QOKG-jcozR4P8iPNJAY2ObXgfqt=bBD+hZdnSg@mail.gmail.com

Will
