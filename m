Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA028C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714FA230F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="HgvDRa/J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="88XGu44j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfICJ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:27:04 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:21463
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728169AbfICJ1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n65pQfnmQxgt82MQnhiNYKzYQwfTrJYXUt9KPSh+WYU=;
 b=HgvDRa/JvbRTABxff6McpIxLmHffLZ/nYWgvlp5/xFGA3KDIq0ZQeUmgiyxgmx0GFyll6WjDfCAmFQTBfBo+aPen8Vsmv4Iore9hhSBGY9b9kUC96UCLOSC11XrqKU3wH3OeS3rTgI5qJuZhtnfM7dKOBSaJEts6aMxb9nRhyrs=
Received: from VI1PR0802CA0027.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::13) by VE1PR08MB4959.eurprd08.prod.outlook.com
 (2603:10a6:803:110::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.18; Tue, 3 Sep
 2019 09:26:58 +0000
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR0802CA0027.outlook.office365.com
 (2603:10a6:800:a9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.19 via Frontend
 Transport; Tue, 3 Sep 2019 09:26:57 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT047.mail.protection.outlook.com (10.152.19.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Tue, 3 Sep 2019 09:26:56 +0000
Received: ("Tessian outbound eec90fc31dfb:v27"); Tue, 03 Sep 2019 09:26:53 +0000
X-CR-MTA-TID: 64aa7808
Received: from fd0fdbad5475.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 65AD929C-DFA5-4F33-B5DE-9E10A71B2835.1;
        Tue, 03 Sep 2019 09:26:48 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fd0fdbad5475.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Sep 2019 09:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKOAK/r6Q+jDIo0pKw2K+tpkzgnNH1iO+nFa6uabeAw61Kc/XzeFovSYTlHWHkAkMPeew7gGE6+CtsUkmwWnrk5o7GCqpMYWA8PMhRM3UtBT5uGh0nvXrrMPOpPc09++jXw8AD2yDue+E1yqufNLrD2dpwmbVgfL4gm0l7BRD0p5pJFTlrjzH16tJkv1O5ugajDlvmBMNj3KUMC02IDSAhTkr/agPmNwXkT5JMJIcRr5NBqTaskd2EmukjeUP2lARgjby3rYNwgAVwy2FMU7F2O2nySMv10iA9tdYjgcTPJ8f2JaendJPDvkrxitKg6Omvm0vslh8TM6zZGYSlUdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKuDJDmZfo4O1vZixhKd4dWpEZc+DyNh5QYXMj9I0HA=;
 b=i/VaPbIAWJ0UvZgxwR+3QDcwIIoQIHDl/dd+IBiz3BIsIIDUmT9eh9UbPJ+e/nIbj0gmKRdewlTBuL+YqaNmKhj1shy5kqzpTC4kjNBGT2mDyhrODxP/V6y6t6goOKHJn+2gS8K0NpkMeQ1BciIIkHIJTc00BFAJjeWeT/Pu4VQtzB0XC37GYNE/Y19JgxJMf/L8M75sZ5IiatadvyjEKEwODLsokzog/3zlp1mQbfkGxvu2jwyIaPLClJRQvXvLaL5FIl92Hbc/M0KBPgXBkfjZQ7RO37ILBiSQTWSWDITNkQ6ZeaKCvHvpGFUGxx7HlXShYKF+D7UFItDLAdnp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKuDJDmZfo4O1vZixhKd4dWpEZc+DyNh5QYXMj9I0HA=;
 b=88XGu44jriPxDjRnsyjxwtUlNXLczsoH+JBzNcCoYvisbdPUaO6JSmtLrbnIPtrOuQk47P7lLD9RHSyx2IhFcPQsR0tHVJoUV7vRexiKKpFus1cuV3FMn5ym3EK9fSZQo/d6nF/Oo/cId7XYFRwOa8U36Hx/04XOc/t8Y9vWMA0=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3657.eurprd08.prod.outlook.com (20.177.121.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Tue, 3 Sep 2019 09:26:46 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::2121:ca3a:3068:734]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::2121:ca3a:3068:734%3]) with mapi id 15.20.2220.022; Tue, 3 Sep 2019
 09:26:46 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
CC:     Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] drivers/dax/kmem: use default numa_mem_id if
 target_node is invalid
Thread-Topic: [PATCH 1/2] drivers/dax/kmem: use default numa_mem_id if
 target_node is invalid
Thread-Index: AQHVVCRtQ1hfavY4TkeI30h0lYQpeKcZyoNw
Date:   Tue, 3 Sep 2019 09:26:46 +0000
Message-ID: <DB7PR08MB3082574FA8D63C67622C689DF7B90@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190816111844.87442-1-justin.he@arm.com>
 <20190816111844.87442-2-justin.he@arm.com>
In-Reply-To: <20190816111844.87442-2-justin.he@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: aa6eede9-a0a6-4b3b-ae39-067c15a2f39a.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 1a72fea8-df3c-4b67-85c8-08d73050dd59
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3657;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3657:|DB7PR08MB3657:|VE1PR08MB4959:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB4959547562C986F5B2153AEEF7B90@VE1PR08MB4959.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 01494FA7F7
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(13464003)(199004)(189003)(53936002)(305945005)(99286004)(26005)(64756008)(66446008)(66556008)(76176011)(478600001)(6246003)(76116006)(7696005)(6116002)(66476007)(3846002)(33656002)(71200400001)(14444005)(52536014)(446003)(229853002)(86362001)(256004)(186003)(7736002)(11346002)(71190400001)(66066001)(66946007)(2906002)(6436002)(55016002)(81166006)(486006)(8936002)(8676002)(25786009)(81156014)(55236004)(9686003)(14454004)(316002)(74316002)(6506007)(110136005)(53546011)(5660300002)(54906003)(4326008)(102836004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3657;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: LSQ+oT91NRRSr5DFcNDKk6VnzPjAAOpCXufUObKG9XbcOd+qM+A8PWLFaGMwrSQcFQgyZJIweH49IyckO2eVuGwGb2TYYMtO+/CetPTyvYyUewoSXVUrBOhtR8Zl+df7N7sG7e1jdEeb0dtUsG71uIXqji8Y+FxSouLbpcFLnk8pjWtjYfds7oQ6JUQv+a7LJ5yuAZHGXiCsWwcc08NCpJjxNNRxgGDducShq94T5W1tbDKMA3PKntpeWFeSqelR3Rwp56E0UZAqvycyKKAirtFcZcCbri5CDmaSQeDTWa8+U5M25g9/Y3J/H4A/aC2lT5hE81IgT3FpuFC/Tx8/ivO8MxTaHr6ZGkZkddhgsmPNx8wwqyK415TGqLKAy6A3LQZ0Td3fHElOrj87YgG/U7RQFdBszJE6bdjJFTdY+gY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3657
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(13464003)(189003)(199004)(40434004)(7736002)(356004)(3846002)(47776003)(23696002)(6116002)(5024004)(14444005)(47136003)(99286004)(8936002)(70586007)(14454004)(70206006)(50466002)(8676002)(478600001)(26826003)(76130400001)(6506007)(53546011)(48336001)(102836004)(22756006)(2906002)(6246003)(436003)(63350400001)(63370400001)(74316002)(110136005)(316002)(336012)(446003)(11346002)(126002)(476003)(26005)(186003)(54906003)(36906005)(55016002)(486006)(9686003)(81156014)(81166006)(66066001)(7696005)(25786009)(305945005)(52536014)(4326008)(5660300002)(229853002)(86362001)(76176011)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4959;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ef11d7e-82d6-452a-43c2-08d73050d73c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4959;
X-Forefront-PRVS: 01494FA7F7
X-Microsoft-Antispam-Message-Info: Y81nifB3m8eqn+89neYNZkEMxYc9/DB9Scbd6B5ydEiJQv33COXYeZwWFWd1/odQznna32VH6VGJutCWp7WbK8+byedypOHdKiIs7zuraj7qcfqfeRrPK6MR7Thvz6SVIMLLIECaqFo5aCa7noU+1JKZMSvZUuYTUtprZd2JR4dMGSt7lWRaYxeOMgAo4zF35VTNmw5vf1TxHZlU4xFbHERcsDLlqDroLBL6BIx9BgqU2NT8Tn4cJST5+kbztYUwFUVJnUHfimOJ22W00KjJrSyuwBMnDh3ndwvsskESxI8fy1hGO2BIPrLRAs81BGleeMCb9DQob3CRuG97SEfOLm596s2biu1hT4PzOG2+giVRL4uSXcQEgw+QYK30hgKcI5OqySNLFyA0jMw1CUk2v7rKdPhV5mjcCpntxX2yhJU=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2019 09:26:56.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a72fea8-df3c-4b67-85c8-08d73050dd59
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNClBpbmcuDQpUaGUgdGFyZ2V0X25vZGUgd2lsbCBiZSAtMSBpZiBudW1hIGRpc2FibGVkLiBJ
SVVDLCBpdCBpcyBhIGdlbmVyaWMgaXNzdWUsIG5vdCBvbmx5IG9uIGFybTY0Lg0KDQoNCi0tDQpD
aGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gU2VudDogMjAxOcTqONTC
MTbI1SAxOToxOQ0KPiBUbzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
OyBWaXNoYWwgVmVybWENCj4gPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gQ2M6IEtlaXRo
IEJ1c2NoIDxrZWl0aC5idXNjaEBpbnRlbC5jb20+OyBEYXZlIEppYW5nDQo+IDxkYXZlLmppYW5n
QGludGVsLmNvbT47IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBKdXN0aW4gSGUgKEFybSBUZWNobm9sb2d5IENoaW5hKQ0KPiA8SnVz
dGluLkhlQGFybS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGRyaXZlcnMvZGF4L2ttZW06
IHVzZSBkZWZhdWx0IG51bWFfbWVtX2lkIGlmDQo+IHRhcmdldF9ub2RlIGlzIGludmFsaWQNCj4N
Cj4gSW4gc29tZSBwbGF0Zm9ybXMoZS5nIGFybTY0IGd1ZXN0KSwgdGhlIE5GSVQgaW5mbyBtaWdo
dCBub3QgYmUgcmVhZHkuDQo+IFRoZW4gdGFyZ2V0X25vZGUgbWlnaHQgYmUgLTEuIEJ1dCBpZiB0
aGVyZSBpcyBhIGRlZmF1bHQgbnVtYV9tZW1faWQoKSwNCj4gd2UgY2FuIHVzZSBpdCB0byBhdm9p
ZCB1bm5lY2Vzc2FyeSBmYXRhbCBFSU5WTCBlcnJvci4NCj4NCj4gZGV2bV9tZW1yZW1hcF9wYWdl
cygpIGFsc28gdXNlcyB0aGlzIGxvZ2ljIGlmIG5pZCBpcyBpbnZhbGlkLCB3ZSBjYW4NCj4ga2Vl
cCB0aGUgc2FtZSBwYWdlIHdpdGggaXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8anVz
dGluLmhlQGFybS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9kYXgva21lbS5jIHwgNiArKystLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9rbWVtLmMgYi9kcml2ZXJzL2RheC9rbWVtLmMNCj4g
aW5kZXggYTAyMzE4YzZkMjhhLi5hZDYyZDU1MWQ5NGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
ZGF4L2ttZW0uYw0KPiArKysgYi9kcml2ZXJzL2RheC9rbWVtLmMNCj4gQEAgLTMzLDkgKzMzLDkg
QEAgaW50IGRldl9kYXhfa21lbV9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAgICAgICAq
Lw0KPiAgICAgICBudW1hX25vZGUgPSBkZXZfZGF4LT50YXJnZXRfbm9kZTsNCj4gICAgICAgaWYg
KG51bWFfbm9kZSA8IDApIHsNCj4gLSAgICAgICAgICAgICBkZXZfd2FybihkZXYsICJyZWplY3Rp
bmcgREFYIHJlZ2lvbiAlcFIgd2l0aCBpbnZhbGlkDQo+IG5vZGU6ICVkXG4iLA0KPiAtICAgICAg
ICAgICAgICAgICAgICAgIHJlcywgbnVtYV9ub2RlKTsNCj4gLSAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gKyAgICAgICAgICAgICBkZXZfd2FybihkZXYsICJEQVggJXBSIHdpdGggaW52
YWxpZCBub2RlLCBhc3N1bWUgaXQNCj4gYXMgJWRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlcywgbnVtYV9ub2RlLCBudW1hX21lbV9pZCgpKTsNCj4gKyAgICAgICAgICAg
ICBudW1hX25vZGUgPSBudW1hX21lbV9pZCgpOw0KPiAgICAgICB9DQo+DQo+ICAgICAgIC8qIEhv
dHBsdWcgc3RhcnRpbmcgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgbmV4dCBibG9jazogKi8NCj4g
LS0NCj4gMi4xNy4xDQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVt
YWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUg
cHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNv
bnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0
b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
