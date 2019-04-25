Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B8FC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273102084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OVN//KQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfDYS4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:56:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYS4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GfxYqWaXpjNR7LK7i4LsPRRgPJeb/GnO1gEeqtsBVsI=; b=OVN//KQlDhGo0wx6Wn1zAH3v5
        iqJDPypXGLrYCJGgPOX+P6uttkfZBruXkttjMFGGlJ4/LiO6W495UMkYsZBRn+WEFxPEVQcO481o+
        CFo1e5Vqv4TmE1/VTt13rHN9OFsXGnKGoXi/rE6O0CFjZys30MhBqEPwSNwQaDrIXORqBIluZFlQH
        tvGdbRepAwB4hZzPxvIeK1fAv1jAT89OS7EJnpkWOSPlGXXUsEB6MqLeYmnOMfmbl9ZyKHbZU6/7T
        b99BHlRad9niZXbSM9W/WrmAznoG9d39gH5pyvQ1EVPe1kn2y8c6F2SUOX3A4rrmZ9R+E3w6UATvp
        sv+yGoXAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJjY3-0006FD-Fk; Thu, 25 Apr 2019 18:56:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EF2F20321925; Thu, 25 Apr 2019 20:56:41 +0200 (CEST)
Date:   Thu, 25 Apr 2019 20:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/28] Optimize IRQ usage checks and other small bits
Message-ID: <20190425185641.GT12232@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:19:06PM +0800, Yuyang Du wrote:
> Yuyang Du (28):
>   locking/lockdep: Change all print_*() return type to void
>   locking/lockdep: Add description and explanation in lockdep design doc
>   locking/lockdep: Adjust lock usage bit character checks
>   locking/lockdep: Remove useless conditional macro
>   locking/lockdep: Print the right depth for chain key colission
>   locking/lockdep: Update obsolete struct field description
>   locking/lockdep: Use lockdep_init_task for task initiation
>     consistently
>   locking/lockdep: Define INITIAL_CHAIN_KEY for chain keys to start with
>   locking/lockdep: Change the range of class_idx in held_lock struct
>   locking/lockdep: Remove unused argument in validate_chain() and
>     check_deadlock()
>   locking/lockdep: Update comment
>   locking/lockdep: Change type of the element field in circular_queue
>   locking/lockdep: Change the return type of __cq_dequeue()
>   locking/lockdep: Avoid constant checks in __bfs by using offset
>     reference
>   locking/lockdep: Update comments on dependency search
>   locking/lockdep: Add explanation to lock usage rules in lockdep design
>     doc
>   locking/lockdep: Remove redundant argument in check_deadlock
>   locking/lockdep: Remove unused argument in __lock_release

Those look really good (but don't readily apply to tip/locking/core) now
let me try and look at the real changes..

>   locking/lockdep: Optimize irq usage check when marking lock usage bit
>   locking/lockdep: Refactorize check_noncircular and check_redundant
>   locking/lockdep: Consolidate lock usage bit initialization
>   locking/lockdep: Adjust new bit cases in mark_lock
>   locking/lockdep: Update irqsafe lock bitmaps
>   locking/lockdep: Remove !dir in lock irq usage check
>   locking/lockdep: Implement new IRQ usage checking algorithm
>   locking/lockdep: Remove __bfs
>   locking/lockdep: Remove locks_before
>   locking/lockdep: Reduce lock_list_entries by half
