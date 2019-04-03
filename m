Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C56C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58A820700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MqjdxhtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCUPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:15:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfDCUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZBxAyp5v0q/HDp5IAxk7a1hs3OIuiAVZm8xEnBuJo1Q=; b=MqjdxhtWaikSeUIJhsoTdu1q2
        9uc1k0CoJoMCC7kfaWZEfMAhlpuPxGv8MX1B/dSKPIhbd31ZtJL1ATJkNHl+G5K0gB4sG6RlvJm2r
        KwXcTfkomHI2CsWWAU6OIivIUg11Yxh4RFNGCjlv1gclYHunAEikCrufiLPYRsAWy9anFBqA2NL2v
        SfchIx3mOEhex4WXPq4mOPpht5SXqIkq2o4Ac3vlzwproy45fVwVKv2rU/vzkcSHcJcUHH+t8ufng
        KYgw9/y9JSs5z4r+Uo6wohvrGVFbBVwm8+EE5B8hjX792DzPwEloL7wnUE4i863AFXrja3itUHmD4
        9hP5QCRpw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBmIU-0006ln-FY; Wed, 03 Apr 2019 20:15:46 +0000
Date:   Wed, 3 Apr 2019 13:15:45 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: Re: [PATCH] platform/x86: dell-smbios-base: Fix use after free on
 failure of dell_smbios_init()
Message-ID: <20190403201545.GA39081@wrath>
References: <20190403152018.77843868@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403152018.77843868@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 03:20:18PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If da_tokens are allocated, but dell_smbios_init() eventually fails, it will
> free the da_tokens but it does not reset the da_num_tokens number. This
> leads to the possibility of a use after free in dell_smbios_find_token().
> As da_tokens is not NULL and da_num_tokens is set to something other than 0.
> 
> By reseting the da_num_tokens to zero, and da_tokens to NULL after it is
> freed, then access into the other functions that reference them will not
> read freed memory.

Upon closer inspections this appears to be a race more than an access
issue.  Even with this patch, there is still the space between kfree()
and da_num_tokens = 0. This could be addressed by setting da_num_tokens
to 0 prior to the call to kfree().

That said, the bigger issue here seems to be the ability to use the
dell_smbios_find_token() call before the module_init() has completed
successfully.

Mario, care to weigh in?

> 
> This was caught by a KASAN report:
> 
> ==================================================================
> BUG: KASAN: use-after-free in dell_smbios_find_token+0x2e/0x80 [dell_smbios]
> Read of size 2 at addr ffff88840c2bc1a8 by task systemd-udevd/479
> 
> CPU: 0 PID: 479 Comm: systemd-udevd Not tainted 5.1.0-rc1+ #9
> Hardware name: Dell Inc. XPS 13 9360/02PG84, BIOS 2.3.1 10/03/2017
> Call Trace:
>  dump_stack+0x7c/0xbb
>  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
>  print_address_description+0xc7/0x280
>  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
>  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
>  kasan_report+0x14e/0x192
>  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
>  dell_smbios_find_token+0x2e/0x80 [dell_smbios]
>  kbd_led_init+0x2e7/0x473 [dell_laptop]
>  ? dmi_matched+0x2a/0x2a [dell_laptop]
>  ? get_device_parent.isra.28+0x2a0/0x2a0
>  ? lockdep_init_map+0x98/0x2c0
>  ? platform_device_add+0x1b5/0x3a0
>  dell_init+0x4ad/0xb63 [dell_laptop]
>  ? kbd_led_init+0x473/0x473 [dell_laptop]
>  ? ___slab_alloc+0x61f/0x700
>  ? ___slab_alloc+0x61f/0x700
>  ? preempt_count_sub+0x15/0x100
>  ? kbd_led_init+0x473/0x473 [dell_laptop]
>  do_one_initcall+0xbd/0x3fd
>  ? perf_trace_initcall_level+0x280/0x280
>  ? kasan_unpoison_shadow+0x30/0x40
>  ? __kasan_kmalloc.constprop.8+0xa0/0xd0
>  ? kmem_cache_alloc_trace+0x163/0x390
>  ? kasan_unpoison_shadow+0x30/0x40
>  do_init_module+0xe3/0x341
>  load_module+0x2fc5/0x3ad0
>  ? layout_and_allocate+0x1170/0x1170
>  ? vfs_read+0xd4/0x1b0
>  ? kernel_read+0x74/0xa0
>  ? kernel_read_file+0x148/0x320
>  ? seccomp_notify_release+0x110/0x110
>  ? __do_sys_finit_module+0x192/0x1c0
>  __do_sys_finit_module+0x192/0x1c0
>  ? __ia32_sys_init_module+0x40/0x40
>  ? syscall_trace_enter+0x184/0x5e0
>  ? mark_held_locks+0x1a/0x90
>  do_syscall_64+0x72/0x220
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7fcb4f5f5a49
> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 73 01 c3 48 8b 0d 0f b4 2c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffc73e340b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> RAX: ffffffffffffffda RBX: 00005599992bb850 RCX: 00007fcb4f5f5a49
> RDX: 0000000000000000 RSI: 00007fcb4f2e11c5 RDI: 0000000000000010
> RBP: 00007fcb4f2e11c5 R08: 0000000000000000 R09: 00005599992bb850
> R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000559999298f40 R14: 0000000000020000 R15: 00005599992bb850
> 
> Allocated by task 479:
>  __kasan_kmalloc.constprop.8+0xa0/0xd0
>  krealloc+0xa0/0xc0
>  0xffffffffc0cc0075
>  dmi_decode_table+0xf6/0x140
>  dmi_walk+0x46/0x70
>  0xffffffffc0cc0109
>  do_one_initcall+0xbd/0x3fd
>  do_init_module+0xe3/0x341
>  load_module+0x2fc5/0x3ad0
>  __do_sys_finit_module+0x192/0x1c0
>  do_syscall_64+0x72/0x220
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 479:
>  __kasan_slab_free+0x111/0x150
>  kfree+0xf5/0x350
>  0xffffffffc0cc01d4
>  do_one_initcall+0xbd/0x3fd
>  do_init_module+0xe3/0x341
>  load_module+0x2fc5/0x3ad0
>  __do_sys_finit_module+0x192/0x1c0
>  do_syscall_64+0x72/0x220
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff88840c2bc1a8
>  which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 0 bytes inside of
>  2048-byte region [ffff88840c2bc1a8, ffff88840c2bc9a8)
> The buggy address belongs to the page:
> page:ffffea001030ae00 count:1 mapcount:0 mapping:ffff8884204113c0 index:0x0
> compound_mapcount: 0
> flags: 0x17ffffc0010200(slab|head)
> raw: 0017ffffc0010200 ffffea0010367608 ffffea000ea31808 ffff8884204113c0
> raw: 0000000000000000 00000000000d000d 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88840c2bc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88840c2bc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88840c2bc180: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
>                                   ^
>  ffff88840c2bc200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88840c2bc280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Link: http://lkml.kernel.org/r/1553106560.2080.5.camel@gmail.com
> 
> Reported-by: Tom Zanussi <tzanussi@gmail.com>
> Tested-by: Tom Zanussi <tzanussi@gmail.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  drivers/platform/x86/dell-smbios-base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-smbios-base.c
> index 0537d44d45a6..a74c0df25b15 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -625,6 +625,8 @@ static int __init dell_smbios_init(void)
>  
>  fail_platform_driver:
>  	kfree(da_tokens);
> +	da_tokens = NULL;
> +	da_num_tokens = 0;
>  	return ret;
>  }
>  
> -- 
> 2.20.1
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
