Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D75C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2B82075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dEAPkkUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfDBRlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:41:00 -0400
Received: from mail-eopbgr810079.outbound.protection.outlook.com ([40.107.81.79]:35808
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730392AbfDBRlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSJOYTVZY0/E6KplgHSO+EFLClDPIodGEt3YLyvvamU=;
 b=dEAPkkUweA6oaUQA0iUu8ocnme3DlXZAaGuuXV0zwqIQIpQ9Smsl8tmtqlibVICbtojZxN0v3NwbrmbQUKOpWu3BciStSbHXCC6Bw8vI6558xHRgT4o+9600MUxhXQe9QUNyXUBoimgdz2/a0BJqik+hZgmstnGbnDaJMIRxFMM=
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (20.179.92.82) by
 BYAPR12MB3622.namprd12.prod.outlook.com (20.178.54.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Tue, 2 Apr 2019 17:40:55 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::e073:d670:f97c:3eb8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::e073:d670:f97c:3eb8%7]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 17:40:55 +0000
From:   "Kuehling, Felix" <Felix.Kuehling@amd.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "dipankar@in.ibm.com" <dipankar@in.ibm.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC tip/core/rcu 3/4] drivers/gpu/drm/amd: Dynamically
 allocate kfd_processes_srcu
Thread-Topic: [PATCH RFC tip/core/rcu 3/4] drivers/gpu/drm/amd: Dynamically
 allocate kfd_processes_srcu
Thread-Index: AQHU6Wba3Cp5nlfiWUWKtaTZ2PfSlKYpI52A
Date:   Tue, 2 Apr 2019 17:40:54 +0000
Message-ID: <474488ce-75a1-06d9-768a-66008648c70e@amd.com>
References: <20190402142816.GA13084@linux.ibm.com>
 <20190402142933.14547-3-paulmck@linux.ibm.com>
In-Reply-To: <20190402142933.14547-3-paulmck@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-clientproxiedby: YTOPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::23) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:133::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70d58d13-f264-42ce-d0cc-08d6b7925b12
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:BYAPR12MB3622;
x-ms-traffictypediagnostic: BYAPR12MB3622:
x-microsoft-antispam-prvs: <BYAPR12MB3622FB91400D0250559AAF7492560@BYAPR12MB3622.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(6436002)(2906002)(7736002)(6512007)(54906003)(186003)(26005)(31686004)(81156014)(53546011)(65956001)(68736007)(8676002)(81166006)(66574012)(5660300002)(99936001)(305945005)(229853002)(476003)(65826007)(2501003)(71190400001)(71200400001)(6486002)(105586002)(99286004)(65806001)(66066001)(486006)(386003)(106356001)(6246003)(25786009)(72206003)(446003)(6506007)(478600001)(256004)(2616005)(64126003)(8936002)(76176011)(36756003)(7416002)(11346002)(4326008)(52116002)(110136005)(14444005)(5024004)(102836004)(97736004)(31696002)(3846002)(58126008)(86362001)(316002)(53936002)(6116002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3622;H:BYAPR12MB3176.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 16afYyktvK0IM6ppTzJ+QKuUxDSYIqwH67pejaBazE6Xt8SuX2DHbWMxFUhb3B2RwplSToBVo7XtvKXEWMysvzpHArSAvzB8L6pXk4x9HG2k3icFNLxUe/EWOwqlDEkYtttKIIIn9V41j3sfrKyWGQkqyIYBXSPZd4ARHn1x8Ezs4HZRc5EhXqevYhlNB0DhBoj9CrAMwqD4IJp13AEd5sy9P9/gFzV/8KkqbBDQH+yRVx/cYXPzXzSJGfaoKtFyj/1HyX6UxX1tvQN29xrRAib/oSG0nh8RkX5Vt/oExgF4ywO+LUeDUtAIFC1B+hRzk3Iz4PklWOmpe60MfIiYyff0BPXCpm/JAB3l33qqjjl9lqBZjeEF6RpUBLSb5jqQpaeg0b621Go91GkJJuPTiJbx039pmkHrKBNUXnHMABY=
Content-Type: multipart/mixed;
        boundary="_002_474488ce75a106d9768a66008648c70eamdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d58d13-f264-42ce-d0cc-08d6b7925b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 17:40:55.3561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_474488ce75a106d9768a66008648c70eamdcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2A40B5BBC3D0241BA91641A62AEE15C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gMjAxOS0wNC0wMiAxMDoyOSBhLm0uLCBQYXVsIEUuIE1jS2VubmV5IHdyb3RlOg0KPiBIYXZp
bmcgREVGSU5FX1NSQ1UoKSBvciBERUZJTkVfU1RBVElDX1NSQ1UoKSBpbiBhIGxvYWRhYmxlIG1v
ZHVsZQ0KPiByZXF1aXJlcyB0aGF0IHRoZSBzaXplIG9mIHRoZSByZXNlcnZlZCByZWdpb24gYmUg
aW5jcmVhc2VkLCB3aGljaCBpcw0KPiBub3Qgc29tZXRoaW5nIHdlIHJlYWxseSB3YW50IHRvIGJl
IGRvaW5nLiAgVGhpcyBjb21taXQgdGhlcmVmb3JlIHJlbW92ZXMNCj4gdGhlIERFRklORV9TVEFU
SUNfU1JDVSgpIGZyb20gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYyBp
bg0KPiBmYXZvciBvZiBkZWZpbmluZyBrZmRfcHJvY2Vzc2VzX3NyY3UgYXMgYSBzaW1wbGUgc3Jj
dV9zdHJ1Y3QsIGluaXRpYWxpemluZw0KPiBpdCBpbiBhbWRncHVfYW1ka2ZkX2luaXQoKSwgYW5k
IGNsZWFuaW5nIGl0IHVwIGluIGFtZGdwdV9hbWRrZmRfZmluaSgpLg0KPg0KPiBSZXBvcnRlZC1i
eToga2J1aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFBh
dWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAbGludXguaWJtLmNvbT4NCj4gVGVzdGVkLWJ5OiBrYnVp
bGQgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gQ2M6IE9kZWQgR2FiYmF5IDxvZGVkLmdh
YmJheUBnbWFpbC5jb20+DQo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bQ0KPiBDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIgPERhdmlkMS5aaG91QGFtZC5jb20+DQo+
IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+DQo+IENjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+DQo+IENjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+DQo+IENj
OiA8ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4gQ2M6IDxhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2FtZGtmZC5jIHwgNSArKysrKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9wcm9jZXNzLmMgICB8IDIgKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5jDQo+IGluZGV4IGZlMWQ3MzY4YzFlNi4uZWFkYjIwZGVlODY3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+IEBAIC0yOCw2
ICsyOCw4IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiAgICNpbmNsdWRlIDxs
aW51eC9kbWEtYnVmLmg+DQo+ICAgDQo+ICtleHRlcm4gc3RydWN0IHNyY3Vfc3RydWN0IGtmZF9w
cm9jZXNzZXNfc3JjdTsNCj4gKw0KPiAgIHN0YXRpYyBjb25zdCB1bnNpZ25lZCBpbnQgY29tcHV0
ZV92bWlkX2JpdG1hcCA9IDB4RkYwMDsNCj4gICANCj4gICAvKiBUb3RhbCBtZW1vcnkgc2l6ZSBp
biBzeXN0ZW0gbWVtb3J5IGFuZCBhbGwgR1BVIFZSQU0uIFVzZWQgdG8NCj4gQEAgLTQwLDYgKzQy
LDggQEAgaW50IGFtZGdwdV9hbWRrZmRfaW5pdCh2b2lkKQ0KPiAgIAlzdHJ1Y3Qgc3lzaW5mbyBz
aTsNCj4gICAJaW50IHJldDsNCj4gICANCj4gKwlyZXQgPSBpbml0X3NyY3Vfc3RydWN0KCZrZmRf
cHJvY2Vzc2VzX3NyY3UpOw0KPiArCVdBUk5fT04ocmV0KTsNCg0Ka2ZkX3Byb2Nlc3Nlc19zcmN1
IG9ubHkgZXhpc3RzIGlmIGtmZF9wcm9jZXNzLmMgaXMgY29tcGlsZWQgaW4uIFRoYXQgDQpkZXBl
bmRzIG9uIENPTkZJR19IU0FfQU1ELiBTbyB0aGlzIHNob3VsZCBhdCBsZWFzdCBtb3ZlIGludG8g
I2lmZGVmIGEgDQpmZXcgbGluZXMgYmVsb3cuDQoNCkhvd2V2ZXIsIGl0IHdvdWxkIGJlIGNsZWFu
ZXIgdG8gbW92ZSB0aGlzIGluaXRpYWxpemF0aW9uIGludG8ga2ZkX2luaXQgDQppbiBrZmRfbW9k
dWxlLmMsIG9yIGJldHRlciB5ZXQsIGludG8ga2ZkX3Byb2Nlc3NfY3JlYXRlX3dxIGluIA0Ka2Zk
X3Byb2Nlc3MuYy4gVGhlbiBrZmRfcHJvY2Vzc19jcmVhdGVfd3Egc2hvdWxkIGJlIHJlbmFtZWQg
dG8gc29tZXRoaW5nIA0KbW9yZSBnZW5lcmljLCBzdWNoIGFzIGtmZF9wcm9jZXNzX2luaXQuDQoN
Cg0KPiAgIAlzaV9tZW1pbmZvKCZzaSk7DQo+ICAgCWFtZGdwdV9hbWRrZmRfdG90YWxfbWVtX3Np
emUgPSBzaS50b3RhbHJhbSAtIHNpLnRvdGFsaGlnaDsNCj4gICAJYW1kZ3B1X2FtZGtmZF90b3Rh
bF9tZW1fc2l6ZSAqPSBzaS5tZW1fdW5pdDsNCj4gQEAgLTU3LDYgKzYxLDcgQEAgaW50IGFtZGdw
dV9hbWRrZmRfaW5pdCh2b2lkKQ0KPiAgIHZvaWQgYW1kZ3B1X2FtZGtmZF9maW5pKHZvaWQpDQo+
ICAgew0KPiAgIAlrZ2Qya2ZkX2V4aXQoKTsNCj4gKwljbGVhbnVwX3NyY3Vfc3RydWN0KCZrZmRf
cHJvY2Vzc2VzX3NyY3UpOw0KDQpTaW1pbGFybHksIHRoaXMgd291bGQgYmUgY2xlYW5lciBpbiBr
ZmRfZXhpdCBpbiBrZmRfbW9kdWxlLmMgb3IgDQprZmRfcHJvY2Vzc19kZXN0cm95X3dxIGluIGtm
ZF9wcm9jZXNzLmMsIHdpdGggdGhhdCBmdW5jdGlvbiBzaW1pbGFybHkgDQpyZW5hbWVkIHRvIGtm
ZF9wcm9jZXNzX2ZpbmkuDQoNCkknbSBhdHRhY2hpbmcgYSByZXZpc2VkIHBhdGNoLiBJdCdzIG9u
bHkgY29tcGlsZSB0ZXN0ZWQuDQoNClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KDQo+ICAgfQ0KPiAg
IA0KPiAgIHZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZpY2VfcHJvYmUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiBp
bmRleCA0YmRhZTc4YmFiOGUuLjk4YjY5NDA2OGI4YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jDQo+IEBAIC00Nyw3ICs0Nyw3IEBAIHN0cnVjdCBtbV9z
dHJ1Y3Q7DQo+ICAgREVGSU5FX0hBU0hUQUJMRShrZmRfcHJvY2Vzc2VzX3RhYmxlLCBLRkRfUFJP
Q0VTU19UQUJMRV9TSVpFKTsNCj4gICBzdGF0aWMgREVGSU5FX01VVEVYKGtmZF9wcm9jZXNzZXNf
bXV0ZXgpOw0KPiAgIA0KPiAtREVGSU5FX1NSQ1Uoa2ZkX3Byb2Nlc3Nlc19zcmN1KTsNCj4gK3N0
cnVjdCBzcmN1X3N0cnVjdCBrZmRfcHJvY2Vzc2VzX3NyY3U7DQo+ICAgDQo+ICAgLyogRm9yIHBy
b2Nlc3MgdGVybWluYXRpb24gaGFuZGxpbmcgKi8NCj4gICBzdGF0aWMgc3RydWN0IHdvcmtxdWV1
ZV9zdHJ1Y3QgKmtmZF9wcm9jZXNzX3dxOw0K

--_002_474488ce75a106d9768a66008648c70eamdcom_
Content-Type: text/x-patch;
	name="0001-drivers-gpu-drm-amd-Dynamically-allocate-kfd_process.patch"
Content-Description:
 0001-drivers-gpu-drm-amd-Dynamically-allocate-kfd_process.patch
Content-Disposition: attachment;
	filename="0001-drivers-gpu-drm-amd-Dynamically-allocate-kfd_process.patch";
	size=4696; creation-date="Tue, 02 Apr 2019 17:40:54 GMT";
	modification-date="Tue, 02 Apr 2019 17:40:54 GMT"
Content-ID: <D982DF3D6BEB3D459998EB197101F43E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA1ODU3YTlhYTYzOTU3YTU3NTVmZjgxYWU1YzQ2NTMzYmNhNDA4YzEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIlBhdWwgRS4gTWNLZW5uZXkiIDxwYXVsbWNrQGxpbnV4Lmli
bS5jb20+DQpEYXRlOiBUdWUsIDIgQXByIDIwMTkgMDc6Mjk6MzIgLTA3MDANClN1YmplY3Q6IFtQ
QVRDSCAxLzFdIGRyaXZlcnMvZ3B1L2RybS9hbWQ6IER5bmFtaWNhbGx5IGFsbG9jYXRlDQoga2Zk
X3Byb2Nlc3Nlc19zcmN1IHYyDQpNSU1FLVZlcnNpb246IDEuMA0KQ29udGVudC1UeXBlOiB0ZXh0
L3BsYWluOyBjaGFyc2V0PVVURi04DQpDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0DQoN
CkhhdmluZyBERUZJTkVfU1JDVSgpIG9yIERFRklORV9TVEFUSUNfU1JDVSgpIGluIGEgbG9hZGFi
bGUgbW9kdWxlDQpyZXF1aXJlcyB0aGF0IHRoZSBzaXplIG9mIHRoZSByZXNlcnZlZCByZWdpb24g
YmUgaW5jcmVhc2VkLCB3aGljaCBpcw0Kbm90IHNvbWV0aGluZyB3ZSByZWFsbHkgd2FudCB0byBi
ZSBkb2luZy4gIFRoaXMgY29tbWl0IHRoZXJlZm9yZSByZW1vdmVzDQp0aGUgREVGSU5FX1NUQVRJ
Q19TUkNVKCkgZnJvbSBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIGlu
DQpmYXZvciBvZiBkZWZpbmluZyBrZmRfcHJvY2Vzc2VzX3NyY3UgYXMgYSBzaW1wbGUgc3JjdV9z
dHJ1Y3QsIGluaXRpYWxpemluZw0KaXQgaW4ga2ZkX3Byb2Nlc3NfaW5pdCgpLCBhbmQgY2xlYW5p
bmcgaXQgdXAgaW4ga2ZkX3Byb2Nlc3NfZmluaSgpLg0KDQp2MiAoRmVsaXggS3VlaGxpbmcpOiBN
b3ZlIHNyY3UgaW5pdCBhbmQgY2xlYW51cCBpbnRvIGtmZF9wcm9jZXNzLmMNCg0KUmVwb3J0ZWQt
Ynk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogUGF1
bCBFLiBNY0tlbm5leSA8cGF1bG1ja0BsaW51eC5pYm0uY29tPg0KU2lnbmVkLW9mZi1ieTogRmVs
aXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQpUZXN0ZWQtYnkgKHYxKToga2J1
aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQpDYzogT2RlZCBHYWJiYXkgPG9kZWQuZ2Fi
YmF5QGdtYWlsLmNvbT4NCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+DQpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+DQpD
YzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIgPERhdmlkMS5aaG91QGFtZC5jb20+DQpDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPg0KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4NCkNjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+DQpDYzogPGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmc+DQpDYzogPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21vZHVsZS5jICB8ICA4ICsr
KystLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICB8ICA0ICsr
LS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jIHwgMTkgKysrKysr
KysrKysrLS0tLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
bW9kdWxlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbW9kdWxlLmMNCmluZGV4
IDkzMjAwN2UuLmU4ZTJjMTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbW9kdWxlLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tb2R1
bGUuYw0KQEAgLTUyLDE1ICs1MiwxNSBAQCBzdGF0aWMgaW50IGtmZF9pbml0KHZvaWQpDQogCWlm
IChlcnIgPCAwKQ0KIAkJZ290byBlcnJfdG9wb2xvZ3k7DQogDQotCWVyciA9IGtmZF9wcm9jZXNz
X2NyZWF0ZV93cSgpOw0KKwllcnIgPSBrZmRfcHJvY2Vzc19pbml0KCk7DQogCWlmIChlcnIgPCAw
KQ0KLQkJZ290byBlcnJfY3JlYXRlX3dxOw0KKwkJZ290byBlcnJfcHJvY2VzczsNCiANCiAJa2Zk
X2RlYnVnZnNfaW5pdCgpOw0KIA0KIAlyZXR1cm4gMDsNCiANCi1lcnJfY3JlYXRlX3dxOg0KK2Vy
cl9wcm9jZXNzOg0KIAlrZmRfdG9wb2xvZ3lfc2h1dGRvd24oKTsNCiBlcnJfdG9wb2xvZ3k6DQog
CWtmZF9jaGFyZGV2X2V4aXQoKTsNCkBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyBpbnQga2ZkX2lu
aXQodm9pZCkNCiBzdGF0aWMgdm9pZCBrZmRfZXhpdCh2b2lkKQ0KIHsNCiAJa2ZkX2RlYnVnZnNf
ZmluaSgpOw0KLQlrZmRfcHJvY2Vzc19kZXN0cm95X3dxKCk7DQorCWtmZF9wcm9jZXNzX2Zpbmko
KTsNCiAJa2ZkX3RvcG9sb2d5X3NodXRkb3duKCk7DQogCWtmZF9jaGFyZGV2X2V4aXQoKTsNCiB9
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCmluZGV4IDllMDIzMDkuLjlkZDE4
N2MgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oDQpAQCAtNzA4LDggKzcw
OCw4IEBAIHN0cnVjdCBhbWRrZmRfaW9jdGxfZGVzYyB7DQogfTsNCiBib29sIGtmZF9kZXZfaXNf
bGFyZ2VfYmFyKHN0cnVjdCBrZmRfZGV2ICpkZXYpOw0KIA0KLWludCBrZmRfcHJvY2Vzc19jcmVh
dGVfd3Eodm9pZCk7DQotdm9pZCBrZmRfcHJvY2Vzc19kZXN0cm95X3dxKHZvaWQpOw0KK2ludCBr
ZmRfcHJvY2Vzc19pbml0KHZvaWQpOw0KK3ZvaWQga2ZkX3Byb2Nlc3NfZmluaSh2b2lkKTsNCiBz
dHJ1Y3Qga2ZkX3Byb2Nlc3MgKmtmZF9jcmVhdGVfcHJvY2VzcyhzdHJ1Y3QgZmlsZSAqZmlsZXAp
Ow0KIHN0cnVjdCBrZmRfcHJvY2VzcyAqa2ZkX2dldF9wcm9jZXNzKGNvbnN0IHN0cnVjdCB0YXNr
X3N0cnVjdCAqKTsNCiBzdHJ1Y3Qga2ZkX3Byb2Nlc3MgKmtmZF9sb29rdXBfcHJvY2Vzc19ieV9w
YXNpZCh1bnNpZ25lZCBpbnQgcGFzaWQpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jDQppbmRleCA0YmRhZTc4Li5mODEwOTExIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYw0KQEAgLTQ3LDcgKzQ3LDcgQEAgc3RydWN0IG1tX3N0cnVj
dDsNCiBERUZJTkVfSEFTSFRBQkxFKGtmZF9wcm9jZXNzZXNfdGFibGUsIEtGRF9QUk9DRVNTX1RB
QkxFX1NJWkUpOw0KIHN0YXRpYyBERUZJTkVfTVVURVgoa2ZkX3Byb2Nlc3Nlc19tdXRleCk7DQog
DQotREVGSU5FX1NSQ1Uoa2ZkX3Byb2Nlc3Nlc19zcmN1KTsNCitzdHJ1Y3Qgc3JjdV9zdHJ1Y3Qg
a2ZkX3Byb2Nlc3Nlc19zcmN1Ow0KIA0KIC8qIEZvciBwcm9jZXNzIHRlcm1pbmF0aW9uIGhhbmRs
aW5nICovDQogc3RhdGljIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICprZmRfcHJvY2Vzc193cTsN
CkBAIC02OSwyMiArNjksMjUgQEAgc3RhdGljIHZvaWQgZXZpY3RfcHJvY2Vzc193b3JrZXIoc3Ry
dWN0IHdvcmtfc3RydWN0ICp3b3JrKTsNCiBzdGF0aWMgdm9pZCByZXN0b3JlX3Byb2Nlc3Nfd29y
a2VyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yayk7DQogDQogDQotaW50IGtmZF9wcm9jZXNzX2Ny
ZWF0ZV93cSh2b2lkKQ0KK2ludCBrZmRfcHJvY2Vzc19pbml0KHZvaWQpDQogew0KKwlpbnQgcmV0
Ow0KKw0KIAlpZiAoIWtmZF9wcm9jZXNzX3dxKQ0KIAkJa2ZkX3Byb2Nlc3Nfd3EgPSBhbGxvY193
b3JrcXVldWUoImtmZF9wcm9jZXNzX3dxIiwgMCwgMCk7DQogCWlmICgha2ZkX3Jlc3RvcmVfd3Ep
DQogCQlrZmRfcmVzdG9yZV93cSA9IGFsbG9jX29yZGVyZWRfd29ya3F1ZXVlKCJrZmRfcmVzdG9y
ZV93cSIsIDApOw0KIA0KLQlpZiAoIWtmZF9wcm9jZXNzX3dxIHx8ICFrZmRfcmVzdG9yZV93cSkg
ew0KLQkJa2ZkX3Byb2Nlc3NfZGVzdHJveV93cSgpOw0KKwlpZiAoIWtmZF9wcm9jZXNzX3dxIHx8
ICFrZmRfcmVzdG9yZV93cSkNCiAJCXJldHVybiAtRU5PTUVNOw0KLQl9DQogDQotCXJldHVybiAw
Ow0KKwlyZXQgPSBpbml0X3NyY3Vfc3RydWN0KCZrZmRfcHJvY2Vzc2VzX3NyY3UpOw0KKwlXQVJO
X09OKHJldCk7DQorDQorCXJldHVybiByZXQ7DQogfQ0KIA0KLXZvaWQga2ZkX3Byb2Nlc3NfZGVz
dHJveV93cSh2b2lkKQ0KK3ZvaWQga2ZkX3Byb2Nlc3NfZmluaSh2b2lkKQ0KIHsNCiAJaWYgKGtm
ZF9wcm9jZXNzX3dxKSB7DQogCQlkZXN0cm95X3dvcmtxdWV1ZShrZmRfcHJvY2Vzc193cSk7DQpA
QCAtOTQsNiArOTcsOCBAQCB2b2lkIGtmZF9wcm9jZXNzX2Rlc3Ryb3lfd3Eodm9pZCkNCiAJCWRl
c3Ryb3lfd29ya3F1ZXVlKGtmZF9yZXN0b3JlX3dxKTsNCiAJCWtmZF9yZXN0b3JlX3dxID0gTlVM
TDsNCiAJfQ0KKw0KKwljbGVhbnVwX3NyY3Vfc3RydWN0KCZrZmRfcHJvY2Vzc2VzX3NyY3UpOw0K
IH0NCiANCiBzdGF0aWMgdm9pZCBrZmRfcHJvY2Vzc19mcmVlX2dwdXZtKHN0cnVjdCBrZ2RfbWVt
ICptZW0sDQotLSANCjIuNy40DQoNCg==

--_002_474488ce75a106d9768a66008648c70eamdcom_--
