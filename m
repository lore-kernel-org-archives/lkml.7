Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7933C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8075621734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfEQTKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:10:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfEQTKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E67D81F0D;
        Fri, 17 May 2019 19:10:16 +0000 (UTC)
Received: from treble (ovpn-125-173.rdu2.redhat.com [10.10.125.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 963406085B;
        Fri, 17 May 2019 19:10:13 +0000 (UTC)
Date:   Fri, 17 May 2019 14:10:11 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jikos@kernel.org, pmladek@suse.com, tglx@linutronix.de
Subject: Re: [PATCH] stacktrace: fix CONFIG_ARCH_STACKWALK
 stack_trace_save_tsk_reliable return
Message-ID: <20190517191011.oe3g57vxwkf4gupa@treble>
References: <20190517185117.24642-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517185117.24642-1-joe.lawrence@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 17 May 2019 19:10:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 02:51:17PM -0400, Joe Lawrence wrote:
> Miroslav reported that the livepatch self-tests were failing,
> specifically a case in which the consistency model ensures that we do
> not patch a current executing function, "TEST: busy target module".
> 
> Recent renovations to stack_trace_save_tsk_reliable() left it returning
> only an -ERRNO success indication in some configuration combinations:
> 
>   klp_check_stack()
>     ret = stack_trace_save_tsk_reliable()
>       #ifdef CONFIG_ARCH_STACKWALK && CONFIG_HAVE_RELIABLE_STACKTRACE
>         stack_trace_save_tsk_reliable()
>           ret = arch_stack_walk_reliable()
>             return 0
>             return -EINVAL
>           ...
>           return ret;
>     ...
>     if (ret < 0)
>       /* stack_trace_save_tsk_reliable error */
>     nr_entries = ret;                               << 0
> 
> Previously (and currently for !CONFIG_ARCH_STACKWALK &&
> CONFIG_HAVE_RELIABLE_STACKTRACE) stack_trace_save_tsk_reliable()
> returned the number of entries that it consumed in the passed storage
> array.
> 
> In the case of the above config and trace, be sure to return the
> stacktrace_cookie.len on stack_trace_save_tsk_reliable() success.
> 
> Fixes: 25e39e32b0a3f ("livepatch: Simplify stack trace retrieval")
> Reported-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

It's great to see the livepatch selftests working and finding
regressions.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
