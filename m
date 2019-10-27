Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC3CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 01:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619DC2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 01:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="IoQn4ux7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfJ0BCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 21:02:48 -0400
Received: from mail-eopbgr1310070.outbound.protection.outlook.com ([40.107.131.70]:53536
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbfJ0BCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 21:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLFPem3UaMmhO/qg8XpbcRvUQZDsiEPyZqIgbH0R+fLHV1lwVzqWVnD4egGSdiXiBr+SZwOEDZ4ekER5x0xfGOR8GgqHlyb8/+AxZUSwyCwdOkW5hH5XahGVpC+/Lmjq5gjibU5R5PhGHLkYqlzYV2/+rGds4UghZRdLreLz9m4PyCzcDNqEzj7DaS8jzpZfamUTAp0W+r2pqaAt1apasP83R+hMrly4Jk5uH/2412D26jnEeOAuUZH6Zrcrl9jboxxT6beIaBYLWGzxbfjd9PcBcUVrbiZIGR9L8CjEkEu41L9py8izcORSpfgjwIXmC6sVmwgMttR60ylFVuQTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mltYm1LBluQz0hQQ418nZBuX0xjqUYruMP+AMD9wzY=;
 b=cxFJVgN+xEIYdqlbjevWYs7IEWpzLV6KJhjNkzTTniJjv7Hg7K3BfQ2pxljifjQNsm1bxrfkAW7o50llikOr8axP7not3bTKQjxK05XZDBqvDFmWaFu4TWEbjFA9MGt+dp7AmEvr38QHGlJFHfQ0z+KrR4FUwP6/o2x+pW/bj7L7gCr0ZI5JGFwUE3kCJGDNIFFvhVcL0cImg7MJGvMmffZASrKu298COCnqU71aYWXyx6BiCo1TfvZBrFjpc/OzgAhz6mfJdunVCVpDMD924AOFWRSCYS7IWGJqW7D6HC2whnZM1aZEVvFuCtXscivQ9HNOHInIv+SdokJpS4EJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mltYm1LBluQz0hQQ418nZBuX0xjqUYruMP+AMD9wzY=;
 b=IoQn4ux7RdUulY2qjV4AqMSuzBfxCzdF1J1Cful0QQ/r2txGt8CC1TR4Djm1UdyygKvnHRFKLb5upsKwHlPCU+Db7czfi1qp75KU7lcpHUG1gEwaybKmXI+CQ39fzMACdZ6bPtP13ytyGdrsZT+biaNkOC9hCHbQwQXBEE2tloA=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2581.apcprd01.prod.exchangelabs.com (20.177.95.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Sun, 27 Oct 2019 01:02:41 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2387.025; Sun, 27 Oct 2019
 01:02:41 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: 4K Video Rendering Speeds with AMD Ryzen 3 3200G CPU and MSI GeForce
 GTX1650 4 GB GDDR5 GPU
Thread-Topic: 4K Video Rendering Speeds with AMD Ryzen 3 3200G CPU and MSI
 GeForce GTX1650 4 GB GDDR5 GPU
Thread-Index: AdWMYjaPtYhV6lZ6RlG6X3M9RhBsAQ==
Date:   Sun, 27 Oct 2019 01:02:41 +0000
Message-ID: <SG2PR01MB21410E0FD5C7BC269768399387670@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:1ef3:106c:7d3b:fd3d:9c44]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31c1081f-4c27-489e-8f92-08d75a795e51
x-ms-traffictypediagnostic: SG2PR01MB2581:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB258106520A94E8AAE2994CA587670@SG2PR01MB2581.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0203C93D51
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(366004)(376002)(346002)(396003)(39830400003)(199004)(189003)(486006)(6116002)(5660300002)(4326008)(102836004)(316002)(6506007)(476003)(7696005)(186003)(52536014)(46003)(6916009)(25786009)(6436002)(9686003)(55016002)(2906002)(6306002)(8936002)(99286004)(76116006)(81156014)(66946007)(81166006)(107886003)(508600001)(256004)(66556008)(66446008)(14454004)(8676002)(64756008)(66476007)(966005)(305945005)(7736002)(33656002)(71200400001)(74316002)(86362001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2581;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PgLXaNA4hZ6yHZyoy+7Qc2xhsLPpeY6ebkxHiSZj+NKWqCN3vIh3ao4qtSxf2SHgbth7otQ/Yh7EyIdrSYqrhts184QMRC96V3lfaVI94lgJhjnsFm4XItYgzUKH0czZNzz18hYRYlZJlqBEGN5VgoID//ptIo/N9UBwo0eGlfrH7dN2qLbe+f1sB8XukArJDBAS5EXLvC+xoPfYjGcvM/TF/s9wZBlbzsXYCahTaSMQwW+c/vMPa6FSnA1+LniWa7erkaCJK54BQn0zL+E11whtDZqjRAWNMzwDdk6Nycs0bh/xHd0LyJcqQF9P/NpX6sefguvWDQLLIIbRuJeCyDKxcKIxuRG1+3GTu63mODW5G+4pvLHWw+ahgM+YjDBTv17dfkjcuUKRIN9O7AvieFTgpa+j9wGFYmnkFN7Ezs/1CeldRawQuD21jzsQ4z1kvpMQ+vAnoUMvorw8ROGUbIM51xHLhoH+Hq1zPuPaBOc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c1081f-4c27-489e-8f92-08d75a795e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2019 01:02:41.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM7hQq2e5WLOBa62XtOHMSPCr34YjmmLKz0f4F3VWhta5MtCP+FBMuk+yUOE7QcdCTP5+1u/CZWabzMy/PVPwmaWyrYNnD4IhOhBHtbY4pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: 4K Video Rendering Speeds with AMD Ryzen 3 3200G CPU and MSI GeFor=
ce GTX1650 4 GB GDDR5 GPU

Good day from Singapore,

Technical specifications of my home supercomputer:

[1] AMD Ryzen 3 3200G processor with Radeon Vega 8 Graphics

[2] Gigabyte B450M DS3H SOC Socket AM4 Motherboard

[3] 8 GB Transcend DDR4-2666 Memory

[4] MSI GeForce GTX1650 4 GB GDDR5 GPU

Early this morning in Singapore (27 Oct 2019 Sunday), a 1 hour 49 mins 4K U=
ltra HD video took 2 hours 47 mins to render. Well not too bad for an extre=
mely budget AMD Ryzen 3 processor. It is still under 3 hours and definitely=
 not more than 10 hours of the past (4K video rendering speeds). As a NUS u=
niversity graduate, I live in extreme poverty in Singapore because I am a T=
argeted Individual. It looks like I will not need to fork out more money to=
 buy a better supercomputer for myself in the future.

I SIMPLY LOVE TO FLAUNT MY POVERTY!




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

