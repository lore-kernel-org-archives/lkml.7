Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA6CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F1E217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 01:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="49gy/304";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KGPQVJaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437053AbfITBOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 21:14:39 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:44190
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390887AbfITBOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 21:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hASZ5lnA2fMYdbqtg2sSaBgIx1wRhRqbQ65d08lGlcM=;
 b=49gy/304BmQk4EIYIQRyUo3Lp1+QTNoU+A4OQKNfFhfyt73SY8ioqWyxHW8RgSZMFcBp/tKmcfidICIYoLHEIrWSNba7Tc7t1NYn49vZNA3Byu4voS6spMHh2TTN7q8C1bAHvy34a5o1ryW7rnzjK1/hMFqNsyKaLTme9uO4HIA=
Received: from VI1PR0801CA0089.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::33) by DB6PR0802MB2262.eurprd08.prod.outlook.com
 (2603:10a6:4:84::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.23; Fri, 20 Sep
 2019 01:14:32 +0000
Received: from AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by VI1PR0801CA0089.outlook.office365.com
 (2603:10a6:800:7d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Fri, 20 Sep 2019 01:14:32 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT052.mail.protection.outlook.com (10.152.17.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Fri, 20 Sep 2019 01:14:30 +0000
Received: ("Tessian outbound 5061e1b5386c:v31"); Fri, 20 Sep 2019 01:14:23 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5e7f0a330a35.3 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.1.56])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3818456F-3F5B-41C3-9122-10F9A371D00A.1;
        Fri, 20 Sep 2019 01:14:18 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5e7f0a330a35.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 20 Sep 2019 01:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/8T7usVNZIh/RwbBmw3A3Z/zWRpFUSXS0/xvPDmd3PcS5zH4OjpSrkWPoOKoGhGI42qgjQyqvFf+4kRstSiUrOvx9OwCxnirbFZRA5OuIFPBf893TqKJUQxbU07JoupYl3io9KZ6cF79gOx8FGZ3kqE5SqyVjZN/h3MwoAewFAFMlWrJ+82xfPz6ksFumJq+lsFWmWh10FwQpIo+zL49hyUqwfqI3PWcSme3BzgBDWefYhEHpLRvKhwQ1lDrxF8diCgT2bbxXmOznhWorggCjLfUNxwizc7F0zC3csUG4axGOQ6rjfqm4obJlUDF6Cc8hp8oWBp61e4/UMO0a7ReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdwA5JR3lk+jkz/qW0qE0D9SduBsjQjieMfu1RVWDaI=;
 b=Kw0eCL98D55OOyyq0EIdCGOfOa4fMUFZOd9dk9grHUWC9++/xPxBCZjII55nhsu0QAuvI9lMWJsVqTBjLtxlkOmMLQMe/3C7Big2SntvqOq9KW4usYJN/Gp6mQD9TNQGZGFh/Lcv2MSN1FWaSnTgtQ+7lMNft+lNiBs9+BerpzXSbfoHJuB+58sMs8m1BuG2AM3pZbSu7W5MHLo2Z5AUCIumr9Y8wYjV56D2GG75/zoKTANvc/SceLTp0GiHNQBUQRc6cFsCxlkbUG3p8yOW7pKdmJP+H75ZeMUwL372VRDRVOeG/d0WIvVG/FTPl+StAaqKqMbpUt6GuhF/UCQelw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdwA5JR3lk+jkz/qW0qE0D9SduBsjQjieMfu1RVWDaI=;
 b=KGPQVJaqzHl1rYlf0iKCCawCq2dl5AYta2m7Z0i8ueUa6VbFuPIxaChp+izgQLDc+g3kleKBRK05vhKMGN21dwgRw+Fu60Qz97WcyXyKnAoEQu81jMaJ+kwIzuPm6N7Zfv961pUXJA92cjX6h06r9Zv3iy/992tI8WSI7VqDs4Q=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3738.eurprd08.prod.outlook.com (20.178.46.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Fri, 20 Sep 2019 01:14:16 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.023; Fri, 20 Sep 2019
 01:14:16 +0000
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
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>
Subject: RE: [PATCH v5 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Topic: [PATCH v5 1/3] arm64: cpufeature: introduce helper
 cpu_has_hw_af()
Thread-Index: AQHVbwUNnLlX77/LA0SD3jlpnLQKQKczMs0AgACQdBA=
Date:   Fri, 20 Sep 2019 01:14:15 +0000
Message-ID: <DB7PR08MB3082C2800CC612FCF57242A4F7880@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190919161204.142796-1-justin.he@arm.com>
 <20190919161204.142796-2-justin.he@arm.com>
 <20190919163644.GD6472@arrakis.emea.arm.com>
In-Reply-To: <20190919163644.GD6472@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5986a0ef-d7e0-49a5-ba7a-06443398ca8a.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ad0a9e66-409b-4050-d23b-08d73d67e3dc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3738;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3738:|DB7PR08MB3738:|DB6PR0802MB2262:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2262FD76FDBE7616AF7C43C2F7880@DB6PR0802MB2262.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:605;OLM:605;
x-forefront-prvs: 0166B75B74
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(13464003)(189003)(199004)(229853002)(2906002)(86362001)(54906003)(76116006)(7696005)(76176011)(71200400001)(81156014)(71190400001)(14454004)(66476007)(66946007)(8676002)(6116002)(81166006)(3846002)(25786009)(8936002)(6636002)(99286004)(478600001)(316002)(33656002)(446003)(53546011)(476003)(5660300002)(7736002)(11346002)(6506007)(305945005)(7416002)(55016002)(6246003)(256004)(66066001)(26005)(6862004)(6436002)(52536014)(102836004)(55236004)(186003)(486006)(74316002)(66556008)(64756008)(66446008)(4326008)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3738;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: PTkOyixXLXkIZpgXfQ1NdN7ALmXczU8NgNT8TvwQIDKqwfabzJWT30nZV0Od3CpVbudI7NfAqtNdgJ5iW6mpMywtmw20iadYd2kn16rlgwL22WT/fmfWNSg6KuNWETuZ0RKCEX0JbMflB4n9nggRhnZii4i9IwBvVzeu5w8N3LVktCoUxy7uiRI+eN7I2RsOpbj3O2k/HlBnclnsc5rRcKHae1t2/ESiGYPGGeZaF+8HyCxYKEW8OSqyycXHnuKuM7IbIRBZjdnKWfROPCk/RZ9GpLuMcN2s/rCPrZjFqIu20gIqeJCaP7e77TeZjHOVn3YjzeTKRQ+Q6aK44NJtTEDp93jCKx59HlknRJEAWvNkIZ8qv/osEPl3QLbsSpgOJXIQUf7AEIAwYpVv501Ig7VaEXE2uOGtNntboZvCRL0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3738
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(13464003)(40434004)(199004)(189003)(86362001)(76130400001)(356004)(74316002)(70586007)(70206006)(486006)(6246003)(316002)(36906005)(50466002)(476003)(305945005)(7736002)(11346002)(436003)(63350400001)(52536014)(336012)(126002)(6862004)(446003)(5024004)(186003)(55016002)(6636002)(33656002)(102836004)(22756006)(14454004)(14444005)(54906003)(26005)(26826003)(4326008)(66574012)(9686003)(478600001)(53546011)(81166006)(6506007)(8936002)(2906002)(76176011)(66066001)(229853002)(81156014)(8676002)(6116002)(5660300002)(7696005)(25786009)(47776003)(99286004)(3846002)(23676004)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2262;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 35da8c21-1d57-4787-a947-08d73d67daef
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR0802MB2262;
X-Forefront-PRVS: 0166B75B74
X-Microsoft-Antispam-Message-Info: T4vQyp73z81cEsCR5i6mS19eIkBDTHgqKb0/qVrkbpcHaAFZCPpW9CQqhd/CACAzPES7d6M5PdlsnMoI7vXOFjHSUWRJpoWPMpNcP6fFDs1NpEoH9jWZnfTaTNYUw/68TejyrokJJgh4ZgIxqgLQH28PfvrR2ugjI3+A1cc80a2U8d9FALPEm6zhiMWaD7uj8bgU370ZOxggOjTpewdpDwwC0NWABfuzCR65BF/Dk1cyJVDBfgToPJlHNy3nJqjl2JkFxvcEps6immksrju+Cr+kcVcnWOkB89x5iKtkEuwY3afcNDI/EGLJhZ6Adfif0AKMnjzS/DdclpzbpWsKooCkmwECZ8sNZavR3gChHmwKrHkkoDPKHDIbAkZAGruXRpG7nVe3YIIgg7NPi8y9TWtqbkO5S/9LIW6uNl0C/68=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2019 01:14:30.9509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0a9e66-409b-4050-d23b-08d73d67e3dc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBDYXRhbGluDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFNlbnQ6IDIwMTnlubQ55pyI
MjDml6UgMDozNw0KPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPEp1c3Rp
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
YXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzNdIGFybTY0OiBjcHVmZWF0dXJl
OiBpbnRyb2R1Y2UgaGVscGVyDQo+IGNwdV9oYXNfaHdfYWYoKQ0KPg0KPiBPbiBGcmksIFNlcCAy
MCwgMjAxOSBhdCAxMjoxMjowMkFNICswODAwLCBKaWEgSGUgd3JvdGU6DQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBiL2FyY2gvYXJtNjQva2VybmVs
L2NwdWZlYXR1cmUuYw0KPiA+IGluZGV4IGIxZmRjNDg2YWVkOC4uZmIwZTk0MjVkMjg2IDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYw0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYw0KPiA+IEBAIC0xMTQxLDYgKzExNDEsMTYgQEAg
c3RhdGljIGJvb2wgaGFzX2h3X2RibShjb25zdCBzdHJ1Y3QNCj4gYXJtNjRfY3B1X2NhcGFiaWxp
dGllcyAqY2FwLA0KPiA+ICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAgfQ0KPiA+DQo+ID4gKy8qIERl
Y291cGxlIEFGIGZyb20gQUZEQk0uICovDQo+ID4gK2Jvb2wgY3B1X2hhc19od19hZih2b2lkKQ0K
PiA+ICt7DQo+ID4gKyAgIHJldHVybiAocmVhZF9jcHVpZChJRF9BQTY0TU1GUjFfRUwxKSAmIDB4
Zik7DQo+ID4gK30NCj4gPiArI2Vsc2UgLyogQ09ORklHX0FSTTY0X0hXX0FGREJNICovDQo+ID4g
K2Jvb2wgY3B1X2hhc19od19hZih2b2lkKQ0KPiA+ICt7DQo+ID4gKyAgIHJldHVybiBmYWxzZTsN
Cj4gPiArfQ0KPiA+ICAjZW5kaWYNCj4NCj4gUGxlYXNlIHBsYWNlIHRoaXMgZnVuY3Rpb24gaW4g
Y3B1ZmVhdHVyZS5oIGRpcmVjdGx5LCBubyBuZWVkIGZvciBhbg0KPiBhZGRpdGlvbmFsIGZ1bmN0
aW9uIGNhbGwuIFNvbWV0aGluZyBsaWtlOg0KPg0KPiBzdGF0aWMgaW5saW5lIGJvb2wgY3B1X2hh
c19od19hZih2b2lkKQ0KPiB7DQo+ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19BUk02NF9I
V19BRkRCTSkpDQo+ICAgICAgICAgICAgICAgcmV0dXJuIHJlYWRfY3B1aWQoSURfQUE2NE1NRlIx
X0VMMSkgJiAweGY7DQo+ICAgICAgIHJldHVybiBmYWxzZTsNCj4gfQ0KPg0KT2ssIHRoYW5rcw0K
DQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0KPiAtLQ0KPiBDYXRhbGluDQpJTVBP
UlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBh
cmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBp
bW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIg
cGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZv
cm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
