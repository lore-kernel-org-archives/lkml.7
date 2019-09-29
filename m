Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED84C47404
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2A2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 18:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="oPNBQezA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfI2R7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:59:08 -0400
Received: from mail-eopbgr1320087.outbound.protection.outlook.com ([40.107.132.87]:45120
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728853AbfI2R7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:59:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuQiFG6iuyK/PhHgq/JilQCaI1Z29VtXMydZ1U8wIXYOgHPkUHO5tAi6/8jti/GY6H3vhuPurZxbkfQf5OYY3kVUyU8sdmwkcUJZlJysfWwySw94ZIKm/T1xgsnRXBy05XCxAl2paB6RQKB7WyyXyNtH1xe/lJjfD+3QMpwPJas9t1SyyApqYnUNZGU+kU5Z85cL/lVLNAqzcJJCWZAv4kUTsFUzzhtDg1i0oKXpFyQzRNWTmFKFwi16JjgnQTpOYhtrY0BfduAgLu2y5oWw77R6nUGcJIatncSPZEBLSmkF8HorfXxfS0ERFHQJRdUFD1CWAHHOcCfAA5gsXsmmFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzeWybvAQpg4ZiRAULy2ZaQW7dacaqTOBH1s1cdGSw=;
 b=AqccyrbVqO5r6YGeoQMD8Y65Z6XuI38Udm1QRp/2ivKcywUQ+8lA54WTidrdHq61dSOTV/kuqK387+0N6n+No8jv7HfBvyI1VUbPhBZKbwuLcDJlb7W3uaKTCj6CBbhKQfJkrJfm25nnpc+rpg4LsegyMSXapWPTyZqCZOX54YMJhyRfmzn5HLEQsJZfVWLrLN/vqfK8bo4kz+IQ4/zsm2x/RLovpP2e5FDH9xVmK77vWfRGQf1pM2cxj/wPHUGkqxgOuLjy8Z2MJf69qnchIpnbtXj9XKTWrgClPq+RKxLsmEpiANc0mKVc1Pg/K+GDUAdPEmuW61NKa47pbIPa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzeWybvAQpg4ZiRAULy2ZaQW7dacaqTOBH1s1cdGSw=;
 b=oPNBQezAU7rTJo15jDx53GnDqpvta20TTJZlp3kGikCFJj7XByiWKOYFI6gh+Bkvf+91r9Ag5j4AQ5MMww/O5sfOdhF5pe9KvTXLYFRMt6TAcvLJOM6wwFaz9txjuvDY/W3X7PJqX0kXemsthJ1Ba+RQahOZFaSzSUhUcno1V/I=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3030.apcprd01.prod.exchangelabs.com (20.177.94.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Sun, 29 Sep 2019 17:59:02 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::f858:da7a:3a41:fc84]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::f858:da7a:3a41:fc84%6]) with mapi id 15.20.2305.017; Sun, 29 Sep 2019
 17:59:02 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 128Bit Video
 Card Improves 4K Video Rendering Speeds by LEAPS AND BOUNDS!
Thread-Topic: Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 128Bit
 Video Card Improves 4K Video Rendering Speeds by LEAPS AND BOUNDS!
Thread-Index: AdV274u1pSz61UOfSj6SSNjbASk50w==
Date:   Sun, 29 Sep 2019 17:59:01 +0000
Message-ID: <SG2PR01MB2141BAEB1B34B34780C3703187830@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0465508c-3417-492c-a345-08d74506b605
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:SG2PR01MB3030;
x-ms-traffictypediagnostic: SG2PR01MB3030:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB30302094C82DC7C029CCFF5A87830@SG2PR01MB3030.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 017589626D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(6029001)(376002)(136003)(366004)(39830400003)(396003)(346002)(189003)(199004)(6116002)(476003)(966005)(2501003)(305945005)(74316002)(26005)(6506007)(2906002)(71190400001)(71200400001)(99286004)(8676002)(81156014)(81166006)(8936002)(52536014)(7736002)(186003)(486006)(508600001)(14454004)(256004)(14444005)(3846002)(86362001)(5660300002)(102836004)(316002)(7696005)(66946007)(64756008)(66556008)(66476007)(5640700003)(6916009)(25786009)(107886003)(76116006)(6436002)(4326008)(33656002)(6306002)(66446008)(66066001)(9686003)(55016002)(2351001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3030;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r9EFWidoY29GSnjD8FdzDl/MJUA0dytmBmIGkeBQT4iRnp+VdLqqD2p+qH4knMlFyRTNX1WB6S28Y+E2gYaiiZ3e3yekRLReYYs/M7xKg0Ro60vot+5QBGGKaH8hseD4ee4K39yQRtSWB4Mh4SmvAcPN1WDGmQE9MYzaCgM/uehhderAFllP3e2e+uk1ncKWI+bMiaHo6HvBp1WiuQju2EfRRcGmVoOALFRY34ZA1gVLD3nzIOOMyi/joB2QMnlsYKrHb1g4HWMP8heTV8Q4o3DWoDIxkWUmqIyZ3eDxj24zWB/pfxIsYRp6N9sWi3DTpQXIIZLD8Tvq4V0cD1P4b5Fe4njrqeTcccTVLtc/yZRl1meZRjSR6doC4rdbANCA8m29xJ/D2bhJ+8xhrHm+jy8xDQd2O5rRuBfjPGyjLPySy7q3skHiRS8JQRtnR8OQk0Ms+Y4RzZTrT4X7+BcQyQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0465508c-3417-492c-a345-08d74506b605
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2019 17:59:02.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kspo3geyrNrKuU+HK5sJakqpa/GiCaF8pTxDm0o2pfyWj9ivZE64BDJM/J4oqaoPic2mRZgzumji9e/Y/BEyISMEsjbW4h8RSJfnYhBGCTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 128Bit Video =
Card Improves 4K Video Rendering Speeds by LEAPS AND BOUNDS!

Good day from Singapore,

I have just bought a Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 1=
28Bit with/Display Port/HDMI/DVI-D/CoolingFan video card for SGD$230 (after=
 some bargaining) at a 4th story computer shop in Sim Lim Square in Singapo=
re,Singapore on 29th September 2019 Sunday Singapore Time.

Prior to buying the above-mentioned video card, I was using the Sapphire AM=
D Radeon HD6450 video card. Rendering a 2-hour 4K video with this ultra che=
apo video card (GPU acceleration of video processing TURNED OFF) took MORE =
THAN TEN (10) hours!

The technical specifications of my ancient and primitive home desktop compu=
ter are:

[01] 5th Generation Intel Core i7-5820K Extreme Edition Processor with 6 co=
res and 12 threads @ 3.30 GHz

[02] MSI X99A SLI Krait Edition Motherboard LGA2011-3 Socket with Intel X99=
 chipset

[03] 32 GB DDR4 Memory (Mixture of 4 sticks of Crucial and Kingston DDR4 me=
mory sticks)

[04] Windows 10 Home Edition version 1803 64-bit

[05] Vegas Movie Studio 15.0 Platinum video rendering software

As of 30th September 2019 Monday Singapore Time, Intel Corporation has alre=
ady released 10th Generation Intel Core processors. I am truly very sorry t=
hat I am not able to afford upgrading from 5th Generation Intel Core proces=
sor systems to 10th Generation Intel Core processor systems. Hence I have t=
o make do with buying Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 =
128Bit video card for SGD$230 at the moment.

After removing the Sapphire AMD Radeon HD6450 video card from my home deskt=
op computer, I installed the brand new Galax GeForce GTX1650 EX-1 Click OC =
PCI-E 4 GB GDDR5 128Bit video card immediately. Upon booting up Windows 10 =
Home Edition, I quickly turned on GPU Acceleration of Video Processing in V=
egas Movie Studio 15.0 Platinum. I would choose all 4K video rendering temp=
lates with "NVIDIA NVENC".

From Wikipedia:

[QUOTE] Nvidia NVENC is a feature in its graphics cards that performs video=
 encoding, offloading this compute-intensive task from the CPU. It was intr=
oduced with the Kepler-based GeForce 600 series in March 2012.[1][2]

The encoder is supported in many streaming and recording programs, such as =
Wirecast, Open Broadcaster Software (OBS) and Bandicam, and also works with=
 Share game capture, which is included in Nvidia's GeForce Experience softw=
are.[3][4][5]

Consumer targeted GeForce graphics cards officially support no more than 2 =
simultaneously encoding video streams, regardless of the count of the cards=
 installed, but this restriction can be circumvented on Linux and Windows s=
ystems by applying an unofficial patch to the drivers[6]. Professional card=
s support between 2 and 21 simultaneous streams per card, depending on card=
 model and compression quality.[1] [/QUOTE]

And WOW! Rendering a 2 hour 19 minute 4K Ultra HD video (taken with my Sams=
ung NX500 4K camera) with Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GD=
DR5 128Bit video card took only 3 hours and 30 minutes!!! This is a vast an=
d tremendous improvement from the past of taking MORE THAN 10 hours to rend=
er a 2-hour 4K video without any GPU Acceleration of video processing!

What do you think would happen if I am able to afford upgrading to a 10th G=
eneration Intel Core home desktop computer?

Greetings from Singapore!





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the United=
 Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5 Aug 2019):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

