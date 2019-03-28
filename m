Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AABCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0341E2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CMJ/Z1TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfC1OIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:08:37 -0400
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:11141
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfC1OIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNBpEDMlWzwBDruFmJE7DaYiYUm24nIqcuLAY9mLsJk=;
 b=CMJ/Z1TDxw06qtCki4cyaXhJH7GP/27QQ/ne1NmMakLeSfCQ8z3C10djZW0qyBFt27n2ivyHbvni/2xiMTK3obUoQtAEGYpXEBcF3cLXZJtmn50qvpeNiQ8eBrHUwZ7u8oeIofbLbGi1i311iUg0atqNXgF3M2+jYtQTYCpYrdE=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2875.namprd12.prod.outlook.com (20.179.71.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Thu, 28 Mar 2019 14:08:33 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::4dd7:e79:1607:b755%5]) with mapi id 15.20.1730.019; Thu, 28 Mar 2019
 14:08:33 +0000
From:   "Singh, Brijesh" <brijesh.singh@amd.com>
To:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/2] KVM: SVM: move the SEV command handling into a
 separate file
Thread-Topic: [PATCH 0/2] KVM: SVM: move the SEV command handling into a
 separate file
Thread-Index: AQHUuk3H4gJB1J4DqUi+VYhv1rGmf6YhatUA
Date:   Thu, 28 Mar 2019 14:08:33 +0000
Message-ID: <43882998-afca-3245-b376-19cdaab2e490@amd.com>
References: <20190201164654.3888-1-brijesh.singh@amd.com>
In-Reply-To: <20190201164654.3888-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1f1e0f1-af2d-42c5-ec91-08d6b386dccd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2875;
x-ms-traffictypediagnostic: DM6PR12MB2875:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB28756A7E0806E4933C47F0F0E5590@DM6PR12MB2875.namprd12.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(478694002)(14454004)(52116002)(2501003)(6306002)(4326008)(68736007)(86362001)(6486002)(66066001)(256004)(6436002)(31696002)(8676002)(81156014)(81166006)(102836004)(99286004)(6512007)(6506007)(53546011)(3846002)(106356001)(6116002)(97736004)(105586002)(8936002)(386003)(76176011)(26005)(186003)(305945005)(53936002)(446003)(229853002)(25786009)(5660300002)(36756003)(11346002)(110136005)(316002)(54906003)(486006)(478600001)(966005)(2906002)(2616005)(71190400001)(71200400001)(31686004)(6246003)(7736002)(476003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2875;H:DM6PR12MB2682.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pDNfixd7xwhqYE86m+c7Ie7dqxnI94Qmo72Ytgig+WfBOKegUG1YU8U6J4HmCuCKUawexHCMml9yxHD0du1w7RDOQmhhGLlCPmZWp2UOK6AVkBTSBoGpN1BgrKg38j4KXgL4HbHSU227QZqpF9KFXiVbonv36IGpPGVhUUfzIG9qtuMhELhCTfYRK0j8xWURyd+G6mRa8V4RUJrtjulKZR6tnzJ8tRO7/oqR8mIqMJUZ/aWCxAIm/V5DS7mvrTXzmL7vOYmL9plPCYxXQ2IwcahoWmDpYgNlZhziwZ2p3ZL72sfQ1SjVOk7VrJVaBzZyjFznnSKKbZVIXjWYh9kw0qupk8Aac6XQb/ZyfxyGRDzuzieLA8b76UoRAm8dkukaXXr14JRqvXQbJb15osZ0xdmKyCv8WSOl7aUwPO8vaRw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76BD16CABBD01D4FBCFF307916C88B6C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f1e0f1-af2d-42c5-ec91-08d6b386dccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 14:08:33.5179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGFvbG8gYW5kIFJhZGltLA0KDQoNCk9uIDIvMS8xOSAxMDo0NyBBTSwgU2luZ2gsIEJyaWpl
c2ggd3JvdGU6DQo+IHN2bS5jIGlzIHByZXR0eSBodWdlLCBiZWZvcmUgd2UgYWRkIG1vcmUgU0VW
IHNwZWNpZmljIGNvbW1hbmRzIChlLmcgU0VWLUVTLA0KPiBTRVYtTWlncmF0aW9uIGV0YykgbGV0
cyBtb3ZlIHRoZSBTRVYgY29tbWFuZCBoYW5kbGluZyBpbnRvIGEgc2VwYXJhdGUgZmlsZS4NCj4g
VGhlcmUgaXMgbm8gbG9naWNhbCBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzLg0KPiANCg0KQW55IHRo
b3VnaHRzIG9uIHRoaXMgc2VyaWVzID8NCg0KDQo+IFRoZSBwYXRjaCBpcyBiYXNlZCBvbiBtb3Rp
dmF0aW9uIGZyb20gdGhpcyB0aHJlYWQ6DQo+IGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWtl
cm5lbCZtPTE1MzkxMDI0MDUwNzM5OSZ3PTINCj4gDQo+IENjOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gQ2M6IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+DQo+
IENjOiAiUmFkaW0gS3LEjW3DocWZIiA8cmtyY21hckByZWRoYXQuY29tPg0KPiBDYzogSm9lcmcg
Um9lZGVsIDxqb3JvQDhieXRlcy5vcmc+DQo+IENjOiBUb20gTGVuZGFja3kgPFRob21hcy5MZW5k
YWNreUBhbWQuY29tPg0KPiANCj4gQnJpamVzaCBTaW5naCAoMik6DQo+ICAgIEtWTTogU1ZNOiBt
b3ZlIGNvbW1vbiBzdHJ1Y3QgZGVmaW5pdGlvbnMgdG8gaGVhZGVyIGZpbGUNCj4gICAgS1ZNOiBT
Vk06IG1vdmUgdGhlIFNFViBzcGVjaWZpYyBmdW5jdGlvbiBpbiBhIHNlcGFyYXRlIGZpbGUNCj4g
DQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vc3ZtLmggfCAgMTU1ICsrKysrDQo+ICAgYXJjaC94
ODYva3ZtL01ha2VmaWxlICAgICAgfCAgICAyICsNCj4gICBhcmNoL3g4Ni9rdm0vc2V2LmMgICAg
ICAgICB8IDEwNzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGFyY2gveDg2
L2t2bS9zZXYuaCAgICAgICAgIHwgICA0MCArKw0KPiAgIGFyY2gveDg2L2t2bS9zdm0uYyAgICAg
ICAgIHwgMTIzNCArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICA1IGZp
bGVzIGNoYW5nZWQsIDEyOTYgaW5zZXJ0aW9ucygrKSwgMTIxMSBkZWxldGlvbnMoLSkNCj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva3ZtL3Nldi5jDQo+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gveDg2L2t2bS9zZXYuaA0KPiANCg0KDQotQnJpamVzaA0K
