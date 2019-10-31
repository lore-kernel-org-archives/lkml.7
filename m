Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C392CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16D42083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SxmuMy4l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nH82hHmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfJaPNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:13:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57373 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfJaPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572534798; x=1604070798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d0xWATE1LHooGfxIfb8JpVRj7rkZztd9pyHNtH5NSpA=;
  b=SxmuMy4l/m5a1MiQwirgO/o2Rv3zt1heEr8UsNSyDi9oRGtBfmMSedkk
   tGBz0Zos0TbYDyNHiYhVKXWc2rYCVDbYSDx1l0dMrpuBAYBDRaL9C11No
   VnjOMe0QghoDZGRSM+lcpA3TGlXsjGhxtphLC2JaIfw5fGvOOTnYYu7tA
   NskOcGD94uW555N7vaDQLhahcrpzPfYhQQUVH8fqcQPwXzHI01K0Z0ri0
   NH5T5w2yh6YZCPCYqkgGF+6YPdmuMeJDilZVTsf7koHYI3likOqGv/b2M
   llXFEjMnGyIx6VZi9g9gUIf1NK7mYvhrxRFFiI1TmOJINaosQyxEp34dh
   Q==;
IronPort-SDR: 1kkGM7p4aWm2pXHZp3n7fuLk7RTSxj2nNPY736rU5sDiszHuWabD5LboNeBZurOD/eM5dLl5o5
 A1hxXBfa+j8SPT/UIfg63xBcL7FXnhZbbMDvoyCeCgx6ba4P1yY14dh8mvpYB1ZMq5HbS+zY/3
 +T+neGrWpFtDV4gZm+0b/zAY79LgjKO5obmNZ9c1FFemthht/vsihM5S7WpEaFqMnFqMUUhVkg
 a9fubZSWDOZZr4f5HDqAyqsK7oi7upLx9R2BsG8pWIL7DLMB72nX5Do7yGW3nuf0rFtwewdANh
 FBg=
X-IronPort-AV: E=Sophos;i="5.68,252,1569254400"; 
   d="scan'208";a="121811700"
Received: from mail-co1nam03lp2054.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.54])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 23:13:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+4JtGmhc6o4+BjCZnEg2Yw9vCsrW+8ktt9YbJH5GHRtdVoxiK3Hqr6mOccAeUqmpC3/tR84ZKZ33he5pivF1s/qtoJBO1UWtk1LPDmSdUrf3FDUfHDYpXPiopB9Z97aDetyIzPJZTxqf0CUxthvrJdmWZ4c7MxhIDd5xrp6vdDNXKjfLUPUvrIsiwgurIggAA19PgGNVweDgJzhb3cNrcPnxfWc1LVb1/8DUZ5NzrM1GcdlLiXvNrdn8T197iI3mPuKUOLsbFfs0vqZTO8WBak053qBXVF4lRxAQgFDhgeGahZS6y0jH90xx+Px29Im285XoE5iAvGjCTnEZhqJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0xWATE1LHooGfxIfb8JpVRj7rkZztd9pyHNtH5NSpA=;
 b=QGXXaR9GMthaZzU/Txnp3SSBlHTGg7OMsnXvn4sO3UfpdbhVdvndgBRGc9BeKy5N6VjD3XO+ekzUmUdPvlSxRZ+CAjVBaUbulTg89f8L+AijgNT8prGcZOkp3jAq19cBx+uQSr2zpWUJqJcBg9xrl381HMATS9NCnkoW2BcfCQrHyL98fQ4uXweVW+l2iUtsCSna7wi1vX4xGhNR8CstKaHYZBlj4F/5wLKmtuzNjT3ohOWLgs7SvDw64lR7CtV0yCL2Uz1RPYyv6CDDAEtEI9wywku+i2l5WfZVefmsIRG1EDd1qSRCmj8NeveS67fiU25NcGcFZsE3ZmawxVwM+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0xWATE1LHooGfxIfb8JpVRj7rkZztd9pyHNtH5NSpA=;
 b=nH82hHmvbCqj3siGl4FM9rVZA3ydoi4g/IiuTGDetWnZanMoyv0zilXHoFgdsZeyEvEZ016ABGaMuEcrr7Hov8kDLauK/dSZrNb1mOPljHENMeKOK90uERXKHgEhata9FWTH5cBosgG5V5wAb9Qj29rLaZQp3064mcfURrw7zZ4=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB6120.namprd04.prod.outlook.com (20.178.235.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 31 Oct 2019 15:13:16 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::f4e9:4744:a5a1:a35f]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::f4e9:4744:a5a1:a35f%5]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 15:13:16 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 0/3] Optimize tlbflush path
Thread-Topic: [PATCH v4 0/3] Optimize tlbflush path
Thread-Index: AQHVWL967ZZ9b4+26kS/tTJYa+paEqcUnDiAgFZ1kACACjglAA==
Date:   Thu, 31 Oct 2019 15:13:16 +0000
Message-ID: <ad18523fdf51b426808a6ff115ca3decc8e80aeb.camel@wdc.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1908301939300.16731@viisi.sifive.com>
         <alpine.DEB.2.21.9999.1910242001550.28076@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1910242001550.28076@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19c8f478-c6d8-4173-f24a-08d75e14db05
x-ms-traffictypediagnostic: BYAPR04MB6120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6120F4369E911E683FB7927AFA630@BYAPR04MB6120.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(5660300002)(2501003)(6246003)(102836004)(5640700003)(2351001)(478600001)(2906002)(71190400001)(86362001)(25786009)(36756003)(71200400001)(316002)(229853002)(4326008)(8936002)(305945005)(6506007)(6916009)(76176011)(66066001)(66446008)(6486002)(66556008)(76116006)(54906003)(7736002)(66476007)(486006)(186003)(14454004)(26005)(446003)(11346002)(2616005)(476003)(99286004)(8676002)(118296001)(81166006)(256004)(81156014)(4001150100001)(6116002)(3846002)(64756008)(6512007)(66946007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6120;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGD2DWe8lG9M5yJo2KkrM9a03AEEP7LtvPsGWCwn0SQb9lkvtt8/odz0iUr9XU7UFMy5p3vaQB3UcBqA+2zKylrEz3zjCV8v0tDL4+ojaaS66E0f91LHs/cJzGhfgup3t63YG0klpCftEyOHTM60DAPUyOfVeg1O/WOO5s1sVUm9ITOkA1BYr4WhlLuMtyfrFlxyVPIcApdKiLrrRavhmdfVNwSOcI6aFK6Gspc5soLM1zOEVC041Ejq0XXPfCsoyoWO6pM+Fm2XknHr+6BkqhfxofORowbD3n6CkaQ2r++DA6qPJDsoh2xwocAwcULlH+qJ5NypW4FGDzitFOcOPMJlA/I5+aYYS3WHfc42FByNbuwb3MCLmK1zJM5Xcn7A1ILizckqxA4yaevMuj5zB+e04CT0W/nnCx6rP1zEoZb/ERzUI7uovJNhgetyOsiz
Content-Type: text/plain; charset="utf-8"
Content-ID: <350BF2D45FC7F14383E701EAAB6366B1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8f478-c6d8-4173-f24a-08d75e14db05
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 15:13:16.1882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jc4uhkpgc39jKqCsW3I1WsV/PdFpH9rfr9gfC6e7Yawfn8EEMguXA2JNo2nBQNBc2G6jsDuamCQsUksZsQX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTI0IGF0IDIwOjA5IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBGcmksIDMwIEF1ZyAyMDE5LCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0KPiANCj4gPiBPbiBU
aHUsIDIyIEF1ZyAyMDE5LCBBdGlzaCBQYXRyYSB3cm90ZToNCj4gPiANCj4gPiA+IFRoaXMgc2Vy
aWVzIGFkZHMgZmV3IG9wdGltaXphdGlvbnMgdG8gcmVkdWNlIHRoZSB0cmFwIGNvc3QgaW4gdGhl
DQo+ID4gPiB0bGINCj4gPiA+IGZsdXNoIHBhdGguIFdlIHNob3VsZCBvbmx5IG1ha2UgU0JJIGNh
bGxzIHRvIHJlbW90ZSB0bGIgZmx1c2gNCj4gPiA+IG9ubHkgaWYNCj4gPiA+IGFic29sdXRlbHkg
cmVxdWlyZWQuIA0KPiA+IA0KPiA+IFRoZSBwYXRjaGVzIGxvb2sgZ3JlYXQuICBNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgdGhlc2UNCj4gPiBvcHRpbWl6YXRpb24gDQo+ID4gcGF0Y2hlcyBtYXkg
YWN0dWFsbHkgYmUgYSBwYXJ0aWFsIHdvcmthcm91bmQgZm9yIHRoZSBUTEIgZmx1c2hpbmcNCj4g
PiBidWcgdGhhdCANCj4gPiB3ZSd2ZSBiZWVuIGxvb2tpbmcgYXQgZm9yIHRoZSBsYXN0IG1vbnRo
IG9yIHNvLCB3aGljaCBjYW4gY29ycnVwdA0KPiA+IG1lbW9yeSANCj4gPiBvciBjcmFzaCB0aGUg
c3lzdGVtLg0KPiANCj4gSSBkb24ndCB0aGluayB3ZSdyZSBhbnkgY2xvc2VyIHRvIHJvb3QtY2F1
c2luZyB0aGlzDQo+IGlzc3VlLiAgTWVhbndoaWxlLCANCj4gT3BlblNCSSBoYXMgbWVyZ2VkIHBh
dGNoZXMgdG8gd29yayBhcm91bmQgaXQuICBTbyBzaW5jZSBtYW55IG9mIHVzDQo+IGhhdmUgDQo+
IGxvb2tlZCBhdCBBdGlzaCdzIFRMQiBvcHRpbWl6YXRpb24gcGF0Y2hlcywgYW5kIHdlIGFsbCB0
aGluayB0aGV5DQo+IGFyZSANCj4gdXNlZnVsIG9wdGltaXphdGlvbnMsIGxldCdzIHBsYW4gdG8g
bWVyZ2UgaXQgZm9yIHY1LjUtcmMxLg0KPiANCj4gDQoNClRoYW5rcy4gVGhlc2UgcGF0Y2hlcyBz
dGlsbCBhcHBsaWVzIGNsZWFubHkgb24gNS40LXJjNS4NCkxldCBtZSBrbm93IGlmIHlvdSBuZWVk
IHNvbWV0aGluZyBmcm9tIG15c2lkZS4NCg0KPiAtIFBhdWwNCg0KLS0gDQpSZWdhcmRzLA0KQXRp
c2gNCg==
