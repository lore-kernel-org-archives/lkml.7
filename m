Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D375C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A4123777
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IoMmmrjf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kA2qpTiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfHTImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:42:24 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1965 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTImY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566290563; x=1597826563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9/+TwHj058yOzTfd6bqpGLe2KllYeZCcKrNBUVp78Tc=;
  b=IoMmmrjf1miCy5Q9K7rNmi6KC0rvjfWjJNoYw6Sk8DHiV5N1kVWpf13z
   ctu7ogq0v8+5DY/Phbr5De4Y/OJwczlx+T4XPvpwTyz8ukGi9muO20fBp
   flfda3w7YrG72N5VdHbiEpf4UVZEIcu5XKYA+G4alNs25p5xWZ+FFn6mU
   km+VMGwl0yPxS2VpsGfKLANB2xpMOz57o8LJI6q+JXAAdS7cfBlFbv2Nb
   Fxnkm6SsDO7RDtg0EnomG9GI5B+ba++dwggx4rATn04Z/Fz1McgjYomqZ
   ofC82T44hTxInXwzlRXkc6SA2q+IlTw/U6pCgLxv3gAtI96Ho2Iquh11Z
   A==;
IronPort-SDR: j7PuodBqey8iNAqsic7j4QYmxJ3e4riQwSRxfFs5Xj/BHJLrZjsp1p8xPPcK6ipyOMDgWVuu9l
 3guqk67ouKdKsmJyPVkNScuVL8Hm3a8PdW6WL/WRADL8paJLb5uHfl33Zf7IsTk0XyQdRbJoyc
 KUn9Bp1XBGJ4cqVbzrHZzHXB6W1hbaLFoq9gcrqWEk8649szmA4bQkaDo2ZagF2SY7d5VlcmQm
 JKVYMgA/7cRQHbwnrI5s1M7SLr5zykllAsWVYaTzZVOMZrE0fuL8ypbwVQa5KIIAh9UpD5kKXL
 FY4=
X-IronPort-AV: E=Sophos;i="5.64,408,1559491200"; 
   d="scan'208";a="216619242"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 16:42:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQlFFDFqCttV1Jdz4Qbtn3AZIPdjJwQL4dG204QPmhxVczbS+dNdzwS7k7Ov/w2uWPNRNYP3h0LjNGpsXUyAvtxG1TrtSMxHiohuvnsP8U9/89fbL7rnEEO5XyOQ7SoHcI5UTUkY2XBImeOTZk1/jobbXNU4AWSCW4WmBnvZvD3BWYKul1RCoU8wOOVYdEAqyviwjb9sYWHSDUbD6TA6rejDOt1sk5bWywgZKA/7kEZahg5g6UHVduehrzsFzaySzEFtuWdlSXR/usPquBAOGMA0TfXnfUkJwMZKwuYD7DZz7JGrLv4C/B+zRHTPTp9S2IOu4iheHaN+zaoyJIJ44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/+TwHj058yOzTfd6bqpGLe2KllYeZCcKrNBUVp78Tc=;
 b=Vn8bpEGI0mBGZbMeY+Y9kjG6LCfKrKvbfBG4+H47wGN+Mo6NCRu4zVYyLxVTwWy4z6Pz0xmSkMPDhxugJzlRxy8IlXHdgERmaRfFbklVOB8hf+2N69zU95jczbXZDFcERDla6stTUuRqmSqhrL4QGBUsjy7gGxvxwA5uHeZY6vyvhe/D1qiK+wmwqya4YNRJoSryg58VcAUVylKZH6S6UF+6l077WYx2u7F9iJPkJSEsKykla3hsWLdsam1BM58t/bEICu6QEdX9QEM6sbKGYzMOAaJLd7IiOQtT3SMCAaay0J+3q3dSlr6OYUZxrKyVkzie9VPaRU1jhdFOasBDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/+TwHj058yOzTfd6bqpGLe2KllYeZCcKrNBUVp78Tc=;
 b=kA2qpTiM2786XMH3wgbH8ufOyYX54gu5RjEs5T0wDmCeqEKP5rpg3tPXV1rLhBA3Y5huOMKgkdzLJmu0NArsEQqOspZ2TvztB9v7a/64Dndb0rbozTwBH6hbS2U4nHwQ1LOLf8FnLEtzlKANyIgZiD086R1wZZwRixdqnmxG0Yw=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4741.namprd04.prod.outlook.com (52.135.240.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 08:42:19 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 08:42:19 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "schwab@linux-m68k.org" <schwab@linux-m68k.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Topic: [v2 PATCH] RISC-V: Optimize tlb flush path.
Thread-Index: AQHVVvDfUBJCIAOoL0y7jXfLdcYugacDqN07gAAPmgA=
Date:   Tue, 20 Aug 2019 08:42:19 +0000
Message-ID: <b2510462b55ffd93dba0c1b7cc28f9eef3089b50.camel@wdc.com>
References: <20190820004735.18518-1-atish.patra@wdc.com>
         <mvmh86cl1o3.fsf@linux-m68k.org>
In-Reply-To: <mvmh86cl1o3.fsf@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34d8a53e-2485-4ec9-7b28-08d7254a5018
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4741;
x-ms-traffictypediagnostic: BYAPR04MB4741:
x-microsoft-antispam-prvs: <BYAPR04MB47416253685AB77160E064C5FAAB0@BYAPR04MB4741.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(14454004)(6916009)(478600001)(4326008)(6246003)(229853002)(6436002)(7736002)(5640700003)(1730700003)(53936002)(66446008)(76116006)(14444005)(66476007)(64756008)(6486002)(81166006)(6116002)(8676002)(2906002)(256004)(66556008)(66946007)(76176011)(36756003)(25786009)(54906003)(316002)(71200400001)(71190400001)(2501003)(99286004)(6512007)(486006)(81156014)(186003)(2616005)(6506007)(476003)(305945005)(46003)(446003)(8936002)(11346002)(102836004)(5660300002)(2351001)(118296001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4741;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b0c7Ak1u9Fe98fG9DPiQ9pmVbdRUDCL235wsFriQ4qrutif/AnRED2n3gv8bD7ecT+uy123bhFrDihR2GGNtGtmbZljsrQi8WdEzfUSutDsTHDevKJhodJJFERzOkDcB/93xcl51Ru6yKPLMsFhK/2HswCyVM9VKWq96GRo74S9NbQpxXi+Uvw0DRuiBNp/6BtOc9q0UKGqO+fmjoOqf2dTEANOAfw286cHVuFvRU/z9mauzMh1inrL+M/+xoLg4u3n9QlwXFFZzELk7BGs0wt548as9/ioRLqqSXxH1D1K4thzlERUTQ7wCq1sFXSOS43A64+oZkK4WuZjjVx1LVJquOsaL17MUS063c6fxKlGkyzeWp3E+VkB7Bow2Iqh9zcijFfpHiPJMQ6ABa8e/Merb/A7Fgx8BVs32TVQkyFk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <392A880A5F7B66498DB7D6269537B457@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d8a53e-2485-4ec9-7b28-08d7254a5018
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 08:42:19.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mI+GuCd9YbRcXfi9nJvKKR9nbgjwOVOzsGo5+X4mQ/3r79yq+7BGFp7VUs2KDu+DAKrxTrYLFs3p5DqogM6uqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDA5OjQ2ICswMjAwLCBBbmRyZWFzIFNjaHdhYiB3cm90ZToN
Cj4gT24gQXVnIDE5IDIwMTksIEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPiB3cm90
ZToNCj4gDQo+ID4gQEAgLTQyLDIwICs0Myw0NCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZmx1c2hf
dGxiX3JhbmdlKHN0cnVjdA0KPiA+IHZtX2FyZWFfc3RydWN0ICp2bWEsDQo+ID4gIA0KPiA+ICAj
aW5jbHVkZSA8YXNtL3NiaS5oPg0KPiA+ICANCj4gPiAtc3RhdGljIGlubGluZSB2b2lkIHJlbW90
ZV9zZmVuY2Vfdm1hKHN0cnVjdCBjcHVtYXNrICpjbWFzaywNCj4gPiB1bnNpZ25lZCBsb25nIHN0
YXJ0LA0KPiA+IC0JCQkJICAgICB1bnNpZ25lZCBsb25nIHNpemUpDQo+ID4gK3N0YXRpYyB2b2lk
IF9fcmlzY3ZfZmx1c2hfdGxiKHN0cnVjdCBjcHVtYXNrICpjbWFzaywgdW5zaWduZWQgbG9uZw0K
PiA+IHN0YXJ0LA0KPiA+ICsJCQkgICAgICB1bnNpZ25lZCBsb25nIHNpemUpDQo+IA0KPiBjbWFz
ayBjYW4gYmUgY29uc3QuDQo+IA0KDQpTdXJlLiBXaWxsIHVwZGF0ZSBpdC4NCg0KPiA+ICB7DQo+
ID4gIAlzdHJ1Y3QgY3B1bWFzayBobWFzazsNCj4gPiArCXVuc2lnbmVkIGludCBoYXJ0aWQ7DQo+
ID4gKwl1bnNpZ25lZCBpbnQgY3B1aWQ7DQo+ID4gIA0KPiA+ICAJY3B1bWFza19jbGVhcigmaG1h
c2spOw0KPiA+ICsNCj4gPiArCWlmICghY21hc2spIHsNCj4gPiArCQlyaXNjdl9jcHVpZF90b19o
YXJ0aWRfbWFzayhjcHVfb25saW5lX21hc2ssICZobWFzayk7DQo+ID4gKwkJZ290byBpc3N1ZV9z
ZmVuY2U7DQo+ID4gKwl9DQo+IA0KPiBXb3VsZG4ndCBpdCBtYWtlIHNlbnNlIHRvIGZhbGwgdGhy
b3VnaCB0byBkb2luZyBhIGxvY2FsIGZsdXNoIGhlcmU/DQo+IA0KPiAJaWYgKCFjbWFzaykNCj4g
CQljbWFzayA9IGNwdV9vbmxpbmVfbWFzazsNCj4gDQoNCmNtYXNrIE5VTEwgaXMgcHJldHR5IGNv
bW1vbiBjYXNlIGFuZCB3ZSB3b3VsZCAgYmUgdW5uZWNlc3NhcmlseQ0KZXhlY3V0aW5nIGJ1bmNo
IG9mIGluc3RydWN0aW9ucyBldmVyeXRpbWUgd2hpbGUgbm90IHNhdmluZyBtdWNoLiBLZXJuZWwN
CnN0aWxsIGhhdmUgdG8gbWFrZSBhbiBTQkkgY2FsbCBhbmQgT3BlblNCSSBpcyBkb2luZyBhIGxv
Y2FsIGZsdXNoDQphbnl3YXlzLg0KDQpMb29raW5nIGF0IHRoZSBjb2RlIGFnYWluLCBJIHRoaW5r
IHdlIGNhbiBqdXN0IHVzZSBjcHVtYXNrX3dlaWdodCBhbmQNCmRvIGxvY2FsIHRsYiBmbHVzaCBv
bmx5IGlmIGxvY2FsIGNwdSBpcyB0aGUgb25seSBjcHUgcHJlc2VudC4gDQoNCk90aGVyd2lzZSwg
aXQgd2lsbCBqdXN0IGZhbGwgdGhyb3VnaCBhbmQgY2FsbCBzYmlfcmVtb3RlX3NmZW5jZV92bWEo
KS4NCg0KLi4uLg0KLi4uLg0KKw0KKyAgICAgICBjcHVpZCA9IGdldF9jcHUoKTsNCisJaWYgKCFj
bWFzaykgew0KKyAgICAgICAgICAgICAgIHJpc2N2X2NwdWlkX3RvX2hhcnRpZF9tYXNrKGNwdV9v
bmxpbmVfbWFzaywgJmhtYXNrKTsNCisgICAgICAgICAgICAgICBnb3RvIGlzc3VlX3NmZW5jZTsN
CisgICAgICAgfQ0KKw0KKyAgICAgICANCisgICAgICAgaWYgKGNwdW1hc2tfdGVzdF9jcHUoY3B1
aWQsIGNtYXNrKSAmJiBjcHVtYXNrX3dlaWdodChjbWFzaykgPT0NCjEpIHsNCisgICAgICAgICAg
ICAgICAvKiBTYXZlIHRyYXAgY29zdCBieSBpc3N1aW5nIGEgbG9jYWwgdGxiIGZsdXNoIGhlcmUg
Ki8NCisgICAgICAgICAgICAgICBpZiAoKHN0YXJ0ID09IDAgJiYgc2l6ZSA9PSAtMSkgfHwgKHNp
emUgPiBQQUdFX1NJWkUpKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgbG9jYWxfZmx1c2hfdGxi
X2FsbCgpOw0KKyAgICAgICAgICAgICAgIGVsc2UgaWYgKHNpemUgPT0gUEFHRV9TSVpFKQ0KKyAg
ICAgICAgICAgICAgICAgICAgICAgbG9jYWxfZmx1c2hfdGxiX3BhZ2Uoc3RhcnQpOw0KKyAgICAg
ICAgICAgICAgIGdvdG8gZG9uZTsNCisgICAgICAgfQ0KKw0KICAgICAgICByaXNjdl9jcHVpZF90
b19oYXJ0aWRfbWFzayhjbWFzaywgJmhtYXNrKTsNCisNCitpc3N1ZV9zZmVuY2U6DQogICAgICAg
IHNiaV9yZW1vdGVfc2ZlbmNlX3ZtYShobWFzay5iaXRzLCBzdGFydCwgc2l6ZSk7DQorZG9uZToN
CisgICAgICAgcHV0X2NwdSgpOw0KIH0NCg0KVGhpcyBpcyBtdWNoIHNpbXBsZXIgdGhhbiB3aGF0
IEkgaGFkIGRvbmUgaW4gdjIuIEkgd2lsbCBhZGRyZXNzIHRoZSBpZg0KY29uZGl0aW9uIGFyb3Vu
ZCBzaXplIGFzIHdlbGwuDQoNClJlZ2FyZHMsDQpBdGlzaA0KPiBBbmRyZWFzLg0KPiANCg0K
