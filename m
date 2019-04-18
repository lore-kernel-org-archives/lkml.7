Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF1F2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ana1Xhhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbfDRV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:27:13 -0400
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:3589
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728264AbfDRV1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTkpgF6MsdgM/3ek6kB91g2L6guOHq+ZH/z9h01KWbc=;
 b=ana1Xhhzu7Hz0IFrEkCAwEkDkTQsgImcguCMCnydl+XhBbfTZnkqsKFlYTD3mC9abDEBGFaWFnoo0gzQy1z4Z4XyDP9M4yt/pydlX4TuEwl4JnjS8wLZRxQlmEe/mtasK7hjxzsj/Zf6pSDMY5Vkh9h26+ZvktF7WP1qoIVuTHg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1424.namprd22.prod.outlook.com (10.172.63.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 21:27:08 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 21:27:08 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 08/11] mips: Properly account for stack randomization
 and stack guard gap
Thread-Topic: [PATCH v3 08/11] mips: Properly account for stack randomization
 and stack guard gap
Thread-Index: AQHU9N7WOMS/C9RNx0iyqk626UOBSKZCcS8A
Date:   Thu, 18 Apr 2019 21:27:08 +0000
Message-ID: <20190418212701.dpymnwuki3g7rox2@pburton-laptop>
References: <20190417052247.17809-1-alex@ghiti.fr>
 <20190417052247.17809-9-alex@ghiti.fr>
In-Reply-To: <20190417052247.17809-9-alex@ghiti.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33f5353b-dda9-4910-9587-08d6c4449c56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1424;
x-ms-traffictypediagnostic: MWHPR2201MB1424:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR2201MB1424F170E35DAE843ADE1FEFC1260@MWHPR2201MB1424.namprd22.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(346002)(136003)(376002)(366004)(396003)(189003)(199004)(58126008)(97736004)(6246003)(8936002)(486006)(54906003)(8676002)(81156014)(7416002)(6116002)(25786009)(3846002)(81166006)(229853002)(33716001)(2906002)(6916009)(11346002)(316002)(66556008)(66476007)(73956011)(6486002)(446003)(52116002)(1076003)(6436002)(476003)(4326008)(44832011)(6506007)(5660300002)(386003)(42882007)(14454004)(26005)(76176011)(14444005)(256004)(99286004)(53936002)(9686003)(15650500001)(6306002)(6512007)(305945005)(186003)(71190400001)(71200400001)(7736002)(478600001)(966005)(102836004)(68736007)(66066001)(66446008)(64756008)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1424;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8f4+5nWoBkDj6d1MLlkvJBbL7HDwiQVIXpbaTMbUbalRzhboOrsRxZoUH949lssGtYMTSYy3jxy5+j1nM/rKWn4tVwzvbGdScU9RVhY8wbH6pY12EcqIYEe/gTCLQxzWEmMzWSuSGX0GaUU+cLuTuwXR0hsJCvKOaupWI0YjGxfS3zmOoL82DAhFZa/t778WMCols7AhxapTvBIIQTsLvgWrfQH16GSsxKmGHr4qgowyOKg9YUK66JY/8Yil7SsqzfembPwfLkmIT/BRxLxyK8yFRlhTiLaHNIiCnc1cOfGDWG2TWZt92W+a20PnZs/3W2xUGl3T5g9sEZ6kUUQiRfw7K2sggJJ/3JydxgDKBWStRA6Jqn0RcBkNUscy7D614xZHrygsPek1twK/Igwi/u8uXfVsDQ/VNP4h4M/c07o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7903A9C444F5B74FB67DD91CFCCC1456@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f5353b-dda9-4910-9587-08d6c4449c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 21:27:08.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1424
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Wed, Apr 17, 2019 at 01:22:44AM -0400, Alexandre Ghiti wrote:
> This commit takes care of stack randomization and stack guard gap when
> computing mmap base address and checks if the task asked for randomizatio=
n.
> This fixes the problem uncovered and not fixed for mips here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1429066.html
>=20
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

For patches 8-10:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks for improving this,

    Paul

> ---
>  arch/mips/mm/mmap.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 2f616ebeb7e0..3ff82c6f7e24 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -21,8 +21,9 @@ unsigned long shm_align_mask =3D PAGE_SIZE - 1;	/* Sane=
 caches */
>  EXPORT_SYMBOL(shm_align_mask);
> =20
>  /* gap between mmap and stack */
> -#define MIN_GAP (128*1024*1024UL)
> -#define MAX_GAP ((TASK_SIZE)/6*5)
> +#define MIN_GAP		(128*1024*1024UL)
> +#define MAX_GAP		((TASK_SIZE)/6*5)
> +#define STACK_RND_MASK	(0x7ff >> (PAGE_SHIFT - 12))
> =20
>  static int mmap_is_legacy(struct rlimit *rlim_stack)
>  {
> @@ -38,6 +39,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
>  static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_st=
ack)
>  {
>  	unsigned long gap =3D rlim_stack->rlim_cur;
> +	unsigned long pad =3D stack_guard_gap;
> +
> +	/* Account for stack randomization if necessary */
> +	if (current->flags & PF_RANDOMIZE)
> +		pad +=3D (STACK_RND_MASK << PAGE_SHIFT);
> +
> +	/* Values close to RLIM_INFINITY can overflow. */
> +	if (gap + pad > gap)
> +		gap +=3D pad;
> =20
>  	if (gap < MIN_GAP)
>  		gap =3D MIN_GAP;
> --=20
> 2.20.1
>=20
