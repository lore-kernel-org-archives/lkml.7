Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8081C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C3B2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="sUn2kc9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfIBIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:39:59 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com ([40.107.3.125]:23976
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729606AbfIBIj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:39:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEKtDo27ruBcFIaUnSEPfQRRPVNwL79NdhtgmXuNIZ+dOuA2UMyw2twWj8uCtb30N6sh4rHXBXF2RVYWEcEDg6CrFSiZfro7eUhQVx/vskwCPOy8WaNhElpTaqxIqOlIgV/35JozC0+xxmsy2L2rKz7srqEIlrKixElnjwzBHd4eudyXiA8QFxr3QvgBBSyogrJQH0yFMzsk6KIscoxnEmecCmbC7m6/0nn4fCoJ1XHHg6vGKg4XJdtnyBDgp6VCzj4ptO0knj573rcmOfdo2jmDNqXqPLnZmLUhnUCsmDBX2EnZ9oPsX5BIzF4hxkVnxmqzktgBywtZ5jBmwKTCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q30Gsxa8+t3FtsREPTDYXCswjl66vNTW1BRcQN+GH0=;
 b=F0y0M/6PQ0guWceJJgMPONvr53ff8thJ6s1GH4sM5NzCG4OetofNSCgysFra8syTp+zdKy2zMLfRlGeMTr5MjkpfeUou5xpcdPS1gIbGtURAnHEdH6YUHuXHRtvei81NtuClFoeycYMx07S6sjZE6qaZbjVGijjSL0m8vIeA/EhQKpzEWea4uDK3JDmxo+yqFcu7/aCYCaLF1JhGcQLe4GsMnY31cpz2hOup8KzGJahTnRkrWbQ+kw/IOUi1ua66ztWjJUT7zM2zD6E6FZP9hrS/YMB2332a6z9FpzJOqARaomOqP5kqqhJ7JadVqb9JQxAX51AzM56kjmL7bUiXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q30Gsxa8+t3FtsREPTDYXCswjl66vNTW1BRcQN+GH0=;
 b=sUn2kc9LR+oZtvgoBrwdXj+G4Kdfp/npJ+YDalzUJ3Q/eGbYXYtz5Jn1z3pkXJ7MnXn8hfm4VzdRPi1LWIztwCwC7ksu9buUB2msLhJsFDikjOBOQmcSUc54CGn6gUefnUxN8Kr+z2yrynHzGg0QvS4/8w39aRg1q2T3TebPskQ=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3287.eurprd02.prod.outlook.com (52.133.30.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 08:39:55 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 08:39:55 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] habanalabs: stop using the acronym KMD
Thread-Topic: [PATCH 1/2] habanalabs: stop using the acronym KMD
Thread-Index: AQHVYWMXDoCFAMv1rUGzIkpoa3Z506cYEPqA
Date:   Mon, 2 Sep 2019 08:39:55 +0000
Message-ID: <AM6PR0202MB3382ED0E168DBC4A0D3AB86BB8BE0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190902075024.27302-1-oded.gabbay@gmail.com>
In-Reply-To: <20190902075024.27302-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64420a00-1a77-45f4-f7c3-08d72f81215b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3287;
x-ms-traffictypediagnostic: AM6PR0202MB3287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB328727F2D9AF04681CC0EAE9B8BE0@AM6PR0202MB3287.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(81156014)(4744005)(81166006)(52536014)(476003)(305945005)(7696005)(74316002)(66446008)(9686003)(6246003)(11346002)(5660300002)(26005)(2501003)(66066001)(86362001)(66946007)(64756008)(256004)(66476007)(7736002)(66556008)(2906002)(6436002)(14454004)(316002)(3846002)(8676002)(76176011)(446003)(102836004)(8936002)(110136005)(4326008)(55016002)(71190400001)(71200400001)(486006)(53936002)(186003)(25786009)(478600001)(6116002)(6506007)(33656002)(6636002)(99286004)(76116006)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3287;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xRZyix7P/+L8MukJcJUN2tGfJqM3mDKQjm/3zMM4UJi5sr+PeIm5ApZBq5pC4WYeT3TY4nAq1Y54dMEKIccA1+V8Hp5gn5lYrfTAs2XxrtMScAFrV73iwp33nJfXs0dOYWNkayAKHePaafN0yNCiylxxlSfuS+3RxOc0yZ8obuxMOSfp1n7Iq37FNBU75PS8JHIV1hRGULAHROB4uP4OqxgKIX4NS5J9ytaTmwTDLgyezsf81HKS4ORa4zp+fVQxjqqiYoKJLgALfkUQZgbpKIojEQLL2iLuTV1pSfz3fw2Tk8seXZF6R2URWD+TzSl6Ik+FEKT/zNKdPciXCDmSmhM6mo6OV0+QJeoXjKf8by8tWdddcf2fbgPlft2a9sUfMm+HfsMmcTkJ6jTqqrH1QY7xlwQi23UqFeoDc2YyKEw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 64420a00-1a77-45f4-f7c3-08d72f81215b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 08:39:55.2317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNerA7dqOwutqG47Ry8oSRVpwbWWvR+txvrl9X7b1Cx3Fwo//ISUBW0mMuJ+7eakT+j29JAbcalrG73+qMOkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IE1vbmRheSwg
MiBTZXB0ZW1iZXIgMjAxOSAxMDo1MA0KDQo+IFdlIHdhbnQgdG8gc3RvcCB1c2luZyB0aGUgYWNy
b255bSBLTUQuIFRoZXJlZm9yZSwgcmVwbGFjZSBhbGwgbG9jYXRpb25zDQo+IChleGNlcHQgZm9y
IHJlZ2lzdGVyIG5hbWVzIHdlIGNhbid0IG1vZGlmeSkgd2hlcmUgS01EIGlzIHdyaXR0ZW4gdG8g
b3RoZXINCj4gdGVybXMgc3VjaCBhcyAiTGludXgga2VybmVsIGRyaXZlciIgb3IgIkhvc3Qga2Vy
bmVsIGRyaXZlciIsIGV0Yy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVk
LmdhYmJheUBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBPbWVyIFNocGlnZWxtYW4gPG9zaHBp
Z2VsbWFuQGhhYmFuYS5haT4NCg==
