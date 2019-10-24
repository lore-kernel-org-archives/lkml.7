Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8D9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D6020684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="D+gnLy8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438007AbfJXIHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:07:06 -0400
Received: from mail-eopbgr140094.outbound.protection.outlook.com ([40.107.14.94]:55420
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfJXIHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT/rkBf2KUEHnqNxV3+QMBbJb9m2LdoEVXE7eSmePrXZ2jiXH1ojHrsio/MUUItj7NYgN1R0YMMY1H/e2WK1H2meRpz1z/H2vKZVckQPhpyyG4QoWQoqjbmfPD0elV48nAiXHVlyyaMHAOh8n/qftF9vOYa9jHe3Kd4exe8z/ZWAZ3iM2c7sRSo0KXgKGVWGjxGUnd1LkO8xBEUT0Dxn/xWwZUTL4hE2sDmgHzRerufn/DOUyh2ikLx0QPm+T87dilmOaSZZ6HMhfP535PgxqieCS6sX8OKJduTD2w3e1b/Pf2pXmsDGujCcBeSIrySzOZA0whNZRpCHb1Qbb8AHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t480wy8S/UsW9F+L3Yu+YptIUAOXjkeYm1tDU/0m38=;
 b=akWUbUZF3Ex/OiktIsNgByzcKsr2DEvUIf4cgI7L/rq1k6bg43/5SKACGDeT8qUZibKu69vp5nCTMVLZL1dloNkq0s5baxACD21YVY0S3LeU10hogpaov65C8R3N3yVCSxuoUXTYo/m7b9ykfU3fcnqe5FITi6kWrQ6jw9bc9o6PkxqF58ZWFiWte23n9TjkwkbZ8z2uP4ig4x2+l5S5oIxLdHJJ9ZhdIYfLJkkZpv13fu0XII5rqPKmTJRc0cqvcSMgrZAC93aXf+LUkY+EgPRIo1CwX0vzI1Z1Fm3/4Av3GYW1xR6A+uVdgliNdyby0L+YKnjSQVWx8KJmnrVrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t480wy8S/UsW9F+L3Yu+YptIUAOXjkeYm1tDU/0m38=;
 b=D+gnLy8rMLv0UFKKQ+hPaiExDvdjMjp/jqdH7Hd12xYDyPk3PFGdqtH76U4xltbmUyc7ceWuh1HQT5aenZJ27bCRK6kGzNEdCL4yAgqqsyUyp/OYhbwaHrKsQ5hF5ocE9HJfcaGxRd3tUb/TxB0D7Hd6jzypjpw91kiKc2l7s+4=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3493.eurprd02.prod.outlook.com (52.133.31.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 24 Oct 2019 08:07:02 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2367.027; Thu, 24 Oct 2019
 08:07:02 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Topic: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Index: AQHViKI2kzFSWJT/Dk6DGcovF5gSd6dn9PuAgABElLCAAMnygIAAXYCg
Date:   Thu, 24 Oct 2019 08:07:01 +0000
Message-ID: <AM6PR0202MB3382CAB4D348F568EFBAC237B86A0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20191022063028.9030-1-oshpigelman@habana.ai>
 <20191023092035.GA12222@infradead.org>
 <AM6PR0202MB3382B554A4C7F0F677A804D7B86B0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
 <20191024012849.GB32358@infradead.org>
In-Reply-To: <20191024012849.GB32358@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.181.186]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0224508e-996f-45b3-3031-08d7585926b8
x-ms-traffictypediagnostic: AM6PR0202MB3493:
x-microsoft-antispam-prvs: <AM6PR0202MB3493E95F37DE6F8E1D110575B86A0@AM6PR0202MB3493.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39850400004)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(5660300002)(3846002)(6116002)(52536014)(6916009)(53546011)(7736002)(6506007)(305945005)(25786009)(86362001)(486006)(186003)(81166006)(8936002)(66066001)(4744005)(8676002)(102836004)(81156014)(26005)(11346002)(478600001)(74316002)(446003)(476003)(99286004)(76176011)(7696005)(316002)(2906002)(33656002)(54906003)(256004)(6436002)(229853002)(6246003)(14454004)(66556008)(9686003)(66946007)(64756008)(66476007)(66446008)(76116006)(55016002)(4326008)(71190400001)(71200400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3493;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FRpT/nulIokjojuRA1MnIS5YMWu10NGPTuY+u7X7nNg78vXYto5gi5LHNBXozs+jCnkomrghu8H5rGjn8aSBXp0JTgsTnquzk4vAxFRTfitu/Y1RyE/3pHx8AMfMXEyWw/dk5tT76silvK3f6OvCxxtoy2Z65HQCgrXpaNE+NonG3ikcBO3kz+COBSgVtneTsmpWGARMrGQ6ADVAjsgrJpF26DVCvv6qI0dsfQSqc0riKOqcaeAd5dv9E/u8pFV7XEFfgsMUV3RO+Z9DSAEY4JL8H5QwXzyoI3suCqhcR0q+VkHpPAGrqZxNWZdnbdAcHd33wAlNUB4mIYp7Z9HicI/hBVQO3LqBvFFQHK/Gl5SugCxxGd47hQfPxFsW5xELZk5ofDhZWY8o8gLnRwDTILonr8FN3wWkXAA0jWegTXgp23RtGYrA9tE978+xZHkG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 0224508e-996f-45b3-3031-08d7585926b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 08:07:01.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaYyy7hRStHUPGtZwPMjEKVlR82BE7bF2fFzEKGtXFtTPPiKQn8+CwH3lCydJUyGWtIzSRXtXOqaI2dFqzUFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBPY3QgMjQsIDIwMTkgYXQgMDQ6MjkgQU0gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBp
bmZyYWRlYWQub3JnPiB3cm90ZToNCj4gT24gV2VkLCBPY3QgMjMsIDIwMTkgYXQgMDE6Mzk6NDFQ
TSArMDAwMCwgT21lciBTaHBpZ2VsbWFuIHdyb3RlOg0KPiA+IEknbSBub3Qgc3VyZSBJIHVuZGVy
c3RhbmQuIENhbiB5b3UgcGxlYXNlIHBpbiBwb2ludCB0aGUgcHJvYmxlbWF0aWMgbGluZT8NCj4g
DQo+IEV2ZXJ5IGxpbmUgeW91IHRvdWNoIGFkZHIgZmllbGQgYmFzaWNhbGx5LiAgSWYgeW91IGhh
dmUgYSBrZXJuZWwgYWRkcmVzcyBwbGVhc2UNCj4gc3RvcmUgaXQgaW4gYW4gYWN0dWFsIEMgcG9p
bnRlciB0eXBlLCBub3QgaW4gYSB1NjQgdG8gZW5zdXJlIHRoYXQgdGhlIGNvbXBpbGVyDQo+IGNh
biBkbyBwcm9wZXIgdHlwZSBjaGVja2luZy4NCg0KSSBzZWUgeW91ciBwb2ludC4gSSdsbCBzZXBh
cmF0ZSB0aGUgY29kZSBzbyB0aGUga2VybmVsIGFkZHJlc3MgcGF0aCB3aWxsIHVzZSBhIHBvaW50
ZXIgdHlwZSByYXRoZXIgdGhhbiB1NjQuDQo=
