Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C8C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836C422CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFXgNKpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfHTN4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:56:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbfHTN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3FZMVIbuRNp32d8JMD1EkMNHi8iS7iY8D8CYQ+VI9+w=; b=QFXgNKpB5rOao8Qx5vOD3t9UB
        Ab4npiAfKzsEfTNL1y0FugkBkUUDwsk0YCkLIk4JE2kSl5UdnuDlnI+nv+UKRz/yRSYS9m8yaFCwP
        sJ/rIW+KRkKR2k7rUWAuX9j463kqqEWmrxxNS2fejyZ3zldMrUyttcw4Lvda+h2EB5QlduO/jCKTp
        zVUUQlX5LM+aBg8HkD2Rt8MhPeXqWN+JwB4uC2UZKM9pmPDEFc5l85bNxqgOnD34vLxO79ABuPt73
        hCRvdpysPApN+SuqIObefSHXobfBFVrQCWpB55ogSOec+bBCCYRFiu2yuTXLrq6IaGU4zqBGAbn4V
        RnP7gKe4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i04cR-0002Sn-0S; Tue, 20 Aug 2019 13:56:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EEAA230768C;
        Tue, 20 Aug 2019 15:55:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1126120A99A00; Tue, 20 Aug 2019 15:56:12 +0200 (CEST)
Date:   Tue, 20 Aug 2019 15:56:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190820135612.GS2332@hirez.programming.kicks-ass.net>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 01:08:02AM -0700, Linus Torvalds wrote:

> The data tearing issue is almost a non-issue. We're not going to add
> WRITE_ONCE() to these kinds of places for no good reason.

Paulmck actually has an example of that somewhere; ISTR that particular
case actually got fixed by GCC, but I'd really _love_ for some compiler
people (both GCC and LLVM) to state that their respective compilers will
not do load/store tearing for machine word sized load/stores.

Without this written guarantee (which supposedly was in older GCC
manuals but has since gone missing), I'm loathe to rely on it.

Yes, it is very rare, but it is a massive royal pain to debug if/when it
does do happen.

