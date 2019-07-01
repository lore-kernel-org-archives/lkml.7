Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E504C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C332173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Al/aLvhu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fUaChbDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGAUSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:18:48 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62971 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGAUSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562012336; x=1593548336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=N8FdXl9fQhVeMl/osm7KAlS6gPFgaAA9xTyaCj4BAvw=;
  b=Al/aLvhu2cAJL5K8inDZD4SalS6MM7y6fankehpwkJF8Y2NBkUEGoKT/
   TAOLCCOjrl+OrV1xlC+3LJVcyBp5cMNq0kL6evl9Ay17NliTumrq18YG1
   vtg9kyiVkP6q39/klVWfxj/mMtEjms6G+8x6C5iMCbf7gF9IpV0djYU3n
   EaOI0i/crSdvg9nChRkpO+uuA7jldUjj4e9oa/reV3hY5pmxG+3lcKKlz
   /577DYXizRWEghZ2tHf967DTV+nQ8/7xS3ef7n7tbxFnwdLsLgqulJDrC
   NBIkE4W8Y729mCkcLVOYzsGMekhUc+UMjq6jpf1NGL2BF/zYJgqTKbISM
   A==;
X-IronPort-AV: E=Sophos;i="5.63,440,1557158400"; 
   d="scan'208";a="211832433"
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 04:18:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8FdXl9fQhVeMl/osm7KAlS6gPFgaAA9xTyaCj4BAvw=;
 b=fUaChbDyboOJkSkpFbOeD6ynlDJk3hv5TXEFgpEXSHjJ4Szj4f1xiw4DH6HGUMATnS585m3k1VXdlqfQOziVg30gOiGGwf88/18iAwoXBWFxg6OVVuCnNyNRPzqmwtampVfXnGNRiynkbfq3e9UjSlYinVOhTjnadOw8rJ2wq84=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5509.namprd04.prod.outlook.com (20.178.232.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 20:18:45 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::65e3:6069:d7d5:90a2%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 20:18:45 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "ottosabart@seberm.com" <ottosabart@seberm.com>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V
Thread-Topic: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V
Thread-Index: AQHVLSJGz+hI7exIqkGm7p6W+lzWB6a2H8CAgAACBYCAAAEiAIAAFy+A
Date:   Mon, 1 Jul 2019 20:18:44 +0000
Message-ID: <daaf6f4e6512402bd8b6fcefc3dba9c045921b38.camel@wdc.com>
References: <20190627195302.28300-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1907011143520.3867@viisi.sifive.com>
         <5f31cb3c576bdbd89665614582af66d04ece8f29.camel@wdc.com>
         <alpine.DEB.2.21.9999.1907011154310.3867@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1907011154310.3867@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.45.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 392baa72-e3fe-4abc-8622-08d6fe615186
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5509;
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB5509E1C8D65A9917F7C2D528FAF90@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(51914003)(199004)(189003)(478600001)(76176011)(118296001)(25786009)(102836004)(99286004)(54906003)(26005)(5660300002)(6306002)(6512007)(6246003)(66476007)(5640700003)(316002)(72206003)(6506007)(68736007)(66446008)(6486002)(66556008)(64756008)(6916009)(73956011)(229853002)(7416002)(66946007)(76116006)(6436002)(86362001)(486006)(446003)(11346002)(2616005)(476003)(81156014)(81166006)(2906002)(36756003)(66066001)(966005)(3846002)(6116002)(14454004)(2501003)(8936002)(71190400001)(186003)(2351001)(53936002)(71200400001)(4326008)(4744005)(7736002)(305945005)(8676002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5509;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DmK/3pHc9Bd04sX1oPOoOSDuOu9s7ntx/WZT3Mizz7c47m29yOQe6UjfIzZz2IMXnEILYkg5h+GGCzZmnm6CMXHQtDsB212OpPb0pl2GM7WwVi/Liwei84bfApPMHiilt4lkniFuOgrLzE9lxyux7ClpwqKeUqoZV9ksizKHgctG7hhWKV8nhKpdnjn4IKmgdcSu0c3z+DlNwiaLdxP/lbpCKpNnE6EofBTzfNUQVC8ZcpSi+ilpT39pXFiv74DoMIVxNDJIuoPgDvpZTcJHAKXzuxGzYpp7MBfKN9mhVm9DS4sArjNgjK6pAcQhBr805YeZVifxKJ3hK8D+pPaYAMoEgncSMgXl4AByAt12tnlDPMDjkx/J5b67+8vdP7uGqqs185LyhGUesXJkrIngUdRzMqH9K/YBwVUt14cxZtc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19593EB42262524DBDC8DEE9233E70C3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392baa72-e3fe-4abc-8622-08d6fe615186
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 20:18:44.9279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA3LTAxIGF0IDExOjU1IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBNb24sIDEgSnVsIDIwMTksIEF0aXNoIFBhdHJhIHdyb3RlOg0KPiANCj4gPiBPbiBNb24s
IDIwMTktMDctMDEgYXQgMTE6NDQgLTA3MDAsIFBhdWwgV2FsbXNsZXkgd3JvdGU6DQo+ID4gPiBM
b29rcyBsaWtlIHBhdGNoZXMgMSwgNiwgYW5kIDcgYXJlIG1pc3NpbmcgeW91ciBTaWduZWQtb2Zm
LQ0KPiA+ID4gYnk6LiAgQ2FuIEkgDQo+ID4gPiBhZGQgdGhvc2U/DQo+ID4gPiANCj4gPiBTdXJl
LiANCj4gPiANCj4gPiBJcyBpdCBhIGNvbW1vbiBwcmFjdGljZSB0byBhZGQgIlNpZ25lZC1vZmYt
Ynk6IiB0aGUgc2VuZGVyIGV2ZW4gaWYNCj4gPiB0aGUNCj4gPiBzZW5kZXIgaGFzIG5vdCB0b3Vj
aGVkIHRoZSBwYXRjaCBhdCBhbGw/DQo+IA0KPiBZZXMsIHNlZSBzZWN0aW9uIDExKGMpIGhlcmU6
DQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLnJzdCNuNDE4DQo+IA0KPiBUaGUgbWFpbiBmYWN0b3IgaGVyZSBpcyB0aGF0IHlvdSBj
b2xsZWN0ZWQgYW5kIHJlc2VudCB0aGUgcGF0Y2hlcyAtDQo+IHRodXMgDQo+IHlvdSdyZSBpbiB0
aGUgcGF0Y2ggc3VibWlzc2lvbiBjaGFpbi4NCj4gDQoNCkFoaCBva2F5LiBUaGFua3MgZm9yIHRo
ZSBsaW5rLiBJIHdpbGwga2VlcCB0aGlzIGluIG1pbmQgaW4gZnV0dXJlLg0KDQpSZWdhcmRzLA0K
QXRpc2gNCj4gDQo+IC0gUGF1bA0KDQo=
