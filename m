Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D89C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1B421881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="ijhdmhrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfIBHqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:46:55 -0400
Received: from mail-eopbgr60107.outbound.protection.outlook.com ([40.107.6.107]:53927
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfIBHqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:46:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mixQH1Q8lHB/g3LTx07a6hOZ5WrVQXRrgGMrlEtMuG6u2zIPMXBDbM+gqywujI0lDJubYuuvCczPUoA3DPkpgUJHJ7fORMBCLQ7e3YOfgBcdOUdVZ43h/4cQdFrJRQSfwK2wFcSe9TUMF/ypbHf5MjA6Kdt+t/4KBDY6jB1VyKxga8Vx1BGv67r2k7tRgCpuHF8SEyGPBGMQ4N5LPMtLhk4jJoG5sHxueoih28Ef4h7em9w1p9twaUiymap682b29c8Tg/L3s5m4mbMfzpN2VSiSvJ05RPdcUkh0HiDWDOE6qJz/MERDF/ZA4VNsnYF2pWjz08JGyJ6z5TGe3JpgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyewEswZtxfYBL4S52hTLruw/iS+Yzqsg8Jfi9BnuTw=;
 b=H8ZkVi/trhmloC60mOgeJRoUCEaFie8q2qGu7V/8Hwu4aRNIfgq46adXsAkktdlhUOOIu9ff2kF9tHoo/tpNuwHZkO0wuSSgcNrEhnbzce93zvsNF6yKrMff4ix+UcBfY/o2gFcNJSEv7cWBNqpZBVSGNgtgyGOiC1F8p29mlHiifOYBiRaLcmeP+s+QQHnpNDTQswizbmBgXlh9Z+MzAe5mBfx5BOGNms2sJO455IvFIXUTShnMZk90Ck/+N5e1EHSjcyAnap3McDfRkbE4LAOVECE3faONc8MX0xwv2o1NgMG+zwUcwELuxdzy6fkFOGah3tEWRpUVUne0WNl7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyewEswZtxfYBL4S52hTLruw/iS+Yzqsg8Jfi9BnuTw=;
 b=ijhdmhrFNWuih9OQcrhRPBTakEmbhof/91D7fxy8T9d93l7S+7GDQlRxSqnG0bUfAXbGoh2d1Qy87BDWBdrIbr4n5iPfpQeNCN4gB3wKCMlPCcncNnUTkJGqqPZkkQpCullnWHcTqyLAw53K1+sQ977YA4KjYFfRUikDPfg7aL8=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3302.eurprd02.prod.outlook.com (52.133.29.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 07:46:51 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 07:46:51 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] habanalabs: add uapi to retrieve device utilization
Thread-Topic: [PATCH 1/2] habanalabs: add uapi to retrieve device utilization
Thread-Index: AQHVXyGo+25m6yEOT0mrC8f1mOA+C6cYBj1A
Date:   Mon, 2 Sep 2019 07:46:51 +0000
Message-ID: <AM6PR0202MB3382B96648CD5FF41C1326C0B8BE0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190830105700.8781-1-oded.gabbay@gmail.com>
In-Reply-To: <20190830105700.8781-1-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44297d76-d8cd-4e33-df16-08d72f79b7b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3302;
x-ms-traffictypediagnostic: AM6PR0202MB3302:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB33028A74B3FA95C7C8CA530EB8BE0@AM6PR0202MB3302.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(346002)(396003)(136003)(366004)(376002)(199004)(189003)(7696005)(8676002)(186003)(110136005)(81166006)(81156014)(71190400001)(66066001)(6506007)(74316002)(71200400001)(26005)(4744005)(53936002)(229853002)(9686003)(256004)(478600001)(86362001)(6246003)(8936002)(33656002)(66556008)(66476007)(486006)(5660300002)(66446008)(64756008)(76116006)(11346002)(4326008)(316002)(476003)(2906002)(7736002)(76176011)(6116002)(6436002)(3846002)(305945005)(55016002)(14454004)(99286004)(6636002)(2501003)(102836004)(446003)(52536014)(66946007)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3302;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: unBfYx74if1r/fwjOgJpu4SzGIdmr+Rg9ewcJB4cAbbKOmdpCjKt/4lN7K2vgQlC9m+g6MbyPho90vEpwdYnG2HVph+1+Lt6Y5mNfIbgqH9ZWwQljL4BxFRS2nPop4tMZtipMZYtHn7zQXiFLekBhdKVwIaw3gCTT7iDGt/5Y5w0u31j6MRVbOVSsTPADzInIUZRs7Vm/fxm/khwV1DTH4k9NXkTmm4dLjygCW/qnZX/o/G4NJcGAwX7thcqxFRkuYdnyGHO45X3KxHidRcnh57xMtPtxI+7cK8QgD4Q9wYnVlbAzxVoXFdOxpeEYRkjbRXK252EPjSBxFQJNmy++Z1lcLQat+qSglXLomCtmPZ6RJjWVQrPD7DRaWYTlUIn/yDhtpcKF1YJP8IwbZbV9sbwJ78c9itg+y1voHR1igA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 44297d76-d8cd-4e33-df16-08d72f79b7b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 07:46:51.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRRgKhWpog6bcbj4LJGKwODqPbo8Cv3RqNNj7+8vsWKFrycpOvcdFS1gfzu8pTRsn70VxgiQjMGhH+U6RCzGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3302
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IEZyaWRheSwg
MzAgQXVndXN0IDIwMTkgMTM6NTcNCg0KPiBVc2VycyBhbmQgc3lzYWRtaW5zIHVzdWFsbHkgd2Fu
dCB0byBrbm93IHdoYXQgaXMgdGhlIGRldmljZSB1dGlsaXphdGlvbiBhcyBhDQo+IGxldmVsIDAg
aW5kaWNhdGlvbiBpZiB0aGV5IGFyZSBlZmZpY2llbnRseSB1c2luZyB0aGUgZGV2aWNlLg0KPiAN
Cj4gQWRkIGEgbmV3IG9wY29kZSB0byB0aGUgSU5GTyBJT0NUTCB0aGF0IHdpbGwgcmV0dXJuIHRo
ZSBkZXZpY2UgdXRpbGl6YXRpb24NCj4gb3ZlciB0aGUgbGFzdCBwZXJpb2Qgb2YgMTAwLTEwMDBt
cy4gVGhlIHJldHVybiB2YWx1ZSBpcyAwLTEwMCwgcmVwcmVzZW50aW5nIGFzDQo+IHBlcmNlbnRh
Z2UgdGhlIHRvdGFsIHV0aWxpemF0aW9uIHJhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVk
IEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBp
Z2VsbWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=
