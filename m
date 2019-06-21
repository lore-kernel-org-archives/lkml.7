Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B348C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A621530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FYGTNKRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFUNYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:24:07 -0400
Received: from mail-eopbgr740074.outbound.protection.outlook.com ([40.107.74.74]:20544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfFUNYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiArLKtiLzI2TGsNoz0UpT/qUaNnHYZYKsBvNEx6tLg=;
 b=FYGTNKRQpq7tc9wLr/+MkAOfDGQOj0frwCTIVxhbA1ifPDRnUxqSQTMBs860nzg+SB8Do1x4iG8pkXUP/BtFYtboqy5MDMVqjeKX90YmNigbdIpQaEkwwGZPYY6Kpdk/W6jYa5Vhftc/vwgqSsKk9ZNOEZjT1ZH5FahkeDc+yXI=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4217.namprd02.prod.outlook.com (20.176.76.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 13:23:56 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::6d49:62d5:cd7c:a8f]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::6d49:62d5:cd7c:a8f%6]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 13:23:56 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v16] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Topic: [LINUX PATCH v16] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Index: AQHVJOm9RuKR855h4kWfTmRlitOSm6al0HkAgAAWSnA=
Date:   Fri, 21 Jun 2019 13:23:56 +0000
Message-ID: <DM6PR02MB47797622A75DD47042136C25AFE70@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190617085002.4746-1-naga.sureshkumar.relli@xilinx.com>
 <20190621084141.xnqnzuogb3fv4tla@laureti-dev>
In-Reply-To: <20190621084141.xnqnzuogb3fv4tla@laureti-dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a602038a-285a-4f0d-743c-08d6f64bb68b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR02MB4217;
x-ms-traffictypediagnostic: DM6PR02MB4217:
x-microsoft-antispam-prvs: <DM6PR02MB421753F6FF31DA0F4B6368ACAFE70@DM6PR02MB4217.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(136003)(39850400004)(51914003)(189003)(199004)(13464003)(26005)(71190400001)(25786009)(71200400001)(66066001)(229853002)(30864003)(305945005)(486006)(74316002)(7736002)(476003)(55016002)(53946003)(9686003)(11346002)(186003)(14444005)(256004)(5024004)(446003)(6436002)(86362001)(2906002)(7696005)(4326008)(14454004)(107886003)(76176011)(68736007)(102836004)(99286004)(478600001)(6916009)(81156014)(81166006)(8676002)(52536014)(33656002)(8936002)(64756008)(66946007)(5660300002)(66476007)(66556008)(73956011)(66446008)(76116006)(53936002)(316002)(54906003)(6506007)(53546011)(3846002)(6246003)(6116002)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4217;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CnzXTQrF6Yt6xn/uKcsepmBIsKeo35D+MgUFoXNDvR5inVJZqKir1ZeWl//rq3cMhaNvqWB6/Ep0OAdVQVgMgcngmfOcGeajTBIn6dk8Z+XfkFgqSFq4JUGOlyuPaP+vkb7c7eFXaSpvCAWdwiaErzZ2DHTePA55dkTe2PiDORz1u+bJRKvTiayQ/dzxSqKIKZEcvNJUo/5EMStpqhZPwxZ849o1n24VRHUrFYHnG4dgWJs96bqwxph7aevfGNVdOtHy5XHKcRrrmBAMijcL+KTiG7180DYcDLtzcdQ9rW+nObzHiFI0r9C4ZJfVKvoU6eWVc2gjuLIYG0QKAJfaVcBS9AH+BPiOJGGNVSaerh9U1irah9qNIEfVa/kcDkJQYD+jbjFzqdDJ1BWByRmSyV7njMakBXVDVLUQrYegLmU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a602038a-285a-4f0d-743c-08d6f64bb68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:23:56.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut,

> -----Original Message-----
> From: Helmut Grohne <helmut.grohne@intenta.de>
> Sent: Friday, June 21, 2019 2:12 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: miquel.raynal@bootlin.com; richard@nod.at; dwmw2@infradead.org;
> computersforpeace@gmail.com; marek.vasut@gmail.com; vigneshr@ti.com; linu=
x-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>
> Subject: Re: [LINUX PATCH v16] mtd: rawnand: pl353: Add basic driver for =
arm pl353 smc
> nand interface
>=20
> Hi,
>=20
> On Mon, Jun 17, 2019 at 02:50:02AM -0600, Naga Sureshkumar Relli wrote:
> > Add driver for arm pl353 static memory controller nand interface with
> > HW ECC support. This controller is used in Xilinx Zynq SoC for
> > interfacing the NAND flash memory.
>=20
> Thank you for the update.
>=20
> > -> Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion
> S34ML01G1.
>=20
Thank you for your effort on testing.
> I've tested this driver with the same Micron MT29F2G08ABAEAWP using
I haven't tried jffs2 previously.
I tried it now and I also seen the similar behavior.
I found one issue in nand_micron.c and in pl353_nand.c where in micron_nand=
_init(),
without checking if (!chip->ecc.read_page), it is over writing
The driver's read_page().
So I have added check like below in nand_micron.c
@@ -500,8 +500,11 @@ static int micron_nand_init(struct nand_chip *chip)
 		chip->ecc.size =3D 512;
 		chip->ecc.strength =3D chip->base.eccreq.strength;
 		chip->ecc.algo =3D NAND_ECC_BCH;
-		chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;
-		chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;
+		if (!chip->ecc.read_page)
+			chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;
+
+		if (!chip->ecc.write_page)
+			chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;

And in pl353_nand.c driver,=20
@@ -1024,6 +1028,8 @@ static int pl353_nand_ecc_init(struct mtd_info *mtd, =
struct nand_ecc_ctrl *ecc,
 	ecc->read_oob =3D pl353_nand_read_oob;
 	ecc->write_oob =3D pl353_nand_write_oob;
 	if (ecc_mode =3D=3D NAND_ECC_ON_DIE) {
+		ecc->write_page =3D pl353_nand_write_page_raw;
+		ecc->read_page =3D pl353_nand_read_page_raw;
 		ecc->write_page_raw =3D pl353_nand_write_page_raw;
 		ecc->read_page_raw =3D pl353_nand_read_page_raw;
=20
with this changes, jffs2 is also working fine(able to mount and unmount and=
 data integrity
is working fine)
I will update and send the updated patches.

> v5.2-rc5 and I am still seeing lots of ecc errors aka mtd_read returning =
-EBADMSG. I traced
> the source of these errors to
> micron_nand_on_die_ecc_status_4 where the NAND_STATUS_FAIL bit is often f=
ound. I
> reproduced this symptom on multiple boards. An older version of the drive=
r (against v4.14)
> does not show this behaviour on the same devices. I was able to reliably =
reproduce this
> behaviour using the following sequence:
>  * flash_erase -j /dev/mtdN 0 0
>  * mount -t jffs2 /dev/mtdblockN /mnt
>  * touch /mnt/foo
>  * umount /mnt
>  * mount -t jffs2 /dev/mtdblockN /mnt
> The relevant kernel message is:
>=20
>     jffs2: mtd->read(0xXXX bytes from 0xXXXXXXX) returned ECC error
>=20
> I also occasionally saw errors from nandtest ("Byte 0xXXXXX is XX should =
be XX"). They
> only reproduce when running nandtest multiple times (less than 10).  When=
 such errors
> happen, they are not simple bit flips. Lots of consecutive bytes differ e=
ntirely. Again, I am
> unable to reproduce these errors with the older driver.
>=20
> Possibly I'm wrongly configuring the flash. Can you share a correct devic=
e tree for it? Given
> my reading of the driver, the nand-ecc-algo is irrelevant, because nand_m=
icron.c forces bch for
> on-die ecc-mode anyway.
> The ecc-strength thus becomes 4. So I'm left wondering what needs to be c=
onfigured beyond
> nand-ecc-mode =3D "on-die" and nand-bus-width =3D <8>?
Below one I am using for testing.
	flash@e1000000 {
		status =3D "okay";
		compatible =3D "arm,pl353-nand-r2p1";
		reg =3D <0xe1000000 0x1000000>;
		#address-cells =3D <0x1>;
		#size-cells =3D <0x1>;
		nand-ecc-mode =3D "on-die";
		nand-bus-width =3D <0x8>;

		partition@nand-fsbl-uboot {
			label =3D "nand-fsbl-uboot";
			reg =3D <0x0 0x2000000>;
		};
		partition@nand-linux {
			label =3D "nand-linux";
			reg =3D <0x100000 0x500000>;
		};
		partition@nand-device-tree {
			label =3D "nand-device-tree";
			reg =3D <0x600000 0x20000>;
		};
		partition@nand-rootfs {
			label =3D "nand-rootfs";
			reg =3D <0x620000 0x5e0000>;
		};
		partition@nand-bitstream {
			label =3D "nand-bitstream";
			reg =3D <0xc00000 0x400000>;
			};
	};
>=20
> In addition to testing the driver, I looked at the source again.
>=20
> > Changes in v15:
>=20
> It seems that this version lost the Kconfig and Makefile integration.
Sorry, will update it.
>=20
> > --- /dev/null
> > +++ b/drivers/mtd/nand/raw/pl353_nand.c
> > @@ -0,0 +1,1306 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ARM PL353 NAND flash controller driver
> > + *
> > + * Copyright (C) 2017 Xilinx, Inc
> > + * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
> > + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/rawnand.h>
> > +#include <linux/mtd/nand_ecc.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/pl353-smc.h>
> > +#include <linux/clk.h>
> > +
> > +#define PL353_NAND_DRIVER_NAME "pl353-nand"
> > +
> > +/* NAND flash driver defines */
> > +#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
> > +
> > +/* AXI Address definitions */
> > +#define START_CMD_SHIFT		3
> > +#define END_CMD_SHIFT		11
> > +#define END_CMD_VALID_SHIFT	20
> > +#define ADDR_CYCLES_SHIFT	21
> > +#define CLEAR_CS_SHIFT		21
> > +#define ECC_LAST_SHIFT		10
> > +#define COMMAND_PHASE		(0 << 19)
> > +#define DATA_PHASE		BIT(19)
> > +
> > +#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set
> ECC_Last */
> > +#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip
> select */
> > +
> > +#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
> > +#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
> > +#define PL353_NAND_LAST_TRANSFER_LENGTH	4
> > +#define PL353_NAND_ECC_VALID_SHIFT	24
> > +#define PL353_NAND_ECC_VALID_MASK	0x40
> > +#define PL353_ECC_BITS_BYTEOFF_MASK	0x1FF
> > +#define PL353_ECC_BITS_BITOFF_MASK	0x7
> > +#define PL353_ECC_BIT_MASK		0xFFF
> > +#define PL353_TREA_MAX_VALUE		1
> > +#define PL353_MAX_ECC_CHUNKS		4
> > +#define PL353_MAX_ECC_BYTES		3
> > +
> > +struct pl353_nfc_op {
> > +	u32 cmnds[2];
> > +	u32 addrs;
> > +	u32 naddrs;
> > +	u16 addrs_56;	/* Address cycles 5 and 6 */
> > +	unsigned int data_instr_idx;
> > +	unsigned int rdy_timeout_ms;
> > +	unsigned int rdy_delay_ns;
> > +	const struct nand_op_instr *data_instr; };
> > +
> > +/**
> > + * struct pl353_nand_controller - Defines the NAND flash controller dr=
iver
> > + *				  instance
> > + * @controller:		NAND controller structure
> > + * @chip:		NAND chip information structure
> > + * @dev:		Parent device (used to print error messages)
> > + * @regs:		Virtual address of the NAND flash device
> > + * @dataphase_addrflags:Flags required for data phase transfers
> > + * @addr_cycles:	Address cycles
> > + * @mclk:		Memory controller clock
> > + * @mclk_rate:		Clock rate of the Memory controller
> > + * @buswidth:		Bus width 8 or 16
> > + */
> > +struct pl353_nand_controller {
> > +	struct nand_controller controller;
> > +	struct nand_chip chip;
> > +	struct device *dev;
> > +	void __iomem *regs;
> > +	u32 dataphase_addrflags;
> > +	u8 addr_cycles;
> > +	struct clk *mclk;
>=20
> The mclk attribute is only referenced in pl353_nand_probe. There is no ne=
ed to store it in this
> struct.
Ok. will remove it.
>=20
> > +	ulong mclk_rate;
> > +	u32 buswidth;
> > +};
> > +
> > +static inline struct pl353_nand_controller *
> > +			to_pl353_nand(struct nand_chip *chip) {
> > +	return container_of(chip, struct pl353_nand_controller, chip); }
> > +
> > +static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section=
,
> > +				     struct mtd_oob_region *oobregion) {
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +
> > +	if (section >=3D chip->ecc.steps)
> > +		return -ERANGE;
> > +
> > +	oobregion->offset =3D (section * chip->ecc.bytes);
> > +	oobregion->length =3D chip->ecc.bytes;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int sectio=
n,
> > +				      struct mtd_oob_region *oobregion) {
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +
> > +	if (section >=3D chip->ecc.steps)
> > +		return -ERANGE;
> > +
> > +	oobregion->offset =3D (section * chip->ecc.bytes) + 8;
> > +	oobregion->length =3D 8;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops =3D {
> > +	.ecc =3D pl353_ecc_ooblayout16_ecc,
> > +	.free =3D pl353_ecc_ooblayout16_free,
> > +};
> > +
> > +static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section=
,
> > +				     struct mtd_oob_region *oobregion) {
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +
> > +	if (section)
> > +		return -ERANGE;
> > +
> > +	oobregion->offset =3D (section * chip->ecc.bytes) + 52;
>=20
> You already know that `section =3D=3D 0` here. Is there an advantage of i=
ncluding the `(0 *
> something) +` here?
Ok. will update this.
>=20
> > +	oobregion->length =3D chip->ecc.bytes;
> > +
> > +	return 0;
> > +}
> > +
> > +static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int sectio=
n,
> > +				      struct mtd_oob_region *oobregion) {
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +
> > +	if (section)
> > +		return -ERANGE;
> > +
> > +	oobregion->offset =3D (section * chip->ecc.bytes) + 2;
>=20
> Dito.
Ok. will update this.
>=20
> > +	oobregion->length =3D 50;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops =3D {
> > +	.ecc =3D pl353_ecc_ooblayout64_ecc,
> > +	.free =3D pl353_ecc_ooblayout64_free,
> > +};
> > +
> > +/* Generic flash bbt decriptors */
> > +static u8 bbt_pattern[] =3D { 'B', 'b', 't', '0' }; static u8
> > +mirror_pattern[] =3D { '1', 't', 'b', 'B' };
> > +
> > +static struct nand_bbt_descr bbt_main_descr =3D {
> > +	.options =3D NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |
> NAND_BBT_WRITE
> > +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> > +	.offs =3D 4,
> > +	.len =3D 4,
> > +	.veroffs =3D 20,
> > +	.maxblocks =3D 4,
> > +	.pattern =3D bbt_pattern
> > +};
> > +
> > +static struct nand_bbt_descr bbt_mirror_descr =3D {
> > +	.options =3D NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |
> NAND_BBT_WRITE
> > +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> > +	.offs =3D 4,
> > +	.len =3D 4,
> > +	.veroffs =3D 20,
> > +	.maxblocks =3D 4,
> > +	.pattern =3D mirror_pattern
> > +};
> > +
> > +static void pl353_nfc_force_byte_access(struct nand_chip *chip,
> > +					bool force_8bit)
> > +{
> > +	int ret;
> > +	struct pl353_nand_controller *xnfc =3D
> > +		container_of(chip, struct pl353_nand_controller, chip);
> > +
> > +	if (xnfc->buswidth =3D=3D 8)
> > +		return;
> > +
> > +	if (force_8bit)
> > +		ret =3D pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
> > +	else
> > +		ret =3D pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> > +
> > +	if (ret)
> > +		dev_err(xnfc->dev, "Error in Buswidth\n"); }
> > +
> > +static inline int pl353_wait_for_dev_ready(struct nand_chip *chip) {
> > +	unsigned long timeout =3D jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> > +
> > +	while (!pl353_smc_get_nand_int_status_raw()) {
> > +		if (time_after_eq(jiffies, timeout)) {
> > +			pr_err("%s timed out\n", __func__);
> > +			return -ETIMEDOUT;
> > +		}
> > +		cond_resched();
> > +	}
> > +
> > +	pl353_smc_clr_nand_int();
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_read_data_op - read chip data into buffer
> > + * @chip:	Pointer to the NAND chip info structure
> > + * @in:		Pointer to the buffer to store read data
> > + * @len:	Number of bytes to read
> > + * @force_8bit:	Force 8-bit bus access
> > + * Return:	Always return zero
> > + */
> > +static void pl353_nand_read_data_op(struct nand_chip *chip, u8 *in,
> > +				    unsigned int len, bool force_8bit) {
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	int i;
> > +
> > +	if (force_8bit)
> > +		pl353_nfc_force_byte_access(chip, true);
> > +
> > +	if ((IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
> > +	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
>=20
> Do you really mean `||` here? It seems that when `in` and `len` are prope=
rly aligned, there is no
> way to force 8bit access with this implementation.
Ok. I will check it and update.
>=20
> > +		u32 *ptr =3D (u32 *)in;
> > +
> > +		len /=3D 4;
> > +		for (i =3D 0; i < len; i++)
> > +			ptr[i] =3D readl(xnfc->regs + xnfc->dataphase_addrflags);
> > +	} else {
> > +		for (i =3D 0; i < len; i++)
> > +			in[i] =3D readb(xnfc->regs + xnfc->dataphase_addrflags);
> > +	}
> > +
> > +	if (force_8bit)
> > +		pl353_nfc_force_byte_access(chip, false); }
> > +
> > +/**
> > + * pl353_nand_write_buf - write buffer to chip
> > + * @chip:	Pointer to the nand_chip structure
> > + * @buf:	Pointer to the buffer to store write data
> > + * @len:	Number of bytes to write
> > + * @force_8bit:	Force 8-bit bus access
> > + */
> > +static void pl353_nand_write_data_op(struct nand_chip *chip, const u8 =
*buf,
> > +				     int len, bool force_8bit)
> > +{
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	int i;
> > +
> > +	if (force_8bit)
> > +		pl353_nfc_force_byte_access(chip, true);
> > +
> > +	if ((IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
> > +	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
>=20
> Dito.
Ok. will update this.
>=20
> > +		u32 *ptr =3D (u32 *)buf;
> > +
> > +		len /=3D 4;
> > +		for (i =3D 0; i < len; i++)
> > +			writel(ptr[i], xnfc->regs + xnfc->dataphase_addrflags);
> > +	} else {
> > +		for (i =3D 0; i < len; i++)
> > +			writeb(buf[i], xnfc->regs + xnfc->dataphase_addrflags);
> > +	}
> > +
> > +	if (force_8bit)
> > +		pl353_nfc_force_byte_access(chip, false); }
> > +
> > +static inline int pl353_wait_for_ecc_done(void) {
> > +	unsigned long timeout =3D jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> > +
> > +	while (pl353_smc_ecc_is_busy()) {
> > +		if (time_after_eq(jiffies, timeout)) {
> > +			pr_err("%s timed out\n", __func__);
> > +			return -ETIMEDOUT;
> > +		}
> > +		cond_resched();
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> > + * @chip:	Pointer to the nand_chip structure
> > + * @data:	Pointer to the page data
> > + * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
> > + *
> > + * This function retrieves the Hardware ECC data from the controller
> > +and returns
> > + * ECC data back to the MTD subsystem.
> > + * It operates on a number of 512 byte blocks of NAND memory and can
> > +be
> > + * programmed to store the ECC codes after the data in memory. For
> > +writes,
> > + * the ECC is written to the spare area of the page. For reads, the
> > +result of
> > + * a block ECC check are made available to the device driver.
> > + *
> > + * -------------------------------------------------------------------=
-----
> > + * |               n * 512 blocks                  | extra  | ecc    |=
     |
> > + * |                                               | block  | codes  |=
     |
> > + *
> > +---------------------------------------------------------------------
> > +---
> > + *
> > + * The ECC calculation uses a simple Hamming code, using 1-bit
> > +correction 2-bit
> > + * detection. It starts when a valid read or write command with a 512
> > +byte
> > + * aligned address is detected on the memory interface.
> > + *
> > + * Return:	0 on success or error value on failure
> > + */
> > +static int pl353_nand_calculate_hwecc(struct nand_chip *chip,
> > +				      const u8 *data, u8 *ecc)
> > +{
> > +	u32 ecc_value;
> > +	u8 chunk, ecc_byte, ecc_status;
> > +
> > +	for (chunk =3D 0; chunk < PL353_MAX_ECC_CHUNKS; chunk++) {
> > +		/* Read ECC value for each block */
> > +		ecc_value =3D pl353_smc_get_ecc_val(chunk);
> > +		ecc_status =3D (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
> > +
> > +		/* ECC value valid */
> > +		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
> > +			for (ecc_byte =3D 0; ecc_byte < PL353_MAX_ECC_BYTES;
> > +			     ecc_byte++) {
> > +				/* Copy ECC bytes to MTD buffer */
> > +				*ecc =3D ~ecc_value & 0xFF;
> > +				ecc_value =3D ecc_value >> 8;
> > +				ecc++;
> > +			}
> > +		} else {
> > +			pr_warn("%s status failed\n", __func__);
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_correct_data - ECC correction function
> > + * @chip:	Pointer to the nand_chip structure
> > + * @buf:	Pointer to the page data
> > + * @read_ecc:	Pointer to the ECC value read from spare data area
> > + * @calc_ecc:	Pointer to the calculated ECC value
> > + *
> > + * This function corrects the ECC single bit errors & detects 2-bit er=
rors.
> > + *
> > + * Return:	0 if no ECC errors found
> > + *		1 if single bit error found and corrected.
> > + *		-1 if multiple uncorrectable ECC errors found.
> > + */
> > +static int pl353_nand_correct_data(struct nand_chip *chip, unsigned ch=
ar *buf,
> > +				   unsigned char *read_ecc,
> > +				   unsigned char *calc_ecc)
> > +{
> > +	unsigned char bit_addr;
> > +	unsigned int byte_addr;
> > +	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
> > +	unsigned short calc_ecc_lower, calc_ecc_upper;
> > +
> > +	read_ecc_lower =3D (read_ecc[0] | (read_ecc[1] << 8)) &
> > +			  PL353_ECC_BIT_MASK;
> > +	read_ecc_upper =3D ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
> > +			  PL353_ECC_BIT_MASK;
> > +
> > +	calc_ecc_lower =3D (calc_ecc[0] | (calc_ecc[1] << 8)) &
> > +			  PL353_ECC_BIT_MASK;
> > +	calc_ecc_upper =3D ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
> > +			  PL353_ECC_BIT_MASK;
> > +
> > +	ecc_odd =3D read_ecc_lower ^ calc_ecc_lower;
> > +	ecc_even =3D read_ecc_upper ^ calc_ecc_upper;
> > +
> > +	/* no error */
> > +	if (!ecc_odd && !ecc_even)
> > +		return 0;
> > +
> > +	if (ecc_odd =3D=3D (~ecc_even & PL353_ECC_BIT_MASK)) {
> > +		/* bits [11:3] of error code is byte offset */
> > +		byte_addr =3D (ecc_odd >> 3) & PL353_ECC_BITS_BYTEOFF_MASK;
> > +		/* bits [2:0] of error code is bit offset */
> > +		bit_addr =3D ecc_odd & PL353_ECC_BITS_BITOFF_MASK;
> > +		/* Toggling error bit */
> > +		buf[byte_addr] ^=3D (BIT(bit_addr));
> > +		return 1;
> > +	}
> > +
> > +	/* one error in parity */
> > +	if (hweight32(ecc_odd | ecc_even) =3D=3D 1)
> > +		return 1;
> > +
> > +	/* Uncorrectable error */
> > +	return -1;
> > +}
> > +
> > +static void pl353_prepare_cmd(struct nand_chip *chip,
> > +			      int page, int column, int start_cmd, int end_cmd,
> > +			      bool read)
> > +{
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	unsigned long cmd_phase_data =3D 0;
> > +	u32 end_cmd_valid =3D 0, cmdphase_addrflags;
> > +
> > +	end_cmd_valid =3D read ? 1 : 0;
> > +	cmdphase_addrflags =3D ((xnfc->addr_cycles
> > +			      << ADDR_CYCLES_SHIFT) |
> > +			      (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > +			      (COMMAND_PHASE) |
> > +			      (end_cmd << END_CMD_SHIFT) |
> > +			      (start_cmd << START_CMD_SHIFT));
> > +
> > +	/* Get the data phase address */
> > +	xnfc->dataphase_addrflags =3D ((0x0 << CLEAR_CS_SHIFT) |
> > +				(0 << END_CMD_VALID_SHIFT) |
> > +			  (DATA_PHASE) |
> > +			  (end_cmd << END_CMD_SHIFT) |
> > +			  (0x0 << ECC_LAST_SHIFT));
> > +
> > +	if (chip->options & NAND_BUSWIDTH_16)
> > +		column /=3D 2;
> > +
> > +	cmd_phase_data =3D column;
> > +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> > +		cmd_phase_data |=3D page << 16;
> > +
> > +		/* Another address cycle for devices > 128MiB */
> > +		if (chip->options & NAND_ROW_ADDR_3) {
> > +			writel_relaxed(cmd_phase_data,
> > +				       xnfc->regs + cmdphase_addrflags);
> > +			cmd_phase_data =3D (page >> 16);
> > +		}
> > +	} else {
> > +		cmd_phase_data |=3D page << 8;
> > +	}
> > +
> > +	writel_relaxed(cmd_phase_data, xnfc->regs + cmdphase_addrflags); }
> > +
> > +/**
> > + * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read f=
unction
> > + * @chip:	Pointer to the nand_chip structure
> > + * @chip:	Pointer to the nand_chip structure
> > + * @page:	Page number to read
> > + *
> > + * Return:	Always return zero
> > + */
> > +static int pl353_nand_read_oob(struct nand_chip *chip,
> > +			       int page)
> > +{
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	u8 *p;
> > +
> > +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> > +		return 0;
> > +
> > +	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_READ0,
> > +			  NAND_CMD_READSTART, 1);
> > +	if (pl353_wait_for_dev_ready(chip))
> > +		return -ETIMEDOUT;
> > +
> > +	p =3D chip->oob_poi;
> > +	pl353_nand_read_data_op(chip, p,
> > +				(mtd->oobsize -
> > +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				false);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write
> function
> > + * @chip:	Pointer to the nand_chip structure
> > + * @chip:	Pointer to the NAND chip info structure
> > + * @page:	Page number to write
> > + *
> > + * Return:	Zero on success and EIO on failure
> > + */
> > +static int pl353_nand_write_oob(struct nand_chip *chip,
> > +				int page)
> > +{
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	const u8 *buf =3D chip->oob_poi;
> > +
> > +	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_SEQIN,
> > +			  NAND_CMD_PAGEPROG, 0);
> > +
> > +	pl353_nand_write_data_op(chip, buf,
> > +				 (mtd->oobsize -
> > +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +	buf +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > +	xnfc->dataphase_addrflags |=3D (1 << END_CMD_VALID_SHIFT);
> > +	pl353_nand_write_data_op(chip, buf, PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				 false);
> > +	if (pl353_wait_for_dev_ready(chip))
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
> > + * @chip:		Pointer to the nand_chip structure
> > + * @buf:		Pointer to the data buffer
> > + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> > + * @page:		Page number to read
> > + *
> > + * Return:	Always return zero
> > + */
> > +static int pl353_nand_read_page_raw(struct nand_chip *chip,
> > +				    u8 *buf, int oob_required, int page) {
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	u8 *p;
> > +
> > +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
> > +			  NAND_CMD_READSTART, 1);
> > +	if (pl353_wait_for_dev_ready(chip))
> > +		return -ETIMEDOUT;
> > +
> > +	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
> > +	p =3D chip->oob_poi;
> > +	pl353_nand_read_data_op(chip, p,
> > +				(mtd->oobsize -
> > +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				false);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_write_page_raw - [Intern] raw page write function
> > + * @chip:		Pointer to the nand_chip structure
> > + * @buf:		Pointer to the data buffer
> > + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> > + * @page:		Page number to write
> > + *
> > + * Return:	Always return zero
> > + */
> > +static int pl353_nand_write_page_raw(struct nand_chip *chip,
> > +				     const u8 *buf, int oob_required,
> > +				     int page)
> > +{
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	u8 *p;
> > +
> > +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
> > +			  NAND_CMD_PAGEPROG, 0);
> > +	pl353_nand_write_data_op(chip, buf, mtd->writesize, false);
> > +	p =3D chip->oob_poi;
> > +	pl353_nand_write_data_op(chip, p,
> > +				 (mtd->oobsize -
> > +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > +	xnfc->dataphase_addrflags |=3D (1 << END_CMD_VALID_SHIFT);
> > +	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				 false);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nand_write_page_hwecc - Hardware ECC based page write function
> > + * @chip:		Pointer to the nand_chip structure
> > + * @buf:		Pointer to the data buffer
> > + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> > + * @page:		Page number to write
> > + *
> > + * This functions writes data and hardware generated ECC values in to =
the page.
> > + *
> > + * Return:	Always return zero
> > + */
> > +static int pl353_nand_write_page_hwecc(struct nand_chip *chip,
> > +				       const u8 *buf, int oob_required,
> > +				       int page)
> > +{
> > +	int eccsize =3D chip->ecc.size;
> > +	int eccsteps =3D chip->ecc.steps;
> > +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> > +	u8 *oob_ptr;
> > +	const u8 *p =3D buf;
> > +	u32 ret;
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +
> > +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
> > +			  NAND_CMD_PAGEPROG, 0);
> > +
> > +	for ( ; (eccsteps - 1); eccsteps--) {
> > +		pl353_nand_write_data_op(chip, p, eccsize, false);
> > +		p +=3D eccsize;
> > +	}
> > +
> > +	pl353_nand_write_data_op(chip, p,
> > +				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
> > +				 false);
> > +	p +=3D (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +
> > +	/* Set ECC Last bit to 1 */
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_ECC_LAST;
> > +	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				 false);
> > +
> > +	/* Wait till the ECC operation is complete or timeout */
> > +	ret =3D pl353_wait_for_ecc_done();
> > +	if (ret)
> > +		dev_err(xnfc->dev, "ECC Timeout\n");
> > +
> > +	p =3D buf;
> > +	ret =3D chip->ecc.calculate(chip, p, &ecc_calc[0]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Wait for ECC to be calculated and read the error values */
> > +	ret =3D mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> > +					 0, chip->ecc.total);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Clear ECC last bit */
> > +	xnfc->dataphase_addrflags &=3D ~PL353_NAND_ECC_LAST;
> > +
> > +	/* Write the spare area with ECC bytes */
> > +	oob_ptr =3D chip->oob_poi;
> > +	pl353_nand_write_data_op(chip, oob_ptr,
> > +				 (mtd->oobsize -
> > +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > +	xnfc->dataphase_addrflags |=3D (1 << END_CMD_VALID_SHIFT);
> > +	oob_ptr +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +	pl353_nand_write_data_op(chip, oob_ptr,
> PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				 false);
> > +	if (pl353_wait_for_dev_ready(chip))
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_read_page_hwecc - Hardware ECC based page read function
> > + * @chip:		Pointer to the nand_chip structure
> > + * @buf:		Pointer to the buffer to store read data
> > + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> > + * @page:		Page number to read
> > + *
> > + * This functions reads data and checks the data integrity by
> > +comparing
> > + * hardware generated ECC values and read ECC values from spare area.
> > + * There is a limitation in SMC controller, that we must set ECC LAST
> > +on
> > + * last data phase access, to tell ECC block not to expect any data fu=
rther.
> > + * Ex:  When number of ECC STEPS are 4, then till 3 we will write to
> > +flash
> > + * using SMC with HW ECC enabled. And for the last ECC STEP, we will
> > +subtract
> > + * 4bytes from page size, and will initiate a transfer. And the
> > +remaining 4 as
> > + * one more transfer with ECC_LAST bit set in NAND data phase
> > +register to
> > + * notify ECC block not to expect any more data. The last block
> > +should be align
> > + * with end of 512 byte block. Because of this limitation, we are not
> > +using
> > + * core routines.
> > + *
> > + * Return:	0 always and updates ECC operation status in to MTD structu=
re
> > + */
> > +static int pl353_nand_read_page_hwecc(struct nand_chip *chip,
> > +				      u8 *buf, int oob_required, int page) {
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	int i, stat, eccsize =3D chip->ecc.size;
> > +	int eccbytes =3D chip->ecc.bytes;
> > +	int eccsteps =3D chip->ecc.steps;
> > +	unsigned int max_bitflips =3D 0;
> > +	u8 *p =3D buf;
> > +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> > +	u8 *ecc =3D chip->ecc.code_buf;
> > +	u8 *oob_ptr;
> > +	u32 ret;
> > +
> > +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
> > +			  NAND_CMD_READSTART, 1);
> > +	if (pl353_wait_for_dev_ready(chip))
> > +		return -ETIMEDOUT;
> > +
> > +	for ( ; (eccsteps - 1); eccsteps--) {
> > +		pl353_nand_read_data_op(chip, p, eccsize, false);
> > +		p +=3D eccsize;
> > +	}
> > +
> > +	pl353_nand_read_data_op(chip, p,
> > +				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
> > +				false);
> > +	p +=3D (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +
> > +	/* Set ECC Last bit to 1 */
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_ECC_LAST;
> > +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				false);
> > +
> > +	/* Wait till the ECC operation is complete or timeout */
> > +	ret =3D pl353_wait_for_ecc_done();
> > +	if (ret)
> > +		dev_err(xnfc->dev, "ECC Timeout\n");
> > +
> > +	/* Read the calculated ECC value */
> > +	p =3D buf;
> > +	ret =3D chip->ecc.calculate(chip, p, &ecc_calc[0]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Clear ECC last bit */
> > +	xnfc->dataphase_addrflags &=3D ~PL353_NAND_ECC_LAST;
> > +
> > +	/* Read the stored ECC value */
> > +	oob_ptr =3D chip->oob_poi;
> > +	pl353_nand_read_data_op(chip, oob_ptr,
> > +				(mtd->oobsize -
> > +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> > +
> > +	/* de-assert chip select */
> > +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> > +	oob_ptr +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> > +	pl353_nand_read_data_op(chip, oob_ptr,
> PL353_NAND_LAST_TRANSFER_LENGTH,
> > +				false);
> > +
> > +	ret =3D mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
> > +					 chip->ecc.total);
> > +	if (ret)
> > +		return ret;
> > +
> > +	eccsteps =3D chip->ecc.steps;
> > +	p =3D buf;
> > +
> > +	/* Check ECC error for all blocks and correct if it is correctable */
> > +	for (i =3D 0 ; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsize)=
 {
> > +		stat =3D chip->ecc.correct(chip, p, &ecc[i], &ecc_calc[i]);
> > +		if (stat < 0) {
> > +			mtd->ecc_stats.failed++;
> > +		} else {
> > +			mtd->ecc_stats.corrected +=3D stat;
> > +			max_bitflips =3D max_t(unsigned int, max_bitflips, stat);
> > +		}
> > +	}
> > +
> > +	return max_bitflips;
> > +}
> > +
> > +/* NAND framework ->exec_op() hooks and related helpers */ static
> > +void pl353_nfc_parse_instructions(struct nand_chip *chip,
> > +					 const struct nand_subop *subop,
> > +					 struct pl353_nfc_op *nfc_op)
> > +{
> > +	const struct nand_op_instr *instr =3D NULL;
> > +	unsigned int op_id, offset;
> > +	int i;
> > +	const u8 *addrs;
> > +
> > +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> > +	for (op_id =3D 0; op_id < subop->ninstrs; op_id++) {
> > +		instr =3D &subop->instrs[op_id];
> > +
> > +		switch (instr->type) {
> > +		case NAND_OP_CMD_INSTR:
> > +			if (op_id)
> > +				nfc_op->cmnds[1] =3D instr->ctx.cmd.opcode;
> > +			else
> > +				nfc_op->cmnds[0] =3D instr->ctx.cmd.opcode;
> > +			break;
> > +
> > +		case NAND_OP_ADDR_INSTR:
> > +			offset =3D nand_subop_get_addr_start_off(subop, op_id);
> > +			nfc_op->naddrs =3D nand_subop_get_num_addr_cyc(subop,
> > +								     op_id);
> > +			addrs =3D &instr->ctx.addr.addrs[offset];
> > +			for (i =3D 0; i < min_t(unsigned int, 4, nfc_op->naddrs);
> > +			     i++)
> > +				nfc_op->addrs |=3D instr->ctx.addr.addrs[i] <<
> > +						 (8 * i);
>=20
> This code is unchanged compared to v14. That may or may not be correct.
> I've encountered further details regarding this matter:
>=20
> 1. The documentation of nand_subop_get_addr_start_off says:
>  * During driver development, one could be tempted to directly use the
>  * ->addr.addrs field of address instructions. This is wrong as address
>  * instructions might be split.
>  *
>  * Given an address instruction, returns the offset of the first cycle to=
 issue.
>=20
> Now the previous line of code does use addr.addrs without considering the=
 relevant offset. I
> argue that either the documentation or the code is wrong.
>=20
> 2. During my testing, I added a WARN_ON(offset) to the driver. Whenever o=
ffset is exactly 0,
> this potential bug cannot have any practical effects. In my tests, this w=
arning never triggered.
> So even if this is buggy, it does not have any practical effects for me.
>=20
> 3. I also looked into how other drivers use nand_subop_get_addr_start_off=
. Most drivers use it
> in a way that matches my reading of the documentation and consider indice=
s from
> addr_start_off to addr_start_off + num_addr_cyc exclusively. vf610_nfc.c =
is an exception to
> this rule and considers indices from addr_start_off to num_addr_cyc. If t=
his is a bug in
> pl353_nand.c, it likely also is a bug in vf610_nfc.c. Again, it can only =
have practical effects when
> the offset is > 0, which I never encountered.
I don't see any issues with this address cycles update.
May be because of above jfss2 issue, you are suspecting this calculation.
Hope the above update addresses this one.

>=20
> > +			if (nfc_op->naddrs >=3D 5)
> > +				nfc_op->addrs_56 =3D addrs[4];
> > +
> > +			if (nfc_op->naddrs >=3D 6)
> > +				nfc_op->addrs_56 |=3D (addrs[5] << 8);
> > +
> > +			break;
> > +
> > +		case NAND_OP_DATA_IN_INSTR:
> > +			nfc_op->data_instr =3D instr;
> > +			nfc_op->data_instr_idx =3D op_id;
> > +			break;
> > +
> > +		case NAND_OP_DATA_OUT_INSTR:
> > +			nfc_op->data_instr =3D instr;
> > +			nfc_op->data_instr_idx =3D op_id;
> > +			break;
>=20
> Would it make sense to merge the NAND_OP_DATA_IN_INSTR and
> NAND_OP_DATA_OUT_INSTR cases?
Yes, we can
I will update this
>=20
> > +		case NAND_OP_WAITRDY_INSTR:
> > +			nfc_op->rdy_timeout_ms =3D instr->ctx.waitrdy.timeout_ms;
> > +			nfc_op->rdy_delay_ns =3D instr->delay_ns;
> > +			break;
> > +		}
> > +	}
> > +}
> > +
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
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	unsigned long cmd_phase_data =3D 0, end_cmd_valid =3D 0;
> > +	unsigned long end_cmd;
> > +	unsigned int op_id, len;
> > +	bool reading;
> > +	u32 cmdphase_addrflags;
> > +
> > +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> > +	instr =3D nfc_op.data_instr;
> > +	op_id =3D nfc_op.data_instr_idx;
> > +	pl353_smc_clr_nand_int();
> > +
> > +	/* Get the command phase address */
> > +	if (nfc_op.cmnds[1] !=3D 0) {
> > +		if (nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN)
> > +			end_cmd_valid =3D 0;
> > +		else
> > +			end_cmd_valid =3D 1;
> > +	}
> > +
> > +	end_cmd =3D nfc_op.cmnds[1];
> > +
> > +	/*
> > +	 * The SMC defines two phases of commands when transferring data to o=
r
> > +	 * from NAND flash.
> > +	 * Command phase: Commands and optional address information are writt=
en
> > +	 * to the NAND flash.The command and address can be associated with
> > +	 * either a data phase operation to write to or read from the array,
> > +	 * or a status/ID register transfer.
> > +	 * Data phase: Data is either written to or read from the NAND flash.
> > +	 * This data can be either data transferred to or from the array,
> > +	 * or status/ID register information.
> > +	 */
> > +	cmdphase_addrflags =3D ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> > +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > +			 (COMMAND_PHASE) |
> > +			 (end_cmd << END_CMD_SHIFT) |
> > +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> > +
> > +	/* Get the data phase address */
> > +	end_cmd_valid =3D 0;
> > +
> > +	xnfc->dataphase_addrflags =3D ((0x0 << CLEAR_CS_SHIFT) |
> > +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> > +			  (DATA_PHASE) |
> > +			  (end_cmd << END_CMD_SHIFT) |
> > +			  (0x0 << ECC_LAST_SHIFT));
> > +
> > +	/* Command phase AXI Read & Write */
> > +	if (nfc_op.naddrs >=3D 5) {
> > +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> > +			cmd_phase_data =3D nfc_op.addrs;
> > +
> > +			/* Another address cycle for devices > 128MiB */
> > +			if (chip->options & NAND_ROW_ADDR_3) {
> > +				writel_relaxed(cmd_phase_data,
> > +					       xnfc->regs + cmdphase_addrflags);
> > +				cmd_phase_data =3D nfc_op.addrs_56;
> > +			}
> > +		}
> > +	}  else {
> > +		if (nfc_op.addrs !=3D -1) {
> > +			int column =3D nfc_op.addrs;
> > +
> > +			/*
> > +			 * Change read/write column, read id etc
> > +			 * Adjust columns for 16 bit bus width
> > +			 */
> > +			if ((chip->options & NAND_BUSWIDTH_16) &&
> > +			    (nfc_op.cmnds[0] =3D=3D NAND_CMD_READ0 ||
> > +				nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN ||
> > +				nfc_op.cmnds[0] =3D=3D NAND_CMD_RNDOUT ||
> > +				nfc_op.cmnds[0] =3D=3D NAND_CMD_RNDIN)) {
> > +				column >>=3D 1;
> > +			}
> > +			cmd_phase_data =3D column;
> > +		}
> > +	}
> > +
> > +	writel_relaxed(cmd_phase_data, xnfc->regs + cmdphase_addrflags);
> > +	if (!nfc_op.data_instr) {
> > +		if (nfc_op.rdy_timeout_ms) {
> > +			if (pl353_wait_for_dev_ready(chip))
> > +				return -ETIMEDOUT;
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	reading =3D (nfc_op.data_instr->type =3D=3D NAND_OP_DATA_IN_INSTR);
> > +	if (!reading) {
> > +		len =3D nand_subop_get_data_len(subop, op_id);
> > +		pl353_nand_write_data_op(chip, instr->ctx.data.buf.out,
> > +					 len, instr->ctx.data.force_8bit);
> > +		if (nfc_op.rdy_timeout_ms) {
> > +			if (pl353_wait_for_dev_ready(chip))
> > +				return -ETIMEDOUT;
> > +		}
> > +
> > +		ndelay(nfc_op.rdy_delay_ns);
> > +	} else {
> > +		len =3D nand_subop_get_data_len(subop, op_id);
> > +		ndelay(nfc_op.rdy_delay_ns);
> > +		if (nfc_op.rdy_timeout_ms) {
> > +			if (pl353_wait_for_dev_ready(chip))
> > +				return -ETIMEDOUT;
> > +		}
> > +
> > +		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len,
> > +					instr->ctx.data.force_8bit);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct nand_op_parser pl353_nfc_op_parser =3D NAND_OP_PAR=
SER
> > +	(NAND_OP_PARSER_PATTERN
> > +		(pl353_nand_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(pl353_nand_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> > +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(pl353_nand_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(pl353_nand_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> > +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> > +	NAND_OP_PARSER_PATTERN
> > +		(pl353_nand_exec_op_cmd,
> > +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> > +	);
> > +
> > +static int pl353_nfc_exec_op(struct nand_chip *chip,
> > +			     const struct nand_operation *op,
> > +			     bool check_only)
> > +{
> > +	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
> > +					      op, check_only);
> > +}
> > +
> > +/**
> > + * pl353_nand_ecc_init - Initialize the ecc information as per the ecc=
 mode
> > + * @mtd:	Pointer to the mtd_info structure
> > + * @ecc:	Pointer to ECC control structure
> > + * @ecc_mode:	ondie ecc status
> > + *
> > + * This function initializes the ecc block and functional pointers as
> > +per the
> > + * ecc mode
> > + *
> > + * Return:	0 on success or negative errno.
> > + */
> > +static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_c=
trl *ecc,
> > +			       int ecc_mode)
> > +{
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	int ret =3D 0;
> > +
> > +	ecc->read_oob =3D pl353_nand_read_oob;
> > +	ecc->write_oob =3D pl353_nand_write_oob;
> > +	if (ecc_mode =3D=3D NAND_ECC_ON_DIE) {
> > +		ecc->write_page_raw =3D pl353_nand_write_page_raw;
> > +		ecc->read_page_raw =3D pl353_nand_read_page_raw;
> > +
> > +		/*
> > +		 * On-Die ECC spare bytes offset 8 is used for ECC codes
> > +		 * Use the BBT pattern descriptors
> > +		 */
> > +		chip->bbt_td =3D &bbt_main_descr;
> > +		chip->bbt_md =3D &bbt_mirror_descr;
> > +		ret =3D pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
> > +		if (ret)
> > +			return ret;
> > +
> > +	} else {
> > +		ecc->mode =3D NAND_ECC_HW;
> > +
> > +		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
> > +		ecc->bytes =3D 3;
> > +		ecc->strength =3D 1;
> > +		ecc->calculate =3D pl353_nand_calculate_hwecc;
> > +		ecc->correct =3D pl353_nand_correct_data;
> > +		ecc->read_page =3D pl353_nand_read_page_hwecc;
> > +		ecc->size =3D PL353_NAND_ECC_SIZE;
> > +		ecc->read_page =3D pl353_nand_read_page_hwecc;
> > +		ecc->write_page =3D pl353_nand_write_page_hwecc;
> > +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> > +		switch (mtd->writesize) {
> > +		case SZ_512:
> > +		case SZ_1K:
> > +		case SZ_2K:
> > +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> > +			break;
> > +		default:
> > +			ecc->calculate =3D nand_calculate_ecc;
> > +			ecc->correct =3D nand_correct_data;
> > +			ecc->size =3D 256;
> > +			break;
> > +		}
> > +
> > +		if (mtd->oobsize =3D=3D 16) {
> > +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> > +		} else if (mtd->oobsize =3D=3D 64) {
> > +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
> > +		} else {
> > +			ret =3D -ENXIO;
> > +			dev_err(xnfc->dev, "Unsupported oob Layout\n");
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int pl353_nfc_setup_data_interface(struct nand_chip *chip, int =
csline,
> > +					  const struct nand_data_interface
> > +					  *conf)
> > +{
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	const struct nand_sdr_timings *sdr;
> > +	u32 timings[7], mckperiodps;
> > +
> > +	if (csline =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> > +		return 0;
> > +
> > +	sdr =3D nand_get_sdr_timings(conf);
> > +	if (IS_ERR(sdr))
> > +		return PTR_ERR(sdr);
> > +
> > +	/*
> > +	 * SDR timings are given in pico-seconds while NFC timings must be
> > +	 * expressed in NAND controller clock cycles.
> > +	 */
> > +	mckperiodps =3D NSEC_PER_SEC / xnfc->mclk_rate;
> > +	mckperiodps *=3D 1000;
> > +	if (sdr->tRC_min <=3D 20000)
> > +		/*
> > +		 * PL353 SMC needs one extra read cycle in SDR Mode 5
> > +		 * This is not written anywhere in the datasheet but
> > +		 * the results observed during testing.
> > +		 */
> > +		timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
> > +	else
> > +		timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> > +
> > +	timings[1] =3D DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> > +
> > +	/*
> > +	 * For all SDR modes, PL353 SMC needs tREA max value as 1,
> > +	 * Results observed during testing.
> > +	 */
> > +	timings[2] =3D PL353_TREA_MAX_VALUE;
> > +	timings[3] =3D DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> > +	timings[4] =3D DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> > +	timings[5] =3D DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> > +	timings[6] =3D DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> > +	pl353_smc_set_cycles(timings);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pl353_nand_attach_chip(struct nand_chip *chip) {
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	int ret;
> > +
> > +	if (chip->options & NAND_BUSWIDTH_16) {
> > +		ret =3D pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> > +		if (ret) {
> > +			dev_err(xnfc->dev, "Set BusWidth failed\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	if (mtd->writesize <=3D SZ_512)
> > +		xnfc->addr_cycles =3D 1;
> > +	else
> > +		xnfc->addr_cycles =3D 2;
> > +
> > +	if (chip->options & NAND_ROW_ADDR_3)
> > +		xnfc->addr_cycles +=3D 3;
> > +	else
> > +		xnfc->addr_cycles +=3D 2;
> > +
> > +	ret =3D pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
> > +	if (ret) {
> > +		dev_err(xnfc->dev, "ECC init failed\n");
> > +		return ret;
> > +	}
> > +
> > +	if (!mtd->name) {
> > +		/*
> > +		 * If the new bindings are used and the bootloader has not been
> > +		 * updated to pass a new mtdparts parameter on the cmdline, you
> > +		 * should define the following property in your NAND node, ie:
> > +		 *
> > +		 *	label =3D "pl353-nand";
> > +		 *
> > +		 * This way, mtd->name will be set by the core when
> > +		 * nand_set_flash_node() is called.
> > +		 */
> > +		mtd->name =3D devm_kasprintf(xnfc->dev, GFP_KERNEL,
> > +					   "%s", PL353_NAND_DRIVER_NAME);
> > +		if (!mtd->name) {
> > +			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct nand_controller_ops pl353_nand_controller_ops =3D =
{
> > +	.attach_chip =3D pl353_nand_attach_chip,
> > +	.exec_op =3D pl353_nfc_exec_op,
> > +	.setup_data_interface =3D pl353_nfc_setup_data_interface, };
> > +
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
> > +
> > +	xnfc =3D devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
> > +	if (!xnfc)
> > +		return -ENOMEM;
> > +
> > +	xnfc->dev =3D &pdev->dev;
> > +	nand_controller_init(&xnfc->controller);
> > +	xnfc->controller.ops =3D &pl353_nand_controller_ops;
> > +
> > +	/* Map physical address of NAND flash */
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	xnfc->regs =3D devm_ioremap_resource(xnfc->dev, res);
> > +	if (IS_ERR(xnfc->regs))
> > +		return PTR_ERR(xnfc->regs);
> > +
> > +	chip =3D &xnfc->chip;
> > +	chip->controller =3D &xnfc->controller;
> > +	mtd =3D nand_to_mtd(chip);
> > +	nand_set_controller_data(chip, xnfc);
> > +	mtd->priv =3D chip;
> > +	mtd->owner =3D THIS_MODULE;
> > +	nand_set_flash_node(chip, xnfc->dev->of_node);
> > +
> > +	np =3D of_get_next_parent(xnfc->dev->of_node);
> > +	xnfc->mclk =3D of_clk_get_by_name(np, "memclk");
> > +	if (IS_ERR(xnfc->mclk)) {
> > +		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
> > +		return PTR_ERR(xnfc->mclk);
> > +	}
> > +
> > +	xnfc->mclk_rate =3D clk_get_rate(xnfc->mclk);
> > +	dn =3D nand_get_flash_node(chip);
> > +	ret =3D of_property_read_u32(dn, "nand-bus-width", &val);
> > +	if (ret)
> > +		val =3D 8;
> > +
> > +	xnfc->buswidth =3D val;
> > +
> > +	/* Set the device option and flash width */
> > +	chip->options =3D NAND_BUSWIDTH_AUTO;
> > +	chip->bbt_options =3D NAND_BBT_USE_FLASH;
> > +	platform_set_drvdata(pdev, xnfc);
> > +	ret =3D nand_scan(chip, 1);
> > +	if (ret) {
> > +		dev_err(xnfc->dev, "could not scan the nand chip\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D mtd_device_register(mtd, NULL, 0);
> > +	if (ret) {
> > +		dev_err(xnfc->dev, "Failed to register mtd device: %d\n", ret);
> > +		nand_cleanup(chip);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * pl353_nand_remove - Remove method for the NAND driver
> > + * @pdev:	Pointer to the platform_device structure
> > + *
> > + * This function is called if the driver module is being unloaded. It
> > +frees all
> > + * resources allocated to the device.
> > + *
> > + * Return:	0 on success or error value on failure
> > + */
> > +static int pl353_nand_remove(struct platform_device *pdev) {
> > +	struct pl353_nand_controller *xnfc =3D platform_get_drvdata(pdev);
> > +	struct mtd_info *mtd =3D nand_to_mtd(&xnfc->chip);
> > +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> > +
> > +	/* Release resources, unregister device */
> > +	nand_release(chip);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Match table for device tree binding */ static const struct
> > +of_device_id pl353_nand_of_match[] =3D {
> > +	{ .compatible =3D "arm,pl353-nand-r2p1" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
> > +
> > +/*
> > + * pl353_nand_driver - This structure defines the NAND subsystem
> > +platform driver  */ static struct platform_driver pl353_nand_driver =
=3D
> > +{
> > +	.probe		=3D pl353_nand_probe,
> > +	.remove		=3D pl353_nand_remove,
> > +	.driver		=3D {
> > +		.name	=3D PL353_NAND_DRIVER_NAME,
> > +		.of_match_table =3D pl353_nand_of_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(pl353_nand_driver);
> > +
> > +MODULE_AUTHOR("Xilinx, Inc.");
> > +MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
> > +MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.17.1
>=20
> You've addressed a significant number of review comments. Most of the rem=
aining ones seem
> minor to me. If you add back the Kconfig and Makefile parts from v14, you=
 may add:
>=20
> Reviewed-by: Helmut Grohne <helmut.grohne@intenta.de>
>=20
> Despite the review I cannot confirm that it actually works.
Hope, the above update fixes your issue and thanks for the review.

Regards,
Naga Sureshkumar Relli
>=20
> Helmut
