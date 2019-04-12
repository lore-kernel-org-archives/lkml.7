Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B53C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA9C2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nsHeoDo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDLRuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:50:19 -0400
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:64270
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfDLRuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR5kjaZNNlxUaZMMO+sx0gX2K6/Fa43QH5GI5q0u6AE=;
 b=nsHeoDo2HMnl03LlkoT8MEFybG9as762ZceR/AyL0V26UhlXcobTHq/dCITBCHWLcBYnuJEmHAFFUynmtpeAKgm7F0J+4NgUy5ddVfH++yOcXzUnGodogCG3qCVFKRU8k8ruksPIJB5K4wJCX0ayxjhcSRrKP/U4rkyf9p+Sb6c=
Received: from BYAPR02MB5992.namprd02.prod.outlook.com (20.179.89.80) by
 BYAPR02MB5127.namprd02.prod.outlook.com (20.176.254.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Fri, 12 Apr 2019 17:50:12 +0000
Received: from BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::75d3:6a86:7357:90bd]) by BYAPR02MB5992.namprd02.prod.outlook.com
 ([fe80::75d3:6a86:7357:90bd%6]) with mapi id 15.20.1771.014; Fri, 12 Apr 2019
 17:50:12 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Michael Tretter <m.tretter@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] drivers: clk: Update clock driver to handle clock
 attribute
Thread-Topic: [PATCH] drivers: clk: Update clock driver to handle clock
 attribute
Thread-Index: AQHU0uC2ZVAEO+vE+0mpumJCJDukP6Y4dqoAgACQb9A=
Date:   Fri, 12 Apr 2019 17:50:12 +0000
Message-ID: <BYAPR02MB59920087C354B84C9CFED2E0B8280@BYAPR02MB5992.namprd02.prod.outlook.com>
References: <1551741550-10315-1-git-send-email-jollys@xilinx.com>
 <20190412110044.194666db@litschi.hi.pengutronix.de>
In-Reply-To: <20190412110044.194666db@litschi.hi.pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b7dabff-153b-4b4b-d38e-08d6bf6f4ff3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR02MB5127;
x-ms-traffictypediagnostic: BYAPR02MB5127:
x-microsoft-antispam-prvs: <BYAPR02MB51271FF186FB7EB58A202EFCB8280@BYAPR02MB5127.namprd02.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(13464003)(189003)(81156014)(478600001)(6506007)(14454004)(476003)(68736007)(86362001)(486006)(446003)(72206003)(105586002)(26005)(102836004)(25786009)(15650500001)(76176011)(11346002)(7696005)(186003)(2906002)(52536014)(5660300002)(9686003)(81166006)(6116002)(3846002)(53936002)(54906003)(8936002)(33656002)(53546011)(97736004)(6246003)(7736002)(6916009)(55016002)(66066001)(74316002)(6436002)(106356001)(8676002)(229853002)(71200400001)(99286004)(71190400001)(305945005)(256004)(4326008)(316002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5127;H:BYAPR02MB5992.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2yWNfarxYryRw1Ve2AHxaqG4TKsf2d7ZjRmiitcBfPXABMhqkZIbgVZOJ/iC4eLcR+r8C+ReQjRVvbOyzXWQrseR5oZZqptNNKvy/lDaCyuYa5JfHM/Cy4YZc6OQ5ZqU7pL6Jxp6eKDkbcLt6grb7Pb4vVrmZK0wDgrLJb/jiSj7ez/YE0BcYcxL97AONNd7vt5naioVSBkfRmCE0XlSpTwKgUiHEMl2BgPn73ylhUOINCGCIPPZUk2luAgZmsOpU+SPzh+kpz2Ez6Dtho+L8hYeJ7IAi5PwywT5nXcQ3lX865M3T6JHR9X1x/rccwFDcMzqs7Ix5IW78md06LXBsl3AD88/3T1EDEMsBgquA0CJoCEJrtewzAm0oeduvvgx7pLDvmq7FXMN+PQ8LGNEW33wxWAzEFYNh1IRrQ8D9Jc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7dabff-153b-4b4b-d38e-08d6bf6f4ff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 17:50:12.1387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Tretter <m.tretter@pengutronix.de>
> Sent: Friday, April 12, 2019 2:01 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: mturquette@baylibre.com; sboyd@codeaurora.org; Michal Simek
> <michals@xilinx.com>; linux-clk@vger.kernel.org; Tejas Patel
> <TEJASP@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; linux-
> kernel@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org;
> kernel@pengutronix.de
> Subject: Re: [PATCH] drivers: clk: Update clock driver to handle clock at=
tribute
>=20
> On Mon, 04 Mar 2019 15:19:10 -0800, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Versal EEMI APIs uses clock device ID which is combination of class,
> > subclass, type and clock index (e.g. 0x8104006 in which 0-13 bits are
> > for index(6 in given example), 14-19 bits are for clock type (i.e pll,
> > out or ref, 1 in given example), 20-25 bits are for subclass which is
> > nothing but clock type only), 26-32 bits are for device class, which
> > is clock(0x2) for all clocks) while zynqmp firmware uses clock ID
> > which is index only (e.g 0, 1, to n, where n is max_clock id).
> >
> > To use zynqmp clock driver for versal platform also, extend use
> > of QueryAttribute API to fetch device class, subclass and clock type
> > to create clock device ID. In case of zynqmp this attributes would be
> > 0 only, so there won't be any effect on clock id as it would use
> > clock index only.
> >
> > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/clk/zynqmp/clkc.c | 42 +++++++++++++++++++++++++++++----------=
---
> >  1 file changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> > index f65cc0f..c13b014 100644
> > --- a/drivers/clk/zynqmp/clkc.c
> > +++ b/drivers/clk/zynqmp/clkc.c
> > @@ -53,6 +53,10 @@
> >  #define RESERVED_CLK_NAME		""
> >
> >  #define CLK_VALID_MASK			0x1
> > +#define NODE_CLASS_SHIFT		26U
> > +#define NODE_SUBCLASS_SHIFT		20U
> > +#define NODE_TYPE_SHIFT			14U
> > +#define NODE_INDEX_SHIFT		0U
> >
> >  enum clk_type {
> >  	CLK_TYPE_OUTPUT,
> > @@ -80,6 +84,7 @@ struct clock_parent {
> >   * @num_nodes:		Number of nodes present in topology
> >   * @parent:		Parent of clock
> >   * @num_parents:	Number of parents of clock
> > + * @clk_id:		Clock id
> >   */
> >  struct zynqmp_clock {
> >  	char clk_name[MAX_NAME_LEN];
> > @@ -89,6 +94,7 @@ struct zynqmp_clock {
> >  	u32 num_nodes;
> >  	struct clock_parent parent[MAX_PARENT];
> >  	u32 num_parents;
> > +	u32 clk_id;
> >  };
> >
> >  static const char clk_type_postfix[][10] =3D {
> > @@ -396,7 +402,8 @@ static int zynqmp_clock_get_topology(u32 clk_id,
> >
> >  	*num_nodes =3D 0;
> >  	for (j =3D 0; j <=3D MAX_NODES; j +=3D 3) {
> > -		ret =3D zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
> > +		ret =3D zynqmp_pm_clock_get_topology(clock[clk_id].clk_id, j,
> > +						   pm_resp);
>=20
> I think, having clk_id as the index in the array of clock descriptors
> and each descriptor having a clk_id, which might be equal to the clk_id
> (on zynqmp), but might be different from the index (versal) is really
> confusing. It would be better if there would be a clear separation
> between the driver internal id and the id that is used at the interface
> with the firmware.

If we use different ids, we will need to hard code some mappings to convert=
 them to one being used by firmware. For user, both are clock ids but id va=
lues are different compared to zynqmp where it was sequential starting from=
 0.=20

>=20
> >  		if (ret)
> >  			return ret;
> >  		ret =3D __zynqmp_clock_get_topology(topology, pm_resp,
> num_nodes);
> > @@ -459,7 +466,8 @@ static int zynqmp_clock_get_parents(u32 clk_id, str=
uct
> clock_parent *parents,
> >  	*num_parents =3D 0;
> >  	do {
> >  		/* Get parents from firmware */
> > -		ret =3D zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
> > +		ret =3D zynqmp_pm_clock_get_parents(clock[clk_id].clk_id, j,
> > +						  pm_resp);
> >  		if (ret)
> >  			return ret;
> >
> > @@ -528,13 +536,14 @@ static struct clk_hw
> *zynqmp_register_clk_topology(int clk_id, char *clk_name,
> >  						   const char **parent_names)
> >  {
> >  	int j;
> > -	u32 num_nodes;
> > +	u32 num_nodes, clk_dev_id;
> >  	char *clk_out =3D NULL;
> >  	struct clock_topology *nodes;
> >  	struct clk_hw *hw =3D NULL;
> >
> >  	nodes =3D clock[clk_id].node;
> >  	num_nodes =3D clock[clk_id].num_nodes;
> > +	clk_dev_id =3D clock[clk_id].clk_id;
> >
> >  	for (j =3D 0; j < num_nodes; j++) {
> >  		/*
> > @@ -551,13 +560,14 @@ static struct clk_hw
> *zynqmp_register_clk_topology(int clk_id, char *clk_name,
> >  		if (!clk_topology[nodes[j].type])
> >  			continue;
> >
> > -		hw =3D (*clk_topology[nodes[j].type])(clk_out, clk_id,
> > +		hw =3D (*clk_topology[nodes[j].type])(clk_out, clk_dev_id,
> >  						    parent_names,
> >  						    num_parents,
> >  						    &nodes[j]);
> >  		if (IS_ERR(hw))
> > -			pr_warn_once("%s() %s register fail with %ld\n",
> > -				     __func__, clk_name, PTR_ERR(hw));
> > +			pr_warn_once("%s() 0x%x: %s register fail with %ld\n",
> > +				     __func__,  clk_dev_id, clk_name,
> > +				     PTR_ERR(hw));
> >
> >  		parent_names[0] =3D clk_out;
> >  	}
> > @@ -621,20 +631,26 @@ static int zynqmp_register_clocks(struct
> device_node *np)
> >  static void zynqmp_get_clock_info(void)
> >  {
> >  	int i, ret;
> > -	u32 attr, type =3D 0;
> > +	u32 attr, type =3D 0, nodetype, subclass, class;
> >
> >  	for (i =3D 0; i < clock_max_idx; i++) {
> > -		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
> > -		if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME))
> > -			continue;
> > -
> >  		ret =3D zynqmp_pm_clock_get_attributes(i, &attr);
> >  		if (ret)
> >  			continue;
> >
> >  		clock[i].valid =3D attr & CLK_VALID_MASK;
> > -		clock[i].type =3D attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
> > -							CLK_TYPE_OUTPUT;
> > +		clock[i].type =3D ((attr >> CLK_TYPE_SHIFT) & 0x1) ?
> > +				CLK_TYPE_EXTERNAL : CLK_TYPE_OUTPUT;
> > +		nodetype =3D (attr >> NODE_TYPE_SHIFT) & 0x3F;
> > +		subclass =3D (attr >> NODE_SUBCLASS_SHIFT) & 0x3F;
> > +		class =3D (attr >> NODE_CLASS_SHIFT) & 0x3F;
> > +
> > +		clock[i].clk_id =3D (class << NODE_CLASS_SHIFT) |
> > +				  (subclass << NODE_SUBCLASS_SHIFT) |
> > +				  (nodetype << NODE_TYPE_SHIFT) |
> > +				  (i << NODE_INDEX_SHIFT);
>=20
> In the commit message you write that on versal the index is returned in
> bits 13..0 of the get_attr response from the firmware. However, the code =
uses
> the index that is used in the get_attr call and ignores the index in
> the response.
>=20

Yes index is from bit 0:13. Attributes response doesn't contain index as it=
 is same for what attribute is being queried for which is i.=20

> Moreover, on zynqmp bits 0 and 2 of the response are already in use,
> but would be part of the index on versal. Therefore, as I understand,
> the response formats of zynqmp and versal are actually different
> formats and should be distinguished more clearly.
>=20

Bits 0 to 2 are same bot Zynqmp and Versal as versal doesn't contain index =
in attribute response. Only new attribute fields for versal are class, subc=
lass and type. Driver reconstructs clock id using those value and index as =
i.

Thanks,
Jolly Shah


> Michael
>=20
> > +
> > +		zynqmp_pm_clock_get_name(clock[i].clk_id,
> clock[i].clk_name);
> >  	}
> >
> >  	/* Get topology of all clock */
