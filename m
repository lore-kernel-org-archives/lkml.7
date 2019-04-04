Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14007217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1xdTTwMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfDDVZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:25:47 -0400
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:25086
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729400AbfDDVZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXtTmhbVREp5AjsN/HGcTxC2VUvd+BqKr3ejnFUSEUU=;
 b=1xdTTwMKokX6d2wq//Ed7Cb0AceJdqGCpNxZ0xHqwC51u5PINAHm2pOHTtE8RlSvZsipZ+LTS3lKq1SIucmilFwo5NAgoUgGCKaoKtw+orio+dcIR+AdYG/RChRnTVxq2NdLXloTcEAVrcNCaPcxd9aeheM0ZPmtG/4jq/IlQNg=
Received: from SN6PR12MB2736.namprd12.prod.outlook.com (52.135.107.27) by
 SN6PR12MB2847.namprd12.prod.outlook.com (52.135.104.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 21:25:43 +0000
Received: from SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a]) by SN6PR12MB2736.namprd12.prod.outlook.com
 ([fe80::65cb:af55:6bd4:55a%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 21:25:43 +0000
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
Subject: [PATCH v2 0/7] CPPC optional registers AMD support
Thread-Topic: [PATCH v2 0/7] CPPC optional registers AMD support
Thread-Index: AQHU6yz1dnTlH1WoLEy8yDNVtzL7aQ==
Date:   Thu, 4 Apr 2019 21:25:43 +0000
Message-ID: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
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
x-ms-office365-filtering-correlation-id: 283dad5e-8eb6-4c1a-ef96-08d6b94417f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2847;
x-ms-traffictypediagnostic: SN6PR12MB2847:
x-microsoft-antispam-prvs: <SN6PR12MB2847A2C677A257BBCA3A1FCEE7500@SN6PR12MB2847.namprd12.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(26005)(6506007)(97736004)(72206003)(478600001)(68736007)(36756003)(81156014)(8676002)(81166006)(25786009)(4326008)(256004)(105586002)(99286004)(2906002)(2616005)(476003)(486006)(106356001)(52116002)(7736002)(54906003)(305945005)(316002)(110136005)(14454004)(3846002)(66066001)(2501003)(86362001)(102836004)(5660300002)(53936002)(71200400001)(50226002)(71190400001)(386003)(6116002)(14444005)(186003)(2201001)(6512007)(6486002)(8936002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2847;H:SN6PR12MB2736.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jG0wsYgXqS40CNvYtsT4PNVFjfwh0rxl2eu7j8HZToI9ht0I+BMOy6NGMcKXAL3lz7PhCkt7GD1S/lA8vPElYT2rgsm4r//tBJxBrrhjJ3xyPMPhFUTjUOhUlCIWElZw2GyBDSOJRy44covZRSTosW2Iq/zCUnAPEyhTeoiDcHlm3AEes0sybTDJdnsZRRjIzpVxheqC45WYvKiv7FDpX7C5mCfyPnG78nb34Rfnm+eChkYfYMRnyFCz971yd5BMtg7p+VWtKEOiFyObQOK9kSn00eUjSdrKDHKeH62hEZQxFv3fsd0yVgFODq3T6+nDlta8Ln11zv+TuiJ9VmHLXvmU+AAvuq73mh2GlKHa+sGeKiNYGEMFkWcezst7GBMO2o3HJpHewqhnhE30yroPKIaSTc4y/N1g56+B86z2dbE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283dad5e-8eb6-4c1a-ef96-08d6b94417f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 21:25:43.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q1BQQyAoQ29sbGFib3JhdGl2ZSBQcm9jZXNzb3IgUGVyZm9ybWFuY2UgQ29udHJvbCkgb2ZmZXJz
IG9wdGlvbmFsDQpyZWdpc3RlcnMgd2hpY2ggY2FuIGJlIHVzZWQgdG8gdHVuZSB0aGUgc3lzdGVt
IGJhc2VkIG9uIGVuZXJneSBhbmQvb3INCnBlcmZvcm1hbmNlIHJlcXVpcmVtZW50cy4NCg0KTmV3
ZXIgQU1EIHByb2Nlc3NvcnMgYWRkIHN1cHBvcnQgZm9yIGEgc3Vic2V0IG9mIHRoZXNlIG9wdGlv
bmFsIENQUEMNCnJlZ2lzdGVycywgYmFzZWQgb24gQUNQSSB2Ni4xLg0KDQpUaGUgZm9sbG93aW5n
IGFyZSB0aGUgc3VwcG9ydGVkIENQUEMgcmVnaXN0ZXJzIGZvciB3aGljaCBzeXNmcyBlbnRyaWVz
DQphcmUgY3JlYXRlZDoNCiogZW5hYmxlICAgICAgICAgICAgICAgIChORVcpDQoqIG1heF9wZXJm
ICAgICAgICAgICAgICAoTkVXKQ0KKiBtaW5fcGVyZiAgICAgICAgICAgICAgKE5FVykNCiogZW5l
cmd5X3BlcmYNCiogbG93ZXN0X3BlcmYNCiogbm9taW5hbF9wZXJmDQoqIGRlc2lyZWRfcGVyZiAg
ICAgICAgICAoTkVXKQ0KKiBmZWVkYmFja19jdHJzDQoqIGF1dG9fc2VsX2VuYWJsZSAgICAgICAo
TkVXKQ0KKiBsb3dlc3Rfbm9ubGluZWFyX3BlcmYNCg0KVGhlIENQUEMgZHJpdmVyIGlzIHVwZGF0
ZWQgdG8gZW5hYmxlIHRoZSBPU1BNIGFuZCB0aGUgdXNlcnNwYWNlIHRvDQphY2Nlc3MNCnRoZSBu
ZXdseSBzdXBwb3J0ZWQgcmVnaXN0ZXJzLg0KDQpUaGUgcHVycG9zZSBvZiBleHBvc2luZyB0aGUg
cmVnaXN0ZXJzIHZpYSB0aGUgc3lzZnMgZW50cmllcyBpcyB0byBhbGxvdw0KdGhlIHVzZXJzcGFj
ZSB0bzoNCiogVHdlYWsgdGhlIHZhbHVlcyB0byBmaXQgaXRzIHdvcmtsb2FkLg0KKiBBcHBseSBh
IHByb2ZpbGUgZnJvbSBBTUQncyBvcHRpbWl6YXRpb24gZ3VpZGVzLg0KDQpQcm9maWxlcyB3aWxs
IGJlIGRvY3VtZW50ZWQgaW4gdGhlIHBlcmZvcm1hbmNlL29wdGltaXphdGlvbiBndWlkZXMuDQoN
Ck5vdGU6DQoqIEFNRCBzeXN0ZW1zIHdpbGwgbm90IGhhdmUgYSBwb2xpY3kgYXBwbGllZCBpbiB0
aGUga2VybmVsIGF0IHRoaXMgdGltZS4NCiogQnkgZGVmYXVsdCwgYWNwaV9jcHVmcmVxIHdpbGwg
c3RpbGwgYmUgdXNlZC4NCg0KVE9ETzoNCiogQ3JlYXRlIGEgbGludXggdXNlcnNwYWNlIHRvb2wg
dGhhdCB3aWxsIGhlbHAgdXNlcnMgZ2VuZXJhdGUgYSBDUFBDDQoqIHByb2ZpbGUNCiAgZm9yIHRo
ZWlyIHRhcmdldCB3b3JrbG9hZC4NCiogQ3JlYXRlIG9yIHVwZGF0ZSBhIGRyaXZlciB0byBhcHBs
eSBhIGdlbmVyYWwgQ1BQQyBwb2xpY3kgaW4gdGhlDQoqIGtlcm5lbC4NCg0KdjEtPnYyOg0KKiBB
ZGQgbWFjcm8gdG8gZW5zdXJlIEJVRkZFUiBvbmx5IHJlZ2lzdGVycyBoYXZlIEJVRkZFUiB0eXBl
Lg0KKiBBZGQgc3VwcG9ydCBtYWNybyB0byBtYWtlIHRoZSByaWdodCBjaGVjayBiYXNlZCBvbiBy
ZWdpc3RlciB0eXBlLg0KKiBSZW1vdmUgc3VwcG9ydCBjaGVja3MgZm9yIHJlZ2lzdGVycyB3aGlj
aCBhcmUgbWFuZGF0b3J5Lg0KDQpKYW5ha2FyYWphbiBOYXRhcmFqYW4gKDIpOg0KICBhY3BpL2Nw
cGM6IEFkZCBtYWNybyBmb3IgQ1BQQyByZWdpc3RlciBCVUZGRVIgb25seSBjaGVjaw0KICBhY3Bp
L2NwcGM6IEVuc3VyZSBvbmx5IHN1cHBvcnRlZCBDUFBDIHN5c2ZzIGVudHJpZXMgYXJlIGNyZWF0
ZWQNCg0KWWF6ZW4gR2hhbm5hbSAoNSk6DQogIGFjcGkvY3BwYzogTW9kaWZ5IHNob3dfY3BwY19k
YXRhIG1hY3JvDQogIGFjcGkvY3BwYzogUmV3b3JrIGNwcGNfc2V0X3BlcmYoKSB0byB1c2UgY3Bw
Y19yZWdzIGluZGV4DQogIGFjcGkvY3BwYzogQWRkIG1hY3JvcyB0byBkZWZpbmUgYSBSL1cgc3lz
ZnMgZW50cnkgZm9yIENQUEMgcmVnaXN0ZXJzDQogIGFjcGkvY3BwYzogQWRkIHN1cHBvcnQgZm9y
IG9wdGlvbmFsIENQUEMgcmVnaXN0ZXJzDQogIGFjcGkvY3BwYzogQWRkIHN1cHBvcnQgZm9yIENQ
UEMgRW5hYmxlIHJlZ2lzdGVyDQoNCiBkcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMgICAgICAgfCA0
MDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogZHJpdmVycy9jcHVmcmVxL2Nw
cGNfY3B1ZnJlcS5jIHwgICA2ICstDQogaW5jbHVkZS9hY3BpL2NwcGNfYWNwaS5oICAgICAgIHwg
ICA2ICstDQogMyBmaWxlcyBjaGFuZ2VkLCAzNzIgaW5zZXJ0aW9ucygrKSwgNDIgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi4xNy4xDQoNCg==
