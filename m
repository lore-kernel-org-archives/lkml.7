Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53ABC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780A32177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ov0B9Czp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfDDVZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:25:55 -0400
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:6544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729400AbfDDVZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW8gZHZuD3wQMGTOOHdu82wdoI9L6G9fVD3ek1X1pZ4=;
 b=Ov0B9CzpnlavmoW5muZPj8cYufv0HLiryB3Fy5UuDDAAqRBHV+Rhyoz9bX1pzfWFHB0aa8y1FDOOdATyPtxHzi9RZKhQnKnUDVUXA/nmGoiUjR2S7q0Izp8yCeOcmrheuhcaxh1RN8sTLQR2o9EcsyXJ0gCgFPN+tBkhZsSArPo=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 21:25:47 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:25:47 +0000
From:   "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v2 1/7] acpi/cppc: Add macro for CPPC register BUFFER only
 check
Thread-Topic: [PATCH v2 1/7] acpi/cppc: Add macro for CPPC register BUFFER
 only check
Thread-Index: AQHU6yz32WKT40X3o02yO8eIfc6cDA==
Date:   Thu, 4 Apr 2019 21:25:47 +0000
Message-ID: <4eae43aeb96e379bbdd9cd2a040fe53c147bd412.1554410643.git.Janakarajan.Natarajan@amd.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
In-Reply-To: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:803:20::14) To SN6PR12MB2736.namprd12.prod.outlook.com
 (2603:10b6:805:77::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d439b8f-ee15-4a64-13fa-08d6b9441a19
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2845;
x-ms-traffictypediagnostic: SN6PR12MB2845:
x-microsoft-antispam-prvs: <SN6PR12MB284512F5281A002D115CC2F6E7500@SN6PR12MB2845.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(5660300002)(26005)(102836004)(105586002)(66066001)(118296001)(8676002)(106356001)(6116002)(4744005)(3846002)(81156014)(97736004)(68736007)(53936002)(81166006)(316002)(7736002)(2201001)(50226002)(71190400001)(71200400001)(86362001)(6512007)(2501003)(8936002)(99286004)(25786009)(36756003)(256004)(4326008)(6486002)(478600001)(186003)(110136005)(486006)(14454004)(54906003)(446003)(72206003)(11346002)(2906002)(52116002)(2616005)(476003)(6506007)(386003)(76176011)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2845;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YuAOjoJfEY+O2iV94tfdqhO3kxr/ldyx1bE+BUTFfN6NJgVKnu6O6ehtK0xLOCV3C9yI/cgNBepbVEsbLcgmEpJlO3awqrv5kFdwqtWimci5rXyxa6p/GCxmDpykwFoJJm46r2Lww92MSy4PDwTD9oAx3ILb9+g/TlUIynY50QLzwnxXWMT+vHmW2FN/v6OF0xgpYxag8KCp/RtuMU1rgcp0LvcfARyERmpRRFbch+8/6MbJqvY/0ABaMxujHKghqJ7uxt6rI8odN5jW6B+KeHYrMpCS/zMLCw1tVjgA6s7kXfxnKTwTnRkV4t/dsdiJsvKtje8VR4j2huf9SrCAKeZcyWpGBXZ3ygIiZwokSKAlvFIg1ry9nKxIla9xmHgQApkrwfCwB5AcC/jPaQQr+cSmQ0IL7SVmmO+3Zg79Ki4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d439b8f-ee15-4a64-13fa-08d6b9441a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:25:47.1403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q1BDX1NVUF9CVUZGRVJfT05MWSBlbnN1cmVzIHRoYXQgYW4gZXhwZWN0ZWQgQlVGRkVSIG9ubHkg
cmVnaXN0ZXIgaGFzIGENCnJlZ2lzdGVyIHR5cGUgb2YgQUNQSV9UWVBFX0JVRkZFUiBhbmQgaXMg
bm90IE5VTEwuDQoNClNpZ25lZC1vZmYtYnk6IEphbmFrYXJhamFuIE5hdGFyYWphbiA8SmFuYWth
cmFqYW4uTmF0YXJhamFuQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMg
fCA4ICsrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIGIvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5j
DQppbmRleCBkNDI0NGU3ZDBlMzguLjU2YTA5ZTA1N2M0ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
YWNwaS9jcHBjX2FjcGkuYw0KKysrIGIvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jDQpAQCAtMTE1
LDYgKzExNSwxNCBAQCBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGNwY19kZXNjICosIGNw
Y19kZXNjX3B0cik7DQogI2RlZmluZSBDUENfU1VQUE9SVEVEKGNwYykgKChjcGMpLT50eXBlID09
IEFDUElfVFlQRV9JTlRFR0VSID8JCVwNCiAJCQkJISEoY3BjKS0+Y3BjX2VudHJ5LmludF92YWx1
ZSA6CQlcDQogCQkJCSFJU19OVUxMX1JFRygmKGNwYyktPmNwY19lbnRyeS5yZWcpKQ0KKw0KKy8q
DQorICogRXZhbHVhdGVzIHRvIFRydWUgaWYgYW4gb3B0aW9uYWwgY3BjIGZpZWxkIGlzIHN1cHBv
cnRlZCBhbmQgaXMNCisgKiBCVUZGRVIgb25seQ0KKyAqLw0KKyNkZWZpbmUgQ1BDX1NVUF9CVUZG
RVJfT05MWShjcGMpICgoY3BjKS0+dHlwZSA9PSBBQ1BJX1RZUEVfQlVGRkVSICYmCVwNCisJCQkJ
ICAhSVNfTlVMTF9SRUcoJihjcGMpLT5jcGNfZW50cnkucmVnKSkNCisNCiAvKg0KICAqIEFyYml0
cmFyeSBSZXRyaWVzIGluIGNhc2UgdGhlIHJlbW90ZSBwcm9jZXNzb3IgaXMgc2xvdyB0byByZXNw
b25kDQogICogdG8gUENDIGNvbW1hbmRzLiBLZWVwaW5nIGl0IGhpZ2ggZW5vdWdoIHRvIGNvdmVy
IGVtdWxhdG9ycyB3aGVyZQ0KLS0gDQoyLjE3LjENCg0K
