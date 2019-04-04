Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D48C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B426206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="ZnDljIUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfDDSjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:39:36 -0400
Received: from mail-eopbgr20100.outbound.protection.outlook.com ([40.107.2.100]:58382
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbfDDSjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector2-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/0r/2YnuIdfJp4acCzon8M/JMEWrkP7ah/RAUwO1aM=;
 b=ZnDljIUu8ZWZsj5iLsDeDBAdmTxjlKxITkqnbdapa1JTjrYeK7YJO6jS9/WG76XAV4bfVWfflVa8f6QAGg93LXOnsWSuxrayn//7KGyJfZkVqMr7ub0b2LmtCBax3/1UzMFsSxQVDezcDdm1+8baio8EoQLH6nQ5eLrlK4pPW/4=
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com (20.177.190.218) by
 AM6PR07MB6072.eurprd07.prod.outlook.com (20.178.95.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.6; Thu, 4 Apr 2019 18:39:31 +0000
Received: from AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825]) by AM6PR07MB4821.eurprd07.prod.outlook.com
 ([fe80::4849:4337:439d:6825%4]) with mapi id 15.20.1771.011; Thu, 4 Apr 2019
 18:39:31 +0000
From:   "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
To:     Lawrence Brakmo <brakmo@fb.com>, David Miller <davem@davemloft.net>
CC:     "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        "research@bobbriscoe.net" <research@bobbriscoe.net>,
        "fw@strlen.de" <fw@strlen.de>,
        "borkmann@iogearbox.net" <borkmann@iogearbox.net>,
        "ycheng@google.com" <ycheng@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "agshew@gmail.com" <agshew@gmail.com>,
        "glenn.judd@morganstanley.com" <glenn.judd@morganstanley.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Topic: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Index: AQHU6uFJ5qKL9TJ2LUy0DTa6bmxAT6YsSKWAgAAmjID//+KCMA==
Date:   Thu, 4 Apr 2019 18:39:31 +0000
Message-ID: <AM6PR07MB4821BB64AF86A1A650C95000E0500@AM6PR07MB4821.eurprd07.prod.outlook.com>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
 <20190404.105243.1039649838417325989.davem@davemloft.net>
 <532BB0D8-95C8-4A4D-A73D-3B563909780F@fb.com>
In-Reply-To: <532BB0D8-95C8-4A4D-A73D-3B563909780F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=olivier.tilmans@nokia-bell-labs.com; 
x-originating-ip: [195.16.14.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0244d55-b33e-43ca-5b32-08d6b92ce08f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR07MB6072;
x-ms-traffictypediagnostic: AM6PR07MB6072:
x-microsoft-antispam-prvs: <AM6PR07MB6072A2B11185FABDCFE4632AE0500@AM6PR07MB6072.eurprd07.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(76176011)(478600001)(8676002)(9686003)(106356001)(2906002)(105586002)(97736004)(102836004)(14454004)(99286004)(305945005)(74316002)(6506007)(81166006)(71200400001)(81156014)(256004)(71190400001)(8936002)(7736002)(14444005)(7696005)(86362001)(6246003)(446003)(52536014)(5660300002)(55016002)(33656002)(486006)(68736007)(26005)(25786009)(53936002)(4326008)(6436002)(11346002)(476003)(229853002)(6116002)(316002)(7416002)(3846002)(110136005)(54906003)(186003)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR07MB6072;H:AM6PR07MB4821.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: nokia-bell-labs.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TLrRlRQXTQh/xAxo2Nr8uF4RMJPh657b3NhpedqxDAFbGvvu6ZkN5TmbvwW9xTzgs8kl5VelugWK8GyEyXSL7XkmBxIFb7FgEJ5BWo72DzrRGvjVXKhcc8oiWgdXsLO9Bs8CDObpHzMTPqpCPRVufm+em7e3HcVwx5errJ/S9xghH95AK4+bcmDDk7NcCy6qw3b94glOVlasu0XzGQvOVPXsBlovpfRAii7yc9GlSIIq2wwolHpMgXEAt0TC081282hUziAUgHKVVim5DnOYYFM77IS01D8rfsV4Ma7qZDAhQBUXy55jftKDlbDHZUbN2jAJWWmz3tWaCXSRcYO75uYks7ngdyEGxeVY/7jwBkFHxy+IXpQ2AOdwDIeVQ76OAlaKKma9Po84BuxDvEe/WOAHfr1d2baxfdOCtmGYci4=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0244d55-b33e-43ca-5b32-08d6b92ce08f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 18:39:31.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB6072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+AD4- DCTCP is meant to be used in environments where the switches/routers =
do
+AD4- ECN marking, so it is not surprising that it performs badly when used=
 in
+AD4- environments where it was not meant to be used. Has anyone measured t=
he
+AD4- effect of this changed when DCTCP is used in environments where all t=
he
+AD4- switches/routers do ECN marking? My concern is that we could end up
+AD4- hurting performance when DCTCP is used how it was meant to be used in
+AD4- order to protect incorrect uses of DCTCP.

The results reported are indeed from a non-optimal setting, and mostly to
show that it was ignoring losses. In practice, we only use DCTCP on=20
ECN-enabled AQMs, and rarely see the loss reaction (e.g., a burst of new fl=
ows
IW that congest the ToR switch, in which case I'd argue the behavior is
beneficial). I cannot estimate the impact on FB's workloads though.

I had originally put a module parameter to make this loss reaction behavior
optional, mostly to enable people to check first whether it was safe to use=
=20
with their configuration. In hindsight, I should have waited a bit more
before submitting the v2 with its removal as requested.


Olivier
