Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A9C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524622146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 11:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J4eSe9es"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfI0LQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 07:16:31 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:10471
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727343AbfI0LQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 07:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iF42uAvftLYOHCAOrVk+WeuxY9IvFvehx7NNZV8EbogNydcXPjdmzPnF4lTE14339l0Q8snbynbIEdvIGZMZqlTQigIQbRZOaW+MEU26l3il4O/C11G118Emt/EJWEaPpCRRX88mxuRx8MYkpuboMor4Az/k6uDF1cH2i1RZ/jvyJUi6OU9SuxyT5+FEcdm0ZBXRSknB3JbRE1DivJw9uGlkSpFfafxd4PprTk9KFRxz3NFqF5F+ZGzPk86aY9irhfRiWG8JiGLgX9ehlqJH+komC6vHkBO9QDisQ9WdOCZc5CrGpQvMWpftSbSuOcJB+KsDtTXN+MuxGsyh66Y5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCKUUWno90d2RVTD0wJMjtko4AQN5aEb67px0CqKhn4=;
 b=FXB8pi3DBbzKa6DwAm+oEd+eQ0+ONo2xRdXcx/kFdr3pb+PH11YcgWbMeAPRQ7hTWwBtJCbY8D+6fcYfQiSfvPfC9O8VSfZt4FcuaVw6ZHJj2GCb98dy+TzzyQU9AY0umlNJFhMPDu2/fX/jweVbnOzBlrFHoAt1d6nGUhinGFPACsVRyOajsQ5/P22eUjLV+ZbdfoBnlniKpooQQZpqzWWX0Obvv0iwd+jq0fyjMeS0L0KWrJN9gfYLyuNMWxdG/BzB6gfBhaZUFTbzUl4UeYUp7EShLDWD807pD2yZ1L44dt/oLU5hLE2TjEaan3HW4j31vdCPHdd+wPUvG0PCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCKUUWno90d2RVTD0wJMjtko4AQN5aEb67px0CqKhn4=;
 b=J4eSe9esYQPsys9LN6S5t/iS3RlnCkENFsYH0EnMlijvRDC4yHKHdfBTchOfgBmbk8PwsdgqaRxEF6WvsX39+wwF9nZSImhnxoEbEW7/AFskpxHr37MHnxucqrH1eBhZxYc3s2zUEvm9Lyesh9BFBwGf++k/gW/CtNnZ1uDz+jw=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5311.eurprd04.prod.outlook.com (20.177.52.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Fri, 27 Sep 2019 11:16:24 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 11:16:24 +0000
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
Date:   Fri, 27 Sep 2019 11:16:24 +0000
Message-ID: <VI1PR04MB70236265478233D8025706F1EE810@VI1PR04MB7023.eurprd04.prod.outlook.com>
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
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 076cc439-c9b9-4f06-cacc-08d7433c2246
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5311;
x-ms-traffictypediagnostic: VI1PR04MB5311:|VI1PR04MB5311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB53117895A525E8FB7BB57AFEEE810@VI1PR04MB5311.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(74316002)(7736002)(5660300002)(2906002)(6436002)(229853002)(6506007)(256004)(446003)(99286004)(110136005)(53546011)(186003)(54906003)(102836004)(26005)(86362001)(52536014)(4326008)(6636002)(55016002)(81156014)(66066001)(8676002)(81166006)(14454004)(6116002)(3846002)(33656002)(66946007)(66476007)(76116006)(6246003)(64756008)(7696005)(8936002)(9686003)(66556008)(66446008)(91956017)(76176011)(71190400001)(71200400001)(316002)(25786009)(486006)(476003)(478600001)(44832011)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5311;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Se0PzbHD0S7GnMiVkMoS55SQ+qMODiFil5D9WABhQYxyz6VSMKYkVJKDEOXoRlnm0wN3Jpz3hxX3Ir4mfjEIsmrjENd0t41WAPdIpgr4LIlf6QKWjVbjaXkacYgZgsD1URQEACHg/p1oi4tkdvhDSqulRmokUvW/HELiBESHZtwwdX0xAo2rRvuEI1u6ez/1c6SOeXdjpYoaDsm2tVTyqwvsc16mK9YDjM1AXlMbNdSONrAyt8pJy54BoJtkA3YIclrkwbN4E5PRV8HFp9ESmbkOPneuEN5U+oIoN81SP5FiaX4dN0r/F+NoGmyXHWo6CwDjAkMd/Aaww9/oY+GjmsMOMV5uSU/nEcOnpvQHEoZCgZ/hIkuMEtb88ixc4ZWIunjGIrJh/JYs2w5AtpJ7Sl6N8G/kIE5xGlVVBPwow4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076cc439-c9b9-4f06-cacc-08d7433c2246
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 11:16:24.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3u2QcDEU8DV3y9oCj3+7vgizJMVzzLCDbLkCGmx+KR4VKCn2aWhxPWQ12qz229wXggkAQCIGJ6kE9rtwV2yhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.2019 04:20, Anson Huang wrote:=0A=
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
No, I mean there should be no loop enumerating svc/func ids: *the caller =
=0A=
should know* that it's calling a func which doesn't return an error code =
=0A=
and call a different variant of imx_scu_call_rpc=0A=
=0A=
Maybe add an internal __imx_scu_call_rpc_flags and turn the current =0A=
imx_scu_call_rpc into a wrapper.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
