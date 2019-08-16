Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0CAC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DD621721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfHPIUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:20:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbfHPIUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:20:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62492B089;
        Fri, 16 Aug 2019 08:20:01 +0000 (UTC)
Date:   Fri, 16 Aug 2019 10:20:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     " Justin He (Arm Technology China) " <Justin.He@arm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        KeesCook <keescook@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C.Harding" <tobin@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid
 pointers for %pD
Message-ID: <20190816082000.jmz47bke4it72sv5@pathway.suse.cz>
References: <20190809012457.56685-1-justin.he@arm.com>
 <CAHp75VcR1rJ5AX_Nj3n2NnMasLRp74Y3R6Mh4XQ5s64aKrF6tw@mail.gmail.com>
 <DB7PR08MB3082C27A075C410FE339F308F7D60@DB7PR08MB3082.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB3082C27A075C410FE339F308F7D60@DB7PR08MB3082.eurprd08.prod.outlook.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-08-09 10:56:04,  Justin He (Arm Technology China)  wrote:
> 
> 
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: 2019年8月9日 18:52
> > To: Justin He (Arm Technology China) <Justin.He@arm.com>
> > Cc: Petr Mladek <pmladek@suse.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Sergey Senozhatsky
> > <sergey.senozhatsky@gmail.com>; Geert Uytterhoeven
> > <geert+renesas@glider.be>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Thomas Gleixner <tglx@linutronix.de>; Steven
> > Rostedt (VMware) <rostedt@goodmis.org>; Kees Cook
> > <keescook@chromium.org>; Shuah Khan <shuah@kernel.org>; Tobin C.
> > Harding <tobin@kernel.org>
> > Subject: Re: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid
> > pointers for %pD
> >
> > On Fri, Aug 9, 2019 at 4:28 AM Jia He <justin.he@arm.com> wrote:
> > >
> > > Commit 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing
> > invalid
> > > pointers") prevents most crash except for %pD.
> > > There is an additional pointer dereferencing before dentry_name.
> > >
> > > At least, vma->file can be NULL and be passed to printk %pD in
> > > print_bad_pte, which can cause crash.
> > >
> > > This patch fixes it with introducing a new file_dentry_name.
> > >
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > Perhaps you need to add a Fixes tag
> Thanks, Andy
> Fixes: 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")

I have added the Fixes tag and pushed the patch into printk.git,
branch for-5.4.

Thanks for the fix.

Best Regards,
Petr
