Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38264C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4D20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCDMyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:54:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCDMyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:54:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20F45AD47;
        Mon,  4 Mar 2019 12:54:38 +0000 (UTC)
Date:   Mon, 4 Mar 2019 13:54:37 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove no longer used LOG_PREFIX.
Message-ID: <20190304125437.67mnu6yzjhwkqweg@pathway.suse.cz>
References: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190304022229.GC23578@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304022229.GC23578@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-03-04 11:22:29, Sergey Senozhatsky wrote:
> On (02/22/19 18:59), Tetsuo Handa wrote:
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
> 
> Looks good to me. Well, at least I don't see any problems with the patch.
> We can do a tree-wide KERN_DEFAULT removal later.

Yup.

> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

With a fresh head after the weekend, the patch looks fine and
pretty safe to me.

I have pushed it into for-5.1 branch.

Best Regards,
Petr
