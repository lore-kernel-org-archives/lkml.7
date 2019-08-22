Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C0AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7C22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9QihJX6M";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9QihJX6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfHVNza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:55:30 -0400
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:2375
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbfHVNz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w2ogCRnNF47fYXmahqAHy6J9V0jcMM98imHwWykIBw=;
 b=9QihJX6MfkNUrWa+QPw7LkbmrJNFp2Oai/4yAWjU7NXzFJ1i4uOiHKL00oihYblzfeBWrhQg2F597tpAm2fx878M0m20ECfA8B/mhg/LA/q5U7nnYrW30R+qWGgSgfxNSD29tyFepLXNXnGdNksVN9pqq2oLSg3gtq1gAqIRWyw=
Received: from VI1PR08CA0132.eurprd08.prod.outlook.com (2603:10a6:800:d4::34)
 by AM5PR0801MB1844.eurprd08.prod.outlook.com (2603:10a6:203:39::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 22 Aug
 2019 13:55:24 +0000
Received: from VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0132.outlook.office365.com
 (2603:10a6:800:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16 via Frontend
 Transport; Thu, 22 Aug 2019 13:55:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT024.mail.protection.outlook.com (10.152.18.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.13 via Frontend Transport; Thu, 22 Aug 2019 13:55:22 +0000
Received: ("Tessian outbound 0c23f37acac0:v27"); Thu, 22 Aug 2019 13:55:22 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7c26a6728fa23364
X-CR-MTA-TID: 64aa7808
Received: from 752643bbcf4c.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 10C8200B-5C81-4B73-A5FF-801D4E6D7C8A.1;
        Thu, 22 Aug 2019 13:55:17 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2059.outbound.protection.outlook.com [104.47.10.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 752643bbcf4c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Thu, 22 Aug 2019 13:55:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtnFtbtfRFYpOgTWiKy6U6Stsw7/HcZm2EZxHsUdtwP8/rPmUXRtEMsMgnp2mnNSs49/AtkAKxuDCUz0pmXEi2H3fCuYYtfJoconsVS074wX63A98zgnng+AErFF7ILxaPInCxWzCjbmn5/XEwVM/DYQRakftwWrP7uI0Tf41Sm2uK0ahogLsB1CSdc7z2UHRb9fdrnWXETDZXRa17DzAuY5qgGesqFXgtbQYv7xxsnHLAo0B/sB0qpwoE6+mG//E02UbtWOb5nUR/4Nbe9bRMTjhSC4l8LWt5ceEw/LIuBjgpHY3lIbz3WKAjDR6dJvYlbiwz+vbuxjEYmE215eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w2ogCRnNF47fYXmahqAHy6J9V0jcMM98imHwWykIBw=;
 b=EjiGT/iKvPGFk8MoBWu2YE45wrkPuXQwRWEkWJ7QYGFUSZiEQQlPVzoULegVYW/C/yEMFzWWoKD/PMNQHuhTKr+hKnV2UwuTtzzM8qF77Y/SwLt6gWefxcnavONLKR2sdhiW8BKK+Lo+EvgOyI7j0LXaTErft+nE1R0d/XfTVgIwgswjZZnN+Xq7QacaeZ70B5YRq7QlHggVQrRChKqSv27VSxIdlyakJ16asa1RbUjK1/OdwSzHDwMEwN7K8hRpJ2ofwNBtbzaWuQz5uiAzRQCXJ5mUNXnqCieYXZeQcZSl9zjXlsiSBN8ZFmg9WJkgyelD68Eyg8OgeWblsRuKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9w2ogCRnNF47fYXmahqAHy6J9V0jcMM98imHwWykIBw=;
 b=9QihJX6MfkNUrWa+QPw7LkbmrJNFp2Oai/4yAWjU7NXzFJ1i4uOiHKL00oihYblzfeBWrhQg2F597tpAm2fx878M0m20ECfA8B/mhg/LA/q5U7nnYrW30R+qWGgSgfxNSD29tyFepLXNXnGdNksVN9pqq2oLSg3gtq1gAqIRWyw=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2178.eurprd08.prod.outlook.com (10.172.215.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 13:55:15 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::f482:c808:6949:f621]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::f482:c808:6949:f621%11]) with mapi id 15.20.2178.020; Thu, 22 Aug
 2019 13:55:15 +0000
From:   James Clark <James.Clark@arm.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: [PATCH] Fixes hang in zstd compression test by changing the source of
 random data.
Thread-Topic: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Thread-Index: AQHVWPE5BgyJABV5fEmO3uRqTui+jQ==
Date:   Thu, 22 Aug 2019 13:55:15 +0000
Message-ID: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P265CA0453.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::33) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fbfdec86-6f05-40ae-a451-08d727086098
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR0802MB2178;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2178:|AM5PR0801MB1844:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1844DF52AE1CE2C81BDB9447E2A50@AM5PR0801MB1844.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2958;OLM:2958;
x-forefront-prvs: 01371B902F
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(189003)(199004)(6116002)(31696002)(316002)(3846002)(99286004)(2906002)(31686004)(2501003)(36756003)(110136005)(52116002)(4744005)(6512007)(86362001)(66476007)(478600001)(476003)(14454004)(44832011)(2616005)(53936002)(486006)(8936002)(66446008)(71190400001)(64756008)(71200400001)(8676002)(66946007)(66556008)(6486002)(186003)(102836004)(6506007)(2201001)(26005)(14444005)(256004)(386003)(305945005)(81166006)(4326008)(5660300002)(66066001)(81156014)(7736002)(54906003)(6436002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2178;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 3JDv1qyK8yh3tXqlt9K153HO+sXGL5OZMN0Cq+P12rAQNixeUDpaEWCk5aCwOpkCs0vfg7BrGQN8dsrc+/SN6DTIzBBqPOK+LBpcwqj2kpCO6449kxJgYrHc8lFyupDavfAJJcYgPV/kfLL5E+QDHsOXu80O7f9Zon+wl3wRdBuRaKkF8mh07s8zhjuw4dwdC5xhaxpiCyWX3SirblSj7Hmw2Cy7RORTtgqC0J1xDGIZwoFl0NeqbT3yqhM/wAeTW7EoaJ0uWcFla6I6mHTev09GLsqKGJMAIocqtr5GR97Q0WdBqTfO+fWbDxuJYNT4zO2N6gILs6c78ntNAE5+2zCHlU08/JLHLMsXnX8ItnIRqQgD+ln90bo9mdlslqbYcenDgmNpyjJYmbOCh6BJNvPu1VPTiMqjgvlUSc2Xft0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <447EEAA9459EB547B3B9A406E27F76C0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2178
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT024.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39850400004)(376002)(2980300002)(199004)(189003)(99286004)(76130400001)(22756006)(50466002)(356004)(476003)(126002)(54906003)(110136005)(26826003)(4744005)(2501003)(486006)(186003)(5660300002)(316002)(36906005)(6512007)(31686004)(26005)(102836004)(6506007)(386003)(70586007)(6486002)(2486003)(23676004)(70206006)(14454004)(305945005)(81166006)(81156014)(63370400001)(63350400001)(436003)(478600001)(66066001)(31696002)(450100002)(47776003)(336012)(25786009)(86362001)(8936002)(2906002)(4326008)(2616005)(36756003)(8676002)(6116002)(3846002)(2201001)(14444005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1844;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: bea086e7-e922-4c25-49b2-08d727085bc5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0801MB1844;
NoDisclaimer: True
X-Forefront-PRVS: 01371B902F
X-Microsoft-Antispam-Message-Info: c4w2efT6CgpJB4OcXQqG/uYUH9cxS+qiuJvVjv+jzgCDq/CeMQQEsBmb845AJD0QCI4sHmrJp51azACFs97LKqd0ej7dZhBZzqPIF1dqoesbuXPsZuJdDQBEtmZUkYXYdo9O21gs5kpptK2zZ1tUDvD+VQ6SD8wOnNcujv3yMPBO1xA+YHuXA3N8cSr1xLq9Gk+/Bp2t01Se7gg5SnpmLij6EGDbp5VSACTVMwZ+sS/nZrCvaBpFwEkvDRGslgtdI8Nf8WvzcFl1Nqvt3GV/uY/RDaKHIFj4q+C1QwUoZzgNl5+c+DH+hVUCoTJP739CfrDMCzDwG72m3NJUW54CUqBN2GOgQz9bq9ZlNIfaaxF9JVJSIrOsoWnZXokp9EYTdKyPersUmoVk+BfztHJwHcl8HoJbsXVElqZE/9dpitc=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2019 13:55:22.8140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfdec86-6f05-40ae-a451-08d727086098
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UnVubmluZyAncGVyZiB0ZXN0JyB3aXRoIHpzdGQgY29tcHJlc3Npb24gbGlua2VkIHdpbGwgaGFu
ZyBhdCB0aGUgdGVzdA0KJ1pzdGQgcGVyZi5kYXRhIGNvbXByZXNzaW9uL2RlY29tcHJlc3Npb24n
IGJlY2F1c2UgL2Rldi9yYW5kb20gYmxvY2tzDQpyZWFkcyB1bnRpbCB0aGVyZSBpcyBlbm91Z2gg
ZW50cm9weS4gVGhpcyBtZWFucyB0aGF0IHRoZSB0ZXN0IHdpbGwNCmFwcGVhciB0byBuZXZlciBj
b21wbGV0ZSB1bmxlc3MgdGhlIG1vdXNlIGlzIGNvbnRpbnVhbGx5IG1vdmVkIHdoaWxlDQpydW5u
aW5nIGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW1lcyBDbGFyayA8amFtZXMuY2xhcmtAYXJtLmNv
bT4NCi0tLQ0KIHRvb2xzL3BlcmYvdGVzdHMvc2hlbGwvcmVjb3JkK3pzdGRfY29tcF9kZWNvbXAu
c2ggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQoNCmRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3JlY29yZCt6c3RkX2NvbXBf
ZGVjb21wLnNoIGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9yZWNvcmQrenN0ZF9jb21wX2RlY29t
cC5zaA0KaW5kZXggODk5NjA0ZDEuLjYzYTkxZWMgMTAwNzU1DQotLS0gYS90b29scy9wZXJmL3Rl
c3RzL3NoZWxsL3JlY29yZCt6c3RkX2NvbXBfZGVjb21wLnNoDQorKysgYi90b29scy9wZXJmL3Rl
c3RzL3NoZWxsL3JlY29yZCt6c3RkX2NvbXBfZGVjb21wLnNoDQpAQCAtMTMsNyArMTMsNyBAQCBz
a2lwX2lmX25vX3pfcmVjb3JkKCkgew0KIGNvbGxlY3Rfel9yZWNvcmQoKSB7DQogCWVjaG8gIkNv
bGxlY3RpbmcgY29tcHJlc3NlZCByZWNvcmQgZmlsZToiDQogCSRwZXJmX3Rvb2wgcmVjb3JkIC1v
ICR0cmFjZV9maWxlIC1nIC16IC1GIDUwMDAgLS0gXA0KLQkJZGQgY291bnQ9NTAwIGlmPS9kZXYv
cmFuZG9tIG9mPS9kZXYvbnVsbA0KKwkJZGQgY291bnQ9NTAwIGlmPS9kZXYvdXJhbmRvbSBvZj0v
ZGV2L251bGwNCiB9DQogDQogY2hlY2tfY29tcHJlc3NlZF9zdGF0cygpIHsNCi0tIA0KMi43LjQN
Cg0K
