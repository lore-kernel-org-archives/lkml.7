Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A5C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B460C20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfJORFj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfJORFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:05:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2975E2084B;
        Tue, 15 Oct 2019 17:05:38 +0000 (UTC)
Date:   Tue, 15 Oct 2019 13:05:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: Re: [PATCH] tracing: Sample module to demonstrate kernel access to
 Ftrace instances.
Message-ID: <20191015130536.3b1f5bf6@gandalf.local.home>
In-Reply-To: <1569023966-23004-2-git-send-email-divya.indi@oracle.com>
References: <1569023966-23004-1-git-send-email-divya.indi@oracle.com>
        <1569023966-23004-2-git-send-email-divya.indi@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 16:59:26 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> This is a sample module to demostrate the use of the newly introduced and
> exported APIs to access Ftrace instances from within the kernel.
> 
> Newly introduced APIs used here -
> 
> 1. Create a new trace array if it does not exist.
> struct trace_array *trace_array_create(const char *name)
> 
> 2. Destroy/Remove a trace array.
> int trace_array_destroy(struct trace_array *tr)
> 
> 3. Lookup a trace array, given its name.
> struct trace_array *trace_array_lookup(const char *name)
> 
> 4. Enable/Disable trace events:
> int trace_array_set_clr_event(struct trace_array *tr, const char *system,
>         const char *event, int set);
> 
> Exported APIs -
> 1. trace_printk equivalent for instances.
> int trace_array_printk(struct trace_array *tr,
>                unsigned long ip, const char *fmt, ...);
> 
> 2. Helper function.
> void trace_printk_init_buffers(void);
> 
> 3. To decrement the reference counter.
> void trace_array_put(struct trace_array *tr)
> 
> Signed-off-by: Divya Indi <divya.indi@oracle.com>
> Reviewed-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> Reviewed-by: Joe Jin <joe.jin@oracle.com>
> ---
>  samples/Kconfig                              |   7 ++
>  samples/Makefile                             |   1 +
>  samples/ftrace_instance/Makefile             |   6 ++
>  samples/ftrace_instance/sample-trace-array.c | 134 +++++++++++++++++++++++++++
>  samples/ftrace_instance/sample-trace-array.h |  84 +++++++++++++++++
>  5 files changed, 232 insertions(+)
>  create mode 100644 samples/ftrace_instance/Makefile
>  create mode 100644 samples/ftrace_instance/sample-trace-array.c
>  create mode 100644 samples/ftrace_instance/sample-trace-array.h
>

I applied this patch but get this:

/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘mytimer_handler’:
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:35:2: error: implicit declaration of function ‘trace_array_set_clr_event’; did you mean ‘trace_set_clr_event’? [-Werror=implicit-function-declaration]
  trace_array_set_clr_event(tr, "sample-subsystem", "sample_event", 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
  trace_set_clr_event
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘simple_thread_func’:
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:47:2: error: implicit declaration of function ‘trace_array_printk’; did you mean ‘trace_seq_printf’? [-Werror=implicit-function-declaration]
  trace_array_printk(tr, _THIS_IP_, "trace_array_printk: count=%d\n",
  ^~~~~~~~~~~~~~~~~~
  trace_seq_printf
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘simple_thread’:
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:85:2: error: implicit declaration of function ‘trace_array_put’; did you mean ‘trace_seq_putc’? [-Werror=implicit-function-declaration]
  trace_array_put(tr);
  ^~~~~~~~~~~~~~~
  trace_seq_putc
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘sample_trace_array_init’:
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:100:7: error: implicit declaration of function ‘trace_array_lookup’; did you mean ‘radix_tree_lookup’? [-Werror=implicit-function-declaration]
  tr = trace_array_lookup("sample-instance");
       ^~~~~~~~~~~~~~~~~~
       radix_tree_lookup
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:100:5: warning: assignment to ‘struct trace_array *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
  tr = trace_array_lookup("sample-instance");
     ^
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:102:8: error: implicit declaration of function ‘trace_array_create’; did you mean ‘ftrace_force_update’? [-Werror=implicit-function-declaration]
   tr = trace_array_create("sample-instance");
        ^~~~~~~~~~~~~~~~~~
        ftrace_force_update
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:102:6: warning: assignment to ‘struct trace_array *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
   tr = trace_array_create("sample-instance");
      ^
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:110:2: error: implicit declaration of function ‘trace_printk_init_buffers’; did you mean ‘trace_event_get_offsets’? [-Werror=implicit-function-declaration]
  trace_printk_init_buffers();
  ^~~~~~~~~~~~~~~~~~~~~~~~~
  trace_event_get_offsets
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c: In function ‘sample_trace_array_exit’:
/work/git/linux-trace.git/samples/ftrace_instance/sample-trace-array.c:126:2: error: implicit declaration of function ‘trace_array_destroy’; did you mean ‘assoc_array_destroy’? [-Werror=implicit-function-declaration]
  trace_array_destroy(tr);
  ^~~~~~~~~~~~~~~~~~~
  assoc_array_destroy
cc1: some warnings being treated as errors
make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:266: samples/ftrace_instance/sample-trace-array.o] Error 1
make[2]: *** [/work/git/linux-trace.git/scripts/Makefile.build:509: samples/ftrace_instance] Error 2
make[1]: *** [/work/git/linux-trace.git/Makefile:1650: samples] Error 2
make[1]: *** Waiting for unfinished jobs....


-- Steve
