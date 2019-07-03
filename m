Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69EDC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B474621882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGCUAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfGCUAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:00:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE6B21882;
        Wed,  3 Jul 2019 20:00:11 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:00:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] ftrace/selftest: Test if set_event/ftrace_pid
 exists before writing
Message-ID: <20190703160009.31ef5cb7@gandalf.local.home>
In-Reply-To: <20190703195300.408302485@goodmis.org>
References: <20190703194959.596805445@goodmis.org>
        <20190703195300.408302485@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jul 2019 15:50:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> While testing on a very old kernel (3.5), the tests failed because the write
> to set_event_pid in the setup code, did not exist. The tests themselves
> could pass, but the setup failed causing an error.
> 
> Other files test for existance before writing to them. Do the same for
> set_event_pid and set_ftrace_pid.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/testing/selftests/ftrace/test.d/functions | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 779ec11f61bd..a7b06291e32c 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -91,8 +91,8 @@ initialize_ftrace() { # Reset ftrace to initial-state
>      reset_events_filter
>      reset_ftrace_filter
>      disable_events
> -    echo > set_event_pid	# event tracer is always on
> -    echo > set_ftrace_pid
> +    [ -f set_event_pid ] && echo > set_event_pid  # event tracer is always on

I probably should remove that comment, because I believe that was why
it wasn't tested :-/

-- Steve


> +    [ -f set_ftrace_pid ] && echo > set_ftrace_pid
>      [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
>      [ -f set_graph_function ] && echo | tee set_graph_*
>      [ -f stack_trace_filter ] && echo > stack_trace_filter

