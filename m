Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9572C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2B820693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNtH0Fu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfDDJnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:43:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfDDJm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QLr/s+fHEPXOEL/h7FQ2IVo1xBVICDWOuKGsUHxBMww=; b=XNtH0Fu2pZwduxxnnemAl7cnI
        EYwrGUbgIvOzxCsp0J+UL/4qcyt4brqXrWKjzi5h9zYKpyh8gD38ZNHLyCPXnMGI+2+tPMUixtODR
        MuzTdF7FJjSg24G0+ykYPR8eRYuCEO7tMIVD8+rPBxObNBc2XtlMIBT3PbVzTeoWs+HyjZ49KiaH3
        hPWhbyut90fCkULT8H4lr+p2pPQEwKGsPXaG09uK1ebPYe2LXkTbZnyEZUMApUbC/EoBtp5Dc4yCs
        o2wbEOiW+WFHM43Z1F+3IyWh5+dtEID7d3Mfpolw63Gp5LzICjvWGWAYM+QOrBGd1IukMHIdzgoVG
        5B4zsDoiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBytA-0006sN-CB; Thu, 04 Apr 2019 09:42:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB2262038C23E; Thu,  4 Apr 2019 11:42:26 +0200 (CEST)
Date:   Thu, 4 Apr 2019 11:42:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: [RFC PATCH 0/7] Early task context tracking
Message-ID: <20190404094226.GV4038@hirez.programming.kicks-ass.net>
References: <cover.1554234787.git.bristot@redhat.com>
 <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 05:01:02PM -0700, Andy Lutomirski wrote:
> I would much rather do the opposite: completely remove context
> tracking from the asm and, instead, stick it into the C code.  We'd
> need to make sure that the C code is totally immune from tracing,
> kprobes, etc, but it would be a nice cleanup.  And then you could fix
> this bug in C!

Right, so you had some prelim patches toward that a few weeks ago. Esp.
for the idtentry stuff that looked fairly straight forward.

