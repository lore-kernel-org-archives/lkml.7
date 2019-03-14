Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8200DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D37120811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MFlai26N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfCNSNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:13:13 -0400
Received: from mail-eopbgr740111.outbound.protection.outlook.com ([40.107.74.111]:6601
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbfCNSNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv+/jVCpaQDNAYTPEMv3dEMLJupz+pTeEwW+pgdkKAs=;
 b=MFlai26N1W1wCZHtQiqcq/eFxsWCw3RmUGehrR+7HFZ+bT3Y01SPkrt2UDaHzq9P1f1P/rjhO0qoJr1OxzA/khrae8XJSK5wAbJvJBAwLCGTU2NufEXPlUJc7oZYpvGNsscYRciz34KlG0M3umuG6q2D41l7dTJJjUMZl1TNDBo=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1759.namprd22.prod.outlook.com (10.164.206.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 18:13:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1709.011; Thu, 14 Mar 2019
 18:13:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 06/14] MIPS: entry: Remove unneeded need_resched() loop
Thread-Topic: [PATCH 06/14] MIPS: entry: Remove unneeded need_resched() loop
Thread-Index: AQHU2FyFR/j/WMmRLk2V/nucBCrOZKYLcmsA
Date:   Thu, 14 Mar 2019 18:13:07 +0000
Message-ID: <20190314181306.k6vxmaomyqalhi65@pburton-laptop>
References: <20190311224752.8337-1-valentin.schneider@arm.com>
 <20190311224752.8337-7-valentin.schneider@arm.com>
In-Reply-To: <20190311224752.8337-7-valentin.schneider@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:a03:54::37) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73e27bee-3d1c-4cd0-8a5e-08d6a8a8b5ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1759;
x-ms-traffictypediagnostic: MWHPR2201MB1759:
x-microsoft-antispam-prvs: <MWHPR2201MB17593FFD64B4688756A04599C14B0@MWHPR2201MB1759.namprd22.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(366004)(346002)(376002)(136003)(39850400004)(189003)(199004)(52314003)(478600001)(42882007)(71190400001)(53936002)(68736007)(6916009)(105586002)(106356001)(14454004)(71200400001)(54906003)(229853002)(476003)(44832011)(6486002)(186003)(26005)(486006)(5660300002)(6436002)(1076003)(58126008)(52116002)(102836004)(11346002)(446003)(386003)(6506007)(25786009)(305945005)(7736002)(81156014)(81166006)(66066001)(2906002)(316002)(76176011)(8676002)(14444005)(256004)(8936002)(4326008)(97736004)(99286004)(33716001)(6246003)(3846002)(9686003)(6116002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1759;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZDVnl515RHW9f80w7xSDf6hTRiBpx3ohrmEHmo+acpgZEiPLEIrStzeQOtXbn35atxgH+ok0lRGZxXibHMcPfNtzA+gzkvjBXdZQLBfP2lA7D2vlVSsq2cBdDC/Z6LmZ7ajtpAFCi3qOzKCWwQ87wuAJoLI8sx6ezquIGrqQ5Hv0awm7PPCHVwZ8Q/DszKaxbEFDTWvUDWVwNIYbDfJfB/IZa0x1+jML6/FbA6jnimToSZJZTJXTaiA/i77K71BdmiDnbWXCsWt61SqXopRyO5nvlHiCZvFVZXcJyEpeoqJfC+xjSh/2om9Z/Ieo0DfY146HET1uQMaTWyiDYalJtb/8Gzl5iOGWGsUTA2WY6nsKzlrJ0wL4nJlVO0WD1MHMPynpyXLVsn5jVZNBaXNnWBq19ItVrLdKh0bVMqHtOHU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF357C9F3F3E9D44B6AA388F84A73ECB@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e27bee-3d1c-4cd0-8a5e-08d6a8a8b5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 18:13:07.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Mon, Mar 11, 2019 at 10:47:44PM +0000, Valentin Schneider wrote:
> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
>=20
> Do note that commit a18815abcdfd ("Use preempt_schedule_irq.")
> initially removed the existing loop, but commit cdaed73afb61 ("Fix
> preemption bug.") reintroduced it. It is however not clear what the
> issue was and why such a loop was reintroduced, so I'm probably
> missing something.

It looks to me like commit a18815abcdfd ("Use preempt_schedule_irq.")
forgot the branch to restore_all, so would have fallen through to
ret_from_fork() & done weird things.

Adding the branch to restore_all as you're doing here would have been a
better fix than commit cdaed73afb61 ("Fix preemption bug.").

> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/kernel/entry.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> index d7de8adcfcc8..2240faeda62a 100644
> --- a/arch/mips/kernel/entry.S
> +++ b/arch/mips/kernel/entry.S
> @@ -58,7 +58,6 @@ resume_kernel:
>  	local_irq_disable
>  	lw	t0, TI_PRE_COUNT($28)
>  	bnez	t0, restore_all
> -need_resched:
>  	LONG_L	t0, TI_FLAGS($28)
>  	andi	t1, t0, _TIF_NEED_RESCHED
>  	beqz	t1, restore_all
> @@ -66,7 +65,7 @@ need_resched:
>  	andi	t0, 1
>  	beqz	t0, restore_all
>  	jal	preempt_schedule_irq
> -	b	need_resched
> +	j	restore_all

One nit - why change from branch to jump? It's not a big deal, but I'd
prefer we stick with the branch ("b") instruction for a few reasons:

- restore_all is nearby so there's no issue with it being out of range
  of a branch in any variation of the MIPS ISA.

- It's more consistent with the future of the MIPS architecture, eg.
  nanoMIPS in which branch instructions all use PC-relative immediate
  offsets & jump instructions are always of the "register" variety where
  the destination is specified by a register rather than an immediate
  encoded in the instruction (the assembler will fix it up & emit a
  branch anyway, but I generally prefer to invoke less magic in these
  areas...).

- A PC-relative branch won't generate an extra reloc in a relocatable
  kernel, whereas a jump will.

Even better would be if we take advantage of this being a tail call & do
this:

	PTR_LA	ra, restore_all
	j	preempt_schedule_irq

(Where I left the call to preempt_schedule_irq using a jump because it
may be further away.)

Though I don't mind if you wanna just s/j/b/ & leave the tail call
optimisation for someone else to do as a later change.

Thanks,
    Paul

>  #endif
> =20
>  FEXPORT(ret_from_kernel_thread)
> --=20
> 2.20.1
>=20
