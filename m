Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B17C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB27D2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="K/qEu3Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfHXAN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:13:56 -0400
Received: from mail-eopbgr720111.outbound.protection.outlook.com ([40.107.72.111]:30464
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfHXAN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:13:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M41xmgki8to+iEEodxQ3adZNMZWnPUvfW7gjcLrVB09WJQx7O+35lgR9g5wp0fIMWcCwQeX0s/iDauE0tHgnij/sT7p7v9CAJ5Tdx3OjzVXO7JsvhW3jhWk9xb5i33nCi6CVx9mKcHi5dxyhFzolU6XyOae/X35acMk99cIZpM0h4YBQD1V3mpdKQrKmhGAFGBDutMMASUg88C5r+YiVT4S5nUOH3M0ANEim5Hw73Kl1eqPJ8VsFfylv2OVMf2GXMDXWnDOj5O9StszLR3uvfeEN+ZUmeXtiwk03gJ369FGsdp2FHNR5AcI/VlXtlIUEAYjSHbWzCmBHBYbov6bwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpTiljRkaZu+InKWIUoQ9+7lnwFSxZFWVOXzrOemqsw=;
 b=Erx9eOsBXuAS2PxiUO+aSrYNwTuffapOZSKlPjGMPFFoV36DDr/8r1hqNtTxg8uLvnoHgqzd3HtRDnBNEc0EY58GwD5+avEBbT76+108+VygzTO6WPu6SRx7w/t6umbG8Sl3lfVr0KYHqPdpHvo3Roc/5Grp9m5dNgPzS0KQTVLM6drnob4/PGOaAg6+4B7wAvo35FD7VDR+QGg6qAjKKVgisBthfJQPISoIOfLs3/OWeR8S+YWWyuOj58fvVcwqPMHUE8b5AC0weVHEDpCTj3tl+tunCRHCO9fjAHEQ8kaAGcp9RfMA897BEZVc9h9ngc3BU7HV+BGJrBs486fMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpTiljRkaZu+InKWIUoQ9+7lnwFSxZFWVOXzrOemqsw=;
 b=K/qEu3NtzBF8DxnuVi86PTIBUHoX3WkOV6L/uxTrGjIbKMttfo8B1vnVetnv25dAkscs95dys7JRkkQ0vg0jWEwYxy8CQW4zOyYafCTaTVmIhLJlFbke48EfpyLN+Qirax6TxM94Bk+EIYSz8enfBJjE1yGloBozejFlAEL+u38=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.7; Sat, 24 Aug 2019 00:13:47 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Sat, 24 Aug
 2019 00:13:47 +0000
From:   Long Li <longli@microsoft.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Topic: [PATCH 3/3] nvme: complete request in work queue on CPU with
 flooded interrupts
Thread-Index: AQHVVx6V8EslWtuw80WR9kecrOlyh6cETI8AgAD8sjCAAJQMgIAASpsAgANJCKA=
Date:   Sat, 24 Aug 2019 00:13:47 +0000
Message-ID: <CY4PR21MB0741292F0C535156DAC690D7CEA70@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
 <1566281669-48212-4-git-send-email-longli@linuxonhyperv.com>
 <2a30a07f-982c-c291-e263-0cf72ec61235@grimberg.me>
 <CY4PR21MB0741E77B05835E1192415943CEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <CY4PR21MB074141B895C9FE0D390F590ACEAA0@CY4PR21MB0741.namprd21.prod.outlook.com>
 <7fbdf43a-9499-8fb3-f6ec-5f1027b9fb65@grimberg.me>
In-Reply-To: <7fbdf43a-9499-8fb3-f6ec-5f1027b9fb65@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1704844f-0e11-4adf-c310-08d72827ef1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
x-microsoft-antispam-prvs: <CY4PR21MB0837177B176480A51887C010CEA70@CY4PR21MB0837.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(43544003)(189003)(199004)(53936002)(2501003)(10090500001)(22452003)(316002)(7736002)(229853002)(6246003)(8990500004)(6436002)(110136005)(52536014)(25786009)(33656002)(55016002)(14454004)(5660300002)(9686003)(14444005)(256004)(10290500003)(446003)(2201001)(6116002)(11346002)(76116006)(99286004)(66446008)(66556008)(66476007)(64756008)(66946007)(8676002)(81166006)(81156014)(486006)(476003)(71200400001)(6506007)(71190400001)(7696005)(76176011)(186003)(46003)(2906002)(102836004)(8936002)(478600001)(74316002)(305945005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FjbBa3PqxOFTTgZACkSFqcLMAnimYbGZXnBjg0oFqlWzYg+Bv1B8b041ik/EcKO8fPtPtKW7+aVsFtg3zsS4j6AIY7wpCP+4HJ+4813xpjhap3fkg5AthwTyphz2hffvT/ccJ5MzlUYnOt13XxrMGToHruDSWXPKpIsRLW9iPxyt99sQhPAHbhFhzzSjQvsLMtD7RoHSP2jS1jtLTzkx5ZrDaFx2wQ99a1Gn7yBpzYHXeAuFJnUZxeTIT9jy8WewSpvBkGFWrbffPzpMIcRX8wDvszpv5LZqKy9bJw5I3y5awX6djgJbZSLL7Nfm8wSvHVCu/oPqxe5G/b9dbqUiTJjMd9SA3CqB8PoTI2vVhwZzklaD8mFpuKCEUP6mPfSZppPX71W3HjEcKRpZhlB22cBAZcHOQ1Nqu84xAw1n2+Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1704844f-0e11-4adf-c310-08d72827ef1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 00:13:47.4917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMChg6RsF8wlVj4QD/rmRK5seX4TMw/NXimsJaK1Ss3n8iTzk8zUnIhBEUxLbGypiDzV1mC027f1ILT1cMHDEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+U3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIG52bWU6IGNvbXBsZXRlIHJlcXVlc3QgaW4gd29y
ayBxdWV1ZSBvbiBDUFUNCj4+PndpdGggZmxvb2RlZCBpbnRlcnJ1cHRzDQo+Pj4NCj4+Pg0KPj4+
PiBTYWdpLA0KPj4+Pg0KPj4+PiBIZXJlIGFyZSB0aGUgdGVzdCByZXN1bHRzLg0KPj4+Pg0KPj4+
PiBCZW5jaG1hcmsgY29tbWFuZDoNCj4+Pj4gZmlvIC0tYnM9NGsgLS1pb2VuZ2luZT1saWJhaW8g
LS1pb2RlcHRoPTY0DQo+Pj4+IC0tDQo+Pj5maWxlbmFtZT0vZGV2L252bWUwbjE6L2Rldi9udm1l
MW4xOi9kZXYvbnZtZTJuMTovZGV2L252bWUzbjE6L2QNCj4+PmV2L252DQo+Pj4+DQo+Pj5tZTRu
MTovZGV2L252bWU1bjE6L2Rldi9udm1lNm4xOi9kZXYvbnZtZTduMTovZGV2L252bWU4bjE6L2Rl
dg0KPj4+L252bWU5bjENCj4+Pj4gLS1kaXJlY3Q9MSAtLXJ1bnRpbWU9OTAgLS1udW1qb2JzPTgw
IC0tcnc9cmFuZHJlYWQgLS1uYW1lPXRlc3QNCj4+Pj4gLS1ncm91cF9yZXBvcnRpbmcgLS1ndG9k
X3JlZHVjZT0xDQo+Pj4+DQo+Pj4+IFdpdGggeW91ciBwYXRjaDogMTcyMGsgSU9QUw0KPj4+PiBX
aXRoIHRocmVhZGVkIGludGVycnVwdHM6IDEzMjBrIElPUFMNCj4+Pj4gV2l0aCBqdXN0IGludGVy
cnVwdHM6IDM3MjBrIElPUFMNCj4+Pj4NCj4+Pj4gSW50ZXJydXB0cyBhcmUgdGhlIGZhc3Rlc3Qg
YnV0IHdlIG5lZWQgdG8gZmluZCBhIHdheSB0byB0aHJvdHRsZSBpdC4NCj4+Pg0KPj4+VGhpcyBp
cyB0aGUgd29ya2xvYWQgdGhhdCBnZW5lcmF0ZXMgdGhlIGZsb29kPw0KPj4+SWYgc28gSSBkaWQg
bm90IGV4cGVjdCB0aGF0IHRoaXMgd291bGQgYmUgdGhlIHBlcmYgZGlmZmVyZW5jZS4uDQo+Pj4N
Cj4+PklmIGNvbXBsZXRpb25zIGtlZXAgcG91bmRpbmcgb24gdGhlIGNwdSwgSSB3b3VsZCBleHBl
Y3QgaXJxcG9sbCB0byBzaW1wbHkNCj4+PmtlZXAgcnVubmluZyBmb3JldmVyIGFuZCBwb2xsIHRo
ZSBjcXMuIFRoZXJlIGlzIG5vIGZ1bmRhbWVudGFsIHJlYXNvbiB3aHkNCj4+PnBvbGxpbmcgd291
bGQgYmUgZmFzdGVyIGluIGFuIGludGVycnVwdCwgd2hhdCBtYXR0ZXJzIGNvdWxkIGJlOg0KPj4+
MS4gd2UgcmVzY2hlZHVsZSBtb3JlIHRoYW4gd2UgbmVlZCB0bw0KPj4+Mi4gd2UgZG9uJ3QgcmVh
cCBlbm91Z2ggY29tcGxldGlvbnMgaW4gZXZlcnkgcG9sbCByb3VuZCwgd2hpY2ggd2lsbCB0cmln
Z2VyDQo+Pj5yZWFybWluZyB0aGUgaW50ZXJydXB0IGFuZCB0aGVuIHdoZW4gaXQgZmlyZXMgcmVz
Y2hlZHVsZSBhbm90aGVyIHNvZnRpcnEuLi4NCj4+Pg0KDQpZZXMgSSB0aGluayBpdCdzIHRoZSBy
ZXNjaGVkdWxpbmcgdGhhdCB0YWtlcyBzb21lLiBXaXRoIHRoZSBwYXRjaCB0aGVyZSBhcmUgbG90
cyBvZiBrc29mdGlycWQgYWN0aXZpdGllcy4gKGNvbXBhcmVkIHRvIG5lYXJseSBub25lIHdpdGhv
dXQgdGhlIHBhdGNoKQ0KQSA5MCBzZWNvbmRzIEZJTyBydW4gc2hvd3MgYSBiaWcgZGlmZmVyZW5j
ZSBvZiBjb250ZXh0IHN3aXRjaGVzIG9uIGFsbCBDUFVzOg0KV2l0aCBwYXRjaDogNTc1NTg0OQ0K
V2l0aG91dCBwYXRjaDogMTQ2MjkzMQ0KDQo+Pj5NYXliZSB3ZSBuZWVkIHRvIHRha2UgY2FyZSBv
ZiBzb21lIGlycV9wb2xsIG9wdGltaXphdGlvbnM/DQo+Pj4NCj4+PkRvZXMgdGhpcyAodW50ZXN0
ZWQpIHBhdGNoIG1ha2UgYW55IGRpZmZlcmVuY2U/DQo+Pj4tLQ0KPj4+ZGlmZiAtLWdpdCBhL2xp
Yi9pcnFfcG9sbC5jIGIvbGliL2lycV9wb2xsLmMgaW5kZXggMmYxN2I0ODhkNThlLi4wZTk0MTgz
ZWJhMTUNCj4+PjEwMDY0NA0KPj4+LS0tIGEvbGliL2lycV9wb2xsLmMNCj4+PisrKyBiL2xpYi9p
cnFfcG9sbC5jDQo+Pj5AQCAtMTIsNyArMTIsOCBAQA0KPj4+ICAjaW5jbHVkZSA8bGludXgvaXJx
X3BvbGwuaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+Pj4NCj4+Pi1zdGF0aWMg
dW5zaWduZWQgaW50IGlycV9wb2xsX2J1ZGdldCBfX3JlYWRfbW9zdGx5ID0gMjU2Ow0KPj4+K3N0
YXRpYyB1bnNpZ25lZCBpbnQgaXJxX3BvbGxfYnVkZ2V0IF9fcmVhZF9tb3N0bHkgPSAzMDAwOyB1
bnNpZ25lZCBpbnQNCj4+PitfX3JlYWRfbW9zdGx5IGlycXBvbGxfYnVkZ2V0X3VzZWNzID0gMjAw
MDsNCj4+Pg0KPj4+ICBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGxpc3RfaGVhZCwgYmxr
X2NwdV9pb3BvbGwpOw0KPj4+DQo+Pj5AQCAtNzcsMzIgKzc4LDI2IEBAIEVYUE9SVF9TWU1CT0wo
aXJxX3BvbGxfY29tcGxldGUpOw0KPj4+DQo+Pj4gIHN0YXRpYyB2b2lkIF9fbGF0ZW50X2VudHJv
cHkgaXJxX3BvbGxfc29mdGlycShzdHJ1Y3Qgc29mdGlycV9hY3Rpb24gKmgpDQo+Pj4gIHsNCj4+
Pi0gICAgICAgc3RydWN0IGxpc3RfaGVhZCAqbGlzdCA9IHRoaXNfY3B1X3B0cigmYmxrX2NwdV9p
b3BvbGwpOw0KPj4+LSAgICAgICBpbnQgcmVhcm0gPSAwLCBidWRnZXQgPSBpcnFfcG9sbF9idWRn
ZXQ7DQo+Pj4tICAgICAgIHVuc2lnbmVkIGxvbmcgc3RhcnRfdGltZSA9IGppZmZpZXM7DQo+Pj4r
ICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmlycXBvbGxfbGlzdCA9IHRoaXNfY3B1X3B0cigmYmxr
X2NwdV9pb3BvbGwpOw0KPj4+KyAgICAgICB1bnNpZ25lZCBpbnQgYnVkZ2V0ID0gaXJxX3BvbGxf
YnVkZ2V0Ow0KPj4+KyAgICAgICB1bnNpZ25lZCBsb25nIHRpbWVfbGltaXQgPQ0KPj4+KyAgICAg
ICAgICAgICAgIGppZmZpZXMgKyB1c2Vjc190b19qaWZmaWVzKGlycXBvbGxfYnVkZ2V0X3VzZWNz
KTsNCj4+PisgICAgICAgTElTVF9IRUFEKGxpc3QpOw0KPj4+DQo+Pj4gICAgICAgICBsb2NhbF9p
cnFfZGlzYWJsZSgpOw0KPj4+KyAgICAgICBsaXN0X3NwbGljZV9pbml0KGlycXBvbGxfbGlzdCwg
Jmxpc3QpOw0KPj4+KyAgICAgICBsb2NhbF9pcnFfZW5hYmxlKCk7DQo+Pj4NCj4+Pi0gICAgICAg
d2hpbGUgKCFsaXN0X2VtcHR5KGxpc3QpKSB7DQo+Pj4rICAgICAgIHdoaWxlICghbGlzdF9lbXB0
eSgmbGlzdCkpIHsNCj4+PiAgICAgICAgICAgICAgICAgc3RydWN0IGlycV9wb2xsICppb3A7DQo+
Pj4gICAgICAgICAgICAgICAgIGludCB3b3JrLCB3ZWlnaHQ7DQo+Pj4NCj4+Pi0gICAgICAgICAg
ICAgICAvKg0KPj4+LSAgICAgICAgICAgICAgICAqIElmIHNvZnRpcnEgd2luZG93IGlzIGV4aGF1
c3RlZCB0aGVuIHB1bnQuDQo+Pj4tICAgICAgICAgICAgICAgICovDQo+Pj4tICAgICAgICAgICAg
ICAgaWYgKGJ1ZGdldCA8PSAwIHx8IHRpbWVfYWZ0ZXIoamlmZmllcywgc3RhcnRfdGltZSkpIHsN
Cj4+Pi0gICAgICAgICAgICAgICAgICAgICAgIHJlYXJtID0gMTsNCj4+Pi0gICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPj4+LSAgICAgICAgICAgICAgIH0NCj4+Pi0NCj4+Pi0gICAgICAg
ICAgICAgICBsb2NhbF9pcnFfZW5hYmxlKCk7DQo+Pj4tDQo+Pj4gICAgICAgICAgICAgICAgIC8q
IEV2ZW4gdGhvdWdoIGludGVycnVwdHMgaGF2ZSBiZWVuIHJlLWVuYWJsZWQsIHRoaXMNCj4+PiAg
ICAgICAgICAgICAgICAgICogYWNjZXNzIGlzIHNhZmUgYmVjYXVzZSBpbnRlcnJ1cHRzIGNhbiBv
bmx5IGFkZCBuZXcNCj4+PiAgICAgICAgICAgICAgICAgICogZW50cmllcyB0byB0aGUgdGFpbCBv
ZiB0aGlzIGxpc3QsIGFuZCBvbmx5IC0+cG9sbCgpDQo+Pj4gICAgICAgICAgICAgICAgICAqIGNh
bGxzIGNhbiByZW1vdmUgdGhpcyBoZWFkIGVudHJ5IGZyb20gdGhlIGxpc3QuDQo+Pj4gICAgICAg
ICAgICAgICAgICAqLw0KPj4+LSAgICAgICAgICAgICAgIGlvcCA9IGxpc3RfZW50cnkobGlzdC0+
bmV4dCwgc3RydWN0IGlycV9wb2xsLCBsaXN0KTsNCj4+PisgICAgICAgICAgICAgICBpb3AgPSBs
aXN0X2ZpcnN0X2VudHJ5KCZsaXN0LCBzdHJ1Y3QgaXJxX3BvbGwsIGxpc3QpOw0KPj4+DQo+Pj4g
ICAgICAgICAgICAgICAgIHdlaWdodCA9IGlvcC0+d2VpZ2h0Ow0KPj4+ICAgICAgICAgICAgICAg
ICB3b3JrID0gMDsNCj4+PkBAIC0xMTEsOCArMTA2LDYgQEAgc3RhdGljIHZvaWQgX19sYXRlbnRf
ZW50cm9weSBpcnFfcG9sbF9zb2Z0aXJxKHN0cnVjdA0KPj4+c29mdGlycV9hY3Rpb24gKmgpDQo+
Pj4NCj4+PiAgICAgICAgICAgICAgICAgYnVkZ2V0IC09IHdvcms7DQo+Pj4NCj4+Pi0gICAgICAg
ICAgICAgICBsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPj4+LQ0KPj4+ICAgICAgICAgICAgICAgICAv
Kg0KPj4+ICAgICAgICAgICAgICAgICAgKiBEcml2ZXJzIG11c3Qgbm90IG1vZGlmeSB0aGUgaW9w
b2xsIHN0YXRlLCBpZiB0aGV5DQo+Pj4gICAgICAgICAgICAgICAgICAqIGNvbnN1bWUgdGhlaXIg
YXNzaWduZWQgd2VpZ2h0IChvciBtb3JlLCBzb21lIGRyaXZlcnMgY2FuJ3QgQEANCj4+Pi0xMjUs
MTEgKzExOCwyMSBAQCBzdGF0aWMgdm9pZCBfX2xhdGVudF9lbnRyb3B5IGlycV9wb2xsX3NvZnRp
cnEoc3RydWN0DQo+Pj5zb2Z0aXJxX2FjdGlvbiAqaCkNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAodGVzdF9iaXQoSVJRX1BPTExfRl9ESVNBQkxFLCAmaW9wLT5zdGF0ZSkpDQo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2lycV9wb2xsX2NvbXBsZXRlKGlvcCk7
DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPj4+LSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsaXN0X21vdmVfdGFpbCgmaW9wLT5saXN0LCBsaXN0KTsNCj4+PisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9tb3ZlX3RhaWwoJmlvcC0+bGlzdCwgJmxp
c3QpOw0KPj4+ICAgICAgICAgICAgICAgICB9DQo+Pj4rDQo+Pj4rICAgICAgICAgICAgICAgLyoN
Cj4+PisgICAgICAgICAgICAgICAgKiBJZiBzb2Z0aXJxIHdpbmRvdyBpcyBleGhhdXN0ZWQgdGhl
biBwdW50Lg0KPj4+KyAgICAgICAgICAgICAgICAqLw0KPj4+KyAgICAgICAgICAgICAgIGlmIChi
dWRnZXQgPD0gMCB8fCB0aW1lX2FmdGVyX2VxKGppZmZpZXMsIHRpbWVfbGltaXQpKQ0KPj4+KyAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+Pj4gICAgICAgICB9DQo+Pj4NCj4+Pi0gICAg
ICAgaWYgKHJlYXJtKQ0KPj4+KyAgICAgICBsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPj4+Kw0KPj4+
KyAgICAgICBsaXN0X3NwbGljZV90YWlsX2luaXQoaXJxcG9sbF9saXN0LCAmbGlzdCk7DQo+Pj4r
ICAgICAgIGxpc3Rfc3BsaWNlKCZsaXN0LCBpcnFwb2xsX2xpc3QpOw0KPj4+KyAgICAgICBpZiAo
IWxpc3RfZW1wdHkoaXJxcG9sbF9saXN0KSkNCj4+PiAgICAgICAgICAgICAgICAgX19yYWlzZV9z
b2Z0aXJxX2lycW9mZihJUlFfUE9MTF9TT0ZUSVJRKTsNCj4+Pg0KPj4+ICAgICAgICAgbG9jYWxf
aXJxX2VuYWJsZSgpOw0KPj4+LS0NCg0KSXQncyBnb3Qgc2xpZ2h0bHkgYmV0dGVyIElPUFMuIFdp
dGggdGhpcyAybmQgcGF0Y2gsIHRoZSBudW1iZXIgb2YgY29udGV4dCBzd2l0Y2hlcyBpcyBhdCA1
NDQ1ODYzICh+NSUgaW1wcm92ZW1lbnQgb3ZlciB0aGUgMXN0IHBhdGNoKS4NCg==
