Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEE8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9E020707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 03:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MY86VHdk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ys/NrJWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfLED60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:58:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728459AbfLED60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 22:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575518305; x=1607054305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZYSVgKihrD9JiIcPAtmtWoqSsGd92X0JMsBQ8GlVeME=;
  b=MY86VHdk859tWRCgO0rbjrYdC/NfVTN30WROPjNdsedcmC5JMYHo5Sy4
   t2EIEkumm8lb5TvMi2sCGHjWmCzC9tNV6jm0L0uPJu1xwjQk1sMqZsNSz
   96oAVFbREl4G5igcS6sNttGCD26ppzWVvDLYiJ1ACjXeVQv95iRPMvBSp
   tHhkUNqAIOlMePSg8yNhNRUy7LWGL1PYr8qStA65XYPEvZcRxwjQ5y3DV
   zLWuJlWcj/1WqpQSPM65PnmaLHi6CxAAjNaOXOeQqL0OiVs9tk2MBJVGz
   AaaoqgW2/rzu0bI312klczrVkhGaYQT8ptt0mfA7UM32qlyhLzV8dfWmP
   A==;
IronPort-SDR: 8JaCMmhAQA3xU6I4QaolqLo1z+Ql8rx4NcNsHZgaPjW+E70pM+HcBDBl7BZzO3isMatxJUnycj
 658pdWEuoafMQNV3rrv45F5uzkX0P48tglfM2vDHMTsEdn7WxDu4m6xXDw7Vis8UWn/S8Xqg+8
 8bPePnU1aqvpRYljSU1hRqXmJXOrckIgkFQTv5CfDTAek/CgzTtFA1C8XERZmrbcn4KaITFQ7n
 vL/OHdIeBZ2UCyNDJ4cOdWs/wRelmpGjgiywv7UAClpfn97PXOf0tUK+74yZ8ji+gito0RmWrK
 Kds=
X-IronPort-AV: E=Sophos;i="5.69,279,1571673600"; 
   d="scan'208";a="124646314"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2019 11:58:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VukLJ46adtPb0J3zjv3t8v7LH7PFKZhHKm8h8cPPHtBwIXkAd3Zzgjsk8Q4dndOHMpM6Am+tBLemmFEmIxSk68hElEUF4TJjfBMov2B2cX+XtBgg/XwYq58SRcQNzVmalNnkbo0lw7fNVtWNtmdOVm0E9dN7u1s6RdQpzvNeweL1Q3uF7p4EMGASqpgiZPSRA7aohpWsq7zXzNjmdTCpnCIxIfgOnLJ1n1yUk3HAjorcNFYGUoYnirvZ/spMXpAnkwzJHb1h2XELVggHSKGCNXA54nBeIfFOY68S7Cq50arLQpWRUiJLi55B7Z9vvr0lHiMajcg6syBCnXPYJFGTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYSVgKihrD9JiIcPAtmtWoqSsGd92X0JMsBQ8GlVeME=;
 b=d2sIU+Y14RWUPBNxpQGd9jyeG7V2T01psctJ3Op56ID7TGY93P/UInQeOGfcDUpNEnFlpz77pjBJ5NT+XtGCA/zhMKVrcEZUkXgH6Z+xvb/e5/ZKKbznT2A4aX4bqk/pMhkmTMAa3tOlrXd4DtaNtSt/ZY9rnoQX3J+qzt2PdJF1MxR+mfLSqbXxxaB+jO5A9su9JxNBq6adoZo2gR1ammOAaoIiQa2Lm/gI8y0hwmJfhRZxB1wNc5Aa+V+Qut/gkUX4IH9atP34mrPT/poigeWv6RPtPkPRIeQkf7zk53zd+F9B9TZ2Pas5+ate4QpOmRU7j5jVSR61TwbJtz8bBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYSVgKihrD9JiIcPAtmtWoqSsGd92X0JMsBQ8GlVeME=;
 b=Ys/NrJWFz7qXaaJJSZaDJHAjZws8zlX9RYc9IDDCgB0jHtX677LO09a2Wd58jQNGsMQsh9qFqQtSt7U5tXIoDsSDF0H54SOxxD2ipSFzwe52LklgKJQy/7Gsx9KmyRLKcvRFcNJZANJJTtkwNK4Asa/KbHN9hFAjMLFXSloq8/o=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
 BYAPR04MB3861.namprd04.prod.outlook.com (52.135.214.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Thu, 5 Dec 2019 03:58:22 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::545f:1547:d48a:7fbc]) by BYAPR04MB4901.namprd04.prod.outlook.com
 ([fe80::545f:1547:d48a:7fbc%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 03:58:21 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
Thread-Topic: [GIT PULL] Second set of RISC-V updates for v5.5-rc1
Thread-Index: AQHVqoAixayXodMShUatl8RuOOpeiKep7kMAgABfWICAABJLgIAAAdGAgAB4CACAABG3AA==
Date:   Thu, 5 Dec 2019 03:58:20 +0000
Message-ID: <84c4ee600c0dd235a0fcc257115807af7207b5f6.camel@wdc.com>
References: <alpine.DEB.2.21.9999.1912040050430.56420@viisi.sifive.com>
          <CAAhSdy2id0FoLBxWwN7WHEk5Am770BizkK=sZO0-G54MtYa6DQ@mail.gmail.com>
          <9044bad02aa6553cdb2523294500b50fccf3fd2a.camel@wdc.com>
          <alpine.DEB.2.21.9999.1912041128400.186402@viisi.sifive.com>
         <81530734312456aab8b9625d7e9bb071c43db1c5.camel@wdc.com>
         <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1912041644170.206929@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [2601:646:8e00:37b2:d3fd:11e9:7cc1:adaf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2acc84bd-270a-46c0-920b-08d779375e9f
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB386135AD772A5E8B2EBD07B9905C0@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(305945005)(81166006)(316002)(7736002)(5640700003)(2351001)(2501003)(4326008)(6916009)(186003)(66446008)(66476007)(66556008)(6436002)(66946007)(99286004)(64756008)(54906003)(6246003)(5660300002)(76116006)(6486002)(229853002)(6512007)(6306002)(11346002)(2616005)(15650500001)(14444005)(118296001)(14454004)(478600001)(81156014)(86362001)(6116002)(8676002)(71190400001)(966005)(25786009)(6506007)(102836004)(8936002)(36756003)(76176011)(2906002)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3861;H:BYAPR04MB4901.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gEKPwxV+uY5K09Mat52iAEq/9cb5e7xpv0zetq0cuz6RNy18d83l/XsR3U/byST4RjMjbcbtsovZ+WwWKV92fCZI9Tcbz8zT3nBprK4iqHVZv0QpAdO333yETh1fEloQdhuJL03miq1MMhg2uwT8hROz4YveI/DR+l58kkJTRL2ySJKgOV4KFPmGrprOp0zZZfx7PSTJKAemZl7gtUFcaAfD2GxnP8CLdTooyNeDuGHsEmp723+38jQ8+uF7g2nv83mNTYuZhoDzuLtC2ttR61xuZqUkT/uVi7OMQ4lu4fK1zDy68mFPeeRQVOyoW/WKTCRAJ4nBDE9xIlqYoj1FHzKIip+NO7d6PbhA40CFlLlkcYCLs2446OjZKvALj+pV1zruGHr1DbxZ9vkeKEcZ0c6STc5cS/jkvnL7bocJwLeNbh6t9DtRh+xCY7RAZP4dmvHqXLIenhBJn7Z6Dt4PCPIL84993pRtKwt6sLLIkTU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18FD81BE44FAE1409D69A884BA96D18B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc84bd-270a-46c0-920b-08d779375e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 03:58:21.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNWE4ASSmH30DNY6n4AnxBQLPHuK8DE0+ZF15UhjOJTws55l3TgcO7aDND8f8MVMhqKecHw2vCyyG83MUTqv/FJpmuRuiKBiheJODWUN/88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTA0IGF0IDE4OjU0IC0wODAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBPbiBXZWQsIDQgRGVjIDIwMTksIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+IA0KPiA+IFRo
YXQgaXMganVzdCBub3Qgd2hhdCBoYXBwZW5zIHRob3VnaC4NCj4gPiANCj4gPiBJdCBpcyB0b28g
bXVjaCB0byBleHBlY3QgZXZlcnkgZGlzdHJvIHRvIG1haW50YWluIGEgZGVmY29uZmlnIGZvcg0K
PiA+IFJJU0MtIA0KPiA+IFYuIA0KPiANCj4gVGhlIG1ham9yIExpbnV4IGRpc3RyaWJ1dGlvbnMg
bWFpbnRhaW4gdGhlaXIgb3duIGtlcm5lbA0KPiBjb25maWd1cmF0aW9uIA0KPiBmaWxlcywgY29t
cGxldGVseSBpZ25vcmluZyBrZXJuZWwgZGVmY29uZmlncy4gIFRoaXMgaGFzIGJlZW4gc28gZm9y
IGENCj4gbG9uZyANCj4gdGltZS4NCg0KVGhhdCBtaWdodCBiZSB0cnVlIGZvciB0aGUgdHJhZGl0
aW9uYWwgImRlc2t0b3AiIGRpc3Ryb3MsIGJ1dCBlbWJlZGRlZA0KZGlzdHJvcyAodGhlIG1haW4g
dGFyZ2V0IGZvciBSSVNDLVYgYXQgdGhlIG1vbWVudCkgZG9uJ3QgZ2VuZXJhbGx5IGRvDQp0aGlz
Lg0KDQo+IA0KPiA+IFdoaWNoIGlzIHdoeSB3ZSBjdXJyZW50bHkgdXNlIHRoZSBkZWZjb25maWcg
YXMgYSBiYXNlIGFuZCBhcHBseQ0KPiA+IGV4dHJhIA0KPiA+IGZlYXR1cmVzIHRoYXQgZGlzdHJv
IHdhbnQgb24gdG9wLg0KPiANCj4gQXMgeW91IGtub3csIHNpbmNlIHlvdSd2ZSB3b3JrZWQgb24g
c29tZSBvZiB0aGUgZGlzdHJpYnV0aW9uIGJ1aWxkZXIgDQo+IGZyYW1ld29ya3MgKG5vdCBkaXN0
cmlidXRpb25zKSBsaWtlIE9FIGFuZCBCdWlsZHJvb3QsIHRob3NlIGJ1aWxkDQo+IHN5c3RlbXMg
DQo+IGhhdmUgc29waGlzdGljYXRlZCBrZXJuZWwgY29uZmlndXJhdGlvbiBwYXRjaGluZyBhbmQg
b3ZlcnJpZGUgc3lzdGVtcw0KPiB0aGF0IA0KPiBjYW4gZGlzYWJsZSB0aGUgZGVidWcgb3B0aW9u
cyBpZiB0aGUgbWFpbnRhaW5lcnMgdGhpbmsgaXQncyBhIGdvb2QNCj4gaWRlYSB0byANCj4gZG8g
dGhhdC4NCg0KWWVzIHRoZXkgZG8uIEFzIEkgc2FpZCwgd2Ugc3RhcnQgd2l0aCB0aGUgZGVmY29u
ZmlnIGFuZCB0aGVuIGFwcGx5DQpjb25maWcgY2hhbmdlcyBvbiB0b3AuIEV2ZXJ5IGRpdmVyc2lv
biBpcyBhIG1haW50YWluZW5jZSBidXJkZW4gc28NCndoZXJlIHBvc3NpYmxlIHdlIGRvbid0IG1h
a2UgYW55IGNoYW5nZWQuIEFsbCBvZiB0aGUgUUVNVSBtYWNoaW5lcw0KY3VycmVudGx5IGRvbid0
IGhhdmUgY29uZmlnIGNoYW5nZXMgKGFuZCBob3BlZnVsbHkgbmV2ZXIgd2lsbCkgYXMgaXQncw0K
YSBwYWluIHRvIG1haW50YWluLg0KDQo+IA0KPiBZb3UndmUgY29udHJpYnV0ZWQgdG8gYm90aCBC
dWlsZHJvb3QgYW5kIE9FIG1ldGEtcmlzY3YgUklTQy1WIGtlcm5lbCANCj4gY29uZmlndXJhdGlv
biBmcmFnbWVudHMgeW91cnNlbGYsIHNvIHRoaXMgc2hvdWxkbid0IGJlIGEgcHJvYmxlbSBmb3IN
Cj4geW91IA0KPiBpZiB5b3UgZGlzYWdyZWUgd2l0aCBvdXIgY2hvaWNlcyBoZXJlLiAgRm9yIGV4
YW1wbGUsIGhlcmUncyBhbg0KPiBleGFtcGxlIG9mIA0KPiBob3cgdG8gcGF0Y2ggZGVmY29uZmln
IGRpcmVjdGl2ZXMgb3V0IGluIEJ1aWxkcm9vdDoNCj4gDQo+ICAgDQo+IGh0dHBzOi8vZ2l0LmJ1
aWxkcm9vdC5uZXQvYnVpbGRyb290L3RyZWUvYm9hcmQvcWVtdS9jc2t5L2xpbnV4LWNrODA3LmNv
bmZpZy5mcmFnbWVudCNuMw0KPiANCj4gSSdtIGFzc3VtaW5nIHlvdSBkb24ndCBuZWVkIGFuIGV4
YW1wbGUgZm9yIG1ldGEtcmlzY3YsIHNpbmNlIHlvdSd2ZSANCj4gYWxyZWFkeSBjb250cmlidXRl
ZCBSSVNDLVYtcmVsYXRlZCBrZXJuZWwgY29uZmlndXJhdGlvbiBmcmFnbWVudHMgdG8NCj4gdGhh
dCANCj4gcmVwb3NpdG9yeS4NCg0KQXMgSSBzdGF0ZWQsIHRoaXMgaXMgcG9zc2libGUuIEl0J3Mg
anVzdCBhIHBhaW4gdG8gbWFpbnRhaW4gYW5kIGZvciB0aGUNClFFTVUgbWFjaGluZXMgd2lsbCBw
cm9iYWJseSBub3QgaGFwcGVuLg0KDQpXZSBhcmUgdHJ5aW5nIHRvIHJlbW92ZSBSSVNDLVYgc3Bl
Y2lmaWMgY2hhbmdlcywgbm90IGFkZCBtb3JlLg0KDQo+IA0KPiA+IEV4cGVjdGluZyBldmVyeSBk
aXN0cm8gdG8gaGF2ZSBhIGtlcm5lbCBkZXZlbG9wZXJzIGxldmVsIG9mDQo+ID4ga25vd2xlZGdl
DQo+ID4gYWJvdXQgY29uZmlndXJpbmcgS2NvbmZpZ3MgaXMganVzdCB1bnJlYWxpc3RpYy4NCj4g
DQo+IEkgdGhpbmsgaXQncyBmYWxzZSB0aGF0IG9ubHkga2VybmVsIGRldmVsb3BlcnMga25vdyBo
b3cgdG8gZGlzYWJsZQ0KPiBkZWJ1ZyANCj4gb3B0aW9ucyBpbiBLY29uZmlnIGZpbGVzLiAgQXMg
ZmFyIGFzIHRoZSB1bmRlcmx5aW5nIHByZW1pc2UgdGhhdCBvbmUgDQo+IHNob3VsZG4ndCBleHBl
Y3QgZGlzdHJpYnV0aW9uIG1haW50YWluZXJzIHRvIGtub3cgaG93IHRvIGNoYW5nZQ0KPiBLY29u
ZmlnIA0KPiBvcHRpb25zLCB3ZSdsbCBqdXN0IGhhdmUgdG8gYWdyZWUgdG8gZGlzYWdyZWUuDQoN
CkRvIHlvdSByZWFsbHkgZXhwZWN0IGV2ZXJ5IGRpc3RvIHRvIGZvbGxvdyBhbGwgb2YgdGhlIGtl
cm5lbCBjaGFuZ2VzDQphbmQgZ2VuZXJhdGUgdGhlaXIgb3duIGNvbmZpZyBiYXNlZCBvbiB3aGF0
IGhhcHBlbmVkIGluIHRoZSBrZXJuZWwgdHJlZQ0Kc2luY2UgdGhlIGxhc3QgcmVsZWFzZT8gV2Ug
ZG9uJ3QgYWxsIGp1c3Qgc3BlbmQgb3VyIGRheXMgYWRqdXN0aW5nIHRvDQp0aGUgTGludXgga2Vy
bmVsLg0KDQpUaGlzIGlzIGVzcGljaWFsbHkgdHJ1ZSBmb3IgUklTQy1WIGFzIGl0J3MgbmV3IGFu
ZCBjb25zdGFudGx5IGNoYW5naW5nLg0KDQo+IA0KPiA+ID4gZGlzdHJvcyBhbmQgYmVuY2htYXJr
ZXJzIHdpbGwgY3JlYXRlIHRoZWlyIG93biBLY29uZmlncyBmb3IgdGhlaXINCj4gPiA+IG5lZWRz
Lg0KPiA+IA0KPiA+IExpa2UgSSBzYWlkLCB0aGF0IGlzbid0IHRydWUuIEFmdGVyIHRoaXMgcGF0
Y2ggaXMgYXBwbGllZCAoYW5kIGl0DQo+ID4gbWFrZXMgDQo+ID4gaXQgdG8gYSByZWxlYXNlKSBh
bGwgT0UgdXNlcnMgd2lsbCBub3cgaGF2ZSBhIHNsb3dlciBSSVNDLVYga2VybmVsLg0KPiANCj4g
T0UgZG9lc24ndCBoYXZlIGFueSBSSVNDLVYgc3VwcG9ydCB1cHN0cmVhbSwgc28gcHVyZSBPRSB1
c2VycyB3b24ndA0KPiBub3RpY2UgDQoNClRoYXQgaXMganVzdCBub3QgdHJ1ZS4gWW91IHRhbGsg
bGF0ZXIgYWJvdXQgbWlzaW5mb3JtYXRpb24gYnV0IHRoaXMgaXMNCmEgYmxhdGVudCBsaWUuDQoN
Cj4gYW55IGNoYW5nZSBhdCBhbGwuICBBc3N1bWluZyB5b3UncmUgdGFsa2luZyBhYm91dCBtZXRh
LXJpc2N2IHVzZXJzOg0KPiBhcyANCj4gbm90ZWQgYWJvdmUsIGl0J3Mgc2ltcGxlIHRvIGF1dG9t
YXRpY2FsbHkgcmVtb3ZlIEtjb25maWcgZW50cmllcyB5b3UgDQo+IGRpc2FncmVlIHdpdGgsIG9y
IGFkZCBvbmVzIHlvdSB3YW50Lg0KPiANCj4gPiBOb3cgaW1hZ2Ugc29tZSBjb21wYW55IHdhbnRz
IHRvIGludmVzdGlnYXRlIHVzaW5nIGEgUklTQy1WIGNoaXAgZm9yDQo+ID4gdGhlaXIgZW1iZWRk
ZWQgcHJvamVjdC4gVGhleSB1c2UgT0UvYnVpbGRyb290IHRvIGJ1aWxkIGEgcXVpY2sgdGVzdA0K
PiA+IHNldHVwIGFuZCBib290IExpbnV4LiBJdCBub3cgcnVucyBzaWduaWZpY2FudGx5IHNsb3dl
ciB0aGVuIHNvbWUNCj4gPiBvdGhlcg0KPiA+IGFyY2hpdGVjdHVyZSBhbmQgdGhleSBkb24ndCBj
aG9vc2UgUklTQy1WLg0KPiANCj4gVGhlIGJlc3Qgb3B0aW9uIGZvciBuYWl2ZSB1c2VycyB3aG8g
YXJlIHNlZWtpbmcgbWF4aW11bSBwZXJmb3JtYW5jZQ0KPiBpcyB0byANCj4gdXNlIGEgdmVuZG9y
IEJTUC4gIFRoaXMgZ29lcyBiZXlvbmQgc2V0dGluZ3MgaW4gYSBrZXJuZWwgY29uZmlnIGZpbGU6
DQo+IGl0IA0KPiBleHRlbmRzIHRvIGNvbXBpbGVyIGFuZCBsaW5rZXIgb3B0aW1pemF0aW9uIGZs
YWdzLCBMVE8sIGFjY2VsZXJhdG9yIA0KPiBmaXJtd2FyZSBhbmQgbGlicmFyaWVzLCBub24tdXBz
dHJlYW1lZCBwZXJmb3JtYW5jZS1yZWxhdGVkIHBhdGNoZXMsIA0KPiB2ZW5kb3Igc3VwcG9ydCwg
ZXRjLg0KDQpXaGF0PyBIb3cgbWFueSBwZW9wbGUgYWN0dWFsbHkgZG8gdGhpcyBmb3IgZW1iZWRk
ZWQgc3lzdGVtcy4NCg0KSSBhZ3JlZSB0aGF0IGlmIHlvdSByZWFsbHkgd2FudCB0byBtYXhpbWlz
ZSBpdCBhcyBtdWNoIGFzIHlvdSBjYW4geW91DQp3aWxsIGdvIHRvIHRoaXMgZWZmb3J0LCBidXQg
SSBkb24ndCB0aGluayBtb3N0IHBlb3BsZSBkby4gSSB0aGluayB3ZQ0KYWxsIGtub3cgdGhhdCBs
b3RzIG9mIHRpbWVzIGVtYmVkZGVkIExpbnV4IGlzIGp1c3QgaGFja2VkIHVudGlsIGl0DQp3b3Jr
cyBhbmQgdGhlbiBzaGlwcGVkLiBJbiB0aGlzIGNhc2UgZGVmYXVsdHMgYXJlIHZlcnkgaW1wb3J0
YW50Lg0KDQo+IA0KPiA+IFNsb3dpbmcgZG93biBhbGwgdXNlcnMgdG8gaGVscCBrZXJuZWwgZGV2
ZWxvcGVycyBkZWJ1ZyBzZWVtcyBsaWtlDQo+ID4gdGhlDQo+ID4gd3JvbmcgZGlyZWN0aW9uLiBL
ZXJuZWwgZGV2ZWxvcGVycyBzaG91bGQga25vdyBlbm91Z2ggdG8gYmUgYWJsZSB0bw0KPiA+IHR1
cm4gb24gdGhlIHJlcXVpcmVkIGNvbmZpZ3MsIHdoeSBkb2VzIHRoaXMgbmVlZCB0byBiZSB0aGUg
ZGVmYXVsdD8NCj4gDQo+IEl0J3MgY2xlYXIgeW91IHN0cm9uZ2x5IGRpc2FncmVlIHdpdGggdGhl
IGRlY2lzaW9uIHRvIGRvIHRoaXMuICBJdCdzIA0KPiBjZXJ0YWlubHkgeW91ciByaWdodCB0byBk
byBzby4gIEJ1dCBpdCdzIG5vdCBnb29kIHRvIHNwcmVhZA0KPiBtaXNpbmZvcm1hdGlvbiANCj4g
YWJvdXQgaG93IGNoYW5naW5nIHRoZSBkZWZjb25maWdzICJzbG93W3NdIGRvd24gYWxsIHVzZXJz
LCIgb3IgDQoNCldoYXQgbWlzaW5mb3JtYXRpb24/DQoNCkFudXAgc2hhcmVkIGJlbmNobWFya2lu
ZyByZXN1bHRzIGluZGljYXRpbmcgdGhhdCB0aGlzIGNoYW5nZSBoYXMgYSAxMiUNCnBlcmZvcm1h
bmNlIGRlY3JlYXNlIGZvciBldmVyeW9uZSB3aG8gdXNlcyB0aGUgZGVmY29uZmlnIHdpdGhvdXQN
CnJlbW92aW5nIHRoaXMgY2hhbmdlLg0KDQpUaGF0IGlzIGV2ZXJ5b25lIHdobyBkb2Vzbid0IGRl
Y2lkZSB0byByZW1vdmUgY29uZmlnIG9wdGlvbnMgZnJvbSB0aGUNCmRlZmF1bHQgY29uZmlnIHN1
cHBsaWVkIGJ5IHRoZSBwZW9wbGUgd2hvIHdyb3RlIHRoZSBjb2RlIGFyZSBub3cgc3R1Y2sNCndp
dGggYSBsYXJnZSBwZXJmb3JtYW5jZSBoaXQuIFBhc3NpbmcgdGhlIGJ1Y2sgYW5kIHNheWluZyB0
aGF0IHBlb3BsZQ0Kc2hvdWxkIGJlIGNoYW5naW5nIHRoZSBkZWZjb25maWcgY2Fubm90IGJlIHRo
ZSByaWdodCBzb2x1dGlvbiBoZXJlLg0KDQo+IGV4YWdnZXJhdGluZyB0aGUgZGlmZmljdWx0eSBm
b3IgZG93bnN0cmVhbSBzb2Z0d2FyZSBlbnZpcm9ubWVudHMgdG8NCj4gYmFjayANCj4gdGhpcyBj
aGFuZ2Ugb3V0IGlmIHRoZXkgd2lzaC4NCg0KSWYgeW91IHRoaW5rIGl0IGlzIHRoYXQgZWFzeSBj
YW4geW91IHBsZWFzZSBzdWJtaXQgdGhlIHBhdGNoZXM/DQoNCkkgdW5kZXJzdGFuZCBpdCdzIGVh
c3kgdG8gbWFrZSBkZWNpc2lvbnMgdGhhdCBzaW1wbGZ5IHlvdXIgZmxvdywgYnV0DQp0aGlzIGhh
cyByZWFsIG5lZ2F0aXZlIGNvbnNlcXVlbmNlcyBpbiB0ZXJtcyBvZiBwZXJmb3JtYW5jZSBmb3Ig
dXNlcnMNCm9yIGNvbXBsZXhpdHkgZm9yIG1haW50YWluZXJzLiBJdCB3b3VsZCBiZSBuaWNlIGlm
IHlvdSB0YWtlIG90aGVyIHVzZXJzDQovZGV2ZWxvcGVycyBpbnRvIGFjY291bnQgYmVmb3JlIG1l
cmdpbmcgY2hhbmdlcy4NCg0KQWxpc3RhaXINCg0KPiANCj4gDQo+IC0gUGF1bA0K
