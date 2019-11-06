Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C7EFC6195
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D1F217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HeDLa81X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbfKFWhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:37:08 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:11648
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732866AbfKFWhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDItSdGZH0thH44GN51UHkRGoO+IFfIm9a4VkGa5mZ7Flqt8XCsE1XtEMuXeTDKAEIBWYPfaxCLRILMHe7ycbuzTJDHakJFJDYF1U3npOunjJAczdtYW/3+BrYel0oE0WhIjQgl3kzBVjTdiXaNvyaxsfEpdmOxBmQQ5DszKr/nDG/IMF0Qkd0p6x65l++dw4fPvjvqitqgHbZS2EoVYdGMYU/WRNxtEzRBZbRIMTrkenVNiwKi8w6taTdevin62LzAa5lFyjUWbIGpGXwnWYxNleMdkXCu3KuLizi+TusEj16quZZArIon+gGFyLlu7npAawmbSGM+eh7R8ZcKibA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g9r0GR99hiBNGlK/KwDC1PLB9GapFW/c6dcT+5kiWg=;
 b=KXRvLwN+gQypnEgSLiHnni/cHmKZNPGPp+HC8xhwFYSvtleor27pDbiYyIgsf6ZXbRiu1O8mS45zZauha+QANOxoapVzYUI7JikhXbApjje56JucnooN0jBAU/mhIcikWkwsQZEVq8lhXtTf2wDgajAPB48ziBQMJ7ek0VakrBZnn63kuZvMD3v3vEz78ayMHGBDrSYP1sOr9Dpf5gvuv5+QhTPf1uOKFKpu+VhVALVLO2d32UTdzONrFJJZ3TEuMX6DhwmwyrXC61kqYbCljZC3TmmoojYVWUyGMmHpG99vDWpwMJEvVgXrFNISOiYBXDXqeVYL6c6+1J9Mr+ER/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g9r0GR99hiBNGlK/KwDC1PLB9GapFW/c6dcT+5kiWg=;
 b=HeDLa81X+BWJdcPEAdxWkX7ibqvUX0MGyvZ5PBCBrhdNiynOrOwi8wr3DvmYv3Lj5GNcGEFsYDvytcyG+pIIeV4d5ZHSYV2cyvlSF4dAapASskc4MvuLrCFSmK2zNol38q7hFo3zBprUUMR7dN7hwCjOgJVbmPPf033ge9HfSwY=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4096.eurprd04.prod.outlook.com (52.133.14.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 22:36:59 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2430.023; Wed, 6 Nov 2019
 22:36:59 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/fXLWCNQC3kGmFNlizRWSbQ==
Date:   Wed, 6 Nov 2019 22:36:59 +0000
Message-ID: <VI1PR04MB70231EA80BB20C9A84B1B799EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
 <7d3a868a-768c-3cb1-c6d8-bf5fcd1ddd1c@posteo.de>
 <20191030080727.7pcvhd4466dproy4@fsr-ub1664-175>
 <523f92bd-7e89-b48a-afd0-0a9a8bca8344@posteo.de>
 <20191104103525.qjkxh2zhhgaaectk@fsr-ub1664-175>
 <433f3f03-f780-c327-f1e8-fbf046a8374c@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cccedd4d-50b4-4fee-5070-08d76309d603
x-ms-traffictypediagnostic: VI1PR04MB4096:|VI1PR04MB4096:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB40965C472C2822D5F2BFE77AEE790@VI1PR04MB4096.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(54014002)(43544003)(102836004)(446003)(6246003)(55016002)(256004)(14444005)(99286004)(2906002)(76176011)(5660300002)(7696005)(476003)(6436002)(54906003)(561944003)(71190400001)(71200400001)(8936002)(6306002)(86362001)(53546011)(110136005)(9686003)(14454004)(4326008)(6506007)(966005)(316002)(81156014)(52536014)(74316002)(305945005)(81166006)(66946007)(33656002)(26005)(8676002)(7416002)(3846002)(6116002)(186003)(45080400002)(66446008)(64756008)(66556008)(66476007)(478600001)(25786009)(7736002)(76116006)(66066001)(91956017)(44832011)(229853002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4096;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBVez4nMyFrzgmUFk2DdZp5omAI6FV0qHGntOrStPA4t8u3o9GeOMk+WeAmAHcqCSvdhg2M4XgeBqkDXcwOzTvCbr59WvMxKexMWJEBXnIHmxuniKCHsZjqCgXjtWom4gL/6WuR2XKRb6j1N3BFkYeqxdPt4yNtynAZ6m2ifa1R5Y0TCsmK9TyTjujr0XgxjflJFzBD5wTIgJ0+FeysY7uAEOY7K9JUBqXG/IV1nRMZpCb1o1/IDM59baiCcYiWKRHQ5f4IQNLi5zHybfVD2nnbS9baT+lZQtZixtZQEKY7C4bM0k83QppfSW4ZjsioQirV9feMQD38CEpGQiuHzDbDG2MxCwwJ2lOucKU5pS89nHCswNZ8K2mPrg1217lrRG+nTq1pUUWVcHC9ew7rDXJUs1gbezkgtGCciMTwInRdi3DCpLOm/dj8cfk1xwUhGoZBD+od8hwfqM5DsV37ogyrMEkJxKavauKGAs8sB1cM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccedd4d-50b4-4fee-5070-08d76309d603
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 22:36:59.1536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntQZvTMwfGr0Bhu5M0DO6wzfAO107mUhFv8clNVINPagL5vgkzFD1lzXfVZMABPAUlNIi8NdS/rzu+CP4o0Uhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.11.2019 13:59, Martin Kepplinger wrote:=0A=
> On 04.11.19 11:35, Abel Vesa wrote:=0A=
>> On 19-11-04 09:49:18, Martin Kepplinger wrote:=0A=
>>> On 30.10.19 09:08, Abel Vesa wrote:=0A=
>>>> On 19-10-30 07:11:37, Martin Kepplinger wrote:=0A=
>>>>> On 23.06.19 13:47, Martin Kepplinger wrote:=0A=
>>>>>> On 10.06.19 14:13, Abel Vesa wrote:=0A=
>>>>>>> This is another alternative for the RFC:=0A=
>>>>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Flkml.org%2Flkml%2F2019%2F3%2F27%2F545&amp;data=3D02%7C01%7Cleonard.crestez=
%40nxp.com%7C6ca438b3b9e44d70ac7608d762b0c030%7C686ea1d3bc2b4c6fa92cd99c5c3=
01635%7C0%7C1%7C637086383589318475&amp;sdata=3DNyFLkQ8PUfC7PGejDK7NBJoQu36Z=
faYvg9yuJvHedzo%3D&amp;reserved=3D0=0A=
>>>>>>>=0A=
>>>>>>> This new workaround proposal is a little bit more hacky but more co=
ntained=0A=
>>>>>>> since everything is done within the irq-imx-gpcv2 driver.=0A=
>>>>>>>=0A=
>>>>>>> Basically, it 'hijacks' the registered gic_raise_softirq __smp_cros=
s_call=0A=
>>>>>>> handler and registers instead a wrapper which calls in the 'hijacke=
d'=0A=
>>>>>>> handler, after that calling into EL3 which will take care of the ac=
tual=0A=
>>>>>>> wake up. This time, instead of expanding the PSCI ABI, we use a new=
 vendor SIP.=0A=
>>>>>>>=0A=
>>>>>>> I also have the patches ready for TF-A but I'll hold on to them unt=
il I see if=0A=
>>>>>>> this has a chance of getting in.=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> Hi Abel,=0A=
>>>>>=0A=
>>>>> Running this workaround doesn't seem to work anymore on 5.4-rcX. Linu=
x=0A=
>>>>> doesn't boot, with ATF unchanged (includes your workaround changes). =
I=0A=
>>>>> can try to add more details to this...=0A=
>>>>>=0A=
>>>>=0A=
>>>> This is happening because the system counter is now enabled on 8mq.=0A=
>>>> And since the irq-imx-gpcv2 is using as irq_set_affinity the=0A=
>>>> irq_chip_set_affinity_parent. This is because the actual implementatio=
n=0A=
>>>> of the driver relies on GIC to set the right affinity. On a SoC=0A=
>>>> that has the wake_request signales linked to the power controller this=
=0A=
>>>> works fine. Since the system counter is actually the tick broadcast=0A=
>>>> device and the set affinity relies only on GIC, the cores can't be=0A=
>>>> woken up by the broadcast interrupt.=0A=
>>>>=0A=
>>>>> Have you tested this for 5.4? Could you update this workaround? Pleas=
e=0A=
>>>>> let me know if I missed any earlier update on this (having a cpu-slee=
p=0A=
>>>>> idle state).=0A=
>>>>>=0A=
>>>>=0A=
>>>> The solution is to implement the set affinity in the irq-imx-gpcv2 dri=
ver=0A=
>>>> which would allow the gpc to wake up the target core when the broadcas=
t=0A=
>>>> irq arrives.=0A=
>>>>=0A=
>>>> I have a patch for this. I just need to clean it up a little bit.=0A=
>>>> Unfortunately, it won't go upstream since everuone thinks the gic=0A=
>>>> should be the one to control the affinity. This obviously doesn't work=
=0A=
>>>> on 8mq.=0A=
>>>>=0A=
>>>> Currently, I'm at ELCE in Lyon. Will get back at the office tomorrow=
=0A=
>>>> and sned you what I have.=0A=
>>>>=0A=
>>>=0A=
>>> Hi Abel,=0A=
>>>=0A=
>>> Do you have any news on said patch for testing? That'd be great for my=
=0A=
>>> plannings.=0A=
>>>=0A=
>>=0A=
>> Sorry for the late answer.=0A=
>>=0A=
>> I'm dropping here the diff.=0A=
>>=0A=
>> Please keep in mind that this is _not_ an official solution.=0A=
>>=0A=
>> ---=0A=
>>   drivers/irqchip/irq-imx-gpcv2.c | 42 +++++++++++++++++++++++++++++++++=
+++++++-=0A=
>>   1 file changed, 41 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-g=
pcv2.c=0A=
>> index 01ce6f4..3150588 100644=0A=
>> --- a/drivers/irqchip/irq-imx-gpcv2.c=0A=
>> +++ b/drivers/irqchip/irq-imx-gpcv2.c=0A=
>> @@ -41,6 +41,24 @@ static void __iomem *gpcv2_idx_to_reg(struct gpcv2_ir=
qchip_data *cd, int i)=0A=
>>   	return cd->gpc_base + cd->cpu2wakeup + i * 4;=0A=
>>   }=0A=
>>   =0A=
>> +static void __iomem *gpcv2_idx_to_reg_cpu(struct gpcv2_irqchip_data *cd=
,=0A=
>> +					int i, int cpu)=0A=
>> +{=0A=
>> +	u32 offset =3D  GPC_IMR1_CORE0;=0A=
>> +	switch(cpu) {=0A=
>> +	case 1:=0A=
>> +		offset =3D GPC_IMR1_CORE1;=0A=
>> +		break;=0A=
>> +	case 2:=0A=
>> +		offset =3D GPC_IMR1_CORE2;=0A=
>> +		break;=0A=
>> +	case 3:=0A=
>> +		offset =3D GPC_IMR1_CORE3;=0A=
>> +		break;=0A=
>> +	}=0A=
>> +	return cd->gpc_base + offset + i * 4;=0A=
>> +}=0A=
>> +=0A=
>>   static int gpcv2_wakeup_source_save(void)=0A=
>>   {=0A=
>>   	struct gpcv2_irqchip_data *cd;=0A=
>> @@ -163,6 +181,28 @@ static void imx_gpcv2_irq_mask(struct irq_data *d)=
=0A=
>>   	irq_chip_mask_parent(d);=0A=
>>   }=0A=
>>   =0A=
>> +static int imx_gpcv2_irq_set_affinity(struct irq_data *d,=0A=
>> +				 const struct cpumask *dest, bool force)=0A=
>> +{=0A=
>> +	struct gpcv2_irqchip_data *cd =3D d->chip_data;=0A=
>> +	void __iomem *reg;=0A=
>> +	u32 val;=0A=
>> +	int cpu;=0A=
>> +=0A=
>> +	for_each_possible_cpu(cpu) {=0A=
>> +		raw_spin_lock(&cd->rlock);=0A=
>> +		reg =3D gpcv2_idx_to_reg_cpu(cd, d->hwirq / 32, cpu);=0A=
>> +		val =3D readl_relaxed(reg);=0A=
>> +		val |=3D BIT(d->hwirq % 32);=0A=
>> +		if (cpumask_test_cpu(cpu, dest))=0A=
>> +			val &=3D ~BIT(d->hwirq % 32);=0A=
>> +		writel_relaxed(val, reg);=0A=
>> +		raw_spin_unlock(&cd->rlock);=0A=
>> +	}=0A=
>> +=0A=
>> +	return irq_chip_set_affinity_parent(d, dest, force);=0A=
>> +}=0A=
>> +=0A=
>>   static struct irq_chip gpcv2_irqchip_data_chip =3D {=0A=
>>   	.name			=3D "GPCv2",=0A=
>>   	.irq_eoi		=3D irq_chip_eoi_parent,=0A=
>> @@ -172,7 +212,7 @@ static struct irq_chip gpcv2_irqchip_data_chip =3D {=
=0A=
>>   	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,=0A=
>>   	.irq_set_type		=3D irq_chip_set_type_parent,=0A=
>>   #ifdef CONFIG_SMP=0A=
>> -	.irq_set_affinity	=3D irq_chip_set_affinity_parent,=0A=
>> +	.irq_set_affinity	=3D imx_gpcv2_irq_set_affinity,=0A=
>>   #endif=0A=
>>   };=0A=
=0A=
This is prone to race conditions.=0A=
=0A=
In NXP tree there is different gpcv2 irqchip driver which does all GPC =0A=
IMR register manipulation in TF-A through SMC calls. The cpuidle =0A=
workaround also manipulates the same registers and does so safely under =0A=
a lock.=0A=
=0A=
If OS also writes to same IMR register then set_affinity for SPIs 1-31 =0A=
can potentially race with one those cores being woken up. This is very =0A=
unlikely (set_affinity calls are rare) but in the worst case the system =0A=
could still hang on lost IPI.=0A=
=0A=
> I guess this diff does not apply when using this reworked change:=0A=
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc=
e.puri.sm%2FLibrem5%2Flinux-next%2Fcommit%2Fe59807ae0e236512761b751abc84a9b=
129d7fcda&amp;data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C6ca438b3b9e44d70=
ac7608d762b0c030%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6370863835893=
18475&amp;sdata=3DMf%2BFtqFSG4xHL3IGPrD%2FOweR8qoJHV0IKuziPIUK%2Bsw%3D&amp;=
reserved=3D0=0A=
> which has worked for me when running 5.3.=0A=
> =0A=
> At least on 5.4-rc5, using your change, I still get=0A=
> =0A=
> cat /sys/devices/system/cpu/cpuidle/current_driver=0A=
> none=0A=
=0A=
This reads "psci_idle" for me in linux-next on imx8mm. Your problem =0A=
seems to be related to probing the cpuidle driver, not related to any =0A=
hardware workarounds.=0A=
=0A=
> But also when trying to rewrite your patch against irq-gic-v3.c at least=
=0A=
> nothing changes for me (I might have done that wrong as well though).=0A=
> =0A=
> What needs to change (in order to have the cpu-sleep state / idle=0A=
> driver) based on the above "reworked" workaround?=0A=
> =0A=
> Could the config have changed? CONFIG_ARM_CPUIDLE should be the only=0A=
> needed path, or did things change there in 5.4?=0A=
=0A=
It seems there were some recent cleanups in the cpuidle psci core code, =0A=
maybe you need config updates?=0A=
=0A=
https://patchwork.kernel.org/cover/11052723/=0A=
=0A=
> I know all this is no real solution, but currently the only way to have=
=0A=
> said sleep state on top of mainline. so be it for now.=0A=
Can you use the gpcv2 driver from NXP tree?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
