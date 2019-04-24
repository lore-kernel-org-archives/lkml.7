Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7942FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39AAC20878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DEuahUDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDXFFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:05:23 -0400
Received: from mail-eopbgr820052.outbound.protection.outlook.com ([40.107.82.52]:62747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfDXFFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGQgJ5Ius/udLWBy2o5LGNX/ow0nRMrqbedYDCxfHM8=;
 b=DEuahUDvPw9INMi1jhX4PDl4qOdMaX2tv5ZDIF3qvSIiHyENywxdeXflxy52IVJKyqpF+LkslFWGQx+EpJlPgV0YE5KhDX9MYNTwFvIfi/h5DsUNBt8PIBRJHbS7nvgxRNr+/iA8LF/xZAZbz2px5E9CAwzS6P6gWtrfyKGfvWc=
Received: from DM6PR02MB4779.namprd02.prod.outlook.com (20.176.109.16) by
 DM6PR02MB4506.namprd02.prod.outlook.com (20.176.107.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 05:04:39 +0000
Received: from DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::1970:28ec:3bfa:2305]) by DM6PR02MB4779.namprd02.prod.outlook.com
 ([fe80::1970:28ec:3bfa:2305%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 05:04:39 +0000
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
Subject: RE: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Topic: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
Thread-Index: AQHU83vggkxmg2rBCEyEcIHuXS/Vp6ZJveKAgAEOs2A=
Date:   Wed, 24 Apr 2019 05:04:38 +0000
Message-ID: <DM6PR02MB47797E4A5ADFC87DE4B04A81AF3C0@DM6PR02MB4779.namprd02.prod.outlook.com>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190423124525.axaprwy4qofbqfhj@laureti-dev>
In-Reply-To: <20190423124525.axaprwy4qofbqfhj@laureti-dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9668ec92-f7fb-45ad-8f2d-08d6c8725aa3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR02MB4506;
x-ms-traffictypediagnostic: DM6PR02MB4506:
x-microsoft-antispam-prvs: <DM6PR02MB4506E381805A58B4D03144B3AF3C0@DM6PR02MB4506.namprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(4326008)(186003)(102836004)(14454004)(6506007)(7736002)(97736004)(305945005)(316002)(54906003)(74316002)(26005)(6246003)(25786009)(53546011)(5660300002)(3846002)(6116002)(7416002)(76176011)(86362001)(2906002)(52536014)(8936002)(53936002)(6916009)(55016002)(73956011)(76116006)(8676002)(71190400001)(66946007)(71200400001)(81166006)(6436002)(9686003)(486006)(66476007)(99286004)(68736007)(66556008)(478600001)(33656002)(229853002)(11346002)(256004)(14444005)(66066001)(66446008)(64756008)(446003)(81156014)(7696005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4506;H:DM6PR02MB4779.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vpCr/QnClzzDldn3PMpr+Wxvf0c4ORGX8NlELsBsZGOEcN5f7u1hskPpJD+c8JSvJcJvqnzeD2nBFHRB6BoOSRxOY5Mny6eKLte7rLU1ZjhYx5ZAN85/BQ6nvLkrbuJIX3nxBNQ/z0quo74sAgbqucsEPHpTeBgLzCV+tEA/UPRdA/x587Ih9S3bVk3ri22C2sRxly5Q9YTND4lRP56KBiA4jhTNXJ05lwpc1G1aSfTiUyRXbw617WCP8fX2z9yLTq9p+RUKT1/mMa0jt95xNR+R4FLdghcsuKhn6RH3UvgwBNDPohxcWxY/9xz+CTPJosQQisA4iNxGNpvc87UDNBSOU2Flb6iSPxn54GgGUVN4I83uriIIaE9stSSp6T/h8mnI1f40enMtoLyWA1ICLKBwcFW+zd+DjOyMPfz7m2M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9668ec92-f7fb-45ad-8f2d-08d6c8725aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 05:04:39.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut,

> -----Original Message-----
> From: Helmut Grohne <helmut.grohne@intenta.de>
> Sent: Tuesday, April 23, 2019 6:15 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: bbrezillon@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
> dwmw2@infradead.org; computersforpeace@gmail.com; marek.vasut@gmail.com; =
linux-
> mtd@lists.infradead.org; linux-kernel@vger.kernel.org; Michal Simek <mich=
als@xilinx.com>;
> nagasureshkumarrelli@gmail.com
> Subject: Re: [LINUX PATCH v14] mtd: rawnand: pl353: Add basic driver for =
arm pl353 smc
> nand interface
>=20
> WARNING: This driver might brick the hardware. See below.
>=20
> Hi Naga,
>=20
> On Mon, Apr 15, 2019 at 04:40:13PM +0530, Naga Sureshkumar Relli wrote:
> > Changes in v14:
> >  - Removed legacy hooks as per Miquel comments
>=20
> Thank you for the update.
>=20
> > +static inline int pl353_wait_for_dev_ready(struct nand_chip *chip) {
> > +	unsigned long timeout =3D jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> > +
> > +	do {
> > +		if (pl353_smc_get_nand_int_status_raw()) {
> > +			pl353_smc_clr_nand_int();
> > +			break;
>=20
> A closing brace is missing here. This causes a compilation failure.
While cleaning up the warnings reported by checkpatch,  this happened.
sorry for that. I will correct it.=20
>=20
> > +
> > +		cpu_relax();
>=20
> You previously used cond_resched (via nand_wait_ready) here. Why did you =
change it to
> cpu_relax()?
I just replicated the pl353_wait_for_ecc_done() API definition.
But did you see any issue with this?
Anyway I will replace it with cond_resched(), instead of cpu_releax()
>=20
> > +	} while (!time_after_eq(jiffies, timeout));
> > +
> > +	if (time_after_eq(jiffies, timeout)) {
> > +		pr_err("%s timed out\n", __func__);
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
>=20
> > +static int pl353_nand_read_page_hwecc(struct nand_chip *chip,
> > +				      u8 *buf, int oob_required, int page) {
> > +	int i, stat, eccsize =3D chip->ecc.size;
> > +	int eccbytes =3D chip->ecc.bytes;
> > +	int eccsteps =3D chip->ecc.steps;
> > +	u8 *p =3D buf;
> > +	u8 *ecc_calc =3D chip->ecc.calc_buf;
> > +	u8 *ecc =3D chip->ecc.code_buf;
> > +	unsigned int max_bitflips =3D 0;
> > +	u8 *oob_ptr;
> > +	u32 ret;
> > +	unsigned long data_phase_addr;
> > +	unsigned long nand_offset =3D (unsigned long __force)xnfc->regs;
>=20
> The variable xnfc is undeclared here. Consider swapping the line with the=
 next one.
>=20
> > +	struct pl353_nand_controller *xnfc =3D to_pl353_nand(chip);
> > +	struct mtd_info *mtd =3D nand_to_mtd(chip);
>=20
> After loading the driver, the device does not work. The dmesg output is:
>=20
> nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
> nand: Micron MT29F2G08ABAEAWP
> nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64 Ba=
d block table not
> found for chip 0 Bad block table not found for chip 0 Scanning device for=
 bad blocks
> nand_bbt: error while writing BBT block -524
> nand_bbt: error while writing BBT block -524
> nand_bbt: error while writing BBT block -524
> nand_bbt: error while writing BBT block -524 No space left to write bad b=
lock table
> nand_bbt: error while writing bad block table -28 pl353-nand e1000000.fla=
sh: could not scan
> the nand chip
> pl353-nand: probe of e1000000.flash failed with error -28
Did you follow the same thing that you tried earlier?
i.e. updated "nand-bus-width" property and "nand-ecc-mode" ?
I haven't seen any issue in BBT scanning, with this patch.

>=20
> After trying the driver, the flash chip was bricked. Neither the old driv=
er nor the uboot-xlnx
> driver nor the Xilinx fsbl are able to talk to the chip afterwards. This =
behaviour persists even
> after a full power cycle. I'll try reinitializing the flash chip next. I'=
ve only seen this behaviour
> once, so there is a slight chance that the cause is something else.
Sometimes I also faced the same problem during driver development.
What I did is, in standalone nandps driver example,  I forcibly created BBT=
 in the init and once
 it is done. I just reloaded the actual example. Then after wards u-boot an=
d Linux are able to scan
the BBT.

Thanks,
Naga Sureshkumar Relli
>=20
> Helmut
