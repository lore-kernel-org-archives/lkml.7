Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C74AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3D621726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564760277;
	bh=J7foXkkyvGLjn2NR3WtZ/s3yoZlp3/yFLIuz0F/IbVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rjJ6g2ThpjY3X2ZNW/477TH6/leIUae561qsqjjAxmiqe7pvyqjt06GRZOQVbFcCx
	 CdZKkKNKTWib9hCoFBaWEIMK3RDnhOjHX3FVfXSPeA7VuFkN6C5VF5qunBCblhkeXD
	 R4sMFHreALwF/Yqaafz8zX0rIhvNS+UxTUPosU6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfHBPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfHBPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:37:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1A120665;
        Fri,  2 Aug 2019 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564760274;
        bh=J7foXkkyvGLjn2NR3WtZ/s3yoZlp3/yFLIuz0F/IbVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xfxfofhw0zX0VPEViOCDd+foY6VhBnyOdngK1y3/Yrawcp2Wnk7J5SALvURRNysep
         DSbmUwEvo7gex3StN5hvl+MubVV9rIytvDnvBj0GEK199ZlfaTtnwWgr3vBKaCvj7M
         nqoj3GyqEsa8McsL0qNd5qPfhFLBxOeM93tCKqgI=
Date:   Fri, 2 Aug 2019 17:37:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4.14 25/25] sched/fair: Use RCU accessors consistently
 for ->numa_group
Message-ID: <20190802153751.GA17602@kroah.com>
References: <20190802092058.428079740@linuxfoundation.org>
 <20190802092107.912885585@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802092107.912885585@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:39:57AM +0200, Greg Kroah-Hartman wrote:
> From: Jann Horn <jannh@google.com>
> 
> commit cb361d8cdef69990f6b4504dc1fd9a594d983c97 upstream.
> 
> The old code used RCU annotations and accessors inconsistently for
> ->numa_group, which can lead to use-after-frees and NULL dereferences.
> 
> Let all accesses to ->numa_group use proper RCU helpers to prevent such
> issues.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Fixes: 8c8a743c5087 ("sched/numa: Use {cpu, pid} to create task groups for shared faults")
> Link: https://lkml.kernel.org/r/20190716152047.14424-3-jannh@google.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Oops, nope, this didn't apply, sorry about that, it needs to be properly
backported to 4.14.y and older before it can go here.

thanks,

greg k-h
