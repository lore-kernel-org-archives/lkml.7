Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55707C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE8820706
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 15:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKNPm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 10:42:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:59598 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726910AbfKNPm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:42:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DB69AC18;
        Thu, 14 Nov 2019 15:42:27 +0000 (UTC)
Date:   Thu, 14 Nov 2019 16:42:26 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
In-Reply-To: <20191114093644.5c183b1d@gandalf.local.home>
Message-ID: <alpine.LSU.2.21.1911141637000.20723@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org> <alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz> <20191113113105.140fe6b6@gandalf.local.home> <alpine.LSU.2.21.1911141004420.20723@pobox.suse.cz> <20191114093644.5c183b1d@gandalf.local.home>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Steven Rostedt wrote:

> On Thu, 14 Nov 2019 10:05:42 +0100 (CET)
> Miroslav Benes <mbenes@suse.cz> wrote:
> 
> > On Wed, 13 Nov 2019, Steven Rostedt wrote:
> > 
> > > On Wed, 13 Nov 2019 16:10:36 +0100 (CET)
> > > Miroslav Benes <mbenes@suse.cz> wrote:
> > >   
> > > > So I tried to run the selftests and ran into the same timeout issue we had 
> > > > with live patching :/
> > > > 
> > > > See http://lkml.kernel.org/r/20191025115041.23186-1-mbenes@suse.cz for a possible solution.  
> > > 
> > > Is this when you run the all the selftests?  
> > 
> > Yes, when I run all ftrace selftests (make run_tests in 
> > tools/testing/selftests/ftrace/).
> 
> Thanks, I added this:
> 
> From 6105e34804bc3a9a35e8c10fcd9e10b8b5a22f8e Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Date: Wed, 13 Nov 2019 11:48:39 -0500
> Subject: [PATCH] tracing/selftests: Turn off timeout setting
> 
> As the ftrace selftests can run for a long period of time, disable the
> timeout that the general selftests have. If a selftest hangs, then it
> probably means the machine will hang too.
> 
> Link: https://lore.kernel.org/r/alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz
> 
> Suggested-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Tested-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>

...whichever you prefer

M

> ---
>  tools/testing/selftests/ftrace/settings | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/ftrace/settings
> 
> diff --git a/tools/testing/selftests/ftrace/settings b/tools/testing/selftests/ftrace/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/settings
> @@ -0,0 +1 @@
> +timeout=0
> -- 
> 2.20.1
> 
> 
> -- Steve
> 

