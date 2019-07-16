Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E9C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3520449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="KlbniZ/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbfGPKn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:43:28 -0400
Received: from mail-eopbgr140129.outbound.protection.outlook.com ([40.107.14.129]:56900
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732081AbfGPKn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJzI5KVM2sKekvtHFBmjlZh6S/C8Fji6yNWHBZrZt/JQ4L8xbNbTaONjkUfft2+klyIJomrdYgS9oeMIMr5Z+a2DSc8uOQp6vW+DKbMUaFPsejpupNJMiPTkCb+UuF6CANZGfceWun9qsu/yIMGknagMP87cQK1szVCEbiUhQoMyOXDCgbLDCD16V5vgF9NmC43/RO7YRJNO6/07mWZc4IhlcsoEV9+oksqDjdKxZtLsny376oU3Oi+tNBbOagz2zluqPCS577Cq7x3c/mX91ZRfyhVHh8xxtr6W5HvlPxBHVF4hG3QbNA7JasRNwwDXzvVK98NkHj7IIk0dRWce0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJWn23Q9cmSdZoNPNTv5fLV7w5UUXTsDCpqPLXxUePs=;
 b=MBIGLeHrbAP5iZlvMvvbV5XxAa8FbofOHGmjZ3XFpPCRJX+MwLybh23DcRwdfrhLv0g3moO3wRyOHqCQI4OSKLMUW6xpgdvPF43R8rP0k2m06L9iTbg/tc68Z2K46++LxNStMnkY4TthFnDH50GTPEf+kzJUagkywjMTIFztECYxb/FJLsHB0lg/902IuvdlccJVLAYUQSiBpkDFNORny7lr6qo27SqTy/1y8Y1AF/yxCZ/BFvRyXLGnoyn8WTcCVRbkeVujDx1JfBZlxejI4d1g6gXCmXw95TW9ej4irW9KbfL3Dul3ZOEbfWObvIpIbkRfA0yPrzSmOHnKyatGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector1-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJWn23Q9cmSdZoNPNTv5fLV7w5UUXTsDCpqPLXxUePs=;
 b=KlbniZ/72rn8iba694FXzQ54ORdPG0zA0NHBFkdUDORQwxa7Xx7s41UdY/FZFpIx3TNdfbLdYz/l335Yy3YBiO7Pydke/rSQFKaog8gFdB8ya/I1hoTK/uzBuUPC5j/C9jTvIb8j45BcacfDD5HZKFAbHRuohJhMXeEekMoOhzc=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.10.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Tue, 16 Jul 2019 10:43:25 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::e15d:fa52:74f0:9e1d]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::e15d:fa52:74f0:9e1d%3]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 10:43:25 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] habanalabs: add comments on INFO IOCTL
Thread-Topic: [PATCH] habanalabs: add comments on INFO IOCTL
Thread-Index: AQHVO7Uut7QnutRiTEep8X2SDeMSeabNDfcQ
Date:   Tue, 16 Jul 2019 10:43:25 +0000
Message-ID: <AM6PR0202MB33826EC6FC45EDD9299165E9B8CE0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190716090218.12379-1-oded.gabbay@gmail.com>
In-Reply-To: <20190716090218.12379-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e27f9e-da1d-4799-101d-08d709da6e54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3383;
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB338383727C2FF577BECC4F1DB8CE0@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39840400004)(396003)(346002)(136003)(189003)(199004)(7736002)(66066001)(486006)(76176011)(25786009)(99286004)(3846002)(6116002)(7696005)(5660300002)(229853002)(33656002)(2501003)(2906002)(186003)(26005)(6636002)(11346002)(446003)(478600001)(102836004)(14454004)(476003)(8936002)(6506007)(316002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(55016002)(558084003)(68736007)(6436002)(53936002)(74316002)(8676002)(110136005)(71190400001)(71200400001)(52536014)(256004)(86362001)(9686003)(305945005)(81166006)(4326008)(81156014)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HAXqcr7KYOzjXmjt4znU4jDeznUf0sbpbtz/vNoz1m3TGhEfwAFtnOxEsBijdGFZSmpAUTfUrJIUOX6SuVGNHAvjG3A3ZmnMA5wvcwkTHWiUrjp7wMR386lpK8MPZeGmNJ0SHKYlENsiUUOGjevD3RdOOW/dVH+xr3YG2HUkT5bdVeKaTwlrGkloCcKdBarwT5dtPsftGyNc45W2+Mov6xTPVOifNFfYvZhoYMGqMY2bzD0M1rY7IQp3u1Mc0i29cbMCTW1NZIWAAxSK0OmwaOhNBL8KM1RVhsNSU7z1uTkoB5feXc63dzEzSIVgivfslxezLjq0ng4M/o+M7OxCVnbbMai3yhqWisi77K9OSsvSbR3PPS4fHm04I8dtXKxpShU2LUlhhZH85WTlv6xJb7UfIG7jc4gykX+FE2vEvX4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e27f9e-da1d-4799-101d-08d709da6e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 10:43:25.3588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oshpigelman@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IFR1ZXNkYXks
IDE2IEp1bHkgMjAxOSAxMjowMg0KDQo+IFRoaXMgcGF0Y2ggYWRkcyBzb21lIGluLWNvZGUgZG9j
dW1lbnRhdGlvbiBvbiB0aGUgZGlmZmVyZW50IG9wY29kZXMgb2YNCj4gdGhlIElORk8gSU9DVEwu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29t
Pg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBpZ2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+
DQo=
