Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A848C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6D20672
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGdh3i0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfKNOGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:06:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfKNOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WzDqDpc5k/65Fo1yc0KhfHuu05DdY1dk7CfUXKh3Y7o=; b=rGdh3i0BKMkIqprcR+7b+OJ8k
        rq/80NBOu1UhWkK/++ZrrAQ6LzhKZ/gxblHoLYBkDwg/fWeiCgvQXEM8nYGKKqDGWJ2zznTN7nCG9
        8FrL1vVrDJbRzLKqEcxcDD15pVfHwDqug1sumjftHXz6j1BDLZ5p1G/Zq2iEHzWc77b1zjRf/p6nO
        LbsSETwdDiNnse7WsXlCyvjULw+6ja//F4FZJZqN+Asdc0nptByM1oV9mmNqGfNM0tCjozqn4Vq4F
        sQMMSesfYkmC+21+G5JKsAGgZ1CqGGGNSkLEO5KejcV7fNmlbmAhl04F/qKRXWNrVMmGLoXGBsnj5
        /RgdChcsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVFkt-0001XM-9o; Thu, 14 Nov 2019 14:05:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD1A53002B0;
        Thu, 14 Nov 2019 15:04:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55CCA203A5888; Thu, 14 Nov 2019 15:05:49 +0100 (CET)
Date:   Thu, 14 Nov 2019 15:05:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191114140549.GZ4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132457.761255803@infradead.org>
 <20191112132536.28ac1b32@gandalf.local.home>
 <20191112222413.GB4131@hirez.programming.kicks-ass.net>
 <20191112174816.7fb95948@gandalf.local.home>
 <20191113090104.GF4131@hirez.programming.kicks-ass.net>
 <20191113092741.18abd63b@gandalf.local.home>
 <20191114131827.GV4131@hirez.programming.kicks-ass.net>
 <20191114085628.16a942a2@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114085628.16a942a2@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:56:28AM -0500, Steven Rostedt wrote:
> On Thu, 14 Nov 2019 14:18:27 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Nov 13, 2019 at 09:27:41AM -0500, Steven Rostedt wrote:
> > 
> > > Yeah, let's keep it this way, but still needs a comment.  
> > 
> > The function now reads:
> > 
> > int ftrace_arch_code_modify_post_process(void)
> >     __releases(&text_mutex)
> > {
> > 	/*
> > 	 * ftrace_module_enable()
> > 	 *   ftrace_arch_code_modify_prepare()
> > 	 *   do_for_each_ftrace_rec()
> > 	 *     __ftrace_replace_code()
> > 	 *       ftrace_make_{call,nop}()
> > 	 *         ftrace_modify_code_direct()
> > 	 *           text_poke_queue()
> > 	 *   ftrace_arch_code_modify_post_process()
> > 	 *     text_poke_finish()
> 
> Perhaps just:
> 
> 	/*
> 	 * ftrace_make_{call,nop}() may be called during
> 	 * module load, and we need to finish the text_poke_queue()
> 	 * that they do, here.
> > 	 */
> 
> 
> > 	text_poke_finish();
> > 	ftrace_poke_late = 0;
> > 	mutex_unlock(&text_mutex);
> > 	return 0;
> > }
> > 
> > Patch is otherwise unchanged.
> 
> Other than that:
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Done and thanks!
