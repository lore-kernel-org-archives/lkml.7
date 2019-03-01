Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272D92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfCAMst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:48:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:44698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfCAMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:48:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E094AEBD;
        Fri,  1 Mar 2019 12:48:48 +0000 (UTC)
Date:   Fri, 1 Mar 2019 13:48:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove no longer used LOG_PREFIX.
Message-ID: <20190301124847.q6goqvcb7yhm6q6k@pathway.suse.cz>
References: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <b830aae9-766f-54d2-840b-f70da3d1215d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b830aae9-766f-54d2-840b-f70da3d1215d@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-03-01 19:31:59, Tetsuo Handa wrote:
> Can this patch go to Linux 5.1?

I am going to look at it the following week. I do not think that
it is necessary to hurry a clean up of old stuff up into 5.1.

I believe that it is correct. But it is not a typo fix. For example,
I want to double check what was the history of KERN_DEFAULT defined
as "d". It existed since ages...

Best Regards,
Petr

> On 2019/02/22 18:59, Tetsuo Handa wrote:
> > When commit 5becfb1df5ac8e49 ("kmsg: merge continuation records while
> > printing") introduced LOG_PREFIX, we used KERN_DEFAULT etc. as a flag
> > for setting LOG_PREFIX in order to tell whether to call cont_add()
> > (i.e. whether to append the message to "struct cont").
> > 
> > But since commit 4bcc595ccd80decb ("printk: reinstate KERN_CONT for
> > printing continuation lines") inverted the behavior (i.e. don't append
> > the message to "struct cont" unless KERN_CONT is specified) and commit
> > 5aa068ea4082b39e ("printk: remove games with previous record flags")
> > removed the last LOG_PREFIX check, setting LOG_PREFIX via KERN_DEFAULT
> > etc. is no longer meaningful.
> > 
> > Therefore, we can remove LOG_PREFIX and make KERN_DEFAULT empty string.
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> >  include/linux/kern_levels.h | 2 +-
> >  include/linux/printk.h      | 1 -
> >  kernel/printk/printk.c      | 6 +-----
> >  3 files changed, 2 insertions(+), 7 deletions(-)
