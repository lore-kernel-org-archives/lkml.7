Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D3AC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA6F222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKMO1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbfKMO1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:27:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FB3222C9;
        Wed, 13 Nov 2019 14:27:43 +0000 (UTC)
Date:   Wed, 13 Nov 2019 09:27:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191113092741.18abd63b@gandalf.local.home>
In-Reply-To: <20191113090104.GF4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
        <20191111132457.761255803@infradead.org>
        <20191112132536.28ac1b32@gandalf.local.home>
        <20191112222413.GB4131@hirez.programming.kicks-ass.net>
        <20191112174816.7fb95948@gandalf.local.home>
        <20191113090104.GF4131@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2019 10:01:04 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > And that printk() never printed, even after running the ftracetests.  
> 
> Well, then wth did it do that set_all_modules_text_rw() nonsense?
> Because all I did was preserve that semantic.

Because the ftracetests obviously is missing a check :-p

It never printed when running those tests, but when I did a simple:

 # trace-cmd start -p function
 # modprobe <some-module>

The printk appeared.

Yeah, let's keep it this way, but still needs a comment.

-- Steve
