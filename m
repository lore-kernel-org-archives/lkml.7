Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA77C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307C2217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 01:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfHHBto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 21:49:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50112 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389618AbfHHBtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:49:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvXYT-00010L-MQ; Thu, 08 Aug 2019 01:49:26 +0000
Date:   Thu, 8 Aug 2019 02:49:25 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+3de312463756f656b47d@syzkaller.appspotmail.com>,
        allison@lohutok.net, andreyknvl@google.com, cai@lca.pw,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG: bad usercopy in hidraw_ioctl
Message-ID: <20190808014925.GL1131@ZenIV.linux.org.uk>
References: <000000000000ce6527058f8bf0d0@google.com>
 <20190807195821.GD5482@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807195821.GD5482@bombadil.infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 12:58:21PM -0700, Matthew Wilcox wrote:
> On Wed, Aug 07, 2019 at 12:28:06PM -0700, syzbot wrote:
> > usercopy: Kernel memory exposure attempt detected from wrapped address
> > (offset 0, size 0)!
> > ------------[ cut here ]------------
> > kernel BUG at mm/usercopy.c:98!
> 
> This report is confusing because the arguments to usercopy_abort() are wrong.
> 
>         /* Reject if object wraps past end of memory. */
>         if (ptr + n < ptr)
>                 usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
> 
> ptr + n is not 'size', it's what wrapped.  I don't know what 'offset'
> should be set to, but 'size' should be 'n'.  Presumably we don't want to
> report 'ptr' because it'll leak a kernel address ... reporting 'n' will
> leak a range for a kernel address, but I think that's OK?  Admittedly an
> attacker can pass in various values for 'n', but it'll be quite noisy
> and leave a trace in the kernel logs for forensics to find afterwards.
> 
> > Call Trace:
> >  check_bogus_address mm/usercopy.c:151 [inline]
> >  __check_object_size mm/usercopy.c:260 [inline]
> >  __check_object_size.cold+0xb2/0xba mm/usercopy.c:250
> >  check_object_size include/linux/thread_info.h:119 [inline]
> >  check_copy_size include/linux/thread_info.h:150 [inline]
> >  copy_to_user include/linux/uaccess.h:151 [inline]
> >  hidraw_ioctl+0x38c/0xae0 drivers/hid/hidraw.c:392
> 
> The root problem would appear to be:
> 
>                                 else if (copy_to_user(user_arg + offsetof(
>                                         struct hidraw_report_descriptor,
>                                         value[0]),
>                                         dev->hid->rdesc,
>                                         min(dev->hid->rsize, len)))
> 
> That 'min' should surely be a 'max'?

Surely not.  ->rsize is the amount of data available to copy out; len
is the size of buffer supplied by userland to copy into.

BTW, why is it playing those games with offsetof, anyway?  What's wrong
with
	struct hidraw_report_descriptor __user *p = user_arg;
	...
	get_user(&p->size)
	...
	copy_to_user(p->value, ...)
