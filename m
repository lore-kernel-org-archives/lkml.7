Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AC0C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5F220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VtnAd9E/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDHWsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:48:36 -0400
Received: from mail-eopbgr810089.outbound.protection.outlook.com ([40.107.81.89]:55533
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbfDHWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/r81z95aEYlfMzcppooMr0wfmzXERb4mPDQk5T0+Qk=;
 b=VtnAd9E/akXuLYmd0qBubvPXsSq/DQMS+wk78E918NSG+OVdqa3mGZM3uBonegj6X4qUNKmvK23mjAip49xFmDmtVrozFLu6Yc7znfqoRMnm+0u380nAx5y/mOs7mIM9OvVQXRQ8OvjU0a0WCtJb8T2Mo6CbAwRA9d3O2GB/EyA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2654.namprd12.prod.outlook.com (52.135.103.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 22:48:34 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 22:48:34 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Thread-Topic: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Thread-Index: AQHU7hUSYTqXxdHZ3kOiah7oXgcNraYytquAgAACGoCAAAJDAIAAAiCAgAAgghA=
Date:   Mon, 8 Apr 2019 22:48:34 +0000
Message-ID: <SN6PR12MB2639F3E98157872E7C046705F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk> <20190408203431.GM15689@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
 <20190408205013.GN15689@zn.tnic>
In-Reply-To: <20190408205013.GN15689@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7ee6bc0-f227-487c-0f40-08d6bc7454c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2654;
x-ms-traffictypediagnostic: SN6PR12MB2654:
x-microsoft-antispam-prvs: <SN6PR12MB26543E939D3A2E39944AA475F82C0@SN6PR12MB2654.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(189003)(199004)(13464003)(6116002)(68736007)(110136005)(486006)(476003)(3846002)(71200400001)(105586002)(106356001)(2906002)(6436002)(446003)(229853002)(72206003)(81166006)(55016002)(8676002)(81156014)(11346002)(478600001)(5660300002)(66066001)(71190400001)(8936002)(86362001)(54906003)(26005)(305945005)(25786009)(15650500001)(99286004)(186003)(9686003)(102836004)(6246003)(74316002)(14454004)(7696005)(256004)(7736002)(6506007)(53546011)(52536014)(33656002)(4326008)(97736004)(316002)(93886005)(53936002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2654;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: odnZ2UlVA8b0OMGsMRa9VpgkMQwoi/LCVW7K9VXWjECBsGdm2pTKko1e1SKWTDRPXFHZS5xLgBZbCRhA5cgWtDB8OrzIO8Z8RsNrrPLQc56tmahXqEh+2YRYRIvFmMBZYAWmV4d9qbKja/Hu3zShuIpC2EC8cMHDmNA3H3aD2Gb++8y4xd4b/vOJn0gx9fCBDCv80r2zcAvf/CTFY27Q1j81EzmUs2gs5I6v84po8gHRKZhdnerh+cNonpZF55WPisqGeud4sDUSHZnReVDfPMEsadUpydFlT6DXZhYWJDlaCgeKyyS5GyPO390yzqJyVnrymRc9EMCUqtPMyanSxqqcGmpTdHnQJULG22nAXzx20mECizXTmpXcio8Vg61kgXwac3NfpQNUZtwMV1wB3d3w2VLTL578SAs4SGTVnGQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee6bc0-f227-487c-0f40-08d6bc7454c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 22:48:34.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogTW9uZGF5LCBBcHJpbCA4LCAyMDE5IDM6NTAg
UE0NCj4gVG86IEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+DQo+IENjOiBHaGFubmFt
LCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggUkVTRU5EIDQvNV0geDg2L01DRTogTWFrZSBudW1iZXIgb2YgTUNBIGJh
bmtzIHBlcl9jcHUNCj4gDQo+IE9uIE1vbiwgQXByIDA4LCAyMDE5IGF0IDA4OjQyOjM2UE0gKzAw
MDAsIEx1Y2ssIFRvbnkgd3JvdGU6DQo+ID4gPiBBY3R1YWxseSwgaXQgc2hvdWxkIG5vdCBiZSBl
eHBvcnRlZCBhdCBhbGwuIEEgZnVuY3Rpb24gcmV0dXJuaW5nIHRoZSBudW0NCj4gPiA+IGJhbmtz
IGlzIGJldHRlciBpbnN0ZWFkLg0KPiA+DQo+ID4gQXJlIGFsbCB0aGUgcGxhY2VzIGl0IGlzIHVz
ZWQgaW4gbm9uLXByZS1lbXB0aWJsZSBzZWN0aW9ucyBvZiBjb2RlPyBMb29waW5nDQo+ID4gaW4g
dGhlIENNQ0kgYW5kICNNQyBoYW5kbGVycyBzaG91bGQgYmUgZmluZS4gQnV0IGRvIHdlIG5lZWQg
Z2V0X2NwdSgpL3B1dF9jcHUoKQ0KPiA+IGluIGFueSBwbGFjZXM/DQo+IA0KPiBUaGF0IGV4cG9y
dCBpcyBuZWVkZWQgb25seSBpbiB0aGUgbWNlIGluamVjdG9yLiBBY3R1YWxseSwgaXQgd291bGQg
YmUNCj4gbXVjaCBjbGVhbmVyIGlmIHRoZSBpbmplY3RvciB3b3VsZCBmaW5kIG91dCB0aGUgY291
bnQgc3RyYWlnaHQgZnJvbSB0aGUNCj4gTVNSIGFzIGl0IGRvZXMgbm93LCBidXQgYmUgY2hhbmdl
ZCB0byBkbyByZG1zcl9vbl9jcHUoKSBub3csIHNpbmNlIGNhbg0KPiBoYXZlIGRpZmZlcmVudCBu
dW1fYmFua3Mgb24gYSBDUFUuDQo+IA0KDQpPa2F5LCBzbyBkcm9wIHRoZSBleHBvcnQgYW5kIGxl
YXZlIHRoZSBpbmplY3RvciBjb2RlIGFzLWlzIChpdCdzIGFscmVhZHkgZG9pbmcgYSByZG1zcmxf
b25fY3B1KCkpLg0KDQpJcyB0aGF0IG9rYXk/DQoNClRoYW5rcywNCllhemVuDQo=
