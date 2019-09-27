Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E81C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F585217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BfVq4tc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfI0LW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:22:27 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:7262
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0LW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfs3Oo7yC6j3H0cKfy9hIuQ926PE2jc6J4MFy0M8oFu3yG6SvYLNHFcGAcoxBPQBkhZb6tQ7PDvxk2SHlwQVLdI4vtEW2FkSsbjkS5YVDjIynJN0nFuvDSqIsVvrpRIl1V9sAq7tGr3g+/NPMxVO7x1adTQvOPpqMzOmVLk4+Z71iV0IImO2vRoT/rN5wYPGpjCSrrDt7vpyFxKxTZxfdbGKcnlD6fs7/Z2XSgDGkwsmZPw8T1J95ZEyuxmsrtA3i2AhUCvknSgqR4HDbxGyaSU6c2hx/4VykP/cEeca1/GP9j98zXf9HCySSzH8+/8BAcIfhVyc3C2NsJU+kZ0grA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtGnUUZqWh3tnqCrFanKYOojcT5l/I+/oBayKPLOrwg=;
 b=UZK5rJtp8r9cp2asCkfg7VcGOGutwT/ZIDYk+O+9Sf8/7TMjO1/bA4BxEg4eLyR0w/IwSUGTFPAwPG6Ec0ZxsU6XLAxqnysz6k7vy1rL/rp1yMXjrPD2NtqzM2pq7AlcQWdvfHmq8q82wDz7zyh5//5aoIRM+EKJ/Jo9zk1J8EvoXvan/S2YN8d5J0aM+m7pw90/KQkKgxSpm4eUiQcCPtDO0b3MZwYT7b/j5oUbWOG3Yfb8EYidw90ykVvpLF3aVEHWw86bRPd50Bqrzwh3gm1rKsAFhGPj1QX8h3OVIVLv1QdLjKdfAYs8NEpazSHLNbto0V6PXoeOP0p412aLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtGnUUZqWh3tnqCrFanKYOojcT5l/I+/oBayKPLOrwg=;
 b=BfVq4tc57zfUwFIeA5Qt8AVaGI1QBn5cLM8klwfwSiYQo/ZcGdE1LydhwRDBLlG5JBlbA34kQ3zm9waK307lckPD1ZhsBigoJTinSWd7WKM0tl8dPRrJDJbjxxct9jlYfF8Ke0sSSfUQ4M2eF/YtBnGTF2lgu09mbZcWXZdzKWM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5390.eurprd04.prod.outlook.com (20.178.120.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 27 Sep 2019 11:22:23 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 11:22:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Topic: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Thread-Index: AQHVc4lSn4nBMGf230anvZh0PllY6g==
Date:   Fri, 27 Sep 2019 11:22:22 +0000
Message-ID: <VI1PR04MB702397C54519DC27CFF05A78EE810@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190927090609.fyxdekkzrco7memt@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a188c824-5142-467e-d0f0-08d7433cf7c8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB5390:|VI1PR04MB5390:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB53905A496E87A6623FE3DB3EEE810@VI1PR04MB5390.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(66446008)(316002)(66066001)(6506007)(3846002)(5660300002)(110136005)(33656002)(54906003)(6116002)(8676002)(6636002)(81166006)(6436002)(55016002)(9686003)(6246003)(81156014)(229853002)(4326008)(186003)(76176011)(26005)(86362001)(44832011)(486006)(14454004)(256004)(478600001)(99286004)(2906002)(71200400001)(71190400001)(7696005)(305945005)(76116006)(91956017)(25786009)(66946007)(446003)(74316002)(8936002)(476003)(52536014)(7736002)(66556008)(66476007)(53546011)(64756008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5390;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QONa+sdeBvCF+D0uxCdsO7jDP72aznmHgHwZURBqbVLhIxeJP89HP60x2ZEGu2fiVz3MMZB/9X33ixXoO1/4teCrbeOT7Kd1HZkFcOdFYr36aWMiAK0InCiFM11bxnDNQcvchvGeAyt9A7wdkw5dg3U7bYOP2OxWVTDtvmVNyb5JUFUdJLXu7JR3BrxUlYdKf9ZMx1xCz+m4UzwGtIvwBPiStI78q5mTQGVQBiaDNT2PnzBSApu3Hn5ewKgHuqAZ7i7vixwYQT6/vxGIg8FYvaVjCs7e15pW2hR6/EzcYmvrj3NkjLEVrrPwA3NRp/c5sHhEGmYbrTSCqM/b3/ZzmCFVESa+90xpYu9PryQ+mvLe3FScaHy6rsXMx/eFrbG/sG1aZhZ9evVqphK6ctBJphvok7NhzyR0Jh/ff9Vd45E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a188c824-5142-467e-d0f0-08d7433cf7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 11:22:22.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IyjqYja2TdxL6pyLjiFF4wx7D8iA5zV6UNtR9/akexeIHOSvCh+e21r4xYzdyCw2Iw4yTcRoHMoD3Sc8SnPQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5390
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.2019 12:06, Marco Felsch wrote:=0A=
> Hi Anson, Leonard,=0A=
> =0A=
> On 19-09-27 01:20, Anson Huang wrote:=0A=
>> Hi, Leonard=0A=
>>=0A=
>>> On 2019-09-26 1:06 PM, Marco Felsch wrote:=0A=
>>>> On 19-09-26 08:03, Anson Huang wrote:=0A=
>>>>>> On 19-09-25 18:07, Anson Huang wrote:=0A=
>>>>>>> The SCU firmware does NOT always have return value stored in=0A=
>>>>>>> message header's function element even the API has response data,=
=0A=
>>>>>>> those special APIs are defined as void function in SCU firmware, so=
=0A=
>>>>>>> they should be treated as return success always.=0A=
>>>>>>>=0A=
>>>>>>> +static const struct imx_sc_rpc_msg whitelist[] =3D {=0A=
>>>>>>> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D=0A=
>>>>>> IMX_SC_MISC_FUNC_UNIQUE_ID },=0A=
>>>>>>> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D=0A=
>>>>>>> +IMX_SC_MISC_FUNC_GET_BUTTON_STATUS }, };=0A=
>>>>>>=0A=
>>>>>> Is this going to be extended in the near future? I see some upcoming=
=0A=
>>>>>> problems here if someone uses a different scu-fw<->kernel=0A=
>>>>>> combination as nxp would suggest.=0A=
>>>>>=0A=
>>>>> Could be, but I checked the current APIs, ONLY these 2 will be used=
=0A=
>>>>> in Linux kernel, so I ONLY add these 2 APIs for now.=0A=
>>>>=0A=
>>>> Okay.=0A=
>>>>=0A=
>>>>> However, after rethink, maybe we should add another imx_sc_rpc API=0A=
>>>>> for those special APIs? To avoid checking it for all the APIs called =
which=0A=
>>> may impact some performance.=0A=
>>>>> Still under discussion, if you have better idea, please advise, thank=
s!=0A=
>>>=0A=
>>> My suggestion is to refactor the code and add a new API for the this "n=
o=0A=
>>> error value" convention. Internally they can call a common function wit=
h=0A=
>>> flags.=0A=
>>=0A=
>>>> Adding a special api shouldn't be the right fix. Imagine if someone=0A=
>>>> (not a nxp-developer) wants to add a new driver. How could he be=0A=
>>>> expected to know which api he should use. The better abbroach would be=
=0A=
>>>> to fix the scu-fw instead of adding quirks..=0A=
>>=0A=
>> Yes, fixing SCU FW is the best solution, but we have talked to SCU FW ow=
ner, the SCU=0A=
>> FW released has been finalized, so the API implementation can NOT be cha=
nged, but=0A=
>> they will pay attention to this issue for new added APIs later. That mea=
ns the number=0A=
>> of APIs having this issue a very limited.=0A=
> =0A=
> This means those APIs which already have this bug will not be fixed?=0A=
> IMHO this sounds a bit weird since this is a changeable peace of code ;)=
=0A=
=0A=
It's not a bug, it's a documented feature ;)=0A=
=0A=
>>> Right now developers who want to make SCFW calls in upstream need to=0A=
>>> define the message struct in their driver based on protocol documentati=
on.=0A=
>>> This includes:=0A=
>>>=0A=
>>> * Binary layout of the message (a packed struct)=0A=
>>> * If the message has a response (already a bool flag)=0A=
>>> * If an error code is returned (this patch adds support for it)=0A=
> =0A=
> Why should I specify if a error code is returned?=0A=
=0A=
Because you're already defining the message struct and you're already =0A=
specifying if a response is required.=0A=
=0A=
The assumption is that anyone adding a SCFW call to a driver is already =0A=
looking at SCFW documentation which describes the binary message format.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
