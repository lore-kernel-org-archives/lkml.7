Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10042173B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfEHQxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbfEHQxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:53:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E6A20850;
        Wed,  8 May 2019 16:53:38 +0000 (UTC)
Date:   Wed, 8 May 2019 12:53:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <mingo@redhat.com>,
        <bobo.shaobowang@huawei.com>
Subject: Re: [PATCH] ftrace: enable trampoline when rec count decrement to
 one
Message-ID: <20190508125337.37777a2f@gandalf.local.home>
In-Reply-To: <e45dec40-d068-be47-7cbb-1b897e48c306@huawei.com>
References: <1556969979-111047-1-git-send-email-cj.chengjian@huawei.com>
        <20190505153447.594d4eab@oasis.local.home>
        <e45dec40-d068-be47-7cbb-1b897e48c306@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 23:02:33 +0800
"chengjian (D)" <cj.chengjian@huawei.com> wrote:

> function tracer uses ftrace_caller() and livepatch uses 
> ftrace_regs_caller().
> 
> I can modify my testcase to trigger this race condition.
> 
> 
> #enable livepatch
> insmod klp_unshare_files.ko
> cat /sys/kernel/debug/tracing/enabled_functions
>          unshare_files (1) R I	tramp: 0xffffffffc0008000 (klp_ftrace_handler+0x0/0xa0) ->ftrace_ops_assist_func+0x0/0xf0
> [NOW, the rec caller is ftracer_regs_caller TRAMPOLINE]
> 
> #function tracer
> echo unshare_files > /sys/kernel/debug/tracing/set_ftrace_filter
> echo function > /sys/kernel/debug/tracing/current_tracer
> cat /sys/kernel/debug/tracing/enabled_functions
>          unshare_files (2) R I ->ftrace_ops_list_func+0x0/0x170
> [NOW, the rec caller is ftracer_regs_caller]
> 
> 
> # disable livepatch
> echo 0 > /sys/kernel/livepatch/klp_unshare_files/enabled
> rmmod klp_unshare_files
> 
> 
> cat /sys/kernel/debug/tracing/enabled_functions
>          unshare_files (1)    	tramp: 0xffffffffc0005000 (function_trace_call+0x0/0x120) ->function_trace_call+0x0/0x120
> [NOW, the rec caller is ftrace_caller TRAMPOLINE]
> 
> So, the caller switch from regs caller back to non regs caller
> when disable the livepatch. Could this testcase cause the race
> condition ? BUT, Nothing happened here.
> 
> What will happen when the race triggers ? What can I do.
> 

I still can't think of it. But since the merge window already opened,
I'd like to have this patch sit in linux-next for a bit. That is, I
would wait to pull it in for the next merge window, and not this one.

-- Steve
