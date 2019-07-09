Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE26DC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0974216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562676249;
	bh=9KZHooGyatEqMb1kT1mcZtrsl+uFzSoHbbt9cvkl2Pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ARZr8HPFtYFoYI7j+565EHmE7wlObDGFsXbFdmvug/tj50uwckXeNta9875KPVpAH
	 DYzrom8aBGV1x0nee7kLKpecRTwIK8O64D2pf4XQPv1si2MQruKrrsMLmME++8ZRJc
	 /8nPhxwXnzcJZaILv550+MdwxkL9NPYc+uDCheiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGIMoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfGIMoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:44:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA9521537;
        Tue,  9 Jul 2019 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562676247;
        bh=9KZHooGyatEqMb1kT1mcZtrsl+uFzSoHbbt9cvkl2Pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DVQoHFbQx9WuHoat7JU1TGwT5uSIe/ObmRQ8JgHlOCtuDyCcaaqQnKWgkB8XWFcC4
         /bfX6pGhgg2ZDRb1YBe9yJTL+fMQT40l5WCxfMCcVz1HMMC0GVhshvzkRO9A6qx6rh
         JUTbQWtyLk3ZFUOp/p6rVn+PdwS69LyDpP7WBdA8=
Date:   Tue, 9 Jul 2019 21:44:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/ftrace: Select an existing function in
 kprobe_eventname test
Message-Id: <20190709214402.ffe8b206485dec2ec28eeb3a@kernel.org>
In-Reply-To: <20190708152214.0304ec7e@gandalf.local.home>
References: <20190322150923.1b58eca5@gandalf.local.home>
        <20190708191026.GA8307@calabresa>
        <20190708152214.0304ec7e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2019 15:22:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 8 Jul 2019 16:10:29 -0300
> Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> 
> > On Fri, Mar 22, 2019 at 03:09:23PM -0400, Steven Rostedt wrote:
> > > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > 
> > > Running the ftrace selftests on the latest kernel caused the
> > > kprobe_eventname test to fail. It was due to the test that searches for
> > > a function with at "dot" in the name and adding a probe to that.
> > > Unfortunately, for this test, it picked:
> > > 
> > >  optimize_nops.isra.2.cold.4
> > > 
> > > Which happens to be marked as "__init", which means it no longer exists
> > > in the kernel! (kallsyms keeps those function names around for tracing
> > > purposes)

Ouch!

> > > 
> > > As only functions that still exist are in the
> > > available_filter_functions file, as they are removed when the functions
> > > are freed at boot or module exit, have the test search for a function
> > > with ".isra." in the name as well as being in the
> > > available_filter_functions (if the file exists).

Hmm, OK. But I think this eventually fixed in kallsyms, by something like 
having [GONE] or [__init] flag for such symbols.

> > >   
> > 
> > This fixes a similar problem for me.
> > 
> > Tested-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> 
> Masami, can you ack this, and Shuah, can you take it?

Yeah anyway,

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Thanks!
> 
> -- Steve
> 
> > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > index 3fb70e01b1fe..3ff236719b6e 100644
> > > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> > > @@ -24,7 +24,21 @@ test -d events/kprobes2/event2 || exit_failure
> > >  
> > >  :;: "Add an event on dot function without name" ;:
> > >  
> > > -FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> > > +find_dot_func() {
> > > +	if [ ! -f available_filter_functions ]; then
> > > +		grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "
> > > +		return;
> > > +	fi
> > > +
> > > +	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
> > > +		if grep -s $f available_filter_functions; then
> > > +			echo $f
> > > +			break
> > > +		fi
> > > +	done
> > > +}
> > > +
> > > +FUNC=`find_dot_func | tail -n 1`
> > >  [ "x" != "x$FUNC" ] || exit_unresolved
> > >  echo "p $FUNC" > kprobe_events
> > >  EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:`  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
