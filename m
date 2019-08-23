Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A0EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E11233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="TvtC6AP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfHWIri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:47:38 -0400
Received: from mail-eopbgr20124.outbound.protection.outlook.com ([40.107.2.124]:34310
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732418AbfHWIri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq1+JMt7sXjPTQT/GTtOc+viAVDFHcAFaFi5o09LMypeFdSfQB8loVolBzYzy0Fxx9CGTwcmpjb8XNql9CMfoCHnezoEB6OfaC1gcqWSPly6HqsOk0laEU0orOrO9p+i//INDmW2CZHtuIfqf58X4ZEvbMIOA99KmD5q11WyWRXi8tWw21n8Zf1/7TFMymVE2O2YriXvrRoVnohZZX94llQ2ewS+RVy4bdf+JSloA/k1YvwwYHT59Bab4oZatCj8c2IUQIo4GOyiWl6ZkQKiZAkUDjvd0eHUDWTRpklv9OMyvMw2BuWXVV2CJJiaZ9JwJOogf6n/EPWCwodLtGKLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+XxbCn9n99C2q5/webEDiPCnjhg/SXsjfOw/mOvU6g=;
 b=hva7x5vR6E62Q+u9SvjCu3SkU5H2b/Pi3hdyZ43GkJMxRtYTHpHmmsUnmmbTxPRvMLl3P2Z+UUoa+p1GR5QU0oO6Exej7evHsCavA//ssaZs3xVJK9D2JvI2nBIQ1FIVqPDxEDDJzBOQvmCuMgxVbb5m0BOclmdiU+w/ZDecVzpMbAI9FMTOi+mbd9Q59kc4fIsEULDF26tsjMgUtnXCHTfNipXWdDmwhipBBlxx5/SIEvGy+OUmysWe1rLStI6DP/kpRE7XQyb+S7p8hvPU31KeynoSpKLZZ6ZkQjRd3qaeTx0yzQ7Q5DHrVIdZZ95ONGjId0c0jyJa23Er8MPX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+XxbCn9n99C2q5/webEDiPCnjhg/SXsjfOw/mOvU6g=;
 b=TvtC6AP3t12QiZmcvBIUKcPPAaJAuJPQ6FrhnuYkTeueLNAdDnh03iuCzSWdsiqpO1uRNAfyNmPaBmAPaz4Ifx/rU4hRmayZVWPxLWZqBQk0UYb/KMwmZim3Lv9JYQ6RXXwTNtGd1QfDYZu8EPq5XRgsW69s2+J9XgfRMZ72xjU=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3322.eurprd02.prod.outlook.com (52.134.66.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 08:47:33 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::a0df:d7d9:f95e:f3ea%3]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 08:47:33 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH 0/2] Add possibility to specify the number of displayed logos
Thread-Topic: [PATCH 0/2] Add possibility to specify the number of displayed
 logos
Thread-Index: AQHVWY9nGTFic++gsUyrSu+1jjFGlQ==
Date:   Fri, 23 Aug 2019 08:47:33 +0000
Message-ID: <20190823084725.4271-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0401CA0084.eurprd04.prod.outlook.com
 (2603:10a6:3:19::52) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1e1a3ab-5a7d-4bc0-a679-08d727a689ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:DB3PR0202MB3322;
x-ms-traffictypediagnostic: DB3PR0202MB3322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3322C72BAF832713A7C47369BCA40@DB3PR0202MB3322.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39830400003)(189003)(199004)(2501003)(2351001)(86362001)(66066001)(36756003)(71190400001)(6512007)(71200400001)(2906002)(3846002)(4326008)(14444005)(53936002)(256004)(25786009)(7736002)(26005)(305945005)(6486002)(6916009)(186003)(1076003)(102836004)(6506007)(386003)(6436002)(99286004)(52116002)(8936002)(6116002)(476003)(2616005)(50226002)(486006)(81156014)(81166006)(508600001)(8676002)(14454004)(5660300002)(4744005)(66446008)(66946007)(5640700003)(54906003)(64756008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3322;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2uKnoCyNFGRIV/1gmsD+vTELafSKMJavSdQieOKMPtrFF4IdSdYhn2HNYKy1OoigRX8UtxAfAp4D+QKDmW/cmO8p17gYp8BCKnMhkjIwxdriV8EY6lXr02Hfq4G1R+FiSPcCkGU9TiqWpEFlf9KCBVxwVYxEkpqSQ+wD4bisHpXQZU2CUOSSefG9SueflP0go+FOzHAK9zgKUMr+j5b0u8xUnSwW/KH/SijmDtkrvjDs8pmFVVH1L1SLELjhvdze94WTb170dcYnQvnRGeZnbCBweZNXm4SYcDwoMdtsiovvccuetWnYlham0IUO9tETATcfaSGQw4imtKWt3mdPPi5IS5uJRwlkQaucVULlOU6vkbK/f6gp3SOKPLl5DBXkdQkhGRywB6cWC4tR8BT5iZzUhP1adbUUzevv+P0mrZk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e1a3ab-5a7d-4bc0-a679-08d727a689ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 08:47:33.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuoCl/9/chbh6finhWWf4mcXNYXz4O9hEjYqfXwThMgxcMX6NqHjrQBEr7ydNTnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The first patch fixes the fact that there are two items numbered "4" in
the list of fbcon options. This bug is a teenager...

The second patch extends that list with a new option that allows the
user to display any number of logos (that fits on the screen). I need it
to limit the display to only one logo instead of one for each CPU core.

Cheers,
Peter

Peter Rosin (2):
  fbdev: fix numbering of fbcon options
  fbdev: fbmem: allow overriding the number of bootup logos

 Documentation/fb/fbcon.rst       | 13 +++++++++----
 drivers/video/fbdev/core/fbcon.c |  7 +++++++
 drivers/video/fbdev/core/fbmem.c |  5 ++++-
 include/linux/fb.h               |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

--=20
2.11.0

