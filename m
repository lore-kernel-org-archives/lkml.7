Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A639FC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773DF21721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbfGPKev convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:34:51 -0400
Received: from m9a0002g.houston.softwaregrp.com ([15.124.64.67]:50158 "EHLO
        m9a0002g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732081AbfGPKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:34:50 -0400
Received: FROM m9a0002g.houston.softwaregrp.com (15.121.0.191) BY m9a0002g.houston.softwaregrp.com WITH ESMTP;
 Tue, 16 Jul 2019 10:34:49 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 16 Jul 2019 10:30:17 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.124.72.13) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 16 Jul 2019 10:30:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtWv4bxbPByek5BHArgVOCxiCoKYox+xSqLUn/SQZUdZc33fWyCljHgAXeQwRRxFM30ggzHGm9GL4fe4hw3UFnTBpCemmeHQbUTYDlKAkIUx4gtl0AGUpAp1X4o04ayWLdAYQDnBehsAtdtW9RdGO+pVsJxcKer14ughx59pU329k9LM/BxM3AbgK3W14H86z98dFs1kVZq26yn3/x310WROMezR7joKI9rwBUebIkrc+PohRSqptZbQpsJ40SKvIox+02Al9YykXrDwroqaOFKD+j5+Do9vey77c5uhqGKHmwQI5m1d26kKeCUXvQnUYkfGXn/vrdAej1xDNbYr+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmQebN4IJL+xyMpPlM20V2y0XhtweywPn16eYPskVsU=;
 b=NQEuXTX4ksCBhIlq9h4HzlQOlPPW/5wMCC3If5oaoZ5J2F4G1Ci8rGFBED4OomfljaIMW1CA3HWcXBn8KUcZTIqhfKhT02SLYHycNqaOLYJkTNG4ITQbHnqmO1qZ7U8lS1Syz/aJoZbMt/IpG/si6XgNLMdL2VmrGTilrSyvUy4mwyfCR6c8u9aE++3b8XJ3LJ/payTFQqpfhgOjtb9CGErRUC95vcUZkpcqAUWh6Rd8RupCi6PosFufdJG7kZoga0DxfRKd3Fyd4G+61I3vxfRKVvR53FgTqac8LxtHMitn2yyYk8Lkwc4781U98/Nroj80W+Zx/hzk1UJzkGP6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from MN2PR18MB2846.namprd18.prod.outlook.com (20.179.21.147) by
 MN2PR18MB3039.namprd18.prod.outlook.com (20.179.83.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Tue, 16 Jul 2019 10:30:14 +0000
Received: from MN2PR18MB2846.namprd18.prod.outlook.com
 ([fe80::307c:8422:7d8c:8ac6]) by MN2PR18MB2846.namprd18.prod.outlook.com
 ([fe80::307c:8422:7d8c:8ac6%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 10:30:14 +0000
From:   Petr Tesarik <PTesarik@suse.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Laura Abbott" <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Raymund Will <rw@suse.com>
Subject: Re: [PATCH] s390: enable detection of kernel version from bzImage
Thread-Topic: [PATCH] s390: enable detection of kernel version from bzImage
Thread-Index: AQHVO1p2NdiEYNQpfUiSTDvrwXSeS6bNDCkA
Date:   Tue, 16 Jul 2019 10:30:14 +0000
Message-ID: <20190716123006.2d426ec8@ezekiel.suse.cz>
References: <your-ad-here.call-01563228330-ext-8076@work.hours>
        <patch.git-94e9726bbfe5.your-ad-here.call-01563228538-ext-5706@work.hours>
In-Reply-To: <patch.git-94e9726bbfe5.your-ad-here.call-01563228538-ext-5706@work.hours>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0382.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::34) To MN2PR18MB2846.namprd18.prod.outlook.com
 (2603:10b6:208:3e::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=PTesarik@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
x-originating-ip: [213.151.95.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c2c75df-6128-4ed3-d6f4-08d709d896c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3039;
x-ms-traffictypediagnostic: MN2PR18MB3039:
x-microsoft-antispam-prvs: <MN2PR18MB3039010D62B48E96A8D97C25A6CE0@MN2PR18MB3039.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(7736002)(52116002)(76176011)(316002)(186003)(66066001)(25786009)(102836004)(2906002)(386003)(6116002)(6506007)(54906003)(7416002)(3846002)(5660300002)(305945005)(446003)(66946007)(26005)(8676002)(11346002)(53936002)(6916009)(66476007)(486006)(9686003)(4326008)(229853002)(66446008)(50226002)(478600001)(81166006)(6246003)(1076003)(81156014)(8936002)(6486002)(256004)(66556008)(476003)(64756008)(14444005)(86362001)(71190400001)(6436002)(71200400001)(14454004)(68736007)(99286004)(107886003)(80792005)(6512007)(39210200001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR18MB3039;H:MN2PR18MB2846.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nNcnW5B18SYC5zjfgw3VdMqLxNpcbP8s1VSqz0MKEpHy2RLSKx84lKR8VdnxjcqqjhABxoM3t7rB33uC6mItIWenPmhYyi1xs+/8BqNgWpEfZQXrZ9GhA42QdmoegVC++mXbiop7NknlnRRGZp4R62hddt+ipWYwkR+buxeN5zKuL23z6E6SKJ2zUQOG1i1fmGYatbTGaS/zgRdR0DM8PlqmM7zmQC+qAS+ERx/T84cqN7FRnp28MZ/Fw2Kprwb+iRQet8S0T+y/waXx9zxAQ7GbX7jpsJCz/MCzPw80BFwQU4iNetLp7dlYnHFRJb3JBvOrrsetPhMdp0KAVyAtXPmHuCJNBre1jxJYQVU93rCOhUVv9NJoODnuTy+Yw832NPtLAEFDx2dIYd5KkvxqX4UXpGG1vHCXE7gjYZymMrs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0754DD86212944AAEE431760676B286@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c75df-6128-4ed3-d6f4-08d709d896c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 10:30:14.5798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTesarik@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3039
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 00:12:19 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> Extend "parmarea" to include an offset of the version string, which is
> stored as 8-byte big endian value.
> 
> To retrieve version string from bzImage reliably, one should check the
> presence of "S390EP" ascii string at 0x10008 (available since v3.2),
> then read the version string offset from 0x10428 (which has been 0
> since v3.2 up to now). The string is null terminated.
> 
> Could be retrieved with the following "file" command magic (requires
> file v5.34):
> 8 string \x02\x00\x00\x18\x60\x00\x00\x50\x02\x00\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40\x40\x40\x40\x40 Linux S390
> >0x10008       string          S390EP  
> >>0x10428      bequad          >0  
> >>>(0x10428.Q) string          >\0             \b, version %s  
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

This looks great! Much cleaner than the original approach.

Thank you,
Petr T

> ---
>  arch/s390/boot/Makefile       | 2 +-
>  arch/s390/boot/head.S         | 1 +
>  arch/s390/boot/version.c      | 6 ++++++
>  arch/s390/include/asm/setup.h | 4 +++-
>  4 files changed, 11 insertions(+), 2 deletions(-)
>  create mode 100644 arch/s390/boot/version.c
> 
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index 7cba96e7587b..4cf0bddb7d92 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -36,7 +36,7 @@ CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
>  
>  obj-y	:= head.o als.o startup.o mem_detect.o ipl_parm.o ipl_report.o
>  obj-y	+= string.o ebcdic.o sclp_early_core.o mem.o ipl_vmparm.o cmdline.o
> -obj-y	+= ctype.o text_dma.o
> +obj-y	+= version.o ctype.o text_dma.o
>  obj-$(CONFIG_PROTECTED_VIRTUALIZATION_GUEST)	+= uv.o
>  obj-$(CONFIG_RELOCATABLE)	+= machine_kexec_reloc.o
>  obj-$(CONFIG_RANDOMIZE_BASE)	+= kaslr.o
> diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
> index 028aab03a9e7..2087bed6e60f 100644
> --- a/arch/s390/boot/head.S
> +++ b/arch/s390/boot/head.S
> @@ -361,6 +361,7 @@ ENTRY(startup_kdump)
>  	.quad	0			# INITRD_SIZE
>  	.quad	0			# OLDMEM_BASE
>  	.quad	0			# OLDMEM_SIZE
> +	.quad	kernel_version		# points to kernel version string
>  
>  	.org	COMMAND_LINE
>  	.byte	"root=/dev/ram0 ro"
> diff --git a/arch/s390/boot/version.c b/arch/s390/boot/version.c
> new file mode 100644
> index 000000000000..ea5e49651931
> --- /dev/null
> +++ b/arch/s390/boot/version.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <generated/utsrelease.h>
> +#include <generated/compile.h>
> +
> +const char kernel_version[] = UTS_RELEASE
> +	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ") " UTS_VERSION;
> diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
> index 925889d360c1..e5d28a475f76 100644
> --- a/arch/s390/include/asm/setup.h
> +++ b/arch/s390/include/asm/setup.h
> @@ -54,6 +54,7 @@
>  #define INITRD_SIZE_OFFSET	0x10410
>  #define OLDMEM_BASE_OFFSET	0x10418
>  #define OLDMEM_SIZE_OFFSET	0x10420
> +#define KERNEL_VERSION_OFFSET	0x10428
>  #define COMMAND_LINE_OFFSET	0x10480
>  
>  #ifndef __ASSEMBLY__
> @@ -74,7 +75,8 @@ struct parmarea {
>  	unsigned long initrd_size;			/* 0x10410 */
>  	unsigned long oldmem_base;			/* 0x10418 */
>  	unsigned long oldmem_size;			/* 0x10420 */
> -	char pad1[0x10480 - 0x10428];			/* 0x10428 - 0x10480 */
> +	unsigned long kernel_version;			/* 0x10428 */
> +	char pad1[0x10480 - 0x10430];			/* 0x10430 - 0x10480 */
>  	char command_line[ARCH_COMMAND_LINE_SIZE];	/* 0x10480 */
>  };
>  

