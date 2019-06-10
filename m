Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586FDC31E74
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20775207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rBXNvGN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbfFJOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:32:44 -0400
Received: from mail-eopbgr130049.outbound.protection.outlook.com ([40.107.13.49]:55939
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403920AbfFJOco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bL1AJiMVuSmKU/Fz8D2SQXyeR8O0IVyNBaWszVajKk8=;
 b=rBXNvGN1SFdfzecutSSXMeZZZSTvA7RmmFuCp6djvDr1+IXBQvL2ji5bas/yuQ2Q0VCPildZlkE1Kc8Iu8XAwRrL4PeJX5KyDuZDoowm+6VrqYGSogFk6vuodsVAfFK+cdjAMd5DebtOmsAd2We+SLVcki3mwZKBlwtHZTgsILs=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5101.eurprd04.prod.outlook.com (20.177.50.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 14:32:37 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 14:32:37 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marc Zyngier <marc.zyngier@arm.com>, Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Abel Vesa <abelvesa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/fXLWCNQC3kGmFNlizRWSbQ==
Date:   Mon, 10 Jun 2019 14:32:37 +0000
Message-ID: <VI1PR04MB5055A808A08A1C47784E4332EE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <20190610131921.GB14647@lakrids.cambridge.arm.com>
 <20190610132910.srd4j2gtidjeppdx@fsr-ub1664-175>
 <6f1052ea-623a-b2e8-9aa8-22aef5fab4ca@arm.com>
 <20190610135514.xd5myavjsloos2y3@fsr-ub1664-175>
 <7b86aa90-6d64-589c-f11e-d2ee6ab3fd54@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 747db03d-101e-494a-9b21-08d6edb07c7e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5101;
x-ms-traffictypediagnostic: VI1PR04MB5101:
x-microsoft-antispam-prvs: <VI1PR04MB51015807F0037658101180E9EE130@VI1PR04MB5101.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(43544003)(7696005)(446003)(3846002)(26005)(81166006)(81156014)(229853002)(52536014)(5660300002)(6436002)(99286004)(76176011)(6116002)(476003)(486006)(8676002)(44832011)(55016002)(2906002)(186003)(9686003)(8936002)(256004)(14444005)(86362001)(71190400001)(7736002)(71200400001)(66446008)(66556008)(91956017)(68736007)(33656002)(305945005)(316002)(4326008)(53546011)(6506007)(73956011)(76116006)(64756008)(66476007)(66946007)(53936002)(6246003)(25786009)(66066001)(102836004)(14454004)(74316002)(7416002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5101;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BEDsLhREnqfHQqkHAm8yCk1a5zgXSSdKpMs/vwJrKsl6/EeQ95vbdhf3LKU8FxRUE+Mx33jLEbHqEMWZOzcidckVHqz2AFvNS5zz1GkoQKFd0iXwQvtDZqLoM4g0ekJUNjM3bgxKE2sCX+YL78aRH/hP+lW5+LKuHWbKwKN3xOLfDtTEgpJ75wnynXl5kKyFxyyDwkOqAWlowLaHdbFt6RI2TUdWqvNv0acZUPVixM05dQSWLk7nE3WFNUXbox74u+YyhOHll4wAyjcsa3WkuqEa2ZgnX7NoBt5VL3aikPCrWUk3CJZpxFycZdV8NrmQNE3Bt6XVFqNPtf/ZvqUvB9YmiN0cAgyl4hV3LnvMFcBRYQUTiQH9gyljhibvCzrLwhuqThAxutS+iugdM3RwddAYuD4dZHEw95c++mQSbt4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747db03d-101e-494a-9b21-08d6edb07c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 14:32:37.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/2019 5:08 PM, Marc Zyngier wrote:=0A=
> On 10/06/2019 14:55, Abel Vesa wrote:=0A=
>> On 19-06-10 14:39:02, Marc Zyngier wrote:=0A=
>>> On 10/06/2019 14:29, Abel Vesa wrote:=0A=
>>>> On 19-06-10 14:19:21, Mark Rutland wrote:=0A=
>>>>> On Mon, Jun 10, 2019 at 03:13:44PM +0300, Abel Vesa wrote:=0A=
=0A=
>>>>>> Basically, it 'hijacks' the registered gic_raise_softirq __smp_cross=
_call=0A=
>>>>>> handler and registers instead a wrapper which calls in the 'hijacked=
'=0A=
>>>>>> handler, after that calling into EL3 which will take care of the act=
ual=0A=
>>>>>> wake up. This time, instead of expanding the PSCI ABI, we use a new =
vendor SIP.=0A=
>>>>>=0A=
>>>>> IIUC from last time [1,2], this erratum affects all interrupts=0A=
>>>>> targetting teh idle CPU, not just IPIs, so even if the bodge is more=
=0A=
>>>>> self-contained, it doesn't really solve the issue, and there are stil=
l=0A=
>>>>> cases where a CPU will not be woken from idle when it should be (e.g.=
=0A=
>>>>> upon receipt of an LPI).=0A=
>>>>=0A=
>>>> Wrong, this erratum does not affect any other type of interrupts, othe=
r=0A=
>>>> than IPIs. That is because all the other interrupts go through GPC,=0A=
>>>> which means the cores will wake up on any other type (again, other tha=
n IPI).=0A=
>>>=0A=
>>> Huh... Are you saying that LPIs and PPIs are going through the GPC, and=
=0A=
>>> will trigger the wake-up of the core? That's not the conclusion we=0A=
>>> reached last time.=0A=
>>=0A=
>> Hmm, I don't think that was the conclusion. Yes, Lucas was saying (IIRC)=
=0A=
>> that if you terminate the IRQs at GIC then all the other interrupts will=
 be=0A=
>> in the same situation. But the performance improvement given by terminat=
ing=0A=
>> them at GIC might not be worth it when compared to the cpuidle support.=
=0A=
> =0A=
> PPIs are broken,=0A=
> relying on some other terrible hack for the timer (and only the timer,=0A=
> leaving other PPIs dead as a nail). It also implies that LPIs have never=
=0A=
> been looked into, and given that they aren't routed through the GPC, the=
=0A=
> conclusion is pretty easy to draw.=0A=
> =0A=
> Nobody is talking about performance here. It is strictly about=0A=
> correctness, and what I read about this system is that it cannot=0A=
> reliably use cpuidle.=0A=
My argument was that it's fine if PPIs and LPIs are broken as long as =0A=
they're not used:=0A=
=0A=
  * PPIs are only used for local timer which is not used for wakeup.=0A=
  * LPIs on imx are not currently implemented.=0A=
=0A=
This workaround is only targeted at a very specific SOC with specific =0A=
usecases and in that context it behaves correctly, as far as I can tell.=0A=
=0A=
As mentioned in another thread the HW issue was already solved in newer =0A=
chips of the same family (like imx8mm). If there is a need for PPIs and =0A=
LPIs on imx8mq in the future then maybe we can detect that scenario and =0A=
disable cpuidle?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
