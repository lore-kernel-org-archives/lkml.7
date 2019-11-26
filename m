Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5621207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bX2uVdb8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gPDqufTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfKZTM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:12:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17027 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfKZTM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574795546; x=1606331546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U+JxvNoXq3UAD7DRH+k72uPXzjJus7iETq/4nsBX7HY=;
  b=bX2uVdb8YyoS77RF5zCw81JfzVgV3VBQdcY6elvLzyUUcCbKFAu79Ab7
   jTNRDPyz9n0kHHBgsU9DGIQNiuLux86vIi6uAxKRiGHngjCZYjtseFYIL
   eanNuvLRLbK3s7MP4GYuB/lTl+OKcp9yLY8AwHyATSffsQVa54cbZzHLW
   ZqwVBHuaWEQ7woB/n//rOEkKEuQBn2uyAYrMRXtwxqsK0iXmLYvVZXa22
   2cgyhn7TtcBGMlzb+2ZQTlAsPrUuhoJY8cNbiSMYzYSHIj1CSUF9UYOUZ
   UAQaeVeDOAZusZW06uIw9BbMKv03MfHYZhkIN+2x/tve+yLRSRRLoq9wQ
   A==;
IronPort-SDR: sZMMIH05jNVmGxv+c4ClbgCzbEaQTAuLiVBoflrJIOK9tcIHUnatvFavrAABec8FMnwib8YT1x
 nbLSJBJSN0K5Z9WHaxUW9R/klVL4dXe1fCNqfh742PVBWWaAK0ZBTSujpm6pnLmNn4LBvaGKGb
 FIuFaoWKMu1sdaIGCWABd73Cn+TqOkAE6VQaZVL549iGbTnhf3DKHdxEIHqbeo/aXXTPGZaTqe
 +tpaflbHNKbMawRldN6rBtRQSb+kHsfegrGOEY9/trM3dyOy40S5C/3h6X3xqPzaB3C1mxuy1D
 Llw=
X-IronPort-AV: E=Sophos;i="5.69,246,1571673600"; 
   d="scan'208";a="125670931"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 03:12:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HURcx1037FCqvqmCXaA1A3b2PneejtYXKfapF6jWLKb9+c6SBW5zYJ8ZhxqTpxpbOe2BLt2cw++1RRrWhcmfN67WWOzmxVlZZQxbYT+ncslmVELHt433o8JgniLCtt+tjVfKgeNuzVLuJSX47Z/RhzpWuzfoo47QpoS+ZBwYgk3FXUewu+8sEzIdM570q7nOPwqjsZvULpRvJ5eauQxVCPI9znyMUzwtCGC1JV3uxaECUNutveURV1TsNBZuJ6STjTb6GEsNByMigo1Jf8zjvvzce22WV7xGtmmcYXImgkT/ES1/1X7YL/zmt38Ohgce8/MqC5e13aF3xKyOf06xBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+JxvNoXq3UAD7DRH+k72uPXzjJus7iETq/4nsBX7HY=;
 b=jcPaRyjzwoIJAXWqrIWCWoC1DxS7/Wywm1cMY3COWrbux28dyan0ZFHdWqkT30/uKOAxTjuY//br3USBLh46SVHmSgqUmR609aGY95ThoByyy45gaFjTGtkT7Qe3leY61N5prWnFh/sCFCzA9QGsMzJv8k8IAGA2zopP23Eh3QLmp//QtT4tkqKOlW/d5C2XfKp5VKqfxkrYZ1cENrQivBgGovVNh5LHUBEOnR+UXk4GtMdeOPGiH/vajDN67hWWO9fdE/KSoL4g9ghOpZU8eTM6x95SmJc/wDYY5mLLxJpTPDXZuyJr54bhScrnuR7WcmvUMBVN+F38sB05hF6TKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+JxvNoXq3UAD7DRH+k72uPXzjJus7iETq/4nsBX7HY=;
 b=gPDqufTweS2Dsm+pd/njp1nhQUwZwu0nanl6QSwpBCziDNlWhu0bSwhAcxplzIIA84iHERdYs6GrP8JDwTyYD5msFKFBLSyPJ4x8v25UlYqpIp23HHWOs2Kx2m1eRbaRpTNpNgn3pFOeJg8buPROrtvEqY3oDMETgPdeY5f7zMc=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5959.namprd04.prod.outlook.com (20.178.235.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Tue, 26 Nov 2019 19:12:23 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7%3]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 19:12:22 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "hch@lst.de" <hch@lst.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Topic: [PATCH 1/4] RISC-V: Add kconfig option for QEMU virt machine
Thread-Index: AQHVo5Nfdy6Dk930FkiYD7mQlZsw86ed07UA
Date:   Tue, 26 Nov 2019 19:12:22 +0000
Message-ID: <256d158d64bc747431855f4593e008ff744fdcfd.camel@wdc.com>
References: <20191125132147.97111-1-anup.patel@wdc.com>
         <20191125132147.97111-2-anup.patel@wdc.com>
In-Reply-To: <20191125132147.97111-2-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2601:646:8280:fdf0:69be:1cca:a557:65ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0d7db1a-1fe8-4207-3d68-08d772a4910d
x-ms-traffictypediagnostic: BYAPR04MB5959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB59593FB77223BE95950213ECFA450@BYAPR04MB5959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(189003)(199004)(5660300002)(2616005)(2171002)(71190400001)(71200400001)(11346002)(446003)(46003)(76176011)(305945005)(36756003)(316002)(81156014)(4001150100001)(6116002)(8676002)(6506007)(8936002)(81166006)(7736002)(102836004)(2501003)(54906003)(256004)(99286004)(2906002)(478600001)(6512007)(86362001)(186003)(14454004)(6486002)(6246003)(66946007)(4326008)(66556008)(110136005)(66476007)(76116006)(66446008)(64756008)(25786009)(6436002)(118296001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5959;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEpmhXz3cJ3UKxRSFHTdYm70x6VV9KdZjkttc01aW1Mqll97lda2yNGtZQNklrjOqOoWe4mg11ogZHPaVt0v9ZqaFHkFEvxuwMsGsEim7pz7XJr0XrBjFhAuqrGYLenXGOgKq8hkhKTgY8rW2uVnLGONvUi4qLn8udVYoGZ8AGN+C0fXuGfHDWVUGOk6hpYc/HtBN6ETAM+gcIu3hdAKNDf4E5+WBvnRfaRhbZ6hr8TlJrixIa0iFQhB7PORllBlSXiqX81Jv8EVEX+D/vEG/96zZqf1hsr32Lrb8TUupALFewZU+5kT9QUkNJr5R+VbUxuThRHcRfP08nHOGtA9HLNuj4rYMqo8LrwShrQ8WpdAxNn1LUK+80h/EmgTdcd8VltZr5BIpRQbcis841aPgKmeolLEqlZKW5407If9d3FGZs8rHqcj45sD3O7aOkh/
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8993BB3D52D3A42B7BB29DB05DBA6E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d7db1a-1fe8-4207-3d68-08d772a4910d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 19:12:22.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yH/w0ZCbtUKxUfE3aeHoYb8x9gjUAFD5Bwwhrk3Li6KhnRzfJiDTlEFW5t3TBhOWshRYii8T/eGHDLSlSdmXFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTExLTI1IGF0IDEzOjIyICswMDAwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBX
ZSBhZGQga2NvbmZpZyBvcHRpb24gZm9yIFFFTVUgdmlydCBtYWNoaW5lIGFuZCBzZWxlY3QgYWxs
DQo+IHJlcXVpcmVkIFZJUlRJTyBkcml2ZXJzIHVzaW5nIHRoaXMga2NvbmZpZyBvcHRpb24uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBhdGVsIDxhbnVwLnBhdGVsQHdkYy5jb20+DQo+IC0t
LQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnLnNvY3MgfCAyMCArKysrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL3Jpc2N2L0tjb25maWcuc29jcyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+IGluZGV4
IDUzNmMwZWY0YWVlOC4uNjIzODM5NTFiZjJlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L0tj
b25maWcuc29jcw0KPiArKysgYi9hcmNoL3Jpc2N2L0tjb25maWcuc29jcw0KPiBAQCAtMTAsNCAr
MTAsMjQgQEAgY29uZmlnIFNPQ19TSUZJVkUNCj4gICAgICAgICBoZWxwDQo+ICAgICAgICAgICBU
aGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgU2lGaXZlIFNvQyBwbGF0Zm9ybSBoYXJkd2FyZS4NCj4g
IA0KPiArY29uZmlnIFNPQ19WSVJUDQo+ICsgICAgICAgYm9vbCAiUUVNVSBWaXJ0IE1hY2hpbmUi
DQo+ICsgICAgICAgc2VsZWN0IFZJUlRJT19QQ0kNCj4gKyAgICAgICBzZWxlY3QgVklSVElPX0JB
TExPT04NCj4gKyAgICAgICBzZWxlY3QgVklSVElPX01NSU8NCj4gKyAgICAgICBzZWxlY3QgVklS
VElPX0NPTlNPTEUNCj4gKyAgICAgICBzZWxlY3QgVklSVElPX05FVA0KPiArICAgICAgIHNlbGVj
dCBORVRfOVBfVklSVElPDQo+ICsgICAgICAgc2VsZWN0IFZJUlRJT19CTEsNCj4gKyAgICAgICBz
ZWxlY3QgU0NTSV9WSVJUSU8NCj4gKyAgICAgICBzZWxlY3QgRFJNX1ZJUlRJT19HUFUNCj4gKyAg
ICAgICBzZWxlY3QgSFdfUkFORE9NX1ZJUlRJTw0KPiArICAgICAgIHNlbGVjdCBSUE1TR19DSEFS
DQo+ICsgICAgICAgc2VsZWN0IFJQTVNHX1ZJUlRJTw0KPiArICAgICAgIHNlbGVjdCBDUllQVE9f
REVWX1ZJUlRJTw0KPiArICAgICAgIHNlbGVjdCBWSVJUSU9fSU5QVVQNCj4gKyAgICAgICBzZWxl
Y3QgU0lGSVZFX1BMSUMNCj4gKyAgICAgICBoZWxwDQo+ICsgICAgICAgICBUaGlzIGVuYWJsZXMg
c3VwcG9ydCBmb3IgUUVNVSBWaXJ0IE1hY2hpbmUuDQo+ICsNCj4gIGVuZG1lbnUNCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0K
DQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
