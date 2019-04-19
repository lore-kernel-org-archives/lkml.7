Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F5AC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894752171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="b+YF9nwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfDSUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:55:10 -0400
Received: from mail-eopbgr810090.outbound.protection.outlook.com ([40.107.81.90]:10800
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbfDSUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OKKUuG0RGtTDL45kFp1n+Nfgk8c+2RuA6hzjG4hrSY=;
 b=b+YF9nwuEuGOemMO/Bl7UsTRLK9V5t5c0wHy6wd8gDFbd+E5xO7Akd2WMrbGRqJGBGotAu0oQ0befiMbIIljI8FoeyvYCp26GAdEK84Xc+POVJEFcdMOUEhmEppsVQ8+zs7sqjivy+nexDzrbyq9deiakaiThYs9S0Gm22gx3xY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1760.namprd22.prod.outlook.com (10.164.206.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Fri, 19 Apr 2019 20:55:06 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.013; Fri, 19 Apr 2019
 20:55:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Resend] arch: mips: Fix initrd_start and initrd_end when read
 from DT
Thread-Topic: [Resend] arch: mips: Fix initrd_start and initrd_end when read
 from DT
Thread-Index: AQHU9D29gHbzBFCLD0GOCgvAiyCd3qZD+84A
Date:   Fri, 19 Apr 2019 20:55:06 +0000
Message-ID: <20190419205456.uylahdin2jlkeyyy@pburton-laptop>
References: <1555409900-31278-1-git-send-email-horatiu.vultur@microchip.com>
In-Reply-To: <1555409900-31278-1-git-send-email-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c32d273-56d0-465b-3299-08d6c5094cf3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1760;
x-ms-traffictypediagnostic: MWHPR2201MB1760:
x-microsoft-antispam-prvs: <MWHPR2201MB17608C9B21E2918F4775A0C5C1270@MWHPR2201MB1760.namprd22.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(7736002)(71200400001)(68736007)(71190400001)(478600001)(6916009)(99286004)(81166006)(25786009)(8936002)(6486002)(6116002)(44832011)(3846002)(2906002)(33716001)(6436002)(229853002)(81156014)(14444005)(256004)(8676002)(53936002)(66066001)(14454004)(4326008)(5660300002)(73956011)(186003)(9686003)(6512007)(54906003)(6506007)(386003)(76176011)(316002)(97736004)(66446008)(64756008)(58126008)(1076003)(66476007)(66946007)(102836004)(26005)(52116002)(6246003)(305945005)(42882007)(486006)(66556008)(476003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1760;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lmZcFz/I/RWtmPZw1Pp6/oThw05vespswEQdmg4EfV2GkEblUnBP1fjdNTIonz0TUDbNXN8RwZdJ2QDJbxQiIPKVem1TXfd30KtzJ8IWvI5ojz9omVELf4cJoPugFjbm8mfxYzGT8tc7sCJlOQch4yHaGo7eROli4Yt04ThaZaYba0zZtbyf4YVdJ9rV4zoeShfkMDzd4m3V2a5tY6sm15t3gy/03OZi6SjE35M3xncMLy+ipkmc1RaAHHuuJoxDJFetap7070za0cEUR/JchbEHG9oWgM2u4PTxE/RwXhcUNqTLddxIAW+cftexbGaHnc9l1DQFmTTj1ln1JSV8gHCf8oM1/kzIi1CHpvHjH4PT+XgouqGmdOXN999uLDvTg4T125Mb7YMfLZsTvv5CL/qbUJMOeUThs4lKr474n+Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3108908A0AF4B4DA93B006B6EDE77CD@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c32d273-56d0-465b-3299-08d6c5094cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 20:55:06.2533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Tue, Apr 16, 2019 at 12:18:20PM +0200, Horatiu Vultur wrote:
> When the bootloader passes arguments to linux kernel through device tree,
> it passes the address of initrd_start and initrd_stop, which are in kseg0=
.
> But when linux kernel reads these addresses from device tree, it converts
> them to virtual addresses inside the function
> __early_init_dt_declare_initrd.

I'm not sure I follow - if the bootloader provides an address in kseg0
then it's already a virtual address.

It looks like __early_init_dt_declare_initrd expects the DT to provide
physical addresses, which fits in well with the fact that DTs generally
use physical addresses for everything else.

__early_init_dt_declare_initrd calling __va on a virtual address will
give you something bogus, and it looks like you're just cancelling this
out below. In practice for a typical system where PAGE_OFFSET is the
start of kseg0 (0x80000000) the bogus address you get will happen to be
the same as the physical address, but that's not guaranteed.

> At a later point then in the function init_initrd, it is checking for
> initrd_start to be lower than PAGE_OFFSET, which for a 32 CPU it is not,
> therefore it would disable the initrd by setting 0 to initrd_start and
> initrd_stop.

The check you mention here is to make sure initrd_start looks like a
virtual address - if it's lower than PAGE_OFFSET (typically 0x80000000)
then it looks bad & initrd is disabled. I think your comment is
backwards - what you have is a physical address, entirely by accident,
and you're converting it back to a virtual address again by accident
which keeps the check happy.

> The fix consists of checking if linux kernel received a device tree and n=
ot
> having enable extended virtual address and in that case convert them back
> to physical addresses that point in kseg0 as expected.

Can you instead just have your bootloader provide physical addresses in
the DT?

Even if we were to have this code try to sanitize the value with
something like __va(__pa(initrd_start)), it only covers systems using
the UHI boot protocol which isn't the only way we can obtain a DT. If a
system builds in its DTB for example it'll get different behaviour to if
it's passed via the UHI protocol by the bootloader.

Thanks,
    Paul

> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  arch/mips/kernel/setup.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 8d1dc6c..774ee00 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -264,6 +264,17 @@ static unsigned long __init init_initrd(void)
>  		pr_err("initrd start must be page aligned\n");
>  		goto disable;
>  	}
> +
> +	/*
> +	 * In case the initrd_start and initrd_end are read from DT,
> +	 * then they are converted to virtual address, therefore convert
> +	 * them back to physical address.
> +	 */
> +	if (!IS_ENABLED(CONFIG_EVA) && fw_arg0 =3D=3D -2) {
> +		initrd_start =3D initrd_start - PAGE_OFFSET + PHYS_OFFSET;
> +		initrd_end =3D initrd_end - PAGE_OFFSET + PHYS_OFFSET;
> +	}
> +
>  	if (initrd_start < PAGE_OFFSET) {
>  		pr_err("initrd start < PAGE_OFFSET\n");
>  		goto disable;
> --=20
> 2.7.4
>=20
