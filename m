Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF739C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E1220863
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 22:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KstdKr7r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="spGf66WL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfI0W5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 18:57:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5185 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0W5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569625067; x=1601161067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SDITdhgUcsuCvLZN0TXx9BDBXxw8ZmL76yzU5ORKEyI=;
  b=KstdKr7rNJ9r5PK+ZSCN8jtl1ZNoe9yGg44wjjUzK5d6IRu6XxoJrsGt
   hdOyBxGgjD8bu5pXsFueczG2ySLwSVJjEWHIXjCBUMeULkGLZ1z8e4m9c
   H2ol7BzFyt6ok3mVOMPyoUZp9CkGnAv1r1lfdYMbc6efBXISoQXitCugb
   3QIZLlkUfxFitcXHC5cdiOCoY8nma+qEKg6eR//HDJ2dc+0Urw2n0RC0D
   HnjdOIGHOpzbSF1u/cE7Q5sPoi5aBWvPuqfakbXC/mq/tawglN4r51xIC
   T1g+z6jp5frNP+qJ0LGICH+dsHzki9nnPtYL8KGMvJu79oZCHu6c2Uq5f
   Q==;
IronPort-SDR: s1btCiq9s21XjKH5Rv7L5wmsx2gI5SKvyLCzM4BuhZy+rlUBGQbQgbpS95SMQLnWPepT6xlFxS
 a8IiB9D4fvjElbhS/58GrI0fH6NknRjnCZPvXoPtlhGLoSra7275bFg2EdC+H4ef1LTlnPNqY6
 IFcClCEbUbsyi1ZNjevkr1CTo9SCnOxxcuqXgejQF44byo1AYzVY6sz7WfE77UscRmwnTCv2/R
 dE/ZOE2tYtP08TDVACNtd5Yx3tRiRtMPYylNxTagA6YKGFFDMnSy4FpJSpHLMgrYjJMcq7FwbY
 XFU=
X-IronPort-AV: E=Sophos;i="5.64,557,1559491200"; 
   d="scan'208";a="120089266"
Received: from mail-by2nam05lp2059.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.59])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2019 06:57:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFBpj8tpNKA+pIvm0fdQ+miNSsw8bWnHgD0pY5gU6YonPNdCCcyKoi0L7xRtZvR+EOLUfkN5/a0Mn7PQmkoeqLzu/YSSgAH89ufx3Ir/We/B0aiuXwpKnUskSE9kMRiebuszXrAEHV50n+kfSJwNFQ641nLyH+YrhOtwXXaKzgT4TAZTIoChYetPB381UWFtRSPqgcul/4T5keK5pKpuk3xZLTL2LCyHrR7jYMyjoRiuzdyjRg3i3BhM5K/6XD4AeWryMyfBg/dV4QQ/LkhWJ1A8+TX13cr+9B8LE5hf4aYRvXn6tZiSspOhwra+KyktdbcyF/VdXpxy9em8bK4XKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDITdhgUcsuCvLZN0TXx9BDBXxw8ZmL76yzU5ORKEyI=;
 b=RpGPWG7BPDgQiYPpwoTQetQMmI1KTpZtXTycU3nzXznlDX72nw8XcVFk4fWNPj7R8rvhBUD/Q2JEjKsAIy4cx7oLrX519w1aR6aJ71ciTbdX6nC0O70bXSkldg8atO5PTR2TjJa+2ZW0xL3hBJxesl5AXElFTlPfNWgrekrjJI5XCODFjs0y4txiiZkNl8DoiUhdeTH9IW78HBbxI4sNwpzFHg/+dEqbDBBQ5me90QDxttVEuJhUXZtOsAJwbvi6+hoZGaHmnuo0t1ldkzlEb9SFTBIuhpEfFUpX5RC4ZEElqR5rqvi3hdJ5q7UZK8mvuPa6b8kPEOqAO1V6fitmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDITdhgUcsuCvLZN0TXx9BDBXxw8ZmL76yzU5ORKEyI=;
 b=spGf66WL84yqLT5leVCpgau/M+q+EGwfKYK9Rfg3oJGISssSf9HUN2HDu3i23tlpTc/OXHPtL659yvt2BX+BXne/uubUlJHGEoRQcbMQTDAT+4GiwprlA2rROiFaJl+bpzfznAylUYSNMGsNi0S5sKVeEh55aJopq2X+9Z7MBzU=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4982.namprd04.prod.outlook.com (52.135.233.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 27 Sep 2019 22:57:45 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2284.023; Fri, 27 Sep 2019
 22:57:45 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH v2 0/3] Add support for SBI v0.2
Thread-Topic: [PATCH v2 0/3] Add support for SBI v0.2
Thread-Index: AQHVdMfWU3eO8hvHu0yu+KSplvbFjqdAGZ+AgAAKwwA=
Date:   Fri, 27 Sep 2019 22:57:45 +0000
Message-ID: <8683f51f26708a468bcdf16a48db1cffac6c28d8.camel@wdc.com>
References: <20190927000915.31781-1-atish.patra@wdc.com>
         <20190927221913.GA4700@infradead.org>
In-Reply-To: <20190927221913.GA4700@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd4d8733-3b95-45a4-6d8b-08d7439e1c6c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB4982:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4982FF78DA195B915364E56BFA810@BYAPR04MB4982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(66066001)(76176011)(118296001)(6916009)(14454004)(25786009)(3846002)(66446008)(14444005)(256004)(71190400001)(71200400001)(66946007)(64756008)(66556008)(66476007)(2501003)(54906003)(316002)(86362001)(8936002)(6486002)(5660300002)(81156014)(8676002)(6436002)(5640700003)(81166006)(99286004)(6512007)(1730700003)(7416002)(6306002)(6246003)(6116002)(6506007)(478600001)(7736002)(36756003)(76116006)(26005)(2906002)(102836004)(446003)(11346002)(2616005)(486006)(186003)(4326008)(476003)(2351001)(305945005)(966005)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4982;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gAqdxopCLKayQMaxECeiLMOpIjnLrFQPH6WjaGKcYZMY6aOloMVEo7Umx6Bpe8n+nxli3d0EhL7eVdPjzx0vuzEAnGtrVGjP86V7DzD1PyGIMsic6q3htIUWvpGCOmKDFbrLp/f/Kvh2Z2GZBEvVGPtDefM6CBAn3BNFB3uPvDvIERGIdWxC9woffIcUFHnKXuI9xaaYY6HPWLyqakBV0ykn616DYQpKxEUjXvbpzp/uNVUPLoXu1tNt7D9hiY33GNcdUKsB7/efgMuSeoKzDngSEBnhtnbA4F+ihpKERX9FtBD+THBbemN3BXfcK19iWMlLbUuUULFSzxwqqIXMLkxMM2OKKNAtegvCyZN321pgMSvsHFckXmDvBSIPdeVrkfwrnuzYYdmwJNaODw/CXhArCBonu+kQnVBupuWc5plp/6EUV5mwMQOj3xa2kOgYOulxycvGYwVd6r43xGAHwQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAF98DD25B1D1241A065522E69662DD6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4d8733-3b95-45a4-6d8b-08d7439e1c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 22:57:45.5627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVq3MKLpZInMu908mR+gAJAnPnz1BxVfS4HJa7Ylnmkk2h/YESaI8afJN4bUYwv+Z2mx+c/seBlALGF2uY1Hug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4982
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTI3IGF0IDE1OjE5IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVGh1LCBTZXAgMjYsIDIwMTkgYXQgMDU6MDk6MTJQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gVGhlIFN1cGVydmlzb3IgQmluYXJ5IEludGVyZmFjZShTQkkpIHNwZWNp
ZmljYXRpb25bMV0gbm93IGRlZmluZXMgYQ0KPiA+IGJhc2UgZXh0ZW5zaW9uIHRoYXQgcHJvdmlk
ZXMgZXh0ZW5kYWJpbGl0eSB0byBhZGQgZnV0dXJlIGV4dGVuc2lvbnMNCj4gPiB3aGlsZSBtYWlu
dGFpbmluZyBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGggcHJldmlvdXMgdmVyc2lvbnMuDQo+
ID4gVGhlIG5ldyB2ZXJzaW9uIGlzIGRlZmluZWQgYXMgMC4yIGFuZCBvbGRlciB2ZXJzaW9uIGlz
IG1hcmtlZCBhcw0KPiA+IDAuMS4NCj4gPiANCj4gPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQg
djAuMiBhbmQgYSB1bmlmaWVkIGNhbGxpbmcgY29udmVudGlvbg0KPiA+IGltcGxlbWVudGF0aW9u
IGJldHdlZW4gMC4xIGFuZCAwLjIuIEl0IGFsc28gYWRkcyBtaW5pbWFsIFNCSQ0KPiA+IGZ1bmN0
aW9ucw0KPiA+IGZyb20gMC4yIGFzIHdlbGwgdG8ga2VlcCB0aGUgc2VyaWVzIGxlYW4uIA0KPiAN
Cj4gU28gYmVmb3JlIHdlIGRvIHRoaXMgZ2FtZSBjYW4gYmUgcGxlYXNlIG1ha2Ugc3VyZSB3ZSBo
YXZlIGEgY2xlYW4gMC4yDQo+IGVudmlyb25tZW50IHRoYXQgbmV2ZXIgdXNlcyB0aGUgbGVnYWN5
IGV4dGVuc2lvbnMgYXMgZGlzY3Vzc2VkDQo+IGJlZm9yZT8NCj4gV2l0aG91dCB0aGF0IGFsbCB0
aGlzIHdvcmsgaXMgcmF0aGVyIGZ1dGlsZS4NCj4gDQoNCkFzIHBlciBvdXIgZGlzY3Vzc2lvbiBv
ZmZsaW5lLCBoZXJlIGFyZSB0aGluZ3MgbmVlZCB0byBiZSBkb25lIHRvDQphY2hpZXZlIHRoYXQu
DQoNCjEuIFJlcGxhY2UgdGltZXIsIHNmZW5jZSBhbmQgaXBpIHdpdGggYmV0dGVyIGFsdGVybmF0
aXZlIEFQSXMNCgktIHNiaV9zZXRfdGltZXIgd2lsbCBiZSBzYW1lIGJ1dCB3aXRoIG5ldyBjYWxs
aW5nIGNvbnZlbnRpb24NCgktIHNlbmRfaXBpIGFuZCBzZmVuY2VfKiBhcGlzIGNhbiBiZSBtb2Rp
ZmllZCBpbiBzdWNoIGEgd2F5IHRoYXQNCgkJLSB3ZSBkb24ndCBoYXZlIHRvIHVzZSB1bnByaXZp
bGVnZWQgbG9hZCBhbnltb3JlDQoJCS0gTWFrZSBpdCBzY2FsYWJsZQ0KDQoyLiBEcm9wIGNsZWFy
X2lwaSwgY29uc29sZSwgYW5kIHNodXRkb3duIGluIDAuMi4NCg0KV2Ugd2lsbCBoYXZlIGEgbmV3
IGtlcm5lbCBjb25maWcgKExFR0FDWV9TQkkpIHRoYXQgY2FuIGJlIG1hbnVhbGx5DQplbmFibGVk
IGlmIG9sZGVyIGZpcm13YXJlIG5lZWQgdG8gYmUgdXNlZC4gQnkgZGVmYXVsdCwgTEVHQUNZX1NC
SSB3aWxsDQpiZSBkaXNhYmxlZCBhbmQga2VybmVsIHdpdGggbmV3IFNCSSB3aWxsIGJlIGJ1aWx0
LiBXZSB3aWxsIGhhdmUgdG8gc2V0DQphIGZsYWcgZGF5IGluIGEgeWVhciBvciBzbyB3aGVuIHdl
IGNhbiByZW1vdmUgdGhlIExFR0FDWV9TQkkNCmNvbXBsZXRlbHkuDQoNCkxldCB1cyBrbm93IGlm
IGl0IGlzIG5vdCBhbiBhY2NlcHRhYmxlIGFwcHJvYWNoIHRvIGFueWJvZHkuDQpJIHdpbGwgcG9z
dCBhIFJGQyBwYXRjaCB3aXRoIG5ldyBhbHRlcm5hdGUgdjAuMiBBUElzIHNvbWV0aW1lIG5leHQN
CndlZWsuDQoNCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJh
ZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1yaXNjdg0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
