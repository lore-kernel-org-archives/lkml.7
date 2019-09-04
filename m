Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D5EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13EB2339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCWIzguc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfIDMgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:36:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33794 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfIDMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WR+wow81AjXojoGDD+gMeFDZO2s/lpoQ/m4Ch7S3T68=; b=XCWIzgucIS35KuO3oNSfuH/H/
        1ndMag8ZdlCNWemm2TVf75vbx/SGeMM40ZgtfmaspFKl0LEvG2LYtrHLZlrlD8f2vfwj+Pmq0oW25
        mjEP8vNhivIhfPZ77LG/gBQeh77IThDeA/6t51ALyT9x7GXf2rlbrBcFVKsz7EeYhf7DHf3ImW1lK
        RbuQiuFrLDvnDMs80uOJTAqy6AbCtNmd5wVPnmNQJtfxixI8wE5HZYq2OBnfKr8hWuWe5FGBnLuM3
        zlBVBzLsQ/SxJpQuoYbEjo1jswx6lKLvI7cK+lDHEY8QsgrB/0tfZ+J1/heATdYm9roKHy1TJVAux
        fSVDJvw6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5UVa-0005EW-BA; Wed, 04 Sep 2019 12:35:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7505306033;
        Wed,  4 Sep 2019 14:34:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 701CD29D94A7B; Wed,  4 Sep 2019 14:35:31 +0200 (CEST)
Date:   Wed, 4 Sep 2019 14:35:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190904123531.GA2369@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:32:25AM +0206, John Ogness wrote:
> Hello,
> 
> This is a follow-up RFC on the work to re-implement much of
> the core of printk. The threads for the previous RFC versions
> are here: v1[0], v2[1], v3[2].
> 
> This series only builds upon v3 (i.e. the first part of this
> series is exactly v3). The main purpose of this series is to
> replace the current printk ringbuffer with the new
> ringbuffer. As was discussed[3], this is a conservative
> first step to rework printk. For example, all logbuf_lock
> usage is kept even though the new ringbuffer does not
> require it. This avoids any side-effect bugs in case the
> logbuf_lock is (unintentionally) synchronizing more than
> just the ringbuffer. However, this also means that the
> series does not bring any improvements, just swapping out
> implementations. A future patch will remove the logbuf_lock.

So after reading most of the first patch (and it look _much_ better than
previous times), I'm left wondering *why* ?!

That is, why do we need this complexity, as compared to that
CPU serialized approach?

What do we hope to gain by doing a multi-writer buffer? Yes, it is
awesome, but from where I'm sitting it is also completely silly, because
we'll want to CPU serialize the serial console anyway (otherwise it gets
to be a completely unreadable mess).

By having the whole thing CPU serialized we looose multi-writer and
consequently the buffer gets to be significantly simpler (as you know;
because ISTR you've actually done this before -- but I cannot find here
why that didn't live).

In my book simpler is better here. printk() is an absolute utter slow
path anyway, nobody cares about the performance much, and I'm thinking
that it should be plenty fast enough as long as you don't run a
synchronous serial output (which is exactly what I do do/require
anyway).

So can we have a few words to explain why we need multi-writer and all
this complexity?
