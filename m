Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9164CC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B82E218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UolObZ4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCLaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:30:06 -0400
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:28492
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfGCLaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCmna1gLdmddByfrsz4FLGld7c8CeqMYTN8cSuD1ylY=;
 b=UolObZ4b7huN+CoYDb5tvzEIykivwWl5tV8bK12Mb6KFaZ9T8wfQFhcRbCb8thjDgREy417Q4KQBvigv/oCR2WGHCIXU9gqJ4B+IvMX8leJ9ZjRvNBnNHZHhRRqt/MIlucuzVd2jwiXLHY32mCDvMP/U/Gsx14MEeLtcyG9HUVQ=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4667.namprd02.prod.outlook.com (20.176.108.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 11:29:49 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::936:90c8:a385:1513%4]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 11:29:49 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver for
 arm  pl353 smc nand interface
Thread-Topic: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver for
 arm  pl353 smc nand interface
Thread-Index: AQHVMWgp7D0lLmG2J0Kjwyg8UEvB4Ka4i+BAgAAwLACAAAUvoA==
Date:   Wed, 3 Jul 2019 11:29:49 +0000
Message-ID: <DM6PR02MB47793413E233EE8ECB54BC66AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190625044630.31717-1-naga.sureshkumar.relli@xilinx.com>
        <20190625044630.31717-2-naga.sureshkumar.relli@xilinx.com>
        <20190703082544.5b0ea566@collabora.com>
        <DM6PR02MB47792A7E700248348DAD9F78AFFB0@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190703130658.2abe5096@collabora.com>
In-Reply-To: <20190703130658.2abe5096@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3293d6d-4bf2-4d4f-3a8a-08d6ffa9c230
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB4667;
x-ms-traffictypediagnostic: DM6PR02MB4667:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR02MB466761C1D9B7290E2C54AE03AFFB0@DM6PR02MB4667.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(13464003)(51914003)(486006)(68736007)(14454004)(6916009)(6436002)(8936002)(966005)(71190400001)(71200400001)(86362001)(6246003)(2906002)(316002)(7696005)(99286004)(53546011)(6506007)(102836004)(478600001)(9686003)(6306002)(55016002)(76176011)(256004)(14444005)(53936002)(305945005)(26005)(74316002)(7736002)(8676002)(81166006)(81156014)(107886003)(7416002)(25786009)(4326008)(5660300002)(73956011)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(52536014)(54906003)(186003)(66066001)(446003)(3846002)(229853002)(33656002)(6116002)(476003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4667;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jcBYH97tG1xXxtccmAVgb9rzOV9IDhuJw7oyqcF+zcDdQtx7sOmrG3yL4mi4Y0YQZV7UHRj9AKX7vK5gc5togl/KqmUF8tlnQzFGsy6VoTj6knWk0kX3w5kjzIUWFTuoF+iMOeljAUPOmNxn5lETQBLRJQPMcU5ZrM6MWpIbm8HPJv5G2AOj0lnAANFvB3OwGaGqqJ/EvHFR0cPZVgJ+slpU3Wb4B5M/Bh+OKmsJXW8xpqPmeWCWUp/RQxQ6LODa2flxq8wgG7fmE2+c9PPCQJVuGZmdygja91Z14nhXdKV575bEQEz6x+f8hh+xlZQ+NKdB2vRIZS1bGVxJhrDbGqHLs3+LPo8XZoQxpmiM33uBO1Ld2cu0c367rpNYEh/wW4xVFdTgl0QPJ8QrLnv+5Cw0QX/EPtjcvT9A0XDrYG4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3293d6d-4bf2-4d4f-3a8a-08d6ffa9c230
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 11:29:49.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon <boris.brezillon@collabora.com>
> Sent: Wednesday, July 3, 2019 4:37 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de; richard@nod.at;
> dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com;
> bbrezillon@kernel.org; yamada.masahiro@socionext.com; linux-mtd@lists.inf=
radead.org; linux-
> kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>
> Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic driver =
for arm pl353
> smc nand interface
>=20
> On Wed, 3 Jul 2019 08:57:57 +0000
> Naga Sureshkumar Relli <nagasure@xilinx.com> wrote:
>=20
> > Hi Boris,
> >
> > Thanks for the review.
> >
> > > -----Original Message-----
> > > From: Boris Brezillon <boris.brezillon@collabora.com>
> > > Sent: Wednesday, July 3, 2019 11:56 AM
> > > To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > > Cc: miquel.raynal@bootlin.com; helmut.grohne@intenta.de;
> > > richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> > > marek.vasut@gmail.com; vigneshr@ti.com; bbrezillon@kernel.org;
> > > yamada.masahiro@socionext.com; linux- mtd@lists.infradead.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [LINUX PATCH v17 2/2] mtd: rawnand: pl353: Add basic
> > > driver for arm pl353 smc nand interface
> > >
> > > On Mon, 24 Jun 2019 22:46:30 -0600
> > > Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:
> > >
> > >
> > > > +
> > > > +/**
> > > > + * pl353_nand_exec_op_cmd - Send command to NAND device
> > > > + * @chip:	Pointer to the NAND chip info structure
> > > > + * @subop:	Pointer to array of instructions
> > > > + * Return:	Always return zero
> > > > + */
> > > > +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> > > > +				  const struct nand_subop *subop) {
> > > > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > > > +	const struct nand_op_instr *instr;
> > > > +	struct pl353_nfc_op nfc_op =3D {};
> > > > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > > > +	unsigned long cmd_phase_data =3D 0, end_cmd_valid =3D 0;
> > > > +	unsigned long end_cmd;
> > > > +	unsigned int op_id, len;
> > > > +	bool reading;
> > > > +	u32 cmdphase_addrflags;
> > > > +
> > > > +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> > > > +	instr =3D nfc_op.data_instr;
> > > > +	op_id =3D nfc_op.data_instr_idx;
> > > > +	pl353_smc_clr_nand_int();
> > > > +
> > > > +	/* Get the command phase address */
> > > > +	if (nfc_op.cmnds[1] !=3D 0) {
> > > > +		if (nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN)
> > > > +			end_cmd_valid =3D 0;
> > > > +		else
> > > > +			end_cmd_valid =3D 1;
> > >
> > > You're testing the opcode, again. As I said several times, the
> > > ->exec_op() implementation should be opcode agnostic, it should just
> > > ->try
> > > to match sequences of <CMD>-<ADDR>-<DATA> cycles.
> > >
> > This driver uses common function for all patterns.
> > There was some discussion happened on v8 series
> > https://lore.kernel.org/patchwork/patch/933639/
> > There the comments from Miquel was to use an optional property In the
> > pattern Matching, so with this approach, based on the command need to
> > update the end_cmd_valid bit in command phase cycle.
> > So in order to follow that approach, we defined a common pattern
> > matching function And there we are checking the commands.
> > It significantly reduces the code repetition.
>=20
> That's not what I'm talking about. I'm talking about the explicit 'nfc_op=
.cmnds[0] =3D=3D
> NAND_CMD_SEQIN' check, which AFAICT, is wrong, or at the very least, not =
future-proof
> at all.
Ok.
>=20
> Let me see if I understand what end_cmd_valid means: it's supposed to be =
set when the ADDR
> cycles are followed by a CMD cycle. You don't need to check if the first =
CMD cycle is !SEQIN
> (AKA start programming a page) to know that: just go through the flow of =
instructions in the
> subop, and check what's coming just after the ADDR instruction.
Ok. then let me update as per the flow of instructions.
>=20
> >
> > I understand your concern about not to check any NAND command in the
> > drivers under ->exec_op() implementation.
> > But do you see any issues/impact with this?
>=20
> Yes, I do. Sorry to say that, but the whole driver is coded with specific=
 use-cases (read/write
> page, read param page, etc) in mind, which is exactly what we were trying=
 to avoid when
> designing exec_op(). The goal was to have something that's easily maintai=
nable and does not
> break every time one tests a previously untested chip <-> controller comb=
ination.
>=20
Ok. I understand.

> > Functionality wise Helmut tested each series and we addressed all the c=
omments in v17
> series.
>=20
> Just because it's been tested does not mean it's ready to be merged, sorr=
y.
>=20
Ok. I will submit next version with the above changes.
> >
> > Could you please let me know what do you say?
> >
> > > > +	}
> > > > +
> > > > +	end_cmd =3D nfc_op.cmnds[1];
> > > > +
> > > > +	/*
> > > > +	 * The SMC defines two phases of commands when transferring data =
to or
> > > > +	 * from NAND flash.
> > > > +	 * Command phase: Commands and optional address information are w=
ritten
> > > > +	 * to the NAND flash.The command and address can be associated wi=
th
> > > > +	 * either a data phase operation to write to or read from the arr=
ay,
> > > > +	 * or a status/ID register transfer.
> > > > +	 * Data phase: Data is either written to or read from the NAND fl=
ash.
> > > > +	 * This data can be either data transferred to or from the array,
> > > > +	 * or status/ID register information.
> > > > +	 */
> > > > +	cmdphase_addrflags =3D ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> > > > +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > > > +			 (COMMAND_PHASE) |
> > > > +			 (end_cmd << END_CMD_SHIFT) |
> > > > +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> > > > +
> > > > +	/* Get the data phase address */
> > > > +	end_cmd_valid =3D 0;
> > > > +
> > > > +	xnfc->dataphase_addrflags =3D ((0x0 << CLEAR_CS_SHIFT) |
> > > > +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > > > +			  (DATA_PHASE) |
> > > > +			  (end_cmd << END_CMD_SHIFT) |
> > > > +			  (0x0 << ECC_LAST_SHIFT));
> > > > +
> > > > +	/* Command phase AXI Read & Write */
> > > > +	if (nfc_op.naddrs >=3D 5) {
> > > > +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> > > > +			cmd_phase_data =3D nfc_op.addrs;
> > > > +
> > > > +			/* Another address cycle for devices > 128MiB */
> > > > +			if (chip->options & NAND_ROW_ADDR_3) {
> > >
> > > Clearly, none of this belongs in the ->exec_op() implementation.
> > > Looks like something related to page read...
> > As I mentioned above in comments of pl353_exec_op(), the PL353 SMC
> > Controller uses command phase and data phase.
> > And in the Command phase, command and optional addresses are written to=
 NAND flash.
> > And it is correct as you said, it looks like page reads but it is
> > actually a command phase address update.
>=20
> You have the exact number of ADDR cycles to issue in the ADDR instruction=
, why do you
> need to check NAND_ROW_ADDR_3 at all?
Ok. nand_base.c is already doing that. Got it.
I will update.
Thanks for the review and suggestions.

Thanks,
Naga Sureshkumar Relli
