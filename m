Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD0DC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D10206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WJahQ7oS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfFMPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:36:28 -0400
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:1620
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727205AbfFMKSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrIeVn+nUkqIe3O0L9yJM3lkBCAlzxedB/cahtwPIZc=;
 b=WJahQ7oSJsn4HkkLlNpsmBqcaaCSVwqcz06e9cu/omOt8s9+QhbRreNutiNaSKx8lMQaV2rSYWEsEywNSxhLPNegGLtFjKFMviUgG8Bhx0SKBUBU2pSIbhgxH8lvhYAtAOKmcLdegFCAvT3R1w60uUFLSFkIBIVDj2OYRXlK624=
Received: from BYAPR02MB4776.namprd02.prod.outlook.com (52.135.232.145) by
 BYAPR02MB4533.namprd02.prod.outlook.com (52.135.239.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 10:18:00 +0000
Received: from BYAPR02MB4776.namprd02.prod.outlook.com
 ([fe80::3184:2890:c7e6:744a]) by BYAPR02MB4776.namprd02.prod.outlook.com
 ([fe80::3184:2890:c7e6:744a%6]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 10:18:00 +0000
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
Thread-Index: AQHU83vggkxmg2rBCEyEcIHuXS/Vp6ZMy7GAgAFFM5CABRNXAIBGkizg
Date:   Thu, 13 Jun 2019 10:18:00 +0000
Message-ID: <BYAPR02MB4776C0226F9A9F55C9A6DE44AFEF0@BYAPR02MB4776.namprd02.prod.outlook.com>
References: <1555326613-26739-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190425112338.dipgmqqfuj45gx6s@laureti-dev>
 <DM6PR02MB4779EE37978EC0E6475C55D7AF390@DM6PR02MB4779.namprd02.prod.outlook.com>
 <20190429121804.4jzspv4goehwdpez@laureti-dev>
In-Reply-To: <20190429121804.4jzspv4goehwdpez@laureti-dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5ac365a-def6-4ea5-cd45-08d6efe869ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB4533;
x-ms-traffictypediagnostic: BYAPR02MB4533:
x-microsoft-antispam-prvs: <BYAPR02MB453318B1CC8864D43AE5446BAFEF0@BYAPR02MB4533.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(199004)(189003)(129404003)(13464003)(478600001)(26005)(7696005)(476003)(76176011)(446003)(6506007)(102836004)(186003)(53546011)(53936002)(9686003)(25786009)(55016002)(6436002)(6246003)(6916009)(4326008)(561944003)(71190400001)(71200400001)(229853002)(14444005)(33656002)(256004)(486006)(99286004)(2906002)(11346002)(54906003)(8676002)(52536014)(7736002)(305945005)(74316002)(5660300002)(81156014)(81166006)(14454004)(8936002)(66476007)(66556008)(64756008)(66446008)(7416002)(76116006)(66946007)(73956011)(6116002)(3846002)(316002)(66066001)(68736007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4533;H:BYAPR02MB4776.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BkcVO+CnUpPMLVK7ILgX1UZDnqnDhZ0juHUJ6SWOigk5Ebe2iE/CrrqpgwjEBtEHDLijAf9OSMwPuuFaDWh+ubLKwGb+WWEvp87BxEFybRMv+83qV2VVySARHC4urQMDxutPQ7rqDW8DIzhObIoBE+ZvodoGS6TTyju7PDUjXcVLPT4NKvc1onHial2Zf7mx3hXvNBKD3/0lfUwUo4ATkbNvuWHhexgtKBh7sM75VI+VxmurOLYvZj6QapOfFRFTtDj7zvCMl2bjqdmS5HOii5i0YNDmu7zBTyvdwf4SOz+UbFLLPBxJaVPb/r7nPzWO2C9mS0GhTgPLxZYvB1pbD1Civ3VNLGmRRXi7kWkiJmMeL0e9vk/M7FusyT6HDmOQb67PB/3/r7ZT4u16ohCSoGtDwkj9gnIvGb/gL4IWezo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac365a-def6-4ea5-cd45-08d6efe869ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 10:18:00.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nagasure@xilinx.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helmut,

> -----Original Message-----
> From: Helmut Grohne <helmut.grohne@intenta.de>
> Sent: Monday, April 29, 2019 5:48 PM
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
> On Mon, Apr 29, 2019 at 11:31:14AM +0000, Naga Sureshkumar Relli wrote:
> > But just wanted to know, do you see issues with these __force and __iom=
em castings?
>=20
> I only see a minor issue: They're (deliberately) lengthy. Using many of t=
hem diverts attention
> of the reader. Therefore, my proposal attempted to reduce their frequency=
. The only issue I see
> here is readability.
>=20
> > >
> > > > +	u8 addr_cycles;
> > > > +	struct clk *mclk;
> > >
> > > All you need here is the memory clock frequency. Wouldn't it be
> > > easier to extract that frequency once during probe and store it
> > > here? That assumes a constant frequency, but if the frequency isn't c=
onstant, you have a
> race condition.
> > That is what we are doing in the probe.
> > In the probe, we are getting mclk using of_clk_get() and then we are
> > getting the actual frequency Using clk_get_rate().
> > And this is constant frequency only(getting from dts)
>=20
> Not quite. You're getting a clock reference in probe and then repeatedly =
access the frequency
> elswhere. I am suggesting that you get the clock frequency during probe a=
nd never save the
> clock reference to a struct.
>=20
> > > > +		case NAND_OP_ADDR_INSTR:
> > > > +			offset =3D nand_subop_get_addr_start_off(subop, op_id);
> > > > +			naddrs =3D nand_subop_get_num_addr_cyc(subop, op_id);
> > > > +			addrs =3D &instr->ctx.addr.addrs[offset];
> > > > +			nfc_op->addrs =3D instr->ctx.addr.addrs[offset];
> > > > +			for (i =3D 0; i < min_t(unsigned int, 4, naddrs); i++) {
> > > > +				nfc_op->addrs |=3D instr->ctx.addr.addrs[i] <<
> > >
> > > I don't quite understand what this code does, but it looks strange
> > > to me. I compared it to other drivers. The code here is quite
> > > similar to marvell_nand.c. It seems like we are copying a varying
> > > number (0 to 6) of addresses from the buffer instr->ctx.addr.addrs.
> > > However their indices are special: 0, 1, 2, 3, offset + 4, offset + 5=
. This is non-consecutive
> and different from marvell_nand.c in this regard. Could it be that you re=
ally meant index
> offset+i here?
> > I didn't get, what you are saying here.
> > It is about updating page and column addresses.
> > Are you asking me to remove nfc_op->addrs =3D instr->ctx.addr.addrs[off=
set]; before for
> loop?
>=20
> I compared this code to marvell_nand.c and noticed a subtle difference.
> Both snippets read 6 address bytes and consume them in a driver-specific =
way. Now which
> address bytes are consumed differs.
>=20
> marvell_nand.c consumes instr->ctx.addr.addrs at indices offset,
> offset+1, offset+2, offset+3, offset+4, offset+5. pl353_nand.c consumes
> instr->ctx.addr.addrs at indices 0, 1, 2, 3, offset, offset+4, offset+5.
> (In my previous mail, I didn't notice that it was also consuming the offs=
et index.)
>=20
> I would have expected this behaviour to be consistent between different d=
rivers. If I assume
> marvell_nand.c to do the right thing and pl353_nand.c to be wrong (which =
is not necessarily a
> correct assumption), then the code woule likely becom:
>=20
> 	addrs =3D &instr->ctx.addr.addrs[offset];
> 	for (i =3D 0; i < min_t(unsigned int, 4, naddrs); i++) {
> 		nfc_op->addrs |=3D addrs[i] << (8 * i);
> 		              // ^^^^^
> 	}
>=20
> Hope this helps.
I spent much of time to address all your comments.
All are addressed and tested. except the above one(address offset calculati=
on)
I didn't see any issue with the address calculation.
for (i =3D 0; i < min_t(unsigned int, 4, naddrs); i++) {
	nfc_op->addrs |=3D instr->ctx.addr.addrs[i] <<
			 (8 * i);
}
If you go through the nand_base.c, there nand_fill_column_cycles() API, fil=
ls the first two or one address cycle
Based on bus width and page size.
That means, addrs[0]/[1] will be updated here.
And the page is updated to the next offsets.
In the similar way we have to extract the offsets in driver.
So the first four address bytes are stored using the above for() loop and i=
f the
Address cycles are more than 4, then store the remaining offsets as well.

I just compared the offsets that are updated in driver with the offsets(pag=
e and column) that the frame work(nand_base.c) is sending, and the offsets =
are same.
I have also checked these offsets with older driver(not exec_op() implement=
ed) and both are matching.

So I didn't see any issue with this addrs calculation.
As per the statement mentioned by you, this driver consumes addr[0], addr[1=
], addr[2], addr[3] and
If more address cycles needed, then addr[4] and addr[5]. This is correct.

Please let me know, what exactly I am missing.

Thank you for your inputs and sorry for the delay, as I am on leave for som=
e days.

Regards,
Naga Sureshkumar Relli
>=20
> Helmut
