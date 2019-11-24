Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3E7C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF462071A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfKXVkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbfKXVkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:40:00 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 337332071A;
        Sun, 24 Nov 2019 21:39:59 +0000 (UTC)
Date:   Sun, 24 Nov 2019 16:39:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 2/3] selftests/ftrace: Fix ftrace test cases to
 check unsupported
Message-ID: <20191124163957.6ff9d4e4@oasis.local.home>
In-Reply-To: <157457134852.25666.7660419621672440723.stgit@devnote2>
References: <157457133001.25666.5309062776021151107.stgit@devnote2>
        <157457134852.25666.7660419621672440723.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 13:55:48 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since function tracer can be disabled, set_ftrace_filter can be
> disappeared. The test cases must check whether the set_ftrace_filter
> exists or not before testing and if not, return it as unsupported.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |    2 ++
>  .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |    5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> index 36fb59f886ea..1a52f2883fe0 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
> @@ -3,6 +3,8 @@
>  # description: ftrace - stacktrace filter command
>  # flags: instance
>  
> +[ ! -f set_ftrace_filter ] && exit_unsupported
> +
>  echo _do_fork:stacktrace >> set_ftrace_filter
>  
>  grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> index 86a1f07ef2ca..7757b549f0b6 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
> @@ -15,6 +15,11 @@ if [ $NP -eq 1 ] ;then
>    exit_unresolved
>  fi
>  
> +if ! grep -q function available_tracers ; then
> +  echo "Function trace is not enabled"
> +  exit_unsupported
> +fi

This change is not described in the change log.

-- Steve

> +
>  ORIG_CPUMASK=`cat tracing_cpumask`
>  
>  do_reset() {

