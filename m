Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B44E20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="p6Pe87Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCHTCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 14:02:41 -0500
Received: from mail-eopbgr750103.outbound.protection.outlook.com ([40.107.75.103]:58488
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726254AbfCHTCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 14:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36q6+OgAXWFp3UnEvWYPZYgaJmxXZYacyAh4xGUdfVY=;
 b=p6Pe87GgR0eHFl47ZgcYVGvRzq/WfN6NZDwa+nP2Tx/R5BjLSbxR607PtyxA+IlJ6sewqACgdt9rRkgr4pVt+kAi/Vb7Gre+FqHM14uFqg0qCABqKInvvk5WV/xnydRAu2uotvoDZ5K5YDmu9oUM/uI3AAe69aCHUS0zD2aSDS8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1261.namprd22.prod.outlook.com (10.174.162.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 19:02:34 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 19:02:34 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] MIPS: Ensure ELF appended dtb is relocated
Thread-Topic: [PATCH 1/1] MIPS: Ensure ELF appended dtb is relocated
Thread-Index: AQHU1a7JcwPZK+U8+0uc89l/lTqXu6YCF5qA
Date:   Fri, 8 Mar 2019 19:02:34 +0000
Message-ID: <20190308190233.jqgkw26dpryz5izy@pburton-laptop>
References: <20190308125851.31806-1-yasha.che3@gmail.com>
 <20190308125851.31806-2-yasha.che3@gmail.com>
In-Reply-To: <20190308125851.31806-2-yasha.che3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd79b40b-3f47-40e3-5e70-08d6a3f89f95
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1261;
x-ms-traffictypediagnostic: MWHPR2201MB1261:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1261;23:2igNi5ArtuH4NcSrGwgfxPrIcZtKxXQDH9d44yf?=
 =?us-ascii?Q?7jj9Nqa6WDzm/VjzjHnEKplkoespJ81QrzUz8yt8cyKimvpmNi/NNViX5d/X?=
 =?us-ascii?Q?qCPzC62vBD6rxxl7iFPdzFcgT5wLHbGgzdDDc6HGbflp1ZVnpqfVNfh+a0ep?=
 =?us-ascii?Q?KycANs0XBpsrEkIAon3sLXKL+IBgAJTmBp+99BHvBFYVG1HWRogUkVVL1Zpa?=
 =?us-ascii?Q?kJmEkpMaE62oY5Fmzzb+grMOwzwjC/STdAR3GlSqA9yQvjfoQMrfxb6FiYw5?=
 =?us-ascii?Q?LBi9eajDuuBtWrVEwQvMfEcBGPqpklGwhlMAfChwMQSvbxJOyVl60UFHmdtZ?=
 =?us-ascii?Q?fhVEneT4s7ImBaP61z1HERIRYlax7vlvsjLmIhLtc8G7SWfTjJnZfSpmTKCZ?=
 =?us-ascii?Q?bFtCx0Quo/gYKGmpewrpSpE+u3V3n1r5tqVd8m90khLBRV3Tr2gRUOI/6jZK?=
 =?us-ascii?Q?A+jSYdNrrpxuhWIravrOaiIKsvDh84OzLFLy4RnRDMBNAP8VsjcDB+dTgRAl?=
 =?us-ascii?Q?rIBn/JU7sM07pUieR3QbNNTt6Sns1V+YPuNHeQf0SX8dS4WHqLklYLimXslt?=
 =?us-ascii?Q?Dv6J3Rug9jIu+BuoF3/reKa9yQqsmLxKOHNY1qhzdgbd0iVS4FeN7Wf+VsSB?=
 =?us-ascii?Q?nmGIqEwQmTEZ0HKqF0cQEGETktbrsrkx9zj8q3Pn+CBzBYlKR4hR5hi6WMtX?=
 =?us-ascii?Q?0a9XADbMhVMuLmnWQHOEje9ayYJP56ZNaDsftp/PC7hVb/Uv8pbyjgaXg/RY?=
 =?us-ascii?Q?kFRfps3CgQz3JoI4ACPnMwfn0n44x2ecW6GBKfxF2FQsgvJk43YAmXSnB3MF?=
 =?us-ascii?Q?i+2UAqOdjJO6vuLUtoYK9q67j/Arq9c2Ns+kgiAukPFS9Z4tpeqY786aD3Q2?=
 =?us-ascii?Q?6wLOo9IN7XT6fD6n0EFVywScPD3PMUBf6J4u5z1NPfvPDyDolC+jDv0uqk+l?=
 =?us-ascii?Q?uWT+T4QcrRwJ6j9egG8JpM/kNtT1PbK8pm6sF5zEmkNyPrdkmUhPtlJn7gFW?=
 =?us-ascii?Q?LQ7pquIZ3BvS/IQsd6WzXnawhmCUZWR2s0ivQoPhKUGx8SDTZ4NEiiPtOUkB?=
 =?us-ascii?Q?4dP0IpBqK7NI1qso4UoZBsQjIxcUgbTO8eYmWkcycSM8sfm3RhDidc5e1wGb?=
 =?us-ascii?Q?rqP3UjHFRXF0ouEYr7NMjnAYZj7dpontoCi+FJAhQsPyn7f7tCxqUnxA9eUa?=
 =?us-ascii?Q?7eS+kMqsi9psKjGNdaxpgLakfWzRaQR6MLwMAgPuna3oithH/LvQWHgKqzv0?=
 =?us-ascii?Q?YiRdMtp8z/ksv6NC+pnCLcg2AKzOwqLFffHuybhs/9qscQNISHXdQT73l8Hs?=
 =?us-ascii?Q?NPw=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB126135FED8A46DD13B643CD1C14D0@MWHPR2201MB1261.namprd22.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39850400004)(346002)(366004)(376002)(136003)(189003)(199004)(97736004)(53936002)(25786009)(256004)(305945005)(478600001)(6916009)(4326008)(3846002)(106356001)(316002)(6436002)(7736002)(58126008)(54906003)(1076003)(6512007)(5660300002)(9686003)(6486002)(6246003)(71200400001)(33716001)(71190400001)(386003)(102836004)(6506007)(8676002)(68736007)(6116002)(81166006)(81156014)(229853002)(14454004)(186003)(44832011)(2906002)(486006)(42882007)(476003)(11346002)(446003)(99286004)(105586002)(66066001)(76176011)(26005)(52116002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1261;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6jlEY3BoyQjVi+3zkb00TFsf5U4vLox946U9XlpnfmMFQrDKajU4rTSgkdhI1ABquc0Zfv/xG73atkaAxPN5bGphLdMRmkXXNtIMWnIFvmP0Isbye2NAmskpSRj4pWuVDDN9MpKpee73Qbyoet61TB4bT+y3cGd1h0VkMTQ4kDGlXHova3TdBv+N/my7oprF/7V6I8VE4t3LHrLNQ8wQtqzt6KFJyQho04dwfBHcplSmKHrB2KhBKobTxxjsdIQHDACh/YF/K2zmIFarErIN+8v+53rKits5tYDEzdJcx15HYxlU2pS6L63DnhuhN7zcdrr8dg7BIMpGX03S2LKx0HBcbEY/cpK69138NhNUaR5XAKM5KWoDZmemeGJ0+0a6cnrFzplaL+Xy3eVlRFMWHQXak7GVZ7oSqrzN4rnHpWw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32BDE4A9540F164C9D2A62B4704F4D03@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd79b40b-3f47-40e3-5e70-08d6a3f89f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 19:02:34.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yasha,

On Fri, Mar 08, 2019 at 02:58:51PM +0200, Yasha Cherikovsky wrote:
> This fixes booting with the combination of CONFIG_RELOCATABLE=3Dy
> and CONFIG_MIPS_ELF_APPENDED_DTB=3Dy.
>=20
> Sections that appear after the relocation table are not relocated
> on system boot (except .bss, which has special handling).
>=20
> With CONFIG_MIPS_ELF_APPENDED_DTB, the dtb is part of the
> vmlinux ELF, so it must be relocated together with everything else.

Do you have any ideas how CONFIG_RELOCATABLE interacts with
CONFIG_MIPS_RAW_APPENDED_DTB? I'm wondering whether we should move both
variants of appended DTB to before .data.reloc, but haven't yet thought
it through.

Thanks,
    Paul

> Fixes: 069fd766271d ("MIPS: Reserve space for relocation table")
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/mips/kernel/vmlinux.lds.S | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.ld=
s.S
> index cb7e9ed7a453..33ee0d18fb0a 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -140,6 +140,13 @@ SECTIONS
>  	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
>  #endif
> =20
> +#ifdef CONFIG_MIPS_ELF_APPENDED_DTB
> +	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
> +		*(.appended_dtb)
> +		KEEP(*(.appended_dtb))
> +	}
> +#endif
> +
>  #ifdef CONFIG_RELOCATABLE
>  	. =3D ALIGN(4);
> =20
> @@ -164,11 +171,6 @@ SECTIONS
>  	__appended_dtb =3D .;
>  	/* leave space for appended DTB */
>  	. +=3D 0x100000;
> -#elif defined(CONFIG_MIPS_ELF_APPENDED_DTB)
> -	.appended_dtb : AT(ADDR(.appended_dtb) - LOAD_OFFSET) {
> -		*(.appended_dtb)
> -		KEEP(*(.appended_dtb))
> -	}
>  #endif
>  	/*
>  	 * Align to 64K in attempt to eliminate holes before the
> --=20
> 2.21.0
>=20
