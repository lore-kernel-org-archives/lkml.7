Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA0C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BEC218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 06:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n8kKayBu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a1VA7all"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJBG3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 02:29:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49656 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfJBG3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 02:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569997741; x=1601533741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UzYkHkEOmMP5qbsWK9Iap/UZT1AjOFYKp5WANIT7QTo=;
  b=n8kKayBu3nLuDqAJPfH4LOKC+R0ClWfFN+X/UYQQJMUHoOB6ya/92Asg
   sQW5Lu43nHOXCtmNEOhFsfLJHj2t+CHLwho2wPvGl91rdGS45WMDgZ4jU
   KrPi83IS0yE3ZLSsvSXt/LsgARYoJ4xnf3/9AIYWvgYKCKRr8l3SvKo1C
   6YFVDx/Rm6he3KIBBpZDg8Coz1UOwJ/H9vO1uJS+XmXG0YNf91bfGAJiQ
   8vmKtlFJgJmVFguGPKdaHvAkRtGdC50Kz0+Kp3x70VBMfljchtPAtvzHu
   9m+sGSHwdbdkY9R7ecwDrvsYO2SYXo1wKVPuZy03saZ20G/xPtAQ+x3ur
   Q==;
IronPort-SDR: /koFlAyJj3q8gqF6Z0DhzMgMolu3QLUAZQE/SML6QZOW4EIb09V4dGr/wmwLg5YIpS29/zPqfd
 pN42KhDtTCGMuxHcBe4PGPD6wd/QklENhWRvUJcosYSd2YLkQhHQ3abY+dlnX9XlaIhX3/aEtd
 nlmLyKuhCW9QVbrWU2Y0B0KEXUQ++7/P2bhpLpMmp1N/7RzMrriTD0mqv/adpChRGxR+DFe6kp
 yWNdSmcK+444OjL5fByrHg/gwTbBH/lktymf6thKYY7yI0SJNPPmB3Bsupzs2kcFVl0XkuhwhD
 X3Q=
X-IronPort-AV: E=Sophos;i="5.64,573,1559491200"; 
   d="scan'208";a="226518798"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2019 14:29:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTldFei08MIqd2Fp6kmXCXQ19EIDoQCdpgbrDL7NIMKIMpOL4GwmSGQiJz8SVPFrZhVD5cjRWSID6Y6HAhQZ5IF9ds24lT+IplRYl8XEaBS3aOwdVBFIHeOxuB/2L8rcjjt7kbXz0bSxUjJUqz7mFdFvG+U8xEThiktVtcrMtfgxSDDwd3sxB849akDrHb07c8t1ZqmpfyoL2F96CO/4dfh/dFrRuvb2STYR825L2rZOdLCEIFp8ksHAzQIapOr1xoW8tVmVG+A+bCDmlMY9SuwTKpiFKBgi1TyRQFe72La5qt4zOW9KhclgJSa8c2aKK6yG1rCFl8EpnHDEPpyBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzYkHkEOmMP5qbsWK9Iap/UZT1AjOFYKp5WANIT7QTo=;
 b=KV7bEfyyIfpaB7nwTD9ejR71Mly2bo52xUql1+WppvPMbzxaRHQ5+IWCXK+A0BoHEQf4//6GaTwekhVk98qybQhkZcyzmEVRVlMlgfiXjZq6iwoGaecZ2PjOx6WSwwEh/vxoEfl++VZ7zVviU0ip5cSm07I/r2CiW2QIcXI8riM1mbjVUPhcw17UIPpMj0hNGo1o33IaOCI1yLxGDkkFQp2U2X8prOaxX137/8NBViBvgp8xFL9WHM4GJp2WLexX19KfGwwr7Hq7IKLNaw8ztr6PdAEm+TkX7iyyxKUtcw1neQIjfLtHAC1fPmFxcGtIS/Z2RKS2qJFc0Wg7le+wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzYkHkEOmMP5qbsWK9Iap/UZT1AjOFYKp5WANIT7QTo=;
 b=a1VA7allulVn+6XdxA0MUPHuW93mCoCimmVrbALBG2KpcPf8QGj8TBB5RK9g7PgMQsIQATifqAoFTdDpqkL0dy687FJOeg0Kng3bz0+OYpOVMlOJKiTGx9Rta3YmNs+T0AOv6AoHiweK8yQu79sWo+LuOd14jX/pueTfEhRiwdc=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB3784.namprd04.prod.outlook.com (52.135.217.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.22; Wed, 2 Oct 2019 06:28:59 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::a50d:40a0:cd7b:acbc%5]) with mapi id 15.20.2305.022; Wed, 2 Oct 2019
 06:28:59 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "johan@kernel.org" <johan@kernel.org>
Subject: Re: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Thread-Topic: [v6 PATCH] RISC-V: Remove unsupported isa string info print
Thread-Index: AQHVd+597x5i5uf5J02UT+QA3h/uMqdFXIsAgAAWWgCAAB4VAIABB5SAgABM7AA=
Date:   Wed, 2 Oct 2019 06:28:59 +0000
Message-ID: <bc0d2f2803950ebb38fd487fddb0fcf8a370512e.camel@wdc.com>
References: <20191001002318.7515-1-atish.patra@wdc.com>
         <20191001070236.GA7622@infradead.org>
         <b0c39a9895698d74e2f44eb1f2faed46eee54bc3.camel@wdc.com>
         <20191001101016.GB23507@infradead.org>
         <20191002015338.GA28086@andestech.com>
In-Reply-To: <20191002015338.GA28086@andestech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [73.162.108.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41067940-68bc-40ae-6554-08d74701cf34
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB3784:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR04MB3784CE51C7A8494B49F813A6FA9C0@BYAPR04MB3784.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(305945005)(229853002)(6486002)(6306002)(6512007)(6436002)(8936002)(7736002)(118296001)(5660300002)(2501003)(71190400001)(64756008)(66556008)(66446008)(76116006)(66476007)(66946007)(71200400001)(256004)(36756003)(8676002)(81166006)(81156014)(6116002)(3846002)(66066001)(2906002)(966005)(4326008)(316002)(14454004)(99286004)(186003)(26005)(102836004)(6506007)(76176011)(486006)(476003)(478600001)(2616005)(446003)(25786009)(54906003)(11346002)(110136005)(6246003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3784;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lm+Y4isaTKq+gsML+rG1TB6/yt3pCOzvs5+gyA0bMMSwntWUiNA0VwV+IciyJVyX1Kg0WuY4isAPXXYyG+StgJ/V0/wudcr/XBVkxRI7rvQf9zNtU5BasXwnG8VHwuBw9DGizqzzlIbIjSbNbAlT7Jg6Xdecf56eYZogch+FfwofE9eSDp1qPnbXr5GVDv+4sC5/43P+2UD520HHGhfF4imwkAayg6saXg8cxD41IyvAN6vkWbMUpNOh3uulXgLHHwZOvBGTN3hu/IzNVs7RslVmbNY1JeK8O8qfbU/bXUeJgNVoJ1Ke2tn63HgiRheCSFoNrtkxnSVbEj8JYPhkjytBs+zIMO03Lp4BcsM6nOUfXgyZhu4rVICp2fr5BHAzyWTpI/ARPvdbXqakwl9/r0Bd43zNGe1CgKNtaquMNDgYJAd0a7rqp+7a1pdEpII78tR6nn3nc2sbDVA2PSEOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E04A680A98562449A11428D2831F1BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41067940-68bc-40ae-6554-08d74701cf34
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 06:28:59.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAFl5itzCpFgw8ftJP4adcO36LkLdkpoz9J+UaY2i0kbv5DsR3ZOuyUxaY4P1NCyeM+F6HTRVkk6CDX9ztIE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTAyIGF0IDA5OjUzICswODAwLCBBbGFuIEthbyB3cm90ZToNCj4gT24g
VHVlLCBPY3QgMDEsIDIwMTkgYXQgMDM6MTA6MTZBTSAtMDcwMCwgaGNoQGluZnJhZGVhZC5vcmcg
d3JvdGU6DQo+ID4gT24gVHVlLCBPY3QgMDEsIDIwMTkgYXQgMDg6MjI6MzdBTSArMDAwMCwgQXRp
c2ggUGF0cmEgd3JvdGU6DQo+ID4gPiByaXNjdl9vZl9wcm9jZXNzb3JfaGFydGlkKCkgb3Igc2Vl
bXMgdG8gYmUgYSBiZXR0ZXIgY2FuZGlkYXRlLiBXZQ0KPiA+ID4gYWxyZWFkeSBjaGVjayBpZiAi
cnYiIGlzIHByZXNlbnQgaW4gaXNhIHN0cmluZyBvciBub3QuIEkgd2lsbA0KPiA+ID4gZXh0ZW5k
DQo+ID4gPiB0aGF0IHRvIGNoZWNrIGZvciBydjY0aSBvciBydjMyaS4gSXMgdGhhdCBva2F5ID8N
Cj4gPiANCj4gPiBJJ2QgcmF0aGVyIGxpZnQgdGhlIGNoZWNrcyBvdXQgb2YgdGhhdCBpbnRvIGEg
ZnVuY3Rpb24gdGhhdCBpcw0KPiA+IGNhbGxlZA0KPiA+IGV4YWN0bHkgb25jZSBwZXIgaGFydCBv
biBib290IChhbmQgZnV0dXJlIGNwdSBob3RwbHVnKS4NCj4gDQpAQ2hyaXN0b3BoDQpEbyB5b3Ug
bWVhbiB0byBsaWZ0IHRoZSBjaGVja3MgZm9yICJydiIgYXMgd2VsbCBmcm9tDQpyaXNjdl9vZl9w
cm9jZXNzb3JfaGFydGlkIGFzIHdlbGwgb3IgbGVhdmUgdGhhdCBhcyBpdCBpcz8gDQoNCj4gU29y
cnkgdGhhdCBJIGFtIGEgYml0IG91dCBvZiBkYXRlIG9uIHRoaXMuICBJcyB0aGVyZSBhbnkgcmVs
YXRlZA0KPiBkaXNjdXNzaW9uIGFib3V0IHN1Y2ggY2hlY2tzPyAgDQoNCldlIGFyZSB0cnlpbmcg
dG8gcmVtb3ZlIGFsbCB0aGUgY2hlY2tzIGluIC9wcm9jL2NwdWluZm8gYW5kIGp1c3QgcHJpbnQN
CmlzYSBhcyBpdCBpcy4gSGVyZSBpcyB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbi4NCg0KaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXJpc2N2LzIwMTktDQpTZXB0ZW1i
ZXIvMDA2NzAyLmh0bWwNCg0KPiBKdXN0IHdhbnQgdG8gbWFrZSBzdXJlIGlmIHRoZSBjaGVjaw0K
PiBzdG9wcyBoZXJlIGFuZCB3aWxsIG5vdCBnbyBhbnkgZnVydGhlciBmb3IgZXh0ZW5zaW9ucywg
WHMgYW5kIFpzLg0KPiANCg0KQXQgbGVhc3Qgbm90IGhlcmUuIEkgZG9uJ3QgdGhpbmsgd2UgbmVl
ZCB0byBjaGVjayBmb3Igb3B0aW9uYWwNCmV4dGVuc2lvbnMgYW55d2hlcmUgZXhjZXB0IGluIHRo
ZSBleHRlbnNpb24gcmVsZXZhbnQgY29kZS4NCg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+
ID4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0KLS0gDQpSZWdhcmRzLA0K
QXRpc2gNCg==
