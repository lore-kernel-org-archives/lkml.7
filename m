Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0557C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648EC20733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0yTPH9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLQTav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:30:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57272 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfLQTav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Y+l+qhRX82wNX6+96r8AekxTBZHO3NyqH8i08v//ic=; b=I0yTPH9PqNzkbnYw5oHkxqfZV
        JShDIrdEjFa2vyW56mqcBkjoxXZmlp3Cd3M8TYaYvtHfhL2gVdYE0LiFWRmpRg/0imbuVu5ohetcG
        cP56HrseOQ+UaH6aHigkFXz4evsNqGfsnVOW7xIrdL+rT68le4kMC4Jq5UWh1oC48nitMXbwb1Usg
        Kqd2Jn7ZJ15UqomNZLHNkkeEXCkD0EbLhWYzGA+vqg02SqTsBDagb9aDECM5izb5f6jQ2QNIRDPCt
        n/ooyQejYP5zQCmMRY8CAtWQODh04RFhtYYGLrW5f7fhPkHa54zCyPhuHDANJ82mcmLye+z44XXLm
        pDgz6jGgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihIYL-00054y-Oa; Tue, 17 Dec 2019 19:30:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DC5630038D;
        Tue, 17 Dec 2019 20:29:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EEE22B2B0509; Tue, 17 Dec 2019 20:30:39 +0100 (CET)
Date:   Tue, 17 Dec 2019 20:30:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] timer fixes
Message-ID: <20191217193039.GF2844@hirez.programming.kicks-ass.net>
References: <20191217115547.GA68104@gmail.com>
 <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:14:48AM -0800, Linus Torvalds wrote:
> On Tue, Dec 17, 2019 at 3:55 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Add HPET quirks for the Intel "Coffee Lake H" and "Ice Lake" platforms.
> 
> Is there any reason we don't force-disable HPET by default if there
> are alternatives?

What alternatives are there? That is, we normally only use HPET to
double check nobody messed up the TSC.

Now it (fingers crossed) seems to be getting better in that more recent
firmware is less likely to wreck TSC, but we're still running this on
plenty of old machines where TSC really isn't all that sane.

We can't just blindly trust TSC across everything x86.
