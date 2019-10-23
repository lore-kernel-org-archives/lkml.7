Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47200CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AE92084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVtmj+m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390453AbfJWIil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:38:41 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:1448
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389913AbfJWIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:38:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwqCV/BX+/qHF/BVpoZIAoGWWJuk3wBchjtaXV5ORbMsweEYMPtd2Ct3klPLGHBLCO1bEikXJ5hPdimOuTHO/BLoVu7RcvkN573i8KS4oY3eIPlLiZAaI5cVK9/OpLId/Uw5SdJT451cOAVCOx/xO5JIffTykY7QDmRSmIDmNtcMOGmePqJNnZ1oTyYN16TdhDZ4oK5HNwkzl64nR3w8Iqj8DBOekyzlKQT6Q7uN5rGqw99TTFrGhKJW/xobDcPT82XgAKaAgmJd/IoFLSjKlVSQ9rIl/Bys/ciuaGCe8BjmSRfKyZhdVU6rV5S9POFWrsfcPuGjaB/w7rEpIVXLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qyVv2XoSnBmT8uj3uxIR7IOkKTnsoHT/E2wpQc7SzA=;
 b=B+PD4CRndHb3qlR/vRJX9+pSCql9SvpoSkZOaGVHR6AtmQBSsdFwNdbI8hLPyFtizG3Y267/xHDUeJ7/DexSEbkjaVF/32h8ifXCCvc3oEtGvr4Mr0p0RiS+UGOaU0X3P59FrI00ntaIj4b97/kyiH2df+dpA1EdiiTLvQNHleaoSmBtUmGz1jKVRuSnbjwM6sSCyFQdSg2H7yl/NeNwOXAITDbqdl8Re5BY3z4XspROpBYWZJWe/0bqQvThXu5q/EuGPA9eHqTl9hwKmDIsYYxyosMVRyz2BGkWg0OglSCjW8AZ+Pod1JfU3Ag2GfP1lAk7TT4MsNCrUsstR+fryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qyVv2XoSnBmT8uj3uxIR7IOkKTnsoHT/E2wpQc7SzA=;
 b=PVtmj+m0physl6RmXbMLYUITTfDngpcxNMVvl8oszZzgz+MCb+qPsjOBAsl7vrxOUFP+RQ9Ielpb9MFOCwWkPIPvdck/4WRcRTehSAl1jNcBYf0pgLD3rgmzrpHxbNZNVMXjQl9m2eCgWhnzSsLrOG8hmBbJiUsj548EXdL68fs=
Received: from AM7PR04MB7015.eurprd04.prod.outlook.com (52.135.57.19) by
 AM7PR04MB7032.eurprd04.prod.outlook.com (10.255.191.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Wed, 23 Oct 2019 08:38:36 +0000
Received: from AM7PR04MB7015.eurprd04.prod.outlook.com
 ([fe80::3924:7adb:47f2:2ece]) by AM7PR04MB7015.eurprd04.prod.outlook.com
 ([fe80::3924:7adb:47f2:2ece%7]) with mapi id 15.20.2367.022; Wed, 23 Oct 2019
 08:38:36 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viorel Suman <viorel.suman@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
CC:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>, Jacky Bai <ping.bai@nxp.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        Anson Huang <anson.huang@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs for
 clocks
Thread-Topic: [PATCH v4] arm64: dts: imx8mq: Init rates and parents configs
 for clocks
Thread-Index: AQHVRVgHX+vi+LJNg0ufd7EEy7KERw==
Date:   Wed, 23 Oct 2019 08:38:36 +0000
Message-ID: <AM7PR04MB7015B699FDF9F4BDB69C1499EE6B0@AM7PR04MB7015.eurprd04.prod.outlook.com>
References: <20190728152040.15323-1-daniel.baluta@nxp.com>
 <VI1PR04MB70239C63D88ED27D929E29C1EEAA0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <1571812158.5953.2.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bd9f901-222a-40d9-9ac2-08d757946554
x-ms-traffictypediagnostic: AM7PR04MB7032:|AM7PR04MB7032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB7032C7A3C4EE0720112BB8C0EE6B0@AM7PR04MB7032.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(33656002)(14454004)(54906003)(316002)(229853002)(25786009)(186003)(53546011)(6506007)(110136005)(102836004)(8936002)(4001150100001)(26005)(99286004)(7696005)(76176011)(478600001)(71190400001)(486006)(44832011)(71200400001)(81156014)(81166006)(14444005)(446003)(64756008)(66446008)(476003)(91956017)(66556008)(66946007)(66476007)(8676002)(305945005)(3846002)(74316002)(6116002)(256004)(9686003)(55016002)(7736002)(52536014)(4744005)(6246003)(7416002)(66066001)(5660300002)(6636002)(6436002)(86362001)(76116006)(4326008)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7032;H:AM7PR04MB7015.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NFPkoNc1+zkG2rr/8k5zXcMtQsWsTxMPDYe59X81B2ZDYVJm4TGyFPHqVBhQR0LbBvTd+0SRYh84CxfvdBOls3OBTH7ufr3dzCqhMWkLXpGEpMZWV7lAAUcMl5XewUKzaRY0e+dQ2j83VI66PjLvCHfBApSSVPu4zb+USTqPmSoZBxXpoZ2xFR12YMIdibIEjHYz0yBvbY0/MkghRV4gUipS+fiXoQ2LY/o8N93I95qGQfwkrurcwkGvCuAhOf9nbXP3nd8Eq4SRK3mnP6OeRCdjtPeMtLz1hi4YvrMn27BSLZ9W1sXrs46+s7FVIxyAd2EM83r/MfaVfN1zXQxEZunTo+CzFQo66RdV0aHbXqFVOoskgZHeRMy8ivg0ByuXr6fEjM4LyjU15sTQFpdnKMxW1FHT51BFb9U90Y5TDlyH+ukdHjQEgbwZMWMGbnhf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd9f901-222a-40d9-9ac2-08d757946554
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 08:38:36.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3hqBkEhdDGkOSpQNuIiudjk7ISSTLcY7/fdMS72WAcBRbcbA0SHukyvmuS3tZivP8RwB58nsSAOoZji0Iu64TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-23 9:29 AM, Viorel Suman wrote:=0A=
> On Mi, 2019-08-21 at 20:39 +0000, Leonard Crestez wrote:=0A=
>> The audio PLLs should run below 650 mHz so please use 393216000 and=0A=
>> 361267200 instead of 786432000 and 722534400. For the 8mm equivalent see=
=0A=
>> commit 053a4ffe2988 ("clk: imx: imx8mm: fix audio pll setting").=0A=
> =0A=
> Hi Leonard,=0A=
> =0A=
> Audio PLL IP on 8mm and 8mn is different than the Audio PLL IP on 8mq,=0A=
> so the requirement to run below 650 MHZ may not apply to 8mq.=0A=
=0A=
This "max 650mHz" limit is from internal ADD and is also mentioned for =0A=
imx8mq.=0A=
=0A=
Peng: you made the change in our internal tree, can you confirm this =0A=
requirement also applies to 8mq?=0A=
=0A=
Viorel: Is there any impact from 393216000 vs 786432000 on PLL on audio? =
=0A=
As far as I can know this rate goes through various dividers anyway.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
