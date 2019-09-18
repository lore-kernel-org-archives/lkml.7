Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29EFC4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5321855
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfIRBOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfIRBOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:14:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43387206C2;
        Wed, 18 Sep 2019 01:14:01 +0000 (UTC)
Date:   Tue, 17 Sep 2019 21:13:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+2f807f4d3a2a4e87f18f@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in trace_probe_unlink
Message-ID: <20190917211359.0407a222@oasis.local.home>
In-Reply-To: <20190917031342.7248-1-hdanton@sina.com>
References: <20190917031342.7248-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 11:13:42 +0800
Hillf Danton <hdanton@sina.com> wrote:


> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -986,6 +986,9 @@ int trace_probe_init(struct trace_probe
>  	if (!tp->event)
>  		return -ENOMEM;
>  
> +	/* shun gpf in error cleanup path */
> +	INIT_LIST_HEAD(&tp->list);

Thanks, but I took Masami's patch.

 https://lore.kernel.org/lkml/156869709721.22406.5153754822203046939.stgit@devnote2/

-- Steve

> +
>  	call = trace_probe_event_call(tp);
>  	call->class = &tp->event->class;
>  	call->name = kstrdup(event, GFP_KERNEL);
> @@ -1002,7 +1005,6 @@ int trace_probe_init(struct trace_probe
>  	INIT_LIST_HEAD(&tp->event->files);
>  	INIT_LIST_HEAD(&tp->event->class.fields);
>  	INIT_LIST_HEAD(&tp->event->probes);
> -	INIT_LIST_HEAD(&tp->list);
>  	list_add(&tp->event->probes, &tp->list);
>  
>  	return 0;
> --

