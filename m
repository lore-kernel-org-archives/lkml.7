Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D5C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A3E208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MU5uoHUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfFSLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:08:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Ec+cpW1DHs3m2oEbfIqgjbz3u/gomBHl30sxKp5V8I=; b=MU5uoHUWJOA6NEPJEbF9iJzeu
        fmEFrooPpTzM76Ab7xhrDriXftUivgtVRJCGSXD6yp13o8xxb2y9FsAE7EFsQ6vrKmpngg9NN8721
        gUeB2synIzlMlAVSC6EWDlY3uSptIF0NxgU3TVNMitLreK2fC4OC+lrx2+LYIhv+A0RPH2z7Wig9n
        JCftDtBOEZapEtK78t1WxfeHDRElW+Ps4EjduW1nicDlLQzZ8cnwToE73WShGkUuyrWPJDyyZaBQL
        d4OFT5VOsCrsGzTUYLfH5ul39aaiC49pmxMNnVUK7VbOHak0L90TEY8QKjFrQ2xT/Aib9Ru37izm5
        t+YETuhew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdYRf-0007CN-Jz; Wed, 19 Jun 2019 11:08:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81A4520245BD9; Wed, 19 Jun 2019 13:08:01 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:08:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190619110801.GS3436@hirez.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618112237.GP3436@hirez.programming.kicks-ass.net>
 <87a7eebk71.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7eebk71.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 12:30:26AM +0200, John Ogness wrote:
> On 2019-06-18, Peter Zijlstra <peterz@infradead.org> wrote:
> >> +/**
> >> + * DOC: memory barriers
> >
> > What's up with that 'DOC' crap?
> 
> The separate documentation in
> Documentation/core-api/printk-ringbuffer.rst references this so it
> automatically shows up in the kernel docs. An external reference
> requires the DOC keyword.
> 
> Maybe the memory barrier descriptions do not belong in the kernel docs?

So i'm biased; I don't much care for Documentation/ -- code should be
readable and have sufficient comments; I hate rst and I think that
anything that detracts from reading code comments in an editor is pure
evil.

Personally, I've stopped using /** comments, live is better now.

YMMV


> Sorry. I really have no feel about what (or how) exactly I should
> document the memory barriers. I think the above comments make sense when
> someone understands the details of the implementation. But perhaps it
> should describe things such that someone without knowledge of the
> implementation would understand what the memory barriers are for? That
> would significantly increase the amount of text as I would have to
> basically explain the implementation.
> 
> I would appreciate it if you could point out a source file that
> documents its memory barriers the way you would like to see these memory
> barriers documented.

Yeah, I was going to read the implementation and make suggestions; just
haven't gotten there yet.
