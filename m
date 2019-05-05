Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E9C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D4E2087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 08:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DuOLbinf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfEEIAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 04:00:09 -0400
Received: from mail-eopbgr680084.outbound.protection.outlook.com ([40.107.68.84]:49025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbfEEIAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 04:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYIcg3gAeiSMk69nSVaENzzXgJzppd5kOQQX/ooBsBc=;
 b=DuOLbinfKFMLB+XkdGKSenPf6EGNxxS6uu3mwA6ksDC5LDrQ+Iqg0Dc5rxhTa3kUA+I6NiqwlMXuOFad5Q2vmQmq4akXv/W35UrFbk8EjC3H+JVFWLi28rPWkV0kGiByQUhZJxf2O2fSElb5lDFELi4ehJMrtds/sDhOAr1pKBc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5624.namprd05.prod.outlook.com (20.177.186.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 07:59:23 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::b057:917a:f098:6098%7]) with mapi id 15.20.1878.014; Sun, 5 May 2019
 07:59:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     kernel test robot <lkp@intel.com>
CC:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkp@01.org" <lkp@01.org>
Subject: Re: [x86/alternatives] 4fc19708b1: kernel_BUG_at_arch/x86/mm/init.c
Thread-Topic: [x86/alternatives] 4fc19708b1: kernel_BUG_at_arch/x86/mm/init.c
Thread-Index: AQHVAwtDiVWvU6qabEqE4lta8PZzLqZcKs8A
Date:   Sun, 5 May 2019 07:59:23 +0000
Message-ID: <0D4CC040-5546-4086-907A-EAB7EC36CC71@vmware.com>
References: <20190505062513.GH29809@shao2-debian>
In-Reply-To: <20190505062513.GH29809@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 791f6e6c-555d-4750-157f-08d6d12f964b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5624;
x-ms-traffictypediagnostic: BYAPR05MB5624:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR05MB5624F8F971B12D6324E79A47D0370@BYAPR05MB5624.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(4326008)(83716004)(25786009)(446003)(6246003)(71190400001)(71200400001)(76176011)(2616005)(476003)(53546011)(8676002)(81156014)(81166006)(86362001)(486006)(186003)(3846002)(6436002)(6306002)(66066001)(316002)(26005)(99286004)(5660300002)(6512007)(68736007)(11346002)(6486002)(8936002)(102836004)(6506007)(54906003)(229853002)(6916009)(66556008)(2906002)(966005)(33656002)(6116002)(478600001)(14454004)(45080400002)(5024004)(14444005)(256004)(66446008)(82746002)(53936002)(305945005)(7736002)(64756008)(66946007)(76116006)(7416002)(73956011)(66476007)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5624;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ho35EvWZsWNQjquhOXC0OYjZ9nEtma/DRSfdgS7NLeUtnPW2FYStzE8eHMCYNhKpx7PCtRGpj6OyKjyA+KM/Um3pUSS+26OwSjv8/82j4NSKC2d5Xi5Cgo1ChfXiaRLOAleU5Is5QpXDO+paCLgh7U/PIrHQVVp4w9AxrBx1bqIBHCj0T918A5utiRF4+91xruef/EkwKoqnwzoWpbHSIntuiS6KjZedTRtEZfRL1c85fH2eg0wlk57mbrc25XjRA2KdkbTa8wvRWDe6rDaIkNdFDj19RupAVqrFMieagqp57ASM6d1lxhv3KJAN7vom7WuBn3+PrG4zYNqCmIAVXsjmrWkX9Wudb/lUwdCRVU6dE9KSXKgyENwjlTMAwy4SRq2W8Ej+kjk4ehvuHWBBY9CAfsH1zaFgSO8DBa1/0vk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F252219D242151498FFB8BD52BF4D115@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791f6e6c-555d-4750-157f-08d6d12f964b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 07:59:23.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 4, 2019, at 11:25 PM, kernel test robot <lkp@intel.com> wrote:
>=20
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: 4fc19708b165c1c152fa1f12f6600e66184b7786 ("x86/alternatives: Init=
ialize temporary mm for patching")
> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fcgit%2Flinux%2Fkernel%2Fgit%2Fnext%2Flinux-next.git&amp;data=3D=
02%7C01%7Cnamit%40vmware.com%7C42837854d9554a1bfa4608d6d122639e%7Cb39138ca3=
cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C636926342992631859&amp;sdata=3D41sYsMGJlg=
0w9t2EP4v9GcxopFVgicOmHfcZXIf91As%3D&amp;reserved=3D0 master
>=20
> in testcase: trinity
> with following parameters:
>=20
> 	runtime: 300s
>=20
> test-description: Trinity is a linux system call fuzz tester.
> test-url: https://nam04.safelinks.protection.outlook.com/?url=3Dhttp%3A%2=
F%2Fcodemonkey.org.uk%2Fprojects%2Ftrinity%2F&amp;data=3D02%7C01%7Cnamit%40=
vmware.com%7C42837854d9554a1bfa4608d6d122639e%7Cb39138ca3cee4b4aa4d6cd83d9d=
d62f0%7C0%7C0%7C636926342992631859&amp;sdata=3D7ol%2Fq6mrou4H1XuwIaR2T3VOC4=
dUdyGY3Y%2BtqMUjBZk%3D&amp;reserved=3D0
>=20
>=20
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 2G
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
> +------------------------------------------+------------+------------+
> |                                          | 13585fa066 | 4fc19708b1 |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 4          | 0          |
> | boot_failures                            | 0          | 4          |
> | kernel_BUG_at_arch/x86/mm/init.c         | 0          | 4          |
> | invalid_opcode:#[##]                     | 0          | 4          |
> | EIP:poking_init                          | 0          | 4          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 4          |
> +------------------------------------------+------------+------------+
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> [    5.118979] kernel BUG at arch/x86/mm/init.c:716!
> [    5.119018] invalid opcode: 0000 [#1] SMP
> [    5.122979] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.1.0-rc7-00022-=
g4fc1970 #1
> [    5.122979] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
> [    5.122979] EIP: poking_init+0x21/0xb8
> [    5.122979] Code: db 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 53 52 8b 1d f8 2=
e 5e db 31 eb 81 f3 e3 02 89 18 e8 43 a2 1d ff a3 0c a1 56 db 85 c0 75 02 <=
0f> 0b d1 c3 c7 05 08 a1 56 db 00 00 00 40 b8 28 1b 48 db e8 82 a9
> [    5.122979] EAX: 00000000 EBX: 239c2c8f ECX: da865bad EDX: 00000007
> [    5.122979] ESI: 000003ca EDI: 00000000 EBP: db5bff78 ESP: db5bff70
> [    5.122979] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210=
246
> [    5.122979] CR0: 80050033 CR2: ffffffff CR3: 1b766000 CR4: 000006b0
> [    5.122979] Call Trace:
> [    5.122979]  start_kernel+0x447/0x47b
> [    5.122979]  i386_start_kernel+0xd6/0xee
> [    5.122979]  startup_32_smp+0x15f/0x170
> [    5.122979] Modules linked in:
> [    5.123041] random: get_random_bytes called from print_oops_end_marker=
+0x4f/0x60 with crng_init=3D0
> [    5.127013] ---[ end trace 790e10dcf838c933 ]---
>=20
>=20
> To reproduce:
>=20
>        # build kernel
> 	cd linux
> 	cp config-5.1.0-rc7-00022-g4fc1970 .config
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Di386 olddefconfig
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Di386 prepare
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Di386 modules_prepare
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Di386 SHELL=3D/bin/bash
> 	make HOSTCC=3Dgcc-7 CC=3Dgcc-7 ARCH=3Di386 bzImage
>=20
>=20
>        git clone https://nam04.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Fgithub.com%2Fintel%2Flkp-tests.git&amp;data=3D02%7C01%7Cnamit%4=
0vmware.com%7C42837854d9554a1bfa4608d6d122639e%7Cb39138ca3cee4b4aa4d6cd83d9=
dd62f0%7C0%7C0%7C636926342992641853&amp;sdata=3DzTmhr%2FTk12aeE5PPUF6enou4b=
4Ubqy7JfmO%2FHodsixI%3D&amp;reserved=3D0
>        cd lkp-tests
>        bin/lkp qemu -k <bzImage> job-script # job-script is attached in t=
his email
>=20
>=20
>=20
> Thanks,
> lkp
>=20
> <config-5.1.0-rc7-00022-g4fc1970><job-script.txt><dmesg.xz>

PGD cache should be initialized earlier. I will send a fix shortly.

