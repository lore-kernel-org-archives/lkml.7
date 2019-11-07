Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5882C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B672B214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfKGOiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:38:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:40374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727849AbfKGOiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:38:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C281ACA5;
        Thu,  7 Nov 2019 14:38:11 +0000 (UTC)
Date:   Thu, 7 Nov 2019 15:38:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
Message-ID: <20191107143810.oon6bj7dc7xqcyxe@pathway.suse.cz>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
 <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
 <CAMo8BfLmcCOAinyjB3iEuOF36TYBig=724=s9b6EKr3LzwF5QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfLmcCOAinyjB3iEuOF36TYBig=724=s9b6EKr3LzwF5QQ@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-11-06 16:21:51, Max Filippov wrote:
> On Wed, Nov 6, 2019 at 2:34 PM Joe Perches <joe@perches.com> wrote:
> > > @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
> > >       for (i = 0; i < kstack_depth_to_print; i++) {
> > >               if (kstack_end(sp))
> > >                       break;
> > > -             pr_cont(" %08lx", *sp++);
> > > +             sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
> > >               if (i % 8 == 7)
> > > -                     pr_cont("\n");
> > > +                     pr_info("%s\n", buf);
> > >       }
> > > +     if (i % 8)
> > > +             pr_info("%s\n", buf);
> >
> > Could this be done using hex_dump_to_buffer
> > by precalculating kstack_end ?
> 
> I've got this, but it doesn't look very attractive to me:
> 
> void show_stack(struct task_struct *task, unsigned long *sp)
> {
>         unsigned long *stack;
>         int len;
> 
>         if (!sp)
>                 sp = stack_pointer(task);
>         stack = sp;
> 
>         len = min((-(unsigned long)stack) & (THREAD_SIZE - 4),
>                   kstack_depth_to_print * 4ul);
> 
>         pr_info("Stack:\n");
> 
>         for (; len > 0; len -= 32) {
>                 char buf[9 * 8 + 1];
> 
>                 hex_dump_to_buffer(sp, min(len, 32), 32, 4,
>                                    buf, sizeof(buf), false);
>                 pr_info(" %08lx:  %s\n", (unsigned long)sp, buf);
>                 sp += 8;
>         }

I wonder if the cycle actually could get replaced by a single call:

	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
		       16, 1, sp, len, false);

print_hex_dump() currently does not allow to print 8 bytes per-line.
Either 16 is acceptable or hex_dump() function could be updated.

Best Regards,
Petr
