Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD2C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9AE222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EZCBjFxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfIZN0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:26:34 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:35819
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726152AbfIZN0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqSVoe/0pSfzuTYL1ZLuYrwGyG22d4cqMkKua+W6a3E0f2X89YhA0TxaENMmadZ9CwAFgT1bZqAaElUu99z6Sjv1vwnMTSSeRueJiWq0J32IXD6EwL/z4WzOE4qwjjhYacAQIbyVglrHT3B3hqxPgMJ33NqhX45wbIYrN8yN8Iv59h35daxCPcZOMZcsOPhOpL0sKRn47HVqvuYNIAn9qsaNm3VfICJwpjf+2n3zlCRLWXm7yCBHTL7aZ2rFS2X9qdysC16QQ4fwZiudXNVlIisjneTmCc+B96BHknkpHxAcPxuM0xz0vIwghJOeFv5O5nXigdBQrJaOiVf08IXCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yag7SG4jS0Hxh9HAiKbvGip9wmeT0L/RZCmXehodIac=;
 b=KeLfRIv/nJuXVk8gy3Kw0836kFbGzDTAxdBlYnmIHQKq6FvUJj+Q/oh2/mlyvD6MEHFQFMZrRGAPpB5jAuPPTqRP/dsMx+ikGV/xqML6bMXZ8Hw4g3O2gSzOeJ659DpmNBl3P3W7NCfPtIRDwpIXyfrPKJeTeESm5WpUPmrMmBqRkq4YhNtuz1mFsCO11H45U9c0jZNH6CmSNpGMWbEvhVS2ijrgRS7n1msBqUei0gxMLj9fp/O0dShg9HcrML/1avjnLPod+dtlSTFoITqzI3o8SoVFpioCdZHMdyHTFh0rkn3ntXNs5r2G9qwTg4BSpRiv+DuRZeUF7WXpBgpEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yag7SG4jS0Hxh9HAiKbvGip9wmeT0L/RZCmXehodIac=;
 b=EZCBjFxCCX4FDASnDhdU9CmyNCJ1ACbQxtehQi7daMh1sPK5AVL5DmUY81CYpTOxlVigLGnjJkugETjnshxFORyAU0WalhtwiQ0YcDL/b2c96rklVXopXGHAqOMv7uKWjclqk+qGmB/FJm43naU5s4228asDnkzxtWOjmgsdV98=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5376.eurprd04.prod.outlook.com (20.178.120.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.22; Thu, 26 Sep 2019 13:25:50 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Thu, 26 Sep 2019
 13:25:50 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
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
Date:   Thu, 26 Sep 2019 13:25:50 +0000
Message-ID: <VI1PR04MB702336F648EA1BF0E4AC584BEE860@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
 <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
 <DB3PR0402MB391683202692BEAE4D2CD9C1F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190926100558.egils3ds37m3s5wo@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c333a10-2f41-48df-7ea8-08d742850c73
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5376;
x-ms-traffictypediagnostic: VI1PR04MB5376:|VI1PR04MB5376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5376C0647F75F4495E02B109EE860@VI1PR04MB5376.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(229853002)(55016002)(4326008)(91956017)(66946007)(6436002)(9686003)(86362001)(76116006)(186003)(71190400001)(71200400001)(81166006)(316002)(8676002)(102836004)(2906002)(5660300002)(6506007)(6246003)(53546011)(54906003)(8936002)(110136005)(26005)(478600001)(7696005)(7736002)(76176011)(486006)(476003)(33656002)(44832011)(256004)(81156014)(74316002)(305945005)(6636002)(52536014)(66446008)(66556008)(66476007)(64756008)(66066001)(99286004)(6116002)(14454004)(446003)(3846002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5376;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lQYk0GrnY0iSG0n2IytleXr3PjmGpNm7XCOBbn28391Vk5VNbn8H4psrzLBB9u9kCt77gB7yBsgWszf9uwtrUmue9du9uBcMFKCv53fjsJsDYKLzxlHcwea+tID+4F0Y36zJKKyDxfLntyLiVOX6gxkvdat7/IGwrfUG6dkfUCBvfWm2Dxb3OYK3QxCOMj26UFFwXt9h+1E8/cbh8+gDhf/ARsRL4JZqyBwjYoE5eHwDrWcBxGx0rLtcxMdq4yVyaW9/nieAk2nY7hdOjMq9+2QH6pHP5OzZhKWUqJo9WEzyrmwzMO4Nqy2H3OxPEjvVCVu7diKb6W6PTbyCz6OfXIana1Ty09gf4wwvjXhCAkq5GjOG755YOkJcEgu4aegNXtm2TXhkA3Gtji6qSq6G480z2mnupkjxbbp0bEUhQUo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c333a10-2f41-48df-7ea8-08d742850c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 13:25:50.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/To19qNnHBiRwqKNLW8HM+AesFMZcfKj3U5o+bL5g7xAWFZSlLHXHaTO014WKJpV0jHb4NyDu1IMrrfWa3vYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-26 1:06 PM, Marco Felsch wrote:=0A=
> On 19-09-26 08:03, Anson Huang wrote:=0A=
>>> On 19-09-25 18:07, Anson Huang wrote:=0A=
>>>> The SCU firmware does NOT always have return value stored in message=
=0A=
>>>> header's function element even the API has response data, those=0A=
>>>> special APIs are defined as void function in SCU firmware, so they=0A=
>>>> should be treated as return success always.=0A=
>>>>=0A=
>>>> +static const struct imx_sc_rpc_msg whitelist[] =3D {=0A=
>>>> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D=0A=
>>> IMX_SC_MISC_FUNC_UNIQUE_ID },=0A=
>>>> +	{ .svc =3D IMX_SC_RPC_SVC_MISC, .func =3D=0A=
>>>> +IMX_SC_MISC_FUNC_GET_BUTTON_STATUS }, };=0A=
>>>=0A=
>>> Is this going to be extended in the near future? I see some upcoming=0A=
>>> problems here if someone uses a different scu-fw<->kernel combination a=
s=0A=
>>> nxp would suggest.=0A=
>>=0A=
>> Could be, but I checked the current APIs, ONLY these 2 will be used in L=
inux kernel, so=0A=
>> I ONLY add these 2 APIs for now.=0A=
> =0A=
> Okay.=0A=
> =0A=
>> However, after rethink, maybe we should add another imx_sc_rpc API for t=
hose special=0A=
>> APIs? To avoid checking it for all the APIs called which may impact some=
 performance.=0A=
>> Still under discussion, if you have better idea, please advise, thanks!=
=0A=
=0A=
My suggestion is to refactor the code and add a new API for the this "no =
=0A=
error value" convention. Internally they can call a common function with =
=0A=
flags.=0A=
=0A=
> Adding a special api shouldn't be the right fix. Imagine if someone (not=
=0A=
> a nxp-developer) wants to add a new driver. How could he be expected to=
=0A=
> know which api he should use. The better abbroach would be to fix the=0A=
> scu-fw instead of adding quirks..=0A=
=0A=
Right now developers who want to make SCFW calls in upstream need to =0A=
define the message struct in their driver based on protocol =0A=
documentation. This includes:=0A=
=0A=
* Binary layout of the message (a packed struct)=0A=
* If the message has a response (already a bool flag)=0A=
* If an error code is returned (this patch adds support for it)=0A=
=0A=
Since callers are already exposed to the binary protocol exposing them =0A=
to minor quirks of the calling convention also seems reasonable. Having =0A=
the low-level IPC code peek at message IDs seems like a hack; this =0A=
belong at a slightly higher level.=0A=
=0A=
In older internal trees we use a very large amount of generated wrapper =0A=
functions. This hides calling convention details from callers but is =0A=
extremely ugly and verbose.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
