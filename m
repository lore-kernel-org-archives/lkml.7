Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F8C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B025214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ij+8aVx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfG2KfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:35:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfG2KfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OLcOQ/n8nsV1J24avjiNzRxgd0bDdez3laTxyYU6tyw=; b=Ij+8aVx1OaAiW+7gIo9Sqv9mL
        +948ak6QIqgdP+T0hilmrAtpFHhXYXle8u8fIKX8L5A0Cr+yEHYfhHNjFB1PWVJGTqTwKPzZTBnhw
        kj4csS3ft1vaC0DA5pOao6h8i/i6rY9s0leXq+J0J19SlviQKorsoBBT7PR6bxi1NZ99AkUV3ZGG8
        EXm7p9h8LYk1fF+egZoyGgGlxdijsR8hCp35auLiOxJTgiYC/C6yKIikpfBon4gaefSLyBl32ugz6
        HTkoL3FwgVjf3An9fASPiZUl7tZOEwk8HZg8PQLmslRDm2on70VbgMXYDM+zUUAeYe2Z0H/25whhe
        EdxCfk74Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs2zb-0001V0-Ob; Mon, 29 Jul 2019 10:34:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2AABE20AF2C34; Mon, 29 Jul 2019 12:34:58 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:34:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Axtens <dja@axtens.net>,
        kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] x86: panic when a kernel stack overflow is detected
Message-ID: <20190729103458.GZ31381@hirez.programming.kicks-ass.net>
References: <20190729015933.18049-1-dja@axtens.net>
 <CALCETrX_+_zT8iKp9QMpaN0+NPS9_rmhZvPgG=ejN-5KkBbfdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX_+_zT8iKp9QMpaN0+NPS9_rmhZvPgG=ejN-5KkBbfdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 08:53:58PM -0700, Andy Lutomirski wrote:
> On Sun, Jul 28, 2019 at 6:59 PM Daniel Axtens <dja@axtens.net> wrote:
> >
> > Currently, when a kernel stack overflow is detected via VMAP_STACK,
> > the task is killed with die().
> >
> > This isn't safe, because we don't know how that process has affected
> > kernel state. In particular, we don't know what locks have been taken.
> > For example, we can hit a case with lkdtm where a thread takes a
> > stack overflow in printk() after taking the logbuf_lock. In that case,
> > we deadlock when the kernel next does a printk.
> >
> > Do not attempt to kill the process when a kernel stack overflow is
> > detected. The system state is unknown, the only safe thing to do is
> > panic(). (panic() also prints without taking locks so a useful debug
> > splat is printed even when logbuf_lock is held.)
> 
> The thing I don't like about this is that it reduces the chance that
> we successfully log anything to disk.
> 
> PeterZ, do you have any useful input here?  I wonder if we could do
> something like printk_oh_crap() that is just printk() except that it
> panics if it fails to return after a few seconds.

People are already had at work rewriting printk. The current thing is
unfixable.  Then again, I don't know if there's any sane options aside
of early serial.

Still, mucking with printk won't help you at all if the task is holding
some other/filesystem lock required to do that writeback.


