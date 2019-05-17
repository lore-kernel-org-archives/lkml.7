Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC8920848
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d3D+QFu6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YoSB3Czk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEQQcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:32:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39364 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558110732; x=1589646732;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qvM06v5LK2earYmAgDdwZOgIJmtAceqfZkuhQxMz6Cw=;
  b=d3D+QFu6DMSB8o4ry+fktLiSR9eresgq0BtXMnO5n1sPkEhbc0kp59VK
   dZFtn2MlLRPhgAXucAl9LEZCreoAfJynBu5BTawu5cRLwcqtBIAq7Uat6
   BFum6FePgMwqTzuQtLhpz75vfLuzL9Tqvc5qDEcAzTYBbVeLDYlHr0gTx
   mypzosur4VPZjiDiIYfbR2t+L4Dkuw5W6xU2k6lFh6zKM1gACoext9CmJ
   ae0yU8qg7Fh5U2d9LpECDZcGxZ60FLF5LuaenG+nvs79x5fad7vqcT8fn
   n4fWRU7kk82keXhvaagSrdMwsIG1YW/+rem8m+Z4/+8Rf3Hy05f5XRqAQ
   A==;
X-IronPort-AV: E=Sophos;i="5.60,480,1549900800"; 
   d="scan'208";a="214659982"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 00:32:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LRwACc9N4amVXgP1c6tadnlQKYFBobfTc5Y5y4YkQE=;
 b=YoSB3Czkud8aJNPxHvAQaHf4f99iV1w4AxEj2kIMsIN29G4BFaIlkOm9UZ0ny0IH0smzFlY+uP4xUUuXQI88pl2gP0wG/PQR88RYexvgU/y7D+ZBeO2yfRZpgqNGyiVt147QI3ShUiwXQ+U2y8uBkzrb92nA/26U4CHauGHXbXI=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB5312.namprd04.prod.outlook.com (20.177.255.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 16:32:02 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::b163:e740:af6e:2602]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::b163:e740:af6e:2602%6]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 16:32:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     xiaolinkui <xiaolinkui@kylinos.cn>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: target: use struct_size() in kmalloc()
Thread-Topic: [PATCH] nvme: target: use struct_size() in kmalloc()
Thread-Index: AQHVDH8oTBY/BlMzjUaR4gerzBgDxQ==
Date:   Fri, 17 May 2019 16:32:02 +0000
Message-ID: <SN6PR04MB4527D340D48215FE19335A99860B0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1558076615-8576-1-git-send-email-xiaolinkui@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:f9a6:10ea:e679:e2ee]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4796274b-408c-4ef6-5450-08d6dae5312e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB5312;
x-ms-traffictypediagnostic: SN6PR04MB5312:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB5312C1606B7338188D04BE4C860B0@SN6PR04MB5312.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(39860400002)(366004)(189003)(199004)(68736007)(476003)(4326008)(46003)(55016002)(14454004)(53936002)(9686003)(486006)(54906003)(446003)(229853002)(25786009)(6436002)(102836004)(6246003)(66946007)(66476007)(2501003)(66556008)(64756008)(66446008)(2906002)(76116006)(91956017)(73956011)(81156014)(71190400001)(7736002)(71200400001)(478600001)(72206003)(256004)(110136005)(7696005)(186003)(86362001)(76176011)(316002)(5660300002)(81166006)(33656002)(2201001)(52536014)(6506007)(8936002)(6116002)(53546011)(74316002)(8676002)(305945005)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB5312;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i4zpuG7JX247DZ+MTcifqpzAXSGmhIGLB+CsJ4Qqr88okPesKhUaIElQlkuZTmSrFLHOJBlWCBzh+N5tSq3dhPKFkFQY6EuzMnsOVZtoIMNbJph8cn7TeQSwKHPLvxS1v9Jp5QEDuMF7T43oEenaL53BFIJl29tZ+I0qo3iLdNe1U69zLFES7AXmx5O2Iyf+dv90t38NXtv8RsWLfnjVn2W5z2EtQGJzcMhkH4k3C4fNMCoxdVVcMYvJp9QGzBye1DaIAQ8pt1AVsQF2XcPt0afHQlDJR83SOYTwjIh45sXBGRXzVyQkp86Zosa7fyiWkc77qunTDn6v/7pcgQzlS0Vnd+MCv1eYRWJbKPqS4mtDqGky2VWbYY5tetlkRoQtsh/0QeJeZjZqXxG74gzzyssNGUW6kcjH6oeZDu7BAa0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4796274b-408c-4ef6-5450-08d6dae5312e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 16:32:02.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If maintainers are okay with this then,=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 5/17/19 12:07 AM, xiaolinkui wrote:=0A=
> Use struct_size() to keep code sample.=0A=
> One of the more common cases of allocation size calculations is finding=
=0A=
> the size of a structure that has a zero-sized array at the end, along=0A=
> with memory for some number of elements for that array. For example:=0A=
>=0A=
> struct foo {=0A=
>     int stuff;=0A=
>     struct boo entry[];=0A=
> };=0A=
>=0A=
> instance =3D kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP=
_KERNEL);=0A=
>=0A=
> Instead of leaving these open-coded and prone to type mistakes, we can=0A=
> now use the new struct_size() helper:=0A=
>=0A=
> instance =3D kmalloc(struct_size(instance, entry, count), GFP_KERNEL);=0A=
>=0A=
> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>=0A=
> ---=0A=
>  drivers/nvme/target/admin-cmd.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index 9f72d51..6f9f830 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -248,8 +248,8 @@ static void nvmet_execute_get_log_page_ana(struct nvm=
et_req *req)=0A=
>  	u16 status;=0A=
>  =0A=
>  	status =3D NVME_SC_INTERNAL;=0A=
> -	desc =3D kmalloc(sizeof(struct nvme_ana_group_desc) +=0A=
> -			NVMET_MAX_NAMESPACES * sizeof(__le32), GFP_KERNEL);=0A=
> +	desc =3D kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),=0A=
> +			GFP_KERNEL);=0A=
>  	if (!desc)=0A=
>  		goto out;=0A=
>  =0A=
=0A=
=0A=
