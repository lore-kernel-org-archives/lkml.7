Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DEAR_SOMETHING,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F87EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BA820700
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="SOKIJ0wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbfJDNrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:47:53 -0400
Received: from mail-eopbgr1310045.outbound.protection.outlook.com ([40.107.131.45]:63064
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388376AbfJDNrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnbmn3Ir7u41HgvRGRGYFsKopXc6GOzmyUfiOWo9OjZeVGHYLVDeTVzxzQufp6G9hwXvyUBGceZGXye/5kPAJ3dOiTgWLcEmJ1qph4MHv0AJjuh4wWRZ2C4mGP+uSmFaRcl2l6/BmiMArGrHTcMMmbYutrVrHqF/YELMo9/V4VNgs0EZEL2WA3UQ5Z7RzZ7xilP90CH4Yg0hFij+P/+hRfMcpNzFKM05q/UF3BFOqgkByz6oX8H9TH0FISERWQsIsJPunhiq0H4cgltFwiYe+SjCbfNZ+EdPsFhMrLaNTEolqtD+YVxtT6aKJZluTzoNqGsz/fRgYOG8RwLymJ8ZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DNdGl30sxVajcdFqIOPcCbRV6kPsZ0V3BrrGOk6LKE=;
 b=FMTwwZKoFLUQshSn48v8ncjcQLkRLc4z8o6heTtpOWnUAwEM4TVRw4EiWYI64P1B0IUUZihpWjLU7u1s0Pa5BNZFTl8oO2mNVjB1fTE2PBZFXBPmLayiK2QS8BLhbw3tTNO1fn+q/9sVdSHqFTcMywiaw2zj2UEmpNfP1v8bVp7naCSvlF/KQwgt2OmOUidIOIGgaO9s2rmXni1VtpadL2mz031PWG6xQRjFVuQjCn6Fe1ptof0RrvVAQ0AXQ1fP4jiqq43o5lbDiyvsowwZsAIKrd05K+T1jICTejTHzqVhLkVIbyNZG7vf+Y4woXU0jeLnq0tHBezReoenA+uROw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DNdGl30sxVajcdFqIOPcCbRV6kPsZ0V3BrrGOk6LKE=;
 b=SOKIJ0wo1gExyFiF8PpsywQQ/TBx+xbsZpEtwzoi99HtSg6UFdZ+uWd9XlTCpXweOnjyZYTUAHT5alIYQiNvA5Kp7yl2CQriIisyWxqu8Sr0rYoulfDid8F+yYChFn4CGKD3jD/orYtcNjnsFmPWMqzgbxZPbpYQpbkUMEHR6fg=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3488.apcprd01.prod.exchangelabs.com (52.132.235.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 13:47:47 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 13:47:46 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Memo from Orthopaedic Surgeon at Singapore General Hospital for Early
 Onset of Osteoarthritis
Thread-Topic: Memo from Orthopaedic Surgeon at Singapore General Hospital for
 Early Onset of Osteoarthritis
Thread-Index: AdV6uj35cdwGVqr+T0u09hQ8FudA4Q==
Date:   Fri, 4 Oct 2019 13:47:46 +0000
Message-ID: <SG2PR01MB214192F460F25787EDD8B80C879E0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18165533-44db-46cf-d975-08d748d17079
x-ms-traffictypediagnostic: SG2PR01MB3488:
x-ms-exchange-purlcount: 6
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB348852AD0A69B6E4E761D9C0879E0@SG2PR01MB3488.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(66476007)(2351001)(102836004)(55016002)(6306002)(66446008)(52536014)(9686003)(64756008)(81156014)(5640700003)(33656002)(7736002)(3846002)(6116002)(486006)(66556008)(5660300002)(26005)(86362001)(6916009)(6436002)(76116006)(99286004)(2906002)(966005)(107886003)(256004)(508600001)(66066001)(4326008)(8936002)(186003)(7696005)(316002)(74316002)(25786009)(8676002)(476003)(6506007)(305945005)(14454004)(71190400001)(71200400001)(81166006)(2501003)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3488;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e6lybmorl4FBDqvmVfjFP24/kEglQryYf1JF8f+uty7ktVjbGVaYuNLv+XNzwGInGX92BUorKq3sk5NRjCG2SQVPze+gElITgT+5FDgNW9Y1+5M87uOOD8KWNpagR2alajVAsrGqOdTiZbAnnpWbVQiscQAIPFdGk26+AL3wHCYVQb8sAdMxKKLMNvK9G+Vme605DKzp74tX8C+J7qrH3e9a5n/CBAIX8QrRK4FwPQitSsBNaWB2mP/eTwXcpG3hQG10MwdJFoqEfvi/ikI1p17k2J6iGhl3OYaTNc+gRO4kpIeN03JnLB0Z+mzsgMIquN9wvuMoe/efVXKq12fcDO86xnm9vOmZdQJN1zTIO0CnhiWxbwvuoG/r5c8tW1uvT2c1TQmmXX6YSnomnFlzkHgjiWaeatiJ9gCuAbkhVj4ZT1Jq/TKrhWWqcSzL/AkePuM8wFWCINvgDyktSQookQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18165533-44db-46cf-d975-08d748d17079
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 13:47:46.5994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aHmGrlXSylxVjGm3VrPt3OOhCUM/p6uI1XEKpl+X+eda5T4s4l2joxZymm1lJVi7eXycimSNXS5xVWN4n8nEM+3t4/tT9oEhNmJZ2IcZEeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Memo from Orthopaedic Surgeon at Singapore General Hospital for Ea=
rly Onset of Osteoarthritis

Singapore General Hospital
SingHealth

2 October 2019

Dear Sir/Madam

TURRITOPSIS DOHRNII TEO EN MING -ZHANG ENMING ,

To Whom It May Concern,

This gent has early osteoarthritis.

He cannot stand for long hours, can walk 15km in 1 day, have difficulty cli=
mbing steps.

Thank you.

(Signature)

Dr Chia Zi Yang
MBBS, MRCSEd, MMed (Ortho), FRCS (Ortho)
Associate Consultant Orthopaedic Surgeon
Department of Orthopaedic Surgery
Singapore General Hospital
MCR 14877F

For scanned image of this doctor's memo, please refer to my RAID 1 mirrorin=
g redundant blogs at

https://tdtemcerts.blogspot.com/2019/10/memo-from-orthopaedic-surgeon-at.ht=
ml

https://tdtemcerts.wordpress.com/2019/10/02/memo-from-orthopaedic-surgeon-a=
t-singapore-general-hospital-for-osteoarthritis/





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

