Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D525C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBA020679
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 06:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="smLO6F74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKKGJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 01:09:01 -0500
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:35398
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbfKKGJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 01:09:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLW+WcOyT2oqf3b0jPeRTs04sq3l07Z+iHPkLUHt1GcAhMjfZM2pa62eUAlKKsL3j3cIvGwA9Zc2YvzEQN1omS0lnAimYKdO2ru2dgy76cSvxCfNSv+jkoIQhOTFkitF7fID58Zjpe9Z8r+JYxAOW3LdiyfkAXmxMU4TP9hu9NXCrQ2qhzGnbXjlERMniYUmoCraqWfCrClzPCpRptEQp7kshL8JUP9qTfh2OsSKUECqqsvhxCjGWIwR1D/M5vCaSMvvtHvWwlfaKCHClrQXtjruQCRW98hoMsNZdw6BxzobB+s3N71lJI/ag0lUmz2XDIxxIg4YB8BAC6E/vedkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26VtnHa4gLGbH0UB99cFRlwK3vGzGRNd1x2EARCZOFI=;
 b=eKcDFET/D61JyIE95nkxNfzYmTKq1usnO+HdgybBd2Q+IR2D393AUGpOdCG1abjHTreIAcC0lFLYp3RgrMof91f4XDbPfVNG93uJPCOCg/MunTTlHFnuBEAsztCRbWwWmrHiUucftULCnwRcL1sPhw8WAsJIGHYxtwMyhYo5BU0GqpBoN52e811yPJHbBlX8DCio2yD7Isgmjf+ppKP4pfgbEbvMExxqq3AqySIoufV1nKV3S6S4ldEKWHKmY2APBTMUmLHJP8Pg8/NJ9902u/aac51iw86LP4hEG7bnuCYPGH4Pl+c3dbrTPKpZxCVb/YOaJ3qNsqyupxgGIXzdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26VtnHa4gLGbH0UB99cFRlwK3vGzGRNd1x2EARCZOFI=;
 b=smLO6F74FvV6ZLcmLY7vZSNRcUbh4Qh6e3einsbYZqFmCRLWdd7BoTfN4kYx1arFoRsOeI/ekmBKbWZeWr/OAbAz9q9EvmTyWf0ac34UGUoXeJ7NG9xbQAJJn9z/U74IVxeropRqprwzFzZATRKKsWfb9hqgp5+W6AQB/FOISk0=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3463.eurprd02.prod.outlook.com (52.133.10.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Mon, 11 Nov 2019 06:08:57 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 06:08:57 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 6/6] habanalabs: export uapi defines to user-space
Thread-Topic: [PATCH 6/6] habanalabs: export uapi defines to user-space
Thread-Index: AQHVmBGZpXnyHMKtm0GcexnX0cHqiqeFfOfg
Date:   Mon, 11 Nov 2019 06:08:56 +0000
Message-ID: <AM6PR0202MB3382D7E3F87BEA6A42632E92B8740@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191110215533.754-1-oded.gabbay@gmail.com>
 <20191110215533.754-6-oded.gabbay@gmail.com>
In-Reply-To: <20191110215533.754-6-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [141.226.8.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f361be-820f-4d7a-e305-08d7666da328
x-ms-traffictypediagnostic: AM6PR0202MB3463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB3463D3AF43633FB45DC46967B8740@AM6PR0202MB3463.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39840400004)(346002)(189003)(199004)(66066001)(229853002)(558084003)(9686003)(55016002)(6436002)(76176011)(7696005)(102836004)(6506007)(2906002)(86362001)(71190400001)(71200400001)(3846002)(6116002)(486006)(11346002)(446003)(256004)(476003)(6246003)(186003)(26005)(66446008)(64756008)(66556008)(66476007)(4326008)(25786009)(53546011)(76116006)(81156014)(2501003)(8936002)(99286004)(74316002)(7736002)(305945005)(8676002)(81166006)(14454004)(5660300002)(110136005)(52536014)(6636002)(478600001)(33656002)(316002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3463;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sFvmSn26N5DXrASsgTP+O6ExzXhDsicoT6H0Cq5davwWrIqbfYpAXlEmLynRGBKKcLTMSf3oxgcnAFytoSTA4mmCkMowqs5V4ldieNR0F1vPyL0QpnoPm7TVGrV4iMddxw0t2V1z3rWu0vKMYCG4xIbnan9OrZhpOLmchooxpVw3+hn3Z3RkTKYFMHgFzegUWn3Y9i5agDizL0lzuidUltSDlNVuxbKxyO5K09dE5TYDL2E/HeDDUki7eXHHVjPyBuddP5LQ3bT6bK7PHC1MBwJquqgsz95jif3CvzkmteKYKyYslT+bNuW81H86dYaXbtrvur3LQnyMxRaVwy8XbW+Isw2sa8QNFPI8X3rB+Nzj8V9LCf/jr1SZWTaxyP0pAJmMETVR8Hcvtti2i0KrQJL8MmYXXg3ZmYOawWP025cF1/hLaSHsdfcr+87YPtjO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f361be-820f-4d7a-e305-08d7666da328
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 06:08:57.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVfMelOJ4SceDfBnQ3Osv687vM9JtoFf74ymBX4y3FCZk4+V74ChJG4U8c7MwpgebQNH8upPnR2asynqSjoNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBOb3YgMTAsIDIwMTkgYXQgMTE6NTYgUE0gT2RlZCBHYWJiYXkgd3JvdGU6DQo+IFRo
ZSB0d28gZGVmaW5lcyB0aGF0IGNvbnRyb2wgdGhlIG1heGltdW0gc2l6ZSBvZiBhIGNvbW1hbmQg
YnVmZmVyIGFuZCB0aGUNCj4gbWF4aW11bSBudW1iZXIgb2YgSk9CUyBwZXIgQ1MgbmVlZCB0byBi
ZSBleHBvcnRlZCB0byB0aGUgdXNlciBhcyB0aGV5DQo+IGFyZSBwYXJ0IG9mIHRoZSBBUEkgdG93
YXJkcyB1c2VyLXNwYWNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQu
Z2FiYmF5QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE9tZXIgU2hwaWdlbG1hbiA8b3NocGln
ZWxtYW5AaGFiYW5hLmFpPg0K
