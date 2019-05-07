Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32842C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC3E20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kshwGRMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfEGNri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:47:38 -0400
Received: from mail-eopbgr760075.outbound.protection.outlook.com ([40.107.76.75]:58662
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbfEGNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrItdIULoaoyG6nD6rhbuYQO/rMTgTni2ROD0CXj/Uo=;
 b=kshwGRMH1R6sAH8zQyOfZxhcpOh/6gN3vCEbsGjFxMcvS+zmrOovqmwJXxvMwZyk3bckS+ql9XocmFu5cX62xca1NWcCxnwTpFtbZg+PQHMqpsvKb9h2IVjZMbwy4rMHHDXlGyEo61cCnZuV32G2fJ9YiAjc8TnYaTGplRrsrXE=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB1786.namprd12.prod.outlook.com (10.175.91.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 13:47:35 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 13:47:35 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Qian Cai <cai@lca.pw>, "jroedel@suse.de" <jroedel@suse.de>
CC:     "Hook, Gary" <Gary.Hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Thread-Topic: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Thread-Index: AQHVA8HKhrRFrjUPUE6UqWoL4ARBq6Zfr1OA
Date:   Tue, 7 May 2019 13:47:35 +0000
Message-ID: <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
References: <20190506041106.29167-1-cai@lca.pw>
In-Reply-To: <20190506041106.29167-1-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0049.prod.exchangelabs.com (2603:10b6:800::17) To
 DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841f5cb7-f6b2-43b3-3a9a-08d6d2f28f49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1786;
x-ms-traffictypediagnostic: DM5PR12MB1786:
x-microsoft-antispam-prvs: <DM5PR12MB17863BDF30CC4A5E359973E2FD310@DM5PR12MB1786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(53936002)(68736007)(6512007)(256004)(229853002)(14444005)(66066001)(8676002)(81166006)(81156014)(2501003)(3846002)(26005)(71190400001)(71200400001)(476003)(36756003)(6486002)(6436002)(2616005)(446003)(11346002)(6506007)(386003)(52116002)(53546011)(99286004)(102836004)(5660300002)(7736002)(316002)(110136005)(54906003)(6116002)(486006)(305945005)(72206003)(478600001)(66446008)(186003)(14454004)(64756008)(66556008)(66476007)(2906002)(73956011)(66946007)(31686004)(76176011)(25786009)(31696002)(6246003)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1786;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iehGFDvsKQUKjGG8k4lAush6yN+x0xMD4OPm/eLqPaZPKDhtviBdk8Qw3BDBi1FVrO6wJAcn2qZCAV5hPaUazA1roY9hs7L84RLEErbpkyX5BfghjidFWa7o+r4ORy9qFCnBOhLNw0xWt1dqaHiauZRivcq6FmmwRVMyOywJnwqwZBcuKiMMGLUZABpGlrA4EaQYO1iyxJDAMo9a/lZZH7AfQe86sEti/LSa4DcGtgktcjnTmaMSV17yrl7+pAbDfmUiaaLAqtWb7VTP8e3PliMffEe5TdB2IgvtZfK04qc7RQnrte9wz1Z5Ejx9o7CvQuZQCgsZzu4g8w3opVIG+WjMl8TfiQz79ucth4M7xda86PMgBQcOVxY9LU6cffIbYfiUuVD3rQze/r1pkuab3Ypgw3MkzRzWP3oXRgniHx8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <298EF8706C009A43B0877EC26E6790BE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841f5cb7-f6b2-43b3-3a9a-08d6d2f28f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:47:35.2397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS81LzE5IDExOjExIFBNLCBRaWFuIENhaSB3cm90ZToNCj4gW0NBVVRJT046IEV4dGVybmFs
IEVtYWlsXQ0KPiANCj4gVGhlIGNvbW1pdCBlN2Y2M2ZmYzFiZjEgKCJpb21tdS9hbWQ6IFVwZGF0
ZSBsb2dnaW5nIGluZm9ybWF0aW9uIGZvciBuZXcNCj4gZXZlbnQgdHlwZSIpIGludHJvZHVjZWQg
YSB2YXJpYWJsZSAidGFnIiBidXQgaGFkIG5ldmVyIHVzZWQgaXQgd2hpY2gNCj4gZ2VuZXJhdGVz
IGEgd2FybmluZyBiZWxvdywNCj4gDQo+IGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmM6IEluIGZ1
bmN0aW9uICdpb21tdV9wcmludF9ldmVudCc6DQo+IGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmM6
NTY3OjMzOiB3YXJuaW5nOiB2YXJpYWJsZSAndGFnJyBzZXQgYnV0IG5vdA0KPiB1c2VkIFstV3Vu
dXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiAgICBpbnQgdHlwZSwgZGV2aWQsIHBhc2lkLCBmbGFn
cywgdGFnOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+DQo+IHNvIGp1
c3QgdXNlIGl0IGR1cmluZyB0aGUgbG9nZ2luZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFFpYW4g
Q2FpIDxjYWlAbGNhLnB3Pg0KPiAtLS0NCj4gICBkcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIHwg
NCArKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9hbWRfaW9tbXUuYw0KPiBpbmRleCBmN2NkZDJhYjdmMTEuLjUyZjQxMzY5YzViMyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJz
L2lvbW11L2FtZF9pb21tdS5jDQo+IEBAIC02MzEsOSArNjMxLDkgQEAgc3RhdGljIHZvaWQgaW9t
bXVfcHJpbnRfZXZlbnQoc3RydWN0IGFtZF9pb21tdSAqaW9tbXUsIHZvaWQgKl9fZXZ0KQ0KPiAg
ICAgICAgICAgICAgICAgIHBhc2lkID0gKChldmVudFswXSA+PiAxNikgJiAweEZGRkYpDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICgoZXZlbnRbMV0gPDwgNikgJiAweEYwMDAwKTsNCj4g
ICAgICAgICAgICAgICAgICB0YWcgPSBldmVudFsxXSAmIDB4MDNGRjsNCj4gLSAgICAgICAgICAg
ICAgIGRldl9lcnIoZGV2LCAiRXZlbnQgbG9nZ2VkIFtJTlZBTElEX1BQUl9SRVFVRVNUIGRldmlj
ZT0lMDJ4OiUwMnguJXggcGFzaWQ9MHglMDV4IGFkZHJlc3M9MHglbGx4IGZsYWdzPTB4JTA0eF1c
biIsDQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkV2ZW50IGxvZ2dlZCBbSU5WQUxJ
RF9QUFJfUkVRVUVTVCBkZXZpY2U9JTAyeDolMDJ4LiV4IHBhc2lkPTB4JTA1eCB0YWc9MHglMDR4
IGFkZHJlc3M9MHglbGx4IGZsYWdzPTB4JTA0eF1cbiIsDQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICBQQ0lfQlVTX05VTShkZXZpZCksIFBDSV9TTE9UKGRldmlkKSwgUENJX0ZVTkMoZGV2aWQp
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCwgYWRkcmVzcywgZmxhZ3MpOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICBwYXNpZCwgdGFnLCBhZGRyZXNzLCBmbGFncyk7DQo+ICAg
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAg
ICAgICAgZGV2X2VycihkZXYsICJFdmVudCBsb2dnZWQgW1VOS05PV04gZXZlbnRbMF09MHglMDh4
IGV2ZW50WzFdPTB4JTA4eCBldmVudFsyXT0weCUwOHggZXZlbnRbM109MHglMDh4XG4iLA0KDQpJ
IGRpZCBtYW5hZ2UgdG8gb3Zlcmxvb2sgdGhhdCB2YXJpYWJsZSB3aGVuIEkgcG9zdGVkIHRoZSBv
cmlnaW5hbCBwYXRjaC4gDQpCdXQgaXQgbG9va3MgdG8gbWUgbGlrZSA0MWU1OWE0MWZjNWQxIChp
b21tdSB0cmVlKSBhbHJlYWR5IGZpeGVkIHRoaXMuLi4gDQpJJ20gbm90IHN1cmUgd2h5IGl0IG5l
dmVyIGdvdCBwdXNoZWQgdG8gdGhlIG1haW4gdHJlZS4NCg0KZ3JoDQoNCg==
