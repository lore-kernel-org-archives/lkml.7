Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE0218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfB1CUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfB1CUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:20:50 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18D5218A2;
        Thu, 28 Feb 2019 02:20:49 +0000 (UTC)
Date:   Wed, 27 Feb 2019 21:20:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/5] tracing/probe: Add ustring type for user-space
 string
Message-ID: <20190227212047.42811004@vmware.local.home>
In-Reply-To: <155127865291.32576.4103083638486429600.stgit@devbox>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
        <155127865291.32576.4103083638486429600.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 23:44:13 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add "ustring" type for fetching user-space string from kprobe event.
> User can specify ustring type at uprobe event, and it is same as
> "string" for uprobe.
> 
> Note that probe-event provides this option but it doesn't choose the
> correct type automatically since we have not way to decide the address
> is in user-space or not on some arch (and on some other arch, you can
> fetch the string by "string" type). So user must carefully check the
> target code (e.g. if you see __user on the target variable) and
> use this new type.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v2:
>  - Use strnlen_user() instead of open code for fetch_store_strlen_user().


Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
