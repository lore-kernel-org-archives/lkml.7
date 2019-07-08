Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB0C606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEA9217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbfGHTWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390747AbfGHTWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:22:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A413D2086D;
        Mon,  8 Jul 2019 19:22:15 +0000 (UTC)
Date:   Mon, 8 Jul 2019 15:22:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/ftrace: Select an existing function in
 kprobe_eventname test
Message-ID: <20190708152214.0304ec7e@gandalf.local.home>
In-Reply-To: <20190708191026.GA8307@calabresa>
References: <20190322150923.1b58eca5@gandalf.local.home>
        <20190708191026.GA8307@calabresa>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 16:10:29 -0300
Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:

> On Fri, Mar 22, 2019 at 03:09:23PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Running the ftrace selftests on the latest kernel caused the
> > kprobe_eventname test to fail. It was due to the test that searches for
> > a function with at "dot" in the name and adding a probe to that.
> > Unfortunately, for this test, it picked:
> > 
> >  optimize_nops.isra.2.cold.4
> > 
> > Which happens to be marked as "__init", which means it no longer exists
> > in the kernel! (kallsyms keeps those function names around for tracing
> > purposes)
> > 
> > As only functions that still exist are in the
> > available_filter_functions file, as they are removed when the functions
> > are freed at boot or module exit, have the test search for a function
> > with ".isra." in the name as well as being in the
> > available_filter_functions (if the file exists).
> >   
> 
> This fixes a similar problem for me.
> 
> Tested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Masami, can you ack this, and Shuah, can you take it?

Thanks!

-- Steve

> 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > index 3fb70e01b1fe..3ff236719b6e 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > @@ -24,7 +24,21 @@ test -d events/kprobes2/event2 || exit_failure
> >  
> >  :;: "Add an event on dot function without name" ;:
> >  
> > -FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> > +find_dot_func() {
> > +	if [ ! -f available_filter_functions ]; then
> > +		grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "
> > +		return;
> > +	fi
> > +
> > +	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
> > +		if grep -s $f available_filter_functions; then
> > +			echo $f
> > +			break
> > +		fi
> > +	done
> > +}
> > +
> > +FUNC=`find_dot_func | tail -n 1`
> >  [ "x" != "x$FUNC" ] || exit_unresolved
> >  echo "p $FUNC" > kprobe_events
> >  EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`  

