Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90101C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BFC20863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560911312;
	bh=XvkpPw8BXpPDu9amDNuyJZsuc2wbO0WNrMlsTLLzL5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bjL+e+ZnydTFsyOaf3I4Uy2eDiQR2dXskZCPlRcP7LHYkgnRbM0zEyuL9My2E8i0y
	 Ghqsj8nzhzPg5C1JVDWrWf45OE1rdp/RUQTAAiKzYbOl6LQ8w+FphRZGMC+GdC5+k6
	 CuOMlLx1dQFzBRgBZlWZizrwZ1/KKEaf6JPIoIzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbfFSC2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfFSC22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:28:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482132085A;
        Wed, 19 Jun 2019 02:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560911307;
        bh=XvkpPw8BXpPDu9amDNuyJZsuc2wbO0WNrMlsTLLzL5c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7ZarNRNjZeC7nSF/Oa8yUc/U4yM06bihFmjCW4QFcrDEhnSYGiLhQlS4tejgreY5
         unpVjWCYb/tV+o9qBm5Jo1Z8fsa7Zze0OeFpVEm9F+fBV9XxHEXmyCxVcgzKLbBObt
         F/O/At+hnDDOQPrevDm+dio3Ukd2F4a1HLpvM2+4=
Date:   Wed, 19 Jun 2019 11:28:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 10/21] tracing/probe: Split trace_event related data
 from trace_probe
Message-Id: <20190619112822.60db3d69a09e0288f9168421@kernel.org>
In-Reply-To: <20190618171115.2c58fde6@gandalf.local.home>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931589667.28323.6107724588059072406.stgit@devnote2>
        <20190617215643.05a33541@oasis.local.home>
        <20190619011409.1a459906c14b8c851a5eb518@kernel.org>
        <20190618122322.6875b643@gandalf.local.home>
        <20190618171115.2c58fde6@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2019 17:11:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 18 Jun 2019 12:23:22 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Oops, good catch!
> > > This part is related to caller (ftrace/perf) so should be more careful.
> > > Usually, kprobe enablement should not fail. If one of them has
> > > gone (like a probe on unloaded module), it can be fail but that
> > > should be ignored. I would like to add some additional check so that
> > > - If all kprobes are on the module which is unloaded, enablement
> > >   must be failed and return error.
> > > - If any kprobe is enabled, and others are on non-exist modules,
> > >   it should succeeded and return OK.
> > > - If any kprobe caused an error not because of unloaded module,
> > >   all other enablement should be canceled and return error.
> > > 
> > > Is that OK for you?
> > >   
> > 
> > Sounds good to me.
> 
> BTW,
> 
> I pulled in patches 1-9 and I'm starting to test them now.

Thanks! Should I send 10-21 patches in v2?

Thank you,




-- 
Masami Hiramatsu <mhiramat@kernel.org>
