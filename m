Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13413C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33F3254EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559208568;
	bh=z37S3eU6mARunEgZS89SCwtxniogx+stPp5qD9PNZqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FeMhPFT6Xx2uPW/0Eigyhafhsc9CjgRVxcIauRtILh/YhIGSV42KOr3vzFCxhj+nS
	 Thx3wVIseNTDD4KY36bvXQEtKwhBOHPKvVhIICrqqC2R0KTwAWsHqKPMy8DlxL/tSA
	 u75cJ2Qsqr/e9r5jMIS7v1W6AIlVsjR73sN8JADU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE3J31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfE3J31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:29:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A1E254E4;
        Thu, 30 May 2019 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559208566;
        bh=z37S3eU6mARunEgZS89SCwtxniogx+stPp5qD9PNZqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eEBOUttdGJAUhwxn0K17880pmCNDabd+w+xw+79EmPq4gdBBKgT3VQugK1GbcpMuo
         /6hIMVmb/b3MoQU+dSKbdGMMAhawH/bdR39kE9SLeqwrDU+mvUZEGmHbYADwcO/nTE
         RirDcdU/Czk/hkW5300xiOrNglDDkJe0Y0K3bisQ=
Date:   Thu, 30 May 2019 18:29:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 00/14 v2] function_graph: Rewrite to allow multiple
 users
Message-Id: <20190530182920.d8ef9f3c09ba0ae1beaa605a@kernel.org>
In-Reply-To: <20190529052521.6623ae7b@oasis.local.home>
References: <20190520142001.270067280@goodmis.org>
        <20190522231955.72899b0d606adb919e8716ff@kernel.org>
        <20190522104027.1b2aabd8@gandalf.local.home>
        <20190529154740.016517ff9225680f64961097@kernel.org>
        <20190529052521.6623ae7b@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019 05:25:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 29 May 2019 15:47:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> 
> > Hi Steve,
> > 
> > I found that these interfaces seem tightly coupled with fgraph_ops. But that
> > cause a problem when I'm using it from kretprobe.
> 
> I was thinking that the kretprobes could use the fgraph_ops like
> kprobes uses ftrace_ops.
> 
> > 
> > kretprobe has 2 handlers, entry handler and return handler, and both need
> > pt_regs. But fgraph_ops's entryfunc and retfunc do not pass the pt_regs.
> > That is the biggest issue for me on these APIs.
> > Can we expand fgraph_ops with regs parameter?
> 
> Ug. Yeah, of course you need that :-/
> 
> OK, so this series isn't enough to allow kretprobes to use it yet. OK,
> I plan on still keeping it because it does allow for placing function
> graph tracer into instances with their own filters.

OK, that will be a "regs" extension.
> 
> I'll look into adding a REGS flag like we do with ftrace_ops.
> 
> Does the return need all regs? Or is just the return code good enough?

Since it depends on arch, I think all regs we need. And for the entry
handler, we need all.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
