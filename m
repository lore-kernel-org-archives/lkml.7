Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF4FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F234B20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="fu257IWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfDAH41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:56:27 -0400
Received: from mail-eopbgr1310049.outbound.protection.outlook.com ([40.107.131.49]:17572
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731944AbfDAH41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYzMQyAhasE0Q2EE9k+wuIbZo9QNt5Qwmj9eKemqg2Q=;
 b=fu257IWzaYjElFdZWx14YVvZCid8fR0BT0r50IOozhVKYWTEBBwwif2jgZL+3xbP6sly7BGutJL29dHbUavnCCO1PijxOCXKjmnAl8Bmn87lS+dF4gd6awyFBT2zH+NlptSefDDbhnzaZhAYX/1t25iiZ8trBHixx+8RzBXMkwQ=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3800.apcprd02.prod.outlook.com (20.177.170.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 07:56:21 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 07:56:21 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: CMA area pages information
Thread-Topic: CMA area pages information
Thread-Index: AQHU6GA9RylraT4uwk+04/PdjD+qFg==
Date:   Mon, 1 Apr 2019 07:56:21 +0000
Message-ID: <SG2PR02MB30986806577CDA3F568553B6E8550@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 577af18c-ac62-4bb6-b688-08d6b67787b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB3800;
x-ms-traffictypediagnostic: SG2PR02MB3800:
x-microsoft-antispam-prvs: <SG2PR02MB3800A83B5C0237FE40076143E8550@SG2PR02MB3800.apcprd02.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39840400004)(376002)(189003)(199004)(25786009)(3480700005)(478600001)(14454004)(486006)(81156014)(81166006)(5660300002)(86362001)(8676002)(186003)(7736002)(6116002)(52536014)(66066001)(74316002)(33656002)(2906002)(6436002)(106356001)(55016002)(9686003)(476003)(55236004)(102836004)(68736007)(26005)(53936002)(3846002)(110136005)(7696005)(6506007)(8936002)(316002)(2501003)(305945005)(97736004)(105586002)(71190400001)(99286004)(71200400001)(256004)(14444005)(5024004)(44832011)(66574012)(78486014);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3800;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: apC02R6Y7AZkWJ+7rOENAjEqxNb041Yq7vW7Nyw9ihtrVE0DGBk/rGQjYToFai8iPPvp4Yv1Wx+8z4ux0d9WsYsq48YuaathoS0ZlMBTdUsscDaQTkBKdn/IMfE4FQIMUITTgPXFdrne5bfeIvguH/oKv8oR/vgtibdJg6FGQFOyjb6CEs1rgdT60p66clTFnZMRXY2HFzU8qz2JyRkcRFvmQsY1F58XjR509rIRkNh1N//+RbZbfjKDv5Lm7R40cS6cGR3iB5T81BzF56Jf3MvltTNGA+sscQxj4BX3sGW6wR6jm1DOlalMB8F78BWNzSazAD2XkMrHzyhtomXHFxlDW4nuziOWqBb9D5jyFtutA2wROjkZjL0AVElWQz3nj63zQcNcT6P20eDioTEBgrnKFMRYXaR2//AmpAqpkXw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 577af18c-ac62-4bb6-b688-08d6b67787b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 07:56:21.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there any way to get CMA area pages information (tool/application) ?

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
