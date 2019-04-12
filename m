Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421E72084E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 23:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="f/xIwml0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDLXyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 19:54:03 -0400
Received: from mail-eopbgr750130.outbound.protection.outlook.com ([40.107.75.130]:4227
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbfDLXyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 19:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdKS812kpbmgxGbyKmIIZN02TKavNse6IS7EBIdfx7A=;
 b=f/xIwml0e2srhGOntgATN4W76O/0TrUsGiIOcKRA2cgCQ8MbNoEwYxwSFE8Ym454kfHuxceOcucJ37R1KqTQiljFuaJysblWIGrVONDBM7aJgAdojsV4dGotiIl1Sl/JWfVm5zRkQayWXABOOUyEZxq+ZEbF+Ofxm1Y+95/sLbc=
Received: from MW2PR2101MB0937.namprd21.prod.outlook.com (52.132.146.10) by
 MW2PR2101MB1036.namprd21.prod.outlook.com (52.132.149.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.0; Fri, 12 Apr 2019 23:53:57 +0000
Received: from MW2PR2101MB0937.namprd21.prod.outlook.com
 ([fe80::14a3:1607:bd48:515b]) by MW2PR2101MB0937.namprd21.prod.outlook.com
 ([fe80::14a3:1607:bd48:515b%3]) with mapi id 15.20.1813.001; Fri, 12 Apr 2019
 23:53:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "riel@surriel.com" <riel@surriel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] smp: Do not warn if smp_call_function_single() is doing a
 self call.
Thread-Topic: [PATCH] smp: Do not warn if smp_call_function_single() is doing
 a self call.
Thread-Index: AQHU8Yr+1yQwdQoblk+oD0M5U9uMbQ==
Date:   Fri, 12 Apr 2019 23:53:57 +0000
Message-ID: <20190412235341.29379-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:301:60::19) To MW2PR2101MB0937.namprd21.prod.outlook.com
 (2603:10b6:302:4::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-originating-ip: [2001:4898:80e8:9:4b4:b561:d6cf:51ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c066d2fa-d07f-4eb7-34f3-08d6bfa2206b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1036941E84D47809EF359DC9BF280@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(199004)(189003)(54906003)(14454004)(316002)(102836004)(68736007)(6486002)(4744005)(22452003)(6512007)(7416002)(107886003)(1511001)(2616005)(5660300002)(486006)(6506007)(186003)(97736004)(4326008)(110136005)(476003)(386003)(53936002)(6636002)(6436002)(1076003)(2201001)(6116002)(478600001)(86362001)(81156014)(46003)(106356001)(25786009)(2906002)(105586002)(81166006)(36756003)(99286004)(10290500003)(14444005)(71200400001)(71190400001)(86612001)(305945005)(8676002)(52116002)(2501003)(50226002)(8936002)(10090500001)(7736002)(256004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB0937.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D8UULeIvw8tScFMlAIr1rMj88ErCaCb3iu54hm5zWaEzwpAUprf2yUwU3GsEmd7GehksX5v/IoCl+wV4EBAzD/1oX3O0utQKSWMOxWRdqiymeSUARzFsQWr8uHSgb+5tsMhLPHWzTrTFjuq9Fm6VUStkdhCZMb5NuJjMMaAox4kNKcifEUw/A6vVx7seGKtdBVj4hDirvG+ziED7SCTqBinddi7aR9Dmp/Zoeqmx4a7U99fv7wid1/o29bsTa2dHi2jWdClWkwrUpbZk597jSar+pLQ6AUGkZQhiqmt4uR99sbx7Z2rkf71wppA8JoXsjAYaKpVcbcVGahMvz6sADOM3iSH95/G84DQdWKaJU3PKaLu78qiNrzSSLZjKT7N90qEkPXIdyEg7yf0+dvxrpeAyGSWVkF0vyTC0GtxGT4w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c066d2fa-d07f-4eb7-34f3-08d6bfa2206b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 23:53:57.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgc21wX2NhbGxfZnVuY3Rpb25fc2luZ2xlKCkgaXMgY2FsbGluZyB0aGUgZnVuY3Rpb24gZm9y
IGl0c2VsZiwgaXQncyBzYWZlDQp0byBydW4gd2l0aCBpcnFzX2Rpc2FibGVkKCkgPT0gdHJ1ZS4N
Cg0KSSBoaXQgdGhlIHdhcm5pbmcgYmVjYXVzZSBJJ20gaW4gdGhlIGJlbG93IHBhdGggaW4gdGhl
IC5zdXNwZW5kIGNhbGxiYWNrIG9mDQphICJzeXNjb3JlX29wcyIgdG8gc3VwcG9ydCBoaWJlcm5h
dGlvbiBmb3IgYSBWTSBydW5uaW5nIG9uIEh5cGVyLVY6DQoNCiAgaHZfc3luaWNfY2xlYW51cCgp
IC0+DQogICAgY2xvY2tldmVudHNfdW5iaW5kX2RldmljZSgpIC0+DQogICAgICBjbG9ja2V2ZW50
c191bmJpbmQoKSAtPg0KICAgICAgICBzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUoKS4NCg0KV2hl
biB0aGUgLnN1c3BlbmQgY2FsbGJhY2sgcnVucywgb25seSBDUFUwIGlzIG9ubGluZSBhbmQgaXJx
c19kaXNhYmxlZCgpIGlzDQp0cnVlLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1
aUBtaWNyb3NvZnQuY29tPg0KLS0tDQoga2VybmVsL3NtcC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVs
L3NtcC5jIGIva2VybmVsL3NtcC5jDQppbmRleCBmNGNmMWIwYmIzYjguLjRmZGY2YTM3OGRlZiAx
MDA2NDQNCi0tLSBhL2tlcm5lbC9zbXAuYw0KKysrIGIva2VybmVsL3NtcC5jDQpAQCAtMjg4LDcg
KzI4OCw3IEBAIGludCBzbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGUoaW50IGNwdSwgc21wX2NhbGxf
ZnVuY190IGZ1bmMsIHZvaWQgKmluZm8sDQogCSAqIGNhbid0IGhhcHBlbi4NCiAJICovDQogCVdB
Uk5fT05fT05DRShjcHVfb25saW5lKHRoaXNfY3B1KSAmJiBpcnFzX2Rpc2FibGVkKCkNCi0JCSAg
ICAgJiYgIW9vcHNfaW5fcHJvZ3Jlc3MpOw0KKwkJICAgICAmJiBjcHUgIT0gc21wX3Byb2Nlc3Nv
cl9pZCgpICYmICFvb3BzX2luX3Byb2dyZXNzKTsNCiANCiAJY3NkID0gJmNzZF9zdGFjazsNCiAJ
aWYgKCF3YWl0KSB7DQotLSANCjIuMTkuMQ0KDQo=
