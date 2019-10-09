Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD57EECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC9820B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O0h7sRfT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EmrSZwBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbfJIWC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:02:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3692 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfJIWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1570658546; x=1602194546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+zsaZc6kxpwaRjehPSTssL3stLwWwuaV9Og6AnYp1GU=;
  b=O0h7sRfTolrsbRalfJAq8aNJc/VbxENt1SsTNmACvsY3BZvttVzCWPhR
   V4TpEvB8C/GirnWKe7l9FrHJt5p+1S3akqdGayrVXO7DfSDD8OCriMOBl
   IAko81UX5EQFpWo9wAk1wkhcqVnerjW329qainK/RK15eG8l/Ql8dEPU0
   wP9+YBHNRuwCSq0zFY9gYxCtSdkquc0xteJ6sZl33QgH+TPi8YpVRlBqE
   3A9vyD4WYwjq+b2M/SQYNhU8x2RMVcgvt0V03CGvQuEI+mRpkk+dNyOTC
   n8eFSkIY8oGQKf5hV1RB7b6IPXY+ZlOxQ9cUseJ/qTuu+PJ+yes3evxE2
   w==;
IronPort-SDR: g4DVKxNJNsTgbZCVowb9EVMk2kF0VBA3ygDRnI76AfWUfntHRZirEg9klW+mz+hO5VQ3LXkp21
 F7vb7ccanTN2v2TLVex5W3FjNhEEuoonbwkQblk3/FUqhHPt/tcFoFWsBA9oK6namLGbRr4eUR
 1UcVnBb2XoaAVn3zxJq2cxcE7VAAup31a3py+0P9CNmHnu7ScsjLQX0hm31Ac65aroCX1MEcnr
 UH8l0XS9ZXaitCm+N+8WRFqep0X/dxjTpQf4Unb4LVUTT2VXSwVdSb+SAj1Zv0WWTo516tJtK6
 OTA=
X-IronPort-AV: E=Sophos;i="5.67,277,1566835200"; 
   d="scan'208";a="124618111"
Received: from mail-dm3nam05lp2058.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.58])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2019 06:02:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChgIetBlMxCaxTGojATCoSCsVH18MkWDiDXQ6Mlr1eJCo9V+jRAKQsXrApCx8Rswh1dx3sZ2rhP0VNIiBKVb9Cqm2rq/Igtiv8n1s+Vbjbw2IZbQibIj+g1IHl1qZhN91RstluTX0wd59hBfLqDAmA/MwR20isaAdVQ+AlngPpH/s21WXBYNE+K4PrYHYXH604GkaJpT9tpfgPBnVkk3X4CYTHRnSMvYMTBTh/Ht11pH6ACX3tSWq8jWJoI08i+FiMaojrsbsmjsLL+d+0sbPVZikPK9KOMLEtJ+RevjZyEmU3dFmupOrq8WP3PrufVm4CqKSUk5rk7V4PzG9F+mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zsaZc6kxpwaRjehPSTssL3stLwWwuaV9Og6AnYp1GU=;
 b=XAgcOr66jxTmZFajZUfTC24QHRpMSIsNRmCE6iPfV0Wx3xz1V93v/mvqsVBtOuSEGXk7bQsi9F2r8tz2ID6KVHZFJzjiFlP9kDpsSd0bEslGQWjR798zSENhOswH1YrkfpekmKdrHtRMUgCTP8qmsftZbX/wI7DrYayh9TCyAzsZONG9IzULyOpbKjsZeW7NjMicFG4Uxr+mov1ue31MgTRHXsKPBJ9SNIXXapZcDweWTqxzZ1vHsKXE02pQQ0O5MLJm8RP66MGyuCXob141TkbNccMJ4+Kvdct793h9wrc2MAO8veUBJX96XuUXA5ng5j91qUPlmeB6xi63qAF2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zsaZc6kxpwaRjehPSTssL3stLwWwuaV9Og6AnYp1GU=;
 b=EmrSZwByQmz2bp7lHDefUxxgFeNFz2qM3Il7VkNObWdLFrxPFgk2bX5RxzJBP0AS9glJiOZqgOVDPu0OzPudRNMuvd6CgoWOdoEChu/9tAJTFi+Uc7XIyjjfOy4s3kIzgOWtp1ESyGaOTvX5hkLcYtAFvjbBrsPJSMtiokQo6T4=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB5030.namprd04.prod.outlook.com (52.135.234.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 9 Oct 2019 22:02:21 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::51dd:7de9:c4a1:f9f3]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::51dd:7de9:c4a1:f9f3%3]) with mapi id 15.20.2327.026; Wed, 9 Oct 2019
 22:02:21 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aghiti@upmem.com" <aghiti@upmem.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "rfontana@redhat.com" <rfontana@redhat.com>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>
Subject: Re: [v1 PATCH  2/2] RISC-V: Consolidate isa correctness check
Thread-Topic: [v1 PATCH  2/2] RISC-V: Consolidate isa correctness check
Thread-Index: AQHVelHdFNDYeeaoR0C47HAPlzL9UadQ6c0AgAH8AAA=
Date:   Wed, 9 Oct 2019 22:02:21 +0000
Message-ID: <bf56b97914951617cbcc49941737d6714eb762e7.camel@wdc.com>
References: <20191004012000.2661-1-atish.patra@wdc.com>
         <20191004012000.2661-3-atish.patra@wdc.com>
         <20191008154408.GC20318@infradead.org>
In-Reply-To: <20191008154408.GC20318@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8e42985-e488-4b6a-1755-08d74d045c21
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB5030:
x-microsoft-antispam-prvs: <BYAPR04MB5030D4E0BD08A486EA1F5D63FA950@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(256004)(6116002)(71190400001)(4326008)(2351001)(99286004)(476003)(478600001)(2616005)(5660300002)(7736002)(2906002)(3846002)(7416002)(54906003)(36756003)(305945005)(316002)(76116006)(229853002)(71200400001)(66446008)(446003)(6436002)(14454004)(6486002)(6506007)(8936002)(11346002)(2501003)(102836004)(6512007)(6916009)(64756008)(66556008)(76176011)(5640700003)(66476007)(6246003)(25786009)(486006)(86362001)(66066001)(81166006)(118296001)(186003)(1730700003)(26005)(81156014)(66946007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5030;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xQ/mBFQsv7knGYm4Dp7Bc6C9h/GqlvFn1lQJ/7y5p8ftxcoLpAg5C+TurWgWdizAQHNHGNmXVqx9Nm6EIszIgjFjXXJ3UcrZwDeqmZ/R6C3g/ZXa0pP4oL0zD8y5WHNFhcjtaM2uwRiygzY9MOatZL8st+w4wPGlrSRlD5K99JvKsGBWXckNsBEa1msiA7lV82a5NF8dCDjoSISqvjU2XpfmLGdnqSK9+pbIgvzbdxJ4Dh1PCEn+UucuY0VH6AdSMCDkP1q9Wz2cqSt3wVU+4Ds8xKurTp/L0rmnU9qKq7INyuSufv9Dez43q6mL+BPzr9qoRlPFVIGmlPTm+PJHxSid1PKVGM4rkccT2dlPF9dyu6JE3/frnJy0w3ocNKQ2XmtlXalI2FV2E/pNMun0SW+FJdRL9hyVrv7EQjwtPNc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <599FA5FC1033F84281BA3C35FA81F1E3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e42985-e488-4b6a-1755-08d74d045c21
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 22:02:21.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpNmY1RNeJgqwLLe2iOj3yEw4+JRUSnvOh/6H4L/2BwBDhzftJ5YUcdjmNsVq2hOYTVZx85G3DLOMDeCEXrEHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTA4IGF0IDA4OjQ0IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gPiAraW50IHJpc2N2X3JlYWRfY2hlY2tfaXNhKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSwgY29uc3QgY2hhcg0KPiA+ICoqaXNhKQ0KPiA+ICt7DQo+ID4gKwl1MzIgaGFydDsNCj4gPiAr
DQo+ID4gKwlpZiAob2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInJlZyIsICZoYXJ0KSkgew0K
PiA+ICsJCXByX3dhcm4oIkZvdW5kIENQVSB3aXRob3V0IGhhcnQgSURcbiIpOw0KPiA+ICsJCXJl
dHVybiAtRU5PREVWOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChvZl9wcm9wZXJ0eV9yZWFk
X3N0cmluZyhub2RlLCAicmlzY3YsaXNhIiwgaXNhKSkgew0KPiA+ICsJCXByX3dhcm4oIkNQVSB3
aXRoIGhhcnRpZD0lZCBoYXMgbm8gXCJyaXNjdixpc2FcIg0KPiA+IHByb3BlcnR5XG4iLA0KPiA+
ICsJCQloYXJ0KTsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwkvKg0KPiA+ICsJICogTGludXggZG9lc24ndCBzdXBwb3J0IHJ2MzJlIG9yIHJ2MTI4aSwgYW5k
IHdlIG9ubHkgc3VwcG9ydA0KPiA+IGJvb3RpbmcNCj4gPiArCSAqIGtlcm5lbHMgb24gaGFydHMg
d2l0aCB0aGUgc2FtZSBJU0EgdGhhdCB0aGUga2VybmVsIGlzDQo+ID4gY29tcGlsZWQgZm9yLg0K
PiA+ICsJICovDQo+ID4gKyNpZiBkZWZpbmVkKENPTkZJR18zMkJJVCkNCj4gPiArCWlmIChzdHJu
Y21wKCppc2EsICJydjMyaSIsIDUpICE9IDApDQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4g
KyNlbGlmIGRlZmluZWQoQ09ORklHXzY0QklUKQ0KPiA+ICsJaWYgKHN0cm5jbXAoKmlzYSwgInJ2
NjRpIiwgNSkgIT0gMCkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArI2VuZGlmDQo+IA0K
PiBVc2luZyBJU19FTkFCTEVEIGhlcmUgd291bGQgY2xlYW4gdGhlIGNoZWNrcyB1cCBhIGJpdC4N
Cj4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiA+
IGIvYXJjaC9yaXNjdi9rZXJuZWwvY3B1ZmVhdHVyZS5jDQo+ID4gaW5kZXggYjFhZGU5YTQ5MzQ3
Li5lYWFkNWFhMDc0MDMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1ZmVh
dHVyZS5jDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9rZXJuZWwvY3B1ZmVhdHVyZS5jDQo+ID4gQEAg
LTM4LDEwICszOCw4IEBAIHZvaWQgcmlzY3ZfZmlsbF9od2NhcCh2b2lkKQ0KPiA+ICAJCWlmIChy
aXNjdl9vZl9wcm9jZXNzb3JfaGFydGlkKG5vZGUpIDwgMCkNCj4gPiAgCQkJY29udGludWU7DQo+
ID4gIA0KPiA+IC0JCWlmIChvZl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhub2RlLCAicmlzY3YsaXNh
IiwgJmlzYSkpIHsNCj4gPiAtCQkJcHJfd2FybigiVW5hYmxlIHRvIGZpbmQgXCJyaXNjdixpc2Fc
Ig0KPiA+IGRldmljZXRyZWUgZW50cnlcbiIpOw0KPiA+ICsJCWlmIChyaXNjdl9yZWFkX2NoZWNr
X2lzYShub2RlLCAmaXNhKSA8IDApDQo+ID4gIAkJCWNvbnRpbnVlOw0KPiANCj4gRG8gd2UgcmVh
bGx5IGdldCByaWQgb2Ygd2FybmluZ3MgaWYgd2UgZGlkbid0IGZpbmQgYW55dGhpbmcgcHJvcGVy
Pw0KDQpPay4gQWRkZWQgYmFjayB0aGUgd2FybmluZ3MgYW5kIElTX0VOQUJMRUQgaW4gdjIuDQoN
Ci0tIA0KUmVnYXJkcywNCkF0aXNoDQo=
