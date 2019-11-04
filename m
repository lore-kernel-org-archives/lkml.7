Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A47CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7E721E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="Gk5/VCKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfKDNg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:36:28 -0500
Received: from mail-eopbgr1320088.outbound.protection.outlook.com ([40.107.132.88]:51571
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727236AbfKDNg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:36:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJApRx+DE8e4xqgilpeUIW872lA70vcfuY+BuedjlXQfkCFYFp+Y63foovFVPTDWJnx/mFM4fIiEgwqZfus2DnWj01Of1lKTdsB/Smjxp6xjGADauIwSKWYyYWD7zYmtooQhOpo/F1ihOyBtsO8Tn1i2OSyRks2jhc+VByx7APGTvRbN8olIm1or5emqHdFHHVP9G5NUzetTDI3vuJ2TAIRK6vYIYmIzLRoil8dJKioVH9H5+Ttfu1jQUqeX13SmzOlLj+IuJVs8TKp7s5XKvtKbyVRWsnUsPrzltZtWcidYMrlww1ykcBrJOvi/KjPVmXpt+dVXMyJEmTXMxBgYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixYjoT7LPN/cI0RhD/jkKhIlaajNzpvK2gWG0564QH8=;
 b=RhGKtisP4XdsxuLrFCtiaEtu/c5AB8ETJIVKfmjRxxwBoFbTuwyR1PQChJg9qWAcMCk1fE+h+/xJRJE06uWG1uUudNRzmWlt6vo+tQWJFvnk5Mrm1tSY0FxzEBDVr83dTiBn/lQxGtW97eeBYvaw4soMsSIT01yE/msBwPwRUnv2uTMrHjZXEVIyyvhbKijmwMrcz3DH2bWkW94RiNMBm7ER1SumcPlqoqCNym++KFh/iQys6Va5GeBkiGt6QOYa9vosnf3Zs/fYcLQpa0FJWNVJFjcq0LcySy4ubhnRZk49pW9rQmONpAVGxM5Nx0Plt1/BdcuiqOrt++cMCkaUGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixYjoT7LPN/cI0RhD/jkKhIlaajNzpvK2gWG0564QH8=;
 b=Gk5/VCKu+61QP7Hj1Juxm5bz22LxRW3f+tzzb5F0bBBmZXWRJz9S6D5r27uJ/zq6PItoKOZcQWuB8QcdsDEXznXRJ7HK/armLdF7jgQKldRE8UReU9nQ7Ie8XXPPDHlURJCKFDzVq7KL1u8V2ehQEI7eQcF1ASFcvtT6nB9YCu4=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2378.apcprd01.prod.exchangelabs.com (20.177.82.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 13:36:19 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 13:36:19 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera on 3 Nov
 2019 Sunday
Thread-Topic: I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera on 3
 Nov 2019 Sunday
Thread-Index: AdWTFLokRwJBJ8SrRRKaOiWo4qLLLA==
Date:   Mon, 4 Nov 2019 13:36:18 +0000
Message-ID: <SG2PR01MB214129180D8AACC39620A20C877F0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:e1d9:7971:f05e:dfc1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0aaeb193-bb42-48dd-7b44-08d7612bf96e
x-ms-traffictypediagnostic: SG2PR01MB2378:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB2378EAC13212AA57AE82B80B877F0@SG2PR01MB2378.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39830400003)(366004)(346002)(396003)(136003)(189003)(199004)(476003)(5660300002)(14454004)(7696005)(81156014)(6916009)(74316002)(25786009)(71190400001)(7736002)(305945005)(71200400001)(508600001)(6506007)(102836004)(6306002)(55016002)(9686003)(99286004)(52536014)(6436002)(81166006)(33656002)(316002)(2906002)(4326008)(14444005)(46003)(256004)(486006)(966005)(66476007)(66556008)(64756008)(8936002)(66446008)(66946007)(76116006)(8676002)(186003)(107886003)(86362001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2378;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GCgrYhyV3YNVCNJo9sX7/JSqhlnHNnP8lzaWFV4YXRoikAT1S0upurWGtDJPpjcPpFAtmauB4Rz0yLSQlSmr0shQ7HnQ7MosrJ4VayN1S6BHx8gMA37CEkTjPX0kcsLomPaN3XkRaZGA0WdWrWB1OJp7UWQkKoekZY/tSQLLub9s+vgQGQyn8g3AvOIsSSZDb6ctOTugSHYl3NpypL5D615aVgaOAqUqUPiWtnCn8toRcM7qj+Vw+QCfv2gyJH5uf/2Cw5dal/V3lvEJ5qOpyRJn82OYgoAcejKtOZmhd8o9IG6CeP5vbAx4NsqCDziJb02OYYiVzmJAW83ZSgagc5mpJT8GwI5X714khJ0DM6KPGYyJB4HfOhr00eWbozA/zi++CGVLRTGK/BM3OcTMLRGSgJzhnUZF1PzHw5h9VN4mQgb/FMcNnJYSmWhqqeKyw57w3fdWhOIlj1zyGfFmt6gD8Iaq80ChvbmLxWttW4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaeb193-bb42-48dd-7b44-08d7612bf96e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 13:36:18.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mocTmc7wtHSi8HVRAf7TOdAzYihn15g4H10MwDChD22ApdC7ylA2jfR/CYJTi+fckPLiYzb4jr6IYCBRouJa/yoGXenYlzOWC51tjP+ftW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2378
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera on 3 N=
ov 2019 Sunday

Good day from Singapore,

I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera at Funan Singap=
ore shopping mall level 3 on 3 Nov 2019 Sunday at 3:25 PM Singapore Time.

The Panasonic FZ1000 Mark 2 camera has an 1.0-inch MOS image sensor and a f=
ocal length of 25-400 mm (37 to 592 mm in 4K video recording mode). This sa=
ves me the hassle of constantly changing between Sony 16-50 mm kit lens, So=
ny 55-210 mm zoom lens, and Sigma 30 mm F1.4 prime lens every now and then.=
 I simply cannot afford to buy an expensive full-frame DSLR or mirrorless c=
amera with expensive camera lens in excess of SGD$15,000 (like what most ph=
otographers in Singapore do) due to my extreme poverty in Singapore. I beli=
eve that a hybrid bridge camera with an 1.0-inch sensor and a focal length =
of 25-400 mm costing approximately SGD$1000 will suffice. The Panasonic FZ1=
000 Mark 2 is considered a Compact Camera, but with an image sensor much la=
rger than 1/2.3 inch. It has a built-in flash and a hot shoe for mounting a=
n external flash.

TAX INVOICE 3 NOV 2019
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Qty: 1, Panasonic FZ1000 Mark 2 bridge camera, SGD$1039

Qty: 1, STEINZEISER Battery Charger + Adapter, SGD$28

Qty: 1, DIVI PA-BLC12 3rd party camera battery, SGD$28

Qty: 1, SIRUI UV PRO ALU 62MM lens filter, SGD$23

Qty: 1, screen protector given free, SGD$0

Grand Total: SGD$1118

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is ONLY AFTER I have sold most of my Sony A6300 4K interchangeable len=
s camera system for a combined total of SGD$810, after using it for about 3=
 years and 4 months since June 2016.

The following items were sold for SGD$650 at 12:00 PM Singapore Time at Toa=
 Payoh MRT station:

(1) Sony A6300 camera body, with box and accessories (includes default char=
ger), sold for SGD$400

(2) Sigma 30 mm F1.4 prime lens, with box, sold for SGD$250

(3) 2 units of original Sony NP-FW50 camera batteries

(4) brand new Panasonic 16GB SD card worth SGD$15 given free

The following item was sold for SGD$160 at 1:23 PM Singapore Time at City H=
all MRT station:

(5) Sony E-Mount 55-210 mm F4.5-6.3 telephoto zoom lens (model: SEL55210) w=
ith box

SGD$650 and SGD$160 add up to SGD$810 mathematically.

I *still* have other camera accessories (belonging to my old Sony A6300 cam=
era system) waiting to be sold. I am hoping to raise more than SGD$1000 ins=
tead of SGD$810 so that I do not have to spend so much on my new Panasonic =
FZ1000 Mark 2 bridge camera as I have been taking up numerous mediocre low-=
paying part time and temporary jobs in Singapore since August 2019.

Published 4 Nov 2019 Monday Singapore Time.





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

