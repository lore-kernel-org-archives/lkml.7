Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9469C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18A3214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXAH4Lf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLBFHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 00:07:52 -0500
Received: from mail-eopbgr50044.outbound.protection.outlook.com ([40.107.5.44]:38063
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbfLBFHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:07:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSQq+iYClyp9YObTpVHyn1YV5OUgdVijvgCyBDymQH6TkAkoGnCSzAIDl0Wq0vmGLoDEi4w5qpbH6MlANE2BVe09Iwzq15R4rh5Il1r7Pxf8N5MaEKQ2ujqPcEa3USRN02MNLOnhSfsDmHyNHzoGHzLFb/qMbXYyXdF1LvDOx2KM//hKuCvi6EWPgZAQD3PC/YRoJK8zvDHKM/HBSsGXgvTVOGz9djD8bNWeYTBpuyGPV0yeSRh75hRfpq5DDFOKOIQv8LO/zkFB0vAddexvsAidXyfPYYxdcIJvYsLp9sPhtDf+NHSyaBfeCha0F8/OjlaMArdInlfIdGWWlrl0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUEk71V6iz/GFduNsYuas01vu7VaV5VLPvmCMeuybaY=;
 b=TE+0r2p6pSr0HEioXNrl/X3jKsBanWocF8VUaX3tQWIoJT2JCl8zP62vd4joEOwJDM3poQ8QJ288YT3jqwb6UciOSl2OiN4Jg3O6lg5LpVSlXNS6n3i/CAkyadlo2xCJQ7YPSnCme9XLkbyiQeHD3bwvVNL0DByU5VUiVX8MYuOUY9sX9mG0svASnDx+fd2DM3q5WSzN19bmkHLP8zzCGk1kNrHaDdgMCi4L4YKpMroZlu5Gdbk1sXNayS1PCqlZEPvv8Op1JDtjMcdu9vEUJmdRPVIXrVA/+6d9SogddZmh+79z8B5KCAFQzJBHZYsUasnjzSiwFDkPFYWaHecUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUEk71V6iz/GFduNsYuas01vu7VaV5VLPvmCMeuybaY=;
 b=mXAH4Lf4NHKznOoQ0MicYHV6zt01y8B27Q4m17YqObrRQT3YDCmu+C4ztNb0pwGoAbe+iqs50K+NiUc6ePwwfZGvJ6jX7cFKTryNgb2z1dIjLuXrR7B2ncBcwZ7mVRxRUI3Lx7ErmuSeQHstUJKYZDyWC+XNi+0rwp5aLE2pl1M=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.121.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 05:07:48 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 05:07:48 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Topic: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Index: AQHVjl59g0Rhyol1lkGW5Jui3luQOw==
Date:   Mon, 2 Dec 2019 05:07:48 +0000
Message-ID: <VI1PR04MB7023CAEB8ADA6B1CA0907A72EE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
 <1572356175-24950-2-git-send-email-peng.fan@nxp.com>
 <20191202011721.GA17574@dragon>
 <AM0PR04MB4481B7D74A1861558523F21488430@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a29bf61-281a-46bc-8507-08d776e59354
x-ms-traffictypediagnostic: VI1PR04MB5967:|VI1PR04MB5967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB596713F839586FE903500787EE430@VI1PR04MB5967.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(76176011)(7696005)(6506007)(53546011)(66066001)(99286004)(6636002)(71190400001)(71200400001)(74316002)(4326008)(44832011)(86362001)(110136005)(229853002)(54906003)(256004)(102836004)(446003)(316002)(305945005)(6246003)(7736002)(6436002)(6306002)(9686003)(26005)(8676002)(55016002)(52536014)(14454004)(6116002)(81156014)(3846002)(2906002)(186003)(33656002)(8936002)(966005)(81166006)(478600001)(25786009)(66476007)(66556008)(64756008)(66446008)(91956017)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5967;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jP5wiRyf1JaltBduvEMcF6tdViLKGmbiUu3GMHGJNAIGWKoM5a3Y+a31A6T8KdchiNIaUrlJpb1XYm9Ujramh0b4rPaVXbqCc/R9OxlGsah3lVwEwv4vnFRmhdW2fE5wpPDZP4s9gSDXYI+j+m17GoY4bg+hSTfUeL0pL5BINL6iMqMSwmDb1lOOjjDT+bjcun6jiMYXdIloPsu2pWNKpIf7wJU3hpJ0Zkhj5gnxer0MiPNRfpcNnDDwxLKi+MFzss/zknSaX4nwect3YoFV/b7sIXFyEtQVdhGaAT3DRJRvuf2MigGxhpUQjv7yEvNUuxc1w+K+gMVIajs4sYiehN1K7t38L7lBwuRlwhZyiyIJH/3rjSxIOYswJMeoFp6fNLEc5s5h5fLQbFF7zo5mPAAcQKo3Ik79c1uYfQMHntu9TZMMIJ+sHGrtMjVfiqGgvubyjta5j9bySayO3yO6yVNLhdPm0f/C095G40RA1M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a29bf61-281a-46bc-8507-08d776e59354
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 05:07:48.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqVqF1mJ6G1KBnafD//XAyPKPAV3g5MgpB89p7ajRl0b0OG5AgSLyPVBSdtWozzBHxAGlQcRDKRV3EC3DOhD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5967
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-02 4:26 AM, Peng Fan wrote:=0A=
>> Subject: Re: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based A=
PI=0A=
>> On Tue, Oct 29, 2019 at 01:40:54PM +0000, Peng Fan wrote:=0A=
>>> From: Peng Fan <peng.fan@nxp.com>=0A=
>>>=0A=
>>> Switch the imx_clk_pll14xx function to clk_hw based API, rename=0A=
>>> accordingly and add a macro for clk based legacy. This allows us to=0A=
>>> move closer to a clear split between consumer and provider clk APIs.=0A=
>>>=0A=
>>> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index=0A=
>>> bc5bb6ac8636..5038622f1a72 100644=0A=
>>> --- a/drivers/clk/imx/clk.h=0A=
>>> +++ b/drivers/clk/imx/clk.h=0A=
>>> @@ -97,8 +97,12 @@ extern struct imx_pll14xx_clk imx_1443x_pll;=0A=
>>> #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \=0A=
>>>   	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk=
=0A=
>>>=0A=
>>> -struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,=
=0A=
>>> -		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);=0A=
>>> +#define imx_clk_pll14xx(name, parent_name, base, pll_clk) \=0A=
>>> +	imx_clk_hw_pll14xx(name, parent_name, base, pll_clk)->clk=0A=
>>> +=0A=
>>=0A=
>> I would suggest to use an inline function for this, which will be more r=
eadable=0A=
>> and complying to kernel coding style.=0A=
> =0A=
> ok, I'll send out v2.=0A=
=0A=
Blindly dereferencing ->clk will crash instead of propagating errors so =0A=
you might want to use the to_clk helper from here:=0A=
=0A=
https://patchwork.kernel.org/patch/11257811/=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
