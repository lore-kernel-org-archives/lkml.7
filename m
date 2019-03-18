Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9602082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ViYNm6vV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfCRI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:59:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53176 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfCRI7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ALmgar4B3X6CqTSYLBcFD1k8l6NcBpwpstUxNSyhdg=; b=ViYNm6vVENIq+R/bqPElRTcaJ
        IPFONXJ73t6pthX+imVELQky2WZ4ecvDQx77Y1O39OxsQlSpq17/AEg7XVt19/hoqt2yGBanq+Auc
        59kAdBi+RB1rGp/vSlAIB0cZh6f8sMB6r5oUMw/sEyjXq3BLeZtZGVVlK34Jur3AaDhdHgnnSJetU
        5EZkFg4ahRrGV5TIdQqHIRZcNj4L4+eQk0n3oalbB+pIebwZUzA8ZZI3UyGtJJYglIvvo9nXGtOFy
        ZMzvB46HyFztKfFOhJgRVZHAJ37gOdAzuOpRgwFsdQPFmh09KFKKHJz2uaE2SMNM3PgVVbYnUInJH
        vrGtyxOBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5o74-0007ix-W8; Mon, 18 Mar 2019 08:59:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 894CD202194EA; Mon, 18 Mar 2019 09:59:16 +0100 (CET)
Date:   Mon, 18 Mar 2019 09:59:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     hpa@zytor.com
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
Message-ID: <20190318085916.GH6058@hirez.programming.kicks-ass.net>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
 <20190315222906.GC112750@google.com>
 <33DE9AEF-C51C-4021-97FD-BEE2C5D98DBE@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33DE9AEF-C51C-4021-97FD-BEE2C5D98DBE@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 04:18:31PM -0700, hpa@zytor.com wrote:
> Note: it is also probably no reason to use -Os/-Oz for the vdso.

Is anyone actually using -Os and CONFIG_CC_OPTIMIZE_FOR_SIZE ? I've been
staring at compiler output a lot lately and -Os really generates
atrocious crap.

That is, should we just get rid of it?
