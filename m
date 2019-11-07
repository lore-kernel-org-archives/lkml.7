Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DFDC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3694214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfKGOpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:45:43 -0500
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:38217 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727779AbfKGOpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:45:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9AC94182CED28;
        Thu,  7 Nov 2019 14:45:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bait99_88daa8df0b32f
X-Filterd-Recvd-Size: 3046
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Nov 2019 14:45:40 +0000 (UTC)
Message-ID: <bdd82a1f1711cc6862d9d27448bae0a15b96e288.camel@perches.com>
Subject: Re: [PATCH] xtensa: improve stack dumping
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>
Date:   Thu, 07 Nov 2019 06:45:25 -0800
In-Reply-To: <20191107143810.oon6bj7dc7xqcyxe@pathway.suse.cz>
References: <20191106181617.1832-1-jcmvbkbc@gmail.com>
         <a9e2f6b65d4c098ab027ea849120d3cf61858e67.camel@perches.com>
         <CAMo8BfLmcCOAinyjB3iEuOF36TYBig=724=s9b6EKr3LzwF5QQ@mail.gmail.com>
         <20191107143810.oon6bj7dc7xqcyxe@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 15:38 +0100, Petr Mladek wrote:
> On Wed 2019-11-06 16:21:51, Max Filippov wrote:
> > On Wed, Nov 6, 2019 at 2:34 PM Joe Perches <joe@perches.com> wrote:
> > > > @@ -512,10 +510,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
> > > >       for (i = 0; i < kstack_depth_to_print; i++) {
> > > >               if (kstack_end(sp))
> > > >                       break;
> > > > -             pr_cont(" %08lx", *sp++);
> > > > +             sprintf(buf + (i % 8) * 9, " %08lx", *sp++);
> > > >               if (i % 8 == 7)
> > > > -                     pr_cont("\n");
> > > > +                     pr_info("%s\n", buf);
> > > >       }
> > > > +     if (i % 8)
> > > > +             pr_info("%s\n", buf);
> > > 
> > > Could this be done using hex_dump_to_buffer
> > > by precalculating kstack_end ?
> > 
> > I've got this, but it doesn't look very attractive to me:
> > 
> > void show_stack(struct task_struct *task, unsigned long *sp)
> > {
> >         unsigned long *stack;
> >         int len;
> > 
> >         if (!sp)
> >                 sp = stack_pointer(task);
> >         stack = sp;
> > 
> >         len = min((-(unsigned long)stack) & (THREAD_SIZE - 4),
> >                   kstack_depth_to_print * 4ul);
> > 
> >         pr_info("Stack:\n");
> > 
> >         for (; len > 0; len -= 32) {
> >                 char buf[9 * 8 + 1];
> > 
> >                 hex_dump_to_buffer(sp, min(len, 32), 32, 4,
> >                                    buf, sizeof(buf), false);
> >                 pr_info(" %08lx:  %s\n", (unsigned long)sp, buf);
> >                 sp += 8;
> >         }
> 
> I wonder if the cycle actually could get replaced by a single call:
> 
> 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET,
> 		       16, 1, sp, len, false);

I think it could be using 4 and not 1 to keep the same output
of a u32 instead of spaces between bytes.



