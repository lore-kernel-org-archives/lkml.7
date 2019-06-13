Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED20C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EE72064A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="nbK0c+BQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbfFMPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:52:53 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:32518
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731629AbfFMJGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Oo7YHv3N4WeTHDMLA2HPwPovcO6ORtzEu2yX6fwgk=;
 b=nbK0c+BQms9WKYF/SXq1TlXmtU3h6ZBQL3foOY6BuuqPZPNU01h53J/QheD2foBVV1nnEozOjKU2hXF/2V8itCb4lt1yHXpcILwpFps1efVzrVoaYDXh0NuPXCp0oQ5Bqipys6LeaxP1RandG5kxJqq5dt9DZcmgxDmf64iZzxM=
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com (20.179.26.150) by
 VI1PR05MB5599.eurprd05.prod.outlook.com (20.177.203.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 09:06:07 +0000
Received: from VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c]) by VI1PR05MB6477.eurprd05.prod.outlook.com
 ([fe80::8437:8389:cec3:452c%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 09:06:07 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
CC:     Igor Opaniuk <igor.opaniuk@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v1 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Topic: [PATCH v1 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Thread-Index: AQHVD9h2j33UZ9XhhkqUix6wZGjeSaaZbsYA
Date:   Thu, 13 Jun 2019 09:06:07 +0000
Message-ID: <15af220ffe1bcd36bd0cf178ed9f8d09a332d447.camel@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
         <20190521103619.4707-5-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190521103619.4707-5-oleksandr.suvorov@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d75888b-8ef6-4d6c-fb1d-08d6efde5ec9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5599;
x-ms-traffictypediagnostic: VI1PR05MB5599:
x-microsoft-antispam-prvs: <VI1PR05MB5599A77581D1F52CAE7BA2C5FBEF0@VI1PR05MB5599.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39850400004)(366004)(346002)(136003)(189003)(199004)(305945005)(186003)(118296001)(6636002)(11346002)(229853002)(26005)(6486002)(316002)(71190400001)(7736002)(71200400001)(54906003)(86362001)(478600001)(110136005)(14454004)(3846002)(6246003)(81156014)(99286004)(36756003)(76176011)(8676002)(6506007)(53936002)(476003)(6512007)(256004)(5660300002)(25786009)(81166006)(6436002)(8936002)(66446008)(66066001)(4326008)(2501003)(66556008)(66476007)(64756008)(68736007)(66946007)(76116006)(44832011)(2616005)(2906002)(6116002)(486006)(446003)(102836004)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5599;H:VI1PR05MB6477.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bJjiAbU6LZXTXRQEDsMAPBUyZldT2reqp0wKB3olZPvROsG1HAzHebmeKUqU7a2VE/mGgOCrxWU/mfexNkWzg8tx1XnT1hRKohh7cF7eBK7ypEAhbl7iw693GgUv95xtpBO5fWQq9zOio/pJlkesYC4jJQbgQNWFkRK8WxR/SmoqJEWF4EiMAIkkdBlCCewz4AgLbqctDkadp2oZHdozjncXk7HWHfMb8fDheTN9rqR+rwX6tqe4ZE/kFPtXkoVg30PmPs5RlT+1wwYkIk+QkuMt3hDeWQ9I8s9F8ZilcpOHuG6g8IwNHIUdmsF29vyyzuv6OfkoTx2RacnaUBdz/GJhypEWtRNF+jGHy7GaoE/QPKS7I0K/iqgdxS4T4axMnYBrgo26MdKS6MI+0VS1X+dViQ/fxu/ZixIq8gSW9CQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE33956761B04E468ED912869CCE356D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d75888b-8ef6-4d6c-fb1d-08d6efde5ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 09:06:07.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: marcel.ziswiler@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjM2ICswMzAwLCBPbGVrc2FuZHIgU3V2b3JvdiB3cm90
ZToNCj4gSWYgVkREQSAhPSBWRERJTyBhbmQgYW55IG9mIHRoZW0gaXMgZ3JlYXRlciB0aGFuIDMu
MVYsIGNoYXJnZSBwdW1wDQo+IHNvdXJjZSBjYW4gYmUgYXNzaWduZWQgYXV0b21hdGljYWxseS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIuc3V2b3Jv
dkB0b3JhZGV4LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnpp
c3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IC0tLQ0KPiANCj4gIHNvdW5kL3NvYy9jb2RlY3Mvc2d0
bDUwMDAuYyB8IDE0ICsrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBzb3VuZC9zb2MvY29kZWNz
L3NndGw1MDAwLmMgc291bmQvc29jL2NvZGVjcy9zZ3RsNTAwMC5jDQo+IGluZGV4IGU4MTNhMzc5
MTBhZi4uZWUxZTRiZjYxMzIyIDEwMDY0NA0KPiAtLS0gc291bmQvc29jL2NvZGVjcy9zZ3RsNTAw
MC5jDQo+ICsrKyBzb3VuZC9zb2MvY29kZWNzL3NndGw1MDAwLmMNCj4gQEAgLTExNzQsMTIgKzEx
NzQsMTYgQEAgc3RhdGljIGludCBzZ3RsNTAwMF9zZXRfcG93ZXJfcmVncyhzdHJ1Y3QNCj4gc25k
X3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCj4gIAkJCQkJU0dUTDUwMDBfSU5UX09TQ19FTik7
DQo+ICAJCS8qIEVuYWJsZSBWRERDIGNoYXJnZSBwdW1wICovDQo+ICAJCWFuYV9wd3IgfD0gU0dU
TDUwMDBfVkREQ19DSFJHUE1QX1BPV0VSVVA7DQo+IC0JfSBlbHNlIGlmICh2ZGRpbyA+PSAzMTAw
ICYmIHZkZGEgPj0gMzEwMCkgew0KPiArCX0gZWxzZSB7DQo+ICAJCWFuYV9wd3IgJj0gflNHVEw1
MDAwX1ZERENfQ0hSR1BNUF9QT1dFUlVQOw0KPiAtCQkvKiBWRERDIHVzZSBWRERJTyByYWlsICov
DQo+IC0JCWxyZWdfY3RybCB8PSBTR1RMNTAwMF9WRERDX0FTU05fT1ZSRDsNCj4gLQkJbHJlZ19j
dHJsIHw9IFNHVEw1MDAwX1ZERENfTUFOX0FTU05fVkRESU8gPDwNCj4gLQkJCSAgICBTR1RMNTAw
MF9WRERDX01BTl9BU1NOX1NISUZUOw0KPiArCQkvKiBpZiB2ZGRpbyA9PSB2ZGRhIHRoZSBzb3Vy
Y2Ugb2YgY2hhcmdlIHB1bXAgc2hvdWxkIGJlDQo+ICsJCSAqIGFzc2lnbmVkIG1hbnVhbGx5IHRv
IFZERElPDQo+ICsJCSAqLw0KPiArCQlpZiAodmRkaW8gPT0gdmRkYSkgew0KPiArCQkJbHJlZ19j
dHJsIHw9IFNHVEw1MDAwX1ZERENfQVNTTl9PVlJEOw0KPiArCQkJbHJlZ19jdHJsIHw9IFNHVEw1
MDAwX1ZERENfTUFOX0FTU05fVkRESU8gPDwNCj4gKwkJCQkgICAgU0dUTDUwMDBfVkREQ19NQU5f
QVNTTl9TSElGVDsNCj4gKwkJfQ0KPiAgCX0NCj4gIA0KPiAgCXNuZF9zb2NfY29tcG9uZW50X3dy
aXRlKGNvbXBvbmVudCwgU0dUTDUwMDBfQ0hJUF9MSU5SRUdfQ1RSTCwNCj4gbHJlZ19jdHJsKTsN
Cj4gLS0gDQo+IDIuMjAuMQ0K
