Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07720C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3F52133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfE1PDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:03:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:45366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfE1PDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:03:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1B5AACC4;
        Tue, 28 May 2019 15:03:47 +0000 (UTC)
Date:   Tue, 28 May 2019 17:03:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528150345.di2knfzmqfbwro3y@pathway.suse.cz>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
 <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <e564ee00-6a93-defd-4eab-e306bbfe8b01@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e564ee00-6a93-defd-4eab-e306bbfe8b01@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-05-28 23:21:17, Tetsuo Handa wrote:
> On 2019/05/28 22:42, Petr Mladek wrote:
> >> Ahh.. OK, now I sort of remember why I gave up on this idea (see [1]
> >> at the bottom, when it comes to uv_nmi_dump_state()) - printk_NMI and
> >> printk-safe redirections.
> >>
> >> 	NMI
> >> 		loglevel = NEW
> >> 		printk -> printk_safe_nmi
> >> 		loglevel = OLD
> >>
> >> 	iret
> >>
> >> 	IRQ
> >> 		flush printk_safe_nmi -> printk
> >> 		// At this point we don't remember about
> >> 		// loglevel manipulation anymore
> >> 	iret
> > 
> > printk_safe buffer preserves KERN_* headers. It should be
> > possible to insert KERN_UNSUPPRESSED there.
> 
> But is context dependent buffer large enough to hold SysRq-t output?
> I think that only main logbuf can become large enough to hold SysRq-t output.

SysRq messages are stored directly into the main log buffer.

The limited per-CPU buffers are needed only in printk_safe
and NMI context. We discussed it here because KERN_UNSUPPRESSED
allows to pass the information even from this context.

> We can add KERN_UNSUPPRESSED to SysRq's header line. But I don't think
> that we can automatically add KERN_UNSUPPRESSED to SysRq's body lines
> based on some context information. If we want to avoid manipulating
> console_loglevel, we need to think about how to make sure that
> KERN_UNSUPPRESSED is added to all lines from such context without
> overflowing capacity of that buffer.

We could set this context in printk_context per-CPU variable.

Then we could easily add the set per-message flag in
vprintk_store() for the normal/atomic context. And we
could store an extra KERN_UNSUPPRESSED in printk_safe_log_store()
for printk_safe and NMI context.

Best Regards,
Petr
