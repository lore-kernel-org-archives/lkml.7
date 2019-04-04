Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B46C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFE72171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5uUvU63D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbfDDVZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:25:59 -0400
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:6544
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730720AbfDDVZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFFa75NoUBhFlV+yqE//c6N02FdJVCEv38LUuxoZ02Q=;
 b=5uUvU63DQf/qtzrCbPYSD6dNZhiSciv7hbIxWePAw3NkWlrko0M/k2T6n5ZGpLk0Y7bnCG+XQ9hefNKOo9DJB4qjqafbjq0Qo13c/nDgHgRC0pUWn5jSGgLXG0+Uo0mXGv0rOwSc0azUTe4riHODQ6C9ohV8aHvMn0s8X9Koup0=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 21:25:52 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:25:52 +0000
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
Subject: [PATCH v2 3/7] acpi/cppc: Modify show_cppc_data macro
Thread-Topic: [PATCH v2 3/7] acpi/cppc: Modify show_cppc_data macro
Thread-Index: AQHU6yz6JJqmaPEOAkm3pVU0VSvCPw==
Date:   Thu, 4 Apr 2019 21:25:50 +0000
Message-ID: <4ccf8a16e59b500946b3bdd13419a4956692528b.1554410643.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 5bf66619-d84d-4a20-57db-08d6b9441c6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2845;
x-ms-traffictypediagnostic: SN6PR12MB2845:
x-microsoft-antispam-prvs: <SN6PR12MB2845B24A6420B1E770809147E7500@SN6PR12MB2845.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(366004)(346002)(199004)(189003)(305945005)(5660300002)(26005)(102836004)(105586002)(66066001)(118296001)(8676002)(106356001)(6116002)(3846002)(81156014)(97736004)(68736007)(53936002)(81166006)(316002)(7736002)(2201001)(50226002)(71190400001)(71200400001)(86362001)(14444005)(6512007)(2501003)(8936002)(99286004)(25786009)(36756003)(256004)(4326008)(6486002)(478600001)(186003)(110136005)(486006)(14454004)(54906003)(446003)(72206003)(11346002)(2906002)(52116002)(2616005)(476003)(6506007)(386003)(76176011)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2845;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B0YbOAYG+6khKLDSUsyI7qVsvTpgHpbtweWwKPt4ZxVsGHoLSG2Nfeqe5cOR5mb2qayH95VL6fY9LSbSycxfHTb0J5pgaYOaviYETBLgiEpDfciKrlB4RX+ezkTQTTmbWRhedNw219iVhyHFFtdC1mU7GVsVcEhgM7xa4Ls1NDHlaTrH6OgMkXrOgeHAFyz2PkHqL+fs9A17ViXsx796fQcIj4SRAZjCmRFYlVoEq7/hYSZIAhs/EQ8pTDrvOg2525l2bzdM+UTewuICoQ+7HVzav8Yx57EWf6oxefHivbAxG93J7Zn7763+h0/xEjQtbe25nCdDhvFXmO80VyWrGPQftoaeW1RHfbulh6zbJRj3bqVbsp7NpAUOpXF2ZBMWFCR8y26JTfcyUFzTgBO7RbWqlCYBRwu6byK0f+H8LPk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf66619-d84d-4a20-57db-08d6b9441c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:25:50.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgc2hvd19j
cHBjX2RhdGEgbWFjcm8gaW1wbGljaXR5IHVzZXMgZGVmaW5lX29uZV9jcHBjX3JvLiBUaGlzIHdp
bGwNCnByZXZlbnQgdGhlIGNyZWF0aW9uIG9mIGFuIGF0dHJpYnV0ZSB3aXRoIHJlYWQgYW5kIHdy
aXRlIHBlcm1pc3Npb25zLg0KDQpDcmVhdGUgYSBzZXBhcmF0ZSBtYWNybyB0aGF0IGRlZmluZXMg
YSBzaG93IGF0dHJpYnV0ZSBhbmQgY3JlYXRlcw0KYSByZWFkLW9ubHkgc3lzZnMgZW50cnkuIFRo
aXMgaXMgaW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBhIG1hY3JvDQp0byBjcmVhdGUgc3lzZnMg
ZW50cmllcyB3aXRoIHJlYWQrd3JpdGUgcGVybWlzc2lvbi4NCg0KU2lnbmVkLW9mZi1ieTogWWF6
ZW4gR2hhbm5hbSA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KWyBjYXJ2ZWQgb3V0IGludG8gYSBw
YXRjaCwgY2xlYW5lZCB1cCwgcHJvZHVjdGl6ZWQgXQ0KU2lnbmVkLW9mZi1ieTogSmFuYWthcmFq
YW4gTmF0YXJhamFuIDxKYW5ha2FyYWphbi5OYXRhcmFqYW5AYW1kLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvYWNwaS9jcHBjX2FjcGkuYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYWNwaS9jcHBjX2FjcGkuYyBiL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYw0KaW5kZXgg
MzcxNTdkMTlkMmRmLi4xMGFlNWE1ODE4ZTYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2FjcGkvY3Bw
Y19hY3BpLmMNCisrKyBiL2RyaXZlcnMvYWNwaS9jcHBjX2FjcGkuYw0KQEAgLTE1OSwxNyArMTU5
LDIwIEBAIF9fQVRUUihfbmFtZSwgMDQ0NCwgc2hvd18jI19uYW1lLCBOVUxMKQ0KIAkJcmV0dXJu
IHNjbnByaW50ZihidWYsIFBBR0VfU0laRSwgIiVsbHVcbiIsCQlcDQogCQkJCSh1NjQpc3RfbmFt
ZS5tZW1iZXJfbmFtZSk7CQlcDQogCX0JCQkJCQkJCVwNCisNCisjZGVmaW5lIHNob3dfY3BwY19k
YXRhX3JvKGFjY2Vzc19mbiwgc3RydWN0X25hbWUsIG1lbWJlcl9uYW1lKQkJXA0KKwlzaG93X2Nw
cGNfZGF0YShhY2Nlc3NfZm4sIHN0cnVjdF9uYW1lLCBtZW1iZXJfbmFtZSkJCVwNCiAJZGVmaW5l
X29uZV9jcHBjX3JvKG1lbWJlcl9uYW1lKQ0KIA0KLXNob3dfY3BwY19kYXRhKGNwcGNfZ2V0X3Bl
cmZfY2FwcywgY3BwY19wZXJmX2NhcHMsIGhpZ2hlc3RfcGVyZik7DQotc2hvd19jcHBjX2RhdGEo
Y3BwY19nZXRfcGVyZl9jYXBzLCBjcHBjX3BlcmZfY2FwcywgbG93ZXN0X3BlcmYpOw0KLXNob3df
Y3BwY19kYXRhKGNwcGNfZ2V0X3BlcmZfY2FwcywgY3BwY19wZXJmX2NhcHMsIG5vbWluYWxfcGVy
Zik7DQotc2hvd19jcHBjX2RhdGEoY3BwY19nZXRfcGVyZl9jYXBzLCBjcHBjX3BlcmZfY2Fwcywg
bG93ZXN0X25vbmxpbmVhcl9wZXJmKTsNCi1zaG93X2NwcGNfZGF0YShjcHBjX2dldF9wZXJmX2Nh
cHMsIGNwcGNfcGVyZl9jYXBzLCBsb3dlc3RfZnJlcSk7DQotc2hvd19jcHBjX2RhdGEoY3BwY19n
ZXRfcGVyZl9jYXBzLCBjcHBjX3BlcmZfY2Fwcywgbm9taW5hbF9mcmVxKTsNCitzaG93X2NwcGNf
ZGF0YV9ybyhjcHBjX2dldF9wZXJmX2NhcHMsIGNwcGNfcGVyZl9jYXBzLCBoaWdoZXN0X3BlcmYp
Ow0KK3Nob3dfY3BwY19kYXRhX3JvKGNwcGNfZ2V0X3BlcmZfY2FwcywgY3BwY19wZXJmX2NhcHMs
IGxvd2VzdF9wZXJmKTsNCitzaG93X2NwcGNfZGF0YV9ybyhjcHBjX2dldF9wZXJmX2NhcHMsIGNw
cGNfcGVyZl9jYXBzLCBub21pbmFsX3BlcmYpOw0KK3Nob3dfY3BwY19kYXRhX3JvKGNwcGNfZ2V0
X3BlcmZfY2FwcywgY3BwY19wZXJmX2NhcHMsIGxvd2VzdF9ub25saW5lYXJfcGVyZik7DQorc2hv
d19jcHBjX2RhdGFfcm8oY3BwY19nZXRfcGVyZl9jYXBzLCBjcHBjX3BlcmZfY2FwcywgbG93ZXN0
X2ZyZXEpOw0KK3Nob3dfY3BwY19kYXRhX3JvKGNwcGNfZ2V0X3BlcmZfY2FwcywgY3BwY19wZXJm
X2NhcHMsIG5vbWluYWxfZnJlcSk7DQogDQotc2hvd19jcHBjX2RhdGEoY3BwY19nZXRfcGVyZl9j
dHJzLCBjcHBjX3BlcmZfZmJfY3RycywgcmVmZXJlbmNlX3BlcmYpOw0KLXNob3dfY3BwY19kYXRh
KGNwcGNfZ2V0X3BlcmZfY3RycywgY3BwY19wZXJmX2ZiX2N0cnMsIHdyYXBhcm91bmRfdGltZSk7
DQorc2hvd19jcHBjX2RhdGFfcm8oY3BwY19nZXRfcGVyZl9jdHJzLCBjcHBjX3BlcmZfZmJfY3Ry
cywgcmVmZXJlbmNlX3BlcmYpOw0KK3Nob3dfY3BwY19kYXRhX3JvKGNwcGNfZ2V0X3BlcmZfY3Ry
cywgY3BwY19wZXJmX2ZiX2N0cnMsIHdyYXBhcm91bmRfdGltZSk7DQogDQogc3RhdGljIHNzaXpl
X3Qgc2hvd19mZWVkYmFja19jdHJzKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KIAkJc3RydWN0IGF0
dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KLS0gDQoyLjE3LjENCg0K
