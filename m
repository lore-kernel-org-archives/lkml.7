Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E18C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C274F218B8
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UxFk0PGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfGWP3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:29:05 -0400
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:64288
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbfGWP3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:29:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYwBsSqxSUj5LMMZ4xOFbUB7BMixEJbWcipTzmJT4s5fUyjJEmPkjD8c5BHK8FPXlxTVuyZBmPMYuy/mqmYNNPsBdfVX8cU8tYLYI2I9j84alYGe8nEUirGo9bi5ws+HAyncNnxrpvUGZNtDhUhAeuKQPUr4dFFWmgtXqkyOP/K5F7/MsCfdm/X237pQDh23RXep+NmGmLIgSjOXRWG+yO+6wRNiICi2J6hG/g0F3k/S27WndwJjcAdCvJtX1fN8yfH8iZqp4aOD8U3sfUoWIzc3u1gfjlDxMaqGJ391bnuMBPCuMi4++JtES55sRFMplLpgmiZD3IkhaanWL986uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/oEEt6hvgilUyKbKYsYICEpJ7tiWoVli21KFnenhyU=;
 b=eU8wV5gLoGxEp9CdI4PoO8KFdLD7v8K7017LDGrgnoYYCBE981JLsuxsB97Yc88X0ih/Ts1FHoR4ySwaLHYMu5UJDl9z1yEJeHwMHUYV5x90H0IsuK/cyfBHPUo7FaSmoW8quJuo6KXnWw46BBjW8WPcC4DPrrmcA1iNLYgPuJ07y8Tq1po7afPcIyf8qSE6+D63j58D4qxOkmbYx8jztxR41VJ3o8MLZt6YeldzrC52ADCm9BIJbWwLWIiNwNI1W4JiMjPjHbfTc27w8rWpE3faya9qn4BB7tqEqWIWHWvGwsmj94VvOD35UbuSnoShJpciCrccPNAEzTf+xdb6/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/oEEt6hvgilUyKbKYsYICEpJ7tiWoVli21KFnenhyU=;
 b=UxFk0PGOkF9drCC6ZhyHCHtts+BqMWjfTO989c4ktEwEOvLrjWWFdt2ck5rt9C/4cLRH2n7yz0fUlHlv9Bg07LcOvVejwGJHYz6mvE3vJuBFWeYaaRTE8fvgQDXVZ+iGA0V5tZTcrGrKWoUm8YWe0s9RSNcS5VDW3CnQF9vlFNg=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3913.namprd12.prod.outlook.com (10.255.174.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Tue, 23 Jul 2019 15:29:01 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::a91d:8752:288:ed5f%6]) with mapi id 15.20.2115.005; Tue, 23 Jul 2019
 15:29:01 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Thread-Topic: [PATCH] iommu/amd: Add support for X2APIC IOMMU interrupts
Thread-Index: AQHVO48Hx/kfNidzeESmMCe8zpPtA6bYX5MA
Date:   Tue, 23 Jul 2019 15:29:01 +0000
Message-ID: <adbc96db-2574-8573-b05f-9206aa1db915@amd.com>
References: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
In-Reply-To: <1563251350-81400-1-git-send-email-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [165.204.77.11]
x-clientproxiedby: DM5PR1501CA0022.namprd15.prod.outlook.com
 (2603:10b6:4:9d::35) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f7fa349-7e96-4757-9dbb-08d70f827cec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3913;
x-ms-traffictypediagnostic: DM6PR12MB3913:
x-microsoft-antispam-prvs: <DM6PR12MB3913F7DEF6883C357B450E7BF3C70@DM6PR12MB3913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(316002)(58126008)(11346002)(476003)(110136005)(65826007)(66556008)(2616005)(6246003)(66476007)(66946007)(229853002)(6486002)(65806001)(64756008)(446003)(6512007)(2906002)(66066001)(65956001)(66446008)(76176011)(6116002)(3846002)(71200400001)(71190400001)(86362001)(81166006)(81156014)(31696002)(53936002)(52116002)(6436002)(8676002)(68736007)(14444005)(478600001)(25786009)(2501003)(305945005)(8936002)(31686004)(7736002)(486006)(26005)(6506007)(102836004)(53546011)(99286004)(186003)(64126003)(4326008)(5660300002)(386003)(14454004)(256004)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3913;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KND17uQLbw5jgCnh2zcXQiJguMmQAAAkEppfo2aCkBadR6uHw1measQeWL3Lfy827V7uYV5Buev72Bx2alxVEA0cFJgwPBu/KwciPzxL1t2B8mx/W9gAxDTzH9WSTflXDwPkIH8iChLB8N01wybuD1Rvxt7qVyiIqzq+zNc3NAplf76cjbTNGPB+pav0yaov6csMMcd6ye2c7ixRqf52++Pdo+bP9sQZsVIwSImgfCVam9V32jM+2OSh4+exe1cPMPNua97JsZ5awyVJJ/cnEgPJNHL3UUwm0jlXVYN5S1L3fKeKEG79lkAYFD1TqJjkukdEUAd2cvc8KluZOtaC9Nw52rT0tFEkvBYyvgIrp6hN6/Rzxc8xsF0dJU8jd9OdksP7p+gPLMJTT1z6Lyt5fMfQJs9kI58blxuyVI1sCUY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5673A26540045742AED93E246F8989D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7fa349-7e96-4757-9dbb-08d70f827cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 15:29:01.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssuthiku@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNClRoaXMgcGF0Y2ggYWxzbyBmaXhlcyBnZW5lcmFsIHgyQVBJQyBzdXBwb3J0IGZv
ciBBTUQgSU9NTVUsIHdoaWNoDQp3YXMgaW50cm9kdWNlZCBlYXJsaWVyLiBUaGVyZWZvcmUsIEkg
YW0gaW5jbHVkaW5nIHRoZSBGaXhlcyB0YWcgaGVyZS4NCg0KRml4ZXM6IDkwZmNmZmQ5Y2Y1ZSAo
J2lvbW11L2FtZDogQWRkIHN1cHBvcnQgZm9yIElPTU1VIFhUIG1vZGUnKQ0KDQpUaGFua3MsDQpT
dXJhdmVlDQoNCk9uIDcvMTUvMjAxOSAxMToyOSBQTSwgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSB3
cm90ZToNCj4gQU1EIElPTU1VIHJlcXVpcmVzIEludENhcFhUIHJlZ2lzdGVycyB0byBiZSBzZXR1
cCBpbiBvcmRlciB0byBnZW5lcmF0ZQ0KPiBpdHMgb3duIGludGVycnVwdHMgKGZvciBFdmVudCBM
b2csIFBQUiBMb2csIGFuZCBHQSBMb2cpIHdpdGggMzItYml0DQo+IEFQSUMgZGVzdGluYXRpb24g
SUQuIFdpdGhvdXQgdGhpcyBzdXBwb3J0LCBBTUQgSU9NTVUgTVNJIGludGVycnVwdHMNCj4gd2ls
bCBub3QgYmUgcm91dGVkIGNvcnJlY3RseSB3aGVuIGJvb3RpbmcgdGhlIHN5c3RlbSBpbiBYMkFQ
SUMgbW9kZS4NCj4gDQo+IENjOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4NCj4gU2ln
bmVkLW9mZi1ieTogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRA
YW1kLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jICB8IDkw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAgZHJpdmVycy9p
b21tdS9hbWRfaW9tbXVfdHlwZXMuaCB8ICA5ICsrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5
OSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9t
bXVfaW5pdC5jIGIvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+IGluZGV4IGZmNDBi
YTcuLmE0YzViMWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQu
Yw0KPiArKysgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV9pbml0LmMNCj4gQEAgLTM1LDYgKzM1
LDggQEANCj4gICAjaW5jbHVkZSA8bGludXgvbWVtX2VuY3J5cHQuaD4NCj4gICAjaW5jbHVkZSA8
YXNtL3BjaS1kaXJlY3QuaD4NCj4gICAjaW5jbHVkZSA8YXNtL2lvbW11Lmg+DQo+ICsjaW5jbHVk
ZSA8YXNtL2FwaWMuaD4NCj4gKyNpbmNsdWRlIDxhc20vbXNpZGVmLmg+DQo+ICAgI2luY2x1ZGUg
PGFzbS9nYXJ0Lmg+DQo+ICAgI2luY2x1ZGUgPGFzbS94ODZfaW5pdC5oPg0KPiAgICNpbmNsdWRl
IDxhc20vaW9tbXVfdGFibGUuaD4NCj4gQEAgLTE5MzUsNiArMTkzNyw5MCBAQCBzdGF0aWMgaW50
IGlvbW11X3NldHVwX21zaShzdHJ1Y3QgYW1kX2lvbW11ICppb21tdSkNCj4gICAJcmV0dXJuIDA7
DQo+ICAgfQ0KPiAgIA0KPiArI2RlZmluZSBYVF9JTlRfREVTVF9NT0RFKHgpCSgoKHgpICYgMHgx
VUxMKSA8PCAyKQ0KPiArI2RlZmluZSBYVF9JTlRfREVTVF9MTyh4KQkoKCh4KSAmIDB4RkZGRkZG
VUxMKSA8PCA4KQ0KPiArI2RlZmluZSBYVF9JTlRfVkVDKHgpCQkoKCh4KSAmIDB4RkZVTEwpIDw8
IDMyKQ0KPiArI2RlZmluZSBYVF9JTlRfREVTVF9ISSh4KQkoKCgoeCkgPj4gMjQpICYgMHhGRlVM
TCkgPDwgNTYpDQo+ICsNCj4gKy8qKg0KPiArICogU2V0dXAgdGhlIEludENhcFhUIHJlZ2lzdGVy
cyB3aXRoIGludGVycnVwdCByb3V0aW5nIGluZm9ybWF0aW9uDQo+ICsgKiBiYXNlZCBvbiB0aGUg
UENJIE1TSSBjYXBhYmlsaXR5IGJsb2NrIHJlZ2lzdGVycywgYWNjZXNzZWQgdmlhDQo+ICsgKiBN
TUlPIE1TSSBhZGRyZXNzIGxvdy9oaSBhbmQgTVNJIGRhdGEgcmVnaXN0ZXJzLg0KPiArICovDQo+
ICtzdGF0aWMgdm9pZCBpb21tdV91cGRhdGVfaW50Y2FweHQoc3RydWN0IGFtZF9pb21tdSAqaW9t
bXUpDQo+ICt7DQo+ICsJdTY0IHZhbDsNCj4gKwl1MzIgYWRkcl9sbyA9IHJlYWRsKGlvbW11LT5t
bWlvX2Jhc2UgKyBNTUlPX01TSV9BRERSX0xPX09GRlNFVCk7DQo+ICsJdTMyIGFkZHJfaGkgPSBy
ZWFkbChpb21tdS0+bW1pb19iYXNlICsgTU1JT19NU0lfQUREUl9ISV9PRkZTRVQpOw0KPiArCXUz
MiBkYXRhICAgID0gcmVhZGwoaW9tbXUtPm1taW9fYmFzZSArIE1NSU9fTVNJX0RBVEFfT0ZGU0VU
KTsNCj4gKwlib29sIGRtICAgICA9IChhZGRyX2xvID4+IE1TSV9BRERSX0RFU1RfTU9ERV9TSElG
VCkgJiAweDE7DQo+ICsJdTMyIGRlc3QgICAgPSAoKGFkZHJfbG8gPj4gTVNJX0FERFJfREVTVF9J
RF9TSElGVCkgJiAweEZGKTsNCj4gKw0KPiArCWlmICh4MmFwaWNfZW5hYmxlZCgpKQ0KPiArCQlk
ZXN0IHw9IE1TSV9BRERSX0VYVF9ERVNUX0lEKGFkZHJfaGkpOw0KPiArDQo+ICsJdmFsID0gWFRf
SU5UX1ZFQyhkYXRhICYgMHhGRikgfA0KPiArCSAgICAgIFhUX0lOVF9ERVNUX01PREUoZG0pIHwN
Cj4gKwkgICAgICBYVF9JTlRfREVTVF9MTyhkZXN0KSB8DQo+ICsJICAgICAgWFRfSU5UX0RFU1Rf
SEkoZGVzdCk7DQo+ICsNCj4gKwkvKioNCj4gKwkgKiBDdXJyZW50IElPTU1VIGltcGxlbXRhdGlv
biB1c2VzIHRoZSBzYW1lIElSUSBmb3IgYWxsDQo+ICsJICogMyBJT01NVSBpbnRlcnJ1cHRzLg0K
PiArCSAqLw0KPiArCXdyaXRlcSh2YWwsIGlvbW11LT5tbWlvX2Jhc2UgKyBNTUlPX0lOVENBUFhU
X0VWVF9PRkZTRVQpOw0KPiArCXdyaXRlcSh2YWwsIGlvbW11LT5tbWlvX2Jhc2UgKyBNTUlPX0lO
VENBUFhUX1BQUl9PRkZTRVQpOw0KPiArCXdyaXRlcSh2YWwsIGlvbW11LT5tbWlvX2Jhc2UgKyBN
TUlPX0lOVENBUFhUX0dBTE9HX09GRlNFVCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIF9p
cnFfbm90aWZpZXJfbm90aWZ5KHN0cnVjdCBpcnFfYWZmaW5pdHlfbm90aWZ5ICpub3RpZnksDQo+
ICsJCQkJIGNvbnN0IGNwdW1hc2tfdCAqbWFzaykNCj4gK3sNCj4gKwlzdHJ1Y3QgYW1kX2lvbW11
ICppb21tdTsNCj4gKw0KPiArCWZvcl9lYWNoX2lvbW11KGlvbW11KSB7DQo+ICsJCWlmIChpb21t
dS0+ZGV2LT5pcnEgPT0gbm90aWZ5LT5pcnEpIHsNCj4gKwkJCWlvbW11X3VwZGF0ZV9pbnRjYXB4
dChpb21tdSk7DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiArCX0NCj4gK30NCj4gKw0KPiArc3Rh
dGljIHZvaWQgX2lycV9ub3RpZmllcl9yZWxlYXNlKHN0cnVjdCBrcmVmICpyZWYpDQo+ICt7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgaW9tbXVfaW5pdF9pbnRjYXB4dChzdHJ1Y3QgYW1kX2lv
bW11ICppb21tdSkNCj4gK3sNCj4gKwlpbnQgcmV0Ow0KPiArCXN0cnVjdCBpcnFfYWZmaW5pdHlf
bm90aWZ5ICpub3RpZnkgPSAmaW9tbXUtPmludGNhcHh0X25vdGlmeTsNCj4gKw0KPiArCS8qKg0K
PiArCSAqIEludENhcFhUIHJlcXVpcmVzIFhUU3VwPTEsIHdoaWNoIGNhbiBiZSBpbmZlcnJlZA0K
PiArCSAqIGFtZF9pb21tdV94dF9tb2RlLg0KPiArCSAqLw0KPiArCWlmIChhbWRfaW9tbXVfeHRf
bW9kZSAhPSBJUlFfUkVNQVBfWDJBUElDX01PREUpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJ
LyoqDQo+ICsJICogQWxzbywgd2UgbmVlZCB0byBzZXR1cCBub3RpZmllciB0byB1cGRhdGUgdGhl
IEludENhcFhUIHJlZ2lzdGVycw0KPiArCSAqIHdoZW5ldmVyIHRoZSBpcnEgYWZmaW5pdHkgaXMg
Y2hhbmdlZCBmcm9tIHVzZXItc3BhY2UuDQo+ICsJICovDQo+ICsJbm90aWZ5LT5pcnEgPSBpb21t
dS0+ZGV2LT5pcnE7DQo+ICsJbm90aWZ5LT5ub3RpZnkgPSBfaXJxX25vdGlmaWVyX25vdGlmeSwN
Cj4gKwlub3RpZnktPnJlbGVhc2UgPSBfaXJxX25vdGlmaWVyX3JlbGVhc2UsDQo+ICsJcmV0ID0g
aXJxX3NldF9hZmZpbml0eV9ub3RpZmllcihpb21tdS0+ZGV2LT5pcnEsIG5vdGlmeSk7DQo+ICsJ
aWYgKHJldCkgew0KPiArCQlwcl9lcnIoIkZhaWxlZCB0byByZWdpc3RlciBpcnEgYWZmaW5pdHkg
bm90aWZpZXIgKGRldmlkPSUjeCwgaXJxICVkKVxuIiwNCj4gKwkJICAgICAgIGlvbW11LT5kZXZp
ZCwgaW9tbXUtPmRldi0+aXJxKTsNCj4gKwkJcmV0dXJuIHJldDsNCj4gKwl9DQo+ICsNCj4gKwlp
b21tdV91cGRhdGVfaW50Y2FweHQoaW9tbXUpOw0KPiArCWlvbW11X2ZlYXR1cmVfZW5hYmxlKGlv
bW11LCBDT05UUk9MX0lOVENBUFhUX0VOKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+
ICAgc3RhdGljIGludCBpb21tdV9pbml0X21zaShzdHJ1Y3QgYW1kX2lvbW11ICppb21tdSkNCj4g
ICB7DQo+ICAgCWludCByZXQ7DQo+IEBAIC0xOTUxLDYgKzIwMzcsMTAgQEAgc3RhdGljIGludCBp
b21tdV9pbml0X21zaShzdHJ1Y3QgYW1kX2lvbW11ICppb21tdSkNCj4gICAJCXJldHVybiByZXQ7
DQo+ICAgDQo+ICAgZW5hYmxlX2ZhdWx0czoNCj4gKwlyZXQgPSBpb21tdV9pbml0X2ludGNhcHh0
KGlvbW11KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICAgCWlvbW11
X2ZlYXR1cmVfZW5hYmxlKGlvbW11LCBDT05UUk9MX0VWVF9JTlRfRU4pOw0KPiAgIA0KPiAgIAlp
ZiAoaW9tbXUtPnBwcl9sb2cgIT0gTlVMTCkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUv
YW1kX2lvbW11X3R5cGVzLmggYi9kcml2ZXJzL2lvbW11L2FtZF9pb21tdV90eXBlcy5oDQo+IGlu
ZGV4IDg3OTY1ZTQuLjM5YmU4MDRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZF9p
b21tdV90eXBlcy5oDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X3R5cGVzLmgNCj4g
QEAgLTcyLDYgKzcyLDEyIEBADQo+ICAgI2RlZmluZSBNTUlPX1BQUl9MT0dfT0ZGU0VUCTB4MDAz
OA0KPiAgICNkZWZpbmUgTU1JT19HQV9MT0dfQkFTRV9PRkZTRVQJMHgwMGUwDQo+ICAgI2RlZmlu
ZSBNTUlPX0dBX0xPR19UQUlMX09GRlNFVAkweDAwZTgNCj4gKyNkZWZpbmUgTU1JT19NU0lfQURE
Ul9MT19PRkZTRVQJMHgwMTVDDQo+ICsjZGVmaW5lIE1NSU9fTVNJX0FERFJfSElfT0ZGU0VUCTB4
MDE2MA0KPiArI2RlZmluZSBNTUlPX01TSV9EQVRBX09GRlNFVAkweDAxNjQNCj4gKyNkZWZpbmUg
TU1JT19JTlRDQVBYVF9FVlRfT0ZGU0VUCTB4MDE3MA0KPiArI2RlZmluZSBNTUlPX0lOVENBUFhU
X1BQUl9PRkZTRVQJMHgwMTc4DQo+ICsjZGVmaW5lIE1NSU9fSU5UQ0FQWFRfR0FMT0dfT0ZGU0VU
CTB4MDE4MA0KPiAgICNkZWZpbmUgTU1JT19DTURfSEVBRF9PRkZTRVQJMHgyMDAwDQo+ICAgI2Rl
ZmluZSBNTUlPX0NNRF9UQUlMX09GRlNFVAkweDIwMDgNCj4gICAjZGVmaW5lIE1NSU9fRVZUX0hF
QURfT0ZGU0VUCTB4MjAxMA0KPiBAQCAtMTYyLDYgKzE2OCw3IEBADQo+ICAgI2RlZmluZSBDT05U
Uk9MX0dBTE9HX0VOICAgICAgICAweDFDVUxMDQo+ICAgI2RlZmluZSBDT05UUk9MX0dBSU5UX0VO
ICAgICAgICAweDFEVUxMDQo+ICAgI2RlZmluZSBDT05UUk9MX1hUX0VOICAgICAgICAgICAweDMy
VUxMDQo+ICsjZGVmaW5lIENPTlRST0xfSU5UQ0FQWFRfRU4gICAgIDB4MzNVTEwNCj4gICANCj4g
ICAjZGVmaW5lIENUUkxfSU5WX1RPX01BU0sJKDcgPDwgQ09OVFJPTF9JTlZfVElNRU9VVCkNCj4g
ICAjZGVmaW5lIENUUkxfSU5WX1RPX05PTkUJMA0KPiBAQCAtNjA0LDYgKzYxMSw4IEBAIHN0cnVj
dCBhbWRfaW9tbXUgew0KPiAgIAkvKiBEZWJ1Z0ZTIEluZm8gKi8NCj4gICAJc3RydWN0IGRlbnRy
eSAqZGVidWdmczsNCj4gICAjZW5kaWYNCj4gKwkvKiBJUlEgbm90aWZpZXIgZm9yIEludENhcFhU
IGludGVycnVwdCAqLw0KPiArCXN0cnVjdCBpcnFfYWZmaW5pdHlfbm90aWZ5IGludGNhcHh0X25v
dGlmeTsNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgc3RydWN0IGFtZF9pb21tdSAq
ZGV2X3RvX2FtZF9pb21tdShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IA0K
