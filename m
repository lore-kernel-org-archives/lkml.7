Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986EEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DE32075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tgBKRk4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfCMTDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:03:36 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:51120
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfCMTDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IB4yrrEqhNU/Ba0wC8TtqKs8KeEgLTVmx7zb8ffzOi4=;
 b=tgBKRk4L2Wy5Lpu9fVR9PCWxz6sZQxsFu3r+ncCaThMLASiTl8op4eKSecl6phstKpe5fGYxTMlOXsBvw9vvy77r98nQCuFdMzDudjjmAZ7y6dUC9gHdB43wHdB3/36IZi4mnhpTXAD3SkQImwoV+TvpzfyHVArtckNIOL+ekew=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3530.namprd12.prod.outlook.com (20.179.106.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 19:03:32 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::3589:a066:e1d:b1f0%5]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 19:03:32 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Oren Twaig <oren@scalemp.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shai (Shai@ScaleMP.com)" <Shai@scalemp.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>
Subject: Re: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Topic: [PATCH] svm: Fix AVIC incomplete IPI emulation
Thread-Index: AQHU0rY9293WXGT45E2nygfc4G4QEKYGWFMAgALfaQCAAF2XAIAAZBqA
Date:   Wed, 13 Mar 2019 19:03:31 +0000
Message-ID: <828b24bb-a55b-dd5f-a514-ef3e182db5cd@amd.com>
References: <d53d2240-d1f1-da04-9126-9eb3518d0047@scalemp.com>
 <ab2b29ac-adcf-12ab-7c53-cc427995e94c@amd.com>
 <752f5b0a-381c-d559-ec8a-dc41b1e36010@scalemp.com>
 <58fabfcd-7f32-a9fe-1244-6d9af2b94582@scalemp.com>
In-Reply-To: <58fabfcd-7f32-a9fe-1244-6d9af2b94582@scalemp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
x-originating-ip: [110.169.70.41]
x-clientproxiedby: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DM6PR12MB2844.namprd12.prod.outlook.com (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd9dfca8-c06a-4f78-4a17-08d6a7e695a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3530;
x-ms-traffictypediagnostic: DM6PR12MB3530:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB3530CF918E15556A7B5FF283F34A0@DM6PR12MB3530.namprd12.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(346002)(366004)(136003)(396003)(51914003)(189003)(199004)(11346002)(446003)(6246003)(53936002)(305945005)(7736002)(71200400001)(71190400001)(486006)(86362001)(476003)(2616005)(68736007)(4326008)(6512007)(65806001)(65956001)(66066001)(31686004)(186003)(65826007)(6306002)(102836004)(256004)(14444005)(106356001)(31696002)(26005)(105586002)(2906002)(25786009)(76176011)(386003)(53546011)(6506007)(5660300002)(72206003)(99286004)(6116002)(478600001)(316002)(8676002)(3846002)(966005)(52116002)(58126008)(8936002)(14454004)(81166006)(54906003)(81156014)(93886005)(6916009)(229853002)(64126003)(6436002)(6486002)(36756003)(97736004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3530;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M9MqHIRDXHe9UvnPO35o9oBuJ/BScFLv6ACR12IcqnyGQZkyjptaehn2mnpe3y+5s4CAlSQpkykHV9JiCVn9XCu/ALIQNA4oJ2pjzLALRH0OcM60iPxLEuI02evw0X/ogLwu0UE5YtuXXCp1OlQqY4r+o5HpTSmWECeXLmZkpXSON13qn7IqyXpJaxnIooHwap0CTp8a0bCEmpD1bMyTT/83jvMoFLeITwPXrmfH2m7hEy3kWLIniG0D9TAO0Qf7rpiqDW70gefzWTm6nd/cMV37q5ogH6eZ1+fijoLyt1eUPd9thdkryG2SzUeYITc8RNAcqSc0jrbsuC4DyIaPWfTgmCxLj3GmzytH4NlId0oYiAFBqn00B2AmHzkPUPv0mSQGtlcpORFhK9U5eSg9iEQPyXzuH9zLkiXWmnPM348=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2D1792C4CFF7F4AADFF6554AD4283FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9dfca8-c06a-4f78-4a17-08d6a7e695a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 19:03:31.8269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3Jlbg0KDQpPbiAzLzEzLzE5IDg6MDUgUE0sIE9yZW4gVHdhaWcgd3JvdGU6DQo+IEhpwqBTdXJh
dmVlLA0KPiANCj4gVHVybnPCoG91dCzCoHRoZSBfc2FtZV/CoGJ1Z8Kgd2FzwqBhbHJlYWR5wqBk
aXNjdXNzZWTCoGluwqB0aGXCoHBhc3TCoGJ5DQo+IHlvdXJzZWxmLMKgUGFvbG/CoGFuZMKgUmFk
aW3CoChib3RowqBub3fCoCdjYyctZWQpDQo+IA0KPiBQbGVhc2XCoHJlYWTCoGl0wqBoZXJlOg0K
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzgyOTIyMzEvDQo+IA0KPiANCj4g
QWZ0ZXLCoHJlYWRpbmfCoHRoYXTCoHRocmVhZCzCoEnCoGhhdmXCoGNvdXBsZcKgb2bCoHF1ZXN0
aW9uczoNCj4gDQo+IEZpcnN0LA0KPiANCj4gWW91wqB3cm90ZcKgOsKgIknCoGhhdmXCoHRyaWVk
wqBOT1TCoHNldHRpbmfCoHRoZcKgSVJSLMKgYW5kwqBvbmx5DQo+IGtpY2tfdmNwdSgpLsKgQW5k
wqB0aGluZ3PCoHNlZW3CoHRvwqB3b3JrwqBmaW5lLsKgVGhlcmVmb3JlLMKgScKgdGhpbmvCoHlv
dXINCj4gYW5hbHlzaXPCoGlzwqBsaWtlbHnCoHRvwqBiZcKgY29ycmVjdC4iDQo+IA0KPiBBRkFJ
VSzCoGl0wqBtZWFuc8KgdGhhdMKgdGhlwqBiZWxvd8KgcGF0Y2jCoGlzwqB3cm9uZ8KganVzdMKg
YXPCoFBhb2xvDQo+IHN1Z2dlc3RlZMKgaW7CoGhpc8Kgb3JpZ2luYWzCoGFuc3dlcsKgYW5kwqB5
b3XCoGRpZMKgZml4ZWTCoGl0wqBiYWNrwqB0aGFuLMKgYnV0wqB0aGUNCj4gY29kZcKgaXPCoG5v
d8KgYmFja8KgPw0KDQpUaGFua3MgZm9yIHRoZSByZWNhcC4gSSB3YXMgY2hhc2luZyBhIGJ1ZyBh
bmQgdG90YWxseSBmb3Jnb3QgYWJvdXQgdGhpcw0KZGlzY3Vzc2lvbi4gSSBqdXN0IGZvdW5kIHRo
ZSByZWFzb24gd2h5IGlycl9wZW5kaW5nIHdhcyBub3Qgc2V0IHRvIDEgaW4gbXkgdGVzdCwNCndo
aWNoIHRoZW4gY2F1c2VzIHRoZSB0YXJnZXQgdmNwdSB0byBuZXZlciBnZXQgd2FrZSB1cCBhbmQg
c2NoZWR1bGVkIHRvIHByb2Nlc3MNCnRoZSBJUlIgYml0IHRoYXQgd2FzIHNldCBieSBBVklDIGFz
IHBhcnQgb2Ygc2VuZGluZyBJUEkuDQoNCkkgd2lsbCBzZW5kIG91dCBhIHBhdGNoIHRvIHJldmVy
dCBhbmQgY2xlYW4gdXAgdGhpcyBtZXNzLiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuDQpBbmQg
c29ycnkgZm9yIGNvbmZ1c2lvbi4NCg0KVGhhbmtzLA0KU3VyYXZlZQ0K
