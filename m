Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E24C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3273F21783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XPblI7ti";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PptUqPq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfJAIWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:22:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60081 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfJAIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569918161; x=1601454161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JqFKMRo8z8SsJPlNGMij5mgz+9iifWO8SeCfVSiinGw=;
  b=XPblI7tiB8R+4YfieDexGjiyBHmPpoAzcPezv2RBDvVicu7drLsVF31L
   QGRco1vtQ3QYeUPRDibc/Wn4DbneUuO4yuk4BJnQrZhMLQ73T4TJuRHHh
   kdE0fFTciMVmi3YNtebJV/+EnSFLwYtSk407BXqwEx+XXoX70hA7K50Qj
   5tRHfWQLCa4aWnm5RXDM9M5wFt5vxscBNFGMUM2OXTehJh6cg3myIIqxu
   2521GHlq/QOH0YGOMGRooGrrYcElbgrJo3WqOPA/6oZb/n8BsYehe9aZj
   agBvAMwJCiXufRBBkuaRAmz996AqEKItvta2LCX+ewDt0dVL0lsb3MlD1
   Q==;
IronPort-SDR: V5o77ktqqVLO0YUpy7whMHn5oinK/bfArSIUq2wBE9lWI02Ot7gGT4bMcGpX3PjbBOLO0L3gFB
 cRVuJeEqPf0BPUQnfqDhokdR463Vn9chYvKM5TwnxaWgLaeEUJJKgZcn33SVNpGuCiWf1vAHmd
 7JKSmBhZZB78y/AF+H5GqzhWvXKVlKiRugu9M9bJQDpZTFu01zXvF/obGWoR07JjW6kBVXLPv5
 4t8V4U8ji0Edj7+eqMfj6haJnlccuFmeqqu7U3yJXY3KgFKLjXflYK/urag6MGaPOlwT0EBpbH
 hsM=
X-IronPort-AV: E=Sophos;i="5.64,570,1559491200"; 
   d="scan'208";a="121090248"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2019 16:22:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmD8KqD2m11oAfoTSE/96MGYjmba2wSDQ39UMZHekfywwxc37p6pql4wlMC7c/9yHeMrBPP6kl2ZejsttTJqE3q1Nw4h2Sahp0aV7SJRRYuxxh4ir/PnYR7Lf/sZ2FuDr29GVy2vu/4hsvKgAzpQKriyFnVcpKjvciQhCSomZHfyabbAuBDIibRB1bNFkb8QtGp5K4Uer48fMYJj9iDAr0CVF4dfJ58OVXUgOiAxjbyqmLz7PKoZNMdm6QE+ImjrymadiR2Yy4fngWmL+FGEaRothQwi6ZrtcErKkGjkJRhTKKR/l8XN58LZCf1RAZj+qz5piDSiJ/CPCe1HPXLRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqFKMRo8z8SsJPlNGMij5mgz+9iifWO8SeCfVSiinGw=;
 b=dPPfwqWog46k8SY/nDGeHlxVzyob/lnyq+IPsv9PN7F29KFJh+NdYpQzJ/3ZosHZjdVM7IiOZs5MPARHOUkJCGuWfNYMllg8Q4hoc4SJtmRNM1YSlyGmAkBK0aT53fCQUx+00unBGfMl0d27Ef7xhrfxNpHW4WS1Lzx3befAvKGFZA09r6FSHYtgbJeMX2h4H7Wt2Inf0hgNZTjGCa6bqcd48Jo8argx69dOxcQKCxvFQ2CU1j8g4TEMADT4qqmGpFpOdtXeZKJYOpzK3pzc0+OAhpOR8bQwfMCZIxJFW9Hs36NCWUg80tEzHAfp7mOG/mTzbl0GCEcEoqei19exPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqFKMRo8z8SsJPlNGMij5mgz+9iifWO8SeCfVSiinGw=;
 b=PptUqPq7RpVAgrwIgrx0W+3VbApGShXphUOCuqX3OJt6ZgUxzsXbbBQsoW2Nh1p5TLfkV7jeqcJcmviz9J8u5N3Ef/ObXtgwJH1/xW+zdnJ11wN+M9i47jtUPmbn5RQlJ2AfvwdhLxh+nt/QitcLJTpOuhbevAMzC+tmgs6ZrL8=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5127.namprd04.prod.outlook.com (52.135.233.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Tue, 1 Oct 2019 08:22:37 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2305.022; Tue, 1 Oct 2019
 08:22:37 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Thread-Topic: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Thread-Index: AQHVd+597x5i5uf5J02UT+QA3h/uMqdFXIsAgAAWWgA=
Date:   Tue, 1 Oct 2019 08:22:37 +0000
Message-ID: <b0c39a9895698d74e2f44eb1f2faed46eee54bc3.camel@wdc.com>
References: <20191001002318.7515-1-atish.patra@wdc.com>
         <20191001070236.GA7622@infradead.org>
In-Reply-To: <20191001070236.GA7622@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73dd034f-a68c-4384-c33b-08d7464884d2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB5127:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5127E1B4351365C30C7740A7FA9D0@BYAPR04MB5127.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0177904E6B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(81156014)(6246003)(66946007)(966005)(8936002)(81166006)(1730700003)(6512007)(76176011)(46003)(54906003)(6306002)(7736002)(66556008)(76116006)(66446008)(64756008)(66476007)(71200400001)(2501003)(14454004)(71190400001)(316002)(478600001)(8676002)(25786009)(36756003)(86362001)(118296001)(5660300002)(476003)(2616005)(6916009)(11346002)(446003)(2351001)(5640700003)(99286004)(486006)(102836004)(6116002)(2906002)(4326008)(6436002)(186003)(305945005)(229853002)(6486002)(6506007)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5127;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ppi3aE0qpaWJAtidO0LABlMUtuJZzt5qW/Zh8nhZZinErmWAHB7E1eJLVOlgAsxRhWOxpTlIX1XbTnxdC8aF1Z+IrGvrrBbs5AN46ze5qlaEJin3LPBiVUppbwdLk06EMjmkiHrnXOiCKJ1UmlUUbvFXukTriC8prlAxfn7319bKGtbs2/JmQEhZNOoxAWygdyK2NiMzUyOiS4QSwoCk0GFYx9aTVV06Pj/v0AdwlNsnG9AIqB4IkSshM4+bRNI4JGmiMgsh9HMB/MtgN78DjiiNZ7GIVeZculzRl6ahIwlf4/USdWGQjAZTAopf1M6Y0wVbKhP+8i7m/wca+GVJDFho4b+4Wx4rAG8igHKyRjX2X6FvdiK2j0LnkXd68mLNFyov00YSrBwP0RFN4Jm/YycVfCSPxf7MqN0pfQCqXvS+aQGyf3llAQ2Q041tkueAGKmO05l1NZ9zU+AYwLt7iQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4411D8A6E974234D995AB4FE79E365FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd034f-a68c-4384-c33b-08d7464884d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2019 08:22:37.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92ol1izJnSSf5DLg4a4GsJRW67hBnCSgx7FuYvrOQhHn99LsdMNcRobM08MBD33tvRBbPiBBHl9UyJknWVGJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTAxIGF0IDAwOjAyIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gTW9uLCBTZXAgMzAsIDIwMTkgYXQgMDU6MjM6MThQTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gL3Byb2MvY3B1aW5mbyBzaG91bGQganVzdCBwcmludCBhbGwgdGhlIGlz
YSBzdHJpbmcgYXMgYW4NCj4gPiBpbmZvcm1hdGlvbg0KPiA+IGluc3RlYWQgb2YgZGV0ZXJtaW5p
bmcgd2hhdCBpcyBzdXBwb3J0ZWQgb3Igbm90LiBFTEYgaHdjYXAgY2FuIGJlDQo+ID4gdXNlZCBi
eSB0aGUgdXNlcnNwYWNlIHRvIGZpZ3VyZSBvdXQgdGhhdC4NCj4gPiANCj4gPiBTaW1wbGlmeSB0
aGUgaXNhIHN0cmluZyBwcmludGluZyBieSByZW1vdmluZyB0aGUgdW5zdXBwb3J0ZWQgaXNhDQo+
ID4gc3RyaW5nDQo+ID4gcHJpbnQgYW5kIGFsbCByZWxhdGVkIGNvZGUuDQo+ID4gDQo+ID4gVGhl
IHJlbGV2YW50IGRpc2N1c3Npb24gY2FuIGJlIGZvdW5kIGF0DQo+ID4gaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXJpc2N2LzIwMTktU2VwdGVtYmVyLzAwNjcwMi5o
dG1sDQo+IA0KPiBUaGlzIGxvb2tzIGdvb2QsIGJ1dCBjYW4geW91IGFsc28gcmVuYW1lIHRoZSBv
cmlnX2lzYSBhcmd1bWVudCB0byBpc2ENCj4gbm93IHRoYXQgd2UgbmV2ZXIgbW9kaWZ5IGl0Pw0K
PiANClN1cmUuIEkgd2lsbCBkbyB0aGF0Lg0KDQo+ID4gIAkvKg0KPiA+ICAJICogTGludXggZG9l
c24ndCBzdXBwb3J0IHJ2MzJlIG9yIHJ2MTI4aSwgYW5kIHdlIG9ubHkgc3VwcG9ydA0KPiA+IGJv
b3RpbmcNCj4gPiAgCSAqIGtlcm5lbHMgb24gaGFydHMgd2l0aCB0aGUgc2FtZSBJU0EgdGhhdCB0
aGUga2VybmVsIGlzDQo+ID4gY29tcGlsZWQgZm9yLg0KPiA+ICAJICovDQo+ID4gICNpZiBkZWZp
bmVkKENPTkZJR18zMkJJVCkNCj4gPiAtCWlmIChzdHJuY21wKGlzYSwgInJ2MzJpIiwgNSkgIT0g
MCkNCj4gPiArCWlmIChzdHJuY21wKG9yaWdfaXNhLCAicnYzMmkiLCA1KSAhPSAwKQ0KPiA+ICAJ
CXJldHVybjsNCj4gPiAgI2VsaWYgZGVmaW5lZChDT05GSUdfNjRCSVQpDQo+ID4gLQlpZiAoc3Ry
bmNtcChpc2EsICJydjY0aSIsIDUpICE9IDApDQo+ID4gKwlpZiAoc3RybmNtcChvcmlnX2lzYSwg
InJ2NjRpIiwgNSkgIT0gMCkNCj4gPiAgCQlyZXR1cm47DQo+ID4gICNlbmRpZg0KPiANCj4gQW5k
IEkgZG9uJ3QgdGhpbmsgaGF2aW5nIHRoZXNlIGNoZWNrcyBoZXJlIG1ha2VzIG11Y2ggc2Vuc2Uu
ICANCg0KQ29ycmVjdC4gQXMgd2UgYXJlIGR1bXBpbmcgdGhlIGlzYSBpbmZvcm1hdGlvbiBhcyBp
dCBpcywgd2Ugc2hvdWxkIGdldA0KcmlkIG9mIHRoZXNlIGNoZWNrcyBhcyB3ZWxsLg0KDQo+IElm
IHdlIHdhbnQNCj4gdG8gY2hlY2sgdGhpcyBhdCBhbGwgd2Ugc2hvdWxkIGRvIGl0IHNvbWV3aGVy
ZSBpbiB0aGUgYm9vdCBwcm9jZXNzLg0KDQpyaXNjdl9vZl9wcm9jZXNzb3JfaGFydGlkKCkgb3Ig
c2VlbXMgdG8gYmUgYSBiZXR0ZXIgY2FuZGlkYXRlLiBXZQ0KYWxyZWFkeSBjaGVjayBpZiAicnYi
IGlzIHByZXNlbnQgaW4gaXNhIHN0cmluZyBvciBub3QuIEkgd2lsbCBleHRlbmQNCnRoYXQgdG8g
Y2hlY2sgZm9yIHJ2NjRpIG9yIHJ2MzJpLiBJcyB0aGF0IG9rYXkgPw0KDQotLSANClJlZ2FyZHMs
DQpBdGlzaA0K
