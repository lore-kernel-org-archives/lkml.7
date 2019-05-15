Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC7FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5E02089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557910172;
	bh=5yrVffrVhaiJci/m6e+eB28C+yVItJeTAl4JbS9fw8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vBTBNQG5Jlb21kvNPpLoOWCghnCTbNLucroBvJGR0C0DmmkiPjZ1DXINHBT59SXJq
	 MA6eRUK+tbaws6aS2i8SFlrUTRsisPVV4NYR3JtXk4ixKI0113NztJGi+9SFVGgkoN
	 b3sKjhYf3HLeU0HB/5mDYxB7RzgnA3BeCQ8pvHTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEOIta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfEOIta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:49:30 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BA4C2084F;
        Wed, 15 May 2019 08:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557910169;
        bh=5yrVffrVhaiJci/m6e+eB28C+yVItJeTAl4JbS9fw8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TYDo7u5Y1hG5Mhzio5nl+T0ybgMm0U6Qx8bXqmM92WKd1sfC/bTUtnb66E3AiGXAa
         INb7avaebiiMa90I3+rOWtfipKFf/05lPqHpuiorv849dIf77GBJ4dR6VO8YTpB2+P
         FeTWcD2kfmuRkM7UrR7BBE4TRn2WhjRItYNAqqkk=
Date:   Wed, 15 May 2019 17:49:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH -tip v9 0/6] tracing/probes: uaccess: Add support
 user-space access
Message-Id: <20190515174923.609532fe901b1e28761a2e6f@kernel.org>
In-Reply-To: <20190515055534.GA39270@gmail.com>
References: <155789866428.26965.8344923934342528416.stgit@devnote2>
        <20190515055534.GA39270@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Wed, 15 May 2019 07:55:34 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is the v9 series of probe-event to support user-space access.
> > Previous version is here.
> > 
> > https://lkml.kernel.org/r/155741476971.28419.15837024173365724167.stgit@devnote2
> > 
> > In this version, I fixed more typos/style issues.
> > 
> > Changes in v9:
> >  [3/6]
> >       - Fix other style & coding issues (Thanks Ingo!)
> >       - Update fetch_store_string() for style consistency.
> >  [4/6]
> >       - Remove an unneeded line break.
> >       - Move || and && in if-condition at the end of line.
> 
> LGTM:
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

Thank you for your Ack!

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
