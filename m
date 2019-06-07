Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDD920868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfFGVKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:10:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37304 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbfFGVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:10:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 8816780310; Fri,  7 Jun 2019 23:10:09 +0200 (CEST)
Date:   Fri, 7 Jun 2019 19:09:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190607170922.GA17017@xo-6d-61-c0.localdomain>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
 <20190528084825.GA9676@jagdpanzerIV>
 <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-05-28 19:15:43, Tetsuo Handa wrote:
> On 2019/05/28 17:51, Sergey Senozhatsky wrote:
> >> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
> >> context information. But doesn't such attempt resemble find_printk_buffer() ?
> > 
> > Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
> > line is hardly possible. At the same time I'd really prefer not
> > to have buffering for sysrq.
> 
> I don't think it is hardly possible. And I really prefer having
> deferred printing for SysRq.

Well, magic SysRq was meant for situation where system is in weird/broken state.
"Give me backtrace where it is hung", etc. Direct printing is more likely to work
in that cases.
									Pavel
