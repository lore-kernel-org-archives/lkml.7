Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E443BC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936D421848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="14KAEx2X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="9exDMxgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390894AbfISPC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:02:56 -0400
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:47936
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389382AbfISPC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhXW1IYj7xGsThJ6BX0tprBH/CwKsi5ELZu84tTHig0=;
 b=14KAEx2X7+ZLMlvIX2pVZ/ux0F/axiqGawsxGCzEuOS/YotMIh47XefSfeQSXHEeBD8FNtwkgfMT1U53/My2DJhS7AParPFFszC2dZYg72aWj0jwr9FPfZCrNMaSbZK6lIy+e7AzRD42gWXz27WDu7+mIKhXD4aHDuCw2KfgxTY=
Received: from VI1PR0802CA0008.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::18) by AM4PR0802MB2322.eurprd08.prod.outlook.com
 (2603:10a6:200:62::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.18; Thu, 19 Sep
 2019 15:02:45 +0000
Received: from VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR0802CA0008.outlook.office365.com
 (2603:10a6:800:aa::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 19 Sep 2019 15:02:45 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT032.mail.protection.outlook.com (10.152.18.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Thu, 19 Sep 2019 15:02:43 +0000
Received: ("Tessian outbound 96594883d423:v31"); Thu, 19 Sep 2019 15:02:36 +0000
X-CR-MTA-TID: 64aa7808
Received: from b6f9c8f7444c.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5342E780-CA5B-45C9-9B0B-D3EAAB65423C.1;
        Thu, 19 Sep 2019 15:02:31 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2051.outbound.protection.outlook.com [104.47.4.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b6f9c8f7444c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Sep 2019 15:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdLpQYWC7NSBzN4q1FxeAkg5Y5hJqWt52Y7/IVYBRKqlSkKnK9auzbrI967eMy/kqb0YmCOLu04px5tCHWmF02ymUBNgkS3BKgiGqog+/DmWD4YXCPPCtIdnjEiHWBdiyn7+mA2QErlb+YTDFSg84FjZul/RLmzgwVr+yMnHgEXfGQCeSS2EfR8zEf5B/Akm0t6j0bby1xMhP+qmVnYSSLw2/hGXxC+U75uIObPXz58cjy9tiZOEuMyOY8MdnHFigaKJeCszu2P0AwMvJtjjfrlK1lLxx3YvtlawP2FRDPyebZ+N+umszreAlsi1Jb2IQNJWKTMpmqFElfNFhIPkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSSVlejmezc5P6qDr3ZzgkA5kCgUwQfmjiH/yTcr7Zw=;
 b=ofOMm82wWNMepJ8jfD1ZEUx6nsJuu1/+As6SGdLbsfUw8YR7as6tkweExTzLYUgZEKs1weyoni00kVrzyfJn4ooll7QntuotDmot2jR5o5i3Gra5EHcb5p7UFcH0tMs7ukCRGiSyVEss4gLoDR5W4dHJEhM+gyaPmoqRXKLURRGvTvO837tcjkZAk03ZKB6kVIJ3sswqDz2HFy+bll1D9bta4vk010OtLeDTdV9MxBpxJLSpTZiYEBWWV6xoM00LveOjQ8N8QChBtQEqvbU8Mngpbpvv8RWrurleU6pVc8HYN5Hr5/fvKprCLvPORRCmievL38otMbj+biFyvZKnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSSVlejmezc5P6qDr3ZzgkA5kCgUwQfmjiH/yTcr7Zw=;
 b=9exDMxgYQSiV1u0aSicVYw8AhZjt5q5PR1FdCfrPHV+Jbhrfr4/8Mb3X/5iGgbydSoQbPe2PLs0pLlC0OhHK602/Xczr4aPnkGrAqgQFBJpSQgexKpLnFjLht/wz2RPu1r2CDFWYGtxyKpISWIfOnGwjiKfr2jPF7CkOTVpz6VM=
Received: from VI1SPR01MB021.eurprd08.prod.outlook.com (52.134.12.144) by
 VI1PR08MB3008.eurprd08.prod.outlook.com (52.133.14.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Thu, 19 Sep 2019 15:02:29 +0000
Received: from VI1SPR01MB021.eurprd08.prod.outlook.com
 ([fe80::11a8:5077:76da:5e2]) by VI1SPR01MB021.eurprd08.prod.outlook.com
 ([fe80::11a8:5077:76da:5e2%2]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 15:02:29 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Jia He <hejianet@gmail.com>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
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
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>
Subject: RE: [PATCH v4 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Topic: [PATCH v4 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Index: AQHVbiPH7tIovpDc7EGl02aq95xmnKcxdpGAgADNqwCAANSpAIAAASkw
Date:   Thu, 19 Sep 2019 15:02:29 +0000
Message-ID: <VI1SPR01MB0218FB365FE518F4FCB37ADF7890@VI1SPR01MB021.eurprd08.prod.outlook.com>
References: <20190918131914.38081-1-justin.he@arm.com>
 <20190918131914.38081-4-justin.he@arm.com>
 <20190918140027.ckj32xnryyyesc23@box>
 <bebe97e1-b1fe-7f36-91c0-7d412f093560@gmail.com>
 <20190919145742.ooamzlmcfqjobcx6@box>
In-Reply-To: <20190919145742.ooamzlmcfqjobcx6@box>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 29191627-e739-4d87-a5b9-430072dd34ac.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 52e384af-99fa-4d27-ecab-08d73d126cd5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3008;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3008:|VI1PR08MB3008:|AM4PR0802MB2322:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2322475EDC5823F55E20AC76F7890@AM4PR0802MB2322.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 016572D96D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(199004)(189003)(13464003)(51914003)(11346002)(33656002)(25786009)(74316002)(71200400001)(305945005)(7736002)(26005)(186003)(6246003)(256004)(14444005)(66066001)(81166006)(81156014)(8936002)(8676002)(66574012)(6116002)(3846002)(476003)(446003)(71190400001)(7416002)(5660300002)(6306002)(64756008)(66556008)(6436002)(76116006)(7696005)(66446008)(66476007)(4326008)(9686003)(66946007)(99286004)(55016002)(53546011)(6506007)(229853002)(486006)(2906002)(14454004)(966005)(76176011)(55236004)(52536014)(102836004)(54906003)(110136005)(478600001)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3008;H:VI1SPR01MB021.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: rAvivurlECL3ot9n7IfEq36U/P50nJeJF1tf1wLBx2GG9RIeb0IRDIJViMdVAhZYEDPQFABlGfe4c7CHor99sDc1lyMFJ6U8O56b0oQqScvkTeVsg5Y8cNB5Fb33gWaLK/3cFodgG0u1kLJMC0zoWjz7AM+MY+6IPfuXGIhWwaqmwI+DlI8QeVHjn8VNmQfy0Wu5IamHOSIZX+VabTIjSvbg5uaJqosw227QcEY6Yut0ItcRq0QgHXHGFZo4GKjEblHEU0Mei8GEvzWi7d04pzH/yuHIW8NOMdFI7LFMCxkZm+QgUR0tnJK3EqVR29nGYsTE1FWHNB8aItvD/L5LHO3RWJRiejkD4hrGJjsbBF6cU4jqqlV7EBnX9DgWW8pEi/gTucKpiZ0IlPBh0w+AzHZBkFkHbW5q7pdHRmkar/M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3008
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(199004)(51914003)(189003)(40434004)(13464003)(486006)(102836004)(26005)(305945005)(7736002)(126002)(53546011)(74316002)(63350400001)(6506007)(22756006)(66574012)(11346002)(476003)(336012)(446003)(436003)(33656002)(5660300002)(86362001)(81166006)(8936002)(50466002)(356004)(8676002)(81156014)(186003)(478600001)(5024004)(14444005)(9686003)(47776003)(25786009)(14454004)(966005)(66066001)(36906005)(6306002)(110136005)(54906003)(76130400001)(3846002)(6116002)(55016002)(99286004)(7696005)(26826003)(229853002)(52536014)(70206006)(76176011)(6246003)(4326008)(70586007)(316002)(2486003)(23676004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2322;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5caaf6ae-f00d-42d0-0c71-08d73d12640a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2322;
X-Forefront-PRVS: 016572D96D
X-Microsoft-Antispam-Message-Info: kcQL/f8sikQWQ9mLqwqJZhppjme3yZX0Hs0XdfmjzV/ud8/wg5X+UkCDjdCtBzEuGFptj6j4Wv0QEbzY1TVp6txb6X2gp0cX2edoyfqB83Fi43wSOcaLuW5U/hAZSRSzcWsgxJ3OUPe6dEldhqburlcN41lHOSlZM1BDkAIIzch9urDz8AArP1iqjkeCiBOASQ1cjJlrrxAELXmoA1Rs9nGFSPV1R8epUPwWETWUILh1ZhNeHyN+p6Kuc9UuPy89LBiBaE14b0yZkthO+mZEtauHvnZYcwCebfUtYkNFp4N4pnlgblHGCyzluU1Z3hTQPZgiokLea8YmaOBIBqvvdeDVTU9G4g5aJhjlGIbs6e1cbE18PqC7mNy1+1Xulml26Sbz6BESG5KXXfNWz8y+3Wq/rwdAniT0+vWhZIbggQw=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 15:02:43.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e384af-99fa-4d27-ecab-08d73d126cd5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2322
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lyaWxsDQpUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCg0KLS0NCkNo
ZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg0KPiBT
ZW50OiAyMDE55bm0OeaciDE55pelIDIyOjU4DQo+IFRvOiBKaWEgSGUgPGhlamlhbmV0QGdtYWls
LmNvbT4NCj4gQ2M6IEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxKdXN0aW4uSGVA
YXJtLmNvbT47IENhdGFsaW4NCj4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+OyBX
aWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgTWFyaw0KPiBSdXRsYW5kIDxNYXJrLlJ1dGxh
bmRAYXJtLmNvbT47IEphbWVzIE1vcnNlDQo+IDxKYW1lcy5Nb3JzZUBhcm0uY29tPjsgTWFyYyBa
eW5naWVyIDxtYXpAa2VybmVsLm9yZz47IE1hdHRoZXcNCj4gV2lsY294IDx3aWxseUBpbmZyYWRl
YWQub3JnPjsgS2lyaWxsIEEuIFNodXRlbW92DQo+IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50
ZWwuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IFN1enVraSBQb3Vsb3Nl
DQo+IDxTdXp1a2kuUG91bG9zZUBhcm0uY29tPjsgUHVuaXQgQWdyYXdhbCA8cHVuaXRhZ3Jhd2Fs
QGdtYWlsLmNvbT47DQo+IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1hbi5LaGFuZHVhbEBhcm0u
Y29tPjsgSnVuIFlhbw0KPiA8eWFvanVuODU1ODM2M0BnbWFpbC5jb20+OyBBbGV4IFZhbiBCcnVu
dCA8YXZhbmJydW50QG52aWRpYS5jb20+Ow0KPiBSb2JpbiBNdXJwaHkgPFJvYmluLk11cnBoeUBh
cm0uY29tPjsgVGhvbWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBBbmRyZXcg
TW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsNCj4gSsOpcsO0bWUgR2xpc3NlIDxq
Z2xpc3NlQHJlZGhhdC5jb20+OyBSYWxwaCBDYW1wYmVsbA0KPiA8cmNhbXBiZWxsQG52aWRpYS5j
b20+OyBLYWx5IFhpbiAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpDQo+IDxLYWx5LlhpbkBhcm0uY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvM10gbW06IGZpeCBkb3VibGUgcGFnZSBmYXVs
dCBvbiBhcm02NCBpZiBQVEVfQUYgaXMNCj4gY2xlYXJlZA0KPg0KPiBPbiBUaHUsIFNlcCAxOSwg
MjAxOSBhdCAxMDoxNjozNEFNICswODAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gSGkgS2lyaWxsDQo+
ID4NCj4gPiBbT24gYmVoYWxmIG9mIGp1c3Rpbi5oZUBhcm0uY29tIGJlY2F1c2Ugc29tZSBtYWls
cyBhcmUgZmlsdGVkLi4uXQ0KPiA+DQo+ID4gT24gMjAxOS85LzE4IDIyOjAwLCBLaXJpbGwgQS4g
U2h1dGVtb3Ygd3JvdGU6DQo+ID4gPiBPbiBXZWQsIFNlcCAxOCwgMjAxOSBhdCAwOToxOToxNFBN
ICswODAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gPiA+IFdoZW4gd2UgdGVzdGVkIHBtZGsgdW5pdCB0
ZXN0IFsxXSB2bW1hbGxvY19mb3JrIFRFU1QxIGluIGFybTY0DQo+IGd1ZXN0LCB0aGVyZQ0KPiA+
ID4gPiB3aWxsIGJlIGEgZG91YmxlIHBhZ2UgZmF1bHQgaW4gX19jb3B5X2Zyb21fdXNlcl9pbmF0
b21pYyBvZg0KPiBjb3dfdXNlcl9wYWdlLg0KPiA+ID4gPg0KPiA+ID4gPiBCZWxvdyBjYWxsIHRy
YWNlIGlzIGZyb20gYXJtNjQgZG9fcGFnZV9mYXVsdCBmb3IgZGVidWdnaW5nIHB1cnBvc2UNCj4g
PiA+ID4gWyAgMTEwLjAxNjE5NV0gQ2FsbCB0cmFjZToNCj4gPiA+ID4gWyAgMTEwLjAxNjgyNl0g
IGRvX3BhZ2VfZmF1bHQrMHg1YTQvMHg2OTANCj4gPiA+ID4gWyAgMTEwLjAxNzgxMl0gIGRvX21l
bV9hYm9ydCsweDUwLzB4YjANCj4gPiA+ID4gWyAgMTEwLjAxODcyNl0gIGVsMV9kYSsweDIwLzB4
YzQNCj4gPiA+ID4gWyAgMTEwLjAxOTQ5Ml0gIF9fYXJjaF9jb3B5X2Zyb21fdXNlcisweDE4MC8w
eDI4MA0KPiA+ID4gPiBbICAxMTAuMDIwNjQ2XSAgZG9fd3BfcGFnZSsweGIwLzB4ODYwDQo+ID4g
PiA+IFsgIDExMC4wMjE1MTddICBfX2hhbmRsZV9tbV9mYXVsdCsweDk5NC8weDEzMzgNCj4gPiA+
ID4gWyAgMTEwLjAyMjYwNl0gIGhhbmRsZV9tbV9mYXVsdCsweGU4LzB4MTgwDQo+ID4gPiA+IFsg
IDExMC4wMjM1ODRdICBkb19wYWdlX2ZhdWx0KzB4MjQwLzB4NjkwDQo+ID4gPiA+IFsgIDExMC4w
MjQ1MzVdICBkb19tZW1fYWJvcnQrMHg1MC8weGIwDQo+ID4gPiA+IFsgIDExMC4wMjU0MjNdICBl
bDBfZGErMHgyMC8weDI0DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBwdGUgaW5mbyBiZWZvcmUgX19j
b3B5X2Zyb21fdXNlcl9pbmF0b21pYyBpcyAoUFRFX0FGIGlzIGNsZWFyZWQpOg0KPiA+ID4gPiBb
ZmZmZjliMDA3MDAwXSBwZ2Q9MDAwMDAwMDIzZDRmODAwMywgcHVkPTAwMDAwMDAyM2RhOWIwMDMs
DQo+IHBtZD0wMDAwMDAwMjNkNGIzMDAzLCBwdGU9MzYwMDAwMjk4NjA3YmQzDQo+ID4gPiA+DQo+
ID4gPiA+IEFzIHRvbGQgYnkgQ2F0YWxpbjogIk9uIGFybTY0IHdpdGhvdXQgaGFyZHdhcmUgQWNj
ZXNzIEZsYWcsIGNvcHlpbmcNCj4gZnJvbQ0KPiA+ID4gPiB1c2VyIHdpbGwgZmFpbCBiZWNhdXNl
IHRoZSBwdGUgaXMgb2xkIGFuZCBjYW5ub3QgYmUgbWFya2VkIHlvdW5nLiBTbw0KPiB3ZQ0KPiA+
ID4gPiBhbHdheXMgZW5kIHVwIHdpdGggemVyb2VkIHBhZ2UgYWZ0ZXIgZm9yaygpICsgQ29XIGZv
ciBwZm4gbWFwcGluZ3MuDQo+IHdlDQo+ID4gPiA+IGRvbid0IGFsd2F5cyBoYXZlIGEgaGFyZHdh
cmUtbWFuYWdlZCBhY2Nlc3MgZmxhZyBvbiBhcm02NC4iDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMg
cGF0Y2ggZml4IGl0IGJ5IGNhbGxpbmcgcHRlX21reW91bmcuIEFsc28sIHRoZSBwYXJhbWV0ZXIg
aXMNCj4gPiA+ID4gY2hhbmdlZCBiZWNhdXNlIHZtZiBzaG91bGQgYmUgcGFzc2VkIHRvIGNvd191
c2VyX3BhZ2UoKQ0KPiA+ID4gPg0KPiA+ID4gPiBbMV0NCj4gaHR0cHM6Ly9naXRodWIuY29tL3Bt
ZW0vcG1kay90cmVlL21hc3Rlci9zcmMvdGVzdC92bW1hbGxvY19mb3JrDQo+ID4gPiA+DQo+ID4g
PiA+IFJlcG9ydGVkLWJ5OiBZaWJvIENhaSA8WWliby5DYWlAYXJtLmNvbT4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4g
PiA+ICAgbW0vbWVtb3J5LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LQ0KPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1v
cnkuYw0KPiA+ID4gPiBpbmRleCBlMmJiNTFiNjI0MmUuLmQyYzEzMGE1ODgzYiAxMDA2NDQNCj4g
PiA+ID4gLS0tIGEvbW0vbWVtb3J5LmMNCj4gPiA+ID4gKysrIGIvbW0vbWVtb3J5LmMNCj4gPiA+
ID4gQEAgLTExOCw2ICsxMTgsMTMgQEAgaW50IHJhbmRvbWl6ZV92YV9zcGFjZSBfX3JlYWRfbW9z
dGx5ID0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI7
DQo+ID4gPiA+ICAgI2VuZGlmDQo+ID4gPiA+ICsjaWZuZGVmIGFyY2hfZmF1bHRzX29uX29sZF9w
dGUNCj4gPiA+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKHZv
aWQpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiAr
fQ0KPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ICsNCj4gPiA+ID4gICBzdGF0aWMgaW50IF9faW5p
dCBkaXNhYmxlX3JhbmRtYXBzKGNoYXIgKnMpDQo+ID4gPiA+ICAgew0KPiA+ID4gPiAgICAgICAg
IHJhbmRvbWl6ZV92YV9zcGFjZSA9IDA7DQo+ID4gPiA+IEBAIC0yMTQwLDggKzIxNDcsMTIgQEAg
c3RhdGljIGlubGluZSBpbnQgcHRlX3VubWFwX3NhbWUoc3RydWN0DQo+IG1tX3N0cnVjdCAqbW0s
IHBtZF90ICpwbWQsDQo+ID4gPiA+ICAgICAgICAgcmV0dXJuIHNhbWU7DQo+ID4gPiA+ICAgfQ0K
PiA+ID4gPiAtc3RhdGljIGlubGluZSB2b2lkIGNvd191c2VyX3BhZ2Uoc3RydWN0IHBhZ2UgKmRz
dCwgc3RydWN0IHBhZ2UgKnNyYywNCj4gdW5zaWduZWQgbG9uZyB2YSwgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEpDQo+ID4gPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgY293X3VzZXJfcGFnZShz
dHJ1Y3QgcGFnZSAqZHN0LCBzdHJ1Y3QgcGFnZSAqc3JjLA0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdm1fZmF1bHQgKnZtZikNCj4gPiA+ID4gICB7DQo+
ID4gPiA+ICsgICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEgPSB2bWYtPnZtYTsNCj4g
PiA+ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIGFkZHIgPSB2bWYtPmFkZHJlc3M7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gICAgICAgICBkZWJ1Z19kbWFfYXNzZXJ0X2lkbGUoc3JjKTsNCj4gPiA+ID4g
ICAgICAgICAvKg0KPiA+ID4gPiBAQCAtMjE1MiwyMCArMjE2MywzNCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgY293X3VzZXJfcGFnZShzdHJ1Y3QNCj4gcGFnZSAqZHN0LCBzdHJ1Y3QgcGFnZSAqc3Jj
LCB1bnNpZ25lZCBsbw0KPiA+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gPiAgICAgICAgIGlmICh1
bmxpa2VseSghc3JjKSkgew0KPiA+ID4gPiAgICAgICAgICAgICAgICAgdm9pZCAqa2FkZHIgPSBr
bWFwX2F0b21pYyhkc3QpOw0KPiA+ID4gPiAtICAgICAgICAgICAgICAgdm9pZCBfX3VzZXIgKnVh
ZGRyID0gKHZvaWQgX191c2VyICopKHZhICYgUEFHRV9NQVNLKTsNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgIHZvaWQgX191c2VyICp1YWRkciA9ICh2b2lkIF9fdXNlciAqKShhZGRyICYgUEFHRV9N
QVNLKTsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHB0ZV90IGVudHJ5Ow0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgLyoNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAqIFRoaXMgcmVhbGx5IHNo
b3VsZG4ndCBmYWlsLCBiZWNhdXNlIHRoZSBwYWdlIGlzIHRoZXJlDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgKiBpbiB0aGUgcGFnZSB0YWJsZXMuIEJ1dCBpdCBtaWdodCBqdXN0IGJlIHVucmVh
ZGFibGUsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgKiBpbiB3aGljaCBjYXNlIHdlIGp1c3Qg
Z2l2ZSB1cCBhbmQgZmlsbCB0aGUgcmVzdWx0IHdpdGgNCj4gPiA+ID4gLSAgICAgICAgICAgICAg
ICAqIHplcm9lcy4NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAqIHplcm9lcy4gT24gYXJjaGl0
ZWN0dXJlcyB3aXRoIHNvZnR3YXJlICJhY2Nlc3NlZCIgYml0cywNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAqIHdlIHdvdWxkIHRha2UgYSBkb3VibGUgcGFnZSBmYXVsdCBoZXJlLCBzbyBtYXJr
IGl0DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgKiBhY2Nlc3NlZCBoZXJlLg0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgICAgICAgICBpZiAoYXJjaF9mYXVs
dHNfb25fb2xkX3B0ZSgpICYmICFwdGVfeW91bmcodm1mLT5vcmlnX3B0ZSkpDQo+IHsNCj4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKHZtZi0+cHRsKTsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxpa2VseShwdGVfc2FtZSgqdm1mLT5wdGUsIHZt
Zi0+b3JpZ19wdGUpKSkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVudHJ5ID0gcHRlX21reW91bmcodm1mLT5vcmlnX3B0ZSk7DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHB0ZXBfc2V0X2FjY2Vzc19mbGFncyh2bWEsIGFkZHIs
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2bWYtPnB0ZSwgZW50cnksIDApKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdXBkYXRlX21tdV9jYWNoZSh2bWEsIGFkZHIsIHZtZi0N
Cj4gPnB0ZSk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiA+IEkgZG9u
J3QgZm9sbG93Lg0KPiA+ID4NCj4gPiA+IFNvIGlmIHB0ZSBoYXMgY2hhbmdlZCB1bmRlciB5b3Us
IHlvdSBkb24ndCBzZXQgdGhlIGFjY2Vzc2VkIGJpdCwgYnV0DQo+IG5ldmVyDQo+ID4gPiB0aGUg
bGVzcyBjb3B5IGZyb20gdGhlIHVzZXIuDQo+ID4gPg0KPiA+ID4gV2hhdCBtYWtlcyB5b3UgdGhp
bmsgaXQgd2lsbCBub3QgdHJpZ2dlciB0aGUgc2FtZSBwcm9ibGVtPw0KPiA+ID4NCj4gPiA+IEkg
dGhpbmsgd2UgbmVlZCB0byBtYWtlIGNvd191c2VyX3BhZ2UoKSBmYWlsIGluIHRoaXMgY2FzZSBh
bmQgY2FsbGVyIC0tDQo+ID4gPiB3cF9wYWdlX2NvcHkoKSAtLSByZXR1cm4gemVyby4gSWYgdGhl
IGZhdWx0IHdhcyBzb2x2ZWQgYnkgb3RoZXIgdGhyZWFkLA0KPiB3ZQ0KPiA+ID4gYXJlIGZpbmUu
IElmIG5vdCB1c2Vyc3BhY2Ugd291bGQgcmUtZmF1bHQgb24gdGhlIHNhbWUgYWRkcmVzcyBhbmQg
d2UNCj4gd2lsbA0KPiA+ID4gaGFuZGxlIHRoZSBmYXVsdCBmcm9tIHRoZSBzZWNvbmQgYXR0ZW1w
dC4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHBvaW50aW5nLiBIb3cgYWJvdXQgbWFrZSBjb3df
dXNlcl9wYWdlKCkgYmUgcmV0dXJuZWQNCj4gPg0KPiA+IFZNX0ZBVUxUX1JFVFJZPyBUaGVuIGlu
IGRvX3BhZ2VfZmF1bHQoKSwgaXQgY2FuIHJldHJ5IHRoZSBwYWdlIGZhdWx0Pw0KPg0KPiBOby4g
Vk1fRkFVTFRfUkVUUlkgaGFzIGRpZmZlcmVudCBzZW1hbnRpY3M6IHdlIGhhdmUgdG8gZHJvcA0K
PiBtbWFwX3NlbSgpLCBzbw0KPiBsZXQncyB0cnkgdG8gdGFrZSBpdCBhZ2FpbiBhbmQgaGFuZGxl
IHRoZSBmYXVsdC4gSW4gdGhpcyBjYXNlIHRoZSBtb3JlDQo+IGxpa2VseSBzY2VuYXJpbyBpcyB0
aGF0IG90aGVyIHRocmVhZCBoYXMgYWxyZWFkeSBoYW5kbGVkIHRoZSBmYXVsdCBhbmQgd2UNCj4g
ZG9uJ3QgbmVlZCB0byBkbyBhbnl0aGluZy4gSWYgaXQncyBub3QgdGhlIGNhc2UsIHRoZSBmYXVs
dCB3aWxsIGJlDQo+IHRyaWdnZXJlZCBhZ2FpbiBvbiB0aGUgc2FtZSBhZGRyZXNzLg0KPg0KPiAt
LQ0KPiAgS2lyaWxsIEEuIFNodXRlbW92DQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Ns
b3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJw
b3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFu
ayB5b3UuDQo=
