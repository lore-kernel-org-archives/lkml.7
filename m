Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3529DC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0259F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="pSuIzhiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDCOVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:21:02 -0400
Received: from mail-eopbgr1300078.outbound.protection.outlook.com ([40.107.130.78]:16807
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbfDCOVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCY4n+634QN8idCFBL5iZU2uBgOMbKGR8cnYVsDTH5o=;
 b=pSuIzhiEn5+vI5n+qGRXGqHdJ8SkMPUdPpItjNEdT4zMJUscmzVONncOe3oOk61N7K0EoInkSabiz1tAbB80mXKtdlBlUF7MSfMZVT6gSffEPW0p6wKuJZlICO56nWx3Z2AIQlgBb+odqkPkYsVAprAFBhsNoGCtY5jv+mHJB/E=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3417.apcprd02.prod.outlook.com (20.177.84.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Wed, 3 Apr 2019 14:20:57 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 14:20:57 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How to calculate instruction executed for function
Thread-Topic: How to calculate instruction executed for function
Thread-Index: AQHU6igi0LAQURcEFkafVLmNd6QLnw==
Date:   Wed, 3 Apr 2019 14:20:56 +0000
Message-ID: <SG2PR02MB3098EF270AE08CB19E96C5C4E8570@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7eae1c02-83f5-4a98-0731-08d6b83f96c9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SG2PR02MB3417;
x-ms-traffictypediagnostic: SG2PR02MB3417:
x-microsoft-antispam-prvs: <SG2PR02MB3417D5DF95A689D10124AA3BE8570@SG2PR02MB3417.apcprd02.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(346002)(376002)(136003)(199004)(189003)(74316002)(2906002)(97736004)(66066001)(6506007)(78486014)(55236004)(14444005)(68736007)(33656002)(102836004)(3846002)(6116002)(6436002)(71200400001)(5024004)(66574012)(478600001)(71190400001)(256004)(25786009)(105586002)(106356001)(9686003)(7696005)(53936002)(476003)(14454004)(486006)(86362001)(316002)(186003)(2501003)(99286004)(5660300002)(8676002)(55016002)(81166006)(7736002)(81156014)(110136005)(52536014)(305945005)(44832011)(8936002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3417;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z4LmI8dq9T2xKqNft2Val+QuaCUq5qsIpPpr6gjF76UQyqS1Vc8+0yyW+te4OSD4Z2canVuR+kIaZ8Iq0WE79sqTduBaxUFOtbS8KoWlUCfqTtch4e+Vk76ytMjS4c9FhhJTgxntWwBxnsX5LHaK0eej2o9R540I2Wsi3LRfeh9Nfhxvet0nrm4n8PLi0LdzXWbVEpbX7xVJXpxBWNKDHGLxCITkESt55ZMB+PmoXHfsgoEm9j380l5gBVLKS/8QMJQcIq3TdOH4Ayk6L0tZ7WP3QKhJ06uCHHacg37hS5yoo2AGHCgD5ynVW7oi2egDcgucsHsw9XapfcoDuBe9X1KSWxVjlGl2ctgmUKibjsvPKEXcrFeZ1N1vch5jXX7hnw5sh5unK26mI140N7qJYQXyx3AR/igezMQwGZeExjo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eae1c02-83f5-4a98-0731-08d6b83f96c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 14:20:56.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

How to calculate instruction executed for function ?

For eg.

I need to calculate instruction executed for CMA_ALLOC function.
How many instruction executed for cma_alloc ?

Any help would be appreciated.

Regards,
Pankaj
***************************************************************************=
***************************************************************************=
******* eInfochips Business Disclaimer: This e-mail message and all attachm=
ents transmitted with it are intended solely for the use of the addressee a=
nd may contain legally privileged and confidential information. If the read=
er of this message is not the intended recipient, or an employee or agent r=
esponsible for delivering this message to the intended recipient, you are h=
ereby notified that any dissemination, distribution, copying, or other use =
of this message or its attachments is strictly prohibited. If you have rece=
ived this message in error, please notify the sender immediately by replyin=
g to this message and please delete it from your computer. Any views expres=
sed in this message are those of the individual sender unless otherwise sta=
ted. Company has taken enough precautions to prevent the spread of viruses.=
 However the company accepts no liability for any damage caused by any viru=
s transmitted by this email. **********************************************=
***************************************************************************=
************************************
