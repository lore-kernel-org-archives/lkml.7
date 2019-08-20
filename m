Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC11C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853D322D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="curTnr/g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RJb/bwLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbfHTVE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:04:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33187 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566335099; x=1597871099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6kBuad4Y+wWNtvBqol4LM0EQY+Y3HPZMluS/SMiHtPI=;
  b=curTnr/gN+tDOMNKdsHyqfNF73xTNPYPlvIKLww5CDjz0MvJeH/Kz3cc
   es021bxNPnhwyYpoMzzjXEgV6Pbt/v+fJ8CEX2m2EXmrsTUUkUTt8x0hp
   U2a+XKvS+sAVRzxjZ81lIsb3Qw14tXrQoN3NMNN1Q14rEbOxcVdFkRplG
   hiR26pMupiUeHkAnAAcNnT9I6NAszxrCtDZJH11LiyUVlBT7OKE080prB
   nCs/rKbV0KYJ70mn2F0cHtinoqGaVtKast6u4dyY7FsSu1nzXIZaTT5DD
   QEbfnqDx5kEadEswO8bSW3tZ4QBE1+Kb7FXC6rg4iNVsnX3IPCP7+TgO7
   Q==;
IronPort-SDR: GKJ7+kuVpmOR6roKNkYqfRvten4725RcPEN+460TDseYQzsZY1rBf8yikJMfg28sNkN7lyiP5F
 mC6CaH2zblWMTsoqwQvHMerpEFKSmosF0jP85pdTx10VlrUp1dqPowRqeCS4FvJpdbIXzDgHN3
 DfkhQiXgusTXR3nQxa9rUlUvse37i4FDZHnEdGLXH8KPIjR5BTAtcobN9ns52OW5hjaDYNwxAU
 ZF3bmc3q2NB4bK9BS9R1acYX7VVPdOvysj0k5fUe+zTzsH5MwpP+nl2SDfIN4Yd3T+G49+URf0
 6OY=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="120872935"
Received: from mail-by2nam05lp2051.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.51])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 05:04:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cij2CEf4uSfkBjlc4fiExvQ8VU+SsoKnrdb3y95+i49dhyzRxX5KuR5RzT5rxzRWtIMcCJiY3a5jClvmC2QuFcgRzU2bGySbUu42/XuEfg4zvRUNuF/Ce+pu5tJXBXLGMDvj9UcKhhkhPrGrXmeBk/Qt7rEvB2h3ny+d5aSk6Mg0/X0kl8jmRf2O01EbQyUc//bWZIvjjiWP4z3nRR25T55tguaZ/btXaE/mFRHJ5M3BHerz+4DcAr2PSNBBphmh5d2M5eYp/PBKit5o+/lyYHK3OdhaGm/boCywJbYPVrlTWbg0eQ9ikHGAUtAlSaLElZObe9cFUzShE8o9l2PhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kBuad4Y+wWNtvBqol4LM0EQY+Y3HPZMluS/SMiHtPI=;
 b=KLHvV32+Jim4E2Q9A0R1yMn6NTubp7ou1KXurHC0NJDCLVeVneOlc2iQYb0+DqxcfVKTAOyF0zGMFO2YjXYJHg7bETy42r9RYpmXXkaarRvIRwJEyIv6EoC9cUukJEBR9qIIVyhxRl+i/4D1gLl8UXVjz02zffa7/bxmIOISgv8L1jq46H8EvFDKLDm+1PaOBBUReoNI0s+0HAHxeH+5pEg+WCGwJWURM/ZGkQzEPy6RWbC9B/dmcZh0WL/rQ6yugquHNHR7EwwZSGbgmw/k71JbMC23wjqlUqkQ3AVAU0Q90S7zM3FegOPQEgc3tFX5AKpy36pvOjO/EBZR7scOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kBuad4Y+wWNtvBqol4LM0EQY+Y3HPZMluS/SMiHtPI=;
 b=RJb/bwLmRyR5YGP5PFwES9332/3DQCx6MeXYmW7/GSwCayyXXvMii6AFGmORgctulCD+vGJMRnAV77NwiVhGhv78Qo6kysWYmMoVjxSgYEiolZ5Q6QONIRNBVbUOJhM+3O/QGygyn7an2pUDAWCUv8ECTMGEK8MO5aGwWtKbptI=
Received: from BYAPR04MB3990.namprd04.prod.outlook.com (52.135.215.29) by
 BYAPR04MB4310.namprd04.prod.outlook.com (20.176.251.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Tue, 20 Aug 2019 21:04:57 +0000
Received: from BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e]) by BYAPR04MB3990.namprd04.prod.outlook.com
 ([fe80::24ca:5178:5475:9a0e%4]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 21:04:57 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "hch@lst.de" <hch@lst.de>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/15] riscv: implement remote sfence.i natively for
 M-mode
Thread-Topic: [PATCH 09/15] riscv: implement remote sfence.i natively for
 M-mode
Thread-Index: AQHVUe6Ste5QyM3L50+bKaWbkCQXSacEkfiA
Date:   Tue, 20 Aug 2019 21:04:57 +0000
Message-ID: <d3ca4c6174dea85a4a55f2ec62875b226f05b69d.camel@wdc.com>
References: <20190813154747.24256-1-hch@lst.de>
         <20190813154747.24256-10-hch@lst.de>
In-Reply-To: <20190813154747.24256-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8931afa-639f-42a4-ef0f-08d725b20e5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4310;
x-ms-traffictypediagnostic: BYAPR04MB4310:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB43107754AE335F34E46FBB42FAAB0@BYAPR04MB4310.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(81156014)(81166006)(53936002)(316002)(110136005)(8676002)(118296001)(14454004)(186003)(256004)(5660300002)(6246003)(102836004)(6116002)(305945005)(3846002)(6506007)(2616005)(2906002)(11346002)(25786009)(26005)(4326008)(486006)(7736002)(71190400001)(71200400001)(478600001)(8936002)(446003)(36756003)(229853002)(76176011)(476003)(2501003)(76116006)(86362001)(6436002)(66066001)(54906003)(66446008)(66556008)(66476007)(2201001)(64756008)(6486002)(66946007)(6512007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4310;H:BYAPR04MB3990.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QSc+McBQaVF24NWReMYlDmQrQkxEsiOhFw5d6u52I5wuoebgHQykbmpSJh/hqTTEW98q8YIOlwawJrPbMDd431mj3fd6nGGfyF0w0xfXuXiW100Dmuf28VEL1Q0z4uL+ZmL/aFqdHy6CUKA/uAvtzb+G7ENc2OoFPqE1t6B7gK0NIEl4O3HrSn6wnZseHWaQK8G0RW8TvCnEkPUVk6Go9nf0q+bdTF8EtgGxtE8NAAOFIyOsT8L/Dt3k42NU1mtxxWC16spkgO3M1fdtRV502XfI0dT3GqHCU8tzAcoMYDEbJhW3w+RCz+uxYtBHiE7ih1h8lY2zG0+wjP4/FzJ87CmMwzGypZ/vUO96bFYCXdoC2ryZC8SpirCdEh8q1CD8c9kK+Rmgv8HSii2nGtoyeP0d+V42rx2d6pPhvGvD6CM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CA2AAD6A7152345891D03CEE309E4DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8931afa-639f-42a4-ef0f-08d725b20e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 21:04:57.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dmaE4lzShq7EUi9Ip8b6eoMRh4mq1jnQSs0uSqW1+XGXY33qz7xcR29s2IBAbMFD73Rfi2kAWb2X1+9cfI3s1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4310
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDE3OjQ3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gVGhlIFJJU0MtViBJU0Egb25seSBzdXBwb3J0cyBmbHVzaGluZyB0aGUgaW5zdHJ1Y3Rp
b24gY2FjaGUgZm9yIHRoZQ0KPiBsb2NhbA0KPiBDUFUgY29yZS4gIEZvciBub3JtYWwgUy1tb2Rl
IExpbnV4IHJlbW90ZSBmbHVzaGluZyBpcyBvZmZsb2FkZWQgdG8NCj4gbWFjaGluZSBtb2RlIHVz
aW5nIGVjYWxscywgYnV0IGZvciBNLW1vZGUgTGludXggd2UnbGwgaGF2ZSB0byBkbyBpdA0KPiBv
dXJzZWx2ZXMuICBVc2UgdGhlIHNhbWUgaW1wbGVtZW50YXRpb24gYXMgYWxsIHRoZSBleGlzdGlu
ZyBvcGVuDQo+IHNvdXJjZQ0KPiBTQkkgaW1wbGVtZW50YXRpb25zIGJ5IGp1c3QgZG9pbmcgYW4g
SVBJIHRvIGFsbCByZW1vdGUgY29yZXMgdG8NCj4gZXhlY3V0ZQ0KPiB0aCBzZmVuY2UuaSBpbnN0
cnVjdGlvbiBvbiBldmVyeSBsaXZlIGNvcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L21tL2NhY2hlZmx1
c2guYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcmlzY3YvbW0vY2FjaGVmbHVzaC5jIGIvYXJjaC9yaXNjdi9tbS9jYWNoZWZsdXNoLmMN
Cj4gaW5kZXggOWViY2ZmOGJhMjYzLi4xMDg3NWVhMTA2NWUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
cmlzY3YvbW0vY2FjaGVmbHVzaC5jDQo+ICsrKyBiL2FyY2gvcmlzY3YvbW0vY2FjaGVmbHVzaC5j
DQo+IEBAIC0xMCwxMCArMTAsMzUgQEANCj4gIA0KPiAgI2luY2x1ZGUgPGFzbS9zYmkuaD4NCj4g
IA0KPiArI2lmZGVmIENPTkZJR19NX01PREUNCj4gK3N0YXRpYyB2b2lkIGlwaV9yZW1vdGVfZmVu
Y2VfaSh2b2lkICppbmZvKQ0KPiArew0KPiArCXJldHVybiBsb2NhbF9mbHVzaF9pY2FjaGVfYWxs
KCk7DQo+ICt9DQo+ICsNCj4gK3ZvaWQgZmx1c2hfaWNhY2hlX2FsbCh2b2lkKQ0KPiArew0KPiAr
CW9uX2VhY2hfY3B1KGlwaV9yZW1vdGVfZmVuY2VfaSwgTlVMTCwgMSk7DQo+ICt9DQo+ICsNCj4g
K3N0YXRpYyB2b2lkIGZsdXNoX2ljYWNoZV9jcHVtYXNrKGNvbnN0IGNwdW1hc2tfdCAqbWFzaykN
Cj4gK3sNCj4gKwlvbl9lYWNoX2NwdV9tYXNrKG1hc2ssIGlwaV9yZW1vdGVfZmVuY2VfaSwgTlVM
TCwgMSk7DQo+ICt9DQo+ICsjZWxzZSAvKiBDT05GSUdfTV9NT0RFICovDQo+ICB2b2lkIGZsdXNo
X2ljYWNoZV9hbGwodm9pZCkNCj4gIHsNCj4gIAlzYmlfcmVtb3RlX2ZlbmNlX2koTlVMTCk7DQo+
ICB9DQo+ICtzdGF0aWMgdm9pZCBmbHVzaF9pY2FjaGVfY3B1bWFzayhjb25zdCBjcHVtYXNrX3Qg
Km1hc2spDQo+ICt7DQo+ICsJY3B1bWFza190IGhtYXNrOw0KPiArDQo+ICsJY3B1bWFza19jbGVh
cigmaG1hc2spOw0KPiArCXJpc2N2X2NwdWlkX3RvX2hhcnRpZF9tYXNrKG1hc2ssICZobWFzayk7
DQo+ICsJc2JpX3JlbW90ZV9mZW5jZV9pKGhtYXNrLmJpdHMpOw0KPiArfQ0KPiArI2VuZGlmIC8q
IENPTkZJR19NX01PREUgKi8NCj4gIA0KPiAgLyoNCj4gICAqIFBlcmZvcm1zIGFuIGljYWNoZSBm
bHVzaCBmb3IgdGhlIGdpdmVuIE1NIGNvbnRleHQuICBSSVNDLVYgaGFzIG5vDQo+IGRpcmVjdA0K
PiBAQCAtMjgsNyArNTMsNyBAQCB2b2lkIGZsdXNoX2ljYWNoZV9hbGwodm9pZCkNCj4gIHZvaWQg
Zmx1c2hfaWNhY2hlX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBib29sIGxvY2FsKQ0KPiAgew0K
PiAgCXVuc2lnbmVkIGludCBjcHU7DQo+IC0JY3B1bWFza190IG90aGVycywgaG1hc2ssICptYXNr
Ow0KPiArCWNwdW1hc2tfdCBvdGhlcnMsICptYXNrOw0KPiAgDQo+ICAJcHJlZW1wdF9kaXNhYmxl
KCk7DQo+ICANCj4gQEAgLTQ3LDkgKzcyLDcgQEAgdm9pZCBmbHVzaF9pY2FjaGVfbW0oc3RydWN0
IG1tX3N0cnVjdCAqbW0sIGJvb2wNCj4gbG9jYWwpDQo+ICAJY3B1bWFza19hbmRub3QoJm90aGVy
cywgbW1fY3B1bWFzayhtbSksIGNwdW1hc2tfb2YoY3B1KSk7DQo+ICAJbG9jYWwgfD0gY3B1bWFz
a19lbXB0eSgmb3RoZXJzKTsNCj4gIAlpZiAobW0gIT0gY3VycmVudC0+YWN0aXZlX21tIHx8ICFs
b2NhbCkgew0KPiAtCQljcHVtYXNrX2NsZWFyKCZobWFzayk7DQo+IC0JCXJpc2N2X2NwdWlkX3Rv
X2hhcnRpZF9tYXNrKCZvdGhlcnMsICZobWFzayk7DQo+IC0JCXNiaV9yZW1vdGVfZmVuY2VfaSho
bWFzay5iaXRzKTsNCj4gKwkJZmx1c2hfaWNhY2hlX2NwdW1hc2soJm90aGVycyk7DQo+ICAJfSBl
bHNlIHsNCj4gIAkJLyoNCj4gIAkJICogSXQncyBhc3N1bWVkIHRoYXQgYXQgbGVhc3Qgb25lIHN0
cm9uZ2x5IG9yZGVyZWQNCj4gb3BlcmF0aW9uIGlzDQoNClJldmlld2VkLWJ5OiBBdGlzaCBQYXRy
YSA8YXRpc2gucGF0cmFAd2RjLmNvbT4NCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
