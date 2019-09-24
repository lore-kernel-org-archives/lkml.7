Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CBEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BEE20673
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 01:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1lehZCOs";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1lehZCOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408443AbfIXBus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 21:50:48 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:13087
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729133AbfIXBur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 21:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knPoEncWYeAe0pWp06dfPMMZAWlbgMnbwEX1xVYMJBc=;
 b=1lehZCOsnh4x0yfF60x32SbtNf71jbuEbkvoV2LHcWchDKwFurZQGitFN/upngV7cDR6coh9Kqx2s9NGu16dF+xWqsxynrk0s3INj1wE3anagB/OThjE03QucuB17Dk2NQLmzR2RuHnylDXBJmiNkFUVWtEcqrPoBGwg2RljnQQ=
Received: from HE1PR0802CA0012.eurprd08.prod.outlook.com (2603:10a6:3:bd::22)
 by AM0PR08MB4355.eurprd08.prod.outlook.com (2603:10a6:208:13a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.24; Tue, 24 Sep
 2019 01:50:36 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by HE1PR0802CA0012.outlook.office365.com
 (2603:10a6:3:bd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 01:50:36 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Tue, 24 Sep 2019 01:50:34 +0000
Received: ("Tessian outbound 0d576b67b9f5:v31"); Tue, 24 Sep 2019 01:50:32 +0000
X-CR-MTA-TID: 64aa7808
Received: from 75332816beee.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DA379F0D-4C22-44DA-9E71-571BCEEEFC14.1;
        Tue, 24 Sep 2019 01:50:27 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 75332816beee.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2019 01:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+bSlb+KmzG1FvnVXK5OwpXBFn2hHkVXJIt2ocVn3oDmPsNHT5//GguD954h/Ws4bHfxH70EY2g+o8Ae/IOlQWglBFR3W0b9PcfaCwetm9jYBgU2R359zQRd0lxCcVYvd1wZrxzbXvabo7+E/8yIBMIXDB31dSXJYO08ZlDtTJr5hXBZC+zXNM93K1L3CwZ6y9e4P1q4cIV4Gm6azZCaElHIhHIJZAJ2lVL8hEQfvIsbn0PzCaH7cy3F25Q4s2lL3n71lHbPQtlFb0mS1c0iEP/+HiR+gVnhG1QaKKj3Dn0C2pnt+ch2PbZh5uvjE2jyySpXn6bMAYud/uePBt/B1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knPoEncWYeAe0pWp06dfPMMZAWlbgMnbwEX1xVYMJBc=;
 b=POox74Vjn95S1CeaQSESsaEfAmyn8Cv+i9SNjq4yNJHK/o36Fu/2oFGVGjpesBcer/3z5IW7Y7HlVHKrGaYOLzH1jfLvm0ZsR0uYVHxQSUYuU5axuJT+0pm8KPCIKA/5xvGtHiM2UJloenl2j9fJ6OdaGC6AnPbw8TNqDM7TcacjSNZzX/OHA2POmcGP/vwuyZu5GHwtH8DYI1g9l5G6gVaO2BXQEk/qqGXeCDljjbvOlAU3fFrzC61w+86MWztHH/7jqUdU57+lLtXBNiOFPK79NvO8fKlGvN4yN8MIoiW1tILogpCB+my0RjBv1k4bFpnwDJ/LqtI5/2oOXJ8SWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knPoEncWYeAe0pWp06dfPMMZAWlbgMnbwEX1xVYMJBc=;
 b=1lehZCOsnh4x0yfF60x32SbtNf71jbuEbkvoV2LHcWchDKwFurZQGitFN/upngV7cDR6coh9Kqx2s9NGu16dF+xWqsxynrk0s3INj1wE3anagB/OThjE03QucuB17Dk2NQLmzR2RuHnylDXBJmiNkFUVWtEcqrPoBGwg2RljnQQ=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3721.eurprd08.prod.outlook.com (20.178.47.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 01:50:24 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 01:50:24 +0000
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
Subject: RE: [PATCH v8 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Topic: [PATCH v8 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Index: AQHVcIOqDsyZY+itCkSnylN63KVMBac5cOKAgACizdA=
Date:   Tue, 24 Sep 2019 01:50:24 +0000
Message-ID: <DB7PR08MB3082C58131C4CBAF88B939D1F7840@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-2-justin.he@arm.com>
 <20190923160710.GC10192@arrakis.emea.arm.com>
In-Reply-To: <20190923160710.GC10192@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2a509af6-2a0b-4da2-9d85-8ae7854bd114.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 37a80384-556d-475b-32db-08d740919760
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3721;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3721:|DB7PR08MB3721:|AM0PR08MB4355:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4355C7C4B4D7E36C0F7712C1F7840@AM0PR08MB4355.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(13464003)(2906002)(256004)(9686003)(71200400001)(66066001)(6636002)(55236004)(99286004)(71190400001)(229853002)(316002)(66574012)(14454004)(5660300002)(52536014)(478600001)(86362001)(102836004)(26005)(6116002)(3846002)(6246003)(4326008)(76116006)(25786009)(54906003)(7416002)(81166006)(81156014)(476003)(486006)(8936002)(33656002)(11346002)(446003)(74316002)(8676002)(305945005)(66946007)(66476007)(66556008)(64756008)(7696005)(7736002)(14444005)(55016002)(53546011)(6506007)(186003)(6862004)(76176011)(6436002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3721;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: TYeYyheVJRagxJIKs57Y0GZmQw4NmBACToTcZtxXXEELdwwN7yHl0/XMSBXbdlq+AiFMrqXJ6Uk3jdQ+uTt9a3ruzZ3baZfLdMnOuNMIZ7jfE2uunEEpJDw3K/HbvZdVStN1rNqgLJJCKYb4aI63kEQUEYquOmM8PF1DeaiGIDcjTVUOANXm4SUq5jGo3csEAGziwt3saB/KIJmjaER2ZvJeKdZF9XGw/O+YtOJRqERoxEck9DGa/RQT7iwd/4owzJa2QZVWKC4dl9rz8/7DYVVpxyA4lVQmnUlS6L6p0e/xXPZB2pJbSSIUCxstSdfXyqr+s4f6moYRFDmElT8jPpKMwdK3eat/K3iUVJJ2hZtEtyBUYqf3Aa4XUfWkuyIpfmw/3b+21MCPuSck9++KGGb/9TdZwYhzGo2/oDuVxJ0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3721
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(346002)(376002)(396003)(136003)(189003)(13464003)(199004)(126002)(356004)(70206006)(55016002)(9686003)(478600001)(26826003)(7736002)(6506007)(6636002)(53546011)(66574012)(102836004)(86362001)(316002)(54906003)(229853002)(81156014)(8676002)(14444005)(81166006)(305945005)(25786009)(4326008)(6862004)(6246003)(8936002)(99286004)(74316002)(14454004)(26005)(50466002)(186003)(2486003)(22756006)(23676004)(33656002)(7696005)(76176011)(3846002)(6116002)(66066001)(2906002)(11346002)(5660300002)(76130400001)(336012)(486006)(476003)(63350400001)(446003)(70586007)(47776003)(52536014)(436003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4355;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6244392d-a27d-435b-b259-08d740919140
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR08MB4355;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: oNH8B1KW9bempPQ+AGaiO2/q90vSTWyanM8uZBQ5JQM2ZTHg/8MAARsV8GlEE/Qx3HoxOIw/XvjGhqiZ01XAJBqPmezjRbXxOr3sev3k31hvHzHOSYNfFOAvmk1pPKkFLjUeJPojfvxcZNq8PAhnkmfxD/fybw1Vj0egZOVWdalaDk5Bii7uDsjygLiehMZ4H5Hcy3TmZx6qdMn9byLLPv3OmQYmBcgp06Hn+SQ571ZNe0QQQLf/2sfr0fhYKwBK1qUxAbbgAlsMQ18rPjCV0Ro5VtqKrl/qOuKSceLk5+dQrMpjjcGT2NdZ/dBJiBhv2AKg1Vi4r/oS2GOw0QNBh6eUSFtB/bn+gtSwklAd86bNoSknc4pSBomTnS8zO2K+0BbWYmSyr0YAK0EbW/F0oAXrmKiSyPWBRm2e6zAz2JI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 01:50:34.9803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a80384-556d-475b-32db-08d740919760
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFNlbnQ6IDIwMTnlubQ55pyI
MjTml6UgMDowNw0KPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPEp1c3Rp
bi5IZUBhcm0uY29tPg0KPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IE1hcmsg
UnV0bGFuZA0KPiA8TWFyay5SdXRsYW5kQGFybS5jb20+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9y
c2VAYXJtLmNvbT47IE1hcmMNCj4gWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBNYXR0aGV3IFdp
bGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IEtpcmlsbCBBLg0KPiBTaHV0ZW1vdiA8a2lyaWxs
LnNodXRlbW92QGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtbUBr
dmFjay5vcmc7IFN1enVraSBQb3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBhcm0uY29tPjsgUHVuaXQN
Cj4gQWdyYXdhbCA8cHVuaXRhZ3Jhd2FsQGdtYWlsLmNvbT47IEFuc2h1bWFuIEtoYW5kdWFsDQo+
IDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29tPjsgQWxleCBWYW4gQnJ1bnQNCj4gPGF2YW5icnVu
dEBudmlkaWEuY29tPjsgUm9iaW4gTXVycGh5IDxSb2Jpbi5NdXJwaHlAYXJtLmNvbT47DQo+IFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC0NCj4gZm91bmRhdGlvbi5vcmc+OyBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0
LmNvbT47IFJhbHBoIENhbXBiZWxsDQo+IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT47IGhlamlhbmV0
QGdtYWlsLmNvbTsgS2FseSBYaW4gKEFybSBUZWNobm9sb2d5DQo+IENoaW5hKSA8S2FseS5YaW5A
YXJtLmNvbT47IG5kIDxuZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDEvM10g
YXJtNjQ6IGNwdWZlYXR1cmU6IGludHJvZHVjZSBoZWxwZXINCj4gY3B1X2hhc19od19hZigpDQo+
IA0KPiBPbiBTYXQsIFNlcCAyMSwgMjAxOSBhdCAwOTo1MDo1MlBNICswODAwLCBKaWEgSGUgd3Jv
dGU6DQo+ID4gV2UgdW5jb25kaXRpb25hbGx5IHNldCB0aGUgSFdfQUZEQk0gY2FwYWJpbGl0eSBh
bmQgb25seSBlbmFibGUgaXQgb24NCj4gPiBDUFVzIHdoaWNoIHJlYWxseSBoYXZlIHRoZSBmZWF0
dXJlLiBCdXQgc29tZXRpbWVzIHdlIG5lZWQgdG8ga25vdw0KPiA+IHdoZXRoZXIgdGhpcyBjcHUg
aGFzIHRoZSBjYXBhYmlsaXR5IG9mIEhXIEFGLiBTbyBkZWNvdXBsZSBBRiBmcm9tDQo+ID4gREJN
IGJ5IG5ldyBoZWxwZXIgY3B1X2hhc19od19hZigpLg0KPiA+DQo+ID4gUmVwb3J0ZWQtYnk6IGti
dWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogU3V6dWtp
IFBvdWxvc2UgPFN1enVraS5Qb3Vsb3NlQGFybS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlh
IEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9jcHVmZWF0dXJlLmggfCAxMCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9jcHVmZWF0dXJlLmgNCj4gYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmUu
aA0KPiA+IGluZGV4IGM5NmZmYTQ3MjJkMy4uNDZjYWY5MzRiYTRlIDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZS5oDQo+ID4gKysrIGIvYXJjaC9hcm02
NC9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlLmgNCj4gPiBAQCAtNjY3LDYgKzY2NywxNiBAQCBzdGF0
aWMgaW5saW5lIHUzMg0KPiBpZF9hYTY0bW1mcjBfcGFyYW5nZV90b19waHlzX3NoaWZ0KGludCBw
YXJhbmdlKQ0KPiA+ICAJZGVmYXVsdDogcmV0dXJuIENPTkZJR19BUk02NF9QQV9CSVRTOw0KPiA+
ICAJfQ0KPiA+ICB9DQo+ID4gKw0KPiA+ICsvKiBEZWNvdXBsZSBBRiBmcm9tIEFGREJNLiAqLw0K
PiANCj4gV2UgY291bGQgZG8gd2l0aCBhIGJldHRlciBjb21tZW50IGhlcmUgb3IganVzdCByZW1v
dmUgaXQgYWx0b2dldGhlci4gVGhlDQo+IGFpbSBvZiB0aGUgcGF0Y2ggd2FzIHRvIGRlY291cGxl
IEFGIGNoZWNrIGZyb20gdGhlIEFGK0RCTSBidXQgdGhlDQo+IGNvbW1lbnQgaGVyZSBzaG91bGQg
ZGVzY3JpYmUgd2hhdCB0aGUgZnVuY3Rpb24gZG9lcy4gTWF5YmUgc29tZXRoaW5nDQo+IGxpa2U6
ICJDaGVjayB3aGV0aGVyIGhhcmR3YXJlIHVwZGF0ZSBvZiB0aGUgQWNjZXNzIGZsYWcgaXMgc3Vw
cG9ydGVkIi4NCj4gDQoNCk9rYXksIEkgd2lsbCB1cGRhdGUgaXQNCg0KLS0NCkNoZWVycywNCkp1
c3RpbiAoSmlhIEhlKQ0KDQoNCj4gPiArc3RhdGljIGlubGluZSBib29sIGNwdV9oYXNfaHdfYWYo
dm9pZCkNCj4gPiArew0KPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSTTY0X0hXX0FGREJN
KSkNCj4gPiArCQlyZXR1cm4gcmVhZF9jcHVpZChJRF9BQTY0TU1GUjFfRUwxKSAmIDB4ZjsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gDQo+IE90aGVyIHRoYW4gdGhlIGNv
bW1lbnQgYWJvdmUsDQo+IA0KPiBSZXZpZXdlZC1ieTogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGlu
Lm1hcmluYXNAYXJtLmNvbT4NCg==
