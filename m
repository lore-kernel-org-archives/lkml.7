Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E78C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD0C21928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5553547.onmicrosoft.com header.i=@NETORGFT5553547.onmicrosoft.com header.b="G+LOGFql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbfISJCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:02:09 -0400
Received: from mail-eopbgr1380059.outbound.protection.outlook.com ([40.107.138.59]:50778
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387881AbfISJCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXIZtrL7Le5S2HhafkHiwaUjgDIYCRfCQ9uXVeCWO5dyk/qmc/enVFbxFG4cd2P6xXdTYEDQSnw4l15Q1BTWnogdLg79PS6jiCXnnUzW0ayoftr3pBsbSzr+d8uFWNAaUcearNEL47XUjTDh5tKvZ+ghLr+2M4944zAzHx7t3WfgN4/MdgJdkfEzGklO+d7BImrfNkGv/dYnDMe2qxf2LZMHcY8whRJfi4b1F8VwkJ4w1RErHI/xH7SBGMljAlXbSb6qdSV2ZmzBQL9sHxfJLXmJ7Di37VBRTqS5gSuf0Xh9WJPgrBPRgrGHauH575gAMUlXFiRSYUE3jXm39WGvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCxe5DKdnVcIkP6wIrozrO4jQ2ivdKpTuzlsdPohjeI=;
 b=P6TjsnTb5WiygeTXgeYpjUa8tj38r5U8zxHFilNLpHbTHAKf+XUijL+w4K4blbEc9pSX6lAuNpCmRbt0SgXjoAkBF5WiyXE65OHMWuBTpg0XWQuYhKUwc6OzkvV9srNy4b8SA/hGX42RMhNW2gpycacTJ5pV3SDG096oU04C9+Kq7ITgZyjM5/E6D9TGYLRfZDH3ALmwQLcPrnvMyzc6mqYWxzgcN+lB8oPrV7YjZOf8KNkwq7ozz7A81RleB95nCyL5Z3g4FVYCe67mn8lKg/7+9lDPmAorriGbv7r5gxHygL/4rBoYFEcSmBOj4/qFGeW1FzTv06HiW7qtpeAiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=universaledigitaldata.com; dmarc=pass action=none
 header.from=universaledigitaldata.com; dkim=pass
 header.d=universaledigitaldata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5553547.onmicrosoft.com;
 s=selector1-NETORGFT5553547-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCxe5DKdnVcIkP6wIrozrO4jQ2ivdKpTuzlsdPohjeI=;
 b=G+LOGFqlOXC7+0I9tBDYaoehgzehzvMLiIya2rtz9Lhe0ilAU8ebxUF39QPQIyMcYS9gY9fkxxKFigu8xUtJwP0sZUA7BILdgj4SjdkqFxnq1eoygdp+J0nAp4QmOzPbANU1SVTkbkdRQO8cjs8YWX+XhkGfTdZBqrRO8C5HRHk=
Received: from BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM (20.179.243.22) by
 BMXPR01MB3125.INDPRD01.PROD.OUTLOOK.COM (10.255.157.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Thu, 19 Sep 2019 09:02:04 +0000
Received: from BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::10fb:2e40:fa7e:92cc]) by BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::10fb:2e40:fa7e:92cc%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 09:02:04 +0000
From:   Sarah Wilson <sarah.wilson@universaledigitaldata.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Visitors List
Thread-Topic: Visitors List
Thread-Index: AdVuyNJeNaW0oqwFSbiKb5wJBk4Lvw==
Date:   Thu, 19 Sep 2019 09:02:04 +0000
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAB17YbDcQgpNo03dDX/NrcbCgAAAEAAAAO1T89jfxsFPjMtgxnGvtG8BAAAAAA==@universaledigitaldata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::28) To BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:61::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sarah.wilson@universaledigitaldata.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Microsoft Outlook 15.0
x-antivirus: Avast (VPS 190918-4, 09/18/2019), Outbound message
x-antivirus-status: Clean
x-originating-ip: [106.51.18.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f03630b-4ebb-4fd4-a860-08d73ce00a94
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(7168020)(4627221)(201702281549075)(8990200)(7048125)(7027125)(7029214)(7031125)(7023125)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BMXPR01MB3125;
x-ms-traffictypediagnostic: BMXPR01MB3125:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BMXPR01MB3125F4DAB524CE4FB67225D090890@BMXPR01MB3125.INDPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39510400003)(39830400003)(34096005)(136003)(376002)(396003)(189003)(199004)(81156014)(221733001)(36756003)(4744005)(81166006)(8676002)(102836004)(8936002)(26005)(50226002)(498600001)(256004)(99286004)(25786009)(71190400001)(2501003)(71200400001)(3480700005)(52116002)(3846002)(386003)(6116002)(6916009)(61296003)(55236004)(9456002)(9476002)(6306002)(7116003)(6506007)(186003)(476003)(7736002)(6486002)(586005)(38610400001)(44832011)(6512007)(2351001)(66066001)(5660300002)(2906002)(5640700003)(966005)(88246002)(64756008)(66446008)(305945005)(2616005)(486006)(66556008)(6436002)(66476007)(86362001)(14454004)(66946007)(626008)(130950200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BMXPR01MB3125;H:BMXPR01MB3735.INDPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: universaledigitaldata.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FMiliajx6zgNPkhBVQgsDEFQluozm4H3DApL5Yifqyq/3f4vPe4lHOwCmPatSmbNFrBXEaMxVIt6mlx5tYUQPcvaksQDLCQ1o7JMwucSZr7ZyStnLdvs264ksPFg0jzAy0dj9cm0b/rBrnvEaJHQreFfw6dAKasnZow8tbBWV1BWo9HscmMhGk+4ZNqwk7maHPuyJMNsUHdUmA0+03y20hrGh0pxnyz5Isy9jzWh+UALjRjRw7Jc8Wwyfx6K/DyH/2dXMml5i8r66f2IHIn46OTjOkDR63I9N4rWzGrHXsKRH+rhliuhode/xYMXG9iRGbJODVXxoH/x6IX0p54BGF8rZk/9fyAb070S6IyrH+hi41jrXmGTacLuHNpWpJJ35Jj9xBZ+S0lUckWx2gL1Jo15se38kzkFXGOQH1aaiV4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4FD146946431A4A818753F0326D978C@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: universaledigitaldata.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f03630b-4ebb-4fd4-a860-08d73ce00a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 09:02:04.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 136679fb-fa93-4ffb-ae24-fda892c47083
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1acp3GEPJV9AzCJH2L1i98B8ze4iaY2OkEN9AOqtzr9IfE79/uEbA4NM9llQgwO92Jq0/cA1lUEz49dkUzW6381tU0tVsLyZFKt1TeSqn72k1NqaSCspYOYU6KjTZ1oQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BMXPR01MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Good Day to you!

Just wanted to check if you would be interested in acquire Batimat 2019
(International Multi-Specialism Trade Show for the Construction Industry
2019)  attendee companies to increase prospect flow at your booth - Product
launch- Brand awareness - increase Sales - Annual marketing Etc.

Information Provided: - Company name, URL, Contact name, Job title, Phone
number, fax number, physical address, Industry, Company size, Email address=
.

We also provide customized lists for all your multi-channel marketing
planning.=20

Please advice, so I can provide you available counts and cost information
for your approval.

Look forward to your reply.

Best Regards,
Sarah Wilson=20
B2B Marketing & Tradeshow Specialist

If you do not wish to receive the attendees list, please reply as 'Opt-out'=
.


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

