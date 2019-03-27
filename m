Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7A8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851252082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hOlH/pdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfC0JPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:15:43 -0400
Received: from mail-eopbgr820041.outbound.protection.outlook.com ([40.107.82.41]:30752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbfC0JPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v/Li4tHMR4YitLZRIOuqvurG1MKWbdo3ac6CPVzql8=;
 b=hOlH/pdQi24ZF0FzlkQcNj+5/M4aZfbiCNXNOrIYJ++HvjjGhzj2+k1q0XkExX3SCrh3JPvcnQ3EOU7y34BoKOXi/q5YxhrclF06ucZuDkUqUnK1spFr9jQzWhaUfyr8rG9fJQQpPPV/mOz6fNFBm1X+tM5yVv9DYEO5ip4Xg2A=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB2640.namprd02.prod.outlook.com (10.168.206.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 09:13:59 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c89d:e485:cb5e:89cf]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::c89d:e485:cb5e:89cf%5]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 09:13:59 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasureshkumarrelli@gmail.com" <nagasureshkumarrelli@gmail.com>
Subject: RE: [LINUX PATCH v13] rawnand: pl353: Add basic driver for arm pl353
 smc nand interface
Thread-Topic: [LINUX PATCH v13] rawnand: pl353: Add basic driver for arm pl353
 smc nand interface
Thread-Index: AQHUwEH1zZQS3QRob0y10ZaiOKtLVqYeLsaAgAFJyIA=
Date:   Wed, 27 Mar 2019 09:13:59 +0000
Message-ID: <MWHPR02MB26235ED95B0F0AE89B2A0972AF580@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1549694247-24625-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190326132721.52e7ktnptgwvzeor@laureti-dev>
In-Reply-To: <20190326132721.52e7ktnptgwvzeor@laureti-dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 004e94e2-4267-4adc-15da-08d6b2948c55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB2640;
x-ms-traffictypediagnostic: MWHPR02MB2640:
x-microsoft-antispam-prvs: <MWHPR02MB2640839623D4C4EBB6640921AF580@MWHPR02MB2640.namprd02.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(13464003)(53234004)(189003)(199004)(53546011)(6916009)(76176011)(6436002)(6246003)(102836004)(8936002)(26005)(81166006)(81156014)(8676002)(25786009)(33656002)(4326008)(99286004)(68736007)(66066001)(478600001)(14454004)(9686003)(6506007)(55016002)(7696005)(71190400001)(71200400001)(6116002)(229853002)(3846002)(105586002)(7416002)(74316002)(54906003)(106356001)(86362001)(5660300002)(305945005)(7736002)(486006)(11346002)(14444005)(316002)(2906002)(97736004)(186003)(5024004)(256004)(52536014)(476003)(53936002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2640;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: muzXueeW1Yg7fn/rpjmCWrpfvhABbTN6yme/+SbC5DJb4qK6RXqd2fBRpdFItGC1FfSFMrEM8/WLu8ArWRZAKRc5QT0R45aGS8CixKxikhS/RUzd4F49oeDHlKfCkj5PoXbAr5dg7W3klXXorP0iCqCVyxRh9YZukDQV7varfTOzJrVgvSZPfYvgG5aVg+70PsbbaWpHpF5hhDkT91jQXDRrziOXvAtMQXNxgC/r73HXbK1dJsPWafVllaeO/RrpD4qWAPlQuTMJvDScXAnBDXKkbeKz6fzdjW2dFt8fe89wxwDx2phC1WLDd2peiZH2v7yc27BDKmKswWFoRWXX7RuaTKms1mBwRGGdUov1lPN7a6apoqPEgCnEXY8ltC1JIGKMPgvkevIFgEst3nj6/4sCNzn2rHcvUPmKqUiEqZQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004e94e2-4267-4adc-15da-08d6b2948c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 09:13:59.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut,

> -----Original Message-----
> From: Helmut Grohne <helmut.grohne@intenta.de>
> Sent: Tuesday, March 26, 2019 6:57 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: bbrezillon@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com; =
linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v13] rawnand: pl353: Add basic driver for arm p=
l353 smc nand
> interface
>=20
> On Sat, Feb 09, 2019 at 12:07:27PM +0530, Naga Sureshkumar Relli wrote:
> > +static void pl353_nfc_force_byte_access(struct nand_chip *chip,
> > +					bool force_8bit)
> > +{
> > +	struct pl353_nand_controller *xnfc =3D
> > +		container_of(chip, struct pl353_nand_controller, chip);
>=20
> This `xnfc' variable is never used anywhere inside this function.
>=20
> > +/**
> > + * pl353_nand_exec_op_cmd - Send command to NAND device
> > + * @chip:	Pointer to the NAND chip info structure
> > + * @subop:	Pointer to array of instructions
> > + * Return:	Always return zero
> > + */
> > +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> > +				  const struct nand_subop *subop) {
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	const struct nand_op_instr *instr;
> > +	struct pl353_nfc_op nfc_op =3D {};
> > +	struct pl353_nand_controller *xnfc =3D
> > +		container_of(chip, struct pl353_nand_controller, chip);
> > +	unsigned long cmd_phase_data =3D 0, end_cmd_valid =3D 0;
> > +	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
> > +	unsigned int op_id, len, offset;
> > +	bool reading;
> > +
> > +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> > +	instr =3D nfc_op.data_instr;
> > +	op_id =3D nfc_op.data_instr_idx;
> > +
> > +	offset =3D nand_subop_get_data_start_off(subop, op_id);
>=20
> This `offset' variable is never used anywhere inside this function. The c=
all is unnecessary and
> should be removed.
Will remove it.
>=20
> Beyond being useless, it also is harmful. When applying this patch on top=
 of a v5.1-rc2, this can
> be found in dmesg:
>=20
> | ------------[ cut here ]------------
> | WARNING: CPU: 0 PID: 1 at
> | .../linux/drivers/mtd/nand/raw/nand_base.c:2299
> | nand_subop_get_data_start_off+0x30/0x6c
> | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc2-dirty #3 Hardware
> | name: Xilinx Zynq Platform [<c001743c>] (unwind_backtrace) from
> | [<c00145a4>] (show_stack+0x18/0x1c) [<c00145a4>] (show_stack) from
> | [<c03afe98>] (dump_stack+0xa0/0xcc) [<c03afe98>] (dump_stack) from
> | [<c0021c10>] (__warn+0x10c/0x128) [<c0021c10>] (__warn) from
> | [<c0021d14>] (warn_slowpath_null+0x48/0x50) [<c0021d14>]
> | (warn_slowpath_null) from [<c02703f0>]
> | (nand_subop_get_data_start_off+0x30/0x6c)
> | [<c02703f0>] (nand_subop_get_data_start_off) from [<c0279fe0>]
> | (pl353_nand_exec_op_cmd+0x94/0x2f0)
> | [<c0279fe0>] (pl353_nand_exec_op_cmd) from [<c027025c>]
> | (nand_op_parser_exec_op+0x460/0x4cc)
> | [<c027025c>] (nand_op_parser_exec_op) from [<c026ee4c>]
> | (nand_reset_op+0x134/0x1a0) [<c026ee4c>] (nand_reset_op) from
> | [<c0270adc>] (nand_reset+0x60/0xbc) [<c0270adc>] (nand_reset) from
> | [<c0272410>] (nand_scan_with_ids+0x288/0x1600) [<c0272410>]
> | (nand_scan_with_ids) from [<c027974c>] (pl353_nand_probe+0xf8/0x1a0)
> | [<c027974c>] (pl353_nand_probe) from [<c025185c>]
> | (platform_drv_probe+0x3c/0x74) [<c025185c>] (platform_drv_probe) from
> | [<c024fd28>] (really_probe+0x278/0x400) [<c024fd28>] (really_probe)
> | from [<c024e440>] (bus_for_each_drv+0x68/0x9c) [<c024e440>]
> | (bus_for_each_drv) from [<c0250090>] (__device_attach+0xa8/0x11c)
> | [<c0250090>] (__device_attach) from [<c024e63c>]
> | (bus_probe_device+0x90/0x98) [<c024e63c>] (bus_probe_device) from
> | [<c024cf7c>] (device_add+0x3b4/0x5f0) [<c024cf7c>] (device_add) from
> | [<c02b91b8>] (of_platform_device_create_pdata+0x98/0xc8)
> | [<c02b91b8>] (of_platform_device_create_pdata) from [<c02beba8>]
> | (pl353_smc_probe+0x194/0x234) [<c02beba8>] (pl353_smc_probe) from
> | [<c0223a64>] (amba_probe+0x60/0x74) [<c0223a64>] (amba_probe) from
> | [<c024fd28>] (really_probe+0x278/0x400) [<c024fd28>] (really_probe)
> | from [<c025062c>] (device_driver_attach+0x60/0x68) [<c025062c>]
> | (device_driver_attach) from [<c02506bc>] (__driver_attach+0x88/0x180)
> | [<c02506bc>] (__driver_attach) from [<c024df98>]
> | (bus_for_each_dev+0x60/0x9c) [<c024df98>] (bus_for_each_dev) from
> | [<c024e894>] (bus_add_driver+0x10c/0x208) [<c024e894>]
> | (bus_add_driver) from [<c0250dcc>] (driver_register+0x80/0x114)
> | [<c0250dcc>] (driver_register) from [<c04e2194>]
> | (do_one_initcall+0x164/0x374) [<c04e2194>] (do_one_initcall) from
> | [<c04e2738>] (kernel_init_freeable+0x394/0x474)
> | [<c04e2738>] (kernel_init_freeable) from [<c03c9660>]
> | (kernel_init+0x14/0x100) [<c03c9660>] (kernel_init) from [<c00090ac>]
> | (ret_from_fork+0x14/0x28) Exception stack(0xdd8c9fb0 to 0xdd8c9ff8)
> | 9fa0:                                     00000000 00000000 00000000 00=
000000
> | 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> | 00000000
> | 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 irq event
> | stamp: 414355 hardirqs last  enabled at (414361): [<c007c318>]
> | console_unlock+0x4c4/0x690 hardirqs last disabled at (414366):
> | [<c007bf30>] console_unlock+0xdc/0x690 softirqs last  enabled at
> | (414350): [<c000a4cc>] __do_softirq+0x454/0x544 softirqs last disabled
> | at (414345): [<c0027d98>] irq_exit+0x124/0x128 ---[ end trace
> | 3be9247df2f8dfb5 ]---
>=20
> After removing the call (and the variable), this particular problem goes =
away.
Ok, will update
>=20
> > +/**
> > + * pl353_nand_probe - Probe method for the NAND driver
> > + * @pdev:	Pointer to the platform_device structure
> > + *
> > + * This function initializes the driver data structures and the hardwa=
re.
> > + * The NAND driver has dependency with the pl353_smc memory
> > +controller
> > + * driver for initializing the NAND timing parameters, bus width, ECC
> > +modes,
> > + * control and status information.
> > + *
> > + * Return:	0 on success or error value on failure
> > + */
> > +static int pl353_nand_probe(struct platform_device *pdev) {
> > +	struct pl353_nand_controller *xnfc;
> > +	struct mtd_info *mtd;
> > +	struct nand_chip *chip;
> > +	struct resource *res;
> > +	struct device_node *np, *dn;
> > +	u32 ret, val;
>=20
> This `val' variable is never used anywhere inside this function.
>=20
> Even after fixing these, I couldn't make this driver work on actual hardw=
are.
It's a on-die ECC capable device. Did u mentioned nand-ecc-mode =3D "on-die=
" in dts.
The same part I tested by mentioning "on-die" property in dts and it worked=
 for me.
Please share the dts entries for NAND.
Also if it is x8 bus then please mention nand-bus-width =3D <8>;
If it is x16 mention nand-bus-width =3D <16>;

>=20
> | nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
> | nand: Micron MT29F2G08ABAEAWP
> | nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> | nand: WARNING: MT29F2G08ABAEAWP: the ECC used on your system is too
> | weak compared to the one required by the NAND chip
> | pl353_nand_calculate_hwecc status failed pl353_nand_calculate_hwecc
> | status failed pl353_nand_calculate_hwecc status failed
> | pl353_nand_calculate_hwecc status failed Bad block table not found for
> | chip 0 pl353_nand_calculate_hwecc status failed
> | pl353_nand_calculate_hwecc status failed pl353_nand_calculate_hwecc
> | status failed pl353_nand_calculate_hwecc status failed Bad block table
> | not found for chip 0
>=20
> The very same device works fine with an older version of the out-of-tree =
driver based on a
> v4.14 tree. Thus far I couldn't figure out why it fails like this.
>=20
> I'd appreciate if you could Cc me on future postings of this driver.
Sure, I will put you in CC.

On this v13 patch, got comments from Miquel to remove legacy hooks.
I will update the driver and will send next version.

Thanks,
Naga Sureshkumar Relli
>=20
> Helmut
