Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B94C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE4E2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yq0VHQm1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="yq0VHQm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404149AbfIXCSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:18:13 -0400
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:49638
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729193AbfIXCSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rEB2L/0tAjILj/54hT8JROb/SyFIdf4rAQodLfrLQc=;
 b=yq0VHQm1ytJldYjP6jOzXc4TDj8qFxOb9Y0xg+41CLuNholjjqijiklscZIWENlZmQw8VbeQ2DcBxFY1acztZYY4ZXLEI/xUdwy6ZOJDUFs75VkJ/1ash/cOTWQ4gkCOGtceqQR2m0aHDx8KcJCbbxDNAi6CMdo8p6V9+RxCoks=
Received: from DB6PR0802CA0048.eurprd08.prod.outlook.com (2603:10a6:4:a3::34)
 by VE1PR08MB4992.eurprd08.prod.outlook.com (2603:10a6:803:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Tue, 24 Sep
 2019 02:18:04 +0000
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by DB6PR0802CA0048.outlook.office365.com
 (2603:10a6:4:a3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 02:18:04 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25 via Frontend Transport; Tue, 24 Sep 2019 02:18:02 +0000
Received: ("Tessian outbound 0d576b67b9f5:v31"); Tue, 24 Sep 2019 02:17:55 +0000
X-CR-MTA-TID: 64aa7808
Received: from 87cfe3be434a.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.12.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 829125A6-5FD4-41F8-91E9-19D1D7ABF78E.1;
        Tue, 24 Sep 2019 02:17:50 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 87cfe3be434a.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2019 02:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqF/7lYOJJdfFOcYAOIAg8jpNqsJpuuK8eDkQDyxsMBvViYaBBAoTFnRYQBZZ66XjP4nTMQfkfRr6DlOLhx/ZXJnQyTanTRz0K/wcAxT9MZN6ALQXkvcw0nADIPZB16PrwG7qTVFVHC4CxkXlXFvRVZSMCYua7Sv2ntkLpLw9DfwNEp22k26119DiVFP6M18avVcyZcvRCUX1jHR0yOdYgrZHfGSyEuZ0CeI3zycvqTdGjAVxmhFZ1Jg1X5rXMPQiAseLk8yDrwtBNBkuFoHRRtbOXaPeDl/aqyTq1JRrA9xnCfCpISCTGze/3tNoJzam9k6RYPkbby6EM4Rxf9kJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rEB2L/0tAjILj/54hT8JROb/SyFIdf4rAQodLfrLQc=;
 b=JJ9k0bLm1v/F3IGHphhbwO69N8kG2n636WIRtknpwS4S4xi8Z3g35fJenmnZO6y3kUXDP/3Bo8kEyPdFjGgrG0VaeFvwa45shVnaRuCiYfwg8Nq4W9OZeKW1SHyGNaLucNgmJ08J6Ejv3sHzfAZnjVnxgKVg6c2/eXuoOTt+F5eUS+hd5gupMYtVUR4sVEDSYUJ3MSkuEaqyawY2rMKfDj/6qp8hFmERj3W54MnZ3o4ftjZ/QMMpU0Ia9ihkMaqUPy4jGj3MTt9CEY0RcRL8MeTU52JGRKG7y4pbKwFMJ+SUif7T+xXpukqAMB5imlNvvODkJ+1hg/lo8VuxrwtWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rEB2L/0tAjILj/54hT8JROb/SyFIdf4rAQodLfrLQc=;
 b=yq0VHQm1ytJldYjP6jOzXc4TDj8qFxOb9Y0xg+41CLuNholjjqijiklscZIWENlZmQw8VbeQ2DcBxFY1acztZYY4ZXLEI/xUdwy6ZOJDUFs75VkJ/1ash/cOTWQ4gkCOGtceqQR2m0aHDx8KcJCbbxDNAi6CMdo8p6V9+RxCoks=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3306.eurprd08.prod.outlook.com (52.134.111.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 02:17:49 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 02:17:49 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "hejianet@gmail.com" <hejianet@gmail.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        nd <nd@arm.com>
Subject: RE: [PATCH v8 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Thread-Topic: [PATCH v8 2/3] arm64: mm: implement arch_faults_on_old_pte() on
 arm64
Thread-Index: AQHVcIOtyGW9OrZq5Euwghiy+NRN36c5dAWAgACm5UA=
Date:   Tue, 24 Sep 2019 02:17:49 +0000
Message-ID: <DB7PR08MB3082F91F6502337231EDC63FF7840@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-3-justin.he@arm.com>
 <20190923161824.GD10192@arrakis.emea.arm.com>
In-Reply-To: <20190923161824.GD10192@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2c10dae5-1410-49d8-8632-d8c1c48e37eb.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7485ff8f-ce1a-433e-6714-08d740956d7a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB3306;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3306:|DB7PR08MB3306:|VE1PR08MB4992:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB49922BEFD23E84CEF4929933F7840@VE1PR08MB4992.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(13464003)(199004)(189003)(446003)(11346002)(486006)(229853002)(74316002)(6436002)(6862004)(55016002)(6246003)(9686003)(52536014)(316002)(14444005)(71200400001)(71190400001)(81166006)(256004)(8936002)(81156014)(8676002)(4326008)(66574012)(66066001)(54906003)(26005)(86362001)(25786009)(5660300002)(14454004)(2906002)(478600001)(6636002)(33656002)(6116002)(3846002)(7416002)(76176011)(76116006)(66446008)(7696005)(55236004)(7736002)(99286004)(6506007)(102836004)(476003)(66476007)(66946007)(186003)(66556008)(64756008)(305945005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3306;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: r79bP/MjcxyvqGMc0h5QaT9Tmi3nWYoYchGq+4VdC3teFUrSFw3EwF+W/6QVxVW7U+VuPlIroh5v6ptIC5HTTJ3IFKK/03Vm5nxqbiOtDX+jZwe4o5p8CcufPoKYb1Xz+4I32j85e8EdmyNgU1LNbAtcg5GJgwCstOMvb8O335KtxUxsZGAFiT90R2rf5DDwemJZWmQD6wi7qLJcsFEUM7HfuIx5ClYPzyXkStsWPh7bRBAOF0ymjFlA7eXOEapxv4Cf+G8d0OvjdptBWK2FX8BNNTe4IGuHbOWmZRo2oG5a0xBSQ6v5bQQ/knfIPfzQvUNEWVVzT/SjN7Ddm3NKXxTQTi2SfiM9WAq640qla8OD2CmPzsh0DrV13mwwdtrB3ObP/v5dc6KixkHRnuF7vRBU0mAIExKYpgaXSJw8jBg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3306
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(13464003)(199004)(189003)(305945005)(26005)(436003)(63350400001)(76130400001)(25786009)(2486003)(23676004)(99286004)(229853002)(186003)(9686003)(6862004)(33656002)(6246003)(14444005)(52536014)(4326008)(55016002)(8936002)(5660300002)(81156014)(81166006)(54906003)(50466002)(8676002)(7696005)(6636002)(2906002)(86362001)(66574012)(486006)(36906005)(316002)(74316002)(6116002)(47776003)(356004)(66066001)(3846002)(70586007)(26826003)(22756006)(478600001)(14454004)(102836004)(446003)(476003)(11346002)(126002)(6506007)(53546011)(76176011)(70206006)(336012)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4992;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53faf272-0db2-4a14-3686-08d74095658d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VE1PR08MB4992;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: TNiW7YKY4sR+t8xxnAKCrsjJvkrUKIf9U97Zq7qrtMeccsxzeTgL3ch1nJiP4kjVB2n5Jf1hZA9s8m0PNHPweWeWECx4jvjmk2kqEmjoFJZWmPA3oE8MwU2T41Wj5zzRoTRL3j9e9+WV19txcPYPkMSwvOEr1LTfAVRi9AJql1+QOJ+rqUSH+Bzcm+LDP1N8kaqVtsHIUB//DhPAtQYj4+aUv7zNb4bL2yhoJMCUiTuSp8IEGEUS4LfPl1sCATtbRZ5mqcMbSr1hCGfZAAZqXUXeZP8R7LIkZrI3q+r8N0VwOsiaoPJex4521kxI0XfNnW7ieYp26Z0xOEAffh58WRaCd/QweSu3WsVR9Auo+wTFju+OP9PP81QhzqCMzWhTAvXAm+YRaOlqr5TyRaw55v8RgPW5jwWuRUvCt5LHMEw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 02:18:02.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7485ff8f-ce1a-433e-6714-08d740956d7a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4992
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2F0YWxpbiBNYXJpbmFz
IDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gU2VudDogMjAxOeW5tDnmnIgyNOaXpSAwOjE4
DQo+IFRvOiBKdXN0aW4gSGUgKEFybSBUZWNobm9sb2d5IENoaW5hKSA8SnVzdGluLkhlQGFybS5j
b20+DQo+IENjOiBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kDQo+
IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47IEphbWVzIE1vcnNlIDxKYW1lcy5Nb3JzZUBhcm0uY29t
PjsgTWFyYw0KPiBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IE1hdHRoZXcgV2lsY294IDx3aWxs
eUBpbmZyYWRlYWQub3JnPjsgS2lyaWxsIEEuDQo+IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZA
bGludXguaW50ZWwuY29tPjsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IG1tQGt2YWNrLm9yZzsg
U3V6dWtpIFBvdWxvc2UgPFN1enVraS5Qb3Vsb3NlQGFybS5jb20+OyBQdW5pdA0KPiBBZ3Jhd2Fs
IDxwdW5pdGFncmF3YWxAZ21haWwuY29tPjsgQW5zaHVtYW4gS2hhbmR1YWwNCj4gPEFuc2h1bWFu
LktoYW5kdWFsQGFybS5jb20+OyBBbGV4IFZhbiBCcnVudA0KPiA8YXZhbmJydW50QG52aWRpYS5j
b20+OyBSb2JpbiBNdXJwaHkgPFJvYmluLk11cnBoeUBhcm0uY29tPjsNCj4gVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LQ0KPiBm
b3VuZGF0aW9uLm9yZz47IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPjsgUmFs
cGggQ2FtcGJlbGwNCj4gPHJjYW1wYmVsbEBudmlkaWEuY29tPjsgaGVqaWFuZXRAZ21haWwuY29t
OyBLYWx5IFhpbiAoQXJtIFRlY2hub2xvZ3kNCj4gQ2hpbmEpIDxLYWx5LlhpbkBhcm0uY29tPjsg
bmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMi8zXSBhcm02NDogbW06
IGltcGxlbWVudA0KPiBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKCkgb24gYXJtNjQNCj4gDQo+IE9u
IFNhdCwgU2VwIDIxLCAyMDE5IGF0IDA5OjUwOjUzUE0gKzA4MDAsIEppYSBIZSB3cm90ZToNCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+IGluZGV4IGUwOTc2MGVjZTg0NC4uNGE5
OTM5NjE1ZTQxIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJs
ZS5oDQo+ID4gKysrIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiBAQCAt
ODY4LDYgKzg2OCwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdXBkYXRlX21tdV9jYWNoZShzdHJ1
Y3QNCj4gdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gPiAgI2RlZmluZSBwaHlzX3RvX3R0YnIoYWRk
cikJKGFkZHIpDQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIE9uIGFybTY0IHdp
dGhvdXQgaGFyZHdhcmUgQWNjZXNzIEZsYWcsIGNvcHlpbmcgZnJvbXVzZXIgd2lsbCBmYWlsDQo+
IGJlY2F1c2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeXl5eXl5eXg0KPiAJCQkJCQkgICAgIGZyb20gdXNlcg0KPiANCg0KT2sNCj4gPiAr
ICogdGhlIHB0ZSBpcyBvbGQgYW5kIGNhbm5vdCBiZSBtYXJrZWQgeW91bmcuIFNvIHdlIGFsd2F5
cyBlbmQgdXAgd2l0aA0KPiB6ZXJvZWQNCj4gPiArICogcGFnZSBhZnRlciBmb3JrKCkgKyBDb1cg
Zm9yIHBmbiBtYXBwaW5ncy4gd2UgZG9uJ3QgYWx3YXlzIGhhdmUgYQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXg0KPiAJCQkJCQlXZQ0KPiANCg0K
T2sNCj4gPiArICogaGFyZHdhcmUtbWFuYWdlZCBhY2Nlc3MgZmxhZyBvbiBhcm02NC4NCj4gPiAr
ICovDQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKHZvaWQp
DQo+ID4gK3sNCj4gPiArCXJldHVybiAhY3B1X2hhc19od19hZigpOw0KPiANCj4gSSBzYXcgYW4g
ZWFybHkgaW5jYXJuYXRpb24gb2YgeW91ciBwYXRjaCBoYXZpbmcgYQ0KPiBXQVJOX09OKHByZWVt
cHRpYmxlKCkpLiBJIHRoaW5rIHdlIG5lZWQgdGhpcyBiYWNrIGp1c3QgaW4gY2FzZSB0aGlzDQo+
IGZ1bmN0aW9uIHdpbGwgYmUgdXNlZCBlbHNld2hlcmUgaW4gdGhlIGZ1dHVyZS4NCg0KT2theQ0K
DQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0KPiANCj4gPiArfQ0KPiA+ICsjZGVm
aW5lIGFyY2hfZmF1bHRzX29uX29sZF9wdGUgYXJjaF9mYXVsdHNfb25fb2xkX3B0ZQ0KPiANCj4g
T3RoZXJ3aXNlLA0KPiANCj4gUmV2aWV3ZWQtYnk6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5t
YXJpbmFzQGFybS5jb20+DQo=
