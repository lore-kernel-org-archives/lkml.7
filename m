Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A042075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AW0vRdiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfCZTPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:15:33 -0400
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:58272
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfCZTPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxn1zG/WydS/HwvGR3F0Y/gTg8ovHUwq3R/S73oN2Lw=;
 b=AW0vRdiyc1U2jPhqft30D6R3SBm0IkZ18MGeH8+5VBkRPYifv920lc+wv/E1Htru9Z0DURcq5Ulq5Th8Mcb7E7Y4uUAXuZzsx8ad7Ppd0wY81nnR+P150kRtlm9ugRKnjXb8RwrBWKVzJ1zlAs8Q5SIHY4WAJ7BBS9/eRc+bwGE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 19:15:29 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 19:15:29 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/amd64: Use maximum channel count for the EDAC
 channel layer size
Thread-Topic: [PATCH] EDAC/amd64: Use maximum channel count for the EDAC
 channel layer size
Thread-Index: AQHU40oCFvOyy4xqaEiYK0CJr0cY8aYeEgGAgAA3vTA=
Date:   Tue, 26 Mar 2019 19:15:29 +0000
Message-ID: <SN6PR12MB263952B80F35F51AECB6AFFAF85F0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190325203319.7603-1-Yazen.Ghannam@amd.com>
 <20190326155511.GM1867@zn.tnic>
In-Reply-To: <20190326155511.GM1867@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [172.56.20.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e2ba3d1-5207-46a3-a1d6-08d6b21f6933
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
x-ms-traffictypediagnostic: SN6PR12MB2688:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB26881F17152B31E4CB77BA39F85F0@SN6PR12MB2688.namprd12.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(13464003)(55016002)(6306002)(54906003)(72206003)(6506007)(26005)(76176011)(25786009)(229853002)(316002)(6916009)(4326008)(74316002)(8936002)(966005)(305945005)(102836004)(106356001)(53546011)(33656002)(7696005)(7736002)(186003)(97736004)(478600001)(81166006)(52536014)(81156014)(5660300002)(68736007)(8676002)(9686003)(11346002)(256004)(14444005)(3846002)(105586002)(6116002)(2906002)(53936002)(486006)(14454004)(476003)(446003)(6436002)(71200400001)(99286004)(86362001)(66066001)(71190400001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V3eYMiKgS0EUv4NGcA7KDXusVpMEQ1Dr23IGmAmxsZuSpxCfcp337AYPglNx16K/i8Vde62xt0gAs+GZbNmVxGkIpVnldnoWFFscP2kVr2SqcIRWXJALwxCmBqbzNRAzPFFIv2WWyMac5xwqiSTadXhQNmfkMJaHHoIKZiz9ltoMe5LjIQXRtel6GWWJ4TbECL9Ez0OYyKkfeHA/xTZWrBO++eifp7i96boDzdmfg/QvQUmpf2YyYmAhERWLTnW8eQFL8P3TkCsz3JL1X0fZtXOvzt9ygRTL9Qr5L/FkXBJHD6rpI8yGBEJ9Bhzpj+hh4DGhAOA/JeRiHwbyH7mAVDd/S2YSwNh8f7+hD9/vQxrLQIOia9CDggA+SGttGV3qV3K+j6oi89FWGcLYdgOqiYgXf5o2eIYnxg/G7sFe3eM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2ba3d1-5207-46a3-a1d6-08d6b21f6933
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 19:15:29.7294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjYsIDIwMTkgMTA6NTUgQU0NCj4g
VG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBsaW51eC1l
ZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBFREFDL2FtZDY0OiBVc2UgbWF4aW11bSBjaGFubmVsIGNvdW50IGZv
ciB0aGUgRURBQyBjaGFubmVsIGxheWVyIHNpemUNCj4gDQo+IE9uIE1vbiwgTWFyIDI1LCAyMDE5
IGF0IDA4OjMzOjMwUE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IEZyb206IFlh
emVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPg0KPiA+IFRoZSBBTUQ2NCBF
REFDIG1vZHVsZSBjdXJyZW50IGhhcmRjb2RlcyB0aGUgRURBQyBjaGFubmVsIGxheWVyIHNpemUN
Cj4gPiAoY291bnQpIHRvIHR3by4gRnV0dXJlIEFNRCBzeXN0ZW1zIG1heSBoYXZlIG1vcmUgY2hh
bm5lbHMgdGhhbiB0aGlzLg0KPiA+DQo+ID4gU2V0IHRoZSBFREFDIGNoYW5uZWwgbGF5ZXIgc2l6
ZSBlcXVhbCB0byB0aGUgbWF4aW11bSBudW1iZXIgb2YgY2hhbm5lbHMNCj4gPiBwb3NzaWJsZSBm
b3IgdGhlIHN5c3RlbS4gT24gRmFtaWx5IDE3aCBhbmQgbGF0ZXIsIHRoaXMgaXMgc2V0IGluIHRo
ZQ0KPiA+IG51bV91bWNzIHZhcmlhYmxlLiBPbGRlciBzeXN0ZW1zIHdpbGwgY29udGludWUgdG8g
dXNlIHR3byBhcyB0aGUNCj4gPiBkZWZhdWx0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWF6
ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2VkYWMvYW1kNjRfZWRhYy5jIHwgOCArKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBPaywgd2hvbGUgcGlsZSBoZXJlOg0K
PiANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnAv
YnAuZ2l0L2xvZy8/aD1lZGFjLWZvci01LjItYW1kNjQNCj4gDQo+IFBsZWFzZSBydW4gaXQgdG8g
Y2hlY2sgYWxsIGlzIHN0aWxsIGdvb2QuDQo+IA0KDQpKdXN0IHRlc3RlZCBvbiBhIGZ1bGx5IHBv
cHVsYXRlZCBzeXN0ZW0uIEV2ZXJ5dGhpbmcgc2VlbXMgdG8gYmUgb2theS4NCg0KVGhhbmtzLA0K
WWF6ZW4NCg==
