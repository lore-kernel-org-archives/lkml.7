Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108082064A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="MBm8reRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfJYBc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:32:58 -0400
Received: from mail-eopbgr1320044.outbound.protection.outlook.com ([40.107.132.44]:32192
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbfJYBc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUD3zlsJKisPFtK5KWr/yG0sEccB7bYAOn1S1zGhVaZ3HH+FUYDB+fJoVnLOuGnMjf8xldTUmYwjM9tmLkACDtksNo0EN/0f6n+XSuJ7ViEaBMqHnswHBJ9bGSvDd4nMeza35Ri7L6oqtQT7Wg8OkG5Q2B+vOfNuogjzosuSCTMpkkZprdKnol8VSWDP2VZGKGGqdgI29CAUyuDRZnFwJ23IBFokWgm+C2h6M7HJ2lHD9nIMBqT+nqzW6ZWYDVcXuyDvEsq2mer0RqcrIBmnuvls53VNchDEpIg/9vkx2LDp/u8MzyT+luIzHe96uCHSSTEyxhjNOfKPM8AjbM7MRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ekeqnocrcbc5M3c/bGfJ2Yxvcw81NBvyAUFlf3Je/g=;
 b=VJeQYn7kgQF+qw86Ew1fsV4KEuRKzwNKPRxZr3bCSrvZTYay1Gcv0QVxcM+LogIHi7rJGg8c0QDsCFza0Gvcxy7/BTwlORW5FIYG5/3Yo1EVajuxgyMgCZNX1USZUiMnKYY01nDrEdAZubTwRDhlO+cZnOCxiabyfmZnCPkHPb2Zi8meM60eLfQtIx5HMQVv1LWDpAFtZpWNJWEF/wUd1vW4ENOzknvTmxKvr8Vn/rTtGEQZi0P3LXc5lWdwXWz7khJzTprz4tfhVgCu4arAakgFtk0CeGcYWSc1dS/+J2sXD7gJNwNfxhgVQACsOH5AMdDMbbtqvo8f7x5sMj6YmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ekeqnocrcbc5M3c/bGfJ2Yxvcw81NBvyAUFlf3Je/g=;
 b=MBm8reRfMFZsOMlMZFNaOi78GeCToGNjmMWcVceP7dw86B/eYSL5BMnt7ImQ3gb7c5ddb1GmTO+JSQCwQGeoO71Gl2PxJ/uMF2F8z43FSgpdZXmyhF8KHUxZjp1mwqKX3PmKGsAag8KlPVoeg7ldxZ56n8M8sOOMlsimkHboZPs=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2997.apcprd01.prod.exchangelabs.com (20.177.93.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Fri, 25 Oct 2019 01:32:47 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2367.027; Fri, 25 Oct 2019
 01:32:47 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Replacement of Supercomputer @ Home in Singapore Due to Motherboard
 Malfunction
Thread-Topic: Replacement of Supercomputer @ Home in Singapore Due to
 Motherboard Malfunction
Thread-Index: AdWK1BSQgEzE1mNCQ7CAh2CK3cnCWw==
Date:   Fri, 25 Oct 2019 01:32:47 +0000
Message-ID: <SG2PR01MB2141F60851D3DBF00F3F4CF287650@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:1ef3:d923:25a:c4b4:68f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2271217a-4ea4-4b41-8cfc-08d758eb3e11
x-ms-traffictypediagnostic: SG2PR01MB2997:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB299770F047BE6E3CCDBFCF2787650@SG2PR01MB2997.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(376002)(39830400003)(199004)(189003)(7736002)(14454004)(46003)(966005)(5660300002)(52536014)(256004)(4326008)(2906002)(81166006)(508600001)(14444005)(107886003)(186003)(86362001)(102836004)(6916009)(6506007)(8936002)(476003)(66556008)(66946007)(66476007)(6306002)(74316002)(66446008)(64756008)(6436002)(76116006)(99286004)(25786009)(33656002)(55016002)(7696005)(9686003)(8676002)(6116002)(81156014)(71190400001)(71200400001)(316002)(305945005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2997;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEaYXdFWjlfiZLP/tIghStd5HPh/0WWDV1ZJ+jy55SgryV3SKIEL6d51dMZPmqIerN66SUN/MTTz7po/iS6Yz1tfgrvRnPCXKZG6tcvrTU5XCm62nAyjlSMRdbJQ/C1yUV8RkvVWx6WKzexlVgFPogBgsgnAGitAxsB/oF7WTY9XkFC7zUdyJG+3KyUV94hZURbI0pSenaE4EHacSnCpN8erI87yy2uMb88ZGA6ueH1ZClHwxFOmLM5keUVIUs/D6H1x2rnGBQdhJGgiB/spLEhG5eJ7BCOxKmHyjb3vYBDVGIbRpJdcC6ZuykHWOoti42YM4RjpVX5MeXIu3bV4GP5QDAZuWxXfrWA9sdU+AcLXhf0rJlKyjJy4aMSMWfW/9AwXSq5RQAZjmpQZPVrmJyeg7+iHr/G/K9RHkoKZaSSoXVkA93rmvtbCs71cXDBtGGsiS5IVNBcLe6szmHJiGhvExJUD4FJyd4TBkvo5ISM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2271217a-4ea4-4b41-8cfc-08d758eb3e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 01:32:47.7091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdvo+tXpTi3Hh2+nne5EbU9Y/dIidT39ro8K6TsNuN9oJxNJ1Oi/lgbEqJGu26IDPIaIYRAc85OWe6yUFVdUXWjSyTtSHTPuDBxcUdVCp1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Replacement of Supercomputer @ Home in Singapore Due to Motherboar=
d Malfunction

Good day from Singapore,

Section A: Old Supercomputer Bought on 30 August 2015
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

I had bought the following computer components on 30 August 2015 (confirmed=
 date), which is slightly more than 4 years ago.

[1] 5th Generation Intel Core i7-5820K 3.3 GHz 15 MB LGA2011(V3) (140W) SGD=
$530

[2] MSI X99A SLI Krait Edition USB3.1 LGA2011-3 DDR4 MAINBOARD SGD$439

[3] Kingston PC4-2133 8 GB DDR4 DIMM (KVR21N15D8/8) SGD$90

[4] ANDYSON AG-SERIES 650W 80PLUS SILVER (5YRS) SGD$95

[5] Coolermaster Hyper 103 CPU Cooler SGD$68

Grand Total: SGD$1,222.00 (on 30 Aug 2015)

Section B: Malfunction of MSI X99A SLI Krait Edition Motherboard on 23 Oct =
2019 Wed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Symptoms:

When power is supplied, there are LED lights on the motherboard. However, t=
he power supply unit fan, casing fan, CPU fan, and GPU fan keeps spinning u=
p and down repeatedly forever. The RESET LED on the motherboard also turns =
on and off repeatedly forever.

Troubleshooting Steps:

1. Removed all existing DDR4 memory sticks on the motherboard. Insert brand=
 new G.SKILL DDR4 memory stick. Symptoms persist.

2. Use another known working power supply unit. Symptoms persist.

Conclusion:=20

The MSI X99A SLI Krait Edition motherboard, which has been in service with =
me for slightly more than 4 years, is now dead.

Credits: Troubleshooting is performed by a computer shop in 4th story of Si=
m Lim Square in Singapore, because I don't have the necessary spare parts t=
o troubleshoot. Troubleshooting fee is SGD$30. Plus Grab fare from my home =
to Sim Lim Square is SGD$20.

Section C: Buying Brand New AMD Ryzen 3 3200G processor, Gigabyte B450M DS3=
H SOC motherboard and Transcend 2666 MHz 8 GB DDR4 DIMM on 23 Oct 2019 Wed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

On 23 Oct 2019 Wednesday, I bought the following *replacement* computer com=
ponents.

[1] Gigabyte B450M DS3H SOC AM4 ATX DDR4 MAINBOARD SGD$113

[2] AMD Ryzen 3 3200G 3.6 GHZ AMD (VEGA 8 GRAPHICS) SGD$138

[3] Transcend 2666 MHZ 8 GB DDR4 DIMM JM2666HLB-8G SGD$58 (bought on 24 Oct=
 2019)

Notes: My previous 1X Kingston DDR4-2133, 2X Crucial DDR4-2133 and 1X Cruci=
al DDR4-2400 memory sticks are not compatible with the new motherboard, acc=
ording to the computer shop. I am reusing the MSI GeForce GTX1650 4 GB GDD5=
 GPU video card and other peripherals in my computer casing.

Grand Total: SGD$309 (on 24 Oct 2019)

Conclusion: Windows 10 Home Edition 64-bit version 1903 is working beautifu=
lly without needing to reinstall the operating system after a complete over=
haul of supercomputer hardware.

Remarks:=20

For the past 13 years after graduation from National University of Singapor=
e (NUS) with a Bachelor's degree (Second Class Lower Honours) in mechanical=
 engineering, I have NEVER had a stable and permanent job because I am a TA=
RGETED INDIVIDUAL (TI). A Targeted Individual is a person who is persecuted=
, targeted, and marked by the [Singapore] Government. Covertly and subtlely=
, the Singapore Government does not allow me to have a stable and permanent=
 job earning high PMET salaries like $8000 or $9000 a month. For the past 1=
3 years after graduation from NUS, I was *frequently* fired/terminated from=
 employment or forced to resign. I am always *struggling* to find part time=
/temporary jobs earning $7-$8 per hour. As a result, I do not have much per=
sonal savings. When another Singaporean flaunted he has $354,000 in his ban=
k account, I only have less than $1000 in my bank account. I can also recal=
l that The Straits Times reported that a Singaporean housewife was cheated =
of some $700,000 some time ago. When my home supercomputer failed, I can on=
ly buy the cheapest AMD Ryzen 3 processor and the cheapest AMD Socket AM4 m=
otherboard. Singaporean Mr. Turritopsis Dohrnii Teo En Ming is the poorest =
university graduate in the world! I SIMPLY LOVE TO FLAUNT MY POVERTY!

POSTED WORLD WIDE.


-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

