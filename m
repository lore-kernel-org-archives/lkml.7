Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E049EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7DD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 03:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cKNZvA1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbfCZDrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:47:35 -0400
Received: from mail-eopbgr770071.outbound.protection.outlook.com ([40.107.77.71]:55252
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbfCZDre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 23:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi+jU4x8jpUszhqk23wf0x8YY21wXzZ/Ua54qRl5Y3c=;
 b=cKNZvA1VT4V2fCfhkW96niVaumNnd/wpKM5sDy2FvYseNqLapihnBi8TW/quljGj2464T3ym0RY6SNM2+OEJwvkbjwj/9M6mkbChYObbKAAFyH/1NJKsTEnAXQx11yFw5rwxvC/DmFv686gNQqW91ipuZut9bLWKYgO/vKN9HVw=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3433.namprd12.prod.outlook.com (20.178.198.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 03:47:31 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 03:47:31 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] svm/avic: Fix invalidate logical APIC id entry
Thread-Topic: [PATCH] svm/avic: Fix invalidate logical APIC id entry
Thread-Index: AQHU4Jh8MXOh/YIDZE+Tvx4LHPVDEaYXnj6AgAWtzwA=
Date:   Tue, 26 Mar 2019 03:47:31 +0000
Message-ID: <de6aed06-fb9b-0b4d-99ee-369ab78b0403@amd.com>
References: <20190322101706.9377-1-suravee.suthikulpanit@amd.com>
 <87ef6zcb7i.fsf@vitty.brq.redhat.com>
In-Reply-To: <87ef6zcb7i.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
x-originating-ip: [165.204.77.1]
x-clientproxiedby: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeb8a88e-7475-45dc-3855-08d6b19dc633
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3433;
x-ms-traffictypediagnostic: DM6PR12MB3433:
x-microsoft-antispam-prvs: <DM6PR12MB3433E76F5C59E5910C6E59B9F35F0@DM6PR12MB3433.namprd12.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(376002)(366004)(396003)(346002)(199004)(189003)(97736004)(446003)(6512007)(14454004)(65826007)(53936002)(68736007)(25786009)(478600001)(72206003)(476003)(6246003)(2616005)(11346002)(86362001)(8936002)(31696002)(229853002)(5660300002)(186003)(486006)(6436002)(6486002)(6916009)(106356001)(256004)(64126003)(7736002)(102836004)(81166006)(81156014)(8676002)(3846002)(52116002)(386003)(31686004)(2906002)(316002)(71200400001)(71190400001)(53546011)(6116002)(65956001)(66066001)(6506007)(14444005)(4326008)(65806001)(105586002)(76176011)(54906003)(58126008)(99286004)(36756003)(305945005)(26005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3433;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L86eTHxYRP2FPutznGl4cuS223ae9ElivzV3pLKtqIf6oF8u4Q1fEqkzxiYCRLSkplQyo+hDyn+hEtZ9L8pbGR196hgFyWz4e+AMzv6fiODH2RHXFmTaU0CgkyOMLNKu0g8lqVdsRtrHPNv1WSCC1/nXV8AM82HeAoBzj0wSEdxp9/mPZ8SYLyH8t1XhXbSGKw2pPVdb8YpY/gfMJCHbXg1yUWJQ951vAMAL0PqSX8jU9vGeqo0LMhKxJmKf4MeoIkHGhZyMmu3o6PBz6QsskxPE/5EWkZvlTYzO5pQU+eGvy1rwvdHvPIUt6BWQlypLN/uVHFxuf1ClFk9Ks4nb5sZVx6x77HJTVncRSasZly4VX+Ud6iNxJkZMTH15sjfqbGY3L2iFULJKnO1Ls5P8Oe4DA41D6lUfE5XXhwBQR6E=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AA92029211371418775D72692DA48AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb8a88e-7475-45dc-3855-08d6b19dc633
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 03:47:31.6814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjIvMTkgODowNCBQTSwgVml0YWx5IEt1em5ldHNvdiB3cm90ZToNCj4gIlN1dGhp
a3VscGFuaXQsIFN1cmF2ZWUiIDxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT4gd3JpdGVz
Og0KPiANCj4+IE9ubHkgY2xlYXIgdGhlIHZhbGlkIGJpdCB3aGVuIGludmFsaWRhdGUgbG9naWNh
bCBBUElDIGlkIGVudHJ5Lg0KPj4gVGhlIGN1cnJlbnQgbG9naWMgY2xlYXIgdGhlIHZhbGlkIGJp
dCwgYnV0IGFsc28gc2V0IHRoZSByZXN0IG9mDQo+PiB0aGUgYml0cyAoaW5jbHVkaW5nIHJlc2Vy
dmVkIGJpdHMpIHRvIDEuDQo+Pg0KPj4gRml4ZXM6IDk4ZDkwNTgyYmUyZSAoJ3N2bTogRml4IEFW
SUMgREZSIGFuZCBMRFIgaGFuZGxpbmcnKQ0KPj4gU2lnbmVkLW9mZi1ieTogU3VyYXZlZSBTdXRo
aWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBh
cmNoL3g4Ni9rdm0vc3ZtLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vc3Zt
LmMgYi9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4+IGluZGV4IDdhNGNlMWEyMmNhMC4uZjRmYjc2NmU0
NzRjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva3ZtL3N2bS5jDQo+PiArKysgYi9hcmNoL3g4
Ni9rdm0vc3ZtLmMNCj4+IEBAIC00NjQwLDcgKzQ2NDAsNyBAQCBzdGF0aWMgdm9pZCBhdmljX2lu
dmFsaWRhdGVfbG9naWNhbF9pZF9lbnRyeShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+PiAgIAl1
MzIgKmVudHJ5ID0gYXZpY19nZXRfbG9naWNhbF9pZF9lbnRyeSh2Y3B1LCBzdm0tPmxkcl9yZWcs
IGZsYXQpOw0KPj4gICANCj4+ICAgCWlmIChlbnRyeSkNCj4+IC0JCVdSSVRFX09OQ0UoKmVudHJ5
LCAodTMyKSB+QVZJQ19MT0dJQ0FMX0lEX0VOVFJZX1ZBTElEX01BU0spOw0KPj4gKwkJV1JJVEVf
T05DRSgqZW50cnksICh1MzIpKCplbnRyeSAmIH5BVklDX0xPR0lDQUxfSURfRU5UUllfVkFMSURf
TUFTSykpOw0KPiANCj4gSSdtIG5vdCBzdXJlIGhvdyBpbXBvcnRhbnQgdGhpcyBpcywgYnV0IHRo
aXMgY2hhbmdlIGNyZWF0ZXMgYSB0aW55IHRpbWUNCj4gd2luZG93IGJldHdlZW4gcmVhZGluZyBm
cm9tICplbnRyeSBhbmQgd3JpdGluZyB0aGVyZS4gU2hvdWxkIHdlIHVzZQ0KPiBhdG9taWMgYml0
b3BzIGluc3RlYWQ/DQoNClN1cmUuIFRoYXQgaXMgYWxzbyBzaW1wbGVyLiBJJ2xsIHNlbmQgb3V0
IFYyIHcvIGNsZWFyX2JpdCgpIGluc3RlYWQuDQoNClN1cmF2ZWUNCg0KPiANCj4+ICAgfQ0KPj4g
ICANCj4+ICAgc3RhdGljIGludCBhdmljX2hhbmRsZV9sZHJfdXBkYXRlKHN0cnVjdCBrdm1fdmNw
dSAqdmNwdSkNCj4gDQo=
