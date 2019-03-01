Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38284C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4BB20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCAT3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:29:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfCAT3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:29:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 913032070B;
        Fri,  1 Mar 2019 19:29:40 +0000 (UTC)
Date:   Fri, 1 Mar 2019 14:29:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5] panic: Avoid the extra noise dmesg
Message-ID: <20190301142939.072e6a26@gandalf.local.home>
In-Reply-To: <20190301085401.vmfnw4geqz5xyeeh@pathway.suse.cz>
References: <1550815226-34194-1-git-send-email-feng.tang@intel.com>
        <20190222060959.pe3u4yvcjw6yj347@shbuild888>
        <20190228120014.19c0ab9227809341c1d5acc6@linux-foundation.org>
        <20190301041131.ypg6oaxhzyrgkkfu@shbuild888>
        <20190301085401.vmfnw4geqz5xyeeh@pathway.suse.cz>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 09:54:01 +0100
Petr Mladek <pmladek@suse.com> wrote:

I'll put my $0.02 in, and say I like the idea of the patch too.


> > > Thoughts:
> > > 
> > > - why do the suppression in vprintk_emit()?  Doing it right at entry
> > >   to printk() seems cleaner, more explicit?  
> > 
> > Yes, I put it in printk() in one earlier post, and Petr suggested to
> > put it into vprintk_emit so that it works for all printk() interfaces,
> > like the devkmsg_write -> printk_emit -> vprintk_emit path.  
> 
> Yes, there are more printk interfaces. The check in vprintk_emit()
> allows to calm down also prink_deferred() and dev_printk().

Agreed.

> 
> > > - Other code sites may wish to suppress all printks.  Perhaps
> > >   `panic_suppress_printk' should just be called `suppress_printk'?  
> > Ok, then I'll move the definition from panic.c to printk code.  
> 
> This change looks fine to me.
> 
> Best Regards,
> Petr
> 
> PS: I am sorry for the late review. I have spent many days with
> reviewing a proposal of rewrite of printk() internals.

Thanks for doing that, BTW.

-- Steve
