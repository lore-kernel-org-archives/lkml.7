Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF82AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA88B2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBpjvfpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfDPRpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:45:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34002 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfDPRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ut9NejS1wR0oJDJXatZJuH7z/KPsH6QzFvIh2WX6q5M=; b=WBpjvfpMqFHGvTmOkaXXijM6T
        2C3+j1kZvpyhI5AVQutpLDVm+tAunjWUAEIp2kbFRIci/B9Q6qAnECt8L9kIQBMMNSL+G8o95VjxF
        zc79ePlyAVeLg5RmmMkJcyOKRvgQYK5ldEajwbcGzRZN/ifwP5I3VOAgzvqOL+2wPtSYJkbz57VE0
        AwRKdCHpqGMW+/Uq+QuPX2BTHomy/FlQjzwR57wq+6EC35ctz8FHpe+WZyrTr6C5EO3W4kIFYYo1J
        soelzTtEz1ryoq2wFaB7go0Rf0m19jWKX1pjDaxtq+RLj6nSXfTTwFptOgApRKc71ut25//q2bD1i
        Hr01WjvIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGS9C-0002FB-I3; Tue, 16 Apr 2019 17:45:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9386C29B3180A; Tue, 16 Apr 2019 19:45:28 +0200 (CEST)
Date:   Tue, 16 Apr 2019 19:45:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20190416174528.GT4038@hirez.programming.kicks-ass.net>
References: <20190408165942.23640-1-kasong@redhat.com>
 <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble>
 <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
 <CACPcB9f0D4SdJLAtUs4vYwduBiPYDpa-y8r7jracYy=sAJmo5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9f0D4SdJLAtUs4vYwduBiPYDpa-y8r7jracYy=sAJmo5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 01:39:19AM +0800, Kairui Song wrote:
> And I also think the "fake"/"real" reg is fragile, could we abuse
> another eflag (just like PERF_EFLAGS_EXACT) to indicate the regs are
> partially dumped fake registers? 

Sure, the SDM seems to suggest bits 1,3,5,15 are 'available'. We've
already used 3 and 5, and I think we can use !X86_EFLAGS_FIXED to
indicate a fake regs set. Any real regs set will always have that set.
