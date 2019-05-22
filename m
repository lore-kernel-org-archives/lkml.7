Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DAAC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA8821473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aZ7BKWeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfEVNa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:30:58 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:44002
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727975AbfEVNa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4EG07VKQFTwcomKXGlm4Oh2OlESk4AVCJdnNIXgl4k=;
 b=aZ7BKWehm30RpRmy/zMSTExZzVxCHxU1doFEMphfdqriOvZaqxYkge6gTCaP7qRcNvWiIYVpuU5qR97vJH20yYg2ztofdDVxQarKELmjUyF0aBePgEAG0PX6JKXD5CgT048J6Bd9GAExX8xyLr7kmEcV5VSeqaHEACOaUfY/NGE=
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com (20.179.252.215) by
 AM0PR04MB4404.eurprd04.prod.outlook.com (52.135.149.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Wed, 22 May 2019 13:30:54 +0000
Received: from AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec]) by AM0PR04MB6434.eurprd04.prod.outlook.com
 ([fe80::19be:75a:9fe:7cec%7]) with mapi id 15.20.1922.016; Wed, 22 May 2019
 13:30:54 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>,
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
Date:   Wed, 22 May 2019 13:30:54 +0000
Message-ID: <AM0PR04MB6434B72679CD26C22FFB420BEE000@AM0PR04MB6434.eurprd04.prod.outlook.com>
References: <20190522131304.GA5692@bogon.m.sigxcpu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd638ae9-b715-46ad-ab60-08d6deb9b720
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4404;
x-ms-traffictypediagnostic: AM0PR04MB4404:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB440473E3A23A9CC6A496096AEE000@AM0PR04MB4404.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(99286004)(6436002)(446003)(55016002)(8936002)(26005)(186003)(81166006)(81156014)(9686003)(6306002)(52536014)(68736007)(102836004)(86362001)(2906002)(8676002)(44832011)(498600001)(6506007)(53546011)(7696005)(14444005)(256004)(76176011)(66066001)(14454004)(71190400001)(71200400001)(966005)(33656002)(5660300002)(229853002)(110136005)(4326008)(6246003)(66574012)(54906003)(53936002)(74316002)(76116006)(66556008)(25786009)(7736002)(305945005)(66946007)(486006)(91956017)(6116002)(476003)(73956011)(66476007)(3846002)(66446008)(64756008)(34023003)(148693002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4404;H:AM0PR04MB6434.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RMQkG9PsX93s1YfJ8SjIt6M4/7z564V+vFvfDZNTiARNUJSHhWeIBIvWNx3pNdwoYOXrU53aORgKHKBzbQBMLYHtVpE5Vw0DhBtCBiTUYpVJDb+Zd4v9/6nqJZLR8u3VIQu5fbKisLHkxtzQCgtQgKt16ZE6wtQPgfkEO5p8IjFMIEtYxmNaGMR8WKfWM4JJnahEayMMMa8p4xhGnIeaTf4V1M0actAq+BjLOGsVoyunmYBMzxG/TL2o6Kczxhq73ZZ2eDm/D3tizj3cgd0mLgE5MwLx89d0FTe/AiS/IxPo7bqcgmdj4Qk3TsNcLZX6xTzl6woLtMyXaRfmaBfTsgYWCkY0a2IhYf6kNPqCuthWBDkw0OM3qqdK5Woq6yA+OJakMtkg+vgSYLIhTLDI4lVMbtVuiMjJ+G1YqnZ0Joo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd638ae9-b715-46ad-ab60-08d6deb9b720
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 13:30:54.1471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2019 16:13, Guido G=FCnther wrote:=0A=
> Subject: Re: [RFC PATCH] soc: imx: Try harder to get imq8mq SoC revisions=
=0A=
=0A=
Fixed subject=0A=
=0A=
> On Wed, May 08, 2019 at 02:40:18PM +0200, Guido G=FCnther wrote:=0A=
>> Thanks for your comments. Let's try s.th. different then: identify by=0A=
>> bootrom, ocotop and anatop and fall back to ATF afterwards (I'll split=
=0A=
>> out the DT part and add binding docs if this makes sense). I'm also=0A=
>> happy to drop the whole ATF logic until mailine ATF catched up:=0A=
>>=0A=
>> The mainline ATF doesn't currently support the FSL_SIP_GET_SOC_INFO call=
=0A=
>> nor does it have the code to identify different imx8mq SOC revisions so=
=0A=
>> mimic what NXPs ATF does here.=0A=
> =0A=
> Does this makes sense? If so I'll send this out as a series.=0A=
=0A=
Mainline ATF has recently caught up:=0A=
=0A=
https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/imx/i=
mx8m/imx8mq/imx8mq_bl31_setup.c#n52=0A=
=0A=
>> As a fallback use ATF so we can identify new revisions once it gains=0A=
>> support or when using NXPs ATF.=0A=
> =0A=
> I'm also fine with dropping the ATF part if we don't want to depend on=0A=
> it in mainline.=0A=
=0A=
Linux arm64 depends on ATF to implement power management via PSCI: =0A=
hotplug cpuidle and suspend.=0A=
=0A=
It is not clear why Linux would avoid other services and insist on =0A=
reimplementing hardware workarounds.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
