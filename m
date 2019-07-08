Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FBDC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8A2216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbfGHTKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:10:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53504 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfGHTKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:10:36 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1hkZ21-0003Ex-F9; Mon, 08 Jul 2019 19:10:33 +0000
Date:   Mon, 8 Jul 2019 16:10:29 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/ftrace: Select an existing function in
 kprobe_eventname test
Message-ID: <20190708191026.GA8307@calabresa>
References: <20190322150923.1b58eca5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322150923.1b58eca5@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:09:23PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Running the ftrace selftests on the latest kernel caused the
> kprobe_eventname test to fail. It was due to the test that searches for
> a function with at "dot" in the name and adding a probe to that.
> Unfortunately, for this test, it picked:
> 
>  optimize_nops.isra.2.cold.4
> 
> Which happens to be marked as "__init", which means it no longer exists
> in the kernel! (kallsyms keeps those function names around for tracing
> purposes)
> 
> As only functions that still exist are in the
> available_filter_functions file, as they are removed when the functions
> are freed at boot or module exit, have the test search for a function
> with ".isra." in the name as well as being in the
> available_filter_functions (if the file exists).
> 

This fixes a similar problem for me.

Tested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> index 3fb70e01b1fe..3ff236719b6e 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> @@ -24,7 +24,21 @@ test -d events/kprobes2/event2 || exit_failure
>  
>  :;: "Add an event on dot function without name" ;:
>  
> -FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> +find_dot_func() {
> +	if [ ! -f available_filter_functions ]; then
> +		grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "
> +		return;
> +	fi
> +
> +	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
> +		if grep -s $f available_filter_functions; then
> +			echo $f
> +			break
> +		fi
> +	done
> +}
> +
> +FUNC=`find_dot_func | tail -n 1`
>  [ "x" != "x$FUNC" ] || exit_unresolved
>  echo "p $FUNC" > kprobe_events
>  EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`
