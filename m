Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C3BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A0A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfDWNsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfDWNsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:48:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0630D21773;
        Tue, 23 Apr 2019 13:48:02 +0000 (UTC)
Date:   Tue, 23 Apr 2019 09:48:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH 0/2] Access console drivers list under console_sem
Message-ID: <20190423094801.377b8059@gandalf.local.home>
In-Reply-To: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 15:25:09 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> Petr, Steven,
> 
> 	RFC
> 
> 	Normally, we grab console_sem lock before we iterate consoles
> list, which is necessary if we want to be race free. The only exception
> to this rule is console_flush_on_panic(). However, it seems that we are
> not fully race free - register_console() iterates console drivers list
> in unsafe manner in several places. E.g. the following scenarion:
> 
> 	CPU0					CPU1
> 	register_console()			unregister_console()
> 						 console_lock()
> 	  for_each_console()			  // modify console_drivers
> 	    con->foo				    kfree(con)
> 
> So I have two quick-n-dirty patches, which remove unsafe console list
> access.
> 
> What do you think?

I just skimmed the patches and haven't done a thorough review, but the
concept seems sane to me.

-- Steve

> 
> Sergey Senozhatsky (2):
>   printk: lock console_sem before we unregister boot consoles
>   printk: take console_sem when accessing console drivers list
> 
>  kernel/printk/printk.c | 117 ++++++++++++++++++++++++-----------------
>  1 file changed, 69 insertions(+), 48 deletions(-)
> 

