Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED01C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A822145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbfGPHlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:37304 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfGPHlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:41:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79244AF3F;
        Tue, 16 Jul 2019 07:41:05 +0000 (UTC)
Date:   Tue, 16 Jul 2019 09:41:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/printk: prevent deadlock at unexpected call
 kmsg_dump in NMI context
Message-ID: <20190716074104.jeagfyr4k57lranz@pathway.suse.cz>
References: <156317789553.326.15952579019338825022.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156317789553.326.15952579019338825022.stgit@buzz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-07-15 11:04:55, Konstantin Khlebnikov wrote:
> Kernel message dumper - function kmsg_dump() is called on various oops or
> panic paths which could happen in unpredictable context including NMI.
> 
> Panic in NMI is handled especially by stopping all other cpus with
> smp_send_stop() and busting locks in printk_safe_flush_on_panic().
> 
> Other less-fatal cases shouldn't happen in NMI and cannot be handled.
> But this might happen for example on oops in nmi context. In this case
> dumper could deadlock on lockbuf_lock or break internal structures.

If I get it correctly than this patch could really prevent a deadlock
in at least:

  + oops_end()
    + oops_exit()
      + kmsg_dump(KMSG_DUMP_OOPS)

If it is called in NMI, it should end up with panic(). Then the dump
will be called later after stopping CPUs...

Or am I wrong?

Otherwise, the patch looks good to me. I would just mention
the above scenario if it is correct.

Best Regards,
Petr

> This patch catches kmsg_dump() called in NMI context except panic and
> prints warning once.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Link: https://lore.kernel.org/lkml/156294329676.1745.2620297516210526183.stgit@buzz/ (v1)
> ---
>  kernel/printk/printk.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 1888f6a3b694..e711f64a1843 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3104,6 +3104,13 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>  	struct kmsg_dumper *dumper;
>  	unsigned long flags;
>  
> +	/*
> +	 * In NMI context only panic could be handled safely:
> +	 * it stops other cpus and busts logbuf lock.
> +	 */
> +	if (WARN_ON_ONCE(reason != KMSG_DUMP_PANIC && in_nmi()))
> +		return;
> +
>  	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
>  		return;
>  
> 
