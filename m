Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A93C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D708020840
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCBAys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:54:48 -0500
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:35668 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725996AbfCBAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:54:48 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9C5A4182251B2;
        Sat,  2 Mar 2019 00:54:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: war85_c404fbc63126
X-Filterd-Recvd-Size: 2804
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Mar 2019 00:54:44 +0000 (UTC)
Message-ID: <16dcfa8617d515c393da290b1d8c7c8991237b01.camel@perches.com>
Subject: Re: [PATCH] printk: Remove no longer used LOG_PREFIX.
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 16:54:42 -0800
In-Reply-To: <20190301124847.q6goqvcb7yhm6q6k@pathway.suse.cz>
References: <1550829580-9189-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
         <b830aae9-766f-54d2-840b-f70da3d1215d@i-love.sakura.ne.jp>
         <20190301124847.q6goqvcb7yhm6q6k@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-01 at 13:48 +0100, Petr Mladek wrote:
> I want to double check what was the history of KERN_DEFAULT defined
> as "d". It existed since ages...

There less than 100 uses of KERN_DEFAULT.

Relatively speaking, KERN_DEFAULT hasn't existed all
that long actually.

commit e28d713704117bca0820c732210df6075b09f13b
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jun 16 11:02:28 2009 -0700

    printk: Add KERN_DEFAULT printk log-level

    This adds a KERN_DEFAULT loglevel marker, for when you cannot decide
    which loglevel you want, and just want to keep an existing printk
    with the default loglevel.
    
    The difference between having KERN_DEFAULT and having no log-level
    marker at all is two-fold:
    
     - having the log-level marker will now force a new-line if the
       previous printout had not added one (perhaps because it forgot,
       but perhaps because it expected a continuation)
    
     - having a log-level marker is required if you are printing out a
       message that otherwise itself could perhaps otherwise be mistaken
       for a log-level.
    
    Signed-of-by: Linus Torvalds <torvalds@linux-foundation.org>

Ever since Linus changed the default logging mechanism
for printks and KERN_CONT uses in

commit 4bcc595ccd80decb4245096e3d1258989c50ed41
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Oct 8 20:32:40 2016 -0700

    printk: reinstate KERN_CONT for printing continuation lines
    
the listed reasons in commit e28d713704117bca0820c732210df6075b09f13b
for the use of KERN_DEFAULT are no longer necessary.

I still think it'd be better to remove KERN_DEFAULT altogether.


