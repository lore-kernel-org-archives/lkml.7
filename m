Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD023C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8FD2814B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559561455;
	bh=Zihgn2N7b++W5DJiNAYJza4M/ApcbJMImq/WR0DNI8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q4MkZOWi2hWCBNJkbaIc2XM5vOuRo+uetosTf8wCczdUKB5+U3LoPSdbCUhp094uh
	 aDTkR9hGbhCVIaSfD1Ou5wMPDapxz7OD48oyeWstD1+Lkz2M5eOtqDXSln/yeRgSdX
	 gLUxxfbaUJicdiQHatsIwR+0MiT8Dgnf7eTOF/qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfFCLay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfFCLay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:30:54 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD1EE28146;
        Mon,  3 Jun 2019 11:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559561453;
        bh=Zihgn2N7b++W5DJiNAYJza4M/ApcbJMImq/WR0DNI8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iTlnIOSMgLDaL23U2WSbseFWDjbVGHoEkeMbxMilPtt0gOJaaXe+hHP5I3YXehafq
         seK+1LXuL9UZ8DNMR61GeYDgIRWoy2N+xzjvqsf0/JIEIaOjJPFCwN9EETkJ8oVB3b
         xsudOfF05Wb4KFqVsb27a8vFVyLY/E7mbJFPGTSE=
Date:   Mon, 3 Jun 2019 20:30:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 01/14 v2] function_graph: Convert ret_stack to a
 series of longs
Message-Id: <20190603203049.bf07719eb3c0af4218812b3f@kernel.org>
In-Reply-To: <20190524080553.354f1cae@gandalf.local.home>
References: <20190520142001.270067280@goodmis.org>
        <20190520142156.704372433@goodmis.org>
        <20190524111144.GI2589@hirez.programming.kicks-ass.net>
        <20190524080553.354f1cae@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 08:05:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > > +#define SHADOW_STACK_SIZE (PAGE_SIZE)  
> > 
> > Do we really need that big a shadow stack?
> 
> Well, this is a sticky point. I allow up to 16 users at a time
> (although I can't imagine more than 5, but you never know), and each
> user adds a long and up to 4 more words (which is probably unlikely
> anyway). And then we can have deep call stacks (we are getting deeper
> each release it seems).
> 
> I figured, I start with a page size, and then in the future we can make
> it dynamic, or shrink it if it proves to be too much.

I'd prefer dynamic allocation, based on the number of users or actual
stack starvation.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
