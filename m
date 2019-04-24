Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE07AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A167520878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbfDXPwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:52:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20185 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730625AbfDXPwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAD1A30A8199;
        Wed, 24 Apr 2019 15:52:04 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0F55D704;
        Wed, 24 Apr 2019 15:52:01 +0000 (UTC)
Date:   Wed, 24 Apr 2019 10:51:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] stacktrace: Remove superfluous WARN_ONCE() from
 save_stack_trace_tsk_reliable()
Message-ID: <20190424155154.h62wc3nt7ib2phdy@treble>
References: <20190424085550.29612-1-pmladek@suse.com>
 <20190424085550.29612-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424085550.29612-3-pmladek@suse.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 24 Apr 2019 15:52:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:55:49AM +0200, Petr Mladek wrote:
> WARN_ONCE() in the generic save_stack_trace_tsk_reliable() is superfluous.
> The only current user klp_check_stack() writes its own warning when
> -ENOSYS is returned.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/stacktrace.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index f8edee9c792d..83ac0ac5ffd9 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -74,6 +74,5 @@ __weak int
>  save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  			      struct stack_trace *trace)
>  {
> -	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
>  	return -ENOSYS;
>  }
> -- 
> 2.16.4
> 

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
