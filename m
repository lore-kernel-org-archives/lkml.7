Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08E420863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="re7e79YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfCRRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:16:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zd2PatB3kgJ3fmUKExcsxWAv3pQUnPPizAMl6bLC1eM=; b=re7e79YQYePtoWPqedXK6ezH6
        7uXj7dawFXhCd2KS7YojxGWsNRsG4NuScRH2puIqpQAYP+Cxh8Q6qGRdxpfltf5XkDg5vWgoCT7kt
        8VcpouNZ1eSH6wuWX2kDoc/R6ZhVsiZZFORVUynajfNvyw+3j7Ii7DQg37YTEAiR1hFKu5m97t73y
        7pSf8GIseeg+nwHC5GmOFn3p2cpHl6OSHwI7mqbN5C8h+0V+iHiN+ed0+i0gGoiUCkzYx4I+86W5r
        oIWQAXxY0+/S0nFWmBFkwY+Fc7wmpX/Ie+JgjX1aehUOgDRIwm4Rh9o0tRqCA8xyphKGYaPvikE2O
        2VbSmObZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5vrq-0002NV-TJ; Mon, 18 Mar 2019 17:16:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 317F5238A0165; Mon, 18 Mar 2019 18:16:04 +0100 (CET)
Date:   Mon, 18 Mar 2019 18:16:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] x86/vdso: include generic __lshrdi3 in 32-bit vDSO
Message-ID: <20190318171604.GU6058@hirez.programming.kicks-ass.net>
References: <CAG5bF+SSMTvkgnQwHC1gx0pzysXhmMJ_+hUci_SJDPSteL4BcQ@mail.gmail.com>
 <CAKwvOd=aqWvjzC1ZF5_pXx2VutAX0dneDPxU_=jroqHUGw-X6g@mail.gmail.com>
 <20190315222906.GC112750@google.com>
 <CAKwvOdkXobdu74Fo0fiS4xkikqZdKS=gWN61pVAFBbXRPoenRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkXobdu74Fo0fiS4xkikqZdKS=gWN61pVAFBbXRPoenRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:09:37AM -0700, Nick Desaulniers wrote:
> On Fri, Mar 15, 2019 at 3:29 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> > On Fri, Mar 15, 2019 at 02:31:09PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > Is there a config I can set to reproduce this, in order to help
> > > test?
> >
> > I encountered it with a Chrome OS specific configuration, but a
> > defconfig should do.
> 
> defconfig selects CONFIG_OPTIMIZE_FOR_PERFORMANCE=y.  I needed to
> select CONFIG_CC_OPTIMIZE_FOR_SIZE=y to repro.  My CI is simply
> running defconfigs, which is why I didn't catch this.

I suspect the right fix is to make clang use -Os and abolish that -Oz
madness.
