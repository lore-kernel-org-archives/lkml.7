Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF7AC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F20A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4JVeVi2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfIQSlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:41:06 -0400
Received: from mail-eopbgr790075.outbound.protection.outlook.com ([40.107.79.75]:17312
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728493AbfIQSlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cau10OIOvDKATzwLWybCb3yrVT6odX4ZCyetTw7+Zode5y2qRb8ys8lasmRBD4cboeU0utTzdkOYtABO0kflQU0mpskOoewLaIwkbDtvnibIDO0TWpo1fKiyOpINh3PdKI5eriMV3DAvxZCLMdgkgBLtzW7BOecjBV91MkGXmxP8HdFvFXgswP3Ke2MCLfG0Ctiwkx/dbIxgkFk73mAb/N5+nDLHEjXTkjKWLrhC9mmT67/ZB40338zoO3YZK0Odix+gbCBtDrnKOjDEprk/lRzIBPCb6NKyiYQP+L5L2bfeDnhibTL5hDs4fMM8kNydmt/+cJj8DFa60Kk4rxo8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STIGllSdrhml3lsUo+Wtv1eCgCC0MjHGb4wrK76om0s=;
 b=dEpE2fnsspXb47OvMtIbD3NUuRE9dCPKtMTMEcKGqWCA/ddpcbOoAxBeeOwFMHpRNGQaZUBgd54o1Zc9iIj5dlAMmhwVVMHhpCrnxGwj/ixAn9/BkxytxkwXiLnrs2OyoYnJm/nWd5abHzRz5UN4k1fWYlDT9mE/5cyMPiNHHcbYPGC/1OTURUyI2AuwgFnf4H0wQqzvzLmiIhjjg1biM7y+Ij+HiNz7ZZrrJVorJU6yVTwTRdviG13kiCMPpgYDJjKydZXNVPuNWzoGJNksDCltlu6U/mGtrSOQfQCfuC8CA3NtgIRND8wU2fbo5eA6QoSPx6RZ3wEHspYFB0imCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STIGllSdrhml3lsUo+Wtv1eCgCC0MjHGb4wrK76om0s=;
 b=4JVeVi2LchOZAudP/RPsOij6tQwn+2OxwtWWcpXetJNfC2GkBv4xlay4OXY+1/wl/36ooZsne7j0mn+1h3c976WYMnof++Bzac+Dr4bFP6dpz4fpT2P6PkZ2YbN7IOgF72QpBeki4NEbp77hGi+UyBSrH/grPgBcIag5wUcr+E0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB2666.namprd12.prod.outlook.com (20.176.116.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Tue, 17 Sep 2019 18:41:03 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::585:2d27:6e06:f9b0%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 18:41:03 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Thread-Topic: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Thread-Index: AQHVY2lqe0y/Ny8J50ycIpieB3Q6FKccmUiAgAEU1ACAEVyvAIABOE0AgAAE/IA=
Date:   Tue, 17 Sep 2019 18:41:02 +0000
Message-ID: <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
 <20190905060627.GA1753@lst.de>
 <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0011.namprd06.prod.outlook.com
 (2603:10b6:803:2f::21) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 568b4c7f-f86f-494f-57f3-08d73b9e9770
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB2666;
x-ms-traffictypediagnostic: DM6PR12MB2666:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB266674255C2A37D6865C3BF5EC8F0@DM6PR12MB2666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(81166006)(71200400001)(6436002)(6506007)(81156014)(6246003)(64756008)(6116002)(66476007)(2906002)(66066001)(8936002)(229853002)(31686004)(316002)(110136005)(3846002)(66556008)(66446008)(6486002)(54906003)(6512007)(4326008)(31696002)(26005)(76176011)(186003)(99286004)(305945005)(86362001)(8676002)(53546011)(386003)(66946007)(36756003)(71190400001)(25786009)(446003)(478600001)(11346002)(7736002)(476003)(14454004)(102836004)(52116002)(486006)(5660300002)(7416002)(14444005)(2616005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2666;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JaI+ETOL76ZcMPGT7arga/10M90sqXlg2vGMxqSpwPfK0fWXnhnINcULdFQbfWOTUywm5OnrgUm9Nlf+xKlILXMIjqAvVP/Zip4n02I04AbTrtgz+kvk6FNt1z6+6lusreisNBvOZ/8nOs3ZZTH6OF7hZ25UJLTbJnwuqhjpDzNCmj/qBQJwjzxpieSwBBJDfC/Gi3D7O/J44b4D0mYg0hHwUT5WjT0tnOoxwYnVOhcqdQJBwN3i0RhNsUYcMpBzt8o9vJfzY4ns3UAW7A8+iX45Tnjm0yVYPpkeSuV0j5DSgGa6b21CTSBKOlmd+HRIkcEQltXB1y1V8cIYb1DP17aWa44h3lgPr1CmxVuwbpYLZX3nT6YowNoMydWSHAc+uZGM/cFd13Y8Q/eV6yhwQmt0dv7F3RPIvJbWUVQIjxI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DC37A5F8C8F4B4B979FC5160ADED03B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568b4c7f-f86f-494f-57f3-08d73b9e9770
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 18:41:02.9237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6e3CGnsO9vv6ofIqHPL5Ist+degQvBJc06ioWjw0OGceTb3srGDb8jm6hThn7eoH1u3md2C35vzAu0z1sB9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNy8xOSAxOjIzIFBNLCBEYXZpZCBSaWVudGplcyB3cm90ZToNCj4gT24gTW9uLCAxNiBT
ZXAgMjAxOSwgRGF2aWQgUmllbnRqZXMgd3JvdGU6DQo+IA0KPj4gQnJpamVzaCBhbmQgVG9tLCB3
ZSBjdXJyZW50bHkgaGl0IHRoaXMgYW55IHRpbWUgd2UgYm9vdCBhbiBTRVYgZW5hYmxlZCANCj4+
IFVidW50dSAxOC4wNCBndWVzdDsgSSBhc3N1bWUgdGhhdCBndWVzdCBrZXJuZWxzLCBlc3BlY2lh
bGx5IHRob3NlIG9mIHN1Y2ggDQo+PiBtYWpvciBkaXN0cmlidXRpb25zLCBhcmUgZXhwZWN0ZWQg
dG8gd29yayB3aXRoIHdhcm5pbmdzIGFuZCBCVUdzIHdoZW4gDQo+PiBjZXJ0YWluIGRyaXZlcnMg
YXJlIGVuYWJsZWQuDQo+Pg0KPj4gSWYgdGhlIHZtYXAgcHVyZ2UgbG9jayBpcyB0byByZW1haW4g
YSBtdXRleCAoYW55IG90aGVyIHJlYXNvbiB0aGF0IA0KPj4gdW5tYXBwaW5nIGFsaWFzZXMgY2Fu
IGJsb2NrPykgdGhlbiBpdCBhcHBlYXJzIHRoYXQgYWxsb2NhdGluZyBhIGRtYXBvb2wgDQo+PiBp
cyB0aGUgb25seSBhbHRlcm5hdGl2ZS4gIElzIHRoaXMgc29tZXRoaW5nIHRoYXQgeW91J2xsIGJl
IGFkZHJlc3NpbmcgDQo+PiBnZW5lcmljYWxseSBvciBkbyB3ZSBuZWVkIHRvIGdldCBidXktaW4g
ZnJvbSB0aGUgbWFpbnRhaW5lcnMgb2YgdGhpcyANCj4+IHNwZWNpZmljIGRyaXZlcj8NCj4+DQo+
IA0KPiBXZSd2ZSBmb3VuZCB0aGF0IHRoZSBmb2xsb3dpbmcgYXBwbGllZCBvbiB0b3Agb2YgNS4y
LjE0IHN1cHByZXNzZXMgdGhlIA0KPiB3YXJuaW5ncy4NCj4gDQo+IENocmlzdG9waCwgS2VpdGgs
IEplbnMsIGlzIHRoaXMgc29tZXRoaW5nIHRoYXQgd2UgY291bGQgZG8gZm9yIHRoZSBudm1lIA0K
PiBkcml2ZXI/ICBJJ2xsIGhhcHBpbHkgcHJvcG9zZSBpdCBmb3JtYWxseSBpZiBpdCB3b3VsZCBi
ZSBhY2NlcHRhYmxlLg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+IC0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+
IEBAIC0xNjEzLDcgKzE2MTMsOCBAQCBzdGF0aWMgaW50IG52bWVfYWxsb2NfYWRtaW5fdGFncyhz
dHJ1Y3QgbnZtZV9kZXYgKmRldikNCj4gIAkJZGV2LT5hZG1pbl90YWdzZXQudGltZW91dCA9IEFE
TUlOX1RJTUVPVVQ7DQo+ICAJCWRldi0+YWRtaW5fdGFnc2V0Lm51bWFfbm9kZSA9IGRldl90b19u
b2RlKGRldi0+ZGV2KTsNCj4gIAkJZGV2LT5hZG1pbl90YWdzZXQuY21kX3NpemUgPSBzaXplb2Yo
c3RydWN0IG52bWVfaW9kKTsNCj4gLQkJZGV2LT5hZG1pbl90YWdzZXQuZmxhZ3MgPSBCTEtfTVFf
Rl9OT19TQ0hFRDsNCj4gKwkJZGV2LT5hZG1pbl90YWdzZXQuZmxhZ3MgPSBCTEtfTVFfRl9OT19T
Q0hFRCB8DQo+ICsJCQkJCSAgQkxLX01RX0ZfQkxPQ0tJTkc7DQoNCkkgdGhpbmsgeW91IHdhbnQg
dG8gb25seSBzZXQgdGhlIEJMS19NUV9GX0JMT0NLSU5HIGlmIHRoZSBETUEgaXMgcmVxdWlyZWQN
CnRvIGJlIHVuZW5jcnlwdGVkLiBVbmZvcnR1bmF0ZWx5LCBmb3JjZV9kbWFfdW5lbmNyeXB0ZWQo
KSBjYW4ndCBiZSBjYWxsZWQNCmZyb20gYSBtb2R1bGUuIElzIHRoZXJlIGEgRE1BIEFQSSB0aGF0
IGNvdWxkIGJlIGNhbGxlZCB0byBnZXQgdGhhdCBpbmZvPw0KDQpUaGFua3MsDQpUb20NCg0KPiAg
CQlkZXYtPmFkbWluX3RhZ3NldC5kcml2ZXJfZGF0YSA9IGRldjsNCj4gIA0KPiAgCQlpZiAoYmxr
X21xX2FsbG9jX3RhZ19zZXQoJmRldi0+YWRtaW5fdGFnc2V0KSkNCj4gQEAgLTIyNjIsNyArMjI2
Myw4IEBAIHN0YXRpYyBpbnQgbnZtZV9kZXZfYWRkKHN0cnVjdCBudm1lX2RldiAqZGV2KQ0KPiAg
CQlkZXYtPnRhZ3NldC5xdWV1ZV9kZXB0aCA9DQo+ICAJCQkJbWluX3QoaW50LCBkZXYtPnFfZGVw
dGgsIEJMS19NUV9NQVhfREVQVEgpIC0gMTsNCj4gIAkJZGV2LT50YWdzZXQuY21kX3NpemUgPSBz
aXplb2Yoc3RydWN0IG52bWVfaW9kKTsNCj4gLQkJZGV2LT50YWdzZXQuZmxhZ3MgPSBCTEtfTVFf
Rl9TSE9VTERfTUVSR0U7DQo+ICsJCWRldi0+dGFnc2V0LmZsYWdzID0gQkxLX01RX0ZfU0hPVUxE
X01FUkdFIHwNCj4gKwkJCQkgICAgQkxLX01RX0ZfQkxPQ0tJTkc7DQo+ICAJCWRldi0+dGFnc2V0
LmRyaXZlcl9kYXRhID0gZGV2Ow0KPiAgDQo+ICAJCXJldCA9IGJsa19tcV9hbGxvY190YWdfc2V0
KCZkZXYtPnRhZ3NldCk7DQo+IA0K
