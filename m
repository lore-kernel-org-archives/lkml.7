Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45811C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8D2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="II5aD96a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfCOUkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:40:49 -0400
Received: from mail-eopbgr720057.outbound.protection.outlook.com ([40.107.72.57]:48384
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfCOUkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOhsF9UeHf5V2FythDTpIpVI/1u04CdwJCqA5LIe0AE=;
 b=II5aD96ahtM/DBk7h5zAixA01aS7aHkR3kMtUuI34pmD5tZLGziFMyG2ONE1V8jKya0tGJscXgwkqn+4Wqt6ngh3JKKWePcGXyqrY6F+hKtlmr1SdafJWyB7S9SNZFsZGRQkAVkzsRkjO2MeQ043nxTc2SAIV+5PU9cyHMADWgQ=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3545.namprd12.prod.outlook.com (20.179.106.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 20:40:45 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::a8aa:c9af:1f69:2a89%6]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 20:40:45 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [RFC PATCH v2 0/2] x86/perf/amd: AMD PMC counters and NMI latency
Thread-Topic: [RFC PATCH v2 0/2] x86/perf/amd: AMD PMC counters and NMI
 latency
Thread-Index: AQHU229deayGe7ZK6U692ECGjQCtpA==
Date:   Fri, 15 Mar 2019 20:40:45 +0000
Message-ID: <155268244291.14761.3432013617741218607.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:805:a2::38) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c45e87-6ddd-48db-e80a-08d6a9867f8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3545;
x-ms-traffictypediagnostic: DM6PR12MB3545:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB3545FA268FE407E198A114E6EC440@DM6PR12MB3545.namprd12.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(256004)(9686003)(305945005)(6506007)(486006)(86362001)(316002)(5660300002)(476003)(6436002)(81166006)(6116002)(102836004)(81156014)(7416002)(966005)(52116002)(6486002)(66066001)(3846002)(103116003)(71200400001)(72206003)(71190400001)(2906002)(2501003)(6306002)(68736007)(105586002)(186003)(26005)(8676002)(386003)(7736002)(14454004)(478600001)(25786009)(99286004)(53936002)(110136005)(8936002)(54906003)(106356001)(97736004)(14444005)(4326008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3545;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HgWq2M4IypqKgL4syivNS3SfTHMERO/6WHJz/FrJDtaF0kuiVcC474CLJUyS42QlEVRGYLvV+mjVEtblV3y3qydhqaGTSXwd6RV9xhhgbb+JuIW9mPzXuzjkib2IW2YA1bt6lRMMN3CZf4X4qM7bZ/fOFXbBH1c+LnoOwKMEaqPZwaKOLctP8htoLKIVg8M0QtijPG0N5C1bUvn2/fOumoDFN+JxJShWWQ4DhmzlvHaRmzxXA+6qnMsRDq3PAvdiQtT3d1iuCXn4xt83cJ1fXILgKIfzh65CRR2Eec/yYntZDNNYSbTgqXdhW8x7Np6wFkxAbBx9YzhL0GDX8s02KQ75r133Csmhu0tEsBw+JUiqwYb0baPlDEC9xKVQHgyWTHbh1DteUnuQTgx+bghI+xseEDxziOot+zonvyDcvXQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <094154363775AD4A97DF464BB6660655@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c45e87-6ddd-48db-e80a-08d6a9867f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 20:40:45.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcmVzc2VzIGlzc3VlcyB3aXRoIGluY3JlYXNlZCBOTUkgbGF0
ZW5jeSBpbiBuZXdlcg0KQU1EIHByb2Nlc3NvcnMgdGhhdCBjYW4gcmVzdWx0IGluIHVua25vd24g
Tk1JIG1lc3NhZ2VzIHdoZW4gUE1DIGNvdW50ZXJzDQphcmUgYWN0aXZlLg0KDQpUaGUgZm9sbG93
aW5nIGZpeGVzIGFyZSBpbmNsdWRlZCBpbiB0aGlzIHNlcmllczoNCg0KLSBSZXNvbHZlIGEgcmFj
ZSBjb25kaXRpb24gd2hlbiBkaXNhYmxpbmcgYW4gb3ZlcmZsb3dlZCBQTUMgY291bnRlciwNCiAg
c3BlY2lmaWNhbGx5IHdoZW4gdXBkYXRpbmcgdGhlIFBNQyBjb3VudGVyIHdpdGggYSBuZXcgdmFs
dWUuDQotIFJlc29sdmUgaGFuZGxpbmcgb2YgbXVsdGlwbGUgYWN0aXZlIFBNQyBjb3VudGVyIG92
ZXJmbG93cyBpbiB0aGUgcGVyZg0KICBOTUkgaGFuZGxlciBhbmQgd2hlbiB0byByZXBvcnQgdGhh
dCB0aGUgTk1JIGlzIG5vdCByZWxhdGVkIHRvIGEgUE1DLg0KDQpJZiBldmVyeXRoaW5nIGxvb2tz
IG9rLCBJJ2xsIHJlLXN1Ym1pdCB3aXRob3V0IHRoZSBSRkMgdGFnLiBEZWZpbml0ZWx5DQpsb29r
cyBjbGVhbmVyIHdpdGggdGhlIEFNRCBzcGVjaWZpYyBjYWxsYmFjayBmdW5jdGlvbnMuDQoNCi0t
LQ0KDQpDaGFuZ2VzIGZyb20gdjEgKGJhc2VkIG9uIGZlZWRiYWNrIGZyb20gUGV0ZXIgWik6DQot
IENyZWF0ZWQgYW4gQU1EIHNwZWNpZmljIGRpc2FibGVfYWxsIGNhbGxiYWNrIGZ1bmN0aW9uIHRv
IGhhbmRsZSB0aGUNCiAgZGlzYWJsaW5nIG9mIHRoZSBjb3VudGVycyBhbmQgcmVzb2x2ZSB0aGUg
cmFjZSBjb25kaXRpb24NCi0gQ3JlYXRlZCBhbiBBTUQgc3BlY2lmaWMgaGFuZGxlX2lycSBjYWxs
YmFjayBmdW5jdGlvbiB0aGF0IGludm9rZXMgdGhlDQogIGNvbW1vbiB4ODZfcG11X2hhbmRsZV9p
cnEoKSBmdW5jdGlvbiBhbmQgdGhlbiBwZXJmb3JtcyB0aGUgTk1JIGxhdGVuY3kNCiAgbWl0aWdh
dGlvbi4NCi0gVGFrZSBpbnRvIGFjY291bnQgdGhlIHBvc3NpYmlsaXR5IG9mIG5vbi1wZXJmIE5N
SSBzb3VyY2VzIHdoZW4gYXBwbHlpbmcNCiAgdGhlIG1pdGlnYXRpb24uDQoNClRoaXMgcGF0Y2gg
c2VyaWVzIGlzIGJhc2VkIG9mZiBvZiB0aGUgcGVyZi9jb3JlIGJyYW5jaCBvZiB0aXA6DQogIGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0
IHBlcmYvY29yZQ0KDQogIENvbW1pdCBjOTc4Yjk0NjBmZTEgKCJNZXJnZSB0YWcgJ3BlcmYtY29y
ZS1mb3ItbWluZ28tNS4xLTIwMTkwMjI1JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvYWNtZS9saW51eCBpbnRvIHBlcmYvY29yZSIpDQo=
