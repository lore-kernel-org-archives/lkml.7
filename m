Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E195C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A32522CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NRzrRHdW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Eej2rG7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfHTACj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:02:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14556 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHTACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566259379; x=1597795379;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TZcS0nUDea+a+6+7Jh2sz6QMkoZG7u5VUqBE5oDjUHU=;
  b=NRzrRHdWBAQkqaBedulOCHZzijTyIcmoTWNMrJuc7745SNmrNLdPzm8V
   1YXcCbx8wh49z6KBZu84vFn/LwQEtk2133nNYzUkjrnfFg6Lu2Sl5ahL/
   fRRxhGsqjCSl/vkFjhUaBYZu9MO5Q6/8HSwjh3xtVfdsPEn7UCGOtjlWQ
   TvvBgdjcjqCjfd0G700MnVd3xcE7ZE1rBRqYmRGWcCU3yZKANDEfee66k
   dsAdeeWCXLoY9V6ZRZe05Trb4asha4YTc0fVlRi4xI10P0Zbw07d7USzW
   dEAqWwaEEdMiyfJYAPQJmCkjAddZF8I1GxCCD7z8bYJNsZlMe9Kjdi+RD
   w==;
IronPort-SDR: tsilV5LZVSkHckYgV3A2CZs5kOuEs4e2TpN0loKjJZnk5biBP0jtyzVRq/oh1pRhlmnRAjZQAZ
 B/55VRbNKWCxM3JdKOvGJiZS1FKVyGm+qa5EDegCQvNty1Os9x79O6lKFRnmBuDAt5I8o5NaiX
 OEsIpyc+rhxCEVC2W/+FUKA/kCWhKBBSTDU34grE9EXhB5LegWGgwAIh/Eb1IqPG83l239RdWC
 I1YbocLA/wW8W4mq+99mf8OEv1XrJPNFm1l9UdD33tmLmkKwHZWW1gamdSh4PjEWvRt1nRwK2M
 oa4=
X-IronPort-AV: E=Sophos;i="5.64,406,1559491200"; 
   d="scan'208";a="216586457"
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 08:02:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA5AThGxHDdCUCqEGg6lS3OX0+miyEgC1dwThR6uKlXNvzmMLx8JPjiBcJog+fjSOjxdEgJF2D7OGVRxDpWGh8L1lTkjB8sTzn8Pgce+8UxnvyH4315RSkpteygEp8oTDr7qYGJIHauVI7e79aVz8Kd/7XHOvTJhOdvM6cFquvssVRcLAoYr79AVewPMwUbVNc31MT5O4Mv5SAPoWK3eLOf+b+ASL+a3I/lLd/DGKIJ1gMvH3OyG68XChFYHZchYAQTS55hDCP3Q7R/QYP2It3tVgW6/ww1YniS8XP42xVk9P9qgRJJHtgd9hikUHc3lwrnsH6bRSr0fnP02UWmPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZcS0nUDea+a+6+7Jh2sz6QMkoZG7u5VUqBE5oDjUHU=;
 b=Uiiu0azmra/rDnbWWQb7RWDqplzYBAitqK3anA6Pd/CTttOTXBChTCH75M7x3a8IBQXEDZueO3vCv79R6ZO0xQUgsn7ygi35wCyQTNU4IumPN2BpVprTkm74p0KEkeFp5/6O58sr4oHJ+UFPjz+VIsa6GQ/ztTSwqel7B5ePcZmq2hGlVeamJjTUvEIyTxJeYSELLDihsVmp90Ingxlq+RdFc0A23dmwoyJuqhd8QlWclrk3BOm4Fb777bCxQIVW/v4hXBh3Kn6zwMNqT1eyhT6XGvUAfAtVwfcwEt9ngutwlBYqUtSvjndetg8FZ+bwjGb48Y6rBaiRXjHvINJ6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZcS0nUDea+a+6+7Jh2sz6QMkoZG7u5VUqBE5oDjUHU=;
 b=Eej2rG7k0GHND6uYDYN8y8z8FzXmNSDeYA84/ousyNzzbTkGx419OaxfBTZ9P1TanKvc6n0EhwKiS90h3d8DWR0mSFoc1GZ8LFmE56gezY/ExsPQaTDeWVeuOHuHofN7uw32VJrAbkuKPMV0eLkE1Mc57KO/x66L72Kcl4O9wBg=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4711.namprd04.prod.outlook.com (52.135.240.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 00:02:31 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 00:02:31 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKb3ngaAgACcGwCAAO7ygIADixaAgAXnX4CAAAZPAIAAAFqAgACUswA=
Date:   Tue, 20 Aug 2019 00:02:31 +0000
Message-ID: <797e3d1cd06dfc98cca0b595a738d297e9e858be.camel@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
         <20190812145631.GC26897@infradead.org>
         <f58814e156b918531f058acfac944abef34f5fb1.camel@wdc.com>
         <20190813143027.GA31668@infradead.org>
         <3f55d5878044129a3cbb72b13b712e9a1c218dc7.camel@wdc.com>
         <20190819144627.GA27061@infradead.org>
         <CAAhSdy3KLCW540mLVk4F6nAqYP2dYuiGqO4FuwTD1Hra_gHcGg@mail.gmail.com>
         <20190819151015.GA3316@infradead.org>
In-Reply-To: <20190819151015.GA3316@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d97cf9f6-fa81-4282-b956-08d72501b255
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4711;
x-ms-traffictypediagnostic: BYAPR04MB4711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB471163090DB1C19B6793BC62FAAB0@BYAPR04MB4711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(110136005)(478600001)(3846002)(6116002)(54906003)(76116006)(4326008)(5660300002)(66946007)(66556008)(66066001)(66476007)(66446008)(25786009)(102836004)(118296001)(6512007)(53936002)(64756008)(6246003)(2906002)(14454004)(316002)(7416002)(71190400001)(99286004)(2616005)(2501003)(305945005)(486006)(476003)(8676002)(8936002)(229853002)(11346002)(446003)(256004)(81156014)(6436002)(81166006)(7736002)(26005)(186003)(86362001)(6506007)(6486002)(36756003)(71200400001)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4711;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: afvscNeV9o9pBfQac2G65nVCzlZideJ+auUNW8RyMtmJ0T15DV/7Am7kQH/1vW0oZGq4iQGK8AegGvyHtb3WZRDY1jf0cZ6L8YhqdnNQ/8PCrip3PvD4n7wpUr7oxbJzyfVZBw0Ks331hh2U+9ynhUavD40iGIG4eZkiog45eTcTus7BMZFK/ThwNBXSzhOp6fmIftiMkOvYqhSDWZfed2TPHPsO8KFrZySFYvhp3hwEBQjVg/X9FEWYCmnMdnn/m6KOfQYLOFEvypKYvPPvQQwhN1t4PopozGBo/1qIagzxO+n2Ec/h7Vsbza7oQgrqXgbjBSC87vdWWs/QqWH+YDRBff60GJmjDCG/D1l3ky+U5Sjf4JVcIKxsr8iVWsdXAUr8DjjUBMcnnySHPqRUu3sGlvl2uWxWA6diOJyw6Eo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <555FADDD74BB684F9EA1BCB6B3332D5E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97cf9f6-fa81-4282-b956-08d72501b255
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 00:02:31.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAS7NPfeCzDyOvGsk0wIALTmynx1fZ5+UGOlGVAijDq6bcyJ/tjgfMS2zP1ovi4gXisxeHHuIDFtvPUCnvahoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDA4OjEwIC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gTW9uLCBBdWcgMTksIDIwMTkgYXQgMDg6Mzk6MDJQTSArMDUzMCwgQW51cCBQYXRl
bCB3cm90ZToNCj4gPiBJZiB3ZSB3ZXJlIHVzaW5nIEFTSUQgdGhlbiB5ZXMgd2UgZG9uJ3QgbmVl
ZCB0byBmbHVzaCBhbnl0aGluZw0KPiA+IGJ1dCBjdXJyZW50bHkgd2UgZG9uJ3QgdXNlIEFTSUQg
ZHVlIHRvIGxhY2sgb2YgSFcgc3VwcG9ydCBhbmQNCj4gPiBIVyBjYW4gY2VydGFpbmx5IGRvIHNw
ZWN1bGF0aXZlbHkgcGFnZSB0YWJsZSB3YWxrcyBzbyBmbHVzaGluZw0KPiA+IGxvY2FsIFRMQiB3
aGVuIE1NIG1hc2sgaXMgZW1wdHkgbWlnaHQgaGVscC4NCj4gPiANCj4gPiBUaGlzIGp1c3QgbXkg
dGhlb3J5IGFuZCB3ZSBuZWVkIHRvIHN0cmVzcyB0ZXN0IG1vcmUuDQo+IA0KPiBXZWxsLCB3aGVu
IHdlIGNvbnRleHQgc3dpdGNoIGF3YXkgZnJvbSBhIG1tIHdlIGFsd2F5cyBmbHVzaCB0aGUNCj4g
bG9jYWwgdGxiLiAgU28gZWl0aGVyIHRoZSBtbV9zdHJ1Y3QgaGFzIG5ldmVyIGJlZW4gc2NoZWR1
bGVkIGluLA0KDQpMb29raW5nIGF0IHRoZSBzdGFjayBkdW1wLCBpdCBsb29rcyBsaWtlIHRoaXMg
aXMgdGhlIGNhc2UuIGNwdW1hc2sgaXMNCmVtcHR5IHBvc3NpYmx5IGFmdGVyIGEgZm9yay9leGVj
IHNpdHVhdGlvbiB3aGVyZSBmb3JrZWQgY2hpbGQgaXMgYmVpbmcNCnJlcGxhY2VkIHdpdGggYWN0
dWFsIHByb2dyYW0gdGhhdCBpcyBhYm91dCB0byBydW4uDQoNCkkgYWxzbyBsb29rZWQgYXQgeDg2
ICYgcG93ZXJwYyBpbXBsZW1lbnRhdGlvbiB3aGljaCBkb2Vzbid0IHNlZW0gdG8gZG8NCmFueXRo
aW5nIHNwZWNpYWwgaWYgY3B1bWFzayBpcyBlbXB0eS4NCg0KSSB3aWxsIHNlbmQgYSB2MiB3aXRo
IG5vIHRsYiBmbHVzaGluZyBpZiBjcHVtYXNrIGlzIGVtcHR5Lg0KDQo+IG9yIHdlIGFscmFkeSBk
aWQgYSBsb2NhbF90bGJfZmx1c2ggYW5kIHdlIGNvbnRleHQgc3dpdGNoZWQgaXQgdXAuDQoNCg0K
UmVnYXJkcywNCkF0aXNoDQo=
