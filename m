Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA16AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C5523431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lH1236id";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NTFRB/Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfH3XN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:13:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33656 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbfH3XN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567206861; x=1598742861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=idaZZxYLZeoZpQOSdYf19iYiDOd/EXK2Lstx5Pdel6U=;
  b=lH1236idl3PVFd+UglQT+3xLG+79S5obXEuQkWS2W78tVTy9p4YAYdQQ
   bVzxOg+Rk8SElYSvPHLuvNgGxBi9UA7xIAtfAc/Bbz15QZuxualvqxpiA
   pqhmqG8k+3ckVBJ27+M/ByDsJAYu/zQbSo3EAZQDNEl7RH+wo3iXVZgDK
   9sGnElXFIiObeFmEi6yAsGUbN8H29yowsm9HLW0i+tdO+TKy4SqcDuCGx
   Et0WhuVsiAAgcV6z/pbYgwxsTIzPO/FyOkae1Lnhu5tQjgcTJoCHZUvWl
   AIeLS/OSMHU8pNpKo87rIw+ET/rYEJSipE8uKG8qns+kEA2YNVBvQpnUt
   w==;
IronPort-SDR: n5JhCh4okUxmPKQsPFxYLYUIa3Mgb4VWZGvbXAE58icN2v//dteGmKXy2vzvYsVsT4oNApUqsm
 YFtsPcatcz4FxNqMKKGIg5aVn1738MZk5aaDJTjCmkuzla1DMfmYM1U+51FUvxIQ/u5RzYeeMf
 +xFx8rFJsXlxk6X/CS4PAwM3mYyGwryUSwNNgIdritMqP3PC9JAMuvgDTvOjf3uQsT4X2WBvde
 CXGSuiqxA0URDL9DrhHShCNP8+o99Y+Eryj12FtgAmge48EIfSd4fklixgD29f7zBjMkqW4qDO
 ov0=
X-IronPort-AV: E=Sophos;i="5.64,449,1559491200"; 
   d="scan'208";a="217610664"
Received: from mail-sn1nam01lp2059.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.59])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2019 07:14:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nruJ9W8KfRl4IYErhSMD+iAPmpmBIPP8AULsZAlriSus7wPIYV8AbH62Ko6eajfDqlLMIR/2IGeHPfindqrUWQX0nP5H8j1vj70ezSf+T8UAOReSZ6XKMZGBJLZ1vI7GDLBJ3ABB9rIGLCxv9oce3HSpI2H7WyNDc86hcEsBk35xqt8zjxJDXtcq2FKJjPf21NU9PDTFoXnaF9xB5dLJ9kIpsE3rj1SAuW5I3GOUxmd4Sl5g2xUGh7ljLTpsb8f5ES5gAQb2ylmB7HPPCAGtzYSAc9+KFCMH0HLI7agbplzpGswRK0xe51AYl6mbZXEUCvNVRUQhSlIslC3Qvogz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idaZZxYLZeoZpQOSdYf19iYiDOd/EXK2Lstx5Pdel6U=;
 b=V/2HOdoPen4lyFHdblWWgScjqA3v1HTzO7HJE6QWIgWUQ8Rip6eD2ck8yGZIQPC0kRLvuHrP+b5US9LnWbX1UznOyOU85hEoobiDww/TCiiQ6vtKwxpc5wYvU8IihRoVjaOFIDpFwCiKmeygNni7DV7eUbwsWooI3jNc2cdDy1PAZxtX39YOIDOfx2TVYUY5yXrn+qkPMkUlCw+82ch+gc8BFt9/hDr3u//1UNOFQnO6l7jmLxbySVzGYgMUazZURdVzkGbi0+y7vaIY8tDQpy42PygZH1o+OdlMija2ZfD9woPA0dB3+MQYsS1M1ny8pwyJ0X9FbgdtfLvHPZ00wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idaZZxYLZeoZpQOSdYf19iYiDOd/EXK2Lstx5Pdel6U=;
 b=NTFRB/Wnto2cwitZlXiuOXBQ2gKsygPoT+bNwN90s/0eQwc+RWz3HQ9NuqXktl9vFC/Dz7LY3yI3hfN+lgLD4FgYMwnY/VYTiSdd2Yk+BCbhFN8q9zRVOsEpD+vYChd7LtGQZZXf52vSjiUR8cIbwHQvKZ1tJPoqgWqJaFHPl84=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4134.namprd04.prod.outlook.com (20.176.250.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 23:13:25 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1cc0:3996:ffa5:23c9]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1cc0:3996:ffa5:23c9%5]) with mapi id 15.20.2220.020; Fri, 30 Aug 2019
 23:13:25 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "alankao@andestech.com" <alankao@andestech.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>
Subject: Re: [RFC PATCH 0/2] Add support for SBI version to 0.2
Thread-Topic: [RFC PATCH 0/2] Add support for SBI version to 0.2
Thread-Index: AQHVXGav48Iq39BuIEaKaF29rj3wXqcPE5gAgAB+pYCAAmaSgIACX24A
Date:   Fri, 30 Aug 2019 23:13:25 +0000
Message-ID: <4bd0a62ba36587661574e1bf8b094b0a28ec8941.camel@wdc.com>
References: <20190826233256.32383-1-atish.patra@wdc.com>
         <20190827144624.GA18535@infradead.org>
         <a31c39e8653bd04efe0051a5fd6f0238d33a80e7.camel@wdc.com>
         <20190829105919.GB8968@infradead.org>
In-Reply-To: <20190829105919.GB8968@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7725f00-97a3-4b00-3a77-08d72d9fa8f1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4134;
x-ms-traffictypediagnostic: BYAPR04MB4134:
x-microsoft-antispam-prvs: <BYAPR04MB4134A019DC21EB1922C750FDFABD0@BYAPR04MB4134.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(199004)(189003)(6246003)(6436002)(2616005)(229853002)(476003)(1730700003)(99286004)(486006)(54906003)(76176011)(11346002)(6916009)(316002)(26005)(36756003)(6506007)(8676002)(25786009)(66066001)(81166006)(81156014)(6512007)(53936002)(8936002)(6486002)(5640700003)(5660300002)(478600001)(102836004)(2501003)(6116002)(118296001)(186003)(7416002)(446003)(14454004)(7736002)(2906002)(305945005)(71200400001)(66446008)(66946007)(64756008)(76116006)(256004)(14444005)(71190400001)(66556008)(2351001)(66476007)(86362001)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4134;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aDOmN2HHwGWOvkChQfiMw3OwnycP8uvehyeZJhNHz4oQyUKeiD5kO4BiVjv3xyWjkgFbSq7AWVqxLJkSHSbBaC/XV5JS0Llt+gIvQ7luTFgS9y1B57XaJNqrTEYwoP4OLEEjtUEshaNcIX9V0ql/Y9LF0m3SaeU3wDEToqXrT9xvjXNFw239tzzodWwkPw7WO3pUDPuYX0sJsnD2aG1fdOsf2zhXpZFMDi1mJ/1Ou6BaUGcnpN4kIxFbXtdBOHTAot3Vnh5upe7VlmpMKax1wRDomZ8bFH9Nkc17xnlEv9DK4klDVki/wLPqvecPCfDot8CgPfglrEf1biWlvS3TABiwpNR+ghmQEeDX8SM/++XT73WwfiWPViGdlLRA4U6jnfzIOga2U35IhdzcVCy9VJ4uuaXgc29oB7sSrFFvaeA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FF9975AEF3AB24B8A68052B5A4F1630@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7725f00-97a3-4b00-3a77-08d72d9fa8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 23:13:25.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zs16T0SjjNILeJKC2tNVasv+DFbUiolFBxdBlL2RWW4NDIlmZznTz8QuSCwKH4AbHpyaRJ2geefdbyL693zD1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTI5IGF0IDAzOjU5IC0wNzAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMTA6MTk6NDJQTSArMDAwMCwgQXRpc2ggUGF0
cmEgd3JvdGU6DQo+ID4gSSBkaWQgbm90IHVuZGVyc3RhbmQgdGhpcyBwYXJ0LiBBbGwgdGhlIGxl
Z2FjeSBTQkkgY2FsbHMgYXJlDQo+ID4gZGVmaW5lZCBhcw0KPiA+IGEgc2VwYXJhdGUgZXh0ZW5z
aW9uIElEIG5vdCBzaW5nbGUgZXh0ZW5zaW9uLiBIb3cgZGlkIGl0IGJyZWFrIHRoZQ0KPiA+IGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkgPw0KPiANCj4gWWVzLCBzb3JyeSBJIG1pc3RlYWQgdGhpcy4g
IFRoZSB3YXkgaXMgaXMgZGVmaW5lZCBpcyByYXRoZXINCj4gbm9uLWludHVpdGl2ZSwgYnV0IGFj
dHVhbGx5IGJhY2t3YXJkcyBjb21wYXRpYmxlLg0KPiANCj4gPiBJIHRoaW5rIHRoZSBjb25mdXNp
b24gaXMgYmVjYXVzZSBvZiBsZWdhY3kgcmVuYW1pbmcuIFRoZXkgYXJlIG5vdA0KPiA+IHNpbmds
ZSBsZWdhY3kgZXh0ZW5zaW9uLiBUaGV5IGFyZSBhbGwgc2VwYXJhdGUgZXh0ZW5zaW9ucy4gVGhl
IHNwZWMNCj4gPiBqdXN0IGNhbGxlZCBhbGwgdGhvc2UgZXh0ZW5zaW9ucyBhcyBjb2xsZWN0aXZl
bHkgYXMgbGVnYWN5LiBTbyBJDQo+ID4ganVzdA0KPiA+IHRyaWVkIHRvIG1ha2UgdGhlIHBhdGNo
IHN5bmMgd2l0aCB0aGUgc3BlYy4NCj4gPiANCj4gPiBJZiB0aGF0J3MgdGhlIHNvdXJjZSBvZiBj
b25mdXNpb24sIEkgY2FuIHJlbmFtZSBpdCB0byBzYmlfMC4xX3ggaW4NCj4gPiBzdGVhZCBvZiBs
ZWdhY3kuDQo+IA0KPiBJIHRoaW5rIHdlIGFjdHVhbGx5IG5lZWQgdG8gZml4IHRoZSBzcGVjIGlu
c3RlYWQsIGV2ZW4gaWYgaXQganVzdCB0aGUNCj4gbmFtaW5nIGFuZCBub3QgdGhlIG1lY2hhbmlz
bS4NCj4gDQoNCklmIEkgdW5kZXJzdG9vZCB5b3UgY2xlYXJseSwgeW91IHdhbnQgdG8gY2FsbCBp
dCBsZWdhY3kgaW4gdGhlIHNwZWMgYW5kDQpqdXN0IHNheSB2MC4xIGV4dGVuc2lvbnMuDQoNClRo
ZSB3aG9sZSBpZGVhIG9mIG1hcmtpbmcgdGhlbSBhcyBsZWdhY3kgZXh0ZW5zaW9ucyB0byBpbmRp
Y2F0ZSB0aGF0IGl0DQp3b3VsZCBiZSBvYnNvbGV0ZSBpbiB0aGUgZnV0dXJlLg0KDQpCdXQgSSBh
bSBub3QgdG9vIHdvcnJpZWQgYWJvdXQgdGhlIHNlbWFudGljcyBoZXJlLiBTbyBJIGFtIGZpbmUg
d2l0aA0KanVzdCBjaGFuZ2luZyB0aGUgdGV4dCB0byB2MC4xIGlmIHRoYXQgYXZvaWRzIGNvbmZ1
c2lvbi4NCg0KPiA+ID4gICgxKSBhY3R1YWxseSBib2FyZCBzcGVjaWZpYyBhbmQgaGF2ZSBub3Qg
cGxhY2UgaW4gYSBjcHUNCj4gPiA+IGFic3RyYWN0aW9uDQo+ID4gPiAgICAgIGxheWVyOiBnZXRj
aGFyL3B1dGNoYXIsIHRoZXNlIHNob3VsZCBqdXN0IG5ldmVyIGJlDQo+ID4gPiBhZHZlcnRpc2Vk
IGluDQo+ID4gPiBhDQo+ID4gPiAgICAgICBub24tbGVnYWN5IHNldHVwLCBhbmQgdGhlIGRyaXZl
cnMgdXNpbmcgdGhlbSBzaG91bGQgbm90DQo+ID4gPiBwcm9iZQ0KPiA+ID4gICAgICAgb24gYSBz
YmkgMC4yKyBzeXN0ZW0NCj4gPiANCj4gPiBJbiB0aGF0IGNhc2UsIHdlIGhhdmUgdG8gdXBkYXRl
IHRoZSBkcml2ZXJzKGVhcmx5Y29uLXJpc2N2LXNiaSAmDQo+ID4gaHZjX3Jpc2N2X3NiaSkgaW4g
a2VybmVsIGFzIHdlbGwuIE9uY2UgdGhlc2UgcGF0Y2hlcyBhcmUgbWVyZ2VkLA0KPiA+IG5vYm9k
eQ0KPiA+IHdpbGwgYmUgYWJsZSB0byB1c2UgZWFybHljb249c2JpIGZlYXR1cmUgaW4gbWFpbmxp
bmUga2VybmVsLg0KPiA+IA0KPiA+IFBlcnNvbmFsbHksIEkgYW0gZmluZSB3aXRoIGl0LiBCdXQg
dGhlcmUgd2VyZSBzb21lIGludGVyZXN0IGR1cmluZw0KPiA+IFJJU0MtViB3b3Jrc2hvcCBpbiBr
ZWVwaW5nIHRoZXNlIGZvciBub3cgZm9yIGVhc3kgZGVidWdnaW5nIGFuZA0KPiA+IGVhcmx5DQo+
ID4gYnJpbmd1cC4NCj4gDQo+IFRoZSBnZXRjaGFyL3B1dGNoYXIgY2FsbHMgdW5mb3J0dW5hdGVs
eSBhcmUgZnVuZGFtZW50YWxseSBmbGF3ZWQsIGFzDQo+IHRoZXkgbWVhbiB0aGUgc2JpIGNhbiBz
dGlsbCBhY2Nlc3MgdGhlIGNvbnNvbGUgYWZ0ZXIgdGhlIGhvc3QgaGFzDQo+IHRha2VuDQo+IGl0
IG92ZXIgdXNpbmcgaXRzIG93biBkcml2ZXJzLiAgV2hpY2ggd2lsbCBsZWFkIHRvIGJ1Z3Mgc29v
bmVyIG9yDQo+IGxhdGVyLg0KPiANCj4gQW5kIGlmIHlvdSBjYW4gYnJpbmcgdXAgYSBjb25zb2xl
IGRyaXZlciBpbiBvcGVuc2JpIGl0IHNob3VsZCBiZSBqdXN0DQo+IGFzIHRyaXZpYWwgdG8gYnJp
bmcgdXAgdGhlIGtlcm5lbCB2ZXJzaW9uLg0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
