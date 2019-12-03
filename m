Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2ADC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2386320661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n2DJRJef";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L0X6F/AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfLCTdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:33:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9947 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfLCTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575401637; x=1606937637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WzwxpGeDXydgm3WX4Wp3Q2mVZpVA2UO5jaLMGpzzqcY=;
  b=n2DJRJef1N3HIAGgVyfVt1EnQmlmMDuscPgolXDuzxFusbp0mWQmO7WN
   ZusognPBN6EDqncjVGFeKLQsCAyEkKaVefo8vis5j1dP0AKD8m9OGzW8i
   Q4IE8KJ6NcDM3ezhI2lfjoit+1AbklbptnOnS4zXWUsp6Dbr527hKKMJ8
   tUrg9UfKSvl6QMKmGIM6mTnbpFjRVFucMnTbtXEtdU9qffZyV/VXnYkAZ
   ViYtU9xSaHea483NBAxqAFILRxfPMPlNGlNyeX00FUaa0tdso2PqbW3bC
   aU3UzVNdKcu58+uv42fBeDI/qQAMSuaLB3eU5ENuoJ2HVY60NdoybnsHQ
   w==;
IronPort-SDR: 0JVaxiI+K1XX3X3mbPNbP0Qu536RBmWAw7aY8zcGeYfff6d1j6es9loVpW6Fo3YBiaqjB3fMB6
 n5wb9yJOSHyHpXdfeFj2l7FhRWyRZsnZwAd5vafqB3ksNtIpG6lbe4V3Le39c40gj0QzYVy/DV
 nJusAICrmf2MwlKbyPZJhntoqdUrqvt8wPlUtRlqFFydqqctODGBTy/2N04V0OX3POwVuqCu/N
 Te+9NQtp/ujZOmMY99bIwY8KtkkFbcp52JAOnW6x1hLNQfKA0Hv419tkol27aL2mZMG2aXsdBD
 9DU=
X-IronPort-AV: E=Sophos;i="5.69,274,1571673600"; 
   d="scan'208";a="225983875"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 03:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHaAsWHrVEsCQQTHziLyzetzHDM8W5Cy0zpIN8/UsLVtQIx2r947yPJhrC6hvNmN3O/TdYID5CSEJ1Zo6gdMiGdEtSYGVKRSagAjF3ypzBDws6HXyV/PAY8xQazOpYbJH4WYH3gssqgSo2pQFf2oPaezGSzXW7ooHb1BeZZSbcnsOghM8tv33Fhd9urUiU+VJp/Zl8Sk1rUyfiTzdwbOoQJ6u1v67u2lhw4E1TYwdLREHMaqtPrMmJp7fC8ZHfOQLwQT/bluo7oWxBQFavN5r2vnWfxveyu5E6fP/4J0x+m279NYG49XfxKj02hwZN4wtU3BuQIX2qOXTGOzuVm9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzwxpGeDXydgm3WX4Wp3Q2mVZpVA2UO5jaLMGpzzqcY=;
 b=a9vIpgF2kvOmM5I/SP1+guRNVpLr+pR+/TzSzwK2hzUm52j2AOWBxrlOqsUZWasiiR/AwzAD0w3FvPDmzkeniZ5MwSNclYYnmnqgIbo/41gRSYPlQ+feEF/8TDGUZ7Y172B5VGJBNHDIBcDiMnM3BIc3cVtaFWcsnDyvU6ZDN93ex0sUvHrENc61V0KNZttieec15dGH5r82cXS+fiqmsTzYCt1P4mn/CRJi6kc+Ggj0C05s/eD0yd57A1fKsCspaAgOGdNuqAFzYuqzHpNwcWOkLpvVEW7643QMZoWeXEi14gLY8AxpYtwdKTmL+CGsKU3KP39f/5oodhbuW8SsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzwxpGeDXydgm3WX4Wp3Q2mVZpVA2UO5jaLMGpzzqcY=;
 b=L0X6F/ASnoGI7kkOopiRaGL3gGGnlzlPQWEjuSMuPbAbMCp0P4Dl/w9xdACXzFYJ1tEW1FRMVDqkX/cnLCN5eL9t643NtKr+5sb56VcFCSdFo/PRknmhtV1F+SN8LtkAjqjtvscWUCxPIuF+uaLV3pXE3p1PFxGCNefIMs3vGHk=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB4951.namprd04.prod.outlook.com (52.135.232.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 19:33:42 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::112d:6934:52da:df11]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::112d:6934:52da:df11%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 19:33:42 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "hch@lst.de" <hch@lst.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Topic: [PATCH v2 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Index: AQHVqYyr/RMj/iyeVEuQTvGzYoAZAKeozHwA
Date:   Tue, 3 Dec 2019 19:33:41 +0000
Message-ID: <2aa53495207f48d50489eda3fcbdd1f02779f85d.camel@wdc.com>
References: <20191203034909.37385-1-anup.patel@wdc.com>
         <20191203034909.37385-2-anup.patel@wdc.com>
In-Reply-To: <20191203034909.37385-2-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06d53ab7-1ebd-4ffc-aaaa-08d77827b491
x-ms-traffictypediagnostic: BYAPR04MB4951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49516DB10749C8B413BF40AB90420@BYAPR04MB4951.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(8676002)(86362001)(8936002)(6506007)(76176011)(2501003)(81166006)(81156014)(26005)(2616005)(118296001)(229853002)(102836004)(11346002)(36756003)(478600001)(6486002)(446003)(14454004)(316002)(6512007)(66476007)(66946007)(76116006)(2906002)(7736002)(6246003)(54906003)(71200400001)(110136005)(66556008)(6436002)(71190400001)(66446008)(5660300002)(64756008)(2171002)(186003)(6116002)(4326008)(3846002)(25786009)(99286004)(256004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4951;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QhWY78z1b3s5DT87XLnvIz00CiNkvQNINvlZSemUYf4UQ94tLSYL79oWcbGRvKis75zRugDjXHoAhRUuFx688N1UX3ZrP7BFlvOYzWtRzBPztgqYj/XB+qovS4jRNm872ullXPWTuttQV0vwo1dkTfOtVMMTtLUlc/Nyo1+9LjYBQL1m4JlcyqMwSMmHg3sBaCFFwQQlHcFBG6MDggOaoSEqcPK9RdUoqW7o8TKEI4lDDkS+dhBci8o+anREGcemEbOutMx4rJBFN9ASsU1rECRPDChWxdfgOd0WIgLlLJHTYxOnPrbwbXolGwZPu/x8kDOFeRox20sutlyhAXJrgHbADxgb18H59PLB5jBbT4EIVURko8Jx8ZWMp0+YVRaMriO+EI0LvmytmG62RCuH5nIK1kmZgAARf9nDxZ1TR/i2n9isgKlhX7dVnsrKoTlD
Content-Type: text/plain; charset="utf-8"
Content-ID: <F94957C4591BBC46B574E2C513EDBB13@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d53ab7-1ebd-4ffc-aaaa-08d77827b491
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 19:33:42.2958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5r8TLpKEeUvSwTrWTzWtFTqqMh8JVcyv/mbVazn1G8ytVL4rfceyrQQZit5Fcp4QpEfmHxth4u+KSqCgkbxQ59Cju4E4xLeqVL9cdDo+kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTAzIGF0IDAzOjQ5ICswMDAwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBX
ZSBhZGQga2NvbmZpZyBvcHRpb24gZm9yIFFFTVUgdmlydCBtYWNoaW5lIGFuZCBzZWxlY3QgYWxs
DQo+IHJlcXVpcmVkIFZJUlRJTyBkcml2ZXJzIHVzaW5nIHRoaXMga2NvbmZpZyBvcHRpb24uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBhdGVsIDxhbnVwLnBhdGVsQHdkYy5jb20+DQo+IFJl
dmlld2VkLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJkYWJiZWx0QGdvb2dsZS5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0
YWlyDQoNCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcuc29jcyB8IDIwICsrKysrKysrKysr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzIGIvYXJjaC9yaXNjdi9LY29uZmlnLnNv
Y3MNCj4gaW5kZXggNTM2YzBlZjRhZWU4Li42MjM4Mzk1MWJmMmUgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+
IEBAIC0xMCw0ICsxMCwyNCBAQCBjb25maWcgU09DX1NJRklWRQ0KPiAgICAgICAgIGhlbHANCj4g
ICAgICAgICAgIFRoaXMgZW5hYmxlcyBzdXBwb3J0IGZvciBTaUZpdmUgU29DIHBsYXRmb3JtIGhh
cmR3YXJlLg0KPiAgDQo+ICtjb25maWcgU09DX1ZJUlQNCj4gKyAgICAgICBib29sICJRRU1VIFZp
cnQgTWFjaGluZSINCj4gKyAgICAgICBzZWxlY3QgVklSVElPX1BDSQ0KPiArICAgICAgIHNlbGVj
dCBWSVJUSU9fQkFMTE9PTg0KPiArICAgICAgIHNlbGVjdCBWSVJUSU9fTU1JTw0KPiArICAgICAg
IHNlbGVjdCBWSVJUSU9fQ09OU09MRQ0KPiArICAgICAgIHNlbGVjdCBWSVJUSU9fTkVUDQo+ICsg
ICAgICAgc2VsZWN0IE5FVF85UF9WSVJUSU8NCj4gKyAgICAgICBzZWxlY3QgVklSVElPX0JMSw0K
PiArICAgICAgIHNlbGVjdCBTQ1NJX1ZJUlRJTw0KPiArICAgICAgIHNlbGVjdCBEUk1fVklSVElP
X0dQVQ0KPiArICAgICAgIHNlbGVjdCBIV19SQU5ET01fVklSVElPDQo+ICsgICAgICAgc2VsZWN0
IFJQTVNHX0NIQVINCj4gKyAgICAgICBzZWxlY3QgUlBNU0dfVklSVElPDQo+ICsgICAgICAgc2Vs
ZWN0IENSWVBUT19ERVZfVklSVElPDQo+ICsgICAgICAgc2VsZWN0IFZJUlRJT19JTlBVVA0KPiAr
ICAgICAgIHNlbGVjdCBTSUZJVkVfUExJQw0KPiArICAgICAgIGhlbHANCj4gKyAgICAgICAgIFRo
aXMgZW5hYmxlcyBzdXBwb3J0IGZvciBRRU1VIFZpcnQgTWFjaGluZS4NCj4gKw0KPiAgZW5kbWVu
dQ0K
