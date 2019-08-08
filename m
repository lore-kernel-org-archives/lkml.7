Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C055C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D423217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 06:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="JNMMUxyR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FuoCDVVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfHHGV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 02:21:27 -0400
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:29607
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfHHGV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcOf9Ty3BZ2RLoj/QIn9K4d5e8uJQl1EGUpZdgTQgEg=;
 b=JNMMUxyRHMZB+s3rAIaMh/xXslyPP8QXm1Bna0cvC5kfMpQ/CyP5VdKfVXJSzvx7my11sqqgnWB/5EJMc8tsclRY2MW+U6M4/Vgiptt5lnnJXmLZ7l1h5ykby9NJ+MN67pLlHI+C+dKLW6Y7KF8E9DGt2zPUqDVzuo9q9tgG71M=
Received: from AM6PR08CA0039.eurprd08.prod.outlook.com (2603:10a6:20b:c0::27)
 by DB6PR0801MB1845.eurprd08.prod.outlook.com (2603:10a6:4:39::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.19; Thu, 8 Aug
 2019 06:21:20 +0000
Received: from DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by AM6PR08CA0039.outlook.office365.com
 (2603:10a6:20b:c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Thu, 8 Aug 2019 06:21:20 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT043.mail.protection.outlook.com (10.152.20.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 8 Aug 2019 06:21:17 +0000
Received: ("Tessian outbound 6d016ca6b65d:v26"); Thu, 08 Aug 2019 06:21:10 +0000
X-CR-MTA-TID: 64aa7808
Received: from 89f7c294953b.1 (cr-mta-lb-1.cr-mta-net [104.47.12.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F41BB035-B700-4D88-9F39-67305AEFED2B.1;
        Thu, 08 Aug 2019 06:21:05 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 89f7c294953b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 08 Aug 2019 06:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4UI63qjV2uLwzGpeUoYIJc/Epi260qUA2vPDPlGKtn+GmtLr2V/4WNf8+Debgu/hjBOVHhO8bT1v7ntsRx3TeOGK5ig0fYxDvINBdn/7E+MSY36yNKbQW7X/mbhbXCgZsjahZEirLN2ZOAf2NThLGwcVSOqy0X36W4posxTG16K5vSrCt942cXUyhYpmqVkpvIOGM9zN1vqF1dxMP2NMn3/LRgLQERR1xAZtfpVYSYVoRsBSijnp0Irv3hUgmtvgu0XJE0Nj7VAgyQG3YMd7PFChwoD1KMl3tS9EGjGxVgB2NYmL7UQIufsknQWDRuL84KlwTW9Ifbo6akFAGzttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T1C3O5XdwCImTjkZ8/j4FLOSx8Xrae5dvXLtrI09M0=;
 b=MT6yrmjYqcRfwbiEU18pMx5wQ9Ubl8R+xE6wowlbuaxF/selEKnTWgI4GjKR5lY3v7ofhpqs0qRds2T1C39IALFff8P/nBeSZX+FKMNRtXkDeNIG26jrtxi9VmklWimJ80bXba3gxR3IFnkLquyDcrRLA51wlAl33Evur7FaPyTpTWTav5f5Bpe30KUrQprKQHXhc953KIxIRsq6PEwnCIV/I2ysS5CigQteAVBizveFcHybC1r3tGnkW5tnsVXC1Ftu1OLOr+P7MTnrYEKFy/uhYrqAvGYa8y0P28i1YzdZsO0Jf3Ld7+khzvsCxtOrmAHhx3/1pbKPGVNXp0mMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T1C3O5XdwCImTjkZ8/j4FLOSx8Xrae5dvXLtrI09M0=;
 b=FuoCDVVhBhAmR+z3zIJKs85owLu6pW1a4Zcak5dqzPNCEBJW5a7HxVUXtdunMu1Z922ynBn3kHFOiOnI/s5aE8h83bkeTQ2RxunAhSP8q/SJs+qbOBOjgF77sbWKln26O4k9HUiHjscYWIEJHSLci+G/9dhpWAFN8LW2U0Yu/cw=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3563.eurprd08.prod.outlook.com (20.177.120.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 8 Aug 2019 06:20:57 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::a13f:5848:5d6d:beef]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::a13f:5848:5d6d:beef%5]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 06:20:56 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        James Morse <James.Morse@arm.com>
CC:     Christoffer Dall <Christoffer.Dall@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>, Qian Cai <cai@lca.pw>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        "Robin Murphy" <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: mm: add missing PTE_SPECIAL in pte_mkdevmap on
 arm64
Thread-Topic: [PATCH] arm64: mm: add missing PTE_SPECIAL in pte_mkdevmap on
 arm64
Thread-Index: AQHVTNzgFzj2oPN2PEG9bf5641PhWqbwt8+AgAAOLeA=
Date:   Thu, 8 Aug 2019 06:20:56 +0000
Message-ID: <DB7PR08MB30823791749E5B083AF167B5F7D70@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190807045851.10772-1-justin.he@arm.com>
 <ce0be561-117c-ef94-6a26-f88c3ba21096@arm.com>
In-Reply-To: <ce0be561-117c-ef94-6a26-f88c3ba21096@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: ca0af0bb-42c9-4549-8b97-cbb29de1d487.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 60a571f0-0023-4e14-b253-08d71bc89f98
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB3563;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3563:|DB6PR0801MB1845:
X-Microsoft-Antispam-PRVS: <DB6PR0801MB184526874D931EA58D33C64CF7D70@DB6PR0801MB1845.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 012349AD1C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(51914003)(13464003)(199004)(189003)(55236004)(66476007)(66556008)(64756008)(9686003)(66446008)(66946007)(6506007)(102836004)(53546011)(71190400001)(71200400001)(14454004)(76116006)(76176011)(55016002)(5660300002)(8936002)(305945005)(8676002)(229853002)(26005)(81156014)(81166006)(6436002)(186003)(66066001)(7736002)(52536014)(316002)(74316002)(33656002)(4326008)(25786009)(110136005)(54906003)(6636002)(3846002)(6116002)(2906002)(53936002)(486006)(446003)(99286004)(11346002)(476003)(7696005)(478600001)(86362001)(256004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3563;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: rFrMcQ1UC+gKsIyLRu0kSJrxaSv0mGsRo0Ugyseay4lwVMsS9raqI8xKETalLvodbGoIP+2eVZj0PedpGeg9EnfJpA8HlTD2MFPud+bMO0inoahx737URVhjNIt5NCOXwETe+Wf/pioMzAn727Rg3DsfzA6A7Kfq2IfhN38ATJuuqoxEkJjm9mICfFWZFejpKpfJoWR+lBXeuQEw5HDBAkjJfGPuV/Cx9ks0qSRGl1LDiW+PG/xPz3GH12CjnMpSASVoO8C++Xx0+fltpU0nqJy3PYlqxCFy6ZqNhsHFE8XuVxzZa3/grCYeZbJgJImitHgCKblSaBUaqvYLI9a1Ffw2i3A5JIKdIfc7AlBi5cEt/W33pv834OtPENLkPKfwzgBPziuM0fhJmM/fG2/qvZY+l/nprXRZI2nmaCsPQw0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3563
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(199004)(40434004)(189003)(51914003)(13464003)(316002)(336012)(126002)(436003)(4326008)(25786009)(86362001)(63370400001)(55016002)(486006)(2906002)(9686003)(476003)(186003)(33656002)(6636002)(26005)(11346002)(8936002)(63350400001)(74316002)(229853002)(356004)(66066001)(110136005)(54906003)(446003)(7736002)(305945005)(6246003)(6506007)(53546011)(52536014)(2486003)(76176011)(7696005)(26826003)(23676004)(81166006)(5024004)(478600001)(14444005)(6116002)(14454004)(50466002)(22756006)(81156014)(8676002)(70586007)(47776003)(70206006)(5660300002)(99286004)(3846002)(102836004)(76130400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1845;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3e3795ec-460c-46bd-d635-08d71bc89300
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(710020)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB6PR0801MB1845;
X-Forefront-PRVS: 012349AD1C
X-Microsoft-Antispam-Message-Info: LiuVVsoY0EwXeLaNdcukyWpuDJ50yHC+1otrfQ4nGqq5Ucbt731dScYeRW1stECeE39uHpQxUXZyG7f2+THzpIzLAqbO8vbJK5qoxPINMb2Uvmy1GmDg2jRYsnTxdyfG+QO/vvVlK9K7WT/XOCgppdHiVmI2k0CAyO2cWzOXI3Tm16othrvaW7qHa44c0jtxjNm7eFM5EaFKifJGrIVTHLC2+1Uvvdlta8rYh1KENjzHaELDyC6kc125xkqAnrb/Yy/VRCa2l8IoP2bEj8KZZDi0rtNVafZ+ZswF3c8A9IO65UJjNtJcU24UsexHBS0TlC10kfOp5v2zHGGom/KxvKr+VNj6RwK0oD2lOP+x5sGCllX8DEb2kQRa89LQoOtS0EZ9LYYmsruC+p8A3bJIwEb+F2z9ItI2a877syF5uAw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2019 06:21:17.9997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a571f0-0023-4e14-b253-08d71bc89f98
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5zaHVtYW4NClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLCBwbGVhc2Ugc2VlIG15IGNvbW1l
bnRzIGJlbG93DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zaHVt
YW4gS2hhbmR1YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+DQo+IFNlbnQ6IDIwMTnlubQ4
5pyIOOaXpSAxMzoxOQ0KPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPEp1
c3Rpbi5IZUBhcm0uY29tPjsgQ2F0YWxpbg0KPiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJt
LmNvbT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Ow0KPiBNYXJrIFJ1dGxhbmQgPE1h
cmsuUnV0bGFuZEBhcm0uY29tPjsgSmFtZXMgTW9yc2UNCj4gPEphbWVzLk1vcnNlQGFybS5jb20+
DQo+IENjOiBDaHJpc3RvZmZlciBEYWxsIDxDaHJpc3RvZmZlci5EYWxsQGFybS5jb20+OyBQdW5p
dCBBZ3Jhd2FsDQo+IDxwdW5pdGFncmF3YWxAZ21haWwuY29tPjsgUWlhbiBDYWkgPGNhaUBsY2Eu
cHc+OyBKdW4gWWFvDQo+IDx5YW9qdW44NTU4MzYzQGdtYWlsLmNvbT47IEFsZXggVmFuIEJydW50
IDxhdmFuYnJ1bnRAbnZpZGlhLmNvbT47DQo+IFJvYmluIE11cnBoeSA8Um9iaW4uTXVycGh5QGFy
bS5jb20+OyBUaG9tYXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IG1tOiBhZGQgbWlzc2luZyBQVEVf
U1BFQ0lBTCBpbg0KPiBwdGVfbWtkZXZtYXAgb24gYXJtNjQNCj4NClsuLi5dDQo+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+IGIvYXJjaC9hcm02NC9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gPiBpbmRleCA1ZmRjZmUyMzczMzguLmUwOTc2MGVjZTg0
NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiA+
ICsrKyBiL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ID4gQEAgLTIwOSw3ICsy
MDksNyBAQCBzdGF0aWMgaW5saW5lIHBtZF90IHBtZF9ta2NvbnQocG1kX3QgcG1kKQ0KPiA+DQo+
ID4gIHN0YXRpYyBpbmxpbmUgcHRlX3QgcHRlX21rZGV2bWFwKHB0ZV90IHB0ZSkNCj4gPiAgew0K
PiA+IC0gICByZXR1cm4gc2V0X3B0ZV9iaXQocHRlLCBfX3BncHJvdChQVEVfREVWTUFQKSk7DQo+
ID4gKyAgIHJldHVybiBzZXRfcHRlX2JpdChwdGUsIF9fcGdwcm90KFBURV9ERVZNQVAgfCBQVEVf
U1BFQ0lBTCkpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHNldF9wdGUo
cHRlX3QgKnB0ZXAsIHB0ZV90IHB0ZSkNCj4gPiBAQCAtMzk2LDcgKzM5NiwxMCBAQCBzdGF0aWMg
aW5saW5lIGludCBwbWRfcHJvdG5vbmUocG1kX3QgcG1kKQ0KPiA+ICAjaWZkZWYgQ09ORklHX1RS
QU5TUEFSRU5UX0hVR0VQQUdFDQo+ID4gICNkZWZpbmUgcG1kX2Rldm1hcChwbWQpICAgICAgICAg
ICAgcHRlX2Rldm1hcChwbWRfcHRlKHBtZCkpDQo+ID4gICNlbmRpZg0KPiA+IC0jZGVmaW5lIHBt
ZF9ta2Rldm1hcChwbWQpDQo+ICAgICAgIHB0ZV9wbWQocHRlX21rZGV2bWFwKHBtZF9wdGUocG1k
KSkpDQo+ID4gK3N0YXRpYyBpbmxpbmUgcG1kX3QgcG1kX21rZGV2bWFwKHBtZF90IHBtZCkNCj4g
PiArew0KPiA+ICsgICByZXR1cm4gcHRlX3BtZChzZXRfcHRlX2JpdChwbWRfcHRlKHBtZCksDQo+
IF9fcGdwcm90KFBURV9ERVZNQVApKSk7DQo+ID4gK30NCj4NCj4gVGhvdWdoIEkgY291bGQgc2Vl
IG90aGVyIHBsYXRmb3JtcyBsaWtlIHBvd2VycGMgYW5kIHg4NiBmb2xsb3dpbmcgc2FtZQ0KPiBh
cHByb2FjaCAoREVWTUFQICsgU1BFQ0lBTCkgZm9yIHB0ZSBzbyB0aGF0IGl0IGNoZWNrcyBwb3Np
dGl2ZSBmb3INCj4gcHRlX3NwZWNpYWwoKSBidXQgdGhlbiBqdXN0IERFVk1BUCBmb3IgcG1kIHdo
aWNoIGNvdWxkIG5ldmVyIGhhdmUgYQ0KPiBwbWRfc3BlY2lhbCgpLiBCdXQgYSBtb3JlIGZ1bmRh
bWVudGFsIHF1ZXN0aW9uIGlzIC0gd2h5IHNob3VsZCBhIGRldm1hcA0KPiBiZSBhIHNwZWNpYWwg
cHRlIGFzIHdlbGwgPw0KDQpJSVVDLCBzcGVjaWFsIHB0ZSBiaXQgbWFrZSB0aGluZ3MgaGFuZGxp
bmcgZWFzaWVyIGNvbXBhcmUgd2l0aCB0aG9zZSBhcmNoZXMgd2hpY2gNCmhhdmUgbm8gc3BlY2lh
bCBiaXQuIFRoZSBtZW1vcnkgY29kZXMgd2lsbCByZWdhcmQgZGV2bWFwIHBhZ2UgYXMgYSBzcGVj
aWFsIG9uZQ0KY29tcGFyZWQgd2l0aCBub3JtYWwgcGFnZS4NCkRldm1hcCBwYWdlIHN0cnVjdHVy
ZSBjYW4gYmUgc3RvcmVkIGluIHJhbS9wbWVtL25vbmUuDQoNCj4NCj4gQWxzbyBpbiB2bV9ub3Jt
YWxfcGFnZSgpIHdoeSBjYW5ub3QgaXQgdGVzdHMgZm9yIHB0ZV9kZXZtYXAoKSBiZWZvcmUgaXQN
Cj4gc3RhcnRzIGxvb2tpbmcgZm9yIENPTkZJR19BUkNIX0hBU19QVEVfU1BFQ0lBTC4gSXMgdGhp
cyB0aGUgb25seSBwYXRoDQo+IGZvcg0KDQpBRkFJQ1QsIHllcywgYnV0IGl0IGNoYW5nZXMgdG8g
bXVjaCBiZXNpZGVzIGFybSBjb2Rlcy4g8J+Yig0KDQo+IHdoaWNoIHdlIG5lZWQgdG8gc2V0IFNQ
RUNJQUwgYml0IG9uIGEgZGV2bWFwIHB0ZSBvciB0aGVyZSBhcmUgb3RoZXIgcGF0aHMNCj4gd2hl
cmUgdGhpcyBzZW1hbnRpY3MgaXMgYXNzdW1lZCA/DQoNCk5vIGlkZWENCg0KDQotLQ0KQ2hlZXJz
LA0KSnVzdGluIChKaWEgSGUpDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9m
IHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkg
YWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9z
ZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9z
ZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsg
eW91Lg0K
