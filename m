Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54F7C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2B620863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfFRVLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfFRVLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:11:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACDD2084A;
        Tue, 18 Jun 2019 21:11:16 +0000 (UTC)
Date:   Tue, 18 Jun 2019 17:11:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 10/21] tracing/probe: Split trace_event related data
 from trace_probe
Message-ID: <20190618171115.2c58fde6@gandalf.local.home>
In-Reply-To: <20190618122322.6875b643@gandalf.local.home>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931589667.28323.6107724588059072406.stgit@devnote2>
        <20190617215643.05a33541@oasis.local.home>
        <20190619011409.1a459906c14b8c851a5eb518@kernel.org>
        <20190618122322.6875b643@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 12:23:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Oops, good catch!
> > This part is related to caller (ftrace/perf) so should be more careful.
> > Usually, kprobe enablement should not fail. If one of them has
> > gone (like a probe on unloaded module), it can be fail but that
> > should be ignored. I would like to add some additional check so that
> > - If all kprobes are on the module which is unloaded, enablement
> >   must be failed and return error.
> > - If any kprobe is enabled, and others are on non-exist modules,
> >   it should succeeded and return OK.
> > - If any kprobe caused an error not because of unloaded module,
> >   all other enablement should be canceled and return error.
> > 
> > Is that OK for you?
> >   
> 
> Sounds good to me.

BTW,

I pulled in patches 1-9 and I'm starting to test them now.

-- Steve
