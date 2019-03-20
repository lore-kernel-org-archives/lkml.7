Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5640C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC6B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCTPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfCTPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6455AEEE;
        Wed, 20 Mar 2019 15:37:29 +0000 (UTC)
Date:   Wed, 20 Mar 2019 16:37:29 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Calvin Owens <calvinowens@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/4] printk: Introduce per-console loglevel setting
Message-ID: <20190320153729.6cl77kdck22vc4rv@pathway.suse.cz>
References: <20190308150914.ifqp36en3pyd4ljy@pathway.suse.cz>
 <c7a9c83c-524d-c0da-a355-6cd4b7ec690c@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a9c83c-524d-c0da-a355-6cd4b7ec690c@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-03-14 23:12:49, Tetsuo Handa wrote:
> Petr Mladek wrote:
> > It might be even more straightforward when the per-console value
> > defines the effective console level. I mean the following semantic:
> > 
> >    + "console_loglevel" would define the default loglevel used
> >      by consoles at runtime.
> > 
> >    + the per-console loglevel could override the default
> >      console_loglevel.
> > 
> >    + We would need a custom handler for the sysctl "console_loglevel".
> >      It would write the given value to the global console_loglevel
> >      variable and for all already registered consoles (con->loglevel).
> 
> But some functions change console_loglevel without sysctl (e.g.
> console_verbose() when reporting hung tasks and panic()). Should
> con->loglevel be changed (which might result in too much messages to
> slow consoles) when console_loglevel changes?

It is about the semantic. We either want to set a hard limit
for each console or we want to set per-console loglevel that
will get used in normal situations.

I prefer the 2nd semantic. IMHO, console_verbose() should be
used only in situations when people really want to see all
lines, for example, panic, sysrq output when the machine
looks deadlocked, ignore_loglevel is set. I believe that they
want to see them even on the slow consoles that are
there exactly for debugging these critical situations.

Best Regards,
Petr
