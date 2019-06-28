Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6445CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A852086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="erydpXdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfF1GBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:01:10 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:21524
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfF1GBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=vMSZXLs2zgnXksxOvtguTdDtZrDo72XxHRZATH3eAktda2oBkHocBJDvvWUxSqJnWmaBfC8DWK3jpH1ym0aJpVoWYEOR4bBAmzxUm7Le3tWsjYeuvMO3pI3w2WQ28URmZqO/1SGv4KXuEPEzyQGC2zqk/PCtlIYTEAtgotEYoqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5MvjqRN8k7G3UzEiU6XyuFXA+0gesu54QUz4e9/cQk=;
 b=hx4bpta30YOriIuzTTHJm/MaM0Lj58Ws/OZlf2uO2qiLZvJcElsw9zLqCaCL/eJsqBTCOx1/FMKi/ADKAI0RmeS0pkgh8lO0Cl2NjVvjFArbC9Vz15S26WX5tKQcRJ7I+N9sQ9RS3qUMzs0EK/Te7iIXMbOzfUSLm3ak3bZuBfE=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5MvjqRN8k7G3UzEiU6XyuFXA+0gesu54QUz4e9/cQk=;
 b=erydpXdUkI1hSwJg3gWkU5SYCHaAmqrt2kW1L+UW5Gsw9EaBqTrAKrVgRqjZbX6qKlXVUW+cT/X419Sm4PO4ZYFrO5wE8AVvSpFTqXg/uo9nnX2LhOFK0FPGPrfAc2VOTnSBCqcqljH0IRINdsESPmHukRcKTwfKE1JDxqJKwfU=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB4861.eurprd04.prod.outlook.com (20.177.49.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 06:01:05 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::d83:14c4:dedb:213b%5]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 06:01:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Correct OPP table according to
 latest datasheet
Thread-Topic: [PATCH 2/2] arm64: dts: imx8mm: Correct OPP table according to
 latest datasheet
Thread-Index: AQHVLWLHJZvOkljf/UeBT/cVdVnPoQ==
Date:   Fri, 28 Jun 2019 06:01:05 +0000
Message-ID: <VI1PR04MB50555399D8A3E4890D8C91E6EEFC0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190628032800.8428-1-Anson.Huang@nxp.com>
 <20190628032800.8428-2-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:e6e7:49ff:fe63:c221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f32db33f-55e1-4e34-547b-08d6fb8e01b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4861;
x-ms-traffictypediagnostic: VI1PR04MB4861:
x-microsoft-antispam-prvs: <VI1PR04MB4861CAB1DC4DCD309769B726EEFC0@VI1PR04MB4861.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(199004)(189003)(5660300002)(52536014)(476003)(99286004)(81156014)(68736007)(66946007)(54906003)(6116002)(256004)(2501003)(110136005)(71200400001)(6246003)(6436002)(186003)(66476007)(6506007)(76176011)(7696005)(14444005)(25786009)(2906002)(55016002)(71190400001)(4744005)(46003)(229853002)(33656002)(53936002)(102836004)(53546011)(66446008)(446003)(8936002)(44832011)(316002)(478600001)(73956011)(7416002)(7736002)(76116006)(9686003)(8676002)(66556008)(486006)(4326008)(74316002)(14454004)(305945005)(86362001)(81166006)(64756008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4861;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OxpCvGmj1WZuuAde2/P+msuo2ONlEXSza09xe1UrYCZX9QQedTyOb/QFeMmWeVBcNp1Nnvl/buDFqPtdPZ/EAWi1Yr/5BEpHK2ekF+d3WZ3Nxmh/fdOgF/E8s/edMBjCjdZVy2twRiiYb9+Bg+n4rFztEtWlWdtqBvoEG3KJotLNylrLkahgOpTwOTiPoCu8xKjxVTXcPFxVh8wYhn3qZAaHFvAmfRm8LiO3EqEFyK8Yzozaeu2bS8VsXZGDl3X95PS2WS6gZ2D4u3RSIQH6tEWJVkJbvH7J2xLrJWP2jk3O5EW6I5mmxFIfCwBGOdBUg269tzyqwga9NVQg3EH5K5Q7F3FQuqdhd/qi0ksiYFB5EXerYk2lgK36vZhDu1km5AYIvK25PrHIxALzEF5NEicjaqSMgnncqacy9wStvhA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32db33f-55e1-4e34-547b-08d6fb8e01b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 06:01:05.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2019 06:37, Anson.Huang@nxp.com wrote:=0A=
=0A=
> According to latest datasheet (Rev.0.2, 04/2019) from below links,=0A=
> 1.8GHz is ONLY available for consumer part, so the market segment=0A=
> bits for 1.8GHz opp should ONLY available for consumer part accordingly.=
=0A=
> =0A=
>   			opp-hz =3D /bits/ 64 <1800000000>;=0A=
>   			opp-microvolt =3D <1000000>;=0A=
>   			/* Consumer only but rely on speed grading */=0A=
> -			opp-supported-hw =3D <0x8>, <0x7>;=0A=
> +			opp-supported-hw =3D <0x8>, <0x3>;=0A=
=0A=
Only consumer parts should be fused for this highest OPP. If you don't =0A=
want to rely on this then maybe also delete the comment above?=0A=
=0A=
--=0A=
Regards,=0A=
leonard=0A=
