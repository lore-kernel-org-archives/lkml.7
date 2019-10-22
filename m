Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C60CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA5E218AE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfJVNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbfJVNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:44:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7041C20700;
        Tue, 22 Oct 2019 13:44:56 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:44:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022094455.6a0a1a27@gandalf.local.home>
In-Reply-To: <20191022071956.07e21543@gandalf.local.home>
References: <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
        <20191002182106.GC4643@worktop.programming.kicks-ass.net>
        <20191003181045.7fb1a5b3@gandalf.local.home>
        <20191004112237.GA19463@hirez.programming.kicks-ass.net>
        <20191004094228.5a5774fe@gandalf.local.home>
        <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
        <20191021204310.3c26f730@oasis.local.home>
        <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
        <20191021231630.49805757@oasis.local.home>
        <20191021231904.4b968dc1@oasis.local.home>
        <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
        <20191022071956.07e21543@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 07:19:56 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > I'm not touching dyn_ftrace.
> > Actually calling my stuff ftrace+bpf is probably not correct either.
> > I'm reusing code patching of nop into call that ftrace does. That's it.
> > Turned out I cannot use 99% of ftrace facilities.
> > ftrace_caller, ftrace_call, ftrace_ops_list_func and the whole ftrace api
> > with ip, parent_ip and pt_regs cannot be used for this part of the work.
> > bpf prog needs to access raw function arguments. To achieve that I'm  
> 
> You can do that today with the ftrace facility, just like live patching
> does. You register a ftrace_ops with the flag FTRACE_OPS_FL_IPMODIFY,
> and your func will set the regs->ip to your bpf handler. When the
> ftrace_ops->func returns, instead of going back to the called
> function, it can jump to your bpf_handler. You can create a shadow stack
> (like function graph tracer does) to save the return address for where
> you bpf handler needs to return to. As your bpf_handler needs raw
> access to the parameters, it may not even need the shadow stack because
> it should know the function it is reading the parameters from.

To show just how easy this is, I wrote up a quick hack that hijacks the
wake_up_process() function and adds a trace_printk() to see what was
woken up. My output from the trace is this:

          <idle>-0     [007] ..s1    68.517276: my_wake_up: We are waking up rcu_preempt:10
           <...>-1240  [001] ....    68.517727: my_wake_up: We are waking up kthreadd:2
           <...>-1240  [001] d..1    68.517973: my_wake_up: We are waking up kworker/1:0:17
            bash-1188  [003] d..2    68.519020: my_wake_up: We are waking up kworker/u16:3:140
            bash-1188  [003] d..2    68.519138: my_wake_up: We are waking up kworker/u16:3:140
            sshd-1187  [005] d.s2    68.519295: my_wake_up: We are waking up kworker/5:2:517
          <idle>-0     [007] ..s1    68.522293: my_wake_up: We are waking up rcu_preempt:10
          <idle>-0     [007] ..s1    68.526309: my_wake_up: We are waking up rcu_preempt:10

I added the code to the trace-event-sample.c sample module, and got the
above when I loaded that module (modprobe trace-event-sample).

It's mostly non arch specific (that is, you can do this with any
arch that supports the IPMODIFY flag). The only parts that would need
arch specific code is the regs->ip compare. The pip check can also be
done less "hacky". But this shows you how easy this can be done today.
Not sure what is missing that you need.

Here's the patch:

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 1a72b7d95cdc..526a6098c811 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -11,6 +11,41 @@
 #define CREATE_TRACE_POINTS
 #include "trace-events-sample.h"
 
+#include <linux/ftrace.h>
+
+int wake_up_process(struct task_struct *p);
+
+int x;
+
+static int my_wake_up(struct task_struct *p)
+{
+	int ret;
+
+	trace_printk("We are waking up %s:%d\n", p->comm, p->pid);
+	ret = wake_up_process(p);
+	/* Force not having a tail call */
+	if (!x)
+		return ret;
+	return 0;
+}
+
+static void my_hijack_func(unsigned long ip, unsigned long pip,
+			   struct ftrace_ops *ops, struct pt_regs *regs)
+{
+	unsigned long this_func = (unsigned long)my_wake_up;
+
+	if (pip >= this_func && pip <= this_func + 0x10000)
+		return;
+
+	regs->ip = my_wake_up;
+}
+
+static struct ftrace_ops my_ops = {
+	.func = my_hijack_func,
+	.flags = FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE |
+					   FTRACE_OPS_FL_SAVE_REGS,
+};
+
 static const char *random_strings[] = {
 	"Mother Goose",
 	"Snoopy",
@@ -115,6 +150,11 @@ void foo_bar_unreg(void)
 
 static int __init trace_event_init(void)
 {
+	int ret;
+
+	ret = ftrace_set_filter_ip(&my_ops, (unsigned long)wake_up_process, 0, 0);
+	if (!ret)
+		register_ftrace_function(&my_ops);
 	simple_tsk = kthread_run(simple_thread, NULL, "event-sample");
 	if (IS_ERR(simple_tsk))
 		return -1;
@@ -124,6 +164,7 @@ static int __init trace_event_init(void)
 
 static void __exit trace_event_exit(void)
 {
+	unregister_ftrace_function(&my_ops);
 	kthread_stop(simple_tsk);
 	mutex_lock(&thread_mutex);
 	if (simple_tsk_fn)


-- Steve
