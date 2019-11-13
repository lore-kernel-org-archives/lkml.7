Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC2FC17447
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161C0207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="fSC5bf/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKMNwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:52:36 -0500
Received: from mail-eopbgr1310057.outbound.protection.outlook.com ([40.107.131.57]:16608
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfKMNwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:52:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn3K9DoQ22Q4sgmJCozPtgzb9MQ3E0ETeuSxlZcEKZ3wgerRdA9em8GVWS3UNrGrobUfcRH+FQoSRtXON4dD2+9TFRMfQZBpF8gAnBunTpNZ3KXzzTBVo6bKCNl8zh8bMEedajhMeeXzVj1Qu/Queon13Sgwy83ioTu9xkliHB4ByCWbKENJxSj70lELNKNBhX3et6pmIWjW5RQhqL+EUdNTT7QQF8L+r1rtjh8UfXlvt54dUhsYwhOuWkAAqi8hacJRv8PEHueVv1uZNhMmEZlZtgpXJ/a8htmJCvuSB3UmVh6O7xHb8h0x18mEaCuBTdhSt+0yiL1vELf1at+tEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nHEsLaw1Cz9+X1pVruDRkVipWsrR4oCuWZw9ccmmc=;
 b=Ji86eflsptWnON3xrF1F//DyG9NOIody8aqtJjgchUAQyMZkentsbaYu29ggVRkkk3n4gnoZytww8JBQTAUrNL3TQM+UyVRg82tTEb7yumoNTYJcPxWCJQgRkSXI/1mG/uZhjFK49kM65+VBygl7idn39OgYJu7tXr0PRIJ3a8trZqZbV+s1uzFXROCR6M/AOaZymFr0Y2iGH4T7/ph0dv/7ZZx2Ldpyn01hmLD5zxOOeHS1JfE/EVYG3XjcenYppR9zQpGdGueYD5T4k0HhQ9AOmG0z7Ss0bAvMsMCTDdpmmk7Wdr0OlV3oTbpaSFcykybnkx0maJFrfh8s07PQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nHEsLaw1Cz9+X1pVruDRkVipWsrR4oCuWZw9ccmmc=;
 b=fSC5bf/J9jg4X0pjHq4SMGwVcMEOa9kkj/qam2AlNrYsZi9TswjyHQxM1QQe0OLZJQ7Px/UjdqV+D+Qihpmps38IeW5ZPh4leJD0VUEzckaySiPTuEAEeUGhwxUdRCzVww77BVyFXEGFVjTJuzKaKgaWIuuhBlMNIYiGDeChYUI=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3189.apcprd01.prod.exchangelabs.com (20.178.152.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 13:52:28 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 13:52:28 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged me to
 try applying for refugee status/political asylum in several countries
Thread-Topic: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged
 me to try applying for refugee status/political asylum in several countries
Thread-Index: AdWaKXOoZfnAG560QReDNYCOKcF4mg==
Date:   Wed, 13 Nov 2019 13:52:28 +0000
Message-ID: <SG2PR01MB21413B325A251521C53F3C8787760@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:9162:51ee:7860:8489]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75086ed9-aa18-424c-a711-08d76840b8b8
x-ms-traffictypediagnostic: SG2PR01MB3189:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB31898143EBC10E85CBF8068187760@SG2PR01MB3189.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39830400003)(376002)(199004)(189003)(2906002)(305945005)(74316002)(6436002)(4326008)(186003)(33656002)(316002)(107886003)(7736002)(55016002)(256004)(6916009)(7696005)(9686003)(14444005)(6306002)(6116002)(14454004)(76116006)(25786009)(966005)(508600001)(66946007)(486006)(99286004)(52536014)(66556008)(64756008)(66446008)(66476007)(8936002)(86362001)(81156014)(46003)(81166006)(476003)(5660300002)(8676002)(102836004)(6506007)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3189;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WI581bgKostaYy/AmC/U/47heCGVcXx7As08ORrwIXsV1UTKg+jOnqDVxFkRKDkb2YHTWHOTnWbyHvxlRRIyGUv0uZ8FcxpKrOv+8Q9p6hVQDu7Rf9qED9D0bhu7AwM0t/Pn+Mqkwqs0Q5sh7tNErJzl+5HrfLt5zUmH9E0A7QR3y/+L/XOcCgPWEfyl3KMyQeYC23L6XKz5KHLZ0IDduDPJzmCZK2pPelhVXQul1N1o2tkDPyEnhAhPl6qdGAqhcgdMJDPUFtrPx1vvUUEk2lfvyAfVpNa1yE3U7GG2OpZjsSSAAmri1dVZ6eObCdFMNBZRLOooImVh/jN22xXp1i1G0wIf8mcLs32i34R03JRVK099KybxpML/kpKU0fAvjXAefst66yWruyCoTWmdGiaZ1y3/VYmNwnLzmHRs0AX0yJNqygCrNYO1P4qaXFxCneLLgMuCafYocHLB+tetdDrLj/tIw6nyDa1JvI2EWyM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75086ed9-aa18-424c-a711-08d76840b8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:52:28.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8fhxR5CGyskBKkroHTZInQWuHkmWCCeTD6wQWzQoEDOa8xMl3nSBeFxK6JAgUAl2HetewRQt1SJbYKOyI1Ns+3zc5s4mynBVVACYtdXtRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged me=
 to try applying for refugee status/political asylum in several countries

I have a chance encounter with Singapore Democratic Party leader Dr. Chee S=
oon Juan along the street at Toa Payoh Lorong 4 on 13 November 2019 Wednesd=
ay at about 3:00 PM Singapore Time. I was on my way home after a 3-hour par=
t time/temporary job from 11 AM to 2 PM Singapore Time when I bumped into D=
r. Chee. We had a short discussion. I briefly told Dr. Chee of my plight fo=
r the past 13 years, which has been told countless times in my RAID 1 mirro=
ring redundant Blogger and Wordpress Blogs, my autobiography first draft 11=
 November 2019 and my countless international posts. Dr. Chee advised and e=
ncouraged me to try applying for refugee status/political asylum in several=
 countries. We parted soon after.

Teo En Ming's Archives and Records Administration (TEMARA). Office of the G=
rand Historian. Records made on 13 November 2019 Wednesday Singapore Time.

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

