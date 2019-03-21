Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB102218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ofdQOeNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfCUJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:02:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfCUJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7xrTOIEHJHDFjEhBP7mEM8RRVlFCfaVww58exeZTQNw=; b=ofdQOeNmKyMLYgzqboB6alj4Q
        3bA9QIQYZEBDm0etd7+8mkeBeP1ZloG8VtiO5M+1A/+hm5X4vxneriDAoTYkwn3+dsZMMw+n0+zt7
        Ln4gXCl6YVsnKMoWGCCrsueo5nO9hvSmUzLROHh1raHs8jA+nheg/HoF8ey/EuXMkQYgempJZY6IJ
        YFQqQ//1eTRqDtiE6gNPjAaZbtEUq0N7OS2hPy36UJTVvT7GYgnQnBrznui68mGM4V5/zrc46wDjU
        K4x9nmRq0lyobB2yygk3NsTtjQ8amuIUWYbkldBQWkcLn75qf3Nf6RwylPvcG+OUItn8aiV4zfeCn
        uGna/6NBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6tb1-0004SQ-Nj; Thu, 21 Mar 2019 09:02:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 589752391A9A9; Thu, 21 Mar 2019 10:02:41 +0100 (CET)
Date:   Thu, 21 Mar 2019 10:02:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on
 error_entry
Message-ID: <20190321090241.GL6521@hirez.programming.kicks-ass.net>
References: <20190320221534.165ab87b@oasis.local.home>
 <20190321083317.GL6058@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321083317.GL6058@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:33:17AM +0100, Peter Zijlstra wrote:

I'm thinking this problem wasn't new.

> idtentry page_fault             do_page_fault           has_error_code=1
>   call error_entry
>     TRACE_IRQS_OFF
>       call trace_hardirqs_off*
>         <tracer stuff>
> 	  <fault> # modifies CR2

      CALL_enter_from_user_mode
        __context_tracking_exit()
	  trace_user_exit(0)
	    #PF

>   call do_page_fault
>     address = read_cr2(); /* whoopsie */

And that also isn't fixed by your patch.

I'm trying to make idtentry put cr2 in rdx, such that do_page_fault()
takes address as a 3rd argument, but I'm still fighting that context
tracking nonsense.

