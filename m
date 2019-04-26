Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F59C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34E20652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfDZIlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:41:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:46636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfDZIlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:41:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8078AF35;
        Fri, 26 Apr 2019 08:41:48 +0000 (UTC)
Date:   Fri, 26 Apr 2019 10:41:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] panic: make panic start/end messages consistent
Message-ID: <20190426084148.su4ez6oua7kgpgqx@pathway.suse.cz>
References: <20190426063356.20453-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426063356.20453-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 15:33:56, Sergey Senozhatsky wrote:
> We don't have consistency:
> - we always print panic header
> 	pr_emerg("Kernel panic - not syncing:")
> 
> - but we don't always print panic footer
> 	pr_emerg("---[ end Kernel panic - not syncing:")
> 
> For instance, no panic footer (end panic) message will be
> printed when panic_timeout is set - the kernel will either
> reboot immediately after console_flush_on_panic() (emergency
> restart) or after panic_timeout seconds. Additionally,
> panic_print_sys_info() goes before panic footer line, which
> doesn't look very right, panic_print_sys_info() is just
> additional debugging into.
> 
> Let's make it consistent:
> 
> 	pr_emerg("Kernel panic - not syncing:")
> 	dump_stack();
> 	console_flush_on_panic();
> 	pr_emerg("---[ end Kernel panic - not syncing:")
> 
> 	panic_print_sys_info();
> 	/* the rest */
> 	/* panic_timeout handling */
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Makes sense to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
