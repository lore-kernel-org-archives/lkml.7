Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C064CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 23:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E560920820
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 23:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="EkPVS9tV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfJSXLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 19:11:43 -0400
Received: from mail-eopbgr1320074.outbound.protection.outlook.com ([40.107.132.74]:15648
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfJSXLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 19:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2WuMEU/wwdZHMrQUtm9PiTEcFPwSO1q+NxS2FF43on5sCj+Dm+HGXbF3M8J2vaRer4Pr/Rie57m+e8XJTE4ssnZXZTCHwYe6jkMRaHQFbFCz3TmudNgLK0viDC/lsMGStlwIYbeNtnSXxozN8kDJLB0z3ZyZtaVjbWQbIEg1vz4DQj4bVXSaOVdeF4t1GXuZNMVhppXeWdrvDgTjZFuIYswPjB/Hus69982EeczP59oMcZh/MrHU3ANGNQGnzKZGKVJW3x8vLk4Ci9X/TcmZGTRofXRHtA9T1YDNuPisa1SpEbFB3aIlitDeW7knWDv04QoVtXZi3Q2fXw7xBDDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6jJDicMnoFwONIhWvDBdox9GWoLIqvUhMyCqiiJQbc=;
 b=RtEBeHIajtVofVbOpbIZReE30z7V2gBQxiTad3a1rCGgKCIN4swC7eZzsOFJgkJ1byLbxwRDdnaWTSl0CrasnaeSIs8qlsUbL09wrCvnGTgI3uzmtGWuPGmY4aeq/FFPsyXlBEmN4GyBxKTdrF7HUrXuRc7/MSTQXXD/kDhubG2ryivwcIfFLXfmtGWDcLjX9JLW3G9IP8WTAX3JZLOsLyABc0KHoynIAJuoPOEjcw9E8ILPufAGYiaG84QxHbefaEmUSplT1NVyEDjYJQw+eW3pmFEOyTd1lQ5mR8AJPrKZfxtPvLcstIadFIldYNwBpS3dzm9SGbodwOga6A9nOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6jJDicMnoFwONIhWvDBdox9GWoLIqvUhMyCqiiJQbc=;
 b=EkPVS9tVVCO1oi7K4U8khlDvwzro5D3JhF3XQR2pJaAiUz7QL75VH7HR8A59dXAAX5t5HtscSy21ncqBqsJVbENYZe4k8smM+P8j70T9qgM/dpYU0YD29yZXQtEUCIMCT/6I1Ei3SRgEEgMSJbX24X2g0vOhkZSmkU+a+L+kiYM=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3416.apcprd01.prod.exchangelabs.com (20.177.93.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Sat, 19 Oct 2019 23:11:36 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2367.019; Sat, 19 Oct 2019
 23:11:36 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: DNS Records for Teo En Ming Corporation (Office 365 Business Premium)
Thread-Topic: DNS Records for Teo En Ming Corporation (Office 365 Business
 Premium)
Thread-Index: AdWG0nwGuo6rnr6xQ3Wic3HY0ZNeCg==
Date:   Sat, 19 Oct 2019 23:11:35 +0000
Message-ID: <SG2PR01MB214169ED01324CF4BC22522D876F0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37bcfc13-5ca2-4d5b-20ce-08d754e9b06f
x-ms-traffictypediagnostic: SG2PR01MB3416:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3416C03A12E7250AA1593E3D876F0@SG2PR01MB3416.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01952C6E96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39830400003)(366004)(47610400004)(199004)(189003)(7696005)(71190400001)(305945005)(2906002)(99286004)(107886003)(5640700003)(476003)(7736002)(6436002)(3846002)(6116002)(81166006)(81156014)(14454004)(8676002)(74316002)(71200400001)(2501003)(8936002)(966005)(52536014)(6506007)(316002)(6916009)(102836004)(25786009)(5660300002)(33656002)(4326008)(508600001)(9686003)(66066001)(45080400002)(26005)(186003)(66946007)(66476007)(66556008)(76116006)(55016002)(2351001)(256004)(66574012)(52230400001)(6306002)(14444005)(86362001)(486006)(64756008)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3416;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8I/WNgCZvPxE3el/4OuHpoG2UkOoGYxX6UzsNXZIfLlDAkWS/wN3f8Igwq+t2H0fRu7o5opqergNbGkZ7jTWYRK/nfZpEU7b1OXipVqmpuDvb+xdf/mNeYes7vf72VFpqQK73u9ZUsPv81zOx9QImszlfmzrPhAY0lbU6PKmyMNWTKlaeFjGCJvIuBPUOgfDWYYjuSdihT1nkM3Io3zwbQWO+ImBfJKlHV2w4Qt2haO/qQFUGpgADAOOxj9XZIiAfVZ4pLUEshlCoef4Ph3rb9yM/MpWEH1/9US/IEJPLN5Fz7JcDUGoZpQh9tKUzkLEUSCdwFHtF59ajVwqxSpwcrEmdNXHksA//wYwp2RhNp0Md1Us8lUHAawW8aNdtoZ4Tmjv3c6R/1vWwt5V5tD2ahesEmEA0ajjwNvS73c01yZ/VLjacylGZTWx7TodSE0zz1rApHusifkLWgOVEeguQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bcfc13-5ca2-4d5b-20ce-08d754e9b06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2019 23:11:35.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AQHmpEL/CEkvwi8mqXepc5A29ge5IpejWew9VkCFGzyTBIulOGGahpa4IFQ+nyxA4f6JS7YIAK4oQf0b8aSKQjx8YmlFeh2z2RG2SCE617c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: DNS Records for Teo En Ming Corporation (Office 365 Business Premi=
um)

Good day from Singapore,

Office 365 Business Premium User: ceo@teo-en-ming-corp.com

Windows Command Prompt nslookup:

teo-en-ming-corp.com    internet address =3D 184.168.221.46
teo-en-ming-corp.com    nameserver =3D ns37.domaincontrol.com
teo-en-ming-corp.com    nameserver =3D ns38.domaincontrol.com
teo-en-ming-corp.com
        primary name server =3D ns37.domaincontrol.com
        responsible mail addr =3D dns.jomax.net
        serial  =3D 2019101803
        refresh =3D 28800 (8 hours)
        retry   =3D 7200 (2 hours)
        expire  =3D 604800 (7 days)
        default TTL =3D 600 (10 mins)
teo-en-ming-corp.com    MX preference =3D 0, mail exchanger =3D teoenmingco=
rp-com0iei.mail.protection.outlook.com
teo-en-ming-corp.com    text =3D

        "v=3Dspf1 include:spf.protection.outlook.com -all"


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

