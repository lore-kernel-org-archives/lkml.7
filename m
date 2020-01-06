Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A763EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E15020715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFRyy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFRyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:54:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93EC2146E;
        Mon,  6 Jan 2020 17:54:50 +0000 (UTC)
Date:   Mon, 6 Jan 2020 12:54:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Alexei Starovoitov <ast@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: "ftrace: Rework event_create_dir()" triggers boot error
 messages
Message-ID: <20200106125449.563a2047@gandalf.local.home>
In-Reply-To: <3F343134-63CB-4D99-97AD-F512B8760C94@lca.pw>
References: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
        <20191218233101.73044ce3@rorschach.local.home>
        <3F343134-63CB-4D99-97AD-F512B8760C94@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 12:05:58 -0500
Qian Cai <cai@lca.pw> wrote:

> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index 53935259f701..abb70c71fe60 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -269,7 +269,8 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
> > 	struct syscall_trace_enter trace;
> > 	struct syscall_metadata *meta = call->data;
> > 	int offset = offsetof(typeof(trace), args);
> > -	int ret, i;
> > +	int ret = 0;
> > +	int i;
> > 
> > 	for (i = 0; i < meta->nb_args; i++) {
> > 		ret = trace_define_field(call, meta->types[i],  
> 
> Steve, those errors are still there in today’s linux-next. Is this patch on the way to the linux-next?

No, because this bug is not in my tree.

I'll send a proper patch to the tip folks.

-- Steve
