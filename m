Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5194ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E2720835
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3cyEvYmh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="3cyEvYmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfJHBzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:55:33 -0400
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:65167
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbfJHBzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyNo5Bc7lrDxAv2BZZXJU2XzVBZr/nI/mBhlXkRJB74=;
 b=3cyEvYmh57RRaPZWjon2UQ8317/U+BooNxZw05tsrd24/eUvqVlGSHxq+1sQoxCPM8HOGZrnU5aFgLl/N8GmFSSReCkOB4y7yKFyPICUOyxrL+S1vSSJUTqOae+Nm+7Jpr59YZnJ/itmGdrcnCIPMlDjwWxNRZUANKC1zR4I5wc=
Received: from VI1PR08CA0249.eurprd08.prod.outlook.com (2603:10a6:803:dc::22)
 by VI1PR0801MB2112.eurprd08.prod.outlook.com (2603:10a6:800:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24; Tue, 8 Oct
 2019 01:55:24 +0000
Received: from VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::203) by VI1PR08CA0249.outlook.office365.com
 (2603:10a6:803:dc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.23 via Frontend
 Transport; Tue, 8 Oct 2019 01:55:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT035.mail.protection.outlook.com (10.152.18.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Tue, 8 Oct 2019 01:55:21 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Tue, 08 Oct 2019 01:55:13 +0000
X-CR-MTA-TID: 64aa7808
Received: from b176a3277a75.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.9.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 54B53FAA-71BE-4F47-946D-D693ED3FAF4F.1;
        Tue, 08 Oct 2019 01:55:08 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b176a3277a75.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 08 Oct 2019 01:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkpOmVvBMj1jxouk06GhmvN6dy0Kff/GhEM04fAMeorbnslnpywPFMahqr4GJoxoO8zK2A1glyQsvY2sI53njh7AgX1FzU63oHRM6iYZ9V5YyEPViubkwYLoSC271X3+5V8Mu6vOuee4/k14y4RIhkhTgWBv2p566pKQYLg7dqDVF94j2ajTE9TJamFcYPDoJwzvK3Njpou39BAHXBJnTqXxnncHY9wRwAoRuBEMRtQhiafrCuawq8Q/snAposi5yrkTPcAtFZ4RtvgzM1PuSOowzOGEwGwNq47EQUR4Oj/RlAUZAT+nySTREVGTp+NFIFQjGGI1Y9sreLb79ZzJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyNo5Bc7lrDxAv2BZZXJU2XzVBZr/nI/mBhlXkRJB74=;
 b=Eo4wdBorC9X//dCiOZT94ZOBrt6VeIjHdZWxReBZJpbDgBE5TZwpP7Ml0P7J57hLZ14QftLuT/GXUAMK+mfOUKHfRo/mJxdO7RDl6+vY0q+5nrQmxrEAOpxWs1+fWR0JpPX6HCpXXNhF0VDvybCzZq3aco7cLd2clOCpgbat5ScW5eHHJTlyUrezdKYU/c1h38v5hdduDo7HfCY8pH0bikwkbO5AXbnfILsd3N5nGZ9Pjc7SNfdk9Jrg8m2+DKL37xLnR1vzgC9Y583Ha8aeH68KqcV0ufEKjyzQ7vlWuKXDSdL08Ec0a9q2f/HdCrj99BC4JLFXQeuon+G2PIhzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyNo5Bc7lrDxAv2BZZXJU2XzVBZr/nI/mBhlXkRJB74=;
 b=3cyEvYmh57RRaPZWjon2UQ8317/U+BooNxZw05tsrd24/eUvqVlGSHxq+1sQoxCPM8HOGZrnU5aFgLl/N8GmFSSReCkOB4y7yKFyPICUOyxrL+S1vSSJUTqOae+Nm+7Jpr59YZnJ/itmGdrcnCIPMlDjwWxNRZUANKC1zR4I5wc=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3404.eurprd08.prod.outlook.com (20.177.121.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.23; Tue, 8 Oct 2019 01:55:04 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::f9f9:ad51:6636:42f0%6]) with mapi id 15.20.2327.023; Tue, 8 Oct 2019
 01:55:04 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Thread-Topic: [PATCH v10 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Thread-Index: AQHVdzKGx1YzEK84qECDJFJMWK8dTqdFvzkAgAALrYCACjIy4A==
Date:   Tue, 8 Oct 2019 01:55:04 +0000
Message-ID: <DB7PR08MB308265EB3ED2465D2471B492F79A0@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190930015740.84362-1-justin.he@arm.com>
        <20190930015740.84362-3-justin.he@arm.com>
        <20191001125031.7ddm5dlwss6m3dth@willie-the-truck>
 <20191001143219.018281be@why>
In-Reply-To: <20191001143219.018281be@why>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: fdf33e25-d274-46d6-909d-7dcfd327ee25.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 0d8419cf-c184-4ec3-b32c-08d74b9293d1
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: DB7PR08MB3404:|DB7PR08MB3404:|VI1PR0801MB2112:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB2112B994AEA62600B79E0EBCF79A0@VI1PR0801MB2112.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 01842C458A
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(13464003)(199004)(189003)(66446008)(2906002)(102836004)(76116006)(4326008)(64756008)(229853002)(66946007)(11346002)(486006)(256004)(14444005)(66556008)(66476007)(6246003)(3846002)(476003)(6436002)(6116002)(86362001)(9686003)(66066001)(186003)(6306002)(26005)(55016002)(446003)(55236004)(6506007)(53546011)(305945005)(8936002)(7416002)(7696005)(76176011)(110136005)(99286004)(25786009)(966005)(33656002)(5660300002)(71200400001)(478600001)(52536014)(74316002)(54906003)(14454004)(71190400001)(8676002)(81156014)(7736002)(316002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3404;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NN6wi+8zqm4PGN+FXz7E3N5S75V+QCqGGDf8Zt3S0/DUZRRSHisH0q8u9fc9fkR0dbc24r0L6pneRrb5JADNVYkDf6KaV45j5uWdarn4HQoxYWxks8DllqUJmqOYWOlw9C2roBrIv/qJraw51c/U3/NSzXCojnGgqkjJfZ1WERxkIN8A+4FXk7yrIknwKvS8P31W9dNDW5P1KDTb33Kzmu+AJcAe0AzEqGk0ZppejMTM75YlJBsfVsY/VqN5/eSMWfjKnmhTc1IoUuGdTODobz7IDWSjqCZoB5ovSLERbKsnOW1nhBTnSl8TbPPhjJ/f9BFjbhBDk5S+fpJodkMR66IsUyCdJ7MEpFf3rsOL6nJuGKCygpCEomkHQpQdkGBT+oyiFNeGcYKipJmliYZYRpFrx51SDcBh8GHoQzZowMQXhzMrWp5Hcv3voQanSKPvsEt4fPR597+OvPThbByLxA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3404
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(13464003)(199004)(189003)(9686003)(25786009)(6246003)(486006)(50466002)(52536014)(446003)(14444005)(229853002)(476003)(76130400001)(126002)(8936002)(23696002)(33656002)(48336001)(186003)(7696005)(99286004)(14454004)(55016002)(102836004)(63350400001)(6306002)(336012)(966005)(53546011)(26826003)(6506007)(11346002)(4326008)(26005)(356004)(478600001)(76176011)(436003)(22756006)(305945005)(74316002)(47136003)(7736002)(86362001)(70586007)(316002)(8676002)(54906003)(81166006)(81156014)(110136005)(47776003)(70206006)(3846002)(66066001)(2906002)(5660300002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB2112;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 470be971-c57a-4ccd-a9ce-08d74b9289ec
NoDisclaimer: True
X-Forefront-PRVS: 01842C458A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEvi8YK5A0lQXGueNHeuaDk4kYpLU4G54cCPPwLsQ/PItMHKKi/RNLkVBkWAQt5KwuuZ/09hVcLU+V1owXacHhrqqaSg4SXUGcfOUJBFgY3dwA67a3tAnZHfejI0WsASHniqgSxLoahnvcw4zcSv4FQZfikJxi1RBShdl7+pmqhZMhdOWbqVgVdd1gHHjxqrKwnNGa7BM6HzZuwcUYPf811isjg/Pii4FnxGyY6g/EeC9KvHqvd5u6g8NGVXh6AEhxBIXJlEzODwVceqMaMMVBTQcVr8Hhivw7RGqumXNTbcHRS0JozEovBY/WwmCs+kdpIc0Rm1rC8QEeSCt01VWG/uxyvMpZwwJH3kzMfGb5bZsBHQSqGVZ6eakdC4n5HEq+rvAo/kETGJZplSpo7TAxhQ2oKZVM+ahJzK1hoypc9kGpNhm6YrFkY8mHgAY+yVDqzleCiOv9JuTv9C2as+1A==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 01:55:21.2445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8419cf-c184-4ec3-b32c-08d74b9293d1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2lsbCBhbmQgTWFyYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMTnE6jEw1MIxyNUgMjE6
MzINCj4gVG86IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+IENjOiBKdXN0aW4gSGUg
KEFybSBUZWNobm9sb2d5IENoaW5hKSA8SnVzdGluLkhlQGFybS5jb20+OyBDYXRhbGluDQo+IE1h
cmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgTWFyayBSdXRsYW5kDQo+IDxNYXJrLlJ1
dGxhbmRAYXJtLmNvbT47IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsNCj4gTWF0
dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+OyBLaXJpbGwgQS4gU2h1dGVtb3YNCj4g
PGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1t
QGt2YWNrLm9yZzsgUHVuaXQgQWdyYXdhbA0KPiA8cHVuaXRhZ3Jhd2FsQGdtYWlsLmNvbT47IFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsNCj4gQW5kcmV3IE1vcnRvbiA8YWtw
bUBsaW51eC1mb3VuZGF0aW9uLm9yZz47IGhlamlhbmV0QGdtYWlsLmNvbTsgS2FseQ0KPiBYaW4g
KEFybSBUZWNobm9sb2d5IENoaW5hKSA8S2FseS5YaW5AYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MTAgMi8zXSBhcm02NDogbW06IGltcGxlbWVudA0KPiBhcmNoX2ZhdWx0c19vbl9v
bGRfcHRlKCkgb24gYXJtNjQNCj4gDQo+IE9uIFR1ZSwgMSBPY3QgMjAxOSAxMzo1MDozMiArMDEw
MA0KPiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+ID4gT24gTW9u
LCBTZXAgMzAsIDIwMTkgYXQgMDk6NTc6MzlBTSArMDgwMCwgSmlhIEhlIHdyb3RlOg0KPiA+ID4g
T24gYXJtNjQgd2l0aG91dCBoYXJkd2FyZSBBY2Nlc3MgRmxhZywgY29weWluZyBmcm9tdXNlciB3
aWxsIGZhaWwNCj4gYmVjYXVzZQ0KPiA+ID4gdGhlIHB0ZSBpcyBvbGQgYW5kIGNhbm5vdCBiZSBt
YXJrZWQgeW91bmcuIFNvIHdlIGFsd2F5cyBlbmQgdXAgd2l0aA0KPiB6ZXJvZWQNCj4gPiA+IHBh
Z2UgYWZ0ZXIgZm9yaygpICsgQ29XIGZvciBwZm4gbWFwcGluZ3MuIHdlIGRvbid0IGFsd2F5cyBo
YXZlIGENCj4gPiA+IGhhcmR3YXJlLW1hbmFnZWQgYWNjZXNzIGZsYWcgb24gYXJtNjQuDQo+ID4g
Pg0KPiA+ID4gSGVuY2UgaW1wbGVtZW50IGFyY2hfZmF1bHRzX29uX29sZF9wdGUgb24gYXJtNjQg
dG8gaW5kaWNhdGUgdGhhdCBpdA0KPiBtaWdodA0KPiA+ID4gY2F1c2UgcGFnZSBmYXVsdCB3aGVu
IGFjY2Vzc2luZyBvbGQgcHRlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEppYSBIZSA8
anVzdGluLmhlQGFybS5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogQ2F0YWxpbiBNYXJpbmFzIDxj
YXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFyY2gvYXJtNjQvaW5j
bHVkZS9hc20vcGd0YWJsZS5oIHwgMTQgKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0
YWJsZS5oDQo+ID4gPiBpbmRleCA3NTc2ZGYwMGViNTAuLmU5NmZiODJmNjJkZSAxMDA2NDQNCj4g
PiA+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ID4gPiArKysgYi9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+ID4gQEAgLTg4NSw2ICs4ODUsMjAg
QEAgc3RhdGljIGlubGluZSB2b2lkIHVwZGF0ZV9tbXVfY2FjaGUoc3RydWN0DQo+IHZtX2FyZWFf
c3RydWN0ICp2bWEsDQo+ID4gPiAgI2RlZmluZSBwaHlzX3RvX3R0YnIoYWRkcikJKGFkZHIpDQo+
ID4gPiAgI2VuZGlmDQo+ID4gPg0KPiA+ID4gKy8qDQo+ID4gPiArICogT24gYXJtNjQgd2l0aG91
dCBoYXJkd2FyZSBBY2Nlc3MgRmxhZywgY29weWluZyBmcm9tIHVzZXIgd2lsbCBmYWlsDQo+IGJl
Y2F1c2UNCj4gPiA+ICsgKiB0aGUgcHRlIGlzIG9sZCBhbmQgY2Fubm90IGJlIG1hcmtlZCB5b3Vu
Zy4gU28gd2UgYWx3YXlzIGVuZCB1cA0KPiB3aXRoIHplcm9lZA0KPiA+ID4gKyAqIHBhZ2UgYWZ0
ZXIgZm9yaygpICsgQ29XIGZvciBwZm4gbWFwcGluZ3MuIFdlIGRvbid0IGFsd2F5cyBoYXZlIGEN
Cj4gPiA+ICsgKiBoYXJkd2FyZS1tYW5hZ2VkIGFjY2VzcyBmbGFnIG9uIGFybTY0Lg0KPiA+ID4g
KyAqLw0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKHZv
aWQpDQo+ID4gPiArew0KPiA+ID4gKwlXQVJOX09OKHByZWVtcHRpYmxlKCkpOw0KPiA+ID4gKw0K
PiA+ID4gKwlyZXR1cm4gIWNwdV9oYXNfaHdfYWYoKTsNCj4gPiA+ICt9DQo+ID4NCj4gPiBEb2Vz
IHRoaXMgd29yayBjb3JyZWN0bHkgaW4gYSBLVk0gZ3Vlc3Q/IChpLmUuIGlzIHRoZSBNTUZSIHNh
bml0aXNlZCBpbg0KPiB0aGF0DQo+ID4gY2FzZSwgZGVzcGl0ZSBub3QgYmVpbmcgdGhlIGNhc2Ug
b24gdGhlIGhvc3Q/KQ0KPiANCj4gWXVwLCBhbGwgdGhlIDY0Yml0IE1NRlJzIGFyZSB0cmFwcGVk
IChIQ1JfRUwyLlRJRDMgaXMgc2V0IGZvciBhbg0KPiBBQXJjaDY0IGd1ZXN0KSwgYW5kIHdlIHJl
dHVybiB0aGUgc2FuaXRpc2VkIHZlcnNpb24uDQpUaGFua3MgZm9yIE1hcmMncyBleHBsYW5hdGlv
bi4gSSB2ZXJpZmllZCB0aGUgcGF0Y2ggc2VyaWVzIG9uIGEga3ZtIGd1ZXN0ICgtTSB2aXJ0KQ0K
d2l0aCBzaW11bGF0ZWQgbnZkaW1tIGRldmljZSBjcmVhdGVkIGJ5IHFlbXUuIFRoZSBob3N0IGlz
IFRodW5kZXJYMiBhYXJjaDY0Lg0KDQo+IA0KPiBCdXQgdGhhdCdzIGFuIGludGVyZXN0aW5nIHJl
bWFyazogd2UncmUgbm93IHRyYWRpbmcgYW4gZXh0cmEgZmF1bHQgb24NCj4gQ1BVcyB0aGF0IGRv
IG5vdCBzdXBwb3J0IEhXQUZEQlMgZm9yIGEgZ3VhcmFudGVlZCB0cmFwIGZvciBlYWNoIGFuZA0K
PiBldmVyeSBndWVzdCB1bmRlciB0aGUgc3VuIHRoYXQgd2lsbCBoaXQgdGhlIENPVyBwYXRoLi4u
DQo+IA0KPiBNeSBndXQgZmVlbGluZyBpcyB0aGF0IHRoaXMgaXMgZ29pbmcgdG8gYmUgcHJldHR5
IHZpc2libGUuIEppYSwgZG8geW91DQo+IGhhdmUgYW55IG51bWJlcnMgZm9yIHRoaXMga2luZCBv
ZiBiZWhhdmlvdXI/DQpJdCBpcyBub3QgYSBjb21tb24gQ09XIHBhdGgsIGJ1dCBhIENPVyBmb3Ig
UEZOIG1hcHBpbmcgcGFnZXMgb25seS4NCkkgYWRkIGEgZ19jb3VudGVyIGJlZm9yZSBwdGVfbWt5
b3VuZyBpbiBmb3JjZV9ta3lvdW5ne30gd2hlbiB0ZXN0aW5nIA0Kdm1tYWxsb2NfZm9yayBhdCBb
MV0uDQoNCkluIHRoaXMgdGVzdCBjYXNlLCBpdCB3aWxsIHN0YXJ0IE0gZm9yayBwcm9jZXNzZXMg
YW5kIE4gcHRocmVhZHMuIFRoZSBkZWZhdWx0IGlzDQpNPTIsTj00LiB0aGUgZ19jb3VudGVyIGlz
IGFib3V0IDI0MSwgdGhhdCBpcyBpdCB3aWxsIGhpdCBteSBwYXRjaCBzZXJpZXMgZm9yIDI0MQ0K
dGltZXMuDQpJZiBJIHNldCBNPTIwIGFuZCBOPTQwIGZvciBURVNUMywgdGhlIGdfY291bnRlciBp
cyBhYm91dCAxNDkyLg0KICANClsxXSBodHRwczovL2dpdGh1Yi5jb20vcG1lbS9wbWRrL3RyZWUv
bWFzdGVyL3NyYy90ZXN0L3ZtbWFsbG9jX2ZvcmsNCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChK
aWEgSGUpDQoNCg0K
