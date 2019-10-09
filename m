Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280CEC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACA420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a9ULepgQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V2RFVsI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbfJIW5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:57:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21103 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732199AbfJIW5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570661841; x=1602197841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+cn8C1W5bRdvwogVJcoqMzhylTv9pss3UfRwShn44pQ=;
  b=a9ULepgQFXBK0rMt38cCYNfcIlwujm3UuylRSOvarm36C6QkhNCCA3yA
   PXKb4jZrZYgqBiRT/+YKPMa8tY3f9mjKlLywlKOgqzSlhvvE/mJl5w7Hg
   561IITc0fpWLvhN+eB3iLvgLouu+6/JGq+BTKcAlvaGyvnVZl+/dVFNY/
   uujfU38cC/48diqBIy1jcQCiCv77gQ8JdhYd/wAYXYYRj2l1srDOzlBCY
   7RLQM/FTLwWJEMIuczBjQK4cRD69J+t/nGkmX9slicHc3lqHslqsDXycm
   5FWwDFzmhbIHzz/RzqmbbsjgTU4Mfr/dylI5gmsDWYTRFNNgVZTCAf5FO
   w==;
IronPort-SDR: OHwITdWPuU+skD4mBZRaqef1NQlhBgcDzTFMsEdE8kEuNrEmGYgXRs78GjOehdnbmrNwRytqbJ
 zEEOlv/wzENQ/mUmovnhUiXs57CZ8wlXGXu+BIh8M6c+gDpdJYcKYHDPXKRofIG0kKbyp3PzaU
 3DuXvd38WPD5WXwdJQDnyluxujbpyeJfZfhtbU7mbOOP5VFyAGN0qRRUjy+kUzRGmXd7fNJBgV
 F1LfGbGYUU2Ak7dqzEyhIpaVv4gNv8teA4d9MzJRbbYWlH5KOqqOYwWLrG6iNGIIiquWJb83tM
 zuc=
X-IronPort-AV: E=Sophos;i="5.67,277,1566835200"; 
   d="scan'208";a="221174261"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2019 06:57:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXg5eixEXYHyygo6v2cDWiUjMuOjqDoQuVKg+5gbPoj+RBfKITGD8BPaa72hAWjve+QWK3da/jPapOiwDkTHqIVN6/bnM5kK55Itu9N0GVZX6hOIZ1qHUYqoomznmHg7QUfqEC4dHhSCdcrO4BEcIb/BlUOqWMM+8LHUH7MUrJ4AD532ma+CI8ODM0MkEmjY+8bjQtVVtRCuzcLKUg/oHXErXe47ngj3wMZQF91WxE/FOQDzOBsg7PgZLLSHdHZA9C8GXUQge/CoChp8g9MvAorqVf6AOceiLXmK9XBdSdpLZpf6d0PldZl4QK1QQcX7RoHw9I9SZBTJfUKDxRT+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cn8C1W5bRdvwogVJcoqMzhylTv9pss3UfRwShn44pQ=;
 b=LV4SdH12xGzXbrtYcwrTcreedIZmzxR7wi26J3h423648o8xcpVsxQ0uZJNJNEd/K5Th3OPusXkksG4VgV9/BYMaGJ003nVTqFo6tFjou7SwgkSONMaENBMpdDJvYhjOurk5D3ZAXQkj1Ipti5kov+wMQWkPK51e1BTZps4UM7tq+4Q92Z7YH9bEg+i/zK7a292fGgLNCVbywii0cZmInjEwn1z6ASXqjGaOiX4jm201HhDDf0eds01hBhFsaXwtYsahrI4fHsb2RL76yT4ZMm0mh/TWSNRoSlDUeNNwMItdmB/TLX+EJd8zPhZhHW+NOFUyatXiBJ/GokMRyN2fsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cn8C1W5bRdvwogVJcoqMzhylTv9pss3UfRwShn44pQ=;
 b=V2RFVsI3e4ogj06/MhG49AeDg+YQM+D9LL7QX2FUFFr87/Uzxc2j9Ei5xd0XxQGVC3tUtGPOPRo/DqCxEdAULudyrZJZoXvOG6YE6PkL57kX3uOuotEegAJoyKjKmtv7WDh1w3pxZWPlvyJlgIsfN4s60hIdxd81JsolSLAZwtw=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5237.namprd04.prod.outlook.com (20.178.48.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 22:57:09 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::51dd:7de9:c4a1:f9f3]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::51dd:7de9:c4a1:f9f3%3]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 22:57:09 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: HiFive Unleashed: add default
 chosen/stdout-path
Thread-Topic: [PATCH] riscv: dts: HiFive Unleashed: add default
 chosen/stdout-path
Thread-Index: AQHVftnFkKqEtgsDnk6DU2Im0fNBVqdS7A0A
Date:   Wed, 9 Oct 2019 22:57:09 +0000
Message-ID: <329f84a635caa92f954c8d614975f03e22158c4a.camel@wdc.com>
References: <alpine.DEB.2.21.9999.1910091240220.11044@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910091240220.11044@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b227d76-3203-4977-fbe2-08d74d0c03b2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB5237:
x-microsoft-antispam-prvs: <BYAPR04MB523770E2A20A20FD67416EBBFA950@BYAPR04MB5237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(71190400001)(14454004)(229853002)(71200400001)(6246003)(54906003)(6512007)(118296001)(256004)(6436002)(25786009)(5660300002)(6486002)(2906002)(478600001)(66066001)(66946007)(66476007)(66446008)(66556008)(86362001)(186003)(64756008)(26005)(8936002)(76116006)(110136005)(7736002)(316002)(4326008)(36756003)(3846002)(6116002)(305945005)(446003)(11346002)(486006)(2616005)(476003)(76176011)(2501003)(8676002)(99286004)(102836004)(6506007)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5237;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AwpxLHTZg4P7xRlCOZ8pvpLQ6Klp7Lt2NbumlSd/lfzYDIxQ460z39G9ojdCxEOCe6Ugl8+8RVY7G+6hMHTETjw9DdtpFwURIX/0DQfal8J23vrRSmGcIxxAeJZZD/17t5yWakT5ctv4Px1nDf5o2rmU3YTUTWECtI5WBh7dL8pmG6DZoNhxfYw8n4XeZi1FJS1zcUkPnbCzZbPWQ03eR3UCDFYKm38rXnnaTFyWj2yx8Yh6pZTfk3GlNaA2nw7Ys9zapnt28VxO1OHYdH4Dy6ZxPjG7G6w08P+2tfU7FH2OTuF/vxfMQIVzwO3m+luLC/OVUZ+hCZkHku7AxAnIvQQdEz6Tcq8xW8IXLF88PMEPFY5nllG0PiGUkeY5Ltmt1Nnsilegf0el0R7IHQxsriTsNloVfgIwDJ16eXuUv4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7AE5B5430D9BB4D9B76E2439B320A2A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b227d76-3203-4977-fbe2-08d74d0c03b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 22:57:09.2003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yTzuam8fcoBqqQW203ilsrW/vBxlyDHnA6oOeLqeme+XznNweOxh0iib9ZAjusW6wiTdathppsG9cRTVSsJBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTA5IGF0IDEyOjQyIC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBBZGQgYSBkZWZhdWx0ICJzdGRvdXQtcGF0aCIgdG8gdGhlIGtlcm5lbCBEVFMgZmlsZSwgYXMg
aXMgcHJlc2VudCBpbg0KPiBtYW55IA0KPiBvZiB0aGUgYm9hcmQgRFRTIGZpbGVzIGVsc2V3aGVy
ZSBpbiB0aGUga2VybmVsIHRyZWUuIFdpdGggdGhpcyBsaW5lIA0KPiBwcmVzZW50LCBlYXJseWNv
bnNvbGUgY2FuIGJlIGVuYWJsZWQgYnkgc2ltcGx5IHBhc3NpbmcgImVhcmx5Y29uIiBvbg0KPiB0
aGUgDQo+IGtlcm5lbCBjb21tYW5kIGxpbmUuICBObyBzcGVjaWZpYyBkZXZpY2UgZGV0YWlscyBh
cmUgbmVjZXNzYXJ5LCBzaW5jZQ0KPiB0aGUgDQo+IGtlcm5lbCB3aWxsIHVzZSB0aGUgc3Rkb3V0
LXBhdGggYXMgdGhlIGRlZmF1bHQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVsIFdhbG1zbGV5
IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+DQo+IC0tLQ0KPiBUZXN0ZWQgb24gYSBIaUZpdmUg
VW5sZWFzaGVkIHVzaW5nIEJCTC4NCj4gDQo+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3NpZml2ZS9o
aWZpdmUtdW5sZWFzaGVkLWEwMC5kdHMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2hp
Zml2ZS11bmxlYXNoZWQtYTAwLmR0cw0KPiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2hp
Zml2ZS11bmxlYXNoZWQtYTAwLmR0cw0KPiBpbmRleCAxMDRkMzM0NTExY2QuLjg4Y2ZjYjk2YmYy
MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9ib290L2R0cy9zaWZpdmUvaGlmaXZlLXVubGVh
c2hlZC1hMDAuZHRzDQo+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc2lmaXZlL2hpZml2ZS11
bmxlYXNoZWQtYTAwLmR0cw0KPiBAQCAtMTMsNiArMTMsNyBAQA0KPiAgCWNvbXBhdGlibGUgPSAi
c2lmaXZlLGhpZml2ZS11bmxlYXNoZWQtYTAwIiwgInNpZml2ZSxmdTU0MC0NCj4gYzAwMCI7DQo+
ICANCj4gIAljaG9zZW4gew0KPiArCQlzdGRvdXQtcGF0aCA9ICJzZXJpYWwwIjsNCj4gIAl9Ow0K
PiAgDQo+ICAJY3B1cyB7DQoNClRlc3RlZCBvbiBhIEhpRml2ZSBVbmxlYXNoZWQgdXNpbmcgT3Bl
blNCSSArIFUtQm9vdCArIExpbnV4IGJvb3QgZmxvdy4NCg0KT25jZSB0aGlzIHBhdGNoIGlzIG1l
cmdlZCwgd2UgY2FuIHJlbW92ZSBzdGRvdXQtcGF0aCBmaXggaW4gT3BlblNCSSBmb3INCnVubGVh
c2hlZCBwbGF0Zm9ybSBhcyB3ZWxsLg0KDQpSZXZpZXdlZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNo
LnBhdHJhQHdkYy5jb20+DQoNCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
