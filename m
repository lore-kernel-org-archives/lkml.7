Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA8BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D712171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LfazChVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406192AbfHIJpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:45:47 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:32389
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406138AbfHIJpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:45:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwvhAU50FVGmkGJlGxmEfjXrhh366das8yim7aUT5TWeCPqTwUVRK15Yg/FTXKQXkmEsJfU68vp1fV1v68OqaLy01MBJX4mbUs3ToMaoiTMFfsYQpHDOnXznqAGsOvYdCEyahrjCRRPbCZpy0LeSeoWOdDAui6sKCUEOiisjSDGUlanDvO5TCTOOB1RF5U1M6rvCbJLhw69tK2esM6WDCFgN8cuTzS/f59wQyvCqH1D+i/5CkLbfUtcOZKsAqXM04MbtZoNW+K0+Y+HKTh2kLtQqPsrslRfDiVLM6J5y5hmyxLw5uSVxYGT8Zs1IAS3lpVHoymyXJ/U57Zgh3LHPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg3Gp8dptVuK+uaY9Ye8x7ZbYCrF0v/JWUmNUsOlG64=;
 b=YNlLLt5xj/UAP/6fYQrlDFDh1XuJU12PLZto+vEPpoG+cD9jPmNLWFIacN7eqAVIcdXkqoKXQJA7Jpeh9EtCBxD8Se1OOox8dAZIHrXjiHBg0D19+IzII/bI9/5kyaFWbLybn5bstZEJ156vutzSW6CuJHOHCt2wQ4dTkFyEaSt7G1fcWfdjb526UkWnfonWMFN6eCTOjpopm4sQ0+gkQu8QLOuODet5Pdyt9qY4mgRmV2ZNpWYllfgOdxp4WwgtdHwqz6Yfz7nBYzjFDNkluKSUjFfDqO0Zkw32E9k9nC1HRCREHBMN7w6CgNYT/RNKN//+h3zkHbCjeGwnmDz/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg3Gp8dptVuK+uaY9Ye8x7ZbYCrF0v/JWUmNUsOlG64=;
 b=LfazChVs4fqY/yHq4h9uqKcMB3Cpi28fmljijeOYaihTEl1nFmqJ4JRB6qtrOIdsdGCmYNDpSgsOeSc4dwQkdRr6jYuUhAz5I1yPz7FKQLYkVHS0DlhiHX2cppeYFeQ0fPx9yVzFnyqk8UUcpSkJx1lPcXvWyzVCG+ThwapwBmQ=
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com (10.175.20.18) by
 VI1PR0402MB3487.eurprd04.prod.outlook.com (52.134.4.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 9 Aug 2019 09:45:40 +0000
Received: from VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023]) by VI1PR0402MB2863.eurprd04.prod.outlook.com
 ([fe80::7de6:ea4b:9b5d:d023%7]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 09:45:40 +0000
From:   Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
To:     Will Deacon <will@kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Topic: [PATCH 5/6] tty: serial: Add linflexuart driver for S32V234
Thread-Index: AQHVTpc0N7PGKATl60WX/HSnUpERYA==
Date:   Fri, 9 Aug 2019 09:45:40 +0000
Message-ID: <VI1PR0402MB2863B3E3E2F93CBA8ADB96E5DFD60@VI1PR0402MB2863.eurprd04.prod.outlook.com>
References: <20190802194702.30249-1-stefan-gabriel.mirea@nxp.com>
 <20190802194702.30249-6-stefan-gabriel.mirea@nxp.com>
 <20190808080832.nleult5bknmzr3ze@willie-the-truck>
 <VI1PR0402MB28635661A4A294EC6F01095EDFD70@VI1PR0402MB2863.eurprd04.prod.outlook.com>
 <20190808171711.nk7ljqkugtketu4q@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stefan-gabriel.mirea@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1ce9e63-d687-4377-7fc5-08d71cae56dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3487;
x-ms-traffictypediagnostic: VI1PR0402MB3487:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3487A57EC47CF9CC1DCD49EBDFD60@VI1PR0402MB3487.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(189003)(199004)(14454004)(9686003)(66066001)(478600001)(25786009)(6246003)(66446008)(91956017)(64756008)(99286004)(966005)(66476007)(7416002)(76116006)(476003)(81156014)(446003)(486006)(52536014)(4326008)(5660300002)(229853002)(256004)(33656002)(81166006)(6916009)(8676002)(86362001)(66556008)(6436002)(66946007)(74316002)(54906003)(8936002)(53936002)(6506007)(3846002)(186003)(26005)(7696005)(6116002)(2906002)(76176011)(6306002)(102836004)(7736002)(55016002)(305945005)(53546011)(71190400001)(71200400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3487;H:VI1PR0402MB2863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VyyhMslZwBvsUnmwB6TSMV9voZEpehOg1viKRnTsBSlMEttEi66M5sogjcHRrhNeThzg5UuxOTh01aLizkypE8lSec88QvBZoLI/SLJa7eF1MQGUjuHH4raKtWsbBncL5xSvUfrPww3q8z+bGz3hVwblZY2qvuctjhxofq7LVkWMN8+6ITj7T5lp9aPSpEvweOt7dybZ7z8FzRiUF0rHHnQVEA3o6WZ8cBXWuHYf66M8wNQSWn/3lrhqgZ8Cr9tYUNlGwsjcQ2XAVZSf2S7DERRaS5+Dm+uQGx4aAIdVT2fL6t4T6YIugeNHAxxVBi89alw0PMoVZbY4B43KNfSdRqmqBM21pReMQ78Gujw3BkjShkkZBSPiNLeEbEA6kKipIc5t8xHjzNYHMWutbZHhFjMZVuZxkfWBwVNE2sY6YLs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ce9e63-d687-4377-7fc5-08d71cae56dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 09:45:40.2418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQTYDFCG5FWbj/6dT0j0JlhWuLrK/tfyIhrltz1ZxBCa0EY/7PVgvAkHY1XrM+gcgsCUj1yFevooUHTaefHnohN++xPwd9OHH3B5rjhTQTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3487
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2019 8:17 PM, Will Deacon wrote:=0A=
> On Thu, Aug 08, 2019 at 12:47:00PM +0000, Stefan-gabriel Mirea wrote:=0A=
>> On 8/8/2019 11:08 AM, Will Deacon wrote:=0A=
>>> On Fri, Aug 02, 2019 at 07:47:23PM +0000, Stefan-gabriel Mirea wrote:=
=0A=
>>>> +             linflex,<addr>=0A=
>>>> +                     Use early console provided by Freescale LinFlex =
UART=0A=
>>>> +                     serial driver for NXP S32V234 SoCs. A valid base=
=0A=
>>>> +                     address must be provided, and the serial port mu=
st=0A=
>>>> +                     already be setup and configured.=0A=
>>>=0A=
>>> Why isn't earlycon=3D sufficient for this?=0A=
>>=0A=
>> "earlycon=3D" is not actually supported. I will fix this in the next=0A=
>> version by adding a /chosen/stdout-path to the dts. The compatible=0A=
>> string provided to OF_EARLYCON_DECLARE will also be changed from=0A=
>> "fsl,s32v234-linflexuart" to "fsl,s32-linflexuart" to match the one in=
=0A=
>> the device tree nodes. I missed this after importing a rename from our=
=0A=
>> codebase.=0A=
>>=0A=
>> Should I remove this addition from kernel-parameters.txt after that?=0A=
> =0A=
> Yes, if you can use earlycon instead, then you can drop your custom optio=
n=0A=
> entirely and therefore there's no need to document it either.=0A=
=0A=
Can you please clarify what you mean by "drop your custom option"? The=0A=
"linflex" option documented in the paragraph is the name of the=0A=
earlycon_id declared via "OF_EARLYCON_DECLARE(linflex, ...)". We have=0A=
not done anything particular to accept it in the parameter value.=0A=
=0A=
We do use earlycon (e.g. "earlycon=3Dlinflex,0x40053000"), we just do not=
=0A=
support an empty value after "=3D", which needs to be fixed as I=0A=
understand, because it does not respect the comment[1] about ARM64.=0A=
=0A=
Regards,=0A=
Stefan=0A=
=0A=
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/admin-guide/kernel-parameters.txt?h=3Dv5.3-rc3#n980=0A=
