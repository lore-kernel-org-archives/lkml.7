Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C457EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A351E2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 14:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNOgs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 09:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfKNOgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:36:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D0C206D8;
        Thu, 14 Nov 2019 14:36:46 +0000 (UTC)
Date:   Thu, 14 Nov 2019 09:36:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20191114093644.5c183b1d@gandalf.local.home>
In-Reply-To: <alpine.LSU.2.21.1911141004420.20723@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org>
        <alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz>
        <20191113113105.140fe6b6@gandalf.local.home>
        <alpine.LSU.2.21.1911141004420.20723@pobox.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 10:05:42 +0100 (CET)
Miroslav Benes <mbenes@suse.cz> wrote:

> On Wed, 13 Nov 2019, Steven Rostedt wrote:
> 
> > On Wed, 13 Nov 2019 16:10:36 +0100 (CET)
> > Miroslav Benes <mbenes@suse.cz> wrote:
> >   
> > > So I tried to run the selftests and ran into the same timeout issue we had 
> > > with live patching :/
> > > 
> > > See http://lkml.kernel.org/r/20191025115041.23186-1-mbenes@suse.cz for a possible solution.  
> > 
> > Is this when you run the all the selftests?  
> 
> Yes, when I run all ftrace selftests (make run_tests in 
> tools/testing/selftests/ftrace/).

Thanks, I added this:

From 6105e34804bc3a9a35e8c10fcd9e10b8b5a22f8e Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Wed, 13 Nov 2019 11:48:39 -0500
Subject: [PATCH] tracing/selftests: Turn off timeout setting

As the ftrace selftests can run for a long period of time, disable the
timeout that the general selftests have. If a selftest hangs, then it
probably means the machine will hang too.

Link: https://lore.kernel.org/r/alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz

Suggested-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/ftrace/settings

diff --git a/tools/testing/selftests/ftrace/settings b/tools/testing/selftests/ftrace/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.20.1


-- Steve
