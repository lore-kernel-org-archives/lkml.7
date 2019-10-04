Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9BC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264472084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 07:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R/naLCDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfJDH2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 03:28:55 -0400
Received: from mail-eopbgr720074.outbound.protection.outlook.com ([40.107.72.74]:64384
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727943AbfJDH2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 03:28:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLqGNFIb3UiOD28hf7jTGewTasGm2uIiwxKDK+cdCP1ZRcqCUlz6w3VIhcnWPzLXjX4h1Ngqg39QhagK5mUkPrj8K3tSjo3EC/TvnucwCfTFHj+NshaMehVupN0uBg5bC+P3vPhK6GLKDGWZD45DknWQNRvoxmutycA3Ebcg5BGr1HOjoK3iKQk3fc0yH0+DhVv5aTJHsGEHnG4b/oZte3X0iZaRStx35pLqbnnxoGdWTEl4yy3YxjEVGDGoWsY10mQXrmV6FlQSJNsQPB4gy60aTN4ioYMbOHSaDVN24hzvqkdvGEgINypzDaV/pbGfD4AZlnIseB9Qx/iDvn4CJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPb8z2q+qCfQMENOmFNIz+mGmeLshOTZHKlXfDQLKq0=;
 b=S5KdOlANby3Ac8c5g16H1E6E4KeSil5hU/PJDG4mNPjogpE5ME1LseQEh59YrQgSUJn2nsjH4QCZMKDYC/OBzpoQHDasuuxSmcr0+aA0nq/UFahDR9BjIcMX0PmyG5tEdRwYHZ47wTB8J/NSPYj0vccBAjdF7ysHq9aHEllhAMn+diIz2ZBLTWmK0AacQxRT01B/tJrj1IrApOWv5c+s5oKwbJ4XBvPKKyIdGskqop2sy8VzWVV4AyVQuQE7D7biKpR7hufgHqPb4/JRud8g0om1fUlvwPCaGHjwD7Qq2EAvBRbj4Rvj+hlZlTqyPV80sBC5N0dzzKe+a8egbsIVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPb8z2q+qCfQMENOmFNIz+mGmeLshOTZHKlXfDQLKq0=;
 b=R/naLCDVdAv+Uokd8stgFl/OH6hgFjwkE2I2mbTw+95mM2Bvm8bKHoEgHH8+Q8pbzm26gCQYIoU79FSjbKPcAosbEHQGlF89z0LxHUl6jgQDFpf3yDGJkVt+RPk3Ans7GfFpAoNgGW0awG49hcty+Xi7wZ2WQBlX4i+yzDIIXlM=
Received: from BN6PR12MB1699.namprd12.prod.outlook.com (10.175.97.148) by
 BN6PR12MB1524.namprd12.prod.outlook.com (10.172.18.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 07:28:52 +0000
Received: from BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::7d62:3e74:d0f0:be92]) by BN6PR12MB1699.namprd12.prod.outlook.com
 ([fe80::7d62:3e74:d0f0:be92%3]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 07:28:52 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/amdgpu: fix uninitialized variable
 pasid_mapping_needed
Thread-Topic: [PATCH][next] drm/amdgpu: fix uninitialized variable
 pasid_mapping_needed
Thread-Index: AQHVejTbS6N1wEhK502BqtiJqWh+AqdKFk0A
Date:   Fri, 4 Oct 2019 07:28:52 +0000
Message-ID: <55116b72-4e15-7efe-09a6-283a7090966a@amd.com>
References: <20191003215227.23540-1-colin.king@canonical.com>
In-Reply-To: <20191003215227.23540-1-colin.king@canonical.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::32) To BN6PR12MB1699.namprd12.prod.outlook.com
 (2603:10b6:404:ff::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31393bf4-f5b8-43c1-3db8-08d7489c8183
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN6PR12MB1524:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB152482F4016892B3699A8496839E0@BN6PR12MB1524.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(66446008)(81166006)(6486002)(6436002)(31686004)(316002)(14444005)(65956001)(6116002)(256004)(2501003)(229853002)(54906003)(2906002)(65806001)(4326008)(478600001)(110136005)(8936002)(36756003)(81156014)(7736002)(305945005)(8676002)(71200400001)(71190400001)(6512007)(25786009)(64756008)(14454004)(66476007)(66556008)(66946007)(5660300002)(46003)(186003)(31696002)(86362001)(446003)(76176011)(486006)(476003)(11346002)(2616005)(6246003)(99286004)(102836004)(66574012)(386003)(6506007)(52116002)(2201001)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1524;H:BN6PR12MB1699.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zo/RvpYHYU+8he7Yoyob9otTqVrInkt4ou8neb2w+HYPl4ljNEFDbKyu8Ei/Ef9+w67EqKkfC2QCF6Tzgh4uq8Lf8/15540Vv3Y7Y4/mf7BoiZCGsg0cJaS4SZ5f3KtLZThTBkF3QXmAXBFfxqYHZIMXuP7xYnzVSH6IXhbao9wpXGrGi+R7Nk+bN2mO2XdRx74gCPl/1SwcLCZr9yq5QsMA0nEwCN0E4mLIxlyfBQakTyksGl970RNOi+1mQWuXc0Sse8r2tWsLTmYm5izgCRLu66jpDIhHuT/tAoFCVi/CJXf8XGkpcTg5w8IEUxPBGqoR7Q2YZp4oCLMmHDk3HF19AqIJePjqkRnIS/kdxFyjY0lqE+HxWJfT1EW0cSGibJOvZy+T2PGt9Bo0S19vYlxiNsxxGJk+NqIPP83qffk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47E0B4F1D4595146B4BE94E6715EE50D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31393bf4-f5b8-43c1-3db8-08d7489c8183
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 07:28:52.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UyGyFvGGtEKB//hhQZw1P8f8GPyY3wlGg+rSgAPIN64fwfFnPt8ucNstkpH57uj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1524
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDMuMTAuMTkgdW0gMjM6NTIgc2NocmllYiBDb2xpbiBLaW5nOg0KPiBGcm9tOiBDb2xpbiBJ
YW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPg0KPiBUaGUgYm9vbGVhbiB2YXJp
YWJsZSBwYXNpZF9tYXBwaW5nX25lZWRlZCBpcyBub3QgaW5pdGlhbGl6ZWQgYW5kDQo+IHRoZXJl
IGFyZSBjb2RlIHBhdGhzIHRoYXQgZG8gbm90IGFzc2lnbiBpdCBhbnkgdmFsdWUgYmVmb3JlIGl0
IGlzDQo+IGlzIHJlYWQgbGF0ZXIuICBGaXggdGhpcyBieSBpbml0aWFsaXppbmcgcGFzaWRfbWFw
cGluZ19uZWVkZWQgdG8NCj4gZmFsc2UuDQo+DQo+IEFkZHJlc3Nlcy1Db3Zlcml0eTogKCJVbmlu
aXRpYWxpemVkIHNjYWxhciB2YXJpYWJsZSIpDQo+IEZpeGVzOiA2ODE3YmYyODNiMmIgKCJkcm0v
YW1kZ3B1OiBncmFiIHRoZSBpZCBtZ3IgbG9jayB3aGlsZSBhY2Nlc3NpbmcgcGFzc2lkX21hcHBp
bmciKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmlj
YWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiBpbmRl
eCBhMmM3OTdlMzRhMjkuLmJlMTBlNGI5YTk0ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4gQEAgLTEwNTUsNyArMTA1NSw3IEBAIGludCBhbWRncHVfdm1f
Zmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iLA0K
PiAgIAkJaWQtPm9hX3NpemUgIT0gam9iLT5vYV9zaXplKTsNCj4gICAJYm9vbCB2bV9mbHVzaF9u
ZWVkZWQgPSBqb2ItPnZtX25lZWRzX2ZsdXNoOw0KPiAgIAlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5j
ZSA9IE5VTEw7DQo+IC0JYm9vbCBwYXNpZF9tYXBwaW5nX25lZWRlZDsNCj4gKwlib29sIHBhc2lk
X21hcHBpbmdfbmVlZGVkID0gZmFsc2U7DQo+ICAgCXVuc2lnbmVkIHBhdGNoX29mZnNldCA9IDA7
DQo+ICAgCWludCByOw0KPiAgIA0KDQo=
