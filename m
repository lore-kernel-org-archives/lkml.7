Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B59C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFE421849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="CVDT/n6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfGRQtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:49:50 -0400
Received: from mail-eopbgr1320085.outbound.protection.outlook.com ([40.107.132.85]:43552
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbfGRQtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaJoO6lbohYnIK+cb9XrNWRkoVkpPL8Y99CFYZgooNATi5NCpKT/kCWWMVHm+BJifMFfJb3DEbgmpluzaOusblOgHVe3tnqGLBXEZjr/dqNxnf8V8kniTFZeviDxr1NaKSj2wkXegCrwV3fYxV21izMLiR3ecpDRgXyiJKrYjncqywyaPSJpeT9sgH1mSv8UHoNnzgPZFDKsNBStgRKt/rwNNOI2lY0dkn/cCQ8D4fc0/H9gAgDfcJQb92OBdyCJvHoxFTc3hHTpthRhkOWu4JabqfF4o7fG3a9rI9pnapsUcoMDbi4zmgO2LjyyRFYYtw9U8ITFe1b/fUXbTR5ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0Ek1iiQSzeMWassq9ur8uP3fosIVYK6C3Jti5j1G1o=;
 b=StW28T5lNx9le7X+FV3aSSxPNIBcxAGhU748sAWuFoxWqIoed7i59svNM2dv3A1ciYZAFK3IfuSaocpLTcc9iWnqc5QZAlGMMW7gRBLK3eeMWvExa2bCwKJk/+auVRVArcREt27Lx7u0u+uMabsIYRi3j+Ro3QsK/tQBgcWkD8dwX9+GEzNX3ZDsMV9neCHwHrmaZZJnHyMsVHRmGFdQPiAkPsiSCFhcs7FfRNXbIJ6Fqsm1TR/nMnDSubHqETv0EqziGmunUWkShnZLKQClvbLE81SJQERLwJ+HeZrFFLFA5Y10eon+QdjUrZV50eKTzhGDPEsUzpmuBiaXaLWjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=teo-en-ming-corp.com;dmarc=pass action=none
 header.from=teo-en-ming-corp.com;dkim=pass
 header.d=teo-en-ming-corp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0Ek1iiQSzeMWassq9ur8uP3fosIVYK6C3Jti5j1G1o=;
 b=CVDT/n6uUIQPM0FenV1jXeQAmjCpWruD+nOiehvaOYjaFjUJCRUqMvwBuMSVtC63gX4PlgrIl1lKUGIGQyqb5zHbzpGX7QpNIAmCtKOVdNgnTq7XuiXNBCA7AatdU49eKiR78oDqbzLLEN2gOmQpY5oG+zwpx26UJ6Z9KWQelsU=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2203.apcprd01.prod.exchangelabs.com (20.177.81.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.12; Thu, 18 Jul 2019 16:49:46 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::d503:3d71:ce06:19d2]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::d503:3d71:ce06:19d2%6]) with mapi id 15.20.2073.015; Thu, 18 Jul 2019
 16:49:46 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Is Linux Kernel 5.2.1 able to support Intel Core i9-9980XE Extreme
 Edition or AMD Ryzen 9 3950X?
Thread-Topic: Is Linux Kernel 5.2.1 able to support Intel Core i9-9980XE
 Extreme Edition or AMD Ryzen 9 3950X?
Thread-Index: AdU9iIp2ElCkcG8oSfqo9T4X4vTz/Q==
Date:   Thu, 18 Jul 2019 16:49:46 +0000
Message-ID: <SG2PR01MB2141849E366930977335B8FD87C80@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e105fcb1-f0ea-439d-bd55-08d70b9ff100
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB2203;
x-ms-traffictypediagnostic: SG2PR01MB2203:
x-ms-exchange-purlcount: 6
x-microsoft-antispam-prvs: <SG2PR01MB220321C779FF7268D7F3D30987C80@SG2PR01MB2203.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(366004)(39830400003)(189003)(199004)(81166006)(81156014)(66066001)(7696005)(5660300002)(25786009)(71200400001)(486006)(71190400001)(2501003)(66476007)(966005)(64756008)(66946007)(66556008)(508600001)(66446008)(6506007)(2351001)(6916009)(86362001)(76116006)(99286004)(14454004)(256004)(52536014)(476003)(4326008)(55016002)(186003)(2906002)(9686003)(6306002)(7736002)(316002)(74316002)(8936002)(33656002)(305945005)(6116002)(3846002)(5640700003)(26005)(6436002)(102836004)(8676002)(107886003)(68736007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2203;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VVXD0t2xLHR7TsJIPQF5TX5NKedATIP1skiEsY21ZB9QeAP8lGUjmfDS0KlEESxAHgqOtj9BMfv/Y2YFYa3NCTxdwdDfDGdeQiZfMzRqgHqilcKHDZ1U6BD4JZEDfWvF5VMa2AypvIsnov/SHE1I3d8b6VO02JvN+tkeJ9tsm9xX5cJAaIDeHYtZTdWJHo7AMzzA+EtsG5p7aTXAfIYR5QTqdsk1cM2nERWbPOcZGdEu+WxxZviwW9gDpeAHfAVJk+A18qsyzMQVHm2JPq8TXWBKZaTMfwL/2yAL8W+OQhbTZxRdEu+N0/uGM7J8HZYnlAkKagItjvOWsSbitL3Ex0njUqJBaWmxqMqbJAc+9wlkVdYjU+atPecqo9rUV4cJpqnekMTfK6TwIBsNoHSf6KhFgbxi9s0IXnR4+XfvPTI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e105fcb1-f0ea-439d-bd55-08d70b9ff100
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 16:49:46.6098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning from Singapore,

Is Linux Kernel 5.2.1 able to support Intel Core i9-9980XE Extreme Edition =
or AMD Ryzen 9 3950X?

Intel Core i9-9980XE Extreme Edition has 18 cores and 36 threads while AMD =
Ryzen 9 3950X has 16 cores and 32 threads.

Intel Core i9-9980XE Extreme Edition technical specifications:

https://ark.intel.com/content/www/us/en/ark/products/189126/intel-core-i9-9=
980xe-extreme-edition-processor-24-75m-cache-up-to-4-50-ghz.html

AMD Ryzen 9 3950X technical specifications:

https://www.amd.com/en/products/cpu/amd-ryzen-9-3950x

What I am trying to ask is, is Linux Kernel 5.2.1 able to support and make =
full use of so many CPU cores and so many threads?

Thank you very much.


-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

