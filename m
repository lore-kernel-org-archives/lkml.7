Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014ABC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9D420866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgABRH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:07:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgABRH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:07:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90FD92085B;
        Thu,  2 Jan 2020 17:07:56 +0000 (UTC)
Date:   Thu, 2 Jan 2020 12:07:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        pmladek@suse.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, dan.j.williams@intel.com,
        Peter Zijlstra <peterz@infradead.org>, longman@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] char/random: silence a lockdep splat with printk()
Message-ID: <20200102120752.7b893b1e@gandalf.local.home>
In-Reply-To: <1CA39814-DE67-4112-8F97-D62B9F47FF9D@lca.pw>
References: <20191205010055.GO93017@google.com>
        <4F9E9335-334B-4600-8BC3-4AF91510D113@lca.pw>
        <1CA39814-DE67-4112-8F97-D62B9F47FF9D@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 10:42:51 -0500
Qian Cai <cai@lca.pw> wrote:

> > On Dec 16, 2019, at 8:52 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > 
> >   
> >> On Dec 4, 2019, at 8:00 PM, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> 
> >> A 'Reviewed-by' will suffice.
> >> 
> >> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>  
> > 
> > Ted, could you take a look at this trivial patch?  
> 
> Not sure if Ted is still interested in maintaining this file as he had no feedback for more
> than a month. The problem is that this will render the lockdep useless for a general
> debugging tool as it will disable the lockdep early in the process.
> 

How would this disable lockdep early in the process? The patch is just
changing pr_notice() to printk_deferred() correct?

-- Steve
