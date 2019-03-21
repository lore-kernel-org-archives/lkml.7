Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15475218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfCUWjI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:39:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:6129 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfCUWjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:39:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="157192301"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2019 15:39:07 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Mar 2019 15:39:06 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.82]) with mapi id 14.03.0415.000;
 Thu, 21 Mar 2019 15:39:06 -0700
From:   "Bowers, AndrewX" <andrewx.bowers@intel.com>
To:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH] fm10k: Fix a potential NULL pointer
 dereference
Thread-Topic: [Intel-wired-lan] [PATCH] fm10k: Fix a potential NULL pointer
 dereference
Thread-Index: AQHU3/Rkq442pz8lMUyKMEkK+mFVAqYWrcWQ
Date:   Thu, 21 Mar 2019 22:39:06 +0000
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D376AEC@ORSMSX104.amr.corp.intel.com>
References: <20190321144223.14392-1-yuehaibing@huawei.com>
In-Reply-To: <20190321144223.14392-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDFjNTNjZmUtY2M2MC00YzE0LWJiMzctMmY4NjdkNjU3OTMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRkJ5M3dQdGd1UkpLdFNuWGpZRTNqcVJIclB1Vit0OFdSWWZGaktuYkcwTVFVSjJGSVwvMXpIcmpwYVIydWN3NlcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces@osuosl.org] On
> Behalf Of Yue Haibing
> Sent: Thursday, March 21, 2019 7:42 AM
> To: davem@davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev@vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] fm10k: Fix a potential NULL pointer
> dereference
> 
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Syzkaller report this:
> 
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN PTI
> CPU: 0 PID: 4378 Comm: syz-executor.0 Tainted: G         C        5.0.0+ #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-
> 1ubuntu1 04/01/2014
> RIP: 0010:__lock_acquire+0x95b/0x3200 kernel/locking/lockdep.c:3573
> Code: 00 0f 85 28 1e 00 00 48 81 c4 08 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3
> 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 24 00 00
> 49 81 7d 00 e0 de 03 a6 41 bc 00 00
> RSP: 0018:ffff8881e3c07a40 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000080
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffff8881e3c07d98 R11: ffff8881c7f21f80 R12: 0000000000000001
> R13: 0000000000000080 R14: 0000000000000000 R15: 0000000000000001
> FS:  00007fce2252e700(0000) GS:ffff8881f2400000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fffc7eb0228 CR3: 00000001e5bea002 CR4: 00000000007606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  lock_acquire+0xff/0x2c0 kernel/locking/lockdep.c:4211
> __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>  __mutex_lock+0xdf/0x1050 kernel/locking/mutex.c:1072
>  drain_workqueue+0x24/0x3f0 kernel/workqueue.c:2934
>  destroy_workqueue+0x23/0x630 kernel/workqueue.c:4319
> __do_sys_delete_module kernel/module.c:1018 [inline]
> __se_sys_delete_module kernel/module.c:961 [inline]
>  __x64_sys_delete_module+0x30c/0x480 kernel/module.c:961
>  do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x462e99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6
> 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7
> c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fce2252dc58 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000b0
> RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
> RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fce2252e6bc
> R13: 00000000004bcca9 R14: 00000000006f6b48 R15: 00000000ffffffff
> 
> If alloc_workqueue fails, it should return -ENOMEM, otherwise may trigger
> this NULL pointer dereference while unloading drivers.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 0a38c17a21a0 ("fm10k: Remove create_workqueue")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


