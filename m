Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081EBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD6F2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oK6KBT4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbfIFKuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:50:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52746 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731717AbfIFKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d9eCsVlOV0qwfpo9c1jVQsAQiCp5Qrb/vwvQlXE2I0k=; b=oK6KBT4OdGd26VgBA2+t1oj5P
        ZFyVJGP0t1PlQxinX44Idet+6CmIzNMrl8IeDbIo7+hvBbRxq3UQCuIHF2yBo+uYiRWfPG4nrX2QB
        5QcKF1W2VZLBYtyma9rY9P1IexmPyczHnayaG8bUFtrJWgK01kMwUwCaURCIX27RF9yGc05P+XFbw
        LK9RwdhfYbCxntWy08cxn9ubnTtP+gnNms/Ic01jE/VxQvMFfg5qUFIbFUCCUgQR1Oyt9QlEVfoGw
        EYhfCGnoux81FR0kY7UadcdJRfCmUi/aZpxYRccn3L3RSFeleCMLzxRpUlfHjnDJVJ9Z/XSlUjUQM
        HYfIWchkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i6BoM-0006RL-Ca; Fri, 06 Sep 2019 10:49:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03CAF3011DF;
        Fri,  6 Sep 2019 12:49:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 599DC29E2D2F9; Fri,  6 Sep 2019 12:49:48 +0200 (CEST)
Date:   Fri, 6 Sep 2019 12:49:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906104948.GX2349@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <20190906090627.GX2386@hirez.programming.kicks-ass.net>
 <20190906100943.GB10876@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906100943.GB10876@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 07:09:43PM +0900, Sergey Senozhatsky wrote:

> ---
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 139c310049b1..9c73eb6259ce 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -103,7 +103,10 @@ static __printf(2, 0) int printk_safe_log_store(struct printk_safe_seq_buf *s,
>         if (atomic_cmpxchg(&s->len, len, len + add) != len)
>                 goto again;
>  
> -       queue_flush_work(s);
> +       if (early_console)
> +               early_console->write(early_console, s->buffer + len, add);
> +       else
> +               queue_flush_work(s);
>         return add;
>  }

You've not been following along, that generates absolutely unreadable
garbage.
