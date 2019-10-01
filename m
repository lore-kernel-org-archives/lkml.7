Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33851C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC715215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="nszivSgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfJAJpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:45:33 -0400
Received: from mail-eopbgr1300080.outbound.protection.outlook.com ([40.107.130.80]:21248
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbfJAJpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:45:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B37d87Ei7DAfKA8AKUAbnmy+dKq1yNZb61o45Ub6QBB8IXXMiXdG3/HyxsgAlnvfdkuh1POD1jnkyu1lKi5jAoT8AKCNswCaxLbMW8QziQjArR/I2uigsVdUupBBJCVGIcqkDgEaGbmZxeIEOm4tqRZwsfHOXY/i0ciFsOm4lLrIsGdgIbFOIs95kuLga6Q51reslj/FhVB9snzz7tEYkXhjb7zvjCxcqj+TFbqwhK2d7f/C/BvTDNpTmpOUUKGAf+NhYNw9oXNfo8fyKnCOnaBhhv8S4P1YzUvMuiOk+m5IuMEMySIAKVvQC0oVnxE7GSdNQq3lgMOhWFgMONMk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lxabX02jGGWeGzWvPoSfXd00e7lGV6PvjwvZdr6wzU=;
 b=MwkEuVRbg3WfmxxNGz72Ml/oOV+ShrJ32QKLdTbR2zmlXRsgHJzQ5zDDVAlD87QSbevrbfX2rdPgSMkO21MigRcKVmwbRJpdtb+ygXM2wLJvM+T2mZBSggpd/JqWdE+1SCDJWJ0F/O43TbYdWmyz5jxNbz2qFqh33Dd+goFfwyu6kY+18pSJUNfGVVHUalOSzlHwwyqCFX7NFmHqSHbUKz5wnrBjWG4Rq6oFzMZGqfdK80QIKEo0EXi+21qMG2nSaSdp9qpkuiMH7vQ1ztWvQQEEmGGYlfgt9oSe+LraHnfR4Dcvj5L3M6NkfL34LwuOsc5N87kduQM084e7hT40kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lxabX02jGGWeGzWvPoSfXd00e7lGV6PvjwvZdr6wzU=;
 b=nszivSghCpvE1FM/U40mMv514R26coi9RqtSIbOKNC4v0WWA+ai1p449UrJ9pc+NVRPGIupDTYlkBdn93GnsWhpeEdFrGQDSaEYthNankNuhr0SxugMGFZwQaedJyG2ytTxQj7eKkp0N98EhFguFS1hjtlv+ElVEK10DDOZPpeI=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB1885.apcprd01.prod.exchangelabs.com (10.170.143.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.18; Tue, 1 Oct 2019 09:45:25 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::f858:da7a:3a41:fc84]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::f858:da7a:3a41:fc84%6]) with mapi id 15.20.2305.017; Tue, 1 Oct 2019
 09:45:25 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: RE: Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 128Bit Video
 Card Improves 4K Video Rendering Speeds by LEAPS AND BOUNDS!
Thread-Topic: Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 128Bit
 Video Card Improves 4K Video Rendering Speeds by LEAPS AND BOUNDS!
Thread-Index: AdV274u1pSz61UOfSj6SSNjbASk50wBTS7QA
Date:   Tue, 1 Oct 2019 09:45:24 +0000
Message-ID: <SG2PR01MB2141B4306D355757D8C81C11879D0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
References: <SG2PR01MB2141BAEB1B34B34780C3703187830@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SG2PR01MB2141BAEB1B34B34780C3703187830@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d8b321b-db59-4b0d-decc-08d7465415a4
x-ms-traffictypediagnostic: SG2PR01MB1885:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB1885DE84D72D8DD773D30C0B879D0@SG2PR01MB1885.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(396003)(136003)(346002)(39830400003)(366004)(376002)(199004)(189003)(13464003)(508600001)(14444005)(53546011)(6116002)(966005)(14454004)(25786009)(74316002)(66946007)(2501003)(52536014)(186003)(3846002)(6916009)(81156014)(33656002)(66066001)(256004)(8676002)(71200400001)(71190400001)(86362001)(76176011)(8936002)(2906002)(5660300002)(7736002)(6436002)(446003)(305945005)(229853002)(66446008)(26005)(9686003)(81166006)(4326008)(6306002)(476003)(99286004)(11346002)(486006)(2351001)(316002)(6246003)(102836004)(7696005)(64756008)(5640700003)(6506007)(107886003)(66556008)(66476007)(55016002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB1885;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3K4gBqYspHQ/UBPyRe/5fri+rJriVy4hgQ+qpqbTrb2tPvhxAOUNisTAjsevbVFOwOJrANvQENPD9Si41zf6pDy+iQvDNpufdhlJic+s7bYn5NgUT7QyqY+wbrQcMZmIpTYGaFTENx/MiIa2EINWCSUuwsbNnWtNgIa5zWYNMM1M9ya54CdFOv0ZOH9h0VtzjDQPYSW2rqKHm6z/7Xa3UqpXNmzkB6y/J87CP3XQLXNwPB1PD66CdSaDoICU1sSMlUMiWfeB3mdseaMgBp6a8oCBsvxFW0Q8Hf68x47aR4qNgV3ApXBZPViV06XC/VOU/JF1Zw3Mlj1w7nERXQmHmagOgAFUsxbtlEsbMqldH1AGbqmvXaIkL/tvqv5FGwVLJLu+PMwqruDnEobuNASQcWGeGmn0ld/klJfpDuFwjZapBCUdw4X/Lv7kMfUkSXCei0hnk0zQ6y8oX2WuqGEOvw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8b321b-db59-4b0d-decc-08d7465415a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 09:45:24.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIsoAz++Mr4WlRkXbGuWk1iCX3hIhwYQPQhqMxvokNdAvCTwf/ON3lgaU5OAv+bEp4BNgdrtU85VkKXMiMWt0TwQ2yyAPuYvSL2pKFF6HwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB1885
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More 4K video rendering speeds with my brand new SGD$230 Galax GeForce GTX1=
650 4 GB GDDR5 video card with hardware encoder:

[1] 2 hours 31 mins of 4K video took 2 hours 50 mins to render

[2] 2 hours 26 mins of 4K video took 2 hours 44 mins to render

[3] 2 hours 27 mins of 4K video took 3 hours 24 mins to render

[4] 2 hours 48 mins of 4K video took 3 hours 15 mins to render

[5] 1 hour 40 mins of 4K video took 4 hours to render (anomaly)

[6] 1 hour 53 mins of 4K video took 2 hours 7 mins to render

[7] 1 hour 37 mins of 4K video took 1 hour 48 mins to render

[8] 1 hour 46 mins of 4K video took 2 hours 3 mins to render

[9] Forgot to record details

[10] Forgot to record details

Previously, for the past many many many years, 2 hours of 4K video took MOR=
E THAN 10 hours to render with my old, ultra cheapo Sapphire AMD Radeon HD =
6450 video card in my 5th generation Intel Core i7-5820K home desktop compu=
ter. Since the year 2015 or perhaps even much earlier, it used to take me a=
 very very very long time to upload combined and rendered videos to YouTube=
 after recording them. Because of my poor finances I couldn't afford to upg=
rade to a 10th generation Intel Core processor computer system or buy a far=
 more expensive gaming video card (typically costing SGD$1000 or more), eve=
n though I am a good university graduate from the National University of Si=
ngapore (NUS) with a Diploma in Computer Networking from Singapore Polytech=
nic.

With effect from 29 September 2019 Sunday, this lingering problem has been =
resolved with my brand new SGD$230 Galax GeForce GTX1650 4 GB GDDR5 video c=
ard with hardware encoder.




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

-----Original Message-----
From: Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>=20
Sent: Monday, 30 September 2019 1:59 AM
To: linux-kernel@vger.kernel.org
Cc: Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Galax GeForce GTX1650 EX-1 Click OC PCI-E 4 GB GDDR5 128Bit Video =
Card Improves 4K Video Rendering Speeds by LEAPS AND BOUNDS!

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

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of U.S. Em=
bassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic Qualifications a=
s at 14 Feb 2019 and refugee seeking attempts at the United Nations Refugee=
 Agency Bangkok (21 Mar 2017) and in Taiwan (5 Aug 2019):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

