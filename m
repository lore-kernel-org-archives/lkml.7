Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF3AC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342FF206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgABPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:35:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:59156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgABPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:35:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3F850AD31;
        Thu,  2 Jan 2020 15:35:49 +0000 (UTC)
Date:   Thu, 2 Jan 2020 16:35:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix exclusive_console replaying
Message-ID: <20200102153548.nrn4cce4gg4oiwhe@pathway.suse.cz>
References: <20191219115322.31160-1-john.ogness@linutronix.de>
 <20191223001801.GA121292@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223001801.GA121292@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-12-23 09:18:01, Sergey Senozhatsky wrote:
> On (19/12/19 12:59), John Ogness wrote:
> > Commit f92b070f2dc8 ("printk: Do not miss new messages when replaying
> > the log") introduced a new variable @exclusive_console_stop_seq to
> > store when an exclusive console should stop printing. It should be
> > set to the @console_seq value at registration. However, @console_seq
> > is previously set to @syslog_seq so that the exclusive console knows
> > where to begin. This results in the exclusive console immediately
> > reactivating all the other consoles and thus repeating the messages
> > for those consoles.
> > 
> > Set @console_seq after @exclusive_console_stop_seq has stored the
> > current @console_seq value.
> > 
> > Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the log")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

The patch has been commited into printk.git, branch for-5.6.

Best Regards,
Petr
