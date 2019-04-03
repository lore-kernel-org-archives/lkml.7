Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D383C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3B2205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 17:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCRYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:24:19 -0400
Received: from foss.arm.com ([217.140.101.70]:45538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfDCRYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 13:24:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C805080D;
        Wed,  3 Apr 2019 10:24:18 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B751C3F68F;
        Wed,  3 Apr 2019 10:24:17 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:24:15 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, croce@redhat.com
Subject: Re: [PATCH] kernel/sysctl.c: Fix out-of-bounds access when setting
 file-max
Message-ID: <20190403172415.GD17500@fuggles.cambridge.arm.com>
References: <20190403153409.17307-1-will.deacon@arm.com>
 <20190403154044.qejdbl7i2ny37jef@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403154044.qejdbl7i2ny37jef@brauner.io>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Wed, Apr 03, 2019 at 05:40:45PM +0200, Christian Brauner wrote:
> On Wed, Apr 03, 2019 at 04:34:09PM +0100, Will Deacon wrote:
> > Commit 32a5ad9c2285 ("sysctl: handle overflow for file-max") hooked
> > up min/max values for the file-max sysctl parameter via the .extra1
> > and .extra2 fields in the corresponding struct ctl_table entry.
> > 
> > Unfortunately, the minimum value points at the global 'zero' variable,
> > which is an int. This results in a KASAN splat when accessed as a long
> > by proc_doulongvec_minmax on 64-bit architectures:
> > 
> >   | BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x5d8/0x6a0
> >   | Read of size 8 at addr ffff2000133d1c20 by task systemd/1
> >   |
> >   | CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc3-00012-g40b114779944 #2
> >   | Hardware name: linux,dummy-virt (DT)
> >   | Call trace:
> >   |  dump_backtrace+0x0/0x228
> >   |  show_stack+0x14/0x20
> >   |  dump_stack+0xe8/0x124
> >   |  print_address_description+0x60/0x258
> >   |  kasan_report+0x140/0x1a0
> >   |  __asan_report_load8_noabort+0x18/0x20
> >   |  __do_proc_doulongvec_minmax+0x5d8/0x6a0
> >   |  proc_doulongvec_minmax+0x4c/0x78
> >   |  proc_sys_call_handler.isra.19+0x144/0x1d8
> >   |  proc_sys_write+0x34/0x58
> >   |  __vfs_write+0x54/0xe8
> >   |  vfs_write+0x124/0x3c0
> >   |  ksys_write+0xbc/0x168
> >   |  __arm64_sys_write+0x68/0x98
> >   |  el0_svc_common+0x100/0x258
> >   |  el0_svc_handler+0x48/0xc0
> >   |  el0_svc+0x8/0xc
> >   |
> >   | The buggy address belongs to the variable:
> >   |  zero+0x0/0x40
> >   |
> >   | Memory state around the buggy address:
> >   |  ffff2000133d1b00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
> >   |  ffff2000133d1b80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
> >   | >ffff2000133d1c00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
> >   |                                ^
> >   |  ffff2000133d1c80: fa fa fa fa 00 fa fa fa fa fa fa fa 00 00 00 00
> >   |  ffff2000133d1d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 
> > Fix the splat by introducing a unsigned long 'zero_ul' and using that
> > instead.
> > 
> > Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")
> > Cc: Christian Brauner <christian@brauner.io>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Hey Will, thanks! For the record, there's another patch by Matteo (Cced)
> for the same thing:
> https://lore.kernel.org/lkml/20190328130306.25384-1-mcroce@redhat.com/

Oops, sorry, I didn't spot that. I just ran into this while I was using
KASAN to investigate a different issue and quickly sent out a fix.

> He's proposing a slightly different version for the fix. I don't care
> very much but I like that you've used the explicit unsigned long so:
> 
> Acked-by: Christian Brauner <christian@brauner.io>
> 
> Thanks to both of you for fixing this!

I'm also not bothered about which patch gets in, as long as the problem is
fixed. I assume somebody will pick up one of them...

Will
