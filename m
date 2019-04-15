Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C41C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8008E2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Z9/3h6jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDOJXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:23:00 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:11483
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726880AbfDOJW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px0t8rQwZjahTyhZR7nk0mSHCZjEwvr/P6VSL3qV8lw=;
 b=Z9/3h6jDKhxiSglJSVQXqKMmA7w235dN5SuXtVd4CTiync5MPrADIZuiSRMYT7HshySGRYHstzCAN9cMtNInrfFXfzUIRpJ9YHF4WaDKbPb8lh0lxSPlEFrAzv+/WSlX0qqbcHDoobelcamf/Hkvwpj8+nnk+uE3DAjpBz7hqf8=
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com (10.172.217.137) by
 AM4PR0802MB2289.eurprd08.prod.outlook.com (10.172.219.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Mon, 15 Apr 2019 09:22:54 +0000
Received: from AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::9976:7f2:5daa:7c48]) by AM4PR0802MB2211.eurprd08.prod.outlook.com
 ([fe80::9976:7f2:5daa:7c48%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 09:22:54 +0000
From:   Ben Gainey <Ben.Gainey@arm.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     nd <nd@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: Fix AUX record suppression
Thread-Topic: [PATCH] perf: Fix AUX record suppression
Thread-Index: AQHU5g+6aN4kfufsHEqs3keeIahjE6Y895cAgAAUOYCAAAGsAA==
Date:   Mon, 15 Apr 2019 09:22:54 +0000
Message-ID: <093d2270edcdbbe9798ad0bd2becc2fb2c448420.camel@arm.com>
References: <20190329091338.29999-1-alexander.shishkin@linux.intel.com>
         <7b073941dd6abfc81773f26573b103adf077bfed.camel@arm.com>
         <20190415091655.GH11158@hirez.programming.kicks-ass.net>
In-Reply-To: <20190415091655.GH11158@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Gainey@arm.com; 
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d985f3f-806d-4a42-39f8-08d6c183f102
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR0802MB2289;
x-ms-traffictypediagnostic: AM4PR0802MB2289:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM4PR0802MB22897594A35907F40715669C912B0@AM4PR0802MB2289.eurprd08.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(366004)(396003)(189003)(199004)(4326008)(6116002)(99286004)(2501003)(3846002)(76176011)(305945005)(6512007)(6436002)(5640700003)(316002)(11346002)(8676002)(476003)(81166006)(81156014)(1730700003)(2616005)(58126008)(7736002)(446003)(54906003)(486006)(186003)(478600001)(102836004)(25786009)(6506007)(8936002)(26005)(53936002)(6486002)(105586002)(71190400001)(71200400001)(72206003)(14454004)(4744005)(229853002)(2351001)(106356001)(5660300002)(6246003)(86362001)(97736004)(6916009)(68736007)(118296001)(36756003)(256004)(66066001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2289;H:AM4PR0802MB2211.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t+bnkgjavaDSRDqXiqpfPYmn8yEX0iLdOfW9Tu6LW6pSOAvCPldUFtf9nUM5ApUQ8yfz86t+fHqV1dV6OKF3nmkVMgZCViNhH2Yneuo0LaDWUklU9ndRsHOI44bSQZErcm2pO3n79Semyfpvza260zYUQKTF8Cl/EV9jumnfOjFpKaYRqQws1PJ8Hs9YRjvrLIHhSspcyhsZtGjjkz5VlTypsJzupc+5SjVLynqh0lm0Ykyfz71HcKOhe8v+AFsvaoWHzwcaor7VbS/8hDLO6thnE2+8t4ichu9i2YfQxJLmNrCb/pzaigHWHnumVIZ+V8qc8LKZAFkdEplu54tMLv6lCFLH7pGS0qX3Mmt6EahcqTj5fozHHGe9TtGnJpGtBI7lLQR0EkN2nGc9uWUjOPSNWtEfiuBXHd7MLIu/a8o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930E4A30F2F58E4A832369FF0E71E76D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d985f3f-806d-4a42-39f8-08d6c183f102
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 09:22:54.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIFBldGVyIDotKSANCg0KDQpPbiBNb24sIDIwMTktMDQtMTUgYXQgMTE6MTYgKzAyMDAs
IFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24sIEFwciAxNSwgMjAxOSBhdCAwODowNDoz
M0FNICswMDAwLCBCZW4gR2FpbmV5IHdyb3RlOg0KPiA+IEhpIEFsZXgNCj4gPiANCj4gPiBJIHdh
cyBqdXN0IHdvbmRlcmluZyBpZiB0aGlzIHdhcyBleHBlY3RlZCB0byBtYWtlIDUuMT8gKEkgY291
bGQgbm90DQo+ID4gc2VlDQo+ID4gaXQgaW4gUkM1KT8NCj4gDQo+IFlpa2VzLCBJIGZvcmdvdCBh
Ym91dCB0aGlzIGFnYWluLCBkaWRuJ3QgSSA/DQo+IA0KPiBBdCBsZWFzdCwgdGhleSBhcHBlYXIg
dG8gc3RpbGwgYXBwbHksIHNvIEkndmUgcXVldWVkIHRoZW0uIE5vdCBzdXJlDQo+IHRoZXknbGwg
c3RpbGwgbWFrZSB0aGlzIHJlbGVhc2UsIGJ1dCBhdCBsZWFzdCB0aGV5IHNob3VsZCBub3QgZ28N
Cj4gbWlzc2luZw0KPiBfYWdhaW5fLg0K
