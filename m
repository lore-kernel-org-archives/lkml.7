Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B2DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D23320673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfD2Lo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:44:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:48242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727933AbfD2Lo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:44:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1AB76AD76;
        Mon, 29 Apr 2019 11:44:25 +0000 (UTC)
Date:   Mon, 29 Apr 2019 13:44:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190429114423.yr7hbmfrfbravgsv@pathway.suse.cz>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
 <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
 <20190426135316.GA505@tigerII.localdomain>
 <20190426141426.h7hpvhr3rqp7umbk@pathway.suse.cz>
 <20190426164302.GA26127@tigerII.localdomain>
 <20190426171640.GA7413@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426171640.GA7413@tigerII.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2019-04-27 02:16:40, Sergey Senozhatsky wrote:
> On (04/27/19 01:43), Sergey Senozhatsky wrote:
> [..]
> > > The console waiter logic is effective but it does not always
> > > work. The current console owner must be calling the console
> > > drivers.
> > >
> > > >   Hmm, we might have a bit of a problem here, maybe.
> > >
> > > Hmm, the printk() might wait forever when NMI stopped
> > > the current console owner in the console driver code
> > > or with the logbuf_lock taken.
> > 
> > I guess this is why we re-init logbuf lock from panic,
> > however, we don't do anything with the console_owner.

> > > The console waiter logic might get solved by clearing
> > > the console_owner in console_flush_on_panic(). It can't
> > > be much worse, we already ignore console_lock() there, ...
> 
> Hmm, or maybe we are fine... console_waiter logic should work
> before we send out stop IPI/NMI from panic CPU. When we call
> flush_on_panic() console_unlock() clears console_owner, so
> panic_print_sys_info() should not deadlock on console_owner.

Good point!

> It's probably only problematic if we kill a console_owner
> CPU and then try to printk() (from smp_send_stop()) before
> we do flush_on_panic()->console_unlock().

Yup. There are called several functions between smp_send_stop()
and console_flush_on_panic().

The question is if it is worth a code complication. We could
never 100% guarantee that printk() would work in panic().
I more and more understand what Peter Zijlstra means
by the duct taping.

Best Regards,
Petr
