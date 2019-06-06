Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D2CC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A0A2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFFHKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:10:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfFFHKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:10:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 33315AC84;
        Thu,  6 Jun 2019 07:10:41 +0000 (UTC)
Date:   Thu, 6 Jun 2019 09:10:40 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190606071039.txqczrjlntrljlrx@pathway.suse.cz>
References: <20190528002412.1625-1-dima@arista.com>
 <20190528041500.GB26865@jagdpanzerIV>
 <20190528044619.GA3429@jagdpanzerIV>
 <20190528134227.xyb3622gjwu52q4r@pathway.suse.cz>
 <20190603065153.GA13072@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603065153.GA13072@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-06-03 15:51:53, Sergey Senozhatsky wrote:
> On (05/28/19 15:42), Petr Mladek wrote:
> > On Tue 2019-05-28 13:46:19, Sergey Senozhatsky wrote:
> > > On (05/28/19 13:15), Sergey Senozhatsky wrote:
> > > > On (05/28/19 01:24), Dmitry Safonov wrote:
> > > > [..]
> > > > > While handling sysrq the console_loglevel is bumped to default to print
> > > > > sysrq headers. It's done to print sysrq messages with WARNING level for
> > > > > consumers of /proc/kmsg, though it sucks by the following reasons:
> > > > > - changing console_loglevel may produce tons of messages (especially on
> > > > >   bloated with debug/info prints systems)
> > > > > - it doesn't guarantee that the message will be printed as printk may
> > > > >   deffer the actual console output from buffer (see the comment near
> > > > >   printk() in kernel/printk/printk.c)
> > > > > 
> > > > > Provide KERN_UNSUPPRESSED printk() annotation for such legacy places.
> > > > > Make sysrq print the headers unsuppressed instead of changing
> > > > > console_loglevel.
> > 
> > I like this idea. console_loglevel is temporary manipulated only
> > when some messages should or should never appear on the console.
> > Storing this information in the message flags would help
> > to solve all the related races.
> 
> I don't really like the whole system-wide console_loglevel manipulation
> thing,

Just to be sure. I wanted to say that I like the idea with
KERN_UNSUPRESSED. So, I think that we are on the same page.

> except for console_verbose(), which seems the be the only legit
> case.

Note that CONSOLE_LOGLEVEL_SILENT is used in vkdb_printf(). I do not
know the background. But it might make some sense in kdb context.

> If KERN_UNSUPPRESSED is going to be yet-another-way-to-print-important-messages
> then I'm slightly less excited.

Yes, KERN_EMERG would do similar job.

Well, my understanding is that KERN_UNSUPRESSED would be used even
for less critical messages because the visibility is required
by the context or situation in which they are printed.

For example, we want to make all information visible in Oops because
the machine might be about to die. We might call there some shared
functions that produce less important messages in another context.

Also the pr_info() in __handle_sysrq() provides just informative
content. My understanding is that we want to show it just because
sysrq might be called when the system is not responding and we want
to give the user some feedback that the sysrq handler was called.

Now, KERN_EMERG might alarm some monitor of console output. It might
trigger unwanted reaction (forced reboot?) of the monitoring system
even when sysrq was not called in emergency situation.

I am sure that we need to care about such monitors. I have to
think more about it.

Best Regards,
Petr
