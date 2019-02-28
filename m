Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CDA206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367410;
	bh=AqREfSndNhO8swPp/mmYSWZmoVA61b23OCTr5O0QBQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wOV/5EDNUCXKIn+kicz35MzBYfmtY9w/CCFSd5tlNrA1IxiUf3olCTmbFqW2NwVf6
	 bqU04vz6bF1DK3XsZqSQXXMVin1Gx1cbIbxDhh3/9qFwYW40T9668+594whTZd9F+x
	 No8hDwRKinEvTh9g25ssRghpRfri6ga9qy1CvruM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfB1PNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387817AbfB1PM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:12:56 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56173214D8;
        Thu, 28 Feb 2019 15:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366775;
        bh=AqREfSndNhO8swPp/mmYSWZmoVA61b23OCTr5O0QBQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cMi0863k42YaiXkVo6DQN2DYgpmMLdiYZO11OVJfPp9sYsJ8mgnx0HC/66rT5E94k
         bfbqbtvJih8Cc91k64GdeThP4LxWpMF2m5q+TvT+2/WK0OMXxWwmmkUzWBT/+Bk0/j
         HxwK2TAlGJOVBzGigRUKJvR4be9elrgT+lOgLtVI=
Date:   Fri, 1 Mar 2019 00:12:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 6/6] selftests/ftrace: Add user-memory access syntax
 testcase
Message-Id: <20190301001251.287316650886276b920448af@kernel.org>
In-Reply-To: <155135718005.438.4959129860081979629.stgit@devbox>
References: <155135700242.438.12930250099644500209.stgit@devbox>
        <155135718005.438.4959129860081979629.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Oops, I forgot to Cc Shuah.
I'll update a bit this series and send v5.

Thanks,

On Thu, 28 Feb 2019 21:33:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a user-memory access syntax testcase which checks
> new user-memory access syntax and ustring type.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_user.tc       |   31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> new file mode 100644
> index 000000000000..996da9d1eec5
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event user-memory access
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +grep -A10 "fetcharg:" README | grep -q 'ustring' || exit_unsupported
> +grep -A10 "fetcharg:" README | grep -q '\[u\]<offset>' || exit_unsupported
> +
> +:;: "user-memory access syntax and ustring working on user memory";:
> +echo 'p:myevent do_sys_open path=+0($arg2):ustring path2=+u0($arg2):string' \
> +	> kprobe_events
> +
> +grep myevent kprobe_events | \
> +	grep -q 'path=+0($arg2):ustring path2=+u0($arg2):string'
> +echo 1 > events/kprobes/myevent/enable
> +echo > /dev/null
> +echo 0 > events/kprobes/myevent/enable
> +
> +grep myevent trace | grep -q 'path="/dev/null" path2="/dev/null"'
> +
> +:;: "user-memory access syntax and ustring not working with kernel memory";:
> +echo 'p:myevent vfs_symlink path=+0($arg3):ustring path2=+u0($arg3):string' \
> +	> kprobe_events
> +echo 1 > events/kprobes/myevent/enable
> +ln -s foo $TMPDIR/bar
> +echo 0 > events/kprobes/myevent/enable
> +
> +grep myevent trace | grep -q 'path=(fault) path2=(fault)'
> +
> +exit 0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
