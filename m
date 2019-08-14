Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2711FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66E120679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 01:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ertisdrz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FkqwKg1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfHNBtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 21:49:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17200 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfHNBtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 21:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565747360; x=1597283360;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rs8ouZzjxXDo41CBvnGowIwaYoVjPNUOtpCtVmqKP/c=;
  b=ErtisdrzxrBTCZFG0+AOKElCgWtZHQcSdpcvWiibea3/ckeMQkRxw+vm
   Ybkta5riKVpdsY1Xi7Zz14Y2+ZWcNvAz8O3tpP4eTswcuDZl2zm0+Wpse
   xyCjQUiwhhfWhQuWT+ZsqqNOojsFzXsixVLqtsNaJE2O342bptcNVV9cm
   lURAzHnl5yGCwG5CCZBp84csHqs68h1CQuAR9kzSPieWDjVzhn3b8TsaU
   6ME9+W7v8EU/0M4kBgRKgtVleMPGDbql9WGabDDo26wp2tf4wcw8YZgXm
   Ki2l/QzRvQyqRxnL4bX6YZIbF2TNgw7UyGryzGlFs1iRfT4hpExHvb66s
   w==;
IronPort-SDR: GRo6Z+TLkeHIU7nL+CFTLSw+OxkETLfT9rS017WHHsn7V6PumOhaI62s3f8ElIyoDbJTevh1lL
 GIQdz6CE7wLTQmBEwaTdR5Cmc0potOlPvq/sJvk9EEW94ct74wKmqd0i82PzlHzsqwpL32taO3
 Nan4BaxcIEm2W4g29yttgnXZOxXJJJaFPeFLIFWzmkZk2CronGkFH82Vsqrm57GoE65JqTenA5
 8keF+csIoYDW00ONTW6V0z226zu2fK7onjKTFSjJEwPpOTvYGQa7DGC/lWxZmSpgeDc/z0rRLU
 xzY=
X-IronPort-AV: E=Sophos;i="5.64,382,1559491200"; 
   d="scan'208";a="116726777"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2019 09:49:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIpuqLgrFRLBya5xtoU7oyK4BsmN1Qrl8c5Ee0qOwNI8jY1+aOZiJNtVvhVl+fbEd++LN8HdKbuDPckttj00GidEjowsxQ9pHjho0kQ3eDwGnEksGimsk0MeRBnYl5Qw43qL1lX1Z1OjQl+02LT+H5a4Vv42fu9bbdzHT+LCrHTwrASsJ7VQ3HF9hC0QrT04hvex7pOg0hSu2gaFpMdPeJc/RdHs6Y4ZsTSS5AZT3IqWcUlqa5c8dJqBogE7uyvItXegBnfAQezgKgwopCwbLSiWybXEZGpbhGsAmd1H6rDyRIUwHkl7jCYcYDA+a9UHHFuBW5j62BjkKb9e3KAy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs8ouZzjxXDo41CBvnGowIwaYoVjPNUOtpCtVmqKP/c=;
 b=NMx0VHYzixDgzVtIO2WR8bOdM972gSz9LMnDMf0lpBz7BV4yWaXOGId6kL7choQv7aN5yZq3irYn6hDTh9x/DPgp2Xlazk4G8Pc32KJgkSylDvSMthEcIyjB3wnOvcm2DvKgl3jaDmX8iOhr8FVQLUADr60Cjqgm3LXzc6btaqM33yfI2i5dha1HExWijdc+7K+nxtwQInHBpA1WL2M1OsYUO2S8A1xqrFGcfXeGbYxOlW3MGweoTnDjc6lgm1vGMloMgwkRD6TU4vnmGL0IJVbJVdWBp25hrfyNcvYqdz/6JQpquypKEKEwcI5L5Jy3/epWCEP+EQQGIv0HOWcUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs8ouZzjxXDo41CBvnGowIwaYoVjPNUOtpCtVmqKP/c=;
 b=FkqwKg1t3tskZaCLywQESeTRN9XL4BF8aZbwRZFo8Lx0sDLZrtA4bHgj95WrnHGhEJ53suDhmaC6ZNEn+eLpAEphZzRL5MlDBI5CN9KT6ryMjGXM2JF1EzlkCHEACoK2BGw1VEfkZYgN0owRDXWxwgVv3E0/4niEkikrjYPkY34=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5990.namprd04.prod.outlook.com (20.178.233.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 01:49:18 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ac9a:967e:70a5:e926%7]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 01:49:18 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Topic: [PATCH] RISC-V: Issue a local tlb flush if possible.
Thread-Index: AQHVTxz5XkoGRRVrekixM0/zCIcSeKb5aq2AgAB8D4A=
Date:   Wed, 14 Aug 2019 01:49:18 +0000
Message-ID: <e2156347093aad1a05e1c59da9110faf703406c0.camel@wdc.com>
References: <20190810014309.20838-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1908131053520.30024@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908131053520.30024@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0322e90c-fd8c-4b85-3a6e-08d720599eb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5990;
x-ms-traffictypediagnostic: BYAPR04MB5990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5990520C0CF08623C30C6E4FFAAD0@BYAPR04MB5990.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(2501003)(25786009)(478600001)(6246003)(4326008)(66476007)(66556008)(76116006)(64756008)(66446008)(6916009)(53936002)(305945005)(8936002)(66066001)(71190400001)(71200400001)(7736002)(81166006)(66946007)(256004)(36756003)(8676002)(81156014)(26005)(6512007)(486006)(14454004)(11346002)(6506007)(316002)(76176011)(54906003)(118296001)(2351001)(102836004)(446003)(2616005)(476003)(5640700003)(6436002)(229853002)(86362001)(3846002)(6116002)(5660300002)(186003)(6486002)(99286004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5990;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hn33LVoYjz3nGRv0WvWG8E+cXM3pcU5/r2rmO+aBuuRWa/3n1Bhn5KIJhGmfJWYhxu9pHf1R+q9/E6t/H6E8b/zSlGpwAUIenkXmqhcaIO7mlZ8A+EyErAehFwlBhswx5RsAL8SuiIKCBYTK6VkBQl+djzMHKIfJKAt6BrQbvxGso0Usp4XF0FsgieuTBbTQEAStQcAkWYmlOA6ft01QN+nDpQBsMFEuFTtCRrcEwpBbii3So7udKZzx07+sDNARu/tGo1rO+sC436rBD/v3uwOqesMKkqnvw7IoJ1kTQTF5HyZRqWG3a4cPcyx8eGYcbCyDSfrGsV1emrWkuVmaRaG8NqgSqpLVbVl86ERAA72j91WzMTjTwo6JRHHg5j8Nmqdjr2mlvmatUJSHDf2ZMITswBY+BUPiomm/1SD7fNI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <140DFC64D05F75478F7595C7E0690F56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0322e90c-fd8c-4b85-3a6e-08d720599eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 01:49:18.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zveAUCspsQ6bcdGewgViOWAq1qTc0kX72bYPABAuo/75raF9D3WpeZWUjjtVgqVHWDDi/hBpVxnHduY7sVF1fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDExOjI1IC0wNzAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBIaSBBdGlzaCwNCj4gDQo+IE9uIEZyaSwgOSBBdWcgMjAxOSwgQXRpc2ggUGF0cmEgd3JvdGU6
DQo+IA0KPiA+IEluIFJJU0MtViwgdGxiIGZsdXNoIGhhcHBlbnMgdmlhIFNCSSB3aGljaCBpcyBl
eHBlbnNpdmUuDQo+ID4gSWYgdGhlIHRhcmdldCBjcHVtYXNrIGNvbnRhaW5zIGEgbG9jYWwgaGFy
dGlkLCBzb21lIGNvc3QNCj4gPiBjYW4gYmUgc2F2ZWQgYnkgaXNzdWluZyBhIGxvY2FsIHRsYiBm
bHVzaCBhcyB3ZSBkbyB0aGF0DQo+ID4gaW4gT3BlblNCSSBhbnl3YXlzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KPiANCj4gQSBm
ZXcgYnJpZWYgY29tbWVudHMvcXVlc3Rpb25zIGJleW9uZCB0aGUgb25lcyB0aGF0IG90aGVycyBo
YXZlDQo+IG1lbnRpb25lZDoNCj4gDQo+IDEuIEF0IHNvbWUgcG9pbnQsIHNvbWUgUklTQy1WIHN5
c3RlbXMgbWF5IGltcGxlbWVudCB0aGlzIFNCSSBjYWxsIGluIA0KPiBoYXJkd2FyZSwgcmF0aGVy
IHRoYW4gaW4gc29mdHdhcmUuICBUaGVuIHRoaXMgbWlnaHQgd2luZCB1cCBiZWNvbWluZw0KPiBh
IA0KPiBkZS1vcHRpbWl6YXRpb24uICBJIGRvbid0IHRoaW5rIHRoZXJlJ3MgYW55dGhpbmcgdG8g
ZG8gYWJvdXQgdGhhdCBpbg0KPiBjb2RlIA0KPiByaWdodCBub3csIGJ1dCBpdCBtaWdodCBiZSB3
b3J0aCBhZGRpbmcgYSBjb21tZW50LCBhbmQgdGhpbmtpbmcgYWJvdXQNCj4gaG93IA0KPiB0aGF0
IGNhc2UgbWlnaHQgYmUgaGFuZGxlZCBpbiB0aGUgcGxhdGZvcm0gc3BlY2lmaWNhdGlvbiBncm91
cC4NCg0KSSBhbSBmaW5lIHdpdGggYWRkaW5nIGEgY29tbWVudC4gQnV0IEkgZGlkIG5vdCB1bmRl
cnN0YW5kIHdoeSB0aGlzDQp3b3VsZCBiZSBkZW9wdGltaXphdGlvbi4gSSBub3QgZXhhY3RseSBz
dXJlIGFib3V0IHRoZSBzeW50YXggb2YgZnV0dXJlDQpUTEIgZmx1c2ggaW5zdHJ1Y3Rpb25zLiBC
dXQgaWYgd2UgaGF2ZSBhIGhhcmR3YXJlIGluc3RydWN0aW9uIGZvcg0KcmVtb3RlIHRsYiBmbHVz
aGluZywgaXQgc2hvdWxkIGJlIGV4ZWN1dGVkIG9ubHkgZm9yIHRoZSBoYXJ0cyBvdGhlcg0KdGhh
biBjdXJyZW50IGhhcnQuIFJpZ2h0ID8gDQoNCj4gMi4gSWYgdGhpcyBwYXRjaCBtYXNrcyBvciBy
ZWR1Y2VzIHRoZSBsaWtlbGlob29kIG9mIGhpdHRpbmcgdGhlIA0KPiBUTEItcmVsYXRlZCBjcmFz
aGVzIHRoYXQgd2UncmUgc2VlaW5nLCB3ZSBwcm9iYWJseSB3aWxsIHdhbnQgdG8gaG9sZA0KPiBv
ZmYgDQo+IG9uIG1lcmdpbmcgdGhpcyBvbmUgdW50aWwgd2UncmUgcmVsYXRpdmVseSBjZXJ0YWlu
IHRoYXQgdGhvc2Ugb3RoZXIgDQo+IHByb2JsZW1zIGhhdmUgYmVlbiBmaXhlZC4gDQo+IA0KDQpZ
ZWFoIHN1cmUuIEkgZG9uJ3Qgc2VlIGFueSBzdHJlc3MtbmcgZXJyb3IgYnV0IHN0aWxsIGNoYXNp
bmcgZG93biB0aGUNCmdsaWJjIGVycm9yLg0KDQpSZWdhcmRzLA0KQXRpc2gNCj4gDQo+IA0KPiA+
IC0tLQ0KPiA+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmggfCAzMw0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3YvaW5jbHVkZS9hc20vdGxiZmx1c2guaA0KPiA+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS90bGJmbHVzaC5oDQo+ID4gaW5kZXggNjg3ZGQxOTczNWE3Li5iMzJiYTRmYTU4ODggMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQo+ID4gKysrIGIv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90bGJmbHVzaC5oDQo+ID4gQEAgLTgsNiArOCw3IEBADQo+
ID4gICNkZWZpbmUgX0FTTV9SSVNDVl9UTEJGTFVTSF9IDQo+ID4gIA0KPiA+ICAjaW5jbHVkZSA8
bGludXgvbW1fdHlwZXMuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+ID4gICNp
bmNsdWRlIDxhc20vc21wLmg+DQo+ID4gIA0KPiA+ICAvKg0KPiA+IEBAIC00NiwxNCArNDcsMzgg
QEAgc3RhdGljIGlubGluZSB2b2lkIHJlbW90ZV9zZmVuY2Vfdm1hKHN0cnVjdA0KPiA+IGNwdW1h
c2sgKmNtYXNrLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiA+ICAJCQkJICAgICB1bnNpZ25lZCBs
b25nIHNpemUpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBjcHVtYXNrIGhtYXNrOw0KPiA+ICsJc3Ry
dWN0IGNwdW1hc2sgdG1hc2s7DQo+ID4gKwlpbnQgY3B1aWQgPSBzbXBfcHJvY2Vzc29yX2lkKCk7
DQo+ID4gIA0KPiA+ICAJY3B1bWFza19jbGVhcigmaG1hc2spOw0KPiA+IC0JcmlzY3ZfY3B1aWRf
dG9faGFydGlkX21hc2soY21hc2ssICZobWFzayk7DQo+ID4gLQlzYmlfcmVtb3RlX3NmZW5jZV92
bWEoaG1hc2suYml0cywgc3RhcnQsIHNpemUpOw0KPiA+ICsJY3B1bWFza19jbGVhcigmdG1hc2sp
Ow0KPiA+ICsNCj4gPiArCWlmIChjbWFzaykNCj4gPiArCQljcHVtYXNrX2NvcHkoJnRtYXNrLCBj
bWFzayk7DQo+ID4gKwllbHNlDQo+ID4gKwkJY3B1bWFza19jb3B5KCZ0bWFzaywgY3B1X29ubGlu
ZV9tYXNrKTsNCj4gPiArDQo+ID4gKwlpZiAoY3B1bWFza190ZXN0X2NwdShjcHVpZCwgJnRtYXNr
KSkgew0KPiA+ICsJCS8qIFNhdmUgdHJhcCBjb3N0IGJ5IGlzc3VpbmcgYSBsb2NhbCB0bGIgZmx1
c2ggaGVyZSAqLw0KPiA+ICsJCWlmICgoc3RhcnQgPT0gMCAmJiBzaXplID09IC0xKSB8fCAoc2l6
ZSA+IFBBR0VfU0laRSkpDQo+ID4gKwkJCWxvY2FsX2ZsdXNoX3RsYl9hbGwoKTsNCj4gPiArCQll
bHNlIGlmIChzaXplID09IFBBR0VfU0laRSkNCj4gPiArCQkJbG9jYWxfZmx1c2hfdGxiX3BhZ2Uo
c3RhcnQpOw0KPiA+ICsJCWNwdW1hc2tfY2xlYXJfY3B1KGNwdWlkLCAmdG1hc2spOw0KPiA+ICsJ
fSBlbHNlIGlmIChjcHVtYXNrX2VtcHR5KCZ0bWFzaykpIHsNCj4gPiArCQkvKiBjcHVtYXNrIGlz
IGVtcHR5LiBTbyBqdXN0IGRvIGEgbG9jYWwgZmx1c2ggKi8NCj4gPiArCQlsb2NhbF9mbHVzaF90
bGJfYWxsKCk7DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmICghY3B1
bWFza19lbXB0eSgmdG1hc2spKSB7DQo+ID4gKwkJcmlzY3ZfY3B1aWRfdG9faGFydGlkX21hc2so
JnRtYXNrLCAmaG1hc2spOw0KPiA+ICsJCXNiaV9yZW1vdGVfc2ZlbmNlX3ZtYShobWFzay5iaXRz
LCBzdGFydCwgc2l6ZSk7DQo+ID4gKwl9DQo+ID4gIH0NCj4gPiAgDQo+ID4gLSNkZWZpbmUgZmx1
c2hfdGxiX2FsbCgpIHNiaV9yZW1vdGVfc2ZlbmNlX3ZtYShOVUxMLCAwLCAtMSkNCj4gPiAtI2Rl
ZmluZSBmbHVzaF90bGJfcGFnZSh2bWEsIGFkZHIpIGZsdXNoX3RsYl9yYW5nZSh2bWEsIGFkZHIs
IDApDQo+ID4gKyNkZWZpbmUgZmx1c2hfdGxiX2FsbCgpIHJlbW90ZV9zZmVuY2Vfdm1hKE5VTEws
IDAsIC0xKQ0KPiA+ICsjZGVmaW5lIGZsdXNoX3RsYl9wYWdlKHZtYSwgYWRkcikgZmx1c2hfdGxi
X3JhbmdlKHZtYSwgYWRkciwNCj4gPiAoYWRkcikgKyBQQUdFX1NJWkUpDQo+ID4gICNkZWZpbmUg
Zmx1c2hfdGxiX3JhbmdlKHZtYSwgc3RhcnQsIGVuZCkgXA0KPiA+ICAJcmVtb3RlX3NmZW5jZV92
bWEobW1fY3B1bWFzaygodm1hKS0+dm1fbW0pLCBzdGFydCwgKGVuZCkgLQ0KPiA+IChzdGFydCkp
DQo+ID4gICNkZWZpbmUgZmx1c2hfdGxiX21tKG1tKSBcDQo+ID4gLS0gDQo+ID4gMi4yMS4wDQo+
ID4gDQo+ID4gDQo+IA0KPiAtIFBhdWwNCg0K
