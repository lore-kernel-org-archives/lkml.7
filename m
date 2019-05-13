Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95ACC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9622133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="wwnUbEVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfEMMxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:53:35 -0400
Received: from mail-eopbgr810075.outbound.protection.outlook.com ([40.107.81.75]:8611
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbfEMMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOHNDlv7Z9xLLYFi+6AO20FAjZwLIDELmzvJGn4alis=;
 b=wwnUbEVdDlRz47o5qQoEZ/P/2LsAj16gCABBvFggxqG0Sry1Ktv4FrqXUfDsOAvYPKJxibmk+KDa4PDRrB1dtrXAccw8H3FwdNiaW0s6376lBcAoV/LO/ahCPEV6xRBoWjUd2Icb9ovrUSCxaOtiZB6nl7qoB6INjApcCXDwNIY=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6478.namprd05.prod.outlook.com (20.178.246.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.11; Mon, 13 May 2019 12:53:21 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::60b8:98a9:5fab:36ee]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::60b8:98a9:5fab:36ee%4]) with mapi id 15.20.1900.010; Mon, 13 May 2019
 12:53:21 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "murray.mcallister@gmail.com" <murray.mcallister@gmail.com>
CC:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH] drm/vmwgfx: NULL pointer dereference from
 vmw_cmd_dx_view_define()
Thread-Topic: [PATCH] drm/vmwgfx: NULL pointer dereference from
 vmw_cmd_dx_view_define()
Thread-Index: AQHVB79XrPbxylocs0WNutclw/x82KZpBisA
Date:   Mon, 13 May 2019 12:53:21 +0000
Message-ID: <7690e0f28bc1c11db323179cd64ce3ec6a5ca8af.camel@vmware.com>
References: <20190511060138.20592-1-murray.mcallister@gmail.com>
In-Reply-To: <20190511060138.20592-1-murray.mcallister@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e289c92e-0bf9-4212-2499-08d6d7a1fadf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6478;
x-ms-traffictypediagnostic: MN2PR05MB6478:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <MN2PR05MB6478CCD01D4DF66D9781F169A10F0@MN2PR05MB6478.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(6116002)(6246003)(3846002)(2616005)(11346002)(54906003)(446003)(8676002)(81156014)(81166006)(8936002)(99286004)(25786009)(36756003)(2501003)(68736007)(102836004)(2906002)(4326008)(5640700003)(6512007)(6486002)(229853002)(256004)(6436002)(71200400001)(71190400001)(53936002)(486006)(476003)(1361003)(118296001)(66066001)(91956017)(316002)(6916009)(76116006)(5660300002)(66946007)(64756008)(66446008)(66556008)(66476007)(73956011)(26005)(186003)(2351001)(76176011)(86362001)(478600001)(6506007)(305945005)(14454004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6478;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xx2vjx1JiD+IQDCeFjRU89UDUf1ms9pYRegOwyIHlY1HqJeSYBxd+39qO+OGtXu76UCEvLhH1jgSDjZj8skofYdCKah/B+8T4kqE8pJCV5+0KavWsfKf87OHc3eUIq9g10Y1wVkXvZ8RCk7EJdg1OczBea/eDq3K4XsqqsuY+IISJFVvpKAV57DAI83/4jkHloAK1FhNN2TFy6t+L9rFt9YS0BrER3dSc2jya6mqEY7Fa9xJUFT710BRUSK8y1ArD3pbl4gnkar2/Kd4zK9u+aqAo2W+2upzGHOHsWF7gccXxyNSg+uiawHQ0dkISlfhv0wQwhiIGYBbjlv9GgoGwPrKp+mUlUG4Z6d9S1tqVQbl05lutG1QU4mfXBuV4O3erzjj65DRjhmMVgcFWD0NWW8sGUzhw37w255Z3tbH0gU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8FA1B287F0A6248BD35D8049F8378CF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e289c92e-0bf9-4212-2499-08d6d7a1fadf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 12:53:21.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDE5LTA1LTExIGF0IDE4OjAxICsxMjAwLCBNdXJyYXkgTWNBbGxpc3RlciB3cm90
ZToNCj4gSWYgU1ZHQV8zRF9DTURfRFhfREVGSU5FX1JFTkRFUlRBUkdFVF9WSUVXIGlzIGNhbGxl
ZCB3aXRoIGEgc3VyZmFjZQ0KPiBJRCBvZiBTVkdBM0RfSU5WQUxJRF9JRCwgdGhlIHNyZiBzdHJ1
Y3Qgd2lsbCByZW1haW4gTlVMTCBhZnRlcg0KPiB2bXdfY21kX3Jlc19jaGVjaygpLCBsZWFkaW5n
IHRvIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIGluDQo+IHZtd192aWV3X2FkZCgpLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTXVycmF5IE1jQWxsaXN0ZXIgPG11cnJheS5tY2FsbGlzdGVyQGdt
YWlsLmNvbT4NCg0KVGhhbmtzLCBJJ2xsIGFkZCB0aGlzIHRvIHRoZSBuZXh0IC1maXhlcyBwdWxs
Lg0KVGhvbWFzDQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2V4
ZWNidWYuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2V4ZWNidWYuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13Z2Z4X2V4ZWNidWYuYw0KPiBpbmRleCAyZmY3
YmEwNGQ4YzguLjQ0N2FmZDA4NjIwNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Zt
d2dmeC92bXdnZnhfZXhlY2J1Zi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92bXdnZngvdm13
Z2Z4X2V4ZWNidWYuYw0KPiBAQCAtMjQxNCw2ICsyNDE0LDEwIEBAIHN0YXRpYyBpbnQgdm13X2Nt
ZF9keF92aWV3X2RlZmluZShzdHJ1Y3QNCj4gdm13X3ByaXZhdGUgKmRldl9wcml2LA0KPiAgCQly
ZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiAgCWNtZCA9IGNvbnRhaW5lcl9vZihoZWFkZXIsIHR5cGVv
ZigqY21kKSwgaGVhZGVyKTsNCj4gKwlpZiAodW5saWtlbHkoY21kLT5zaWQgPT0gU1ZHQTNEX0lO
VkFMSURfSUQpKSB7DQo+ICsJCURSTV9FUlJPUigiSW52YWxpZCBzdXJmYWNlIGlkLlxuIik7DQo+
ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gIAlyZXQgPSB2bXdfY21kX3Jlc19jaGVjayhk
ZXZfcHJpdiwgc3dfY29udGV4dCwgdm13X3Jlc19zdXJmYWNlLA0KPiAgCQkJCVZNV19SRVNfRElS
VFlfTk9ORSwNCj4gdXNlcl9zdXJmYWNlX2NvbnZlcnRlciwNCj4gIAkJCQkmY21kLT5zaWQsICZz
cmYpOw0K
