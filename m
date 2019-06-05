Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69ADC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666582067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="TRP1sB1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFEVCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:02:06 -0400
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:9357
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFEVCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ4Mjp07DQCFWHCwyQ6KYQgf8nFlazZ9TOiF+pSUN1w=;
 b=TRP1sB1rTd896TfjngIUxP2eFoD/oAwqdguaidZo0xJfhVEK1E3yFWCymXqzocPAqn/QimbrbLhqdMNJ7sW3PQ5EWZHlW1etnTlKyKXzTw8N018+xTamrx5M4AWAHYfYGjyE8UgbmibUvUrczBHfoM5fj7ivH1y1rgY8es1BVU8=
Received: from BN8PR06MB6228.namprd06.prod.outlook.com (20.178.217.156) by
 BN8PR06MB6194.namprd06.prod.outlook.com (20.178.215.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Wed, 5 Jun 2019 21:02:03 +0000
Received: from BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::bc27:e0e1:e3e2:7b52]) by BN8PR06MB6228.namprd06.prod.outlook.com
 ([fe80::bc27:e0e1:e3e2:7b52%6]) with mapi id 15.20.1943.018; Wed, 5 Jun 2019
 21:02:03 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.linux.org" <linux-nfs@vger.linux.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHVG+HsIC2HWV3WS06QCVj0pV28+Q==
Date:   Wed, 5 Jun 2019 21:02:02 +0000
Message-ID: <a8ebea1795238acb889dbf3d5b15303bbfccbbf9.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7dcace7-b4d2-44c5-1bc5-08d6e9f90f64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR06MB6194;
x-ms-traffictypediagnostic: BN8PR06MB6194:
x-microsoft-antispam-prvs: <BN8PR06MB6194CF8AEBA048D9783EA5EDF8160@BN8PR06MB6194.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(376002)(366004)(346002)(136003)(396003)(199004)(189003)(8676002)(3846002)(71200400001)(6916009)(2616005)(476003)(478600001)(5660300002)(305945005)(66446008)(5640700003)(72206003)(71190400001)(102836004)(6506007)(14444005)(256004)(6436002)(53936002)(91956017)(2906002)(25786009)(26005)(486006)(118296001)(76116006)(6486002)(6116002)(54906003)(66556008)(66476007)(99286004)(66946007)(73956011)(64756008)(186003)(81156014)(316002)(81166006)(58126008)(14454004)(86362001)(36756003)(8936002)(1730700003)(7736002)(2501003)(2351001)(6512007)(66066001)(68736007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB6194;H:BN8PR06MB6228.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vF9QenSwhI4sRhr4bNB2grfTXWs9b9lEKGlwGbWFwxX5l3Zhz+5lxovUr9Z4Eix50pZhElOCYvyJSvwqhEz64kEUYxUZuckBPDHkn1DAXLDToQ1axSSmtaIttAsbEEnEEd2Ot8z+kHmOJ+rsZUuRTT8kkVd/Sc8sJUw8DOKXUKcbSyb4ZpfWgE2KDOJSNjqxCmPXuDYTnlXWpsuuVxPqVlWosg6ocRUE2w1SMd2qVpVQ9aGiFFTei8+347LG4oxLi2CnFFEUtVcwYttBdWnfBL0wQOVQXhGbr3igKtc6WU/SgCjLIYjo0nttSiWWjfsTx7OiVPhf3RVoatXgrIiUsBlaaty6J2WOP9hvgdWPDnoGUmjNG21T94E2IGjziDc9x6xH67Pg3zNK4piFfyLQiybbphkGBb8EdoKacH3+U3M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CBFABC1D6362646838A787D517D889D@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dcace7-b4d2-44c5-1bc5-08d6e9f90f64
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 21:02:03.1872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjschuma@netapp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQNCmNkNmM4NGQ4
ZjBjZGM5MTFkZjQzNWJiMDc1YmEyMmNlM2M2MDViMDc6DQoNCiAgTGludXggNS4yLXJjMiAoMjAx
OS0wNS0yNiAxNjo0OToxOSAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvYW5uYS9saW51
eC1uZnMuZ2l0IHRhZ3MvbmZzLWZvci01LjItDQoyDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0bw0KYmE4NTFhMzljOTcwM2YwOTY4NGE1NDE4ODVlZDE3NmY4ZmI3Yzg2ODoNCg0KICBO
RlN2NC4xOiBGaXggYnVnIG9ubHkgZmlyc3QgQ0JfTk9USUZZX0xPQ0sgaXMgaGFuZGxlZCAoMjAx
OS0wNS0zMA0KMTU6NTE6MDcgLTA0MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRoZXNlIGFyZSBtb3N0bHkgc3Rh
YmxlIGJ1Z2ZpeGVzIGZvdW5kIGR1cmluZyB0ZXN0aW5nLCBtYW55IGR1cmluZyB0aGUNCnJlY2Vu
dCBORlMgYmFrZS1hLXRob24uDQoNClN0YWJsZSBidWdmaXhlczoNCi0gU1VOUlBDOiBGaXggcmVn
cmVzc2lvbiBpbiB1bW91bnQgb2YgYSBzZWN1cmUgbW91bnQNCi0gU1VOUlBDOiBGaXggYSB1c2Ug
YWZ0ZXIgZnJlZSB3aGVuIGEgc2VydmVyIHJlamVjdHMgdGhlIFJQQ1NFQ19HU1MNCmNyZWRlbnRp
YWwNCi0gTkZTdjQuMTogQWdhaW4gZml4IGEgcmFjZSB3aGVyZSBDQl9OT1RJRllfTE9DSyBmYWls
cyB0byB3YWtlIGEgd2FpdGVyDQotIE5GU3Y0LjE6IEZpeCBidWcgb25seSBmaXJzdCBDQl9OT1RJ
RllfTE9DSyBpcyBoYW5kbGVkDQoNCk90aGVyIGJ1Z2ZpeGVzOg0KLSB4cHJ0cmRtYTogVXNlIHN0
cnVjdF9zaXplKCkgaW4ga3phbGxvYygpDQoNClRoYW5rcywNCkFubmENCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KR3Vz
dGF2byBBLiBSLiBTaWx2YSAoMSk6DQoNCiAgICAgIHhwcnRyZG1hOiBVc2Ugc3RydWN0X3NpemUo
KSBpbiBremFsbG9jKCkNCg0KT2xnYSBLb3JuaWV2c2thaWEgKDEpOg0KICAgICAgU1VOUlBDIGZp
eCByZWdyZXNzaW9uIGluIHVtb3VudCBvZiBhIHNlY3VyZSBtb3VudA0KDQpUcm9uZCBNeWtsZWJ1
c3QgKDEpOg0KICAgICAgU1VOUlBDOiBGaXggYSB1c2UgYWZ0ZXIgZnJlZSB3aGVuIGEgc2VydmVy
IHJlamVjdHMgdGhlIFJQQ1NFQ19HU1MNCmNyZWRlbnRpYWwNCg0KWWloYW8gV3UgKDIpOg0KICAg
ICAgTkZTdjQuMTogQWdhaW4gZml4IGEgcmFjZSB3aGVyZSBDQl9OT1RJRllfTE9DSyBmYWlscyB0
byB3YWtlIGENCndhaXRlcg0KICAgICAgTkZTdjQuMTogRml4IGJ1ZyBvbmx5IGZpcnN0IENCX05P
VElGWV9MT0NLIGlzIGhhbmRsZWQNCg0KIGZzL25mcy9uZnM0cHJvYy5jICAgICAgICAgICB8IDMy
ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQogbmV0L3N1bnJwYy9jbG50LmMgICAg
ICAgICAgIHwgMzAgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQogbmV0L3N1bnJwYy94
cHJ0cmRtYS92ZXJicy5jIHwgIDMgKy0tDQogMyBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25z
KCspLCAzNyBkZWxldGlvbnMoLSkNCg==
