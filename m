Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE561C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CDF21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hIRlhV5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDHOQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:16:27 -0400
Received: from mail-eopbgr790047.outbound.protection.outlook.com ([40.107.79.47]:23712
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfDHOQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMNo6vO3jwyQLMQmtF1rfRiIyL7rxk9M1IEVwbznVH0=;
 b=hIRlhV5gFv6SKXdMVSnbp9qh9mCqfxussxLOGhjsUGaoBK2f4b0iZxMkmZLx7DWjNJaksTwQHDukkmJqoULaealEGwK0Xi01vKt8qo51wqSRFQJ1XiwgBmkKpkOxCf//+Tl058wbHqeGqNU9EoLvlJ2ZeXI6xQ84fpEI8WX/BUM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 14:16:24 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::d119:23e5:be33:4ac6]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::d119:23e5:be33:4ac6%2]) with mapi id 15.20.1771.021; Mon, 8 Apr 2019
 14:16:24 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH v2] svm/avic: Fix invalidate logical APIC id entry
Thread-Topic: [PATCH v2] svm/avic: Fix invalidate logical APIC id entry
Thread-Index: AQHU44gM6vK3inub30eEmN0VlYxwVaYyZDeA
Date:   Mon, 8 Apr 2019 14:16:23 +0000
Message-ID: <3779617e-e695-e8ce-e7fc-d86c383b3824@amd.com>
References: <20190326035711.77916-1-suravee.suthikulpanit@amd.com>
In-Reply-To: <20190326035711.77916-1-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
x-originating-ip: [165.204.78.1]
x-clientproxiedby: SN6PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:805:2a::41) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 578de155-e1d6-4d36-22df-08d6bc2cc7b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB2603;
x-ms-traffictypediagnostic: DM6PR12MB2603:
x-microsoft-antispam-prvs: <DM6PR12MB2603A1B54B3E50FAE87D8953F32C0@DM6PR12MB2603.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(476003)(6512007)(102836004)(4326008)(316002)(53936002)(54906003)(58126008)(110136005)(25786009)(71190400001)(386003)(6246003)(2501003)(64126003)(97736004)(478600001)(105586002)(31686004)(106356001)(76176011)(186003)(99286004)(256004)(81166006)(68736007)(486006)(11346002)(7736002)(26005)(71200400001)(65806001)(52116002)(72206003)(14444005)(65956001)(446003)(6436002)(8936002)(6506007)(53546011)(31696002)(6116002)(65826007)(2906002)(86362001)(305945005)(81156014)(36756003)(3846002)(2616005)(6486002)(14454004)(5660300002)(8676002)(229853002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2603;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z1TzEUoBO5XL0EHQrrOpm5UrnrzUeXlIQKF2o1qIWx5cBUzlvxHGjNLjaiSWK+WP44DXx/3ndabSTMt+BIiVIFkF3tATN9l1lyp+gTTF4uByjzd59KHC7TxGLoCOtx8weNET1SsZh0mN476ZSam6NKcf1j/YxS3Ku3oPRxtOtX6zNoojSiWxmPZxY2oFCXiWrbxeBK/iCvZnV7fuNEDRC9sNtbBKobCUWB7MiL9NHD04Fi3jr4vuxrZsjFRPFHomprBES8zM8UEoeG1ANbvaltnsq7T1twk1c4AoCMwHHVMGnFP0w3zxL/a7EcLVAcTCI82cYJkANmJq5K3N0R5O5OwmkKZI6Z5Yb2I1EYY4lNnNH/bTS9nLDHS3nPQSIencmTZ0S0R9kKxNQjgSNHoP7x0RVMRrHmozTp0Ru2eKPo4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4C029E4CB1CB643AA629B1AA1A85C82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578de155-e1d6-4d36-22df-08d6bc2cc7b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 14:16:23.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZw0KDQpPbiAzLzI2LzE5IDEwOjU3IEFNLCBTdXRoaWt1bHBhbml0LCBTdXJhdmVlIHdyb3Rl
Og0KPiBPbmx5IGNsZWFyIHRoZSB2YWxpZCBiaXQgd2hlbiBpbnZhbGlkYXRlIGxvZ2ljYWwgQVBJ
QyBpZCBlbnRyeS4NCj4gVGhlIGN1cnJlbnQgbG9naWMgY2xlYXIgdGhlIHZhbGlkIGJpdCwgYnV0
IGFsc28gc2V0IHRoZSByZXN0IG9mDQo+IHRoZSBiaXRzIChpbmNsdWRpbmcgcmVzZXJ2ZWQgYml0
cykgdG8gMS4NCj4gDQo+IEZpeGVzOiA5OGQ5MDU4MmJlMmUgKCdzdm06IEZpeCBBVklDIERGUiBh
bmQgTERSIGhhbmRsaW5nJykNCj4gU2lnbmVkLW9mZi1ieTogU3VyYXZlZSBTdXRoaWt1bHBhbml0
IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1kLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC94ODYva3Zt
L3N2bS5jIHwgMyArKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3N2bS5jIGIvYXJjaC94
ODYva3ZtL3N2bS5jDQo+IGluZGV4IDdhNGNlMWEyMmNhMC4uOGExMjNiZDBmNTkxIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL3N2bS5jDQo+
IEBAIC0yNzAsNiArMjcwLDcgQEAgc3RydWN0IGFtZF9zdm1faW9tbXVfaXIgew0KPiAgIH07DQo+
ICAgDQo+ICAgI2RlZmluZSBBVklDX0xPR0lDQUxfSURfRU5UUllfR1VFU1RfUEhZU0lDQUxfSURf
TUFTSwkoMHhGRikNCj4gKyNkZWZpbmUgQVZJQ19MT0dJQ0FMX0lEX0VOVFJZX1ZBTElEX0JJVAkJ
CTMxDQo+ICAgI2RlZmluZSBBVklDX0xPR0lDQUxfSURfRU5UUllfVkFMSURfTUFTSwkJKDEgPDwg
MzEpDQo+ICAgDQo+ICAgI2RlZmluZSBBVklDX1BIWVNJQ0FMX0lEX0VOVFJZX0hPU1RfUEhZU0lD
QUxfSURfTUFTSwkoMHhGRlVMTCkNCj4gQEAgLTQ2NDAsNyArNDY0MSw3IEBAIHN0YXRpYyB2b2lk
IGF2aWNfaW52YWxpZGF0ZV9sb2dpY2FsX2lkX2VudHJ5KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkN
Cj4gICAJdTMyICplbnRyeSA9IGF2aWNfZ2V0X2xvZ2ljYWxfaWRfZW50cnkodmNwdSwgc3ZtLT5s
ZHJfcmVnLCBmbGF0KTsNCj4gICANCj4gICAJaWYgKGVudHJ5KQ0KPiAtCQlXUklURV9PTkNFKCpl
bnRyeSwgKHUzMikgfkFWSUNfTE9HSUNBTF9JRF9FTlRSWV9WQUxJRF9NQVNLKTsNCj4gKwkJY2xl
YXJfYml0KEFWSUNfTE9HSUNBTF9JRF9FTlRSWV9WQUxJRF9CSVQsICh1bnNpZ25lZCBsb25nICop
ZW50cnkpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgaW50IGF2aWNfaGFuZGxlX2xkcl91cGRh
dGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQ0KPiANCg==
