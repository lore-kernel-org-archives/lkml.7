Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13423C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B0F21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgwtrExs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfCTTaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:30:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37184 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfCTTaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:30:24 -0400
Received: by mail-io1-f68.google.com with SMTP id x7so3146236ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O47jytKo6cU2Ssg1y0Nw6l/eqfFPbpRZqiDOJhf72Qs=;
        b=FgwtrExsTVLLI2sd1MrYoHw/Qbi6CiBpK/9foPvDxexsezk9AuMt+R33F93wtytSLK
         V6uDqP9smGAtyQMTvw/SjHP7B6dI76us4kACgXuqdgSjF+VQAinOFHZzA4ivsWiOl2MY
         0Mcz+lfcBaZBhuDg39XHKaR9gIOMa4VJx454Ewyyh7RSNEWZyGSggZrNFjt3VSG9vagA
         qJO/r5vdHLAGyzSrX1gq8RJG4m/gVzO4G742/XVA2YNO+mI/X5K8KrIJK/AxE166GyOc
         Ty7viAk3fqx2pAsX3ozx2LDCHCfZXw5K/QrH7CFWkZL7NrOz4ictk+AWbV0mJcPKifT8
         H5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O47jytKo6cU2Ssg1y0Nw6l/eqfFPbpRZqiDOJhf72Qs=;
        b=E2ac+I1WaiHeY0m/q8ACCCZxqxHGqLnO+EADvTxCYayZ4In6axCZAW51Q6NYYR5U5o
         y/cqKt+k1+Vue6ffl8ZdgqHjBbO/BrO4ikIEBasL7pAZJWBTW07hbnSrtuD7C14kttYo
         l63g3soGhCew4PogctWXGsBv2ZvTiIuiOSrnQ7VFsnO3WG0U4/507xi+dib3fv0MqS0E
         ifyO63+SFUXP9xOrjf7ANLTkBrgOCRyhiHzBE5AbKhbKeEGZf8jGpygBf9BmdMHD+7xF
         oRXL/hc/3/mBQH9Ptb96hMs9cK/bLG98R1BIv882ptHai2YSmvxJE93BrKUBsPSIckwc
         ki4w==
X-Gm-Message-State: APjAAAX8UCHRHgq8P1NCvNjSvInjMaOSHLjMznjjlsxR+Jj39B8G9QUh
        7z0dMJe1rua1X2WU5DmK1qb1AzSd
X-Google-Smtp-Source: APXvYqxdOW/kSnj5RcYJz0rdioFR44xFgd3Ry114eokpgXY9IxW7d4s2iwud+cAwv7D7wkLsEO30/g==
X-Received: by 2002:a5e:9b0b:: with SMTP id j11mr6427337iok.65.1553110223665;
        Wed, 20 Mar 2019 12:30:23 -0700 (PDT)
Received: from tzanussi-mobl ([2601:246:0:7004:f556:710b:1938:a19f])
        by smtp.googlemail.com with ESMTPSA id w5sm628279itd.28.2019.03.20.12.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:30:23 -0700 (PDT)
Message-ID: <1553110221.2034.1.camel@gmail.com>
Subject: Re: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 14:30:21 -0500
In-Reply-To: <20190320151353.1a223c0e@gandalf.local.home>
References: <1553106560.2080.5.camel@gmail.com>
         <20190320144146.08ecd5e4@gandalf.local.home>
         <1553108749.2079.1.camel@gmail.com>
         <20190320151353.1a223c0e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 15:13 -0400, Steven Rostedt wrote:
> On Wed, 20 Mar 2019 14:05:49 -0500
> Tom Zanussi <tzanussi@gmail.com> wrote:
> 
> > On Wed, 2019-03-20 at 14:41 -0400, Steven Rostedt wrote:
> > > On Wed, 20 Mar 2019 13:29:20 -0500
> > > Tom Zanussi <tzanussi@gmail.com> wrote:
> > >   
> > > > Hi,
> > > > 
> > > > While looking into an unrelated problem, I hit this KASAN use-
> > > > after-
> > > > free warning, so thought I'd let you know.
> > > > 
> > > > I have no idea how to fix it, but let me know if you need more
> > > > info.
> > > >   
> > > 
> > > Could you run with debug in the kernel command line, and see if
> > > you
> > > hit
> > > any failed messages from the dell_smbios_init() call?
> > >   
> > 
> > Not much, but this looks relevant:
> > 
> > [   26.783749] dell_smbios: No SMBIOS backends available (wmi: -19,
> > smm: -19)
> > [   26.963648] dell_smbios: No dell-smbios drivers are loaded
> > 
> 
> And does this fix you problem?
> 
> -- Steve
> 
> diff --git a/drivers/platform/x86/dell-smbios-base.c
> b/drivers/platform/x86/dell-smbios-base.c
> index 9dc282ed5a9e..c3825c674522 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -619,6 +619,7 @@ static int __init dell_smbios_init(void)
>  
>  fail_platform_driver:
>  	kfree(da_tokens);
> +	da_num_tokens = 0;
>  	return ret;
>  }
>  


Unfortunately, no.

[   26.125995] dell_smbios: No SMBIOS backends available (wmi: -19, smm: -19)
[   26.232716] systemd-journald[407]: Successfully sent stream file descriptor to service manager.
[   26.242860] dell_smbios: No dell-smbios drivers are loaded
[   26.243142] ==================================================================
[   26.243241] BUG: KASAN: use-after-free in dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   26.243254] Read of size 2 at addr ffff8883bdf941a8 by task systemd-udevd/458

[   26.243277] CPU: 1 PID: 458 Comm: systemd-udevd Not tainted 5.1.0-rc1+ #10
[   26.243283] Hardware name: Dell Inc. XPS 13 9360/02PG84, BIOS 2.3.1 10/03/2017
[   26.243288] Call Trace:
[   26.243303]  dump_stack+0x7c/0xbb
[   26.243317]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   26.243327]  print_address_description+0xc7/0x280
[   26.243339]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   26.243350]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   26.243359]  kasan_report+0x14e/0x192
[   26.243379]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   26.243399]  dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   26.243421]  kbd_led_init+0x2e7/0x473 [dell_laptop]
[   26.243440]  ? dmi_matched+0x2a/0x2a [dell_laptop]
[   26.243451]  ? get_device_parent.isra.28+0x2a0/0x2a0
[   26.243466]  ? lockdep_init_map+0x98/0x2c0
[   26.243494]  ? platform_device_add+0x1b5/0x3a0
[   26.243525]  dell_init+0x4ad/0xb63 [dell_laptop]
[   26.243542]  ? kbd_led_init+0x473/0x473 [dell_laptop]
[   26.243563]  ? ___slab_alloc+0x61f/0x700
[   26.243572]  ? ___slab_alloc+0x61f/0x700
[   26.243594]  ? preempt_count_sub+0x15/0x100
[   26.243616]  ? kbd_led_init+0x473/0x473 [dell_laptop]
[   26.243626]  do_one_initcall+0xbd/0x3fd
[   26.243638]  ? perf_trace_initcall_level+0x280/0x280
[   26.243650]  ? kasan_unpoison_shadow+0x30/0x40
[   26.243662]  ? __kasan_kmalloc.constprop.8+0xa0/0xd0
[   26.243681]  ? kmem_cache_alloc_trace+0x163/0x390
[   26.243691]  ? kasan_unpoison_shadow+0x30/0x40
[   26.243716]  do_init_module+0xe3/0x341
[   26.243736]  load_module+0x2fc5/0x3ad0
[   26.243824]  ? layout_and_allocate+0x1170/0x1170
[   26.243837]  ? vfs_read+0xd4/0x1b0
[   26.243855]  ? kernel_read+0x74/0xa0
[   26.243877]  ? kernel_read_file+0x148/0x320
[   26.243917]  ? seccomp_notify_release+0x110/0x110
[   26.243958]  ? __do_sys_finit_module+0x192/0x1c0
[   26.243964]  __do_sys_finit_module+0x192/0x1c0
[   26.243975]  ? __ia32_sys_init_module+0x40/0x40
[   26.244000]  ? syscall_trace_enter+0x184/0x5e0
[   26.244046]  ? mark_held_locks+0x1a/0x90
[   26.244068]  do_syscall_64+0x72/0x220
[   26.244083]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   26.244091] RIP: 0033:0x7f7ceda3aa49
[   26.244100] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f b4 2c 00 f7 d8 64 89 01 48
[   26.244105] RSP: 002b:00007ffe6ca1cbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   26.244114] RAX: ffffffffffffffda RBX: 00005635100838f0 RCX: 00007f7ceda3aa49
[   26.244121] RDX: 0000000000000000 RSI: 00007f7ced7261c5 RDI: 0000000000000010
[   26.244127] RBP: 00007f7ced7261c5 R08: 0000000000000000 R09: 00005635100838f0
[   26.244133] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
[   26.244139] R13: 0000563510089e90 R14: 0000000000020000 R15: 00005635100838f0

[   26.244193] Allocated by task 458:
[   26.244206]  __kasan_kmalloc.constprop.8+0xa0/0xd0
[   26.244214]  krealloc+0xa0/0xc0
[   26.244220]  0xffffffffc0d60075
[   26.244228]  dmi_decode_table+0xf6/0x140
[   26.244235]  dmi_walk+0x46/0x70
[   26.244241]  0xffffffffc0d60109
[   26.244248]  do_one_initcall+0xbd/0x3fd
[   26.244255]  do_init_module+0xe3/0x341
[   26.244261]  load_module+0x2fc5/0x3ad0
[   26.244269]  __do_sys_finit_module+0x192/0x1c0
[   26.244276]  do_syscall_64+0x72/0x220
[   26.244283]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   26.244297] Freed by task 458:
[   26.244309]  __kasan_slab_free+0x111/0x150
[   26.244316]  kfree+0xf5/0x350
[   26.244323]  0xffffffffc0d601d4
[   26.244330]  do_one_initcall+0xbd/0x3fd
[   26.244337]  do_init_module+0xe3/0x341
[   26.244344]  load_module+0x2fc5/0x3ad0
[   26.244352]  __do_sys_finit_module+0x192/0x1c0
[   26.244358]  do_syscall_64+0x72/0x220
[   26.244366]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   26.244381] The buggy address belongs to the object at ffff8883bdf941a8
                which belongs to the cache kmalloc-2k of size 2048
[   26.244393] The buggy address is located 0 bytes inside of
                2048-byte region [ffff8883bdf941a8, ffff8883bdf949a8)
[   26.244402] The buggy address belongs to the page:
[   26.244413] page:ffffea000ef7e400 count:1 mapcount:0 mapping:ffff88841c0113c0 index:0xffff8883bdf90968 compound_mapcount: 0
[   26.244423] flags: 0x17ffffc0010200(slab|head)
[   26.244433] raw: 0017ffffc0010200 ffffea000eff8208 ffff88841c003200 ffff88841c0113c0
[   26.244442] raw: ffff8883bdf90968 00000000000d0009 00000001ffffffff 0000000000000000
[   26.244447] page dumped because: kasan: bad access detected

[   26.244460] Memory state around the buggy address:
[   26.244472]  ffff8883bdf94080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   26.244483]  ffff8883bdf94100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   26.244494] >ffff8883bdf94180: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
[   26.244504]                                   ^
[   26.244515]  ffff8883bdf94200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.244526]  ffff8883bdf94280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.244535] ==================================================================

