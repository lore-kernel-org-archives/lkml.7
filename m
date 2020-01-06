Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17741C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D042146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k3aXAXZ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="D4u0+d02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgAFSKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:10:06 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:50434 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgAFSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:10:05 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6EF0542D6F;
        Mon,  6 Jan 2020 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578334204; bh=eLJYuBzZL5UA8EQFt/BP/OSFS/vpuEQ/MnjX46lEYNo=;
        h=From:To:CC:Subject:Date:From;
        b=k3aXAXZ3ZA3m4iNX53OGGIxmzxmtysNGC2zeOcU4czxm9zxl7aeiPvRwTJuqaU7eN
         vU+qv1Ob+e+FLzrW38IttgLQNkGESGlOpANZFQUNm7BIu6mzhuy+8MNYF5Q3jZ5qpa
         9n4CTNU73aUM4lnJmztsGsB3+BSvCsVU92R2XUJ84DZiiMVk42JCogF0uW6ne4LxJ8
         h066GXp4aJ+d/30EA27Ykluup5bIDaQSZvVFMFNcGoK4UgLzzBa8aN2VrAdTL4HuMN
         bWPqIkoTagZzw1KqUNwy372YkEZe3Oa3jwVcDhKspxOY6StBvhEsdeAjOEoCgyN0eP
         b9RcB20ZQcW3Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1C920A006A;
        Mon,  6 Jan 2020 18:09:49 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 6 Jan 2020 10:09:41 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 6 Jan 2020 10:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDkYFeP4ysjGBN5bzmUby+Q4YxhLrKwMpbZ/EAmNEzg9S1S1fWTVltorQWHSRI5UigmKxzdVuEw3b/2QkNJiGyR440lGoP3Y3CXBww0FSooPZs25pvVnr3nHHPxT/DPdpOLnJGvNTCBJ1EfO3Ia2pxs0iotefOFS31IEN29wpC1VpnMvH1gE4zw3p9VIULzesjU7Ww2illqhMGBg+tL7eAOrP6v8VA1N+n7GThQOwW5iQTXgzgZtVJaRM7CAnLue/0U3q6qVHjMaeuB8sWHRzyBtR4nSPIAEIpg/4bkbtnmHW541qkt3kHqaHAqxY+IN4tSvVyArdRdx9F4FaFDoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLJYuBzZL5UA8EQFt/BP/OSFS/vpuEQ/MnjX46lEYNo=;
 b=OvXwk5W8QOuCOJ0o9tlUrdUhIKBZThVWkmYIfMZaYV00TknWPe9ZBJJ9Ec4IkG1oIcBlsVsFPIKRkk4Gx3nMmMdGXw0MEvlpiKpnQinFIxz1nye1HbYtmus4kmXCN5ubt9HXYzVxsT5T41L1xWDBSCJ8MV8PBzzPgtTiwTV2B8iJqPBpbxsCRmTzyyyYRk63x8qhz2y6mzJW7xGSmCtrK5q5R568JKvXE1UbXQBOEoAeq1373hidjExGGLBQNuQiV5P75zWKVYCmFlhHs6dFM3c61EdX6PCrktpYTBlZeak/YNjCYXyB4aQ9q23YsgEra5RroQkVONptsInNYELYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLJYuBzZL5UA8EQFt/BP/OSFS/vpuEQ/MnjX46lEYNo=;
 b=D4u0+d029bmM0lJE4Ej9iyq3+ZrHPoDpWUt2pgz0eb0NB6HC7p8TTwFs+e+qTJvBjf/7P4qwKDzz2aPy0H0mqmpnGSW5vvaUdVl+lVO6uXC+Py86zapLCCOrwvPBDEH8NQn/fRZLkovi+TP54fLCQgo7inY3wzjx+6HtoFY+HkE=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB3495.namprd12.prod.outlook.com (20.178.197.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 18:09:39 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 18:09:39 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.5-rc6
Thread-Topic: [GIT PULL] ARC updates for 5.5-rc6
Thread-Index: AQHVxLx2GJONL5CMbkOw1UV1gvQN+A==
Date:   Mon, 6 Jan 2020 18:09:39 +0000
Message-ID: <9907df0c-6996-1a6b-0cf1-0dbfcb8ea414@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16d565d9-b30e-4637-89c5-08d792d398c6
x-ms-traffictypediagnostic: BYAPR12MB3495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3495198D75D0ACA935CD2654B63C0@BYAPR12MB3495.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(189003)(199004)(6506007)(6512007)(26005)(71200400001)(4001150100001)(4326008)(2616005)(107886003)(81156014)(186003)(8936002)(81166006)(8676002)(66946007)(76116006)(66476007)(66556008)(64756008)(66446008)(36756003)(31686004)(478600001)(86362001)(2906002)(5660300002)(54906003)(6486002)(316002)(6916009)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3495;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6x43Pz/hwQOvmg6ObW/cS9b0aZIdc/DIfdQ06vyKGoKuMQyTpRXUplUpoay6cIY9s185gZzilpl6o804mv/T6ndxrUHI/DIWADxVtHJjvh9V8NtPOSpucCnJC+36xvQSPtFzeDbELAcFOBieYh+fJOZlIL/NpYswjRh7R+Fcty4Pzd9NPV0PshStR6E/tE9ZI3YhD97rpN7Kuxjce2A5x8yYsjvDYZi+lGUkRJjxlrzSYYZ4rtk3+08Pd26lJG66JTyVgogbJFExeWPCHuLNQBTHRB8KKTGkZDDPHQVV4NoisXr6xobC1B1Ek+OC8Ej7p4J3eQQXrPbSgTpX7iO6SosPXMLNacahnFNzdfDuzW+LM+8Eel9MFuO/8yslrVqUrkzBCUvzRpkKpclLVKs43+plejmIAWPRHRnlMfUmMJHHhWXFL4OJ3q4ZB/s+u+5O
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFA12D285CBFF47BAF4DB8D6DE76124@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d565d9-b30e-4637-89c5-08d792d398c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 18:09:39.4158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEi7b/q8sNiJ0U0t4lr8LGip9vkGU76F8C7YtA/RJdL7/EbICnLns+akPWm0F2gp7DRBDXsHQnEUW6hnTHrjxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3495
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkhhcHB5IE5ldyBZZWFyLiBQbGVhc2UgcHVsbCBBUkMgZml4ZWQgZm9yIDUu
NS1yYzYuDQoNClRoeCwNCi1WaW5lZXQNCg0KLS0tLS0tLS0tLS0tLS0tLS0+DQpUaGUgZm9sbG93
aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGU0MjYxN2I4MjVmODA3MzU2OWRhNzZkYzQ1MTBiZmEw
MTliMWMzNWE6DQoNCsKgIExpbnV4IDUuNS1yYzEgKDIwMTktMTItMDggMTQ6NTc6NTUgLTA4MDAp
DQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQrCoCBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIHRh
Z3MvYXJjLTUuNS1yYzYNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDdlY2M2YzFk
NWM4ZGJjNzEzYzY0NzUxMmE1MjY3Y2EwZWFmZTNlMWM6DQoNCsKgIEFSQzogcHRfcmVnczogcmVt
b3ZlIGhhcmRjb2RlZCByZWdpc3RlcnMgb2Zmc2V0ICgyMDE5LTEyLTI4IDEzOjA1OjA4IC0wODAw
KQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpBUkMgZml4ZXMgZm9yIHY1LjUtcmM2DQoNCsKgLSBLY29uZmlnIHdhcm5p
bmcsIHN0YWxlIGRlZmluZSwgZHVwbGljYXRlIGFzbS1vZmZzZXQgZW50cnkgLi4uDQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkV1Z2VuaXkgUGFsdHNldiAoMik6DQrCoMKgwqDCoMKgIEFSQzogYXNtLW9mZnNldHM6IHJl
bW92ZSBkdXBsaWNhdGUgZW50cnkNCsKgwqDCoMKgwqAgQVJDOiBwdF9yZWdzOiByZW1vdmUgaGFy
ZGNvZGVkIHJlZ2lzdGVycyBvZmZzZXQNCg0KTWlrZSBSYXBvcG9ydCAoMSk6DQrCoMKgwqDCoMKg
IEFSQzogbW06IGRyb3Agc3RhbGUgZGVmaW5lIG9mIF9fQVJDSF9VU0VfNUxFVkVMX0hBQ0sNCg0K
UmFuZHkgRHVubGFwICgxKToNCsKgwqDCoMKgwqAgYXJjOiBlem5wczogZml4IGFsbG1vZGNvbmZp
ZyBrY29uZmlnIHdhcm5pbmcNCg0KwqBhcmNoL2FyYy9pbmNsdWRlL2FzbS9lbnRyeS1hcmN2Mi5o
IHzCoCA4ICsrKystLS0tDQrCoGFyY2gvYXJjL2luY2x1ZGUvYXNtL2h1Z2VwYWdlLmjCoMKgwqAg
fMKgIDEgLQ0KwqBhcmNoL2FyYy9rZXJuZWwvYXNtLW9mZnNldHMuY8KgwqDCoMKgwqAgfCAxMCAr
KysrKysrKystDQrCoGFyY2gvYXJjL3BsYXQtZXpucHMvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgIHzC
oCAyICstDQrCoDQgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkNCg==
