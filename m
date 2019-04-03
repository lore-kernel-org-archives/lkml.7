Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8663C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4966206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A3TWBHBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfDCPYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:24:48 -0400
Received: from mail-eopbgr750045.outbound.protection.outlook.com ([40.107.75.45]:3235
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDCPYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx6heFC05Hk1yX3Ozk2x/YRVNIzs8FBkZPGT72lFxxo=;
 b=A3TWBHBuQ4UJMC4U1pnf07eIqiWZHpAFCU2xTt0Vui65JvEUvOQODp7SL2vS7fuEtqNPq/JtjLMFJx8hKg+ITn11/X6k3c+Zr/eoXZIB3RzmUUfsX9WOm+5N/29AeKT9g++ELvOA/t+/eO30pQJV8/qWatj0gOMVm+ONCT3pxYc=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3001.namprd12.prod.outlook.com (20.178.29.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 15:24:43 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::b1af:416d:c2c3:8e3b%5]) with mapi id 15.20.1750.014; Wed, 3 Apr 2019
 15:24:43 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] x86/perf/amd: Fix build failure when CONFIG_HAVE_NMI_WATCHDOG
 is not set
Thread-Topic: [PATCH] x86/perf/amd: Fix build failure when
 CONFIG_HAVE_NMI_WATCHDOG is not set
Thread-Index: AQHU6jFdWJAdOPSHLECe1g7/jmO2EA==
Date:   Wed, 3 Apr 2019 15:24:43 +0000
Message-ID: <a7d0eb1bf09b2b3c53de423f779e799725fc8c79.1554305069.git.thomas.lendacky@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d084ec32-964d-4e94-2210-08d6b8487f53
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3001;
x-ms-traffictypediagnostic: DM6PR12MB3001:
x-microsoft-antispam-prvs: <DM6PR12MB300162A23CE92502BD2D60BCEC570@DM6PR12MB3001.namprd12.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(6116002)(6512007)(8676002)(81166006)(102836004)(105586002)(52116002)(71190400001)(54906003)(478600001)(110136005)(86362001)(97736004)(6506007)(50226002)(316002)(7416002)(2501003)(3846002)(4744005)(186003)(25786009)(72206003)(6486002)(256004)(14444005)(5660300002)(4326008)(8936002)(14454004)(36756003)(81156014)(476003)(26005)(6436002)(305945005)(68736007)(486006)(66066001)(71200400001)(386003)(99286004)(7736002)(118296001)(106356001)(2616005)(53936002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3001;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eNIEDtFmpi6VDA0rH0yaAj/kw2SV6peHKJ3hmx4Uwryt2cvI/yo5w6+zkJvnN53McdrvItBpOxLfs7232DTHWvWCERFtB0Ws0Gs1LozO8DSfGywRyqCUQfB3+Qhlt8mTGU5MIkZs33CFGlXgirjkte4fLlM4q+uSLcuJVemy49wRlh4Tg8H5O7UKlaozYkku7pB4QIqO2AndQ2i585l+1MnD2MTVWyAPl3Hmlf2vF418y3lC57ayHq7BLQUv92JfT017ntIwnCtO2UN0c/9nViEJugiveNL+r7vxAvka7wwlGdMuxXfmyMrdKSDSSzlUnsMp5IIrzhtqttnXvsejR6PVkwJTlojpG+PqpjMA8ePA1UWajkLaeATg+IPnETBeGbWOgMcZ5bRY6aYzGgnvcN8kOY3e+nsKRB/cWDyfcwA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d084ec32-964d-4e94-2210-08d6b8487f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 15:24:43.6156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBDT05GSUdfSEFWRV9OTUlfV0FUQ0hET0cgaXMgbm90IHNldCwgdGhlIGFzbS9ubWkuaCBm
aWxlIGlzIG5vdA0KaW5jbHVkZWQuIFRoZSBhc20vbm1pLmggZmlsZSBjb250YWlucyB0aGUgZGVm
aW5pdGlvbnMgZm9yIE5NSV9IQU5ETEVEDQphbmQgTk1JX0RPTkUgd2hpY2ggYXJlIHVzZWQgaW4g
YXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMuIFRoaXMgY2F1c2VzDQp0aGUgYnVpbGQgdGhlIGZh
aWwuDQoNCkZpeCB0aGUgaXNzdWUgYnkgY2hhbmdpbmcgdGhlIGluY2x1ZGUgaW4gYXJjaC94ODYv
ZXZlbnRzL2FtZC9jb3JlLmMgZnJvbQ0KbGludXgvbm1pLmggdG8gYXNtL25taS5oLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBUb20gTGVuZGFja3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPg0KLS0tDQog
YXJjaC94ODYvZXZlbnRzL2FtZC9jb3JlLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMv
YW1kL2NvcmUuYyBiL2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5jDQppbmRleCA1ZDQyMzY1M2Y3
NDQuLjBlY2ZhYzg0YmE5MSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2V2ZW50cy9hbWQvY29yZS5j
DQorKysgYi9hcmNoL3g4Ni9ldmVudHMvYW1kL2NvcmUuYw0KQEAgLTQsOCArNCw4IEBADQogI2lu
Y2x1ZGUgPGxpbnV4L2luaXQuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRl
IDxsaW51eC9kZWxheS5oPg0KLSNpbmNsdWRlIDxsaW51eC9ubWkuaD4NCiAjaW5jbHVkZSA8YXNt
L2FwaWNkZWYuaD4NCisjaW5jbHVkZSA8YXNtL25taS5oPg0KIA0KICNpbmNsdWRlICIuLi9wZXJm
X2V2ZW50LmgiDQogDQotLSANCjIuMTcuMQ0KDQo=
