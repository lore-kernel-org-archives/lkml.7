Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624DAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B522133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="OWv+nKk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDDBbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:31:43 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:30470 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDDBbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1554341501; x=1585877501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/24RT5LRmDrENVxp/k7dElOqjFNm3+v4+15IbShUobU=;
  b=OWv+nKk0KsOw34AcnXcptC5MYwRWU3KP5JgojLHzzH5qBU1/LtZnh2xj
   X7ttPrDDgZTIaaGCFx8MY306T+x22lbjt8DUo8LMhTBwzLfEaxrRTIu1/
   2go6y3Xs+k6K0s8cb9zouQwteqDsmmx6JFFDWBRWGBUoK3aWWG1R/OSjo
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ElAAB1XaVchyeV50NlGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBZYJoEYEDJwqMf4p3gVKJOIl0hSiBZw4BASMJAoQ+AoV?=
 =?us-ascii?q?FIjgSAQEDAQEJAQMCAQECEAEBARUJCCkjDII6IhxNawEBAQEBASMCDWMBAQE?=
 =?us-ascii?q?DARJnDAQCAQgRBAEBAS4hLggCBAENBQgagwABgV0DDQgPoB49Am+BAYkHAQE?=
 =?us-ascii?q?Bgh6EMQGDVQ2CH4EwizOCFoERgxI+ghqBdwESAQiFeAOMXIRyTpMRNgcCh36?=
 =?us-ascii?q?INoM8IoIFXYkPiFYtiklVghaDZCCBQowNAgQCBAUCFYFkIGdxcIM8CQqCAAM?=
 =?us-ascii?q?OCRSITIU/QAExAQEBAYEkjFWBHwGBHgEB?=
X-IPAS-Result: =?us-ascii?q?A2ElAAB1XaVchyeV50NlGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?QGBZYJoEYEDJwqMf4p3gVKJOIl0hSiBZw4BASMJAoQ+AoVFIjgSAQEDAQEJA?=
 =?us-ascii?q?QMCAQECEAEBARUJCCkjDII6IhxNawEBAQEBASMCDWMBAQEDARJnDAQCAQgRB?=
 =?us-ascii?q?AEBAS4hLggCBAENBQgagwABgV0DDQgPoB49Am+BAYkHAQEBgh6EMQGDVQ2CH?=
 =?us-ascii?q?4EwizOCFoERgxI+ghqBdwESAQiFeAOMXIRyTpMRNgcCh36INoM8IoIFXYkPi?=
 =?us-ascii?q?FYtiklVghaDZCCBQowNAgQCBAUCFYFkIGdxcIM8CQqCAAMOCRSITIU/QAExA?=
 =?us-ascii?q?QEBAYEkjFWBHwGBHgEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2019 20:31:40 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x341N8kY039720;
        Wed, 3 Apr 2019 21:31:41 -0400
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com [143.166.148.206])
        by mx0b-00154901.pphosted.com with ESMTP id 2rn4km9khq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 21:31:41 -0400
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.60,306,1549951200"; 
   d="scan'208";a="1274989211"
From:   <Mario.Limonciello@dell.com>
To:     <dvhart@infradead.org>, <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <andy@infradead.org>,
        <pali.rohar@gmail.com>, <tzanussi@gmail.com>
Subject: RE: [PATCH] platform/x86: dell-smbios-base: Fix use after free on
 failure of dell_smbios_init()
Thread-Topic: [PATCH] platform/x86: dell-smbios-base: Fix use after free on
 failure of dell_smbios_init()
Thread-Index: AQHU6loLujzInO04HUaxh4TKZKx/QqYrNzFA
Date:   Thu, 4 Apr 2019 01:31:38 +0000
Message-ID: <4a66c6e456df43f2b374ce5a72b5f957@ausx13mpc120.AMER.DELL.COM>
References: <20190403152018.77843868@gandalf.local.home>
 <20190403201545.GA39081@wrath>
In-Reply-To: <20190403201545.GA39081@wrath>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.234]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Darren Hart <dvhart@infradead.org>
> Sent: Wednesday, April 3, 2019 3:16 PM
> To: Steven Rostedt; Limonciello, Mario
> Cc: LKML; platform-driver-x86@vger.kernel.org; Andy Shevchenko; Pali Roh=
=E1r; Tom
> Zanussi
> Subject: Re: [PATCH] platform/x86: dell-smbios-base: Fix use after free o=
n failure of
> dell_smbios_init()
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, Apr 03, 2019 at 03:20:18PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >
> > If da_tokens are allocated, but dell_smbios_init() eventually fails, it=
 will
> > free the da_tokens but it does not reset the da_num_tokens number. This
> > leads to the possibility of a use after free in dell_smbios_find_token(=
).
> > As da_tokens is not NULL and da_num_tokens is set to something other th=
an 0.
> >
> > By reseting the da_num_tokens to zero, and da_tokens to NULL after it i=
s
> > freed, then access into the other functions that reference them will no=
t
> > read freed memory.
>=20
> Upon closer inspections this appears to be a race more than an access
> issue.  Even with this patch, there is still the space between kfree()
> and da_num_tokens =3D 0. This could be addressed by setting da_num_tokens
> to 0 prior to the call to kfree().
>=20
> That said, the bigger issue here seems to be the ability to use the
> dell_smbios_find_token() call before the module_init() has completed
> successfully.
>=20
> Mario, care to weigh in?
>=20

As I can tell as soon as da_num_tokens is set to 0 that function should be =
safe to call
though even if module_init wasn't finished yet.

> >
> > This was caught by a KASAN report:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: use-after-free in dell_smbios_find_token+0x2e/0x80 [dell_sm=
bios]
> > Read of size 2 at addr ffff88840c2bc1a8 by task systemd-udevd/479
> >
> > CPU: 0 PID: 479 Comm: systemd-udevd Not tainted 5.1.0-rc1+ #9
> > Hardware name: Dell Inc. XPS 13 9360/02PG84, BIOS 2.3.1 10/03/2017
> > Call Trace:
> >  dump_stack+0x7c/0xbb
> >  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
> >  print_address_description+0xc7/0x280
> >  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
> >  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
> >  kasan_report+0x14e/0x192
> >  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
> >  dell_smbios_find_token+0x2e/0x80 [dell_smbios]
> >  kbd_led_init+0x2e7/0x473 [dell_laptop]
> >  ? dmi_matched+0x2a/0x2a [dell_laptop]
> >  ? get_device_parent.isra.28+0x2a0/0x2a0
> >  ? lockdep_init_map+0x98/0x2c0
> >  ? platform_device_add+0x1b5/0x3a0
> >  dell_init+0x4ad/0xb63 [dell_laptop]
> >  ? kbd_led_init+0x473/0x473 [dell_laptop]
> >  ? ___slab_alloc+0x61f/0x700
> >  ? ___slab_alloc+0x61f/0x700
> >  ? preempt_count_sub+0x15/0x100
> >  ? kbd_led_init+0x473/0x473 [dell_laptop]
> >  do_one_initcall+0xbd/0x3fd
> >  ? perf_trace_initcall_level+0x280/0x280
> >  ? kasan_unpoison_shadow+0x30/0x40
> >  ? __kasan_kmalloc.constprop.8+0xa0/0xd0
> >  ? kmem_cache_alloc_trace+0x163/0x390
> >  ? kasan_unpoison_shadow+0x30/0x40
> >  do_init_module+0xe3/0x341
> >  load_module+0x2fc5/0x3ad0
> >  ? layout_and_allocate+0x1170/0x1170
> >  ? vfs_read+0xd4/0x1b0
> >  ? kernel_read+0x74/0xa0
> >  ? kernel_read_file+0x148/0x320
> >  ? seccomp_notify_release+0x110/0x110
> >  ? __do_sys_finit_module+0x192/0x1c0
> >  __do_sys_finit_module+0x192/0x1c0
> >  ? __ia32_sys_init_module+0x40/0x40
> >  ? syscall_trace_enter+0x184/0x5e0
> >  ? mark_held_locks+0x1a/0x90
> >  do_syscall_64+0x72/0x220
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x7fcb4f5f5a49
> > Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff
> > 73 01 c3 48 8b 0d 0f b4 2c 00 f7 d8 64 89 01 48
> > RSP: 002b:00007ffc73e340b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
> > RAX: ffffffffffffffda RBX: 00005599992bb850 RCX: 00007fcb4f5f5a49
> > RDX: 0000000000000000 RSI: 00007fcb4f2e11c5 RDI: 0000000000000010
> > RBP: 00007fcb4f2e11c5 R08: 0000000000000000 R09: 00005599992bb850
> > R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000559999298f40 R14: 0000000000020000 R15: 00005599992bb850
> >
> > Allocated by task 479:
> >  __kasan_kmalloc.constprop.8+0xa0/0xd0
> >  krealloc+0xa0/0xc0
> >  0xffffffffc0cc0075
> >  dmi_decode_table+0xf6/0x140
> >  dmi_walk+0x46/0x70
> >  0xffffffffc0cc0109
> >  do_one_initcall+0xbd/0x3fd
> >  do_init_module+0xe3/0x341
> >  load_module+0x2fc5/0x3ad0
> >  __do_sys_finit_module+0x192/0x1c0
> >  do_syscall_64+0x72/0x220
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > Freed by task 479:
> >  __kasan_slab_free+0x111/0x150
> >  kfree+0xf5/0x350
> >  0xffffffffc0cc01d4
> >  do_one_initcall+0xbd/0x3fd
> >  do_init_module+0xe3/0x341
> >  load_module+0x2fc5/0x3ad0
> >  __do_sys_finit_module+0x192/0x1c0
> >  do_syscall_64+0x72/0x220
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >
> > The buggy address belongs to the object at ffff88840c2bc1a8
> >  which belongs to the cache kmalloc-2k of size 2048
> > The buggy address is located 0 bytes inside of
> >  2048-byte region [ffff88840c2bc1a8, ffff88840c2bc9a8)
> > The buggy address belongs to the page:
> > page:ffffea001030ae00 count:1 mapcount:0 mapping:ffff8884204113c0
> index:0x0
> > compound_mapcount: 0
> > flags: 0x17ffffc0010200(slab|head)
> > raw: 0017ffffc0010200 ffffea0010367608 ffffea000ea31808 ffff8884204113c=
0
> > raw: 0000000000000000 00000000000d000d 00000001ffffffff
> 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff88840c2bc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff88840c2bc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >ffff88840c2bc180: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
> >                                   ^
> >  ffff88840c2bc200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff88840c2bc280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Link: http://lkml.kernel.org/r/1553106560.2080.5.camel@gmail.com
> >
> > Reported-by: Tom Zanussi <tzanussi@gmail.com>
> > Tested-by: Tom Zanussi <tzanussi@gmail.com>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  drivers/platform/x86/dell-smbios-base.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform=
/x86/dell-
> smbios-base.c
> > index 0537d44d45a6..a74c0df25b15 100644
> > --- a/drivers/platform/x86/dell-smbios-base.c
> > +++ b/drivers/platform/x86/dell-smbios-base.c
> > @@ -625,6 +625,8 @@ static int __init dell_smbios_init(void)
> >
> >  fail_platform_driver:
> >  	kfree(da_tokens);
> > +	da_tokens =3D NULL;
> > +	da_num_tokens =3D 0;
> >  	return ret;
> >  }
> >
> > --
> > 2.20.1
> >
> >
>=20
> --
> Darren Hart
> VMware Open Source Technology Center
