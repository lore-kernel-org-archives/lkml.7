Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C6BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931B92332A
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mQJI4Qnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfHUUkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:40:02 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:65444
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfHUUkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH2oiBBQKcP2oLHqswKTCii4bFEW8jzkEk1Ild0hnuw7oslSWyyKA6kbzp+z07ObxX7T5yMqLl11lTNNo6FllwmfM1OFqQP/18Dw9HxfVdx5Zytw9NZtJ/H6jJpjwU5Mwf78uccI1XvFUXABg6CnOdV0/VLAeHR5guKF1kAOTx/xnCfRVBR6cq7vdt2S0PJQqAeA+nZdgdYWhEXJSC6/cwObx5HzxZmB2RJ7C5+gTy4Dax7TuLQgGpwlUe+2+cZx7+vjnF6kXGXNMp3pptkFgQFgXusE6CZRVCqjbgvAHoeB/4nkZmpyoEN+y3FMIfPWn27yiin2kfuB2fSWq8P1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTNaENpdVtJijgn3pQot9Y0mkqpi42y19eYJ8kKrnfM=;
 b=nZmdDe4L5zDp0kwdQLgthNgwDTrxP/yVWNYNP+gHkSxb9nEK4Xc5wuineEdVSSKnmh3CC2q6oncEwL10NawcXcgl2/+0JCqtYLpAjb6Z2w1u6FdN/CkOEc1UPbL5TeLiKTXwrWKp9BYzTtEOPDp+5y1hi4hHn+DyC8kt1TOPUSv1dWxiiL8ORZuiBA3QvSWA4o8nJzuZmEbpogVes1GV4blTSec7Q6kpyk813kGDf7OLqyV2vAfRvKSQ6eNOPesgS0rClv3OyB2YffsDLkmzXL7jH9LhYXwsqPKHrpriuzNWMqf4ZUfSHC+dglo915UDUP+tRIFTYGPMPj94JAAg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTNaENpdVtJijgn3pQot9Y0mkqpi42y19eYJ8kKrnfM=;
 b=mQJI4QncipYUoJzN9vaPSFOswBVgFZmSZ15nnpJWQ78wytlp4SaIrNemp6GMSE5VgYIbE+yjHcSHMt+e2tFfAU2zLTdUj5UwGF2mo+8SlabJXhIH1XA7iQZbDvk6RtnePeIGxwYperG8oi1i15UGK4XUt1JYV2PazsXyH+1k2QY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3293.eurprd04.prod.outlook.com (10.170.231.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 20:39:56 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 20:39:56 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs for
 clocks
Thread-Topic: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs
 for clocks
Thread-Index: AQHVRVgHX+vi+LJNg0ufd7EEy7KERw==
Date:   Wed, 21 Aug 2019 20:39:56 +0000
Message-ID: <VI1PR04MB70239C63D88ED27D929E29C1EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190728152040.15323-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c61d291f-35ce-4134-8403-08d72677ba18
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3293;
x-ms-traffictypediagnostic: VI1PR04MB3293:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3293AF016B3FD811E21DE54EEEAA0@VI1PR04MB3293.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(199004)(189003)(6436002)(7736002)(81166006)(71200400001)(2501003)(305945005)(74316002)(229853002)(25786009)(66066001)(55016002)(71190400001)(9686003)(44832011)(53546011)(6506007)(476003)(2906002)(81156014)(5660300002)(486006)(446003)(14454004)(52536014)(186003)(26005)(8676002)(102836004)(54906003)(99286004)(110136005)(6636002)(76176011)(76116006)(53936002)(7696005)(478600001)(33656002)(8936002)(316002)(7416002)(256004)(4326008)(6116002)(3846002)(86362001)(66446008)(66946007)(6246003)(66476007)(66556008)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3293;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nskwv3f3kHMYD+qYyjlM44//nPkscpkyQf2HIijZvlB3FRv4AAlXpZkzusnzI6heVhwPhd/0uUxguDeiH5i7krvGcB0vfozK2exKcippRg9VAKYrdtnjLce/4hsFBOAmXlJdXzXKYpec43wxMZuh0/mosyBWyssnUmX3g47c8fp5AdUEaVInYJAiwmdIxqUrlqJ+BkOAV0jKIxD/e1so8TV3Uj3JsiSeubqc/bNheClSFwRE4v1hSz8xQlGviQsJMizLp11M991AXDsL24qv1XW4YqYtUP3EvNutcGEW8o0ROw8WEwvDbVf7tU+hcaHodSp6KKMBKcAHoy3vMeaMnkTp9qbn9Cxb4urtkqPT9Wd1SAQ1JNnrwVHGZiYVbYBz5IXO54nMuyg2JortlqEqeXjtuCJTZrskxQWeG1vIdf8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61d291f-35ce-4134-8403-08d72677ba18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 20:39:56.0116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gluK+HYspweKS2HObGCCufjxR5APrAYLj7DglvaFo2Eyen7OLEseU2vIzXFaE7gar5IOxIe6Bk4x9aklZrD2vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2019 18:20, Daniel Baluta wrote:=0A=
> From: Abel Vesa <abel.vesa@nxp.com>=0A=
> =0A=
> Add the initial configuration for clocks that need default parent and rat=
e=0A=
> setting. This is based on the vendor tree clock provider parents and rate=
s=0A=
> configuration except this is doing the setup in dts rather then using clo=
ck=0A=
> consumer API in a clock provider driver.=0A=
> =0A=
> Note that by adding the initial rate setting for audio_pll1/audio_pll=0A=
> setting we need to remove it from imx8mq-librem5-devkit.dts=0A=
=0A=
Setting default rates for audio_pll1 and audio_pll2 in soc dtsi makes a =0A=
lot of sense to me; the intention is for one to run at a multiple of =0A=
44.1k and another at a multiple of 48k.=0A=
=0A=
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi=0A=
> index 02fbd0625318..a55d72ba2e05 100644=0A=
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi=0A=
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi=0A=
> @@ -494,6 +494,25 @@=0A=
>   				clock-names =3D "ckil", "osc_25m", "osc_27m",=0A=
>   				              "clk_ext1", "clk_ext2",=0A=
>   				              "clk_ext3", "clk_ext4";=0A=
> +				assigned-clocks =3D <&clk IMX8MQ_VIDEO_PLL1>,=0A=
> +					<&clk IMX8MQ_AUDIO_PLL1>,=0A=
> +					<&clk IMX8MQ_AUDIO_PLL2>,=0A=
> +					<&clk IMX8MQ_CLK_AHB>,=0A=
> +					<&clk IMX8MQ_CLK_NAND_USDHC_BUS>,=0A=
> +					<&clk IMX8MQ_CLK_AUDIO_AHB>,=0A=
> +					<&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,=0A=
> +					<&clk IMX8MQ_CLK_NOC>;=0A=
> +				assigned-clock-parents =3D <0>,=0A=
> +						<0>,=0A=
> +						<0> > +						<&clk IMX8MQ_SYS1_PLL_133M>,=0A=
> +						<&clk IMX8MQ_SYS1_PLL_266M>,=0A=
> +						<&clk IMX8MQ_SYS2_PLL_500M>,=0A=
> +						<&clk IMX8MQ_CLK_27M>,=0A=
> +						<&clk IMX8MQ_SYS1_PLL_800M>;=0A=
> +				assigned-clock-rates =3D <593999999>,=0A=
> +						<786432000>,=0A=
> +						<722534400>;=0A=
=0A=
The audio PLLs should run below 650 mHz so please use 393216000 and =0A=
361267200 instead of 786432000 and 722534400. For the 8mm equivalent see =
=0A=
commit 053a4ffe2988 ("clk: imx: imx8mm: fix audio pll setting").=0A=
=0A=
You should also move the unbypassing of AUDIO_PLL1 and AUDIO_PLL2 here =0A=
just add two more assigned-clocks and assigned-clock-parents.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
