Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F138C282E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB020857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 08:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gHlK29Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfDVIto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:49:44 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:20166
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbfDVItm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 04:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WptTQaU9vjun3nwR1Ka4gMyV7hk4b8VhHMKQ5LsdlgU=;
 b=gHlK29Sud2wFAv4pOzJ6qd9FA/ygrauNCuSwSWZR/6uW+tKlywAjevSU1p2kyaWTTMdmwV0jcDm2cVBxuL6EmrZbzsl4fI4hJrGna7UuWNMTs3aTgRcy2Vv5HXwToKWiDOM186mi4So7pJ7NJjodID9u51G0bk6hx9920CSjTHA=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB6269.eurprd04.prod.outlook.com (20.179.26.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Mon, 22 Apr 2019 08:48:57 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::cca7:43cf:dc13:a822%4]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 08:48:57 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
CC:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Topic: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Index: AQHU8DKsAg9Kriz6B0mooDc33xId4w==
Date:   Mon, 22 Apr 2019 08:48:56 +0000
Message-ID: <VI1PR04MB5533CED52723AE8292CFC305EE220@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
 <20190421073958.GC19962@dragon> <20190421074152.GD19962@dragon>
 <DB3PR0402MB39161C0DDFF0EEA6D8A90378F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39164B30B26CAF62EE807168F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29d42f5c-6060-4421-4426-08d6c6ff5b4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6269;
x-ms-traffictypediagnostic: VI1PR04MB6269:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <VI1PR04MB6269EA7BCCC01F396A961705EE220@VI1PR04MB6269.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(13464003)(189003)(199004)(102836004)(186003)(54906003)(26005)(93886005)(6506007)(53546011)(476003)(446003)(486006)(25786009)(33656002)(7696005)(97736004)(76176011)(4326008)(478600001)(316002)(110136005)(44832011)(14454004)(229853002)(99286004)(6436002)(91956017)(3846002)(6116002)(68736007)(81156014)(81166006)(66476007)(7416002)(8676002)(53936002)(66446008)(64756008)(66556008)(73956011)(66946007)(52536014)(55016002)(71190400001)(2906002)(66066001)(6246003)(71200400001)(8936002)(7736002)(256004)(14444005)(5660300002)(305945005)(74316002)(76116006)(9686003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6269;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WvEbwDSany0ojD/fG/FuZZtcq61fm+ZuwmyAbyeGzIpIhD2//CZl5BHkHO5fEDipJgtL3/lMo6fUwzK2h1+kCAGhOVZoGenaCoNXzwp69uUYozwtXlq1v41N+yHQWlR9ozWBGBBd3uI47u4UlFXkr8U0LfDFmXP6jPxYBgL0baoYEdu6EY+4MMviEeRuFemlurbisUIS8CFxUvZxrizCx9Bq2zInd/HqSRCU0aqcHK8FvAxQ1cz+3nJkt1zptdTv15cEEaBlgL8fgYwvSlhNFj3TlghacYMBwn/C3lGAdGIa7rCpBzpHAvvHcAv0a1HhSWj2fnx8G7lP0iQyQy6w1pHc96IFaiBUTaQMhKyoXc945gLn++M5+/DeOpBGWCJxhdbRP2t1WNySsLqATBM/hVUQRQvO/RE+sdYBxpEb+Vk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d42f5c-6060-4421-4426-08d6c6ff5b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 08:48:56.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/2019 9:46 AM, Anson Huang wrote:=0A=
>> -----Original Message-----=0A=
>> From: Anson Huang=0A=
>>> From: Shawn Guo [mailto:shawnguo@kernel.org]=0A=
>>> On Sun, Apr 21, 2019 at 03:40:00PM +0800, Shawn Guo wrote:=0A=
>>>> On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:=0A=
>>>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller=0A=
>>>>> inside, the system controller is in charge of controlling power,=0A=
>>>>> clock and fuse etc..=0A=
>>>>>=0A=
>>>>> This patch adds i.MX system controller soc driver support, Linux=0A=
>>>>> kernel has to communicate with system controller via MU (message=0A=
>>>>> unit) IPC to get soc revision, uid etc..=0A=
>>>>>=0A=
>>>>> With this patch, soc info can be read from sysfs:=0A=
>>>>>=0A=
>>>>>   drivers/soc/imx/Kconfig      |   7 ++=0A=
>>>>>   drivers/soc/imx/Makefile     |   1 +=0A=
>>>>>   drivers/soc/imx/soc-imx-sc.c | 220=0A=
>>>>> +++++++++++++++++++++++++++++++++++++++++++=0A=
>>>>>   3 files changed, 228 insertions(+)  create mode 100644=0A=
>>>>> drivers/soc/imx/soc-imx-sc.c=0A=
>>>>=0A=
>>>> Rather than creating a new driver, please take a look at Abel's=0A=
>>>> generic=0A=
>>>> i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.=0A=
>>=0A=
>> Got it, I didn't notice that this patch bas been accepted, I will redo t=
he patch=0A=
>> based on it, thanks.=0A=
> =0A=
> I have sent the new patch set to support i.MX8QXP SoC revision based on g=
eneric i.MX8=0A=
> SoC driver, however, the Kconfig modification is NOT good, it may break i=
.MX8MQ if IMX_SCU=0A=
> is NOT enabled, although we can add some warp function for SCU firmware A=
PI call to fix it,=0A=
> but after further thought and discussion with Dong Aisheng, I think we ma=
y need to roll back to=0A=
> use this patch series to create a new SoC driver dedicated for i.MX8 SoCs=
=0A=
> with system controller inside, such as i.MX8QXP, i.MX8QM etc., the reason=
 are as below:=0A=
> =0A=
> For i.MX8MQ/i.MX8MM:=0A=
> 	1. SoC driver does NOT depends on i.MX SCU firmware, so no need to use p=
latform driver=0A=
> 	     probe model, just device_init phase call is good enough;=0A=
> 	2. The SoC driver no need to depends on IMX_SCU, so it can be always bui=
lt in, no need to=0A=
> 	     check IMX_SCU config;=0A=
> 	3. The fuse check for CPU speed grading, HDCP status, NoC settings etc. =
could be added to this driver,=0A=
> 	    but they are ONLY for i.MX8MQ/i.MX8MM etc..=0A=
> For i.MX8QXP/i.MX8QM:=0A=
> 	1. SoC driver MUST depends on IMX_SCU;=0A=
> 	2. MUST use platform model to support defer probe;=0A=
> 	3. No fuse check for CPU speed grading.=0A=
> =0A=
> So, I guess the reused code for i.MX8MQ and i.MX8QXP is ONLY those part o=
f creating SoC id device node (less than=0A=
> 30% I think), all other functions are implemented in total different ways=
, that is why I created the imx_sc_soc driver=0A=
> in this patch series, so do you think we can add new SoC driver for i.MX8=
 SoC with SCU inside? Putting 2 different architecture=0A=
> SoCs' driver into 1 file looks like NOT making enough sense.=0A=
=0A=
+1 for separate SOC driver. The 8mq/8mm and 8qm/8qxp families are very =0A=
different, they just happen to share the imx8 prefix.=0A=
=0A=
It makes sense to allow people to compile one without the other and this =
=0A=
is easier with distinct SOC drivers.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
