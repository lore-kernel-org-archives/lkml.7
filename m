Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5373F208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 06:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HFTXmhtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405536AbfHIGO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 02:14:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfHIGO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jJMeCIZk1dJ4cGtAjfl9MWzK2vlDx5N7AdKbdBQf0T0=; b=HFTXmhtzNHNKhcj1E06ya8Mrl
        BwmS0s8MCZYi8hm1k8r27ynoKDjZy21hJ9Qv62FN/QH8G9CBoxK2phV1aWirhubv8dvNiP5sviQ01
        +fHnkhey/jRvNTZiJBK1yhL3W/7LZ/zRNuTW6OhkbAl+Ppmywv4y/xCDX4izFbfVfpHnXu62g5kgg
        ytswo9emvNskg79gNwqALsG2orF3hijRXVKyqT0dKfP8mMc8cqlXE55J4lFt6mRWTbLnws3YRu4jb
        6TSHLzYQSkS1dcrss8UCCW6tYXoASNa6xhNGDyzPSgn8b30Fno6K5p9jVtoCJZRTbugYRG9cOLHCI
        WOVA2eEcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvyAj-00055i-2z; Fri, 09 Aug 2019 06:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A1E2307764;
        Fri,  9 Aug 2019 08:14:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B38C120BE516F; Fri,  9 Aug 2019 08:14:37 +0200 (CEST)
Date:   Fri, 9 Aug 2019 08:14:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC PATCH v4 9/9] printk: use a new ringbuffer implementation
Message-ID: <20190809061437.GE2332@hirez.programming.kicks-ass.net>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-10-john.ogness@linutronix.de>
 <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKTn-BMpp4w645XqmFBEtUXe84+TKc6aRMPbvFwUjA=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:07:28PM -0700, Linus Torvalds wrote:

> End result: a DRAM buffer can work, but is not "reliable".
> Particularly if you turn power on and off, data retention of DRAM is
> iffy. But it's possible, at least in theory.
> 
> So I have a patch that implements a "stupid ring buffer" for thisa
> case, with absolutely zero data structures (because in the presense of
> DRAM corruption, all you can get is "hopefully only slightly garbled
> ASCII".

Note that you can hook this into printk as a fake early serial device;
just have the serial device write to the DRAM buffer.


