Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95558C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B8A205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevasonline.onmicrosoft.com header.i=@prevasonline.onmicrosoft.com header.b="CSVMt6H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfI0VQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:16:56 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com ([40.107.15.120]:64502
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfI0VQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+fVs5IZgFQnBehj5Vrtmxb6LVGSFCPaYrDNiY247VOTssSVFTcaTp1BrYv2a5iIH4mi84+F48OeAm3ebLo+PGboboQPjsef6l7S1J9MM++2roE5dDVpY3OsGU0WNfxDQINPSHsPCYHJMCCQjw4wQY0jRTIUuLyqPGsqXbyiP8ZPH5IUmeh45qQwIJ6hmps/3VkmpalydAZzRxJCnLjocPrde6WqXvGdvXSMA9WbJGSZz32jHRfN3C8lq/EvYzqj1xVpF6z1yiMjBKtsiZUseBBySoqo7goI0FRoduCzWbxrngnLeYaFSSr5vZQIRsGQVNGC6hRyafNNiRfsFJdPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZwYsVdNLIdSAHN1SvuiOjjaOoWlwILspKN83LOqa2Q=;
 b=cMuHJriGOUE5PJuB7zsNY8vcWvQ+v655ldJkF9hLUVEbgiqujjKd4WaFpifoR+SZvAoZA0h2yWwsg1jl9LocWpPN06REFJu56+xey72qtb1z2KmyVIV98vyqNSnxEiX03MGkDA69TAQ2fNRqayqg1AyUTUYOHD6q71z9eudJOButBWy4l75LX48Yb+xXLmA1rF0hpzQiJ+uhTxWeWJIcFFlC+wX2KqkIGxKsnBq7PPVhyhZYH2T6vA5GCPMwFqE+9blmuIFHCS1RYfT+gBqgcLCGf+p5MfBRlPD47IM21Kdz/77iuCT+Vx2o9dlz/S2JIA3b8rnxwo51eE9Ypap+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=prevasonline.onmicrosoft.com; s=selector2-prevasonline-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZwYsVdNLIdSAHN1SvuiOjjaOoWlwILspKN83LOqa2Q=;
 b=CSVMt6H4jCFTGwFeKsjpOu83nhOvosvP9hUmJPQWtQjKFo4Xw87bO4ihiBmo4F8Vc4X6qyO11cjeABMC/l8s0mUwKVYh0T+G4vnSxGRLVSnGAwK7SQisjouQvOOl9HPQHRLc3ng+eqrbhThNl3JGr/rZ0eMFJlGDIByi7y6eo4M=
Received: from AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM (10.186.175.83) by
 AM0PR10MB1986.EURPRD10.PROD.OUTLOOK.COM (52.134.84.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Fri, 27 Sep 2019 21:16:50 +0000
Received: from AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ace2:40dd:f2a:26bd]) by AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ace2:40dd:f2a:26bd%2]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 21:16:50 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Rob Herring <robh@kernel.org>, Kurt Kanzenbach <kurt@linutronix.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
Thread-Topic: [PATCH v6 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
Thread-Index: AQHVcffWKeTRBhwJoUaNxC4njuzHPKc/uHMAgABVWQA=
Date:   Fri, 27 Sep 2019 21:16:50 +0000
Message-ID: <f63da257-95b4-bcb8-9ba4-9786645caf26@prevas.dk>
References: <20190923101513.32719-1-kurt@linutronix.de>
 <20190923101513.32719-3-kurt@linutronix.de> <20190927161118.GA19333@bogus>
In-Reply-To: <20190927161118.GA19333@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::19) To AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:15e::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rasmus.villemoes@prevas.dk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.115.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fac147e6-c838-4c88-13bb-08d74390030e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR10MB1986;
x-ms-traffictypediagnostic: AM0PR10MB1986:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR10MB1986275635BF7415EBF3B4B993810@AM0PR10MB1986.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(136003)(39850400004)(199004)(189003)(52544003)(66066001)(6116002)(71200400001)(6436002)(6486002)(81166006)(36756003)(66476007)(66556008)(64756008)(66946007)(66446008)(476003)(446003)(2616005)(7736002)(5660300002)(44832011)(4326008)(305945005)(256004)(6512007)(54906003)(110136005)(6306002)(229853002)(478600001)(25786009)(14454004)(186003)(102836004)(316002)(6246003)(486006)(2906002)(3846002)(8936002)(99286004)(52116002)(86362001)(11346002)(26005)(6506007)(386003)(81156014)(8676002)(31696002)(31686004)(71190400001)(8976002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR10MB1986;H:AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B8wmp5H1Z32BCN/Hog//uq1ezkHkA2SIK54GNMH06/6XuqO6pHYcLuveuV3nm04fe8wOJ0xfSS25R8hAOgsdfweCXWLZxzzfRt6vKO42g9i/eOWji2e0ojRW63v60x3zrG+OBTCn4G/EwoJ6DXtl85z4Ebzxl15ASm/TCQatTeLHMrAb502eszM/Pw2Awg/DT9mpFr+wrOjceIxqmeLlDTZqsWZjuWuFuC6s3p+4aIe3MD3bJlhMLINbny0wMvTE96cQlAeQtPG9U5/RNTsbDjvcUyKUV7zGEzVDgmHkF0SbhNpwUurqPTyKr75+B4mNbheA1Ye3dTZx6iovvOam1ZTn5apG60R2fdroPgoQ2YkoiBN+eTuXogdKvMIkO6DgnH0lv2Tx3OdL/NFrqchtX4/2wLuEDIxUIWjqN/8Tc994oh2sZc5xr034RN46b5sxXtLXVKLMZKadM2itRGcbFw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <B78BBAF278F6A0498AA0DD162BF8ECC9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fac147e6-c838-4c88-13bb-08d74390030e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 21:16:50.3581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yV7OSSEZO/n6LsBYsvGYi6uGcyJj+90Nj16wnfoAVlhSlJT8342YiZSZpgMx8yGkjRqngxZF9unTkExE6zDYfLJI4fxX8XkeizQOosD0fPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2019 18.11, Rob Herring wrote:
> On Mon, Sep 23, 2019 at 12:15:13PM +0200, Kurt Kanzenbach wrote:
>> From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>
>> This adds Device Tree binding documentation for the external interrupt
>> lines with configurable polarity present on some Layerscape SOCs.
>>
>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>
>> +* Freescale Layerscape external IRQs
>> +
>> +Some Layerscape SOCs (LS1021A, LS1043A, LS1046A, LS2088A) support
>> +inverting the polarity of certain external interrupt lines.
>> +
>> +The device node must be a child of the node representing the
>> +Supplemental Configuration Unit (SCFG) or the Interrupt Sampling
>> +Control (ISC) Unit.
>> +
>> +Required properties:
>> +- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-exti=
rq".
>> +- interrupt-controller: Identifies the node as an interrupt controller
>> +- #interrupt-cells: Must be 2. The first element is the index of the
>> +  external interrupt line. The second element is the trigger type.
>> +- interrupt-parent: phandle of GIC.
>> +- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in th=
e SCFG.
>> +- fsl,extirq-map: Specifies the mapping to interrupt numbers in the par=
ent
>> +  interrupt controller. Interrupts are mapped one-to-one to parent
>> +  interrupts.
>=20
> This should be an 'interrupt-map' instead.

Rob, thanks for your review comments. I know you said the same thing at
v5, and it might seem like they are ignored. However, I asked a couple
of followup questions
(https://lore.kernel.org/lkml/0bb4533d-c749-d8ff-e1f2-4b08eb724713@prevas.d=
k/).
I'd really appreciate it if you could (a) point to some documentation on
how to write that interrupt-map and (b) explain how this is different
from the Qualcomm PDC case I tried to copy and which had your Reviewed-By.

>> +
>> +Optional properties:
>> +- fsl,bit-reverse: This boolean property should be set on the LS1021A
>> +  if the SCFGREVCR register has been set to all-ones (which is usually
>> +  the case), meaning that all reads and writes of SCFG registers are
>> +  implicitly bit-reversed. Other compatible platforms do not have such
>> +  a register.
>=20
> Couldn't you just read that register and tell?

In theory, yes, but as far as I understand (and as I wrote) it's
specific to the ls1021a. Of course one can decide whether it's
necessary/possible to read it based on the compatible string, but one
would also need an extra reg property to have its address - but that
register is not really part of the extirq "device" we're trying to
describe. So would it need to be represented as its own subnode of scfg?

If it is set at all, it's done within the first few instructions after
reset (before control is even handed to the bootloader), so I see it as
a kind of quirk of the hardware. The data sheet says "SCFG bit reverse
(SCFG_SCFGREVCR) must be written 0xFFFF_FFFF as a part of initialization
sequence before writing to any other SCFG register." which, taken
literally, means we don't need the property at all and can just assume
it for the ls1021a (i.e., do it based on compatible string alone) - but
I think it should be read as "if you're going to write this register, it
must be done first thing".

> Does this apply to only the extirq register or all of scfg?

All of scfg. It really seems like some accident/bad joke coming out of a
discussion between a hardware and software engineer on the enumeration
of bits, with the hardware guy ending up saying "alright, have it
whichever way you want it", causing even more pain :(

>> +
>> +Example:
>> +	scfg: scfg@1570000 {
>> +		compatible =3D "fsl,ls1021a-scfg", "syscon";
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>=20
> As the child node(s) are memory mapped, this should not be 0. And you=20
> need 'ranges'.

Indeed - I think I understand this a little better now than I did back then=
.

Thanks,
Rasmus
