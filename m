Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477BC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADBC2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="fjUu1cw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfIBIk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:40:29 -0400
Received: from mail-eopbgr40112.outbound.protection.outlook.com ([40.107.4.112]:60152
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729870AbfIBIk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:40:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt3aocTrOYM6B4otj6wFqGqy5YNS2LW8SJ6kt7TTbaNG66+xWuIUgvIVO08T5AwROJXtRty+6RYzpJslm78Xq3YfAXBemWVBOQaSnWNOmoDM8ZywBo8f0ESPJx513dahqwFgxQhaD+9Umr889LYd0iB8zjYcYZqgVJa02pS/WdYghjqL/OUhwAgUQ22AccWoKbFPMKkHQW5ZW6jR+eAqOVI6GqTQxAtmJIXQt4QWItrU38auKpHWkaPlkrBEFdFEHTidvUzbYTBCTa/dsF29WD2lSCk/rUZjg8OKtIEF7dYdSAr3Etx9k7Ck4FRhAubqmZ0GlMnzKl151jZgU0yALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYS+ze3M6QQcY2TTd/G6Wx5gv8uDYYgVBYNIeM44HvQ=;
 b=m1+2FffIgRkF7meVSygeec302Mfb/wD3N0BaiFPqE0TxC79LuzK9Dz2YJJB5gQXWT00t1EHvpl2KeKWkHz17u3rIJ39CiBZu9R3OUZeprUa/2L8ldQ2DctR5OWwjRPxQc7yFCYQT0I6nDFpq66ei35jjoOxcur2ExAxF/fu7NJi8zp0liU517xZayptD7Pk3f1lvfmJ62KPsBiMev0486yDibsRRrqXTuUWRUNZQk8wADukG1OUVNg/DNON0pxj67AIYXtkNPXhZW1A1diH1xGuKYQFP+pFDZN5GIL10TUKzTaNbCOjjChZTdqKFDrpxajKS4+ijEVzCTNg+wMDABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYS+ze3M6QQcY2TTd/G6Wx5gv8uDYYgVBYNIeM44HvQ=;
 b=fjUu1cw6IzdYmn+MwjEBSuJNxRdeCCuqapgCM3Ocwy+bMbJqSjPSBiHDH7OViiUIXIp/gYZAIfSQDGuXCpP9gAboNLKQT0q8eU9LALXNgM/TGcr4JsCtZlN1IwLwR7JkD2h1I9GYoQxxolKLbamFA+uVSnsncLnCBCpHf0jRWP4=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3287.eurprd02.prod.outlook.com (52.133.30.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Mon, 2 Sep 2019 08:40:25 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::4171:a73:3c96:2c5b%7]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 08:40:25 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 2/2] habanalabs: show correct id in error print
Thread-Topic: [PATCH 2/2] habanalabs: show correct id in error print
Thread-Index: AQHVYWMYyHgeupmj4k6wAz0op/ACbacYEToQ
Date:   Mon, 2 Sep 2019 08:40:25 +0000
Message-ID: <AM6PR0202MB3382496B88E3E7C39DE3377BB8BE0@AM6PR0202MB3382.eurprd02.prod.outlook.com>
References: <20190902075024.27302-1-oded.gabbay@gmail.com>
 <20190902075024.27302-2-oded.gabbay@gmail.com>
In-Reply-To: <20190902075024.27302-2-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5bbb5c7-2460-4048-667b-08d72f813358
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR0202MB3287;
x-ms-traffictypediagnostic: AM6PR0202MB3287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0202MB32879768E923893BD13E1BB9B8BE0@AM6PR0202MB3287.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 01480965DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(81156014)(81166006)(52536014)(476003)(305945005)(7696005)(74316002)(66446008)(9686003)(6246003)(11346002)(5660300002)(26005)(2501003)(66066001)(86362001)(66946007)(64756008)(256004)(66476007)(7736002)(558084003)(66556008)(2906002)(6436002)(14454004)(316002)(3846002)(8676002)(76176011)(446003)(102836004)(8936002)(110136005)(4326008)(55016002)(71190400001)(71200400001)(486006)(53936002)(186003)(25786009)(478600001)(6116002)(6506007)(33656002)(6636002)(99286004)(76116006)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3287;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H/16O39orCvgWQ3KO9KvxPwsjfgQ8rqF4hGH1ul6l0JfpuuuYHeHJ8B++i8apI4N57lvZiIh6r22a8N1FVxdgTvORvCAiGx17f+/iXr/I/d7g1Av10p+b79n95kJjtpod5g3YFPGjB1ZUh+MLQsqpXDKSOmr09xC8lOizQA7RuRP8PqplZ03EKYsaTmyTNVsyrVhVqs5PUqpJHdG3/9J6wriozxzNzB+nHFPCPYk8Gwwu0DCRU9N3amKevwGlfTBmIgYjE8Uyr3bku0fgCD4hO6ia84DRMVeW5+hoS4LYXNVeo154jYgWugVBH4/a9nmnGpeTGJZ2kzx23LQC5ONuCpXnI0zpdXazBnaWWa6hay2nLo8UQ9elrt5M0JnGB/6phf6qPXoj1Q7otIYUy8BMt2Xe7pyIV0a3CdFWgXAkMI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bbb5c7-2460-4048-667b-08d72f813358
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2019 08:40:25.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXA/xMAwJLz/AvJ1/uLFmAuGVkE4cGIJP2tQMO63kU80i754NkdqfH+AdMN49wOgMOQG2I3JfLAsXG9JJKSgOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4NClNlbnQ6IE1vbmRheSwg
MiBTZXB0ZW1iZXIgMjAxOSAxMDo1MA0KDQo+IElmIHRoZSBpbml0aWFsaXphdGlvbiBvZiBhIGRl
dmljZSBmYWlsZWQsIHRoZSBkcml2ZXIgcHJpbnRzIGFuIGVycm9yIG1lc3NhZ2Ugd2l0aA0KPiB0
aGUgaWQgb2YgdGhlIGRldmljZS4gVGhlIGRldmljZSBpbmRleCBvbiB0aGUgZmlsZSBzeXN0ZW0g
aXMgdGhhdCBpZCBkaXZpZGVkIGJ5DQo+IDIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPZGVkIEdh
YmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogT21lciBTaHBpZ2Vs
bWFuIDxvc2hwaWdlbG1hbkBoYWJhbmEuYWk+DQo=
