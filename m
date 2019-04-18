Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77BC220693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dRBEQHhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfDRWBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:01:30 -0400
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:44230
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfDRWB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PMUOkAg8O+jVts1qENA64Kkwnble1HykdvZSn5XaUA=;
 b=dRBEQHhPQjE6pJGyvUoNGpHOx1sLGeARCLqTpAGoPWsb1FA/yX2Rwa544DoZhgJ/q2pBFkzyaYNPxgst3rcjcmbZT/ZwjHL1p02a7QdndVLeufbtR4NiJEDJ1/Vg5sPT8sycjlR1LvkdeTIh9PxSeHnmOY9LDXyaPHeRilkpLbE=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB6000.eurprd04.prod.outlook.com (20.178.123.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Thu, 18 Apr 2019 22:01:24 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 22:01:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Peng Fan <peng.fan@nxp.com>
CC:     Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ye Li <ye.li@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Topic: [RESEND v2] soc: imx: Add generic i.MX8 SoC driver
Thread-Index: AQHU4M8x51owZIDO7UOOFQ/teNRhvw==
Date:   Thu, 18 Apr 2019 22:01:24 +0000
Message-ID: <VI1PR04MB5533BF028703707A956DAEA7EE260@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <1553273350-28852-1-git-send-email-abel.vesa@nxp.com>
 <8df8afc4a50512d28247743e06f9ed30534da921.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 114e39aa-fcad-4a56-63cd-08d6c4496665
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB6000;
x-ms-traffictypediagnostic: VI1PR04MB6000:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB60002E0049EE059CF3889173EE260@VI1PR04MB6000.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(97736004)(54906003)(81156014)(99286004)(8676002)(966005)(110136005)(25786009)(53936002)(316002)(9686003)(6306002)(66446008)(64756008)(55016002)(91956017)(73956011)(66946007)(7696005)(6506007)(52536014)(5660300002)(53546011)(102836004)(6246003)(76176011)(6636002)(68736007)(186003)(71200400001)(86362001)(71190400001)(26005)(229853002)(81166006)(33656002)(446003)(7736002)(256004)(2906002)(14454004)(478600001)(66066001)(305945005)(6436002)(3846002)(8936002)(476003)(4326008)(44832011)(6116002)(74316002)(66476007)(486006)(66556008)(76116006)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6000;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O24oPMnWFWNr/8qCInWOymx4Qc89i8cJYvF+L8+ktA87L4OKOJefLlC+KAxGiK0og6EjSmRF+BNSIbHy7BshHnRNOQaSHigw0IfHP00vNhDunbmm0c5WMSbRErMqfrmce7DwS7tnGrl36Cic4eiD+zz+9+I9oV5npzWPdNorkIKwr+ydqEgGoVjAf68LvSH8kxhspB6Wt82IPkZWgqC6/T9qlW/haMOJ41L5gtsMADnv35fqmHu16z1WAVUPwufFJSs3xv+xgIjXZnwQtryBNGDU77BSvloukXw/HnU5dxEAiaeqbevlQ0wTBZSpqu8z1f93nf+7j5qT6zKcQG8MnwVkuVGADggNO5BMzu7D9m1zsJ8+x0b1nkSlTymGmJZITdFSsoKeZvSg0EhLUicNJuNhAdIQ9DosH7s0lYvK7x8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114e39aa-fcad-4a56-63cd-08d6c4496665
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 22:01:24.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/2019 6:43 PM, Leonard Crestez wrote:=0A=
> On Fri, 2019-03-22 at 16:49 +0000, Abel Vesa wrote:=0A=
>> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.=
=0A=
>> For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ=
=0A=
>> revision it will print 'unknown'.=0A=
> =0A=
>> +#define REV_B1				0x21=0A=
>> +=0A=
>> +#define IMX8MQ_SW_INFO_B1		0x40=0A=
>> +#define IMX8MQ_SW_MAGIC_B1		0xff0055aa=0A=
>> +=0A=
>> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");+=0A=
>> +	ocotp_base =3D of_iomap(np, 0);=0A=
>> +=0A=
>> +	magic =3D readl_relaxed(ocotp_base + IMX8MQ_SW_INFO_B1);=0A=
>> +	if (magic =3D=3D IMX8MQ_SW_MAGIC_B1)=0A=
>> +		rev =3D REV_B1;=0A=
> =0A=
> This is based on ATF code in vendor tree, but shouldn't we have some=0A=
> sort of explanation for this "magic"?=0A=
> =0A=
> Looking at the OCOTP driver reg 0x40 is IMX_OCOTP_ADDR_DATA2 and it's=0A=
> used as part of fuse writes. According to the driver code 8mq is=0A=
> compatible with 7d and this write path is enabled for imx8mq-ocotp.=0A=
=0A=
After further digging in NXP manuals and uboot sources it seems that =0A=
imx8mq ocotp is like imx6 rather than imx7. Posted fix for nvmem driver:=0A=
=0A=
https://patchwork.kernel.org/patch/10908081/=0A=
=0A=
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
=0A=
It might still be nice to find a way to identify imx8mq B0.=0A=
