Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF9620854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjjyxzGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392852AbfIFJGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:06:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51960 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389138AbfIFJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vk20lkAmcOiEVq+MyZECDuXSB+dU8yQRts5ngj0GVXE=; b=kjjyxzGH/bgBMCEn9CDlBGSTV
        rWS+qCnIhH0IwAnBaejGt9e2YjA4A1K33NqTEdRK9tnAxyTfRnFRL/9mY+KZn4qClq/VXR32ZYm5K
        QPhnwIL+fvhWB99Xbgyx3ox8Wy5XIPYacltFyany8bbzXroii7IbG8uW2bPK79N6pmi4j3ycSQO/q
        5RUCLdUZ5Co3aJ3G//qTsllRnaQJL2MLrpQSE+0sIySifEe9iXuhPnMbAgzKTwPceJGRwccWG/eO/
        UGwuePCmY4Zyvfin4k6DffOky4fo/zT+/RTQ1wac6DoDUQcw3FRKCvrY63wplR8y3IFwt7a7u5W9X
        kJIxoaI1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6ACL-0004HM-AS; Fri, 06 Sep 2019 09:06:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FF81301A5D;
        Fri,  6 Sep 2019 11:05:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A75129DE780C; Fri,  6 Sep 2019 11:06:27 +0200 (CEST)
Date:   Fri, 6 Sep 2019 11:06:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906090627.GX2386@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 04:31:18PM +0200, Peter Zijlstra wrote:
> So I have something roughly like the below; I'm suggesting you add the
> line with + on:
> 
>   int early_vprintk(const char *fmt, va_list args)
>   {
> 	char buf[256]; // teh suck!
> 	int old, n = vscnprintf(buf, sizeof(buf), fmt, args);
> 
> 	old = cpu_lock();
> +	printk_buffer_store(buf, n);
> 	early_console->write(early_console, buf, n);
> 	cpu_unlock(old);
> 
> 	return n;
>   }
> 
> (yes, yes, we can get rid of the on-stack @buf thing with a
> reserve+commit API, but who cares :-))

Another approach is something like:

DEFINE_PER_CPU(int, printk_nest);
DEFINE_PER_CPU(char, printk_line[4][256]);

int vprintk(const char *fmt, va_list args)
{
	int c, n, i;
	char *buf;

	preempt_disable();
	i = min(3, this_cpu_inc_return(printk_nest) - 1);
	buf = this_cpu_ptr(printk_line[i]);
	n = vscnprintf(buf, 256, fmt, args);

	c = cpu_lock();
	printk_buffer_store(buf, n);
	if (early_console)
		early_console->write(early_console, buf, n);
	cpu_unlock(c);

	this_cpu_dec(printk_nest);
	preempt_enable();

	return n;
}

Again, simple and straight forward (and I'm sure it's been mentioned
before too).

We really should not be making this stuff harder than it needs to be
(and anybody whining about lines longer than 256 characters can just go
away, those are unreadable anyway).
