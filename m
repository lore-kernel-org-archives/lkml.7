Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1769C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C045320656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZFktwume"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfEHPjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:39:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37526 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEHPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k1/lM6ktqQzSWbUrYqk0UYWJVHJ+bpIMtuRzd2CzIks=; b=ZFktwumeG0jB3w3wR6cmfn4JA
        1XnP3Fl7t0zBUdeNg0zpRYPdM1oz0ROABIRlp+utJpSq2zFcPO1vBV1j7qCywib5yvUMrA2AAhA/J
        5rio3Y6X4xLxjaYm/5FKou70esWVOogOvKYtx8g2ad7HcHkwKSJVB14E8GLUf23Fj/3dfsUfbII1h
        +NV22Ro0+hXdnZfcoqJbPT0NUurtdrPFrQZ3Y+cSv8dDqa5nYSZd91/YzymOvCJaSSWZj+os/il4J
        2xMb+CSvKLxduRspW4N0wThdLPlJo6ggqUGaq5aIOdcnDk2R3KqRslQJ4dVDwZuxYcW3Gl6xmkwtJ
        mTldAF8sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOOey-0007ct-UH; Wed, 08 May 2019 15:39:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 412492029F888; Wed,  8 May 2019 17:39:07 +0200 (CEST)
Date:   Wed, 8 May 2019 17:39:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-ID: <20190508153907.GM2589@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508124248.u5ukpbhnh4wpiccq@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 07:42:48AM -0500, Josh Poimboeuf wrote:
> On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:

> > Do the x86_64 variants also want some ORC annotation?
> 
> Maybe so.  Though it looks like regs->ip isn't saved.  The saved
> registers might need to be tweaked.  I'll need to look into it.

What all these sites do (and maybe we should look at unifying them
somehow) is turn a CALL frame (aka RET-IP) into an exception frame (aka
pt_regs).

So regs->ip will be the return address (which is fixed up to be the CALL
address in the handler).
