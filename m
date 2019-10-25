Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B287421929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="lsmo3uSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbfJYCKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:10:04 -0400
Received: from mail-eopbgr1310045.outbound.protection.outlook.com ([40.107.131.45]:3835
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389721AbfJYCKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr2mUhoFqQKylNpVKrDkG5UMH5v0kZ6ocY/s7CZ+qz8FA6kBiAefFxBCRew84rQQFvru73UOPIHf5Pg2j9RBHscV9VobMIG2Mkbay7sxpr2vmfhURtIODWyfRu6fTHskucPs1tAXRKCjVtuyTGCSg2mKooyv0miRNQ5O5sWCQqw0MnwzGxWA1jndQdLYh4CD1AXDP4PTRbQkjoFstW0PiKrCaD5paRuFGdn1LABx/3ENEBVKBN7oFbn1EcU6aKiEogncjcD+eA2N7SeMhQDwkacfZwZfEAR9vLY2XDxt81DecGOoDligBSi0f1gynvzkxBC/fWcJcP6ON85qBlr+/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhCu8U0rzLTXBPxQSiINnFuV9vGV+60iaY4/wlmE1QM=;
 b=UGRmd5M7idlF0d/XSnXQkyfQlhzIcvteI/rnFaDLFkeBiGv+2I1rlC98p6CAxDqI2q66geteG5AAWtbhpT3W2Vmfq3cE7plMv3hyubUDCAdYSjohPfRQ/7O2+4O9S6d6QrY3x0bX1QkfG+KiKNnDR7IJoMM9owwiJLx3k6tXyalbCF9Qgn11Uuyzx1YZFe5NdjcSE8x18qi9QTWmJEAX/+cOF2h8+VmtbSvFWDIv+8vw1RPuZ/GJPi4JouhD2BY46DpznsDUnqa+tuRroKoZHbX59/seTEKtzgrB84dAWEXxcKN4ISgVLO3JAPTGXoECzPHdoHY35jNsb99RFosPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhCu8U0rzLTXBPxQSiINnFuV9vGV+60iaY4/wlmE1QM=;
 b=lsmo3uSCrV+nrGTbG7A9aHXMSDhi0Q8gdNIVEPL6/Pp+9bl0BHveej9nRRQjJmVBbMwAjYqzF87gBmPAF0jwhfJnsBICBWtR9y7X7q1GrZNVT9UCNNSLyTsmuzenb+yFfYr7zU3zSyg0ZQaMlbm/pKUIpvKWlo8V+j07/fodSXE=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2SPR01MB0025.apcprd01.prod.exchangelabs.com (20.179.224.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Fri, 25 Oct 2019 02:09:58 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::48a5:3998:fd15:92e8%6]) with mapi id 15.20.2367.027; Fri, 25 Oct 2019
 02:09:58 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I believe Singaporean Kurt Tay is also a TARGETED INDIVIDUAL
Thread-Topic: I believe Singaporean Kurt Tay is also a TARGETED INDIVIDUAL
Thread-Index: AdWK2T5zvWqTWe6tTQm0ElJph/0WLw==
Date:   Fri, 25 Oct 2019 02:09:58 +0000
Message-ID: <SG2PR01MB2141519B5B36F5ACB898D71387650@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:1ef3:d923:25a:c4b4:68f8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4bd5d07-5ed0-4a68-a816-08d758f06f7d
x-ms-traffictypediagnostic: SG2SPR01MB0025:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2SPR01MB002545A1E8204A788C664D1487650@SG2SPR01MB0025.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39830400003)(136003)(396003)(346002)(366004)(189003)(199004)(316002)(8936002)(7736002)(508600001)(46003)(8676002)(52536014)(305945005)(81156014)(81166006)(25786009)(66446008)(71190400001)(186003)(55016002)(71200400001)(6306002)(9686003)(7696005)(66556008)(64756008)(66476007)(476003)(5660300002)(66946007)(4326008)(74316002)(86362001)(6506007)(102836004)(14454004)(76116006)(2906002)(486006)(107886003)(33656002)(6916009)(99286004)(6436002)(4744005)(6116002)(966005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2SPR01MB0025;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRUV/4g31ZpFQDFYuJjZql8T3oGFURDjcvr0R8G+7gUzSvI2sfw5Ze+ytvfqAbeazJn52mBP0a8FRUXUo42g4bBf+EqtS/kBUpEeHPbZ/IfaNqjWUO/4UYTJCKiskdEUUomKNNa0P9wojmOq2kmz/+K89Z8a5XbSNGezhaLtYHc+lMG/ziXLjyj7YzU27I8gtxdxYjpX1mgMPwQLpcgFukGZ6p8KF2lZnTBgO58fin7jktIB5qF7wqK0cqI5rHy+MT7l/YU5FTb9lDtj0p6/gZaO5+cVCChpfp9bpT2oFGSvE5uh96Z7yYpbavuLKMGKNC5bWqcM8iYDR8uW5WKCervKiBQ0ujBsV4nAX5Dnp2MVSjxAZHaQIfeIzPOgag07N4X9f8rUU/nOtc0pQQfMrP7KODwa56g0FVfG3UZ3qv9nX2LtV9/gg01Sv2o3N62g2kGG0Dl3DqPsYY6Nh79ZGvSv6Lh236XlDaBs/aOCxzE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bd5d07-5ed0-4a68-a816-08d758f06f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 02:09:58.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpW/07OxxWdqost+JGswPZk7qhdPJci9mPE1Pfv9jW98BMY8xKc0/IuKUmNFqz+0fvyJydZSsTnaay+ZceHbbPKr4XuJe1MFRDnKIuHZi2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2SPR01MB0025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day from Singapore,

I believe Singaporean Kurt Tay is also a TARGETED INDIVIDUAL.

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

