Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E50C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D22081B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4+PysdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfI3H3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:29:02 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:19975
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfI3H3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPLxeooJMpRY1DkT4Eh9NaXCP4PKTP70aSuTTKuLUrP9ln/cEXE+/OzgiFEAzXvZyDjGUtzclAR+8Ee8fFfCRL8mHR8THUpENfyi+I8AdI7pK+6Pp6lI0XKNtFzbxb1FgTfUYTXoO5DGeMbicafkci3GnHPX5qmpUKi9WkokiMWbQ8HMBFGRkQiqT5gE/o6USw6Iunrs7u2DR4jrCgC0NzDOQMTispM9/OxxmPzVrIDAh9hTbNr5lS8Tmb7dLBpJLXbWzUn+Rdi9uOVtLMlKzb7yfvF/8B8lmwHYdodECGe8lrddU1nef9ynRruSfQU9LIF2BzYc78g52are/XXr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLgmKVfne/pz1rv76xu6EYh3hkTNDQx84GH3+bvVwjQ=;
 b=cR9mg2KLVWkCCqVviicDo/yLZJIrGw6dIyIFrTmzmsTi9PawNRnHED+CimEeFrCmUfLEcGup8bejFe9TrPyW2BgRjAX3ysVQg/lX5g2DlOW+rBGtTxQ5W42hU3yTjo7oF2yVVwp23OiYkz9pQI+nlC0f4xg0YMXt+6WR0UU4rV7AriO4D5aix60G1WZRNSfylfwMLNhB/kQV4D05id5WQmJggsjZRdDpYGSA7JQYfvBcBcYCf9bQEOajwzBZsVavYXbK5pnlmGhu9jia0kaa9ib4Qho1MQFWVbtERkn0itD4Etf/j6ynxJ6hmMqoZ0wJQXU/bjeaaqyB3oZzT+LNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLgmKVfne/pz1rv76xu6EYh3hkTNDQx84GH3+bvVwjQ=;
 b=B4+PysdYMZxpSnI5VxirzLROGOzpEDPxGV10iIJ16HoSvJARYGf8rlC+n/MSZytvE+vLDrhXFiYj7QQs2wL3vBESY6NHcuCPlGUnrVQ2NdObvPOxTkyG736Vqk6ZH3RtAdgKubH9OcizZxKtV/RL4s3MWBFQu9+44BcvGWPYRe8=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3120.eurprd04.prod.outlook.com (10.170.229.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 07:28:54 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::2ce6:267:b2a6:9902%2]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 07:28:54 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Date:   Mon, 30 Sep 2019 07:28:54 +0000
Message-ID: <VI1PR04MB702322F2F020A527AD2F8DDEEE820@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
 <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <DB3PR0402MB391675F9BF6FCA315B124BEBF5810@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [82.144.34.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b9aa49-871f-4729-a6d6-08d74577d940
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB3120:|VI1PR04MB3120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB312005556B4A0F3EECAACC13EE820@VI1PR04MB3120.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(33656002)(476003)(44832011)(14454004)(2906002)(6116002)(5660300002)(305945005)(6636002)(52536014)(486006)(3846002)(71200400001)(71190400001)(8936002)(55016002)(76176011)(7696005)(6436002)(66066001)(102836004)(74316002)(6246003)(4326008)(81166006)(81156014)(76116006)(91956017)(66946007)(53546011)(6506007)(26005)(66446008)(66476007)(478600001)(229853002)(7736002)(186003)(64756008)(25786009)(446003)(8676002)(110136005)(66556008)(54906003)(256004)(316002)(86362001)(9686003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3120;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9uitgTNpvv5ugH11BjJZXBlLd6EHvmFtJGr9gue1W/X3zxE1PRHRSLNAFdhB4in9J803VSUpIEJoDdOilPjUXlAuHjusJiV8aoqz6vtFYTN6Gcryd42mxOElB1NqgHmGaSW9aoOh/IcP6ctNuIz8a/zK70jpbuQXm2NEg6/CCs8YlFlyDS/DUWD2LHIofPRI+l00ndF5eNqUwM4j3MV6k2UnuawjvCGF8B+vcdlA+zhh+PI1YuUOXkkuryaYmXXvYNIWrFe3mFr5JG1ps97NkuN0Vtfso3NiGZhiturVOMd8SJkHVxsRsWipgk60k0MRu/XXpHoLr192xYyvxoaw96W+KH/Hr+5dof4kV6Ri57xGCj5IUkra7PF4gvEZTselVnlHneUIr+Ch8uIOs/SXXNtzEBjaBrbmY+U0UrocuzI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b9aa49-871f-4729-a6d6-08d74577d940
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 07:28:54.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /J7iUK9ghqZDoHsTDfOwhHFQrgaD2YgAmMEJXP9ETfH85uMcrRtK4ndYBweArc4OqFcdHf08jHG5+h6/1uPZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-27 4:20 AM, Anson Huang wrote:=0A=
>> On 2019-09-26 1:06 PM, Marco Felsch wrote:=0A=
>>> On 19-09-26 08:03, Anson Huang wrote:=0A=
>>>>> On 19-09-25 18:07, Anson Huang wrote:=0A=
>>>>>> The SCU firmware does NOT always have return value stored in=0A=
>>>>>> message header's function element even the API has response data,=0A=
>>>>>> those special APIs are defined as void function in SCU firmware, so=
=0A=
>>>>>> they should be treated as return success always.=0A=
>>>>>>=0A=
>>>>>> +static const struct imx_sc_rpc_msg whitelist[] =3D {=0A=
>>>>>> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D=0A=
>>>>> IMX_SC_MISC_FUNC_UNIQUE_ID },=0A=
>>>>>> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D=0A=
>>>>>> +IMX_SC_MISC_FUNC_GET_BUTTON_STATUS }, };=0A=
>>>>>=0A=
>>>>> Is this going to be extended in the near future? I see some upcoming=
=0A=
>>>>> problems here if someone uses a different scu-fw<->kernel=0A=
>>>>> combination as nxp would suggest.=0A=
>>>>=0A=
>>>> Could be, but I checked the current APIs, ONLY these 2 will be used=0A=
>>>> in Linux kernel, so I ONLY add these 2 APIs for now.=0A=
>>>=0A=
>>> Okay.=0A=
>>>=0A=
>>>> However, after rethink, maybe we should add another imx_sc_rpc API=0A=
>>>> for those special APIs? To avoid checking it for all the APIs called w=
hich=0A=
>> may impact some performance.=0A=
>>>> Still under discussion, if you have better idea, please advise, thanks=
!=0A=
>>=0A=
>> My suggestion is to refactor the code and add a new API for the this "no=
=0A=
>> error value" convention. Internally they can call a common function with=
=0A=
>> flags.=0A=
> =0A=
> If I understand your point correctly, that means the loop check of whethe=
r the API=0A=
> is with "no error value" for every API still NOT be skipped, it is just r=
efactoring the code,=0A=
> right?=0A=
=0A=
There would be no "loop" anywhere: the responsibility would fall on the =0A=
call to call the right RPC function. In the current layering scheme =0A=
(drivers -> RPC -> mailbox) the RPC layer treats all calls the same and =0A=
it's up the the caller to provide information about calling convention.=0A=
=0A=
An example implementation:=0A=
* Rename imx_sc_rpc_call to __imx_sc_rpc_call_flags=0A=
* Make a tiny imx_sc_rpc_call wrapper which just converts resp/noresp to =
=0A=
a flag=0A=
* Make get button status call __imx_sc_rpc_call_flags with the =0A=
_IMX_SC_RPC_NOERROR flag=0A=
=0A=
Hope this makes my suggestion clearer? Pushing this to the caller is a =0A=
bit ugly but I think it's worth preserving the fact that the imx rpc =0A=
core treats services in an uniform way.=0A=
=0A=
>>> Adding a special api shouldn't be the right fix. Imagine if someone=0A=
>>> (not a nxp-developer) wants to add a new driver. How could he be=0A=
>>> expected to know which api he should use. The better abbroach would be=
=0A=
>>> to fix the scu-fw instead of adding quirks..=0A=
> =0A=
> Yes, fixing SCU FW is the best solution, but we have talked to SCU FW own=
er, the SCU=0A=
> FW released has been finalized, so the API implementation can NOT be chan=
ged, but=0A=
> they will pay attention to this issue for new added APIs later. That mean=
s the number=0A=
> of APIs having this issue a very limited.=0A=
> =0A=
>>=0A=
>> Right now developers who want to make SCFW calls in upstream need to=0A=
>> define the message struct in their driver based on protocol documentatio=
n.=0A=
>> This includes:=0A=
>>=0A=
>> * Binary layout of the message (a packed struct)=0A=
>> * If the message has a response (already a bool flag)=0A=
>> * If an error code is returned (this patch adds support for it)=0A=
>>=0A=
>> Since callers are already exposed to the binary protocol exposing them t=
o=0A=
>> minor quirks of the calling convention also seems reasonable. Having the=
=0A=
>> low-level IPC code peek at message IDs seems like a hack; this belong at=
 a=0A=
>> slightly higher level.=0A=
> =0A=
> A little confused, so what you suggested is to add make the imx_scu_call_=
rpc()=0A=
> becomes the "slightly higher level" API, then in this API, check the mess=
age IDs=0A=
> to decide whether to return error value, then calls a new API which will =
have=0A=
> the low-level IPC code, the this new API will have a flag passed from imx=
_scu_call_rpc()=0A=
> function, am I right?=0A=
=0A=
No, I am saying that the caller (button driver) should be responsible =0A=
for calling with a special flag which states that the RPC call.=0A=
=0A=
In internal tree this is handled inside the machine-generated function =0A=
calls, right? These are mostly skipped in upstream but maybe for these =0A=
particular calls we can manually add wrappers inside =0A=
"drivers/firmware/imx/misc.c".=0A=
=0A=
And even if the functions "return void" from a SCFW perspective it still =
=0A=
makes sense to return general kernel errors, for example from mailbox.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
