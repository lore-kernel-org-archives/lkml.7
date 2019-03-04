Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF3D2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="twi6ur6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfCDPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:51:48 -0500
Received: from mail-eopbgr780059.outbound.protection.outlook.com ([40.107.78.59]:8997
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbfCDPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaRTqDfuFtKZ5eGz8W87EzKW2UV/8+1rlo1n6d1C3lQ=;
 b=twi6ur6xzWmSE1RS59MA/hZdLMAYZSqrl7DdqTu6DcX76vvzig41QMHKWtCm6EeqjGqk2iX/SwnH4aTKS05eQ/V3aQkVxcL3OjURKCbxxD9URfI/3Ty7V5BhSij7iAmJvsW/Yd404Io5jZloCxMshi8ipEPeTgb2NcFgiFO2dUQ=
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (20.178.197.10) by
 BYAPR12MB3205.namprd12.prod.outlook.com (20.179.92.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Mon, 4 Mar 2019 15:51:44 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::a92d:c93:ed77:b0a9]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::a92d:c93:ed77:b0a9%4]) with mapi id 15.20.1643.022; Mon, 4 Mar 2019
 15:51:44 +0000
From:   "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
To:     Helen Koike <helen.koike@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     =?utf-8?B?U3TDqXBoYW5lIE1hcmNoZXNpbg==?= <marcheu@google.com>,
        Sean Paul <seanpaul@google.com>,
        David Airlie <airlied@linux.ie>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH 3/5] drm/amd: fix fb references in async update
Thread-Topic: [PATCH 3/5] drm/amd: fix fb references in async update
Thread-Index: AQHU0pmADEoe1dDs6Uubz0u/ZEP0bKX7nx6A
Date:   Mon, 4 Mar 2019 15:51:44 +0000
Message-ID: <e421e3c9-abb0-5763-1aa0-1e21e0abd09f@amd.com>
References: <20190304144909.6267-1-helen.koike@collabora.com>
 <20190304144909.6267-4-helen.koike@collabora.com>
In-Reply-To: <20190304144909.6267-4-helen.koike@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: QB1PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::46) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nicholas.Kazlauskas@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b06ea09c-c6e6-4aaf-fd36-08d6a0b94d3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3205;
x-ms-traffictypediagnostic: BYAPR12MB3205:
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3205;20:U9+83sfaGbckTGaEoNvWWUYhd0fG3qby4V6sU8wHlv9sqKqR/H8O2fWUnpVI6rFIZTJZlW8wktVDMrt3WGll0JI4TH30ON8ItuiwsciUKh0UMtESSD/a0+L8B+d0woaKrFO8fNmAqIhcZ9nVvlEASv1KkXl4hVzAMgkdxv2KJKrWyYlfr55uTlxRlK7WhCpwi6rFLsgEdC1cqOyDJ0n1OMIO6vwCPVyz10VK41ey35eHAx3D7IcMWd4OYPpHhV29
x-microsoft-antispam-prvs: <BYAPR12MB3205422CA505B7CDC853741FEC710@BYAPR12MB3205.namprd12.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(3846002)(97736004)(54906003)(105586002)(478600001)(66066001)(386003)(106356001)(15650500001)(76176011)(72206003)(52116002)(6116002)(36756003)(316002)(6436002)(31686004)(68736007)(2906002)(81166006)(8936002)(110136005)(8676002)(53936002)(81156014)(6506007)(99286004)(14454004)(6486002)(6512007)(486006)(31696002)(476003)(6246003)(446003)(11346002)(14444005)(256004)(86362001)(71200400001)(71190400001)(4326008)(2616005)(5660300002)(7736002)(7416002)(25786009)(26005)(2501003)(229853002)(186003)(305945005)(53546011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3205;H:BYAPR12MB3560.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ox9tdtF0UXrEkBMZOrQHQapcXR/sTo5nR7AIsOsRnmxZOryXeS5rVbF24o0nK4nuttB8KpkX4V7PZ2fnCHJOXuHESLUy6PUVwuFWvhCdrLVimyE3aKXKtdRz97gdRdJF+ABZnDdtvfjRc6PzdR9V/j46GvwPmQbRBMcEZ9l5V02d0qEaoBCtmd55Z5VyoHmjI0ktmmi+6z0AYNKaW5ao1NB9fpwi2gQbykK89Hpk+M/YcZHyj9HuWP7eYOEv3FXhq4GXdkF67YgaX1xemLf9wfCCHNVbGDVlSL2d9TErc12/iUrEmOWolMXk1C0h81OUn8KD0UOYpA//SJUR9u3wXirPx0ffb/HN4V6Lat3FzeqZENNXHD14YVY1bdqAn0xXg1BgC/JMZcYSbcEPupCFZ0+ha3G5C0eHlCDuYFVhrP8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B932A95D0EACEC4B8B799D6037EF32F6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b06ea09c-c6e6-4aaf-fd36-08d6a0b94d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 15:51:43.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzE5IDk6NDkgQU0sIEhlbGVuIEtvaWtlIHdyb3RlOg0KPiBBc3luYyB1cGRhdGUgY2Fs
bGJhY2tzIGFyZSBleHBlY3RlZCB0byBzZXQgdGhlIG9sZF9mYiBpbiB0aGUgbmV3X3N0YXRlDQo+
IHNvIHByZXBhcmUvY2xlYW51cCBmcmFtZWJ1ZmZlcnMgYXJlIGJhbGFuY2VkLg0KPiANCj4gQ2Fs
bGluZyBkcm1fYXRvbWljX3NldF9mYl9mb3JfcGxhbmUoKSAod2hpY2ggZ2V0cyBhIHJlZmVyZW5j
ZSBvZiB0aGUgbmV3DQo+IGZiIGFuZCBwdXQgdGhlIG9sZCBmYikgaXMgbm90IHJlcXVpcmVkLCBh
cyBpdCdzIHRha2VuIGNhcmUgYnkNCj4gZHJtX21vZGVfY3Vyc29yX3VuaXZlcnNhbCgpIHdoZW4g
Y2FsbGluZyBkcm1fYXRvbWljX2hlbHBlcl91cGRhdGVfcGxhbmUoKS4NCj4gDQo+IFN1Z2dlc3Rl
ZC1ieTogQm9yaXMgQnJlemlsbG9uIDxib3Jpcy5icmV6aWxsb25AY29sbGFib3JhLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSGVsZW4gS29pa2UgPGhlbGVuLmtvaWtlQGNvbGxhYm9yYS5jb20+DQoN
ClJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFt
ZC5jb20+DQoNCkkgZ3Vlc3MgdGhlIHN3YXAgaXRzZWxmIHNob3VsZCBiZSBlbm91Z2ggaGVyZSBh
cyBwZXIgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbi4NCg0KSXQgd291bGQgaGF2ZSBiZWVuIG5pY2Ug
aWYgdGhpcyBwYXRjaCBkcm9wcGVkIHRoZSBvbGRfcGxhbmVfc3RhdGUtPmZiICE9IA0KbmV3X3Bs
YW5lX3N0YXRlLT5mYiBjaGVjayB0b28gYXQgdGhlIHNhbWUgdGltZSwgYnV0IEkgc3VwcG9zZSBJ
IGNhbiBkcm9wIA0KdGhhdCBsYXRlci4gSXQnbGwgaGVscCB1cyBwYXNzIHRob3NlIGZhaWxpbmcg
SUdUIHRlc3RzIGFzIHdlbGwuDQoNCk5pY2hvbGFzIEthemxhdXNrYXMNCg0KDQo+IA0KPiAtLS0N
Cj4gSGVsbG8sDQo+IA0KPiBBcyBtZW50aW9uZWQgaW4gdGhlIGNvdmVyIGxldHRlciwNCj4gSSB0
ZXN0ZWQgb24gdGhlIHJvY2tjaGlwIGFuZCBvbiBpOTE1IHVzaW5nIGlndCBwbGFuZV9jdXJzb3Jf
bGVnYWN5IGFuZA0KPiBrbXNfY3Vyc29yX2xlZ2FjeSBhbmQgSSBkaWRuJ3Qgc2VlIGFueSByZWdy
ZXNzaW9ucy4NCj4gQnV0IEkgY291bGRuJ3QgdGVzdCBvbiBBTUQgYmVjYXVzZSBJIGRvbid0IGhh
dmUgdGhlIGhhcmR3YXJlIGFuZCBJIHdvdWxkDQo+IGFwcHJlY2lhdGUgaWYgYW55b25lIGNvdWxk
IHRlc3QgaXQuDQo+IA0KPiBBbHNvLCBJIGRpZG4ndCBDQyB0byBzdGFibGUgaGVyZSBhcyBJIHNh
dyB0aGUgYXN5bmNfdXBkYXRlIGZ1bmN0aW9uIHdhcyBvbmx5DQo+IGFkZGVkIG9uIHY0LjIwLCBw
bGVhc2UgbGV0IG1lIGtub3cgaWYgSSBzaG91bGQgQ0MgdG8gc3RhYmxlLg0KPiANCj4gVGhhbmtz
IQ0KPiBIZWxlbg0KPiANCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jIHwgMyArLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMNCj4gaW5kZXggM2E2ZjU5NWYyOTVlLi5iYzAyODAwMjU0
YmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYw0KPiBAQCAtMzc2MCw4ICszNzYwLDcgQEAgc3RhdGljIHZvaWQgZG1fcGxh
bmVfYXRvbWljX2FzeW5jX3VwZGF0ZShzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwNCj4gICAJc3Ry
dWN0IGRybV9wbGFuZV9zdGF0ZSAqb2xkX3N0YXRlID0NCj4gICAJCWRybV9hdG9taWNfZ2V0X29s
ZF9wbGFuZV9zdGF0ZShuZXdfc3RhdGUtPnN0YXRlLCBwbGFuZSk7DQo+ICAgDQo+IC0JaWYgKHBs
YW5lLT5zdGF0ZS0+ZmIgIT0gbmV3X3N0YXRlLT5mYikNCj4gLQkJZHJtX2F0b21pY19zZXRfZmJf
Zm9yX3BsYW5lKHBsYW5lLT5zdGF0ZSwgbmV3X3N0YXRlLT5mYik7DQo+ICsJc3dhcChwbGFuZS0+
c3RhdGUtPmZiLCBuZXdfc3RhdGUtPmZiKTsNCj4gICANCj4gICAJcGxhbmUtPnN0YXRlLT5zcmNf
eCA9IG5ld19zdGF0ZS0+c3JjX3g7DQo+ICAgCXBsYW5lLT5zdGF0ZS0+c3JjX3kgPSBuZXdfc3Rh
dGUtPnNyY195Ow0KPiANCg0K
