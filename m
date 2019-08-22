Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A46206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eZ6E8Yhl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YvWu6dwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbfHVSbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:31:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5975 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbfHVSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566498697; x=1598034697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Jk2c7yUIuhxgQsOiX5/4Y8fqlVy2ksI6oH8D72P9rE=;
  b=eZ6E8YhlU0lHNpGXbOF5IR0MHydCvoZVivgqs6G2RAiYkLGTjQIjs0Z9
   1KFZvW8/bMgqxe/OAccevALQLNO3SkqU29tIHPBCB2q7CC91ecFWoiWmE
   koKdBMjDawomyiH437ahtyrPBJC9wTkl/H9jn3A+prn4rpLA7AEcV8sb0
   Q+/g4uNroooT67zVTNaTPIFp4xnuy2DB+fwQu1yz5kaE55/P+pdLF5MKd
   VKjnYw0cTndP2CjO7mq9S/pNrzzCbSY2zyRQm3/GjW2xnuSk171AC2e2A
   ORLdQw2qb5j2pnWIFpN3uh9tlI4t+ktdgrwvCSlSueAFRKn2sPanrmBLn
   w==;
IronPort-SDR: LQQyNtp5cOjfFGY5t+91RK1VvXKDcpFmZNa1Kt8YQLJ3x+XM9qNXZDIxSJ+QXPNg0yghP8huKA
 xK5CFmWucyPKfGsxHcUB5ZTpY+6y/18gtaPX54qXhVWrNlMCMn8PMh+B+HqIsLTeTO1FX5RgVG
 v3koeURmA3xrPhKcoEwygjcxYxptkxMmWcrai+icdRS42pXcIpEgGTGUftpK5Us/yzp6DkEbWx
 Qh/qgj+gM4mbeNZzaU0qoO2q8Ll7xHVXxIXUBOdHAroq0ydFmjKM0Cd6NkC4NUDak9744gcV3S
 acI=
X-IronPort-AV: E=Sophos;i="5.64,417,1559491200"; 
   d="scan'208";a="117378618"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 02:31:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC04pYJp2VCsNneJIC/iUgL4TGhMAycCmcVQxMwK0mjb9HFXuZeFuVkcIIZ+4ng6ifuJ7eERJu6VwE9ilUTcgxPkCwUI1n1kyZp7KedmCWb95r8snBJFWSRzcjoCy/UKPHN6xyGWuon3Nsb3KFkUN5zkFJhCsDCiisK8F+qdjP2DHei795SVA9XHpFM8kng4bKadHglrp6Hoid/fVOYRb0T4EBZHaCWqRz3wzb8jUdonmlsEgEa6z/pJ/A8dCxSqGpg31VWIJMIWNHpSeje2Anfm+3Yc1/RMRYDdKAR9ITvkf4GxzSdbmD7DrACyfn6ZUeDeHEJDufNGsmA7H0JlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jk2c7yUIuhxgQsOiX5/4Y8fqlVy2ksI6oH8D72P9rE=;
 b=FmHOvmIESv5x/7m89kKqmC4p47YXcYnyMV+/eFb9lRosBHlRi/B9lBkqHQlO/mOUg6No/NJnhBRLkX4HLVwb4f7jNmBeIoxHdZIWjsSDtO5HB0sPMXnkDFBEi9FaVGZBdyUNSiMQG85/1XKZowtJpbppDIiB4BCSKW20pzUTBztXdjeSaPmQtZQmcsanePGmZ5UDCfpEC/k4uH3lLzfA1aI1PBT7Pv9LkLVUGN2ul0taCr8vOj6QvppUZqPr8m2PpxwMB+r2Mz72MFvq+MDeaFIO7JUA571CFk34dzT3NWjL+4nMJBQlgXBjeLdmqQDwM1WZexYKO/CysnNNWeaVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jk2c7yUIuhxgQsOiX5/4Y8fqlVy2ksI6oH8D72P9rE=;
 b=YvWu6dwZ1McuZh0rUQsGZAcElcAf5hazwU0Yso2yCevBlYR6/SLUH+LZWS39x0o47ZV7NurGBBVB4SYd7g/6aSpuBOXSW32u+hv7uJFz5CKsrgD60sOaa/6DN1fE0TaFNryS+TPpl530XHDAIiAJGp5tsG5K9zPfyyHBBtj3y0Q=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5896.namprd04.prod.outlook.com (20.179.59.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 18:31:29 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 18:31:29 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 3/3] RISC-V: Issue a tlb page flush if possible
Thread-Topic: [PATCH v4 3/3] RISC-V: Issue a tlb page flush if possible
Thread-Index: AQHVWL95e6LZrQt6lE6f3WVrn/k0WqcG0QSAgACtHAA=
Date:   Thu, 22 Aug 2019 18:31:29 +0000
Message-ID: <ab8e3417e7949390ce256fc4afb5d6e82e4f91da.camel@wdc.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
         <20190822075151.24838-4-atish.patra@wdc.com>
         <20190822081153.GC17573@lst.de>
In-Reply-To: <20190822081153.GC17573@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aac10f71-62bf-4031-593d-08d7272ef2e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5896;
x-ms-traffictypediagnostic: BYAPR04MB5896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58964DE80B3D48F67EDFDDE1FAA50@BYAPR04MB5896.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(51914003)(199004)(189003)(51444003)(6246003)(76176011)(2501003)(25786009)(6916009)(6116002)(7736002)(4326008)(86362001)(53936002)(4744005)(6506007)(229853002)(8936002)(6436002)(66946007)(6486002)(5640700003)(478600001)(71200400001)(71190400001)(2351001)(81166006)(76116006)(2906002)(66476007)(66556008)(81156014)(305945005)(118296001)(1730700003)(66446008)(5660300002)(54906003)(46003)(14454004)(6512007)(102836004)(446003)(486006)(99286004)(186003)(14444005)(2616005)(64756008)(316002)(36756003)(11346002)(476003)(66574012)(256004)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5896;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3WcSdkPW652FHwl64/VtpB+Ac9Jg7YyyjipQxCi2kUKOXGH426zUUwoK+hMSZJegvBNqBjQWLji1TuY3W54/0Vwlp8RdZQQH5aQBFNDtudzC3aYTVvkplGCsN8x6BR46Qf8w0XfKQwaUyX8g23KElZUK+mOl0inptQk551G74sXcVwatRzmpYkXag7gPY2tJT96TErm7YRrZ8AQVM5LhhemXTAdRp41Dy5h+wZgM+Mjhf2dEs8VofDAIIq7zoSzoT6JOz9dCsQ8O3j3MMlSGvOA/1rDN1ByBc8KO6gBDSnpho3RFM5BDSWBIWTqzFRQlZm/tlO+lA+wBxUQu9fWiNcc5O8LKxCEgIefSRwfb57wSl0V0yDWN2fXFBnS2oDIkgn1KKZhRrQJR+dcUxQMO8QxGh5IvBXTAzne+57CQ13Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8695B9941D48D4DB50C08E0C3B3715F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac10f71-62bf-4031-593d-08d7272ef2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 18:31:29.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ai+Dli4t/JVNsnwmMa6X61LzgXFbn0/biI5aO2JMnSmZoSeYygrpykwnO/QznneZ8iEs0ILn/FkwupsHLbZhMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5896
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDEwOjExICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVGh1LCBBdWcgMjIsIDIwMTkgYXQgMTI6NTE6NTFBTSAtMDcwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gSWYgdGxiZmx1c2ggcmVxdWVzdCBpcyBmb3IgcGFnZSBvbmx5LCB0aGVy
ZSBpcyBubyBuZWVkIHRvIGRvIGENCj4gPiBjb21wbGV0ZSBsb2NhbCB0bGIgc2hvb3Rkb3duLg0K
PiA+IA0KPiA+IEp1c3QgZG8gYSBsb2NhbCB0bGIgZmx1c2ggZm9yIHRoZSBnaXZlbiBhZGRyZXNz
Lg0KPiANCj4gTG9va3MgZ29vZCwgYWx0aG91Z2ggSSBzdXNwZWN0IGluIG1hbnkgY2FzZXMgZXZl
biBkb2luZyBtdWx0aXBsZQ0KPiBzaW5nbGUtcGFnZSBzZmVuY2Uudm1hIGNhbGxzIG1pZ2h0IGJl
IGNoZWFwZXIgdGhhbiB0aGUgZ2xvYmFsIG9uZS4NCj4gDQo+IEJ1dCBJIHRoaW5rIHRoYXQgaXMg
d29ydGggYSDRlWVwYXJhdGUgZGlzY3Vzc2lvbiwgcHJlZmVyYWJseSB3aXRoDQo+IGFjdHVhbA0K
PiBudW1iZXJzLg0KPiANCg0KWXVwLiBGaW5kaW5nIGEgZ29vZCB0aHJlYXNob2xkIGlzIGFsd2F5
cyB0cmlja3kgd2l0aG91dCByZWFsDQpiZW5jaG1hcmtzLg0KDQo+IFJldmlld2VkLWJ5OiBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQot
LSANClJlZ2FyZHMsDQpBdGlzaA0K
