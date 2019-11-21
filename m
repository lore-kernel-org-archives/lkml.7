Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35427C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92EF2068E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iwjW4IPo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iqSthETm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKUTHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:07:37 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45984 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUTHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574363256; x=1605899256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dR4swahfibxUo9etnfokYP1A7shRi89ll8+RdnKt0Vg=;
  b=iwjW4IPoJtHyylM+bezonytKw/Liu9G/MXDN6N4O+2tS255lo84DlSvH
   0XTQjIK6hyyiizIcyMtuoGUq7Q3Wxe3wv9bDi4eUrS6u/G2uNO3PDCX0L
   BrbhJOVE/EXs6Tw6lIwWjaCt7JSBDSq8biJJhMXhuY+XnvLHXbOE1r2P3
   j7MlqZqxDP8/OMd8ffStc/OXHoCFV4ZrEIYHvR0BVI14bgXfn3Hf5vPPi
   7+jaKSj5doIkZmEgusBcyJAKG0Mj6cVwMlr4FQzQ8F5j4i9kUlgXsXnLy
   JQfoGGHHTubps0VGYt2X6gS3z6VOmeDQa9ZhK8XHmB0bvSkfwtqGjh8bQ
   w==;
IronPort-SDR: iPlrynLqIJoNNbKRnQO5OoRogt2IVeIsH62xjhTLEgQ+haI2QneUm5P4+OZ+NV4J3qjzrl7G4O
 91X1h9JD8hjNXskrm57OLPxwuJ295nEnqNmBeRTuOVx193kkk5sH6rg2KypMRHZirjj2V8AfA7
 TkVePc48lxe17IxijWczBryaMU0N7RGrPE/0GMZirpB4yc+d4GHDg61wL7tPrKvyIoPufIdlUW
 7Yv5osIxR4nxnCfK9ENlvq3ulzwXyA6IZ0F7GmS/4YPHPWui4PMMYm/CUW9XfxOSxshKFQlZfS
 0YQ=
X-IronPort-AV: E=Sophos;i="5.69,226,1571673600"; 
   d="scan'208";a="123668466"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 03:07:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGJMF3Xx4UmtppEhUFRDY5rK9GRL0HWNfGf/o9H9LgzjgRiMcdZPkUZq/mGYeCfG9JtsCkLgjXQQsZvjw8yZAPAsqju6DF+WC8HkipjGU4swYAtOObDsiNzpB4aYBZHMD05wtV65LmZE0ajJNDg+xIATXv+6hJ6g3y9EnWPI+ny4RO3/vt+LskwVbPlF3ERSpFIL98lGze9jKUgSPH+Ohhl4RopvUVQtqJfKi8d4GZrz4FoDBLYAn/mC5bd2qj8flfAkKr5ReqbHA7MnVEx0ZLBxC2E9RDlPQaZl/HBRIRs2qvnUAjw9c98cIBs7RiHXKbtm3bX6JCOoOPf65oTpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR4swahfibxUo9etnfokYP1A7shRi89ll8+RdnKt0Vg=;
 b=XtDaQ6PNxwSFmeTfJdcWT5DeBQezO3oz1ElNFbhiFRrIm7Vjax9lMEqGsACjR9/LVj2P0Rankr/kmJ518P2RIFrIVKkbK9myz2DC0OkmQVw8uJjV88luIOD1Lsa8PDggQ7S2CB6utLYLaY3ZWQTn3LzXeX24Vdvh8ZYEb0vehH3qYCEXokgZtSgnbtLTQ0P8nWGMLACK+4GkV0NZ4D4qQp/OHHrn8Xtcy82Pk+5GuCRKPneHhZNZFl5CX3Fy4D6sHszR2rGcNK5wt1JSdqWlCvLoqESoZyVlqFpVKcxAnQnbe7XAwkej/nXICVtZqWFKfAwFLRYWBuVVIM912dxfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR4swahfibxUo9etnfokYP1A7shRi89ll8+RdnKt0Vg=;
 b=iqSthETm38IG2ZrWtcSW0Kdu2Th67n0yeQa5UqWO7jwEsh7uY02dWs91nIAMIpqAsWkilSk0AaYZ0rJeNLwSbpuJJs5G5epI84E1ZDYtVQm0qY/W/+jKf/FPEb8sJw37BvVQt1GlG5bzoPggqOiJ+VhI1e9laXyebpl1nDP1UcE=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4023.namprd04.prod.outlook.com (52.135.215.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Thu, 21 Nov 2019 19:07:20 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::1d22:29b6:df03:86f7%3]) with mapi id 15.20.2451.031; Thu, 21 Nov 2019
 19:07:20 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "han_mao@c-sky.com" <han_mao@c-sky.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "behrensj@mit.edu" <behrensj@mit.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v3 0/4] Add support for SBI v0.2
Thread-Topic: [PATCH v3 0/4] Add support for SBI v0.2
Thread-Index: AQHVnmOBiprL/mb7AEaxYBu8wWT9EqeTsfsAgAJPCIA=
Date:   Thu, 21 Nov 2019 19:07:20 +0000
Message-ID: <ede95b25bb1e27ccfd1380896b5b8ec055184f2c.camel@wdc.com>
References: <20191118224539.2171-1-atish.patra@wdc.com>
         <alpine.DEB.2.21.9999.1911192344560.12489@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1911192344560.12489@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58576670-8bac-4175-41b2-08d76eb608d5
x-ms-traffictypediagnostic: BYAPR04MB4023:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BYAPR04MB4023D2E375A8F6AB5D3281BEFA4E0@BYAPR04MB4023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(55674003)(71190400001)(2906002)(6506007)(102836004)(14454004)(229853002)(6436002)(316002)(6486002)(25786009)(6246003)(8676002)(6306002)(6512007)(256004)(8936002)(66066001)(6916009)(81166006)(478600001)(3846002)(81156014)(6116002)(54906003)(36756003)(305945005)(118296001)(5660300002)(5640700003)(966005)(7736002)(2351001)(7416002)(99286004)(26005)(2501003)(76176011)(66446008)(64756008)(86362001)(66556008)(76116006)(66476007)(66946007)(11346002)(446003)(71200400001)(4001150100001)(186003)(4326008)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4023;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PyUkOUMp1m7T7PxSK6jyPdrwFBVURTsNqR8hWoc84PIKpUYGRorscgskkkuCqJ3xA5/StI87BHjiRr5yy99tbjLWnKY7SmIl5M5yh3WR6VOHdJ5HsmK0PzobiSZeFxFTmtREMT+xly6eh8gQ+NpGNJhitxo8Q42jh/lv0/5auq9d1aGzDJ/x0AUwmDdZ5znh9d1tneRDFxP//CaAluMfen8PCWI4JCA9T/wPvUnArZgC2YFUC9VCV3i3rKBM9pfbF9HpylWm/duLGfKu8iveU9l9GcXchWqeiEZOiG63HbK26aew7bP/KSCA3s4dSAQPUG05+18UoC+45Ei0GzYbPJWke8v2XOy2fnAtMt6JtSB/LAsQZtZw50ADSfx2rFrwxLqg2OyMCbFm7wFI2SJjivsxDOzzvyiL0UpVbn/ArMNoDfyWcGR5Fu3EpBmzR0lsZjOhnWzmK89sM3fFbXPVeDon6v+6m+n4au+GIJdaUdE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4742D8E3FCBEC64590BF849E83009054@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58576670-8bac-4175-41b2-08d76eb608d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 19:07:20.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEyitYKhCqi6jgQ6LbnBdkGfaOBZSrnMupZFyv8bSGE7G8stYu9bn4rOr45ILnineHoph+8XRtNVl7kFuxxqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTE5IGF0IDIzOjUxIC0wODAwLCBQYXVsIFdhbG1zbGV5IHdyb3RlOg0K
PiBIaSBBdGlzaCwNCj4gDQo+IE9uIE1vbiwgMTggTm92IDIwMTksIEF0aXNoIFBhdHJhIHdyb3Rl
Og0KPiANCj4gPiBUaGUgU3VwZXJ2aXNvciBCaW5hcnkgSW50ZXJmYWNlKFNCSSkgc3BlY2lmaWNh
dGlvblsxXSBub3cgZGVmaW5lcyBhDQo+ID4gYmFzZSBleHRlbnNpb24gdGhhdCBwcm92aWRlcyBl
eHRlbmRhYmlsaXR5IHRvIGFkZCBmdXR1cmUgZXh0ZW5zaW9ucw0KPiA+IHdoaWxlIG1haW50YWlu
aW5nIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgd2l0aCBwcmV2aW91cyB2ZXJzaW9ucy4NCj4gPiBU
aGUgbmV3IHZlcnNpb24gaXMgZGVmaW5lZCBhcyAwLjIgYW5kIG9sZGVyIHZlcnNpb24gaXMgbWFy
a2VkIGFzDQo+ID4gMC4xLg0KPiA+IA0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgc3VwcG9ydCB2MC4y
IGFuZCBhIHVuaWZpZWQgY2FsbGluZyBjb252ZW50aW9uDQo+ID4gaW1wbGVtZW50YXRpb24gYmV0
d2VlbiAwLjEgYW5kIDAuMi4gSXQgYWxzbyBhZGRzIG1pbmltYWwgU0JJDQo+ID4gZnVuY3Rpb25z
DQo+ID4gZnJvbSAwLjIgYXMgd2VsbCB0byBrZWVwIHRoZSBzZXJpZXMgbGVhbi4gDQo+ID4gDQo+
ID4gWzFdIA0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi9yaXNjdi1zYmktZG9jL2Jsb2Iv
bWFzdGVyL3Jpc2N2LXNiaS5hZG9jDQo+ID4gDQo+ID4gVGhlIGJhc2Ugc3VwcG9ydCBmb3IgU0JJ
IHYwLjIgaXMgYWxyZWFkeSBhdmFpbGFibGUgaW4gT3BlblNCSSB2MC41Lg0KPiA+IFRoaXMgc2Vy
aWVzIG5lZWRzIGZvbGxvd2luZyBhZGRpdGlvbmFsIHBhdGNoZXMgaW4gT3BlblNCSS4gDQo+ID4g
DQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL29wZW5zYmkvMjAxOS1O
b3ZlbWJlci8wMDA3MDQuaHRtbA0KPiA+IA0KPiA+IFRlc3RlZCBvbiBib3RoIEJCTCwgT3BlblNC
SSB3aXRoL3dpdGhvdXQgdGhlIGFib3ZlIHBhdGNoIHNlcmllcy4gDQo+IA0KPiBKdXN0IGJhc2Vk
IG9uIGEgcXVpY2sgbG9vazoNCj4gDQo+IEFsbCBvZiB0aGUgcGF0Y2hlcyBpbiB0aGlzIHNlcmll
cyBhZGQgd2FybmluZ3MgcmVwb3J0ZWQgYnkgDQo+ICdzY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1z
dHJpY3QnLiAgQ291bGQgeW91IHBsZWFzZSBmaXggYW5kIHJlcG9zdD8NCj4gDQoNClllYWggc3Vy
ZS4gSSB3aWxsIGRvIHRoYXQuDQoNCj4gQWxzbzogY291bGQgeW91IHJlYmFzZSB0aGVzZSBwYXRj
aGVzIG9uIHRvcCBvZiB0aGUgY3VycmVudCBSSVNDLVYNCj4gZm9yLW5leHQgDQo+IGJyYW5jaD8g
IFRoZXJlIGFyZSBzb21lIHNpZ25pZmljYW50IGNvbmZsaWN0cyBhZnRlciBDaHJpc3RvcGgncw0K
PiBub21tdSANCj4gd29yay4NCj4gDQoNCm9rLiBJIHdpbGwgcmViYXNlIG9uIHRvcCBvZiBmb3It
bmV4dC4NCg0KPiBXZSdsbCB3YWl0IHRvIHNlbmQgdGhlc2UgdXBzdHJlYW0gdW50aWwgdGhlIFNC
SSB2MC4yIHNwZWMgaXMgZnJvemVuLA0KPiBidXQgDQo+IGluIHRoZSBtZWFudGltZSwgaXQnbGwg
YmUgZ29vZCB0byBnZXQgdGhlc2UgaW50byB0aGUgZXhwZXJpbWVudGFsDQo+IGJyYW5jaC4NCj4g
DQo+IHRoYW5rcywNCj4gDQo+IC0gUGF1bA0KDQotLSANClJlZ2FyZHMsDQpBdGlzaA0K
