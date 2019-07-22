Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997CC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0FB2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jwov1XK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfGVSO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:14:56 -0400
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:26785
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728594AbfGVSO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:14:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc4T/hL0BUq08Czwa8nBFeBD7Tb+++Tsj9fgiflUB9gJ4+iBYWuf5loK7zIXoOOYZlbTVfg0Dw26y0JeFOIFwPzvZt9MgdiZFGk7HCJm4rF6bMIiq6UgIQP8sxUdxZZ3ITWzwJi6cc/2ZNiw6MT0+9k1pICRGiwUpCnzDmvpcnu4WdWOdpIQ8/6S91bilWG9sx5yGgIMu2G8ylTOhTQG/lQxRk7qROQipZBMcSDpnBmwXKTQcVjvHyfBpScoJe9J17ALoKSRJcaVbgQ73Zn2Zh2iddQETeQFBRlfrUvkT6OrqHEWa253PxgtYRcqHUK0CLwHBy6ozu6FqIizKZewhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0mDNBEpeVnIsMDng/OVf/VYn1RgeSslxVe224QmWco=;
 b=AvKOWq2W7bRYogZq/rLfsFQI2CIQh/kbNyF2Fe6OgvEncH9y2drITfEYvg8NVO8EG2wVMi1w+ogfD1GTW6WXdMW8yXjsZV+jfDvdRHhEb0HJsTTIQJ5QML6d3ilwYIEdjU4YCJzXsMrou3eJdi9RFJOJmx7X1EfitrjB42w/zCfeh1e08o9Ta4724KlFfFnM++M7ibTm4Led3qYPBlxf3Rk0FScBlb44YmJX21GqY1MhG5s5H7DO/3TBWjmIFOhk6ryzK5QXBapffznoqvJOpjDdOAC+8a7NH6HLoRvGhO88omg2jPKE3NtKq+ceqyUm4QBVZkrjobO76CPVzVuIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0mDNBEpeVnIsMDng/OVf/VYn1RgeSslxVe224QmWco=;
 b=jwov1XK0rlP0bcMkU1JMBsE24YM7at3L3QyaBwDrMHbLC86e3Q747DcnKmNWiLgk9/rxiXCbZgS7GkswIDmO/4F9kj/QuAvWXvIXCemhA4qJUntrtiq0+TPSqmPI94dN5eQMAbHKPaifV8Qfw0mnkUYQN4WioGvfb+pTEENqQgg=
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3722.namprd12.prod.outlook.com (10.255.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Mon, 22 Jul 2019 18:14:51 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::2532:fffd:e1e1:3bdc]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::2532:fffd:e1e1:3bdc%6]) with mapi id 15.20.2094.017; Mon, 22 Jul 2019
 18:14:51 +0000
From:   "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Cox, Philip" <Philip.Cox@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through
 warning
Thread-Topic: [PATCH] drm/amdkfd/kfd_mqd_manager_v10: Avoid fall-through
 warning
Thread-Index: AQHVQLWGlDpRDeYIX0yhL0Q6QMW9pabW8UeA
Date:   Mon, 22 Jul 2019 18:14:50 +0000
Message-ID: <7769041f-f321-1e99-a94f-52bdb7c016b5@amd.com>
References: <20190722174716.GA17037@embeddedor>
In-Reply-To: <20190722174716.GA17037@embeddedor>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
x-clientproxiedby: YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::19) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4eabd74c-b785-4186-5cb3-08d70ed07ce4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3722;
x-ms-traffictypediagnostic: DM6PR12MB3722:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB372238051237B195C21AD5DCF4C40@DM6PR12MB3722.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(6306002)(6512007)(66446008)(64756008)(66476007)(6436002)(66556008)(102836004)(66946007)(31686004)(6486002)(2906002)(5660300002)(186003)(6506007)(25786009)(386003)(99286004)(966005)(478600001)(229853002)(64126003)(14454004)(6246003)(4326008)(76176011)(52116002)(486006)(53936002)(14444005)(8936002)(6116002)(305945005)(31696002)(256004)(65826007)(36756003)(26005)(8676002)(66066001)(316002)(71190400001)(53546011)(71200400001)(3846002)(476003)(446003)(81166006)(81156014)(7736002)(58126008)(2616005)(86362001)(68736007)(54906003)(65956001)(65806001)(11346002)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3722;H:DM6PR12MB3241.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NSx+M8Kv2dCmZe0toQobKforEy1sR+sHKWwjV52oGCSPOlrifZ5g/F3eaYn//PK3LrdC7SBiswEiG1DoiF9McMYWbXV0ocXEEZENUfvKfl22nfJIIU+7JDvo5sn+uwkCq/cqFBanrPMf/iyJRtJZoFW5I5MWf9Jw9lXihbHBpKrnjlmbthyBUTp4KJHak4fZ4wgtMCTCoKWHgE/IwtQES4Ne8c61MKAl/oOLIhkxGI5tRGzJbL2CEa6vRRWfIJqRrJtQDPaezdrK5O166z/wyxQrXSsP39F3bvOhNaqSiNcPxkZsdcpFHw7kTjmEBxO76FQAgXguliPcYMTetBIvCWZR8l8V9xxbJ/jzCpG89Z3kzYIiIObYvpKP1MdrHctrOESMcgCnu6g2kSFHPYHahGs+F49YdMjPD7SaT6aWU3U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EA55DF28A76A84C916C0474DFDE086A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eabd74c-b785-4186-5cb3-08d70ed07ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 18:14:50.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShaoyunL@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6wqAgc2hhb3l1bmwgPHNoYW95dW4ubGl1QGFtZC5jb20+DQoNCk9uIDIwMTkt
MDctMjIgMTo0NyBwLm0uLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPiBJbiBwcmVwYXJh
dGlvbiB0byBlbmFibGluZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLCB0aGlzIHBhdGNoIHNpbGVu
Y2VzDQo+IHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCj4NCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvLi4vYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYzogSW4gZnVuY3Rpb24g4oCYbXFk
X21hbmFnZXJfaW5pdF92MTDigJk6DQo+IC4vaW5jbHVkZS9saW51eC9keW5hbWljX2RlYnVnLmg6
MTIyOjUyOiB3YXJuaW5nOiB0aGlzIHN0YXRlbWVudCBtYXkgZmFsbCB0aHJvdWdoIFstV2ltcGxp
Y2l0LWZhbGx0aHJvdWdoPV0NCj4gICAjZGVmaW5lIF9fZHluYW1pY19mdW5jX2NhbGwoaWQsIGZt
dCwgZnVuYywgLi4uKSBkbyB7IFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBeDQo+IC4vaW5jbHVkZS9saW51eC9keW5hbWljX2RlYnVnLmg6
MTQzOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX2R5bmFtaWNfZnVuY19jYWxs
4oCZDQo+ICAgIF9fZHluYW1pY19mdW5jX2NhbGwoX19VTklRVUVfSUQoZGRlYnVnKSwgZm10LCBm
dW5jLCAjI19fVkFfQVJHU19fKQ0KPiAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQo+IC4vaW5jbHVk
ZS9saW51eC9keW5hbWljX2RlYnVnLmg6MTUzOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNy
byDigJhfZHluYW1pY19mdW5jX2NhbGzigJkNCj4gICAgX2R5bmFtaWNfZnVuY19jYWxsKGZtdCwg
X19keW5hbWljX3ByX2RlYnVnLCAgXA0KPiAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gLi9pbmNs
dWRlL2xpbnV4L3ByaW50ay5oOjMzNjoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCY
ZHluYW1pY19wcl9kZWJ1Z+KAmQ0KPiAgICBkeW5hbWljX3ByX2RlYnVnKGZtdCwgIyNfX1ZBX0FS
R1NfXykNCj4gICAgXn5+fn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jOjQzMjozOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYcHJfZGVidWfigJkNCj4gICAgIHByX2RlYnVnKCIlc0AlaVxuIiwgX19m
dW5jX18sIF9fTElORV9fKTsNCj4gICAgIF5+fn5+fn5+DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEwLmM6NDMzOjI6IG5vdGU6IGhlcmUN
Cj4gICAgY2FzZSBLRkRfTVFEX1RZUEVfQ09NUFVURToNCj4gICAgXn5+fg0KPg0KPiBieSByZW1v
dmluZyB0aGUgY2FsbCB0byBwcl9kZWJ1ZygpIGluIEtGRF9NUURfVFlQRV9DUDoNCj4NCj4gIlRo
ZSBtcWQgaW5pdCBmb3IgQ1AgYW5kIENPTVBVVEUgd2lsbCBoYXZlIHRoZSBzYW1lICByb3V0aW5l
LiIgWzFdDQo+DQo+IFRoaXMgYnVnIHdhcyBmb3VuZCB0aGFua3MgdG8gdGhlIG9uZ29pbmcgZWZm
b3J0cyB0byBlbmFibGUNCj4gLVdpbXBsaWNpdC1mYWxsdGhyb3VnaC4NCj4NCj4gWzFdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYzczNWExY2MtYTU0NS01MGZiLTQ0ZTctYzBhZDkzZWU4
ZWU3QGFtZC5jb20vDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1
c3Rhdm9AZW1iZWRkZWRvci5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAuYyB8IDEgLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbXFkX21hbmFnZXJfdjEwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFk
X21hbmFnZXJfdjEwLmMNCj4gaW5kZXggNGY4YTZmZmM1Nzc1Li45Y2QzZWIyZDkwYmQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTAu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEw
LmMNCj4gQEAgLTQyOSw3ICs0MjksNiBAQCBzdHJ1Y3QgbXFkX21hbmFnZXIgKm1xZF9tYW5hZ2Vy
X2luaXRfdjEwKGVudW0gS0ZEX01RRF9UWVBFIHR5cGUsDQo+ICAgDQo+ICAgCXN3aXRjaCAodHlw
ZSkgew0KPiAgIAljYXNlIEtGRF9NUURfVFlQRV9DUDoNCj4gLQkJcHJfZGVidWcoIiVzQCVpXG4i
LCBfX2Z1bmNfXywgX19MSU5FX18pOw0KPiAgIAljYXNlIEtGRF9NUURfVFlQRV9DT01QVVRFOg0K
PiAgIAkJcHJfZGVidWcoIiVzQCVpXG4iLCBfX2Z1bmNfXywgX19MSU5FX18pOw0KPiAgIAkJbXFk
LT5hbGxvY2F0ZV9tcWQgPSBhbGxvY2F0ZV9tcWQ7DQo=
