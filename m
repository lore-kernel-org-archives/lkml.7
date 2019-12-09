Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BCC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C812207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WxpGX1HV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLIKyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:54:55 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:25468
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727347AbfLIKyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:54:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Khzzwnp/skOD3zjLScEdobu55iQWmV5elVUdLki1nBdm83NYYQp+OlHqGbRO175f4jOBSmQImdBmZkYoifCtTcaNCl7PwdWuC6Chri+nXC7SoRkpyXx0iRn+Bo6V8rMfOQw6XYr38z7iTva5ZLRf/wRBjE1NHf3B4mAstoCRe+WoxeYw+hik6Bm9GjcVcd+sBU/RMXprOzS2tA4XhfaAh0uy95Ayt/58sCKN7QkTQ93cp8ycq524No2mwKwGEkeq++Ya3Qo5pnmG4sIFMJE2MDXKtSvVb2u0ih+JBycLzHYmaUdbNfPc7RMszUJpE3VC83QKBdIVC9kehKEzax+PxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFRW6bz/o5N+EcwVIRsHa/J+oHo9wfzyIRZBtC1DR0Y=;
 b=HJOUgSC77vumBVPwM64lTvDb5NdeS0z2wsj+2O02exSBfp+lneLqBHG0dRjU6DPBlhdrfU/w2zjJ3ImRsvOd1xPF8dla8cIT+umgH9r1uuMvy9bfKpysIPDcRCDLDc4RcEode/RP0RsUUOrUQt0Aw3iXUuj3Er5n4obD3dxSaRv9gg8o9AF6oxAy4S/smqjA2lz7KpgaHeLMFW2AIhL9dpVLtfZBTSOINMy7BtI52ighsJqAzNW6VhOzf7l7g3VUTmL4V3P8xnHHbrpHmgbhW4o67CKZyVUWifOnmLq7mbkMLzXZgJbFARP/6Osho3WnCBKBnZ3SlUVqFxg0gwNdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFRW6bz/o5N+EcwVIRsHa/J+oHo9wfzyIRZBtC1DR0Y=;
 b=WxpGX1HVDzRydd+0+EfSMQrT/XR6KMdqQK0lieITVP+qH54RI3q7zHPOP9g7vTM2DqsaxErPyxswhPOsHXDDE7YYQHZXPd+iCvr9ySMzcVFC2jCWqluKbS9uZkLEny03K3fmle89/QD2H7EWQUIGF5v68ZifAZYjvpRuuuBnpb8=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6247.namprd02.prod.outlook.com (52.132.228.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 10:54:50 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::a813:f8cb:207c:9c7]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::a813:f8cb:207c:9c7%4]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 10:54:50 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Derek Kiernan <dkiernan@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Documentation: fix Sphinx warning in xilinx_sdfec.rst
Thread-Topic: [PATCH] Documentation: fix Sphinx warning in xilinx_sdfec.rst
Thread-Index: AQHVrkd21IU3iMXack2EgvPo2nBd7qexoUVQ
Date:   Mon, 9 Dec 2019 10:54:50 +0000
Message-ID: <CH2PR02MB6359AB222D733BA04215AC3ECB580@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <8d644cf1-fa7b-ec62-84cf-9b41d7c30eed@infradead.org>
In-Reply-To: <8d644cf1-fa7b-ec62-84cf-9b41d7c30eed@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37c97d1b-26f7-4ad3-ff26-08d77c96371f
x-ms-traffictypediagnostic: CH2PR02MB6247:|CH2PR02MB6247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB624748B2FDC71E7AC2CB9220CB580@CH2PR02MB6247.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:117;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(13464003)(110136005)(54906003)(8936002)(316002)(8676002)(305945005)(81166006)(81156014)(64756008)(66556008)(66946007)(53546011)(7696005)(66446008)(6506007)(71190400001)(66476007)(5660300002)(71200400001)(52536014)(76116006)(478600001)(9686003)(33656002)(26005)(2906002)(4326008)(86362001)(229853002)(55016002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6247;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nLxOsrwGU6MyLsHxdGGUfHjX0Zd8MExiLPWQtkdJydqSj8wPK3saQoZ601aw/twILRzY+wiXvQeefNy9fF0ix7azVl3umQplYFdFhcOgNgYK/2rM3vvnMSJTmBI5uhUcRfvqv6IwMI0BPjkwVexJDaoKrTLBD/dtoOiY8xTbCV504DqEQnJytU4VafDAW3Nti+4AHa7fHxwC0eiyE5qeNlgoCXKgbiJKqEh6Y0rfWjqTOCC5PWi1p6YzCAsGVOHvXNF0wDEfVLBYko543GqZvLOdQriTbiqS8fZRy0d0sK3lQ+Y50TRNLqWK1mRDpkIeOfOxg0E/xGO+EN9JBzQWUtIG2vvUEHEizeWfFp5izsfDRSyS9UyFF/3GNT9G+DKY5ACrhPhmLySUIl5tyDO83hGM6SJeRWDTrkeeGwOxr+JdqTAZALia8FN1245+TNZV5s2pqB/7tYOmRlu09NizNVkAFHwlin8y7KcMlkeeyHo5xMvVyBh+tl6GMhSrqsXQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c97d1b-26f7-4ad3-ff26-08d77c96371f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 10:54:50.6657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uh4VWShRMZKyhxdapm8z4yj6EpDwHOHYk3bzY1LfCTa56NwWgC+j6k1ipIVM5YTK51aphTxshcDehrQQdfF6FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNClRoYW5rcyBmb3IgZml4aW5nIHRoZSB3YXJuaW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVh
ZC5vcmc+DQo+IFNlbnQ6IE1vbmRheSA5IERlY2VtYmVyIDIwMTkgMDQ6MTcNCj4gVG86IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+
IENjOiBEZXJlayBLaWVybmFuIDxka2llcm5hbkB4aWxpbnguY29tPjsgRHJhZ2FuIEN2ZXRpYyA8
ZHJhZ2FuY0B4aWxpbnguY29tPjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogW1BBVENIXSBEb2N1bWVudGF0aW9uOiBmaXggU3BoaW54IHdhcm5pbmcgaW4g
eGlsaW54X3NkZmVjLnJzdA0KPiANCj4gRnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJh
ZGVhZC5vcmc+DQo+IA0KPiBGaXggU3BoaW54IGZvcm1hdCB3YXJuaW5nIGJ5IGFkZGluZyBhIGJs
YW5rIGxpbmUuDQo+IA0KPiBEb2N1bWVudGF0aW9uL21pc2MtZGV2aWNlcy94aWxpbnhfc2RmZWMu
cnN0OjI6IFdBUk5JTkc6IEV4cGxpY2l0IG1hcmt1cCBlbmRzIHdpdGhvdXQgYSBibGFuayBsaW5l
OyB1bmV4cGVjdGVkIHVuaW5kZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFw
IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBEZXJlayBLaWVybmFuIDxkZXJlay5raWVy
bmFuQHhpbGlueC5jb20+DQo+IENjOiBEcmFnYW4gQ3ZldGljIDxkcmFnYW4uY3ZldGljQHhpbGlu
eC5jb20+DQo+IENjOiBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KPiBDYzogbGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vbWlzYy1kZXZp
Y2VzL3hpbGlueF9zZGZlYy5yc3QgfCAgICAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiANCj4gLS0tIGxpbnV4LW5leHQtMjAxOTEyMDkub3JpZy9Eb2N1bWVudGF0aW9u
L21pc2MtZGV2aWNlcy94aWxpbnhfc2RmZWMucnN0DQo+ICsrKyBsaW51eC1uZXh0LTIwMTkxMjA5
L0RvY3VtZW50YXRpb24vbWlzYy1kZXZpY2VzL3hpbGlueF9zZGZlYy5yc3QNCj4gQEAgLTEsNCAr
MSw1IEBADQo+ICAuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gKw0KPiAg
PT09PT09PT09PT09PT09PT09PT0NCj4gIFhpbGlueCBTRC1GRUMgRHJpdmVyDQo+ICA9PT09PT09
PT09PT09PT09PT09PQ0KPiANCg0KQWNrZWQtYnk6IERyYWdhbiBDdmV0aWMgPGRyYWdhbi5jdmV0
aWNAeGlsaW54LmNvbT4NCg0KDQpSZWdhcmRzDQpEcmFnYW4NCg==
