Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35108C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E851020825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S6SkxTd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEGKYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:24:14 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:5760
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726340AbfEGKYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC5KLEluilj9HPoBxEBUgVb5MMYQWC+BIYnMmL9Plr8=;
 b=S6SkxTd0hY2ni6z1gj0R7jBBzUTu7/xqQ+PjOz1EHj0+Wu1RbeKQzqUjjAW0614eWSr57ija7sQeez8+P5OygoqROZSKMVm2uvxkkr7svYjrknVR58gRP/pqWgPFr1T9WIEuaj/bGV6/Rw0yQdLoy2/EomNElmkvQOOqZB1mB+A=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB5409.eurprd04.prod.outlook.com (20.178.116.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Tue, 7 May 2019 10:24:10 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 10:24:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH] soc: imx: Get iMX8MQ revision for B0 from ATF
Thread-Topic: [PATCH] soc: imx: Get iMX8MQ revision for B0 from ATF
Thread-Index: AQHVAbePp28Sq24nH0ukEcxeJWhXpA==
Date:   Tue, 7 May 2019 10:24:10 +0000
Message-ID: <AM0PR04MB6434517A0235C8308D86B050EE310@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <d85c6cfe79f9fc1e7761c952e29dfb2f71cff2c1.1556891520.git.agx@sigxcpu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56296692-e382-445a-6d67-08d6d2d62539
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5409;
x-ms-traffictypediagnostic: AM0PR04MB5409:
x-microsoft-antispam-prvs: <AM0PR04MB54096C185BEDA4001C1CA712EE310@AM0PR04MB5409.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(54534003)(71190400001)(33656002)(91956017)(44832011)(5660300002)(66446008)(66556008)(66476007)(64756008)(316002)(73956011)(76116006)(66946007)(68736007)(66574012)(54906003)(110136005)(3846002)(6116002)(2906002)(99286004)(102836004)(76176011)(53546011)(74316002)(6506007)(7696005)(66066001)(186003)(55016002)(9686003)(26005)(476003)(486006)(52536014)(6436002)(229853002)(6246003)(86362001)(71200400001)(446003)(81156014)(81166006)(8676002)(478600001)(8936002)(25786009)(7736002)(4326008)(14454004)(305945005)(256004)(53936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5409;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7S6zDAL0B+PMy2PnEFQrkNDmL2gIZ7DS2II4N8Xb8kJMD+JqdQ6xpvr5YdT4TVMoiPSUGvddive5ECEk9mhsTpr6VH2hkxlSIE9Tm84+H75HO/dSa7/i61VOidNcCluEmT8v/tx4U3S64CS1DDKfuWI183lKCHaXY/0MYZMJiPmuC5wq5FWrgohCCugS9z6tz3B3UVipE+w9G0921D9Tdiyg0U0Er9ByvJgcsCyTB/5FBlk+7WSWGa5UrGgzR0pPTef2HDolJNx2RhCWhzlROS1FtEsfzC+E9xWp+K3kbJnGQLDYBetivOvmaMbnjPmBb3R8AcadBLKwZsNcq3CF7fYxY/UtMymmuKnXSQ31Fecjf9EEl3ZtA/802VO74LUUZenjvVgps8XmlwTQcLrL9OZ992XIHvUBml/KWjKNchQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56296692-e382-445a-6d67-08d6d2d62539
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 10:24:10.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.2019 16:53, Guido G=FCnther wrote:=0A=
> This is similar to what the BSP does and needed to e.g. determine=0A=
> necessary quirks for MIPI DSI.=0A=
> =0A=
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>=0A=
> =0A=
>  From the list discussion and changelog it's not clear to me why a=0A=
> different method was chosen for the B1 silicon so I left that in place=0A=
> as is and only trigger on the B0 silicon I have here.=0A=
=0A=
Fetching revision without an ATF call was done for the sake of avoiding =0A=
depending on ATF as much as vendor tree does. I'm not sure avoiding ATF =0A=
dependencies is a good approach.=0A=
=0A=
The imx8mq reference manual claims that 0x3036006c is should be soc =0A=
revision but that incorrectly reports 0x00824010 meaning "A0" on all =0A=
chips. So some nasty hacks are done in ATF instead by poking at ROM and =0A=
OCOTP.=0A=
=0A=
There were multiple discussions also for GPCv2 and 8mm about how much to =
=0A=
rely on firmware. I personally think that duplicating ATF workarounds =0A=
just makes supporting imx8m harder in Linux. Don't we want firmware to =0A=
help us with silicon erratas?=0A=
=0A=
> +#define IMX8MQ_ATF_GET_SOC_INFO		0xc2000006=0A=
=0A=
Any reason not to use original FSL_SIP_GET_SOC_INFO constant name?=0A=
=0A=
Since ATF can fetch revision for B1 as well it makes no sense to keep =0A=
the old code if we switch to using a SIP call, just call ATF always.=0A=
=0A=
ATF upstream currently has 8mq support but no SIP call for GET_SOC_INFO, =
=0A=
that could be added easily.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
