Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C33C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 06:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A37A20740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 06:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="xMg7IMhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfKQG0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 01:26:19 -0500
Received: from mail-eopbgr40125.outbound.protection.outlook.com ([40.107.4.125]:64422
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbfKQG0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 01:26:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+fPSL+U8fttDkdcd0/0LMeq2zvlLK6PfXwu50h5EVROqI9E+aX8zwqGN3NpZVx83TmWlpnFvhZ42LB4eYeUPCNoqiziGblQoB2yCbR/ObRKHPQ/Q+p20vf0A33oWKKw2ab3q6MXYGaKDyKO01CfRZsPZt/Ow0QYTApizq78hn34vz9NVmMfoOd9PvnudiWuwevswsp1krklmohxsqEjX+uBFZqvsFPmhf/S7gqhARBk8PWq5bK5L5WFLDiB3p1IoFYpPvvnPXM4eNWalFigyIOGBg6Yn8MUCyBXHbrT8GARDAl7PhsP6X1I53yFBGRNysZ/cbYrWJyTvVYmE+yw1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni2ALoS0Qionw5l/UJ1SVFpvs26hW5caGsD4s0kPg6s=;
 b=OWW7jIS72Cu/MaKZTuxbzaAqrkppo37AdwEkpY+EAt5DBzODIIjYum918vsXq4XFKs18Hv7A2Ftv6RC08kLCaY0nOsRROP3As1XCWTNXl1aaG5DbSAMm4059uWDPpVNqUgH1q8+Xnvu9xWxG+OyjGh9ExeiF9HMxkDn4SKxay9cpnd6oGJBObzJJEgWylk4YIMMQI34KioDN2Ks5+eY+beUQKC4xLZElKlqqOljaK5lQ2ht+sJCzkSxATLgkuY4W5r8ajQ7U07G5yLVmTQJbkvCHXBs5LkTBH41dlmf0A9AzDeJDrDIyKXZEZion3RMRY+woRotxD7QT13tBenIiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni2ALoS0Qionw5l/UJ1SVFpvs26hW5caGsD4s0kPg6s=;
 b=xMg7IMhp8E/+isyLKkrPu4l0t8R10kTKvCVDvNJaCyx+AMxu4XcW4YYme6lCZLczSdA6kddIfeUth/dOZRpxYROs61ACPOscWYBQ9EgIqSTPBwI6UtUkz1wamyWWDVyOt3nsCEbaNc6R5K4sgo+D/G95ROVDOEOZOO+Mq9Gzkd0=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3320.eurprd02.prod.outlook.com (52.133.10.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sun, 17 Nov 2019 06:26:06 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 06:26:06 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 3/3] habanalabs: make code more concise
Thread-Topic: [PATCH 3/3] habanalabs: make code more concise
Thread-Index: AQHVnGlOIBQKGN7YOk+pLovyNXccvqeO5dHQ
Date:   Sun, 17 Nov 2019 06:26:06 +0000
Message-ID: <AM6PR0202MB3382CAA282CECE60A148CA6AB8720@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191116103329.30171-1-oded.gabbay@gmail.com>
 <20191116103329.30171-3-oded.gabbay@gmail.com>
In-Reply-To: <20191116103329.30171-3-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71461e69-9cf5-4a38-7d4a-08d76b270702
x-ms-traffictypediagnostic: AM6PR0202MB3320:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB3320277DEDB95B58FA6DF90AB8720@AM6PR0202MB3320.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(99286004)(110136005)(316002)(102836004)(6506007)(7736002)(53546011)(74316002)(186003)(26005)(478600001)(86362001)(66066001)(6636002)(76176011)(5660300002)(71200400001)(71190400001)(4326008)(14454004)(2501003)(55016002)(7696005)(8676002)(8936002)(305945005)(6246003)(2906002)(9686003)(81156014)(81166006)(52536014)(66446008)(446003)(33656002)(11346002)(76116006)(6116002)(3846002)(229853002)(558084003)(256004)(486006)(25786009)(64756008)(6436002)(476003)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3320;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MsIB53DMf9SkX/ffkG4T+cRRdZBh4RWBAd0sMyInqmggRi3ZxbQp7Yrju6BGtaX6UGRjbTu3hKuVTqjVsAkV9s+Or7QItrpnXZcNMDLaVSTy3MTNmwo2yJSqmKsG+QvI/nZ/wfTy1CPgcLEoNONzcqS1+mYKBXgg/YbVUu8L5ZIHwICRUBe+nn5qhDpWuapSmxa53S+YmseaSg/Heh5mRJ4bM3e2DpdZmlRkHQj1M30QrinCu55XUnAlA2r651vUR7AMxxXnPdlPduGMQgMRvvcZskRncpgnWP1ZDAXActkGsRMvkVrl2VyoKBh8yanCfWMjia17p0VGcrFiUnlwX/9/UI81Mlxu5bqIzTDfKXpwG+QpmlERjPmoMIVAzx/cswZlwPlYVHwVylJ4QQI+zbtlWqmJji5ryHZx+ZPF0gPN0DQmNC/VrxrZ+kD6gMCL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 71461e69-9cf5-4a38-7d4a-08d76b270702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 06:26:06.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49CXiU1EBMazL6vdxqkSRrfuafOi/M3+tCIUEKtAkbUNduchpAeoKdmWe2YYYqK6BYOtis5zgFYPEthKYRBBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBOb3YgMTYsIDIwMTkgYXQgMTI6MzMgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IElu
c3RlYWQgb2YgZG9pbmcgaWYgaW5zaWRlIGlmLCBqdXN0IHdyaXRlIHRoZW0gd2l0aCAmJiBvcGVy
YXRvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9kZWQgR2FiYmF5IDxvZGVkLmdhYmJheUBnbWFp
bC5jb20+DQoNClRoaXMgcGF0Y2gtc2V0IGlzOg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdlbG1h
biA8b3NocGlnZWxtYW5AaGFiYW5hLmFpPg0K
