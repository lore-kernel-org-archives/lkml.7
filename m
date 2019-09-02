Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E05C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2732173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="S3AmGZsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfIBHsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:48:54 -0400
Received: from mail-eopbgr20092.outbound.protection.outlook.com ([40.107.2.92]:53220
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729848AbfIBHsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:48:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9862cF/0jFzWGsezmKVfgrWtS3VJTzrNTCvyltesjVVxdB9khwT2tytdXucvtOTPKD0phyr2RJCkFEAOuCh9gQPteNApf837wsTFhqxnClXP1gLrMGQRQwadZjhO8AkTmigyoZvvb9SXhbcPluZGOXnyyrwoaPxzgH4+8pLJHt/aIj9+rJ9Lboi9uhi9D94qzo2kg8yynfpDI0M4auIrT0Fa1iev7NovSCMYIgW8Lo3W+qFq7iXfRTYEMIiwBC/aXUdNBi2m9nWqDyK1U48gsrG6jN+YKa7uU5GoZ6toSQTNXxuOM+bWKhRWYWlsV88+AukSb7cLP7Ls9ZXl3k13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFBJt73bnmgshswodxP6mBYI9YRb4t2rssujUkua68Y=;
 b=ls+9ec3ttax+qE6dhUKHoa9qX8154fft8NIcpYbzk4hR7wJOVLAKhswm/qf3ijvxOnMfUPwn/s7FUOcnDvQ1QXrM44G7szDlARgNS0PhQ3XMaAxW2wF+gCAPwBUq/uvDmHN2NQzHgVJMAN7YfNlIVWtxdLlW7Eap9Yg3yluZhL7RhJj2sacrSjq+LBKbwV3utRDYywORw4eRPWgyqnIi0+yGsXTXGuLxo6Bqwhrpf9ynHqqny18uNWbuFonyizX6pSi/+cxYO7CpZoTeAk2D2jk7GD/H+0AhZ5NwlPacHwr7mif3jr+RuoT6VN4/EYX1XK3Ft38QNdlzWxqWnxq9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFBJt73bnmgshswodxP6mBYI9YRb4t2rssujUkua68Y=;
 b=S3AmGZsbOpG46zxbJngWzWgzSgDH1KXhSHaHRkko4Z2s5M7ukrPaYN1TLzFpPThLIGxPGOWg7pZkZ2xKvXWE/GoZ/RgWZwSXAnfi6wUAQDAOmoifpvO5Ze1tI9GMPGkak5S04bZ0vihKwz0gkNIpo673J5YJkYIOewwG/ZT4oag=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3271.eurprd02.prod.outlook.com (52.133.28.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 07:48:51 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 07:48:51 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: display card name as sensors header
Thread-Topic: [PATCH] habanalabs: display card name as sensors header
Thread-Index: AQHVXzeeiuhQ4WoA2kunIVVmZrcdcKcYBxyg
Date:   Mon, 2 Sep 2019 07:48:51 +0000
Message-ID: <AM6PR0202MB338244BF2DA960861CDE36A0B8BE0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190830133411.24697-1-oded.gabbay@gmail.com>
In-Reply-To: <20190830133411.24697-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bef7b7b-5e1d-4cf6-2f77-08d72f79ff0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3271;
x-ms-traffictypediagnostic: AM6PR0202MB3271:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB32718DEE77D93F0BEC4E165AB8BE0@AM6PR0202MB3271.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39840400004)(366004)(396003)(376002)(199004)(189003)(6436002)(6506007)(76176011)(8676002)(81156014)(81166006)(14454004)(99286004)(186003)(110136005)(9686003)(25786009)(316002)(4744005)(33656002)(55016002)(52536014)(7696005)(11346002)(446003)(6246003)(53936002)(102836004)(4326008)(478600001)(26005)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(2501003)(86362001)(3846002)(6116002)(2906002)(66066001)(476003)(486006)(74316002)(7736002)(305945005)(5660300002)(256004)(229853002)(71200400001)(71190400001)(8936002)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3271;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2On9jUZOdSDIUzEy9mPGYqztenxHtGEQTRSig7MZvf9phcXgO2k/BoPSJ2tLDvpbZH4gpfcxuxxLKnUbeaZT5vftedRh80OXBqJtohSeB5fUvu1SPRMXzmRjxY8PmRReurb3wxCyDql7KhFCzng7qrhf67Y5OieCECypbEy3AGNtOWkzmERz27w/o848O/GFWjUk1LDrRC//uzlsuyU2RE96bmd98JWnbo3x01E0YVeepB1HhC/7HC9SegIIHeHVkQsunsnecSscHqTWfSk2tofkModzLoBcaCdSttGPMEdMhpKgFuU6upUC9Y2MXefM8ezwevXY79l3RxDekQfPqBXT0OBVyUei947am7xktbRxYrTmCARsoKidfbMJa9jCHyhzrTNNBRkbjcDYhjLtr2ACf4nIn6uD91roytkc2ik=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bef7b7b-5e1d-4cf6-2f77-08d72f79ff0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 07:48:51.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: um6EMxuK921/lbgosh2GwDoqwKncr8UHEmEETd04zBwKghS3+LuolWRvsAE2wR6S6YJYQ4RJglqQeaKU9Q3BQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IEZyaWRheSwg
MzAgQXVndXN0IDIwMTkgMTY6MzQNCg0KPiBUbyBhbGxvdyB0aGUgdXNlciB0byB1c2UgYSBjdXN0
b20gZmlsZSBmb3IgdGhlIEhXTU9OIGxtLXNlbnNvcnMgbGlicmFyeSBwZXINCj4gY2FyZCB0eXBl
LCB0aGUgZHJpdmVyIG5lZWRzIHRvIHJlZ2lzdGVyIHRoZSBIV01PTiBzZW5zb3JzIHdpdGggdGhl
IHNwZWNpZmljDQo+IGNhcmQgdHlwZSBuYW1lLg0KPiANCj4gVGhlIGNhcmQgbmFtZSBpcyBzdXBw
bGllZCBieSB0aGUgRi9XIHJ1bm5pbmcgb24gdGhlIGRldmljZS4gSWYgdGhlIEYvVyBpcyBvbGQN
Cj4gYW5kIGRvZXNuJ3Qgc3VwcGx5IGEgY2FyZCBuYW1lLCBhIGRlZmF1bHQgY2FyZCBuYW1lIGlz
IGRpc3BsYXllZCBhcyB0aGUNCj4gc2Vuc29ycyBncm91cCBuYW1lLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IE9tZXIgU2hwaWdlbG1hbiA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
