Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDFEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7C020879
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 17:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X5vXihH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfCWRWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 13:22:17 -0400
Received: from mail-eopbgr710074.outbound.protection.outlook.com ([40.107.71.74]:40299
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbfCWRWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRvBP0APmZJ/rJttL7En9aVx/3vkk+6V3cf/oxGZ83M=;
 b=X5vXihH5J1fgvIFr7MG1nUuj1BrsYVeC6mjs82kUf6QoYqUjlyBHrP7oy56eO9dwWCXoCG/+sxUaCMZCpXYRrZT9owH3+HbWRQpH8xr1FjocBXbwLwZH+qPilnS7JHcufwvCNdBMFXAqPnx5sH3AlDiWaVGmLwl/iFp1o3NVZ4Y=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2669.namprd12.prod.outlook.com (52.135.103.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Sat, 23 Mar 2019 17:22:14 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1730.013; Sat, 23 Mar 2019
 17:22:14 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Thread-Topic: [PATCH v3 3/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Thread-Index: AQHUz3tUScjw79nRdk2YLwwHsenigaYZRVSAgABVYfA=
Date:   Sat, 23 Mar 2019 17:22:14 +0000
Message-ID: <SN6PR12MB2639EFF2DFF030F442075013F85C0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
 <20190228153558.127292-3-Yazen.Ghannam@amd.com>
 <20190323121546.GA17541@zn.tnic>
In-Reply-To: <20190323121546.GA17541@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:e099:d447:2979:dd3f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a28f3516-c012-47ca-0e2e-08d6afb417dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2669;
x-ms-traffictypediagnostic: SN6PR12MB2669:
x-microsoft-antispam-prvs: <SN6PR12MB2669FA53D5DC856B50FD2959F85C0@SN6PR12MB2669.namprd12.prod.outlook.com>
x-forefront-prvs: 0985DA2459
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(13464003)(2906002)(81156014)(8676002)(6916009)(229853002)(476003)(81166006)(14444005)(486006)(11346002)(6116002)(508600001)(186003)(97736004)(9686003)(53936002)(105586002)(446003)(33656002)(6246003)(8936002)(4326008)(6436002)(106356001)(99286004)(46003)(68736007)(6506007)(76176011)(53546011)(55016002)(25786009)(7696005)(54906003)(52536014)(14454004)(316002)(7736002)(86362001)(72206003)(71190400001)(256004)(5660300002)(71200400001)(102836004)(74316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2669;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eH0Zp3eqeT4UmlYgZADkNoPNmtTMxx7gGYmBiNVYJROHDHitS6hFzhQQSUNvCoItcHQnYDMEX9JLBaqgg1bvErnRN2lNrHzyaYsWKSYVB7ANLoxhw6RKaI8f3F+fDOSH0YMHuHzE3+q8rDziWKRrS4k+kiXKTGJQTKfRBTBq/SX+Xj7+NrO3TO9ACj8bZFQXlHm9+rULyiOFc1+9fMVR0uwKmVIHHpGI9mJyVSlHm/jXllwuYdABObeDuMccVvDbaNplo7Nodfgnz+scd+V2EvuJpOJVMxTz+XpIiiJCshNNOU0Q35I3WGLQiwbqMEO1LaX7B5wR0HD65BopOyMx3axt/U2J/KZNcfhC6qH4WjSAFWgvgir3SqHqLnQjCvNu3Hh3T+SyHst200ktDMEItcWDgJC9LLEfnUm9zJuPrgo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28f3516-c012-47ca-0e2e-08d6afb417dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2019 17:22:14.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2669
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDIzLCAyMDE5IDc6
MTYgQU0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENj
OiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNl0gRURBQy9hbWQ2NDogU3VwcG9ydCBtb3Jl
IHRoYW4gdHdvIFVuaWZpZWQgTWVtb3J5IENvbnRyb2xsZXJzDQo+IA0KPiBPbiBUaHUsIEZlYiAy
OCwgMjAxOSBhdCAwMzozNjoxMFBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuaCBiL2RyaXZlcnMvZWRhYy9hbWQ2
NF9lZGFjLmgNCj4gPiBpbmRleCBkZThkYmIwYjQyYjUuLjQwZTYzY2VhMmQ4MSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5oDQo+ID4gKysrIGIvZHJpdmVycy9lZGFj
L2FtZDY0X2VkYWMuaA0KPiA+IEBAIC0yNzQsNyArMjc0LDExIEBADQo+ID4NCj4gPiAgI2RlZmlu
ZSBVTUNfU0RQX0lOSVQJCQlCSVQoMzEpDQo+ID4NCj4gPiAtI2RlZmluZSBOVU1fVU1DUwkJCTIN
Cj4gPiArLyoNCj4gPiArICogTnVtYmVyIG9mIFVuaWZpZWQgTWVtb3J5IENvbnRyb2xsZXJzDQo+
ID4gKyAqIFNldCBkdXJpbmcgZHJpdmVyIGluaXQgYmFzZWQgb24gZmFtaWx5L21vZGVsLg0KPiA+
ICsgKi8NCj4gPiArc3RhdGljIHU4IG51bV91bWNzOw0KPiANCj4gUGxlYXNlIGRvbid0IGRvIHNp
bGx5IHRoaW5ncyBsaWtlIHRoYXQ6DQo+IA0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVy
cy9lZGFjL2FtZDY0X2VkYWNfaW5qLmM6MjowOg0KPiBkcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5o
OjI3OToxMTogd2FybmluZzog4oCYbnVtX3VtY3PigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLXZhcmlhYmxlXQ0KPiAgc3RhdGljIHU4IG51bV91bWNzOw0KPiAgICAgICAgICAgIF5+
fn5+fn5+DQo+IA0KPiBJIGZpeGVkIGl0IHVwIG5vdy4NCj4gDQoNClRoYW5rcy4gU29ycnkgSSBt
aXNzZWQgdGhhdC4NCg0KLVlhemVuDQo=
