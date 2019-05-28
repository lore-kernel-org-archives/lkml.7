Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB9CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22313214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P2Q67/IW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfE1NhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:37:19 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:36675
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727538AbfE1NhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2dOFtwREv0U+Q0wESCenZac7wlxESExSIWpm12qi1U=;
 b=P2Q67/IWgJMc24ecQE4Zl0FQp7ocknRB7qw6YvyoX8TtVF87k9dD1iimvSat8hz7fpS1kpTTl+tXYCemYWOhx3VI4MZEOgZiyi/HeiZP+HPrESY1baqGIVXzbOCM737533uSYf/53JO3yTb4q3VWUrRSSgmUy5mWZLgPebShVh4=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB4960.eurprd04.prod.outlook.com (20.177.49.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Tue, 28 May 2019 13:37:15 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 13:37:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>
CC:     Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions
Thread-Topic: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions
Thread-Index: AQHVEKAZarE5OuVeAEC7HAm8UuJafQ==
Date:   Tue, 28 May 2019 13:37:15 +0000
Message-ID: <VI1PR04MB505574DFE06BFF0A894C22F0EE1E0@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190522131304.GA5692@bogon.m.sigxcpu.org>
 <AM0PR04MB6434B72679CD26C22FFB420BEE000@AM0PR04MB6434.eurprd04.prod.outlook.com>
 <1558532450.2624.44.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 447cde2e-1c71-4c0d-c210-08d6e37198fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4960;
x-ms-traffictypediagnostic: VI1PR04MB4960:
x-microsoft-antispam-prvs: <VI1PR04MB496065E59D80A237710AEC56EE1E0@VI1PR04MB4960.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(8676002)(68736007)(7736002)(8936002)(81166006)(81156014)(3846002)(2906002)(6116002)(186003)(26005)(110136005)(53546011)(6506007)(54906003)(102836004)(33656002)(446003)(76176011)(486006)(316002)(476003)(99286004)(44832011)(7696005)(86362001)(14454004)(229853002)(71190400001)(71200400001)(9686003)(55016002)(74316002)(25786009)(14444005)(256004)(6436002)(66574012)(52536014)(5660300002)(76116006)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(66066001)(4326008)(6246003)(53936002)(478600001)(34023003)(148693002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4960;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pUJMATtwU0KPpFgHOm3KnquYSnwpBH4Rzt0gRXpf4BM+Xq5cQtq4QMUV2l1+6m4p16U2e1uiPHqhZZA70B9f3qx+DXr253lDjHtS9M1q+LhFUfGqEdrjvmu/vF329XIOQQpWTIMIgTfhMqRdSlDvCc7fj2qC3ycSfYXqFFCBzFcYpY550WO3mHPjw1HhXknpbD0bniWF5BZOd8P/xb1JMKq4Y+O+aF27ZS9gsokq/yd6osWdnxf+/3IsXfY151TsJLJ7hxpUZd8cUVmVYtRMmeXIc9cY47rI+yfNg24q3Gp7jd7d1coknxgNbpKmFiKRR0QdPVWAn6fk/sKOjuur+rwyNGdPPRQ+613/wFR5C2Y8SiocT3b+BwwdyafBuGANDyJmB47zH+Fr3UVTHvF4TFiaV+n+nZq9JC5XyjH76ME=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447cde2e-1c71-4c0d-c210-08d6e37198fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 13:37:15.5654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4960
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2019 16:40, Lucas Stach wrote:=0A=
> Am Mittwoch, den 22.05.2019, 13:30 +0000 schrieb Leonard Crestez:=0A=
>> On 22.05.2019 16:13, Guido G=FCnther wrote:=0A=
>>> Subject: Re: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisio=
ns=0A=
>>> On Wed, May 08, 2019 at 02:40:18PM +0200, Guido G=FCnther wrote:=0A=
=0A=
>>>> Thanks for your comments. Let's try s.th. different then: identify by=
=0A=
>>>> bootrom, ocotop and anatop and fall back to ATF afterwards (I'll split=
=0A=
>>>> out the DT part and add binding docs if this makes sense). I'm also=0A=
>>>> happy to drop the whole ATF logic until mailine ATF catched up:=0A=
>>>>=0A=
>>>> The mainline ATF doesn't currently support the FSL_SIP_GET_SOC_INFO ca=
ll=0A=
>>>> nor does it have the code to identify different imx8mq SOC revisions s=
o=0A=
>>>> mimic what NXPs ATF does here.=0A=
>>>=0A=
>>> Does this makes sense? If so I'll send this out as a series.=0A=
>>=0A=
>> Mainline ATF has recently caught up:=0A=
>>=0A=
>>>> As a fallback use ATF so we can identify new revisions once it gains=
=0A=
>>>> support or when using NXPs ATF.=0A=
>>>=0A=
>>> I'm also fine with dropping the ATF part if we don't want to depend on=
=0A=
>>> it in mainline.=0A=
>>=0A=
>> Linux arm64 depends on ATF to implement power management via PSCI:=0A=
>> hotplug cpuidle and suspend.=0A=
>>=0A=
>> It is not clear why Linux would avoid other services and insist on=0A=
>> reimplementing hardware workarounds.=0A=
> =0A=
> I fully agree. We should not duplicate functionality between ATF and=0A=
> Linux kernel.=0A=
=0A=
Excellent, will remember this when debating who should manipulate GPC.=0A=
=0A=
Guido: Are you going to resend a variant of your V1?=0A=
=0A=
You mentioned that you need this for erratas, how exactly are you going =0A=
to fetch soc revision from a driver? For 32bit imx there is a global =0A=
imx_get_soc_revision(), maybe the definition could be moved from =0A=
arch/arm/mach-imx/cpu.c to drivers/soc/imx/revision.c so that it's =0A=
available everywhere?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
