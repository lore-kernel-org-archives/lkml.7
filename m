Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F872087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="5OuFZtt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCNHx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:53:59 -0400
Received: from mail-eopbgr1300089.outbound.protection.outlook.com ([40.107.130.89]:30160
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbfCNHx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjkPIyRpxO47YJiDGxE0Y57nvDP18sPirYTwH9P2wco=;
 b=5OuFZtt4nfhLOUVXIt7lyZNBCMNKcj5CKGt4tOz5tE+xVj/tk6OtvK43x/v/pPWzTebgYrJRx9FHGV0642MNeML4Z7tehiV+JFJEcAsFwAC+4779KS5zYZQnaX6IVlGnKf0IY/v5ZELGYwsOIM8hgQ4uHqA2ks+mTUzkI/wQtgM=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3847.apcprd02.prod.outlook.com (20.178.134.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 07:53:54 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3%4]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 07:53:54 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>
Subject: vmscan: Reclaim unevictable pages
Thread-Topic: vmscan: Reclaim unevictable pages
Thread-Index: AQHU2jnLyCfGly2dbEuVu40O8aA4saYKwYIO
Date:   Thu, 14 Mar 2019 07:53:53 +0000
Message-ID: <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 552fcc4e-74a7-4dff-ebd5-08d6a852347a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB3847;
x-ms-traffictypediagnostic: SG2PR02MB3847:|SG2PR02MB3847:
x-microsoft-antispam-prvs: <SG2PR02MB38474F7B6E7E53483A1535C9E84B0@SG2PR02MB3847.apcprd02.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(396003)(366004)(376002)(136003)(189003)(199004)(476003)(81156014)(305945005)(105586002)(5660300002)(44832011)(71190400001)(93156006)(71200400001)(7736002)(66066001)(316002)(6916009)(5024004)(2501003)(8676002)(52536014)(74316002)(4326008)(25786009)(186003)(2940100002)(33656002)(81166006)(14444005)(11346002)(256004)(5640700003)(6116002)(76176011)(478600001)(446003)(86362001)(68736007)(99286004)(6436002)(3846002)(486006)(55236004)(53936002)(6506007)(102836004)(8936002)(66574012)(26005)(97736004)(9686003)(55016002)(2351001)(106356001)(14454004)(7696005)(2906002)(78486014);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3847;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jlMeBtb54R/pbjRpM7/QdACDk0dNCE7dQDDqTuRd+L9MXiYzLDtNifUprctvk+qLDqzMckSrxrjTB/XA97RBAYYDqwiiG1uWfx7qfRvrMdJj5giz+bOlDz4rtOEytONirY2hiQPi0X8OK3yd5l8GjLy7IpeLPAo5dbR8MuTwg7DUg8w+G/cjQBX++LYvm9ZxhGtOhMri9o265uHZ9OsFWTjo0HZUTRfLl0ETapFXGr42LBN/mZBYvKmkVYzSLmIi7wdNulkwDqTwwDpC4TEHdJzYpbMaRvafeoclOWzPjdA4m4BoXRHp2/13Magb362MBdqhYay+r1eKhg1JznMTG66AK9fYFHhkPoYL/b9g8b3QWllClxko2NMYEyPljeK4ktSNt0wGWfqoIt151ZTGWvjq9sXwWypsSz9Al7iTAfw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552fcc4e-74a7-4dff-ebd5-08d6a852347a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 07:53:53.9218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello ,

shrink_page_list() returns , number of pages reclaimed, when pages is unevi=
ctable it returns VM_BUG_ON_PAGE(PageLRU(page) || PageUnevicatble(page),pag=
e);

We can add the unevictable pages in reclaim list in shrink_page_list(), ret=
urn total number of reclaim pages including unevictable pages, let the call=
er handle unevictable pages.

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
