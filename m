Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194FF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="YNQJHb6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfCKTHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:07:13 -0400
Received: from mail-eopbgr690102.outbound.protection.outlook.com ([40.107.69.102]:1773
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727424AbfCKTHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jMDsLsz46Z/Z8ucfwLaG1YB9BHXvKuM+IyPRqbbsAE=;
 b=YNQJHb6Qi4aZ/f6WXv0tk211kGNj+uoINJsaXfytQFzAYjdJylMYBkrk2+QqMqjgHqm/+4Zt0awBs3SlnEEXTbdNC/VW7k6pEtxMt9ZBVhb5aSGHp7GoO94pumAeY5xr61IAljTFSHj8WSXBOCiPdgT/k9OSj75LcvhGvcr1RQg=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1104.namprd22.prod.outlook.com (10.174.169.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 19:07:06 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 19:07:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hassan Naveed <hnaveed@wavecomp.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] MIPS: eBPF: Provide eBPF support for MIPS64R6
Thread-Topic: [PATCH 2/3] MIPS: eBPF: Provide eBPF support for MIPS64R6
Thread-Index: AQHU1gcoXvIspUQ9X0CpvLWQunKe+6YGzysA
Date:   Mon, 11 Mar 2019 19:07:05 +0000
Message-ID: <20190311190704.yopt7usiu2p4a7t7@pburton-laptop>
References: <20190308233245.19648-1-hnaveed@wavecomp.com>
 <20190308233245.19648-2-hnaveed@wavecomp.com>
In-Reply-To: <20190308233245.19648-2-hnaveed@wavecomp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c0ad43b-6364-4e2e-486c-08d6a654c084
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1104;
x-ms-traffictypediagnostic: MWHPR2201MB1104:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1104;23:J3xC7tSKls6+MexIZRJYqSI6S3wwZtcHRJ8o6gu?=
 =?us-ascii?Q?wCOl2L8wLcDTWCiEdmCq3WuNhFdqmQnX9Z5ot3BEZZnSnF2+EL87VzJNCASZ?=
 =?us-ascii?Q?sROjZF2iqDT7WFJu5gqfhIdEbchI1/YoHjMqQ8NE4hxyKN3ECpw0EuTw2rlN?=
 =?us-ascii?Q?DtzFN0hhcm9ifXCw3BtW5ewUPzmt9SxR7/LQxCyhnCOu6Sv9ZQwP9wppA+Yd?=
 =?us-ascii?Q?Bf4uqYgDm+QEC9Li2MBRwNvGXa8X5DkUBoNH/UYYE11tg2vuDEPqE03zlPOY?=
 =?us-ascii?Q?FnTx63mTbY8T2rgJhbBsZxz2PixhymKsLVZ6vZxUmsuLhiedOTpfk2kYGfQx?=
 =?us-ascii?Q?nFpFs88MXOzLv1jLEA4sAOVvmsp7G67TT7CQylmWH8Kfo6ywx7snv4gcTa2d?=
 =?us-ascii?Q?YS/pGvtZEqpFPH1OSn1dCg4e9PrYhAwVtAGol55tTkiBrwaDuBoj1ZJGmnh4?=
 =?us-ascii?Q?pVqVYosdkGUbuuUvB4tsmbcdyXv8Gpxk5tamyV3sVbIHUfZQOjswEXbezNNT?=
 =?us-ascii?Q?gH6dGP1AV+ARycyXfzHqXcd3jOf9GVDrncSxrKFKzQZL3Rrvi39Vh5TzG8LO?=
 =?us-ascii?Q?69TsRfvE0m1zhh9AxTpDkcIdJVxl2YFeY5y20vuLA6QWSOToXMeF50RGsTcY?=
 =?us-ascii?Q?1WBJ0y0IwviOIHkZvbfnSaufCztLEUUFdowauDPlgn+zb6VWRlGItzvt8xHE?=
 =?us-ascii?Q?+zTUN/nRMa2CVwc1YoxPuisaa0sZkVV/A6iI9+lQgWliy6euZzHf2KysQrtG?=
 =?us-ascii?Q?CeCP4bfKgCojNeQjmmaM2VyF/BrWms89W/MAfEYUehe57WRkKsLOVqNxax7w?=
 =?us-ascii?Q?pWsOWeJgNM5IZy9RIq62ZIsx5MTPeTxg/9pmwPWmkewMuMuKKODHTFHz08Co?=
 =?us-ascii?Q?fJ4rFrXkQ2tZ8OIRt1dTxfamWxJ7mjDCu6YyANU7so0ip5EcfdyfEivenfIj?=
 =?us-ascii?Q?3M1DuM2dcdvJuridOmZUjBJI/5k0QJvNQ/xEkTsGsc04ciEoxapWkKY90ZX+?=
 =?us-ascii?Q?aZcUYyAHuMyOa3VNMoX1xmuzYnEzV9gSSnZ8lr4fep8wSyuINVUDzraDQG9N?=
 =?us-ascii?Q?RUVcts8CeFv1+kFb4YmTrSI4x9yox9vCzpyK2e95qj/Kw6dnSoc5htvMo8lU?=
 =?us-ascii?Q?Af2mEdK7zcRrpbiVaoyhyzVUVp3upCRzqj+QjOgysGIq4/sWa6fGxL035enq?=
 =?us-ascii?Q?7O2895lctbiZezMLNr0H9izzObcNpWZ9MK29t51UpVKlntbPyTEqu5NvDZPu?=
 =?us-ascii?Q?3aT/aUu5mK8h5/K+HDvsxd4Clfzulypxf2DYfZMQFKQU4f3ngB9DPIpOA+Is?=
 =?us-ascii?Q?LbQGx0c1G+mZP3US6o+Y9bsBOFpmoaHNlmVyTiz2+Iexl8fo5EwygxNeAvmc?=
 =?us-ascii?Q?XEphhoA=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB110495EC292EF3B3E71CA7A4C1480@MWHPR2201MB1104.namprd22.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39850400004)(366004)(346002)(376002)(396003)(189003)(199004)(31014005)(6862004)(7416002)(3846002)(256004)(102836004)(76176011)(386003)(6506007)(42882007)(52116002)(105586002)(71200400001)(71190400001)(66066001)(186003)(446003)(26005)(4326008)(2906002)(1076003)(11346002)(476003)(99286004)(5660300002)(486006)(44832011)(14454004)(14444005)(478600001)(53936002)(229853002)(6246003)(6436002)(316002)(8936002)(58126008)(9686003)(6512007)(54906003)(106356001)(68736007)(305945005)(7736002)(25786009)(33716001)(6486002)(8676002)(81156014)(6116002)(97736004)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1104;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0o+us6WlOtNthGUrODahCg5xwsZVao64L7xenLB0yvxn0a7A1Mo8fTHFknIJCY15f+K+1xI1HOQZux4BiyWXSHcY6ZIGCaUiAACh1Raon3O2rKV6KIxxpwSEAp5RuEXj9kx0yvC4MONlsAJB3nitZQckGF6RAQdTBvrFA8Us6NrY535Hk6Z9nNlBXgpWxQGHW8xAP/wkgwnhGm5ry//hLffYtPdvl8opGxmSXowJvB5BoTzjhXXSYC1BTPtRBHMTzSCiNeFEUyLIT9eRQKYE/peiHChZKx6VzWoGLMdVKqOG/BPHgF5dpdLVHGwdsCQ478tPLMVJRNm6lElA4/ziyd+VWNbTER/0cM8ZDatvdm3KOcDtd1pxuXnrpGHvzOmMYf5BHCEdUonm85PFbIYJejAIpqUJ6euyn971V5QdDJk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6667FD7812DAF549AEE4F4C8C299BE7C@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0ad43b-6364-4e2e-486c-08d6a654c084
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 19:07:05.9584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hassan,

Thanks - overall this is looking good :)

On Fri, Mar 08, 2019 at 03:32:09PM -0800, Hassan Naveed wrote:
> Currently eBPF support is available on MIPS64R2 only. Use MIPS64R6
> variants of instructions like multiply, divide, movn, movz so eBPF
> can run on the newer ISA. Also, we only need to check ISA revision
> before JIT'ing code, because by this point, we already know CPU
> supports 64 bits since it's running a 64 bit kernel. It would have
> crashed otherwise.

It might be worth stating that we know it's running a 64 bit kernel
because the eBPF JIT is only included in kernels with CONFIG_64BIT=3Dy due
to Kconfig dependencies.

> @@ -1006,8 +1048,25 @@ static int build_one_insn(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx,
>  			emit_instr(ctx, dsubu, MIPS_R_T8, dst, src);
>  			emit_instr(ctx, sltu, MIPS_R_AT, dst, src);
>  			/* SP known to be non-zero, movz becomes boolean not */
> -			emit_instr(ctx, movz, MIPS_R_T9, MIPS_R_SP, MIPS_R_T8);
> -			emit_instr(ctx, movn, MIPS_R_T9, MIPS_R_ZERO, MIPS_R_T8);
> +			if (MIPS_ISA_REV >=3D 6) {
> +				emit_instr(ctx, seleqz, MIPS_R_T7,
> +						MIPS_R_SP, MIPS_R_T8);
> +				emit_instr(ctx, selnez, MIPS_R_T9,
> +						MIPS_R_T9, MIPS_R_T8);
> +				emit_instr(ctx, or, MIPS_R_T9,
> +						MIPS_R_T9, MIPS_R_T7);
> +				emit_instr(ctx, selnez, MIPS_R_T7,
> +						MIPS_R_ZERO, MIPS_R_T8);
> +				emit_instr(ctx, seleqz, MIPS_R_T9,
> +						MIPS_R_T9, MIPS_R_T8);
> +				emit_instr(ctx, or, MIPS_R_T9,
> +						MIPS_R_T9, MIPS_R_T7);
> +			} else {
> +				emit_instr(ctx, movz, MIPS_R_T9,
> +						MIPS_R_SP, MIPS_R_T8);
> +				emit_instr(ctx, movn, MIPS_R_T9,
> +						MIPS_R_ZERO, MIPS_R_T8);
> +			}
>  			emit_instr(ctx, or, MIPS_R_AT, MIPS_R_T9, MIPS_R_AT);
>  			cmp_eq =3D bpf_op =3D=3D BPF_JGT;
>  			dst =3D MIPS_R_AT;

Looking at this, I think we can simplify it a lot. What the original
movn/movz code is doing is this:

	/* movz */
	if (!t8)
		t9 =3D sp;

	/* movn */
	if (t8)
		t9 =3D 0;

Or, simplified:

	t9 =3D t8 ? sp : 0;

This actually matches up very well with the r6 selnez instruction, so I
think the MIPSr6 version can be just one instruction:

	selnez	t9, sp, t8

Could you give that a try?

> @@ -1245,7 +1304,6 @@ static int build_one_insn(const struct bpf_insn *in=
sn, struct jit_ctx *ctx,
>  		if (emit_bpf_tail_call(ctx, this_idx))
>  			return -EINVAL;
>  		break;
> -
>  	case BPF_ALU | BPF_END | BPF_FROM_BE:
>  	case BPF_ALU | BPF_END | BPF_FROM_LE:
>  		dst =3D ebpf_to_mips_reg(ctx, insn, dst_reg);

Please leave that empty line there; it helps readability.

> @@ -1366,6 +1424,12 @@ static int build_one_insn(const struct bpf_insn *i=
nsn, struct jit_ctx *ctx,
>  		if (src < 0)
>  			return src;
>  		if (BPF_MODE(insn->code) =3D=3D BPF_XADD) {
> +			if (MIPS_ISA_REV >=3D 6) {
> +				emit_instr(ctx, daddiu, MIPS_R_T6,
> +						dst, mem_off);
> +				mem_off =3D 0;
> +				dst =3D MIPS_R_T6;
> +			}
>  			switch (BPF_SIZE(insn->code)) {
>  			case BPF_W:
>  				if (get_reg_val_type(ctx, this_idx, insn->src_reg) =3D=3D REG_32BIT)=
 {

It might be worth adding a comment before your if statement explaining
that in MIPSr6 the encoded immediate for ll/sc instructions shrunk from
16 bits to 9 bits, hence the need for the temporary register.

Actually you could conditionalise this upon mem_off actually being too
big for the 9 bit field. For example something like:

	if ((mem_off >=3D 0) && (mem_off < BIT(9))) {
		/*
		 * mem_off is positive & fits within the 9 bit ll/sc
		 * instruction immediate field.
		 */
	} else if ((mem_off < 0) && (-mem_off <=3D BIT(9))) {
		/*
		 * mem_off is negative & fits within the 9 bit ll/sc
		 * instruction immediate field.
		 */
	} else if (MIPS_ISA_REV >=3D 6) {
		use the temp register
	}

That way we'd avoid the temp register in cases where the immediate is
small enough to fit in the instruction anyway.

And further this all makes me wonder what happens if we have an
immediate that doesn't fit in 16 bits... I suspect we have a bug there
on both pre-r6 (ll/sc immediate field overflow) & r6 (daddiu immediate
field overflow). Though in practice I don't know if it's possible to hit
it, and it's not a new issue so let's look at that separately & not gate
this work on it.

One last comment - it'd be good to copy the BPF maintainers too for v2.
You can get the full list of people to email from get_maintainer.pl:

$ ./scripts/get_maintainer.pl -f arch/mips/net/ebpf_jit.c
Paul Burton <paul.burton@mips.com> (maintainer:BPF JIT for MIPS (32-BIT AND=
 64-BIT))
Ralf Baechle <ralf@linux-mips.org> (supporter:MIPS)
James Hogan <jhogan@kernel.org> (supporter:MIPS)
Alexei Starovoitov <ast@kernel.org> (supporter:BPF (Safe dynamic programs a=
nd tools))
Daniel Borkmann <daniel@iogearbox.net> (supporter:BPF (Safe dynamic program=
s and tools))
Martin KaFai Lau <kafai@fb.com> (reviewer:BPF (Safe dynamic programs and to=
ols))
Song Liu <songliubraving@fb.com> (reviewer:BPF (Safe dynamic programs and t=
ools))
Yonghong Song <yhs@fb.com> (reviewer:BPF (Safe dynamic programs and tools))
netdev@vger.kernel.org (open list:BPF JIT for MIPS (32-BIT AND 64-BIT))
bpf@vger.kernel.org (open list:BPF JIT for MIPS (32-BIT AND 64-BIT))
linux-mips@vger.kernel.org (open list:MIPS)
linux-kernel@vger.kernel.org (open list)

Thanks,
    Paul
