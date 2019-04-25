Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1EC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8477217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfDYHuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:50:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:39868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727938AbfDYHuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:50:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E6FCAF60;
        Thu, 25 Apr 2019 07:50:03 +0000 (UTC)
Date:   Thu, 25 Apr 2019 09:50:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 1/2] printk: lock console_sem before we unregister
 boot consoles
Message-ID: <20190425075002.r4g325fyh5jmabzs@pathway.suse.cz>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-2-sergey.senozhatsky@gmail.com>
 <20190424144924.lw5sgl7qa2yrpxsj@pathway.suse.cz>
 <20190425035233.GA8532@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425035233.GA8532@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-04-25 12:52:33, Sergey Senozhatsky wrote:
> On (04/24/19 16:49), Petr Mladek wrote:
> > > +	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
> > > +		console_lock();
> > > +		/*
> > > +		 * We need to iterate through all boot consoles, to make
> > >  		 * sure we print everything out, before we unregister them.
> > >  		 */
> > 
> > I wondered if moving the console locking could break the above
> > statement.
> > 
> > It seems that the comment has been invalid since the commit
> > 8259cf4342029aad37660e ("printk: Ensure that "console
> > enabled" messages are printed on the console").
> 
> That's very interesting. Yes, you are right, the comment is a
> leftover. printk used to iterate consoles twice before
> 8259cf4342029aad37660e
> 
>                /* we need to iterate through twice, to make sure we print
>                 * everything out, before we unregister the console(s)
>                 */
>                printk(KERN_INFO "console handover:");
>                for_each_console(bcon)
>                        printk("boot [%s%d] ", bcon->name, bcon->index);
> 
>                printk(" -> real [%s%d]\n", newcon->name, newcon->index);
>                for_each_console(bcon)
>                        unregister_console(bcon);
> 
> But 8259cf4342029aad37660e has changed that and has made comment
> invalid.
> 
> > Could we remove it in this patch? It touches it indirectly anyway.
> 
> Sure we can.
> 
> We also can take extra care of pr_info("%sconsole [%s%d] enabled\n".
> Right now we do
> 
> 	...
> 	console_unlock();
> 	console_sysfs_notify();
> 
> 	pr_info("%sconsole [%s%d] enabled\n",....
> 
> 
> But we can simply move that pr_info() a bit up:
> 
> 	pr_info("%sconsole [%s%d] enabled\n",
> 	console_unlock();
> 	console_sysfs_notify();
> 
> 
> So the message will be printed on all consoles.

Great idea!

It would deserve a separate patch that moves the pr_info()
and removes the invalid comment.

Actually, the pr_info() would deserve a comment explaining
why it should be called before console_unlock().

Best Regards,
Petr
