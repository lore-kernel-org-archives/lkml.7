Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E137C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324E52080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="F/1xXH3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfFQIiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:38:46 -0400
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:41843
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbfFQIin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCU/ZLKeXtVGXtAGHOrixxGA8prNUQp4aerckvggoPY=;
 b=F/1xXH3ghZupQXlNQfJfeM5CxA2XHELl3xqs7tBcSZGdO2WiIDl6F36YdiUmRqNqdeeoyxBa9vur1aLn9ge2JJMMcnd31FUx/Fwm3PB3Nclc18l/JHGmWluouBfVYNsdeZD+Hy6xCaTzgadDuE1MDWuhfyubwMLQAbeysLBS3Hk=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4618.namprd02.prod.outlook.com (20.176.107.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Mon, 17 Jun 2019 08:38:32 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::6d49:62d5:cd7c:a8f]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::6d49:62d5:cd7c:a8f%6]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 08:38:32 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "helmut.grohne@intenta.de" <helmut.grohne@intenta.de>
CC:     "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [LINUX PATCH v15] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Topic: [LINUX PATCH v15] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Index: AQHVJOGEq3KzOUBWEUC/fOmrjWsc3Kafhjtg
Date:   Mon, 17 Jun 2019 08:38:32 +0000
Message-ID: <DM6PR02MB477932CBBB69F5F352D6172CAFEB0@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <20190617075049.3397-1-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <20190617075049.3397-1-naga.sureshkumar.relli@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43d27a4f-31b9-4046-f12a-08d6f2ff2e12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB4618;
x-ms-traffictypediagnostic: DM6PR02MB4618:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR02MB4618D95EC363CD8F94D107EFAFEB0@DM6PR02MB4618.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(13464003)(189003)(199004)(30864003)(86362001)(6506007)(52536014)(53936002)(6436002)(54906003)(25786009)(5660300002)(33656002)(2201001)(110136005)(2906002)(53546011)(8676002)(102836004)(81156014)(81166006)(74316002)(99286004)(4326008)(8936002)(107886003)(53946003)(6246003)(7696005)(55016002)(6306002)(76176011)(229853002)(2501003)(305945005)(76116006)(316002)(486006)(14444005)(5024004)(73956011)(66476007)(66556008)(7736002)(66946007)(64756008)(66446008)(9686003)(26005)(14454004)(478600001)(446003)(11346002)(6116002)(476003)(3846002)(68736007)(256004)(71200400001)(66066001)(186003)(966005)(71190400001)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4618;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AInq4Kui2HXbgQ5xclFfvLgWw3Os96/RSAylLWZgYnz2HQrSNvpl0ghT4drpV0aMgz2k5aMB09Ik6hLg0NAhAx1Z8nDZ7BhhsGeUX1jvsMRNMU1j1G9/BxRK2CQ0J9JpfE8FGbXv7fODZPZrnFnMp8II//E67ZQwZEEjAZI27Iam86VV2Enfhwa1zikPsAGpa647r4uIZK6o48bMyHLhYReEceAskDbjUEXi1BnBnkw7qq8LTXZlIeXdCWa6kBvBR5NWkZNp/wXlNK3U2wmahU1TF5Rtg+dn3Zygc2/sA4+kQOo70MZsgtZk+QWIm8XT2VrbCj9q5HB7Lpn3iXEiVfsi9VT/99FHRGuIaVNkKPMUJVeOVh996HecCMagtUGLAABB9gMfOfCGzX97h+e13FPBr5S62M1RrY4LtathCiw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d27a4f-31b9-4046-f12a-08d6f2ff2e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 08:38:32.1410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4618
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please ignore this patch.

Thanks,
Naga Sureshkumar Relli

> -----Original Message-----
> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> Sent: Monday, June 17, 2019 1:21 PM
> To: miquel.raynal@bootlin.com; helmut.grohne@intenta.de
> Cc: richard@nod.at; dwmw2@infradead.org; computersforpeace@gmail.com;
> marek.vasut@gmail.com; vigneshr@ti.com; linux-mtd@lists.infradead.org; li=
nux-
> kernel@vger.kernel.org; Michal Simek <michals@xilinx.com>; Naga Sureshkum=
ar Relli
> <nagasure@xilinx.com>
> Subject: [LINUX PATCH v15] mtd: rawnand: pl353: Add basic driver for arm =
pl353 smc
> nand interface
>=20
> Add driver for arm pl353 static memory controller nand interface with HW =
ECC support. This
> controller is used in Xilinx Zynq SoC for interfacing the NAND flash memo=
ry.
>=20
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> xilinx zynq TRM link:
> https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-=
TRM.pdf
>=20
> ARM pl353 smc TRM link:
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/DDI0380G_smc_pl=
350_series_
> r2p1_trm.pdf
>=20
> -> Tested Micron MT29F2G08ABAEAWP (On-die capable) and AMD/Spansion
> S34ML01G1.
> -> Tested both x8 and x16 bus-widths.
> -> Tested ubifs, mtd_debug tools and mtd-tests which exists in kernel as =
modules.
>=20
> SMC memory controller driver is at drivers/memory/pl353-smc.c
>=20
> Changes in v15:
>   All the comments given by Helmut Grohne to v14 are addressed in this se=
ries
>   as mentioned below.
>  - Removed below unused macros
>    PL353_NAND_CMD_PHASE, PL353_NAND_DATA_PHASE and
> PL353_NAND_ECC_CONFIG
>  - Used cond_resched() instead of cpu_relax() to eleminate the CPU spin f=
or
>    a full second
>  - changed the size of cmnds[4] to cmnds[2]
>  - Removed the unused variable end_cmd in struct pl353_nfc_op
>  - Added new variable u16 addrs_56, instead of u32 addr5 and u32 addr6
>  - Removed the unused variable cle_ale_delay_ns in struct pl353_nfc_op
>  - Completely changed the nand_offset calculation, taken new varibale
>    called dataphase_addrflags and eleminated the casting with __force
>    just used offset + flags
>  - in pl353_ecc_ooblayout64_free(), removed checking of section with
>    ecc.steps, as section is 0 here
>  - simplified the pl353_wait_for_dev_ready() and pl353_wait_for_ecc_done(=
)
>  - Updated the nfc_op->addrs calculation in pl353_nfc_parse_instructions(=
)
>  - Removed cond_delay(), instead used ndelay(), as it is sufficient
>  - in pl353_nand_exec_op(), instead of assigning end_cmd twice, just assi=
gn
>    it once by nfc_op.cmnds[1]
>  - changed if (reading) to else in pl353_nand_exec_op()
>  - Removed int err variable in pl353_nand_ecc_init(), instead just used
>    single variable ret
>  - Changed reading clock value by name rather than index in pl353_nand_pr=
obe()
>  - Instead of always calling clk_get_rate(), stored it in the probe to a
>    varaible and use it later
> Changes in v14:
>  - Removed legacy hooks as per Miquel comments Changes in v13:
>  - Rebased the driver to mtd/next
> Changes in v12:
>  - Rebased the driver on top of v4.19 nand tree
>  - Removed nand_scan_ident() and nand_scan_tail(), and added nand_control=
ler_ops
>    with ->attach_chip() and used nand_scan() instead.
>  - Renamed pl353_nand_info structure to pl353_nand_controller
>  - Renamed nand_base and nandaddr in pl353_nand_controller to 'regs' and =
'buf_addr'
>  - Added new API pl353_wait_for_ecc_done() to wait for ecc done and call =
it from
>    pl353_nand_write_page_hwecc() and pl353_nand_read_page_hwecc()
>  - Defined new macro for max ECC blocks
>  - Added return value check for ecc.calculate()
>  - Renamed pl353_nand_cmd_function() to pl353_nand_exec_op_cmd()
>  - Added x16 bus-width support
>  - The dependent driver pl353-smc is already reviewed and hence dropped t=
he
>    smc driver
> Changes in v11:
>  - Removed Documentation patch and added the required info in driver as
>    per Boris comments.
>  - Removed unwanted variables from pl353_nand_info as per Miquel comments
>  - Removed IO_ADDR_R/W.
>  - Replaced onhot() with hweight32()
>  - Defined macros for static values in function pl353_nand_correct_data()
>  - Removed all unnecessary delays
>  - Used nand_wait_ready() where ever is required
>  - Modifed the pl353_setup_data_interface() logic as per Miquel comments.
>  - Taken array instead of 7 values in pl353_setup_data_interface() and pa=
ss
>    it to smc driver.
>  - Added check to collect the return value of mtd_device_register().
> Changes in 10:
>  - Typos correction like nand to NAND and soc to SOC etc..
>  - Defined macros for the values in pl353_nand_calculate_hwecc()
>  - Modifed ecc_status from int to char in pl353_nand_calculate_hwecc()
>  - Changed the return type form int to bool to the function
>    onehot()
>  - Removed udelay(1000) in pl353_cmd_function, as it is not required
>  - Dropped ecc->hwctl =3D NULL in pl353_ecc_init()
>  - Added an error message in pl353_ecc_init(), when there is no matching
>    oobsize
>  - Changed the variable from xnand to xnfc
>  - Added logic to get mtd->name from DT, if it is specified in DT Changes=
 in v9:
>  - Addressed the below comments given by Miquel
>  - instead of using pl353_nand_write32, use directly writel_relaxed
>  - Fixed check patch warnings
>  - Renamed write_buf/read_buf to write_data_op/read_data_op
>  - use BIT macro instead of 1 << nr
>  - Use NAND_ROW_ADDR_3 flag
>  - Use nand_wait_ready()
>  - Removed swecc functions
>  - Use address cycles as per size, instead of reading it from Parameter p=
age
>  - Instead of writing too many patterns, use optional property Changes in=
 v8:
>  - Added exec_op() implementation
>  - Fixed the below v7 review comments
>  - removed mtd_info from pl353_nand_info struct
>  - Corrected ecc layout offsets
>  - Added on-die ecc support
> Changes in v7:
>  - Currently not implemented the memclk rate adjustments. I will
>    look into this later and once the basic driver is accepted.
>  - Fixed GPL licence ident
> Changes in v6:
>  - Fixed the checkpatch.pl reported warnings
>  - Using the address cycles information from the onfi param page
>    earlier it is hardcoded to 5 in driver Changes in v5:
>  - Configure the nand timing parameters as per the onfi spec Changes in v=
4:
>  - Updated the driver to sync with pl353_smc driver APIs Changes in v3:
>  - implemented the proper error codes
>  - further breakdown this patch to multiple sets
>  - added the controller and driver details to Documentation section
>  - updated the licenece to GPLv2
>  - reorganized the pl353_nand_ecc_init function Changes in v2:
>  - use "depends on" rather than "select" option in kconfig
>  - remove unused variable parts
> ---
>  drivers/mtd/nand/raw/pl353_nand.c | 1309 +++++++++++++++++++++++++++++
>  1 file changed, 1309 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
>=20
> diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl3=
53_nand.c
> new file mode 100644
> index 000000000000..2dc799865c2e
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/pl353_nand.c
> @@ -0,0 +1,1309 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 NAND flash controller driver
> + *
> + * Copyright (C) 2017 Xilinx, Inc
> + * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pl353-smc.h>
> +#include <linux/clk.h>
> +
> +#define PL353_NAND_DRIVER_NAME "pl353-nand"
> +
> +/* NAND flash driver defines */
> +#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
> +
> +/* AXI Address definitions */
> +#define START_CMD_SHIFT		3
> +#define END_CMD_SHIFT		11
> +#define END_CMD_VALID_SHIFT	20
> +#define ADDR_CYCLES_SHIFT	21
> +#define CLEAR_CS_SHIFT		21
> +#define ECC_LAST_SHIFT		10
> +#define COMMAND_PHASE		(0 << 19)
> +#define DATA_PHASE		BIT(19)
> +
> +#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
> +#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
> +
> +#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_LAST_TRANSFER_LENGTH	4
> +#define PL353_NAND_ECC_VALID_SHIFT	24
> +#define PL353_NAND_ECC_VALID_MASK	0x40
> +#define PL353_ECC_BITS_BYTEOFF_MASK	0x1FF
> +#define PL353_ECC_BITS_BITOFF_MASK	0x7
> +#define PL353_ECC_BIT_MASK		0xFFF
> +#define PL353_TREA_MAX_VALUE		1
> +#define PL353_MAX_ECC_CHUNKS		4
> +#define PL353_MAX_ECC_BYTES		3
> +
> +struct pl353_nfc_op {
> +	u32 cmnds[2];
> +	u32 addrs;
> +	u32 naddrs;
> +	u16 addrs_56;	/* Address cycles 5 and 6 */
> +	unsigned int data_instr_idx;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	const struct nand_op_instr *data_instr; };
> +
> +/**
> + * struct pl353_nand_controller - Defines the NAND flash controller driv=
er
> + *				  instance
> + * @controller:		NAND controller structure
> + * @chip:		NAND chip information structure
> + * @dev:		Parent device (used to print error messages)
> + * @regs:		Virtual address of the NAND flash device
> + * @dataphase_addrflags:Flags required for data phase transfers
> + * @addr_cycles:	Address cycles
> + * @mclk:		Memory controller clock
> + * @mclk_rate:		Clock rate of the Memory controller
> + * @buswidth:		Bus width 8 or 16
> + */
> +struct pl353_nand_controller {
> +	struct nand_controller controller;
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *regs;
> +	u32 dataphase_addrflags;
> +	u8 addr_cycles;
> +	struct clk *mclk;
> +	ulong mclk_rate;
> +	u32 buswidth;
> +};
> +
> +static inline struct pl353_nand_controller *
> +			to_pl353_nand(struct nand_chip *chip) {
> +	return container_of(chip, struct pl353_nand_controller, chip); }
> +
> +static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section >=3D chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes);
> +	oobregion->length =3D chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section >=3D chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes) + 8;
> +	oobregion->length =3D 8;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops =3D {
> +	.ecc =3D pl353_ecc_ooblayout16_ecc,
> +	.free =3D pl353_ecc_ooblayout16_free,
> +};
> +
> +static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +//	if (section >=3D chip->ecc.steps)
> +//		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes) + 52;
> +	oobregion->length =3D chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion) {
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->offset =3D (section * chip->ecc.bytes) + 2;
> +	oobregion->length =3D 50;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops =3D {
> +	.ecc =3D pl353_ecc_ooblayout64_ecc,
> +	.free =3D pl353_ecc_ooblayout64_free,
> +};
> +
> +/* Generic flash bbt decriptors */
> +static u8 bbt_pattern[] =3D { 'B', 'b', 't', '0' }; static u8
> +mirror_pattern[] =3D { '1', 't', 'b', 'B' };
> +
> +static struct nand_bbt_descr bbt_main_descr =3D {
> +	.options =3D NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |
> NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs =3D 4,
> +	.len =3D 4,
> +	.veroffs =3D 20,
> +	.maxblocks =3D 4,
> +	.pattern =3D bbt_pattern
> +};
> +
> +static struct nand_bbt_descr bbt_mirror_descr =3D {
> +	.options =3D NAND_BBT_LASTBLOCK | NAND_BBT_CREATE |
> NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs =3D 4,
> +	.len =3D 4,
> +	.veroffs =3D 20,
> +	.maxblocks =3D 4,
> +	.pattern =3D mirror_pattern
> +};
> +
> +static void pl353_nfc_force_byte_access(struct nand_chip *chip,
> +					bool force_8bit)
> +{
> +	int ret;
> +	struct pl353_nand_controller *xnfc =3D
> +		container_of(chip, struct pl353_nand_controller, chip);
> +
> +	if (xnfc->buswidth =3D=3D 8)
> +		return;
> +
> +	if (force_8bit)
> +		ret =3D pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
> +	else
> +		ret =3D pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +
> +	if (ret)
> +		dev_err(xnfc->dev, "Error in Buswidth\n"); }
> +
> +static inline int pl353_wait_for_dev_ready(struct nand_chip *chip) {
> +	unsigned long timeout =3D jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +
> +	while (!pl353_smc_get_nand_int_status_raw()) {
> +		if (time_after_eq(jiffies, timeout)) {
> +			pr_err("%s timed out\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +		cond_resched();
> +	}
> +
> +	pl353_smc_clr_nand_int();
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_data_op - read chip data into buffer
> + * @chip:	Pointer to the NAND chip info structure
> + * @in:		Pointer to the buffer to store read data
> + * @len:	Number of bytes to read
> + * @force_8bit:	Force 8-bit bus access
> + * Return:	Always return zero
> + */
> +static void pl353_nand_read_data_op(struct nand_chip *chip, u8 *in,
> +				    unsigned int len, bool force_8bit) {
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	int i;
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, true);
> +
> +	if ((IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
> +	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
> +		u32 *ptr =3D (u32 *)in;
> +
> +		len /=3D 4;
> +		for (i =3D 0; i < len; i++)
> +			ptr[i] =3D readl(xnfc->regs + xnfc->dataphase_addrflags);
> +	} else {
> +		for (i =3D 0; i < len; i++)
> +			in[i] =3D readb(xnfc->regs + xnfc->dataphase_addrflags);
> +	}
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, false); }
> +
> +/**
> + * pl353_nand_write_buf - write buffer to chip
> + * @chip:	Pointer to the nand_chip structure
> + * @buf:	Pointer to the buffer to store write data
> + * @len:	Number of bytes to write
> + * @force_8bit:	Force 8-bit bus access
> + */
> +static void pl353_nand_write_data_op(struct nand_chip *chip, const u8 *b=
uf,
> +				     int len, bool force_8bit)
> +{
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	int i;
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, true);
> +
> +	if ((IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
> +	     IS_ALIGNED(len, sizeof(uint32_t))) || !force_8bit) {
> +		u32 *ptr =3D (u32 *)buf;
> +
> +		len /=3D 4;
> +		for (i =3D 0; i < len; i++)
> +			writel(ptr[i], xnfc->regs + xnfc->dataphase_addrflags);
> +	} else {
> +		for (i =3D 0; i < len; i++)
> +			writeb(buf[i], xnfc->regs + xnfc->dataphase_addrflags);
> +	}
> +
> +	if (force_8bit)
> +		pl353_nfc_force_byte_access(chip, false); }
> +
> +static inline int pl353_wait_for_ecc_done(void) {
> +	unsigned long timeout =3D jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> +
> +	while (pl353_smc_ecc_is_busy()) {
> +		if (time_after_eq(jiffies, timeout)) {
> +			pr_err("%s timed out\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> + * @chip:	Pointer to the nand_chip structure
> + * @data:	Pointer to the page data
> + * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
> + *
> + * This function retrieves the Hardware ECC data from the controller
> +and returns
> + * ECC data back to the MTD subsystem.
> + * It operates on a number of 512 byte blocks of NAND memory and can be
> + * programmed to store the ECC codes after the data in memory. For
> +writes,
> + * the ECC is written to the spare area of the page. For reads, the
> +result of
> + * a block ECC check are made available to the device driver.
> + *
> + * ---------------------------------------------------------------------=
---
> + * |               n * 512 blocks                  | extra  | ecc    |  =
   |
> + * |                                               | block  | codes  |  =
   |
> + *
> +-----------------------------------------------------------------------
> +-
> + *
> + * The ECC calculation uses a simple Hamming code, using 1-bit
> +correction 2-bit
> + * detection. It starts when a valid read or write command with a 512
> +byte
> + * aligned address is detected on the memory interface.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_calculate_hwecc(struct nand_chip *chip,
> +				      const u8 *data, u8 *ecc)
> +{
> +	u32 ecc_value;
> +	u8 chunk, ecc_byte, ecc_status;
> +
> +	for (chunk =3D 0; chunk < PL353_MAX_ECC_CHUNKS; chunk++) {
> +		/* Read ECC value for each block */
> +		ecc_value =3D pl353_smc_get_ecc_val(chunk);
> +		ecc_status =3D (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
> +
> +		/* ECC value valid */
> +		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
> +			for (ecc_byte =3D 0; ecc_byte < PL353_MAX_ECC_BYTES;
> +			     ecc_byte++) {
> +				/* Copy ECC bytes to MTD buffer */
> +				*ecc =3D ~ecc_value & 0xFF;
> +				ecc_value =3D ecc_value >> 8;
> +				ecc++;
> +			}
> +		} else {
> +			pr_warn("%s status failed\n", __func__);
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_correct_data - ECC correction function
> + * @chip:	Pointer to the nand_chip structure
> + * @buf:	Pointer to the page data
> + * @read_ecc:	Pointer to the ECC value read from spare data area
> + * @calc_ecc:	Pointer to the calculated ECC value
> + *
> + * This function corrects the ECC single bit errors & detects 2-bit erro=
rs.
> + *
> + * Return:	0 if no ECC errors found
> + *		1 if single bit error found and corrected.
> + *		-1 if multiple uncorrectable ECC errors found.
> + */
> +static int pl353_nand_correct_data(struct nand_chip *chip, unsigned char=
 *buf,
> +				   unsigned char *read_ecc,
> +				   unsigned char *calc_ecc)
> +{
> +	unsigned char bit_addr;
> +	unsigned int byte_addr;
> +	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
> +	unsigned short calc_ecc_lower, calc_ecc_upper;
> +
> +	read_ecc_lower =3D (read_ecc[0] | (read_ecc[1] << 8)) &
> +			  PL353_ECC_BIT_MASK;
> +	read_ecc_upper =3D ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) &
> +			  PL353_ECC_BIT_MASK;
> +
> +	calc_ecc_lower =3D (calc_ecc[0] | (calc_ecc[1] << 8)) &
> +			  PL353_ECC_BIT_MASK;
> +	calc_ecc_upper =3D ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) &
> +			  PL353_ECC_BIT_MASK;
> +
> +	ecc_odd =3D read_ecc_lower ^ calc_ecc_lower;
> +	ecc_even =3D read_ecc_upper ^ calc_ecc_upper;
> +
> +	/* no error */
> +	if (!ecc_odd && !ecc_even)
> +		return 0;
> +
> +	if (ecc_odd =3D=3D (~ecc_even & PL353_ECC_BIT_MASK)) {
> +		/* bits [11:3] of error code is byte offset */
> +		byte_addr =3D (ecc_odd >> 3) & PL353_ECC_BITS_BYTEOFF_MASK;
> +		/* bits [2:0] of error code is bit offset */
> +		bit_addr =3D ecc_odd & PL353_ECC_BITS_BITOFF_MASK;
> +		/* Toggling error bit */
> +		buf[byte_addr] ^=3D (BIT(bit_addr));
> +		return 1;
> +	}
> +
> +	/* one error in parity */
> +	if (hweight32(ecc_odd | ecc_even) =3D=3D 1)
> +		return 1;
> +
> +	/* Uncorrectable error */
> +	return -1;
> +}
> +
> +static void pl353_prepare_cmd(struct nand_chip *chip,
> +			      int page, int column, int start_cmd, int end_cmd,
> +			      bool read)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	unsigned long cmd_phase_data =3D 0;
> +	u32 end_cmd_valid =3D 0, cmdphase_addrflags;
> +
> +	end_cmd_valid =3D read ? 1 : 0;
> +	cmdphase_addrflags =3D ((xnfc->addr_cycles
> +			      << ADDR_CYCLES_SHIFT) |
> +			      (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			      (COMMAND_PHASE) |
> +			      (end_cmd << END_CMD_SHIFT) |
> +			      (start_cmd << START_CMD_SHIFT));
> +
> +	/* Get the data phase address */
> +	xnfc->dataphase_addrflags =3D ((0x0 << CLEAR_CS_SHIFT) |
> +				(0 << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		column /=3D 2;
> +
> +	cmd_phase_data =3D column;
> +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +		cmd_phase_data |=3D page << 16;
> +
> +		/* Another address cycle for devices > 128MiB */
> +		if (chip->options & NAND_ROW_ADDR_3) {
> +			writel_relaxed(cmd_phase_data,
> +				       xnfc->regs + cmdphase_addrflags);
> +			cmd_phase_data =3D (page >> 16);
> +		}
> +	} else {
> +		cmd_phase_data |=3D page << 8;
> +	}
> +
> +	writel_relaxed(cmd_phase_data, xnfc->regs + cmdphase_addrflags); }
> +
> +/**
> + * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read fun=
ction
> + * @chip:	Pointer to the nand_chip structure
> + * @chip:	Pointer to the nand_chip structure
> + * @page:	Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_oob(struct nand_chip *chip,
> +			       int page)
> +{
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u8 *p;
> +
> +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> +		return 0;
> +
> +	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	p =3D chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write f=
unction
> + * @chip:	Pointer to the nand_chip structure
> + * @chip:	Pointer to the NAND chip info structure
> + * @page:	Page number to write
> + *
> + * Return:	Zero on success and EIO on failure
> + */
> +static int pl353_nand_write_oob(struct nand_chip *chip,
> +				int page)
> +{
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	const u8 *buf =3D chip->oob_poi;
> +
> +	pl353_prepare_cmd(chip, page, mtd->writesize, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +
> +	pl353_nand_write_data_op(chip, buf,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	buf +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> +	xnfc->dataphase_addrflags |=3D (1 << END_CMD_VALID_SHIFT);
> +	pl353_nand_write_data_op(chip, buf, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
> + * @chip:		Pointer to the nand_chip structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_page_raw(struct nand_chip *chip,
> +				    u8 *buf, int oob_required, int page) {
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u8 *p;
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	pl353_nand_read_data_op(chip, buf, mtd->writesize, false);
> +	p =3D chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_page_raw - [Intern] raw page write function
> + * @chip:		Pointer to the nand_chip structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_raw(struct nand_chip *chip,
> +				     const u8 *buf, int oob_required,
> +				     int page)
> +{
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u8 *p;
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +	pl353_nand_write_data_op(chip, buf, mtd->writesize, false);
> +	p =3D chip->oob_poi;
> +	pl353_nand_write_data_op(chip, p,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +	p +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> +	xnfc->dataphase_addrflags |=3D (1 << END_CMD_VALID_SHIFT);
> +	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +
> +	return 0;
> +}
> +
> +/**
> + * nand_write_page_hwecc - Hardware ECC based page write function
> + * @chip:		Pointer to the nand_chip structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * This functions writes data and hardware generated ECC values in to th=
e page.
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_hwecc(struct nand_chip *chip,
> +				       const u8 *buf, int oob_required,
> +				       int page)
> +{
> +	int eccsize =3D chip->ecc.size;
> +	int eccsteps =3D chip->ecc.steps;
> +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> +	u8 *oob_ptr;
> +	const u8 *p =3D buf;
> +	u32 ret;
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_write_data_op(chip, p, eccsize, false);
> +		p +=3D eccsize;
> +	}
> +
> +	pl353_nand_write_data_op(chip, p,
> +				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
> +				 false);
> +	p +=3D (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_ECC_LAST;
> +	pl353_nand_write_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +
> +	/* Wait till the ECC operation is complete or timeout */
> +	ret =3D pl353_wait_for_ecc_done();
> +	if (ret)
> +		dev_err(xnfc->dev, "ECC Timeout\n");
> +
> +	p =3D buf;
> +	ret =3D chip->ecc.calculate(chip, p, &ecc_calc[0]);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for ECC to be calculated and read the error values */
> +	ret =3D mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +					 0, chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear ECC last bit */
> +	xnfc->dataphase_addrflags &=3D ~PL353_NAND_ECC_LAST;
> +
> +	/* Write the spare area with ECC bytes */
> +	oob_ptr =3D chip->oob_poi;
> +	pl353_nand_write_data_op(chip, oob_ptr,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> +	xnfc->dataphase_addrflags |=3D (1 << END_CMD_VALID_SHIFT);
> +	oob_ptr +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_write_data_op(chip, oob_ptr,
> PL353_NAND_LAST_TRANSFER_LENGTH,
> +				 false);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_hwecc - Hardware ECC based page read function
> + * @chip:		Pointer to the nand_chip structure
> + * @buf:		Pointer to the buffer to store read data
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * This functions reads data and checks the data integrity by comparing
> + * hardware generated ECC values and read ECC values from spare area.
> + * There is a limitation in SMC controller, that we must set ECC LAST
> +on
> + * last data phase access, to tell ECC block not to expect any data furt=
her.
> + * Ex:  When number of ECC STEPS are 4, then till 3 we will write to
> +flash
> + * using SMC with HW ECC enabled. And for the last ECC STEP, we will
> +subtract
> + * 4bytes from page size, and will initiate a transfer. And the
> +remaining 4 as
> + * one more transfer with ECC_LAST bit set in NAND data phase register
> +to
> + * notify ECC block not to expect any more data. The last block should
> +be align
> + * with end of 512 byte block. Because of this limitation, we are not
> +using
> + * core routines.
> + *
> + * Return:	0 always and updates ECC operation status in to MTD structure
> + */
> +static int pl353_nand_read_page_hwecc(struct nand_chip *chip,
> +				      u8 *buf, int oob_required, int page) {
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	int i, stat, eccsize =3D chip->ecc.size;
> +	int eccbytes =3D chip->ecc.bytes;
> +	int eccsteps =3D chip->ecc.steps;
> +	unsigned int max_bitflips =3D 0;
> +	u8 *p =3D buf;
> +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> +	u8 *ecc =3D chip->ecc.code_buf;
> +	u8 *oob_ptr;
> +	u32 ret;
> +
> +	pl353_prepare_cmd(chip, page, 0, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	if (pl353_wait_for_dev_ready(chip))
> +		return -ETIMEDOUT;
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_read_data_op(chip, p, eccsize, false);
> +		p +=3D eccsize;
> +	}
> +
> +	pl353_nand_read_data_op(chip, p,
> +				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH),
> +				false);
> +	p +=3D (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_ECC_LAST;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	/* Wait till the ECC operation is complete or timeout */
> +	ret =3D pl353_wait_for_ecc_done();
> +	if (ret)
> +		dev_err(xnfc->dev, "ECC Timeout\n");
> +
> +	/* Read the calculated ECC value */
> +	p =3D buf;
> +	ret =3D chip->ecc.calculate(chip, p, &ecc_calc[0]);
> +	if (ret)
> +		return ret;
> +
> +	/* Clear ECC last bit */
> +	xnfc->dataphase_addrflags &=3D ~PL353_NAND_ECC_LAST;
> +
> +	/* Read the stored ECC value */
> +	oob_ptr =3D chip->oob_poi;
> +	pl353_nand_read_data_op(chip, oob_ptr,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH), false);
> +
> +	/* de-assert chip select */
> +	xnfc->dataphase_addrflags |=3D PL353_NAND_CLEAR_CS;
> +	oob_ptr +=3D (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_read_data_op(chip, oob_ptr,
> PL353_NAND_LAST_TRANSFER_LENGTH,
> +				false);
> +
> +	ret =3D mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
> +					 chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	eccsteps =3D chip->ecc.steps;
> +	p =3D buf;
> +
> +	/* Check ECC error for all blocks and correct if it is correctable */
> +	for (i =3D 0 ; eccsteps; eccsteps--, i +=3D eccbytes, p +=3D eccsize) {
> +		stat =3D chip->ecc.correct(chip, p, &ecc[i], &ecc_calc[i]);
> +		if (stat < 0) {
> +			mtd->ecc_stats.failed++;
> +		} else {
> +			mtd->ecc_stats.corrected +=3D stat;
> +			max_bitflips =3D max_t(unsigned int, max_bitflips, stat);
> +		}
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +/* NAND framework ->exec_op() hooks and related helpers */ static void
> +pl353_nfc_parse_instructions(struct nand_chip *chip,
> +					 const struct nand_subop *subop,
> +					 struct pl353_nfc_op *nfc_op)
> +{
> +	const struct nand_op_instr *instr =3D NULL;
> +	unsigned int op_id, offset;
> +	int i;
> +	const u8 *addrs;
> +
> +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> +	for (op_id =3D 0; op_id < subop->ninstrs; op_id++) {
> +		instr =3D &subop->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			if (op_id)
> +				nfc_op->cmnds[1] =3D instr->ctx.cmd.opcode;
> +			else
> +				nfc_op->cmnds[0] =3D instr->ctx.cmd.opcode;
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			offset =3D nand_subop_get_addr_start_off(subop, op_id);
> +			nfc_op->naddrs =3D nand_subop_get_num_addr_cyc(subop,
> +								     op_id);
> +			addrs =3D &instr->ctx.addr.addrs[offset];
> +			for (i =3D 0; i < min_t(unsigned int, 4, nfc_op->naddrs);
> +			     i++)
> +				nfc_op->addrs |=3D instr->ctx.addr.addrs[i] <<
> +						 (8 * i);
> +
> +			if (nfc_op->naddrs >=3D 5)
> +				nfc_op->addrs_56 =3D addrs[4];
> +
> +			if (nfc_op->naddrs >=3D 6)
> +				nfc_op->addrs_56 |=3D (addrs[5] << 8);
> +
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			nfc_op->data_instr =3D instr;
> +			nfc_op->data_instr_idx =3D op_id;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			nfc_op->data_instr =3D instr;
> +			nfc_op->data_instr_idx =3D op_id;
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			nfc_op->rdy_timeout_ms =3D instr->ctx.waitrdy.timeout_ms;
> +			nfc_op->rdy_delay_ns =3D instr->delay_ns;
> +			break;
> +		}
> +	}
> +}
> +
> +/**
> + * pl353_nand_exec_op_cmd - Send command to NAND device
> + * @chip:	Pointer to the NAND chip info structure
> + * @subop:	Pointer to array of instructions
> + * Return:	Always return zero
> + */
> +static int pl353_nand_exec_op_cmd(struct nand_chip *chip,
> +				  const struct nand_subop *subop)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	const struct nand_op_instr *instr;
> +	struct pl353_nfc_op nfc_op =3D {};
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	unsigned long cmd_phase_data =3D 0, end_cmd_valid =3D 0;
> +	unsigned long end_cmd;
> +	unsigned int op_id, len;
> +	bool reading;
> +	u32 cmdphase_addrflags;
> +
> +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> +	instr =3D nfc_op.data_instr;
> +	op_id =3D nfc_op.data_instr_idx;
> +	pl353_smc_clr_nand_int();
> +
> +	/* Get the command phase address */
> +	if (nfc_op.cmnds[1] !=3D 0) {
> +		if (nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN)
> +			end_cmd_valid =3D 0;
> +		else
> +			end_cmd_valid =3D 1;
> +	}
> +
> +	end_cmd =3D nfc_op.cmnds[1];
> +
> +	/*
> +	 * The SMC defines two phases of commands when transferring data to or
> +	 * from NAND flash.
> +	 * Command phase: Commands and optional address information are written
> +	 * to the NAND flash.The command and address can be associated with
> +	 * either a data phase operation to write to or read from the array,
> +	 * or a status/ID register transfer.
> +	 * Data phase: Data is either written to or read from the NAND flash.
> +	 * This data can be either data transferred to or from the array,
> +	 * or status/ID register information.
> +	 */
> +	cmdphase_addrflags =3D ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> +
> +	/* Get the data phase address */
> +	end_cmd_valid =3D 0;
> +
> +	xnfc->dataphase_addrflags =3D ((0x0 << CLEAR_CS_SHIFT) |
> +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +
> +	/* Command phase AXI Read & Write */
> +	if (nfc_op.naddrs >=3D 5) {
> +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +			cmd_phase_data =3D nfc_op.addrs;
> +
> +			/* Another address cycle for devices > 128MiB */
> +			if (chip->options & NAND_ROW_ADDR_3) {
> +				writel_relaxed(cmd_phase_data,
> +					       xnfc->regs + cmdphase_addrflags);
> +				cmd_phase_data =3D nfc_op.addrs_56;
> +			}
> +		}
> +	}  else {
> +		if (nfc_op.addrs !=3D -1) {
> +			int column =3D nfc_op.addrs;
> +
> +			/*
> +			 * Change read/write column, read id etc
> +			 * Adjust columns for 16 bit bus width
> +			 */
> +			if ((chip->options & NAND_BUSWIDTH_16) &&
> +			    (nfc_op.cmnds[0] =3D=3D NAND_CMD_READ0 ||
> +				nfc_op.cmnds[0] =3D=3D NAND_CMD_SEQIN ||
> +				nfc_op.cmnds[0] =3D=3D NAND_CMD_RNDOUT ||
> +				nfc_op.cmnds[0] =3D=3D NAND_CMD_RNDIN)) {
> +				column >>=3D 1;
> +			}
> +			cmd_phase_data =3D column;
> +		}
> +	}
> +
> +	writel_relaxed(cmd_phase_data, xnfc->regs + cmdphase_addrflags);
> +	if (!nfc_op.data_instr) {
> +		if (nfc_op.rdy_timeout_ms) {
> +			if (pl353_wait_for_dev_ready(chip))
> +				return -ETIMEDOUT;
> +		}
> +
> +		return 0;
> +	}
> +
> +	reading =3D (nfc_op.data_instr->type =3D=3D NAND_OP_DATA_IN_INSTR);
> +	if (!reading) {
> +		len =3D nand_subop_get_data_len(subop, op_id);
> +		pl353_nand_write_data_op(chip, instr->ctx.data.buf.out,
> +					 len, instr->ctx.data.force_8bit);
> +		if (nfc_op.rdy_timeout_ms) {
> +			if (pl353_wait_for_dev_ready(chip))
> +				return -ETIMEDOUT;
> +		}
> +
> +		ndelay(nfc_op.rdy_delay_ns);
> +	} else {
> +		len =3D nand_subop_get_data_len(subop, op_id);
> +		ndelay(nfc_op.rdy_delay_ns);
> +		if (nfc_op.rdy_timeout_ms) {
> +			if (pl353_wait_for_dev_ready(chip))
> +				return -ETIMEDOUT;
> +		}
> +
> +		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len,
> +					instr->ctx.data.force_8bit);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser pl353_nfc_op_parser =3D NAND_OP_PARSE=
R
> +	(NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> +	);
> +
> +static int pl353_nfc_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			     bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
> +					      op, check_only);
> +}
> +
> +/**
> + * pl353_nand_ecc_init - Initialize the ecc information as per the ecc m=
ode
> + * @mtd:	Pointer to the mtd_info structure
> + * @ecc:	Pointer to ECC control structure
> + * @ecc_mode:	ondie ecc status
> + *
> + * This function initializes the ecc block and functional pointers as
> +per the
> + * ecc mode
> + *
> + * Return:	0 on success or negative errno.
> + */
> +static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctr=
l *ecc,
> +			       int ecc_mode)
> +{
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	int ret =3D 0;
> +
> +	ecc->read_oob =3D pl353_nand_read_oob;
> +	ecc->write_oob =3D pl353_nand_write_oob;
> +	if (ecc_mode =3D=3D NAND_ECC_ON_DIE) {
> +		ecc->write_page_raw =3D pl353_nand_write_page_raw;
> +		ecc->read_page_raw =3D pl353_nand_read_page_raw;
> +
> +		/*
> +		 * On-Die ECC spare bytes offset 8 is used for ECC codes
> +		 * Use the BBT pattern descriptors
> +		 */
> +		chip->bbt_td =3D &bbt_main_descr;
> +		chip->bbt_md =3D &bbt_mirror_descr;
> +		ret =3D pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
> +		if (ret)
> +			return ret;
> +
> +	} else {
> +		ecc->mode =3D NAND_ECC_HW;
> +
> +		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
> +		ecc->bytes =3D 3;
> +		ecc->strength =3D 1;
> +		ecc->calculate =3D pl353_nand_calculate_hwecc;
> +		ecc->correct =3D pl353_nand_correct_data;
> +		ecc->read_page =3D pl353_nand_read_page_hwecc;
> +		ecc->size =3D PL353_NAND_ECC_SIZE;
> +		ecc->read_page =3D pl353_nand_read_page_hwecc;
> +		ecc->write_page =3D pl353_nand_write_page_hwecc;
> +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> +		switch (mtd->writesize) {
> +		case SZ_512:
> +		case SZ_1K:
> +		case SZ_2K:
> +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> +			break;
> +		default:
> +			ecc->calculate =3D nand_calculate_ecc;
> +			ecc->correct =3D nand_correct_data;
> +			ecc->size =3D 256;
> +			break;
> +		}
> +
> +		if (mtd->oobsize =3D=3D 16) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> +		} else if (mtd->oobsize =3D=3D 64) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
> +		} else {
> +			ret =3D -ENXIO;
> +			dev_err(xnfc->dev, "Unsupported oob Layout\n");
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int pl353_nfc_setup_data_interface(struct nand_chip *chip, int cs=
line,
> +					  const struct nand_data_interface
> +					  *conf)
> +{
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	const struct nand_sdr_timings *sdr;
> +	u32 timings[7], mckperiodps;
> +
> +	if (csline =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> +		return 0;
> +
> +	sdr =3D nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +
> +	/*
> +	 * SDR timings are given in pico-seconds while NFC timings must be
> +	 * expressed in NAND controller clock cycles.
> +	 */
> +	mckperiodps =3D NSEC_PER_SEC / xnfc->mclk_rate;
> +	mckperiodps *=3D 1000;
> +	if (sdr->tRC_min <=3D 20000)
> +		/*
> +		 * PL353 SMC needs one extra read cycle in SDR Mode 5
> +		 * This is not written anywhere in the datasheet but
> +		 * the results observed during testing.
> +		 */
> +		timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + 1;
> +	else
> +		timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> +
> +	timings[1] =3D DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> +
> +	/*
> +	 * For all SDR modes, PL353 SMC needs tREA max value as 1,
> +	 * Results observed during testing.
> +	 */
> +	timings[2] =3D PL353_TREA_MAX_VALUE;
> +	timings[3] =3D DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> +	timings[4] =3D DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> +	timings[5] =3D DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> +	timings[6] =3D DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> +	pl353_smc_set_cycles(timings);
> +
> +	return 0;
> +}
> +
> +static int pl353_nand_attach_chip(struct nand_chip *chip) {
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> +	int ret;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		ret =3D pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +		if (ret) {
> +			dev_err(xnfc->dev, "Set BusWidth failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (mtd->writesize <=3D SZ_512)
> +		xnfc->addr_cycles =3D 1;
> +	else
> +		xnfc->addr_cycles =3D 2;
> +
> +	if (chip->options & NAND_ROW_ADDR_3)
> +		xnfc->addr_cycles +=3D 3;
> +	else
> +		xnfc->addr_cycles +=3D 2;
> +
> +	ret =3D pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
> +	if (ret) {
> +		dev_err(xnfc->dev, "ECC init failed\n");
> +		return ret;
> +	}
> +
> +	if (!mtd->name) {
> +		/*
> +		 * If the new bindings are used and the bootloader has not been
> +		 * updated to pass a new mtdparts parameter on the cmdline, you
> +		 * should define the following property in your NAND node, ie:
> +		 *
> +		 *	label =3D "pl353-nand";
> +		 *
> +		 * This way, mtd->name will be set by the core when
> +		 * nand_set_flash_node() is called.
> +		 */
> +		mtd->name =3D devm_kasprintf(xnfc->dev, GFP_KERNEL,
> +					   "%s", PL353_NAND_DRIVER_NAME);
> +		if (!mtd->name) {
> +			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops pl353_nand_controller_ops =3D {
> +	.attach_chip =3D pl353_nand_attach_chip,
> +	.exec_op =3D pl353_nfc_exec_op,
> +	.setup_data_interface =3D pl353_nfc_setup_data_interface, };
> +
> +/**
> + * pl353_nand_probe - Probe method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function initializes the driver data structures and the hardware=
.
> + * The NAND driver has dependency with the pl353_smc memory controller
> + * driver for initializing the NAND timing parameters, bus width, ECC
> +modes,
> + * control and status information.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_probe(struct platform_device *pdev) {
> +	struct pl353_nand_controller *xnfc;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	struct resource *res;
> +	struct device_node *np, *dn;
> +	u32 ret, val;
> +
> +	xnfc =3D devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
> +	if (!xnfc)
> +		return -ENOMEM;
> +
> +	xnfc->dev =3D &pdev->dev;
> +	nand_controller_init(&xnfc->controller);
> +	xnfc->controller.ops =3D &pl353_nand_controller_ops;
> +
> +	/* Map physical address of NAND flash */
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xnfc->regs =3D devm_ioremap_resource(xnfc->dev, res);
> +	if (IS_ERR(xnfc->regs))
> +		return PTR_ERR(xnfc->regs);
> +
> +	chip =3D &xnfc->chip;
> +	chip->controller =3D &xnfc->controller;
> +	mtd =3D nand_to_mtd(chip);
> +	nand_set_controller_data(chip, xnfc);
> +	mtd->priv =3D chip;
> +	mtd->owner =3D THIS_MODULE;
> +	nand_set_flash_node(chip, xnfc->dev->of_node);
> +
> +	np =3D of_get_next_parent(xnfc->dev->of_node);
> +	xnfc->mclk =3D of_clk_get_by_name(np, "memclk");
> +	if (IS_ERR(xnfc->mclk)) {
> +		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
> +		return PTR_ERR(xnfc->mclk);
> +	}
> +
> +	xnfc->mclk_rate =3D clk_get_rate(xnfc->mclk);
> +	dn =3D nand_get_flash_node(chip);
> +	ret =3D of_property_read_u32(dn, "nand-bus-width", &val);
> +	if (ret)
> +		val =3D 8;
> +
> +	xnfc->buswidth =3D val;
> +
> +	/* Set the device option and flash width */
> +	chip->options =3D NAND_BUSWIDTH_AUTO;
> +	chip->bbt_options =3D NAND_BBT_USE_FLASH;
> +	platform_set_drvdata(pdev, xnfc);
> +	ret =3D nand_scan(chip, 1);
> +	if (ret) {
> +		dev_err(xnfc->dev, "could not scan the nand chip\n");
> +		return ret;
> +	}
> +
> +	ret =3D mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(xnfc->dev, "Failed to register mtd device: %d\n", ret);
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_remove - Remove method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function is called if the driver module is being unloaded. It
> +frees all
> + * resources allocated to the device.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_remove(struct platform_device *pdev) {
> +	struct pl353_nand_controller *xnfc =3D platform_get_drvdata(pdev);
> +	struct mtd_info *mtd =3D nand_to_mtd(&xnfc->chip);
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	/* Release resources, unregister device */
> +	nand_release(chip);
> +
> +	return 0;
> +}
> +
> +/* Match table for device tree binding */ static const struct
> +of_device_id pl353_nand_of_match[] =3D {
> +	{ .compatible =3D "arm,pl353-nand-r2p1" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
> +
> +/*
> + * pl353_nand_driver - This structure defines the NAND subsystem
> +platform driver  */ static struct platform_driver pl353_nand_driver =3D =
{
> +	.probe		=3D pl353_nand_probe,
> +	.remove		=3D pl353_nand_remove,
> +	.driver		=3D {
> +		.name	=3D PL353_NAND_DRIVER_NAME,
> +		.of_match_table =3D pl353_nand_of_match,
> +	},
> +};
> +
> +module_platform_driver(pl353_nand_driver);
> +
> +MODULE_AUTHOR("Xilinx, Inc.");
> +MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
> +MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.17.1

