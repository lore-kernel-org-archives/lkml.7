Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A754D20679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="P0gtKy5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503269AbfJYOIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:08:02 -0400
Received: from mail-eopbgr1310054.outbound.protection.outlook.com ([40.107.131.54]:60989
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503124AbfJYOH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5gE7KcOSrd0yCFQtseFRd8y8zHMfrTMh9IGk8gVpxby7i2lV4crdq4xgY2mPDEMDJC+S84b2ON6iU0pz4x8yf2AdbjG1BKlWuMVyxhFnKnrHXrUpNYc4FfpzyvNjEo71w8EC7wWeK7ZNcs7Ze/LMUvNOwUcb2LXW3GGfv1QdSGeKlpBULO1XtDw7P/2+Z549SHFCCDpvSor81k1TS07dJxCF1L+OrNEY1GaXoG568jVTxqmpkzVoF1kGZVJhrvFyq5TwypSazFBLPTJoXAeNYddvOajGyp7KHFUHesUT5SdmGSYqwqC65g884PplLSgqNvKFcV8KmpWasBxNHgiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd0KZD27Mw9UtCFHDg7DoPRSsckqKDe6hrnGhFMwleg=;
 b=ByQKI+iCNFjLpTrYUBmHyJ5V0ZAcl6cXwHZA4RrwmZmT1MLP7WtgyaPPMwUJ5ut04EdSB5XnOduL5hILeJIPAO8tk4iq0bzn0jITKv+SQ3H9SEjAghpsNOoonT4eqTeyAs8ryIM5Baz+qf3NUSJCS8ELHPOhFs1G90MVRIGFjoEUAn7SgK4O3riGOP0USP7YsRvw4NuPUVXPeHJgr4tEQuMUdAXr3Tu/Jklm5muceOJma3hhxvAm5lIcTGSvzCfcjFDescIWisaJOtpeY3CnaoWNFR2JWhTMFD3cIvbO+tThxbv6KqbAznZB1MyudjhiZnoBDkIEJquSGWVOM8OeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd0KZD27Mw9UtCFHDg7DoPRSsckqKDe6hrnGhFMwleg=;
 b=P0gtKy5EiQPAdoGLFkbxEABJ8V0JQhq7HnWnSHVmqn7306UXPG3CaWAnFCX0fuKsAyVMzbAvQ2aWB2SwSl4EXTQaC1yqmgM3TzG3LCPREDTCp1VhfKBxXE1FkOLrl2wLVwDGq7Jce1br3Q4Zmx+6gB3oNNwl9eaqRxDa+Xj6piw=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3352.apcprd01.prod.exchangelabs.com (20.178.152.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 25 Oct 2019 14:07:53 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2367.027; Fri, 25 Oct 2019
 14:07:53 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I bought my Sony A6300 4K camera on 03 JUNE 2016
Thread-Topic: I bought my Sony A6300 4K camera on 03 JUNE 2016
Thread-Index: AdWLPXeoIGDkviafS5eWQzkvvJe7mw==
Date:   Fri, 25 Oct 2019 14:07:53 +0000
Message-ID: <SG2PR01MB21416F8F998EAF0D20F9EB0A87650@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:1ef3:41e9:3466:4716:2746]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cc2616c-a23c-4c67-52cb-08d75954ba5b
x-ms-traffictypediagnostic: SG2PR01MB3352:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3352F9D80CC8E5FCA493D80987650@SG2PR01MB3352.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39830400003)(136003)(376002)(396003)(346002)(199004)(189003)(64756008)(66476007)(66556008)(107886003)(66946007)(25786009)(66446008)(6506007)(6116002)(76116006)(508600001)(102836004)(55016002)(71200400001)(71190400001)(99286004)(74316002)(305945005)(4326008)(7736002)(7696005)(8936002)(6916009)(9686003)(6306002)(81166006)(81156014)(8676002)(186003)(5660300002)(476003)(33656002)(486006)(256004)(316002)(14444005)(2906002)(966005)(6436002)(14454004)(86362001)(46003)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3352;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VH8kCWX6rNgIVqjXPfzmKSmH5JJ6ikbHPGO13B0hCIVKEuROJ+jTSya+p08Hc5XP3lDGeR5KPG71vB8Hpv+v9FdqHUESo6YJGaDq9oIWO85gOdtA+gAr6L1npc64sbuSQf0I5aKH/mo0we4v66LXK1fpAgY41UQh+3OlTfv7JgNu9nh6g4x7p80wieHNvg8i718WlD5bqe9rGHkGcQwRYdpWNQwQXPobbdz15eiz21XXl/5lW5nzgqEh1kkhTyOnrIOkAiaB9NChhmZHoD0sF3lPJUnI4Ld5VarWgQi2CdSt9ILUprXXMYxar8tF7ITkwhqi9squ5v2Mnwju7BCBcE0E/VRppKpUs1st+oZkd0yCziznPVgi1jxtRwQrEn0Rki+qvTS62tEd/WhjuchMZrlMF2kLRpgAfRmcxP1/H5MVD2hByIGWMFJ58B0rTfpJJ05P7Q9tb2iAe4yRAe5LSHUgI9luFP7DwCWJkDN4IAQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc2616c-a23c-4c67-52cb-08d75954ba5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 14:07:53.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUu/jrL85biAvE9BO/gu9p8HGg7rQPrVnXJUrZ0SAaSXfNEMaylfr43hpxG4VifwkVExCDgtmwTEBUQhegm35cC6BuzhjQPXwtK50hErvhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: I bought my Sony A6300 4K camera on 03 JUNE 2016

Good day from Singapore,

TAX INVOICE FOR 03 JUNE 2016
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

1. SONY SDXC 64 GB PROFESSIONAL 4K 95MB/S (SF-64P) 1 PCS

2. SONY ILCE-6300L KIT W/SELP1650 LENS 1 PCS

3. SONY CASE 1 PCS

4. SONY NP-FW50 BATTERY 2 PCS

GRAND TOTAL: SGD$1728.00

TAX INVOICE FOR 26 JULY 2016
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

1. SONY SEL 55-210MM F4.5-6.3 OSS LENS (SEL55210) 1 PCS

2. HOYA 49 HMC UV (C) FILTER 1 PCS

3. SAMURAI DRY BOX 1 PCS

4. SONY NP-FW50 BATTERY 2 PCS

GRAND TOTAL: SGD$400.00

Today is 25 October 2019 Friday Singapore Time.

I have been using my Sony A6300 4K camera for 3 years, 4 months, 23 days ex=
actly WITHOUT UPGRADING my camera because of my extreme poverty. I SIMPLY L=
OVE TO FLAUNT MY POVERTY!



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

