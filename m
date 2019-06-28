Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2DDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634312147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m530JtJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfF1F6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:58:50 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:56896
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbfF1F6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:58:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=mTu4g7kRZ7Px/aEQUOpas/HMn/cgwk11gpWJ6eRYX8ECZAu756A2ybaCjBVGF/LKFysiUwiseAe26S9P11NfLEZjJncD/Ya37VUpjri4d+Tc2oaXCv613aH0ruhvQ1Mn0ExvkPhCmGibR3FupCR6hI9ezZT8rg8p90YNvm8+kNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgIr4hod7oBTVXDZKPq7UkOTgNGV5qmVQbm6noRygpA=;
 b=S2IZSwg8lfPMRgclC4UYhGwinLanwCQXQNcvhESggYadVvtt+qLHn2G88goL1eNdtdLKrTIym1zUCScVOn54RxyrAK3Lpw43sWpey10zzN79c1daFEBrmjnld7/YU00HeNdGs+DxbSVnim+RMED0SUH5FeKRcE+oLYjmgDW61V8=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgIr4hod7oBTVXDZKPq7UkOTgNGV5qmVQbm6noRygpA=;
 b=m530JtJjEZH8uQKFcfU+uzeIxpzglQloXZGsc6Z93z9lfqQFswAHgHfzCrDrkZ4ki63ywgn7XLVlVe97LuqaXBGGhgsw4jjxwwlf92vKpFaS+P0vHQjjEdc28sISQQAk1+3PvI7tbfbi4wp5g5XIbeZ+WqmDA4EDyBlmkHZG9Ec=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB3023.eurprd04.prod.outlook.com (10.170.228.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 05:58:42 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 05:58:42 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: Correct OPP table according to
 latest datasheet
Thread-Index: AQHVLWLGEgwa/2nQ4E+GYs5uFNg8hw==
Date:   Fri, 28 Jun 2019 05:58:42 +0000
Message-ID: <VI1PR04MB50553915C0D978A8019BDC5CEEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190628032800.8428-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:e6e7:49ff:fe63:c221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f41d2f26-ff64-43c7-529a-08d6fb8dacc6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3023;
x-ms-traffictypediagnostic: VI1PR04MB3023:
x-microsoft-antispam-prvs: <VI1PR04MB3023D56AB103540FC6599E54EEFC0@VI1PR04MB3023.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(25786009)(33656002)(66556008)(478600001)(76176011)(5660300002)(2906002)(53546011)(305945005)(66476007)(66446008)(44832011)(9686003)(55016002)(7696005)(64756008)(14454004)(256004)(6246003)(14444005)(52536014)(7736002)(54906003)(73956011)(110136005)(66946007)(446003)(68736007)(102836004)(53936002)(71190400001)(81156014)(81166006)(2501003)(6116002)(229853002)(486006)(316002)(186003)(8676002)(6436002)(74316002)(8936002)(71200400001)(7416002)(76116006)(86362001)(4326008)(476003)(46003)(6506007)(99286004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3023;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J44+bz+bmMKg1ZDyfeTaRDiUjr1KmTU7x0rt8+vNhyHZwKEbOW5d5kzHI7d4kOVbl8qh736/pJQUpDhp5rd+2Ce7ovYn4su9D/QnFB3nOvkubSGLe4kEFqoXp4hsClkERzrCtCUsb7nrPRbGUS9EK+zjknncPAliiAFvZ6gWXr8UlG3ty13LhhDsysN0y9/zQfoIcUIIxjIN2Coymj0zHxvH0EG72WXU4wVFtgm8KkN/8JZObQf5eP3h+wlqOlLWvOn8Eu0XBTaWs7/8U7E4/xTn9i8wxpYpAnvXhiyd6rb28X8R40ny2YLFFnrg3/2yAmZumG0ZQU60lzHP9foH+bSL3nVcvrssdpbLPmSdd8A2zbMNZo65ydXTv+Q2XaMk1oueBX7NWRpf9eojDYgGAEArrfXp1L9XMF5FdDc6Elw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41d2f26-ff64-43c7-529a-08d6fb8dacc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 05:58:42.5373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2019 06:37, Anson.Huang@nxp.com wrote:=0A=
> From: Anson Huang <Anson.Huang@nxp.com>=0A=
> =0A=
> According to latest datasheet (Rev.1, 10/2018) from below links,=0A=
> in the consumer datasheet, 1.5GHz is mentioned as highest opp but=0A=
> depends on speed grading fuse, and in the industrial datasheet,=0A=
> 1.3GHz is mentioned as highest opp but depends on speed grading=0A=
> fuse. 1.5GHz and 1.3GHz opp use same voltage, so no need for=0A=
> consumer part to support 1.3GHz opp, with same voltage, CPU should=0A=
> run at highest frequency in order to go into idle as quick as=0A=
> possible, this can save power.=0A=
=0A=
I looked at the same datasheets and it's not clear to me that 1.3 Ghz =0A=
should be disallowed for consumer parts. Power consumption increases =0A=
with both voltage and frequency so having two OPPs with same voltage =0A=
does make sense.=0A=
=0A=
>   			opp-hz =3D /bits/ 64 <1300000000>;=0A=
>   			opp-microvolt =3D <1000000>;=0A=
> -			opp-supported-hw =3D <0xc>, <0x7>;=0A=
> +			/* Industrial only but rely on speed grading */=0A=
> +			opp-supported-hw =3D <0xc>, <0x4>;=0A=
=0A=
Comment is false, you're explicitly excluding consumer parts via the =0A=
second element.=0A=
=0A=
>   			opp-hz =3D /bits/ 64 <1500000000>;=0A=
>   			opp-microvolt =3D <1000000>;=0A=
>   			/* Consumer only but rely on speed grading */=0A=
> -			opp-supported-hw =3D <0x8>, <0x7>;=0A=
> +			opp-supported-hw =3D <0x8>, <0x3>;=0A=
=0A=
If you don't want to rely on the fact that only consumer parts should be =
=0A=
fused for 1.5 Ghz then please delete the comment.=0A=
