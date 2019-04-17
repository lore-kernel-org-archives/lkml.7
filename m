Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3EC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D36B20675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byIXOqTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfDQHHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:07:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQHHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+Lhr4FjfZlU230vKvsD/VlGEhuOqeIzAJsBvJVypx4U=; b=byIXOqTCRKHGGLd3kXmq1rplM
        W1hkNS58tI+dXTweZG6lejtyKFwgf6Xs3D0sCl/fWhBUp2/FMUKgOmRA3WjqLVYqYvAXdywPlGlFT
        IoP7jUCppaXRlpPlFn4gqVYBgimxh7pijIwCKJq+Xu6Ja/Sh1fU9viGjDhXowAJHo45EY1oIKKXjX
        1S3HCDu936aodHkjWH8on1B3OtBtZAryeUxYIOQvZCI3TdAfseUVggvMXro9trnDim2mIxm69xRzK
        C5oBGcKjruOiON43es3xMequIMBgXauPzM9slKVXxpz+4jY/7vtAgB55b0zmMgd0icwfmyeEF53dH
        5ZV7Zdlug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGefR-0005kh-OO; Wed, 17 Apr 2019 07:07:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BF30200BFB38; Wed, 17 Apr 2019 09:07:35 +0200 (CEST)
Date:   Wed, 17 Apr 2019 09:07:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kairui Song <kasong@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190417070735.GW4038@hirez.programming.kicks-ass.net>
References: <20190408165942.23640-1-kasong@redhat.com>
 <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble>
 <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
 <CACPcB9f0D4SdJLAtUs4vYwduBiPYDpa-y8r7jracYy=sAJmo5g@mail.gmail.com>
 <20190416201559.d267liiwpjvo3wet@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416201559.d267liiwpjvo3wet@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:15:59PM -0500, Josh Poimboeuf wrote:
> If you do the regs->eflags thing to mark the regs as fake in
> (perf_arch_fetch_caller_regs()), then I don't think skip_sp would be
> needed, because regs->sp could probably mark the skip point.
> 
> Instead I was actually hoping we could get rid of fake regs and
> perf_arch_fetch_caller_regs() altogether, because it's a nasty hack.
> But I don't know what else those fake regs are used for.

This is the generic perf generate a sample path. It doesn't know the
context. Normally it is an interrupt or exception of sorts and we simply
pass the pt_regs from that down the chain and all is good.

It is just for a few software events, such as SW_CONTEXT_SWITCH,
SW_MIGRATIONS and all the TP muck that we do not have regs to pass down.

These regs are used by:

 - SAMPLE_IP,
 - SAMPLE_CALLCHAIN (this here issue),
 - SAMPLE_REGS_INTR,
 - a few misc bits

There's actually comment on top of perf_fetch_caller_regs() that tries
to explain what is needed -- although I suppose that could do with an
update.


