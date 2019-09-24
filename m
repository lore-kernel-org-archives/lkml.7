Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA51BC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0A020665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tBz3ijgT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tBz3ijgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503933AbfIXGnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:43:37 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:27636
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503902AbfIXGnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nmXfkKGPqzkrPM3r75eFIbvyYOx/1r6a6VcBt20azU=;
 b=tBz3ijgTmlmUOxgI2pArZOlk3kFmZ2kCsTAkZBzbjIGdcXVF6cX9/LUHS4XQ7rEs5stHwDNQoSupOgpULGeeFiXND7MLUWBlMhKc3BgTrveNuxgPilnDcqcgxeNa574gFYMpTg8/+CHHyUWeaF12gkOWr8qySJ5du3d8dP+N/6Q=
Received: from VE1PR08CA0032.eurprd08.prod.outlook.com (2603:10a6:803:104::45)
 by DB7PR08MB3897.eurprd08.prod.outlook.com (2603:10a6:10:7e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.23; Tue, 24 Sep
 2019 06:43:24 +0000
Received: from VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VE1PR08CA0032.outlook.office365.com
 (2603:10a6:803:104::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 06:43:24 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT010.mail.protection.outlook.com (10.152.18.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Tue, 24 Sep 2019 06:43:23 +0000
Received: ("Tessian outbound d5a1f2820a4f:v31"); Tue, 24 Sep 2019 06:43:16 +0000
X-CR-MTA-TID: 64aa7808
Received: from fd047ad28d33.3 (cr-mta-lb-1.cr-mta-net [104.47.5.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3752C817-0037-4B55-9613-DF5D7AE54426.1;
        Tue, 24 Sep 2019 06:43:11 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fd047ad28d33.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 24 Sep 2019 06:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6CqOM55OS1YXJ0JZ5/mDCSt9FNEFVsyiiHxN1lSDCOVJAZM0hy8uGBRlFy/grQxr5uepISAgqfA+bXb3CoD+SVYcyF0iuqdiHDVvlQG2sRUDdYfsjZ4uFSHClCItZfX75BosLEMRs8hx+aT53t3sdu4OA+vfve+JO1WS8WmmY/auN7Gaot8H6ZEvHQgBvp0ey8+IyEj7ROUygeuxFdZW9a95p8mlRFU8jgRDVjWXNkz4fMy8bxV4XEHJmU0IPJPU27Jk9++MbWcSytaKlVVRHOrv8Bz5duhP9d74GFRaI7VWIOWJy6LHfZDpt77cdV4YVy3aNPsR9M3gN5HvlMo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nmXfkKGPqzkrPM3r75eFIbvyYOx/1r6a6VcBt20azU=;
 b=njlWYpP6JxR8Pv6xWBA+amD9lde5km5tJfGIxEe0xcRJ3QaW0nwcrFVZaQbv9zv8U5LuszHN5N8ogRvH8rl9xOSZYwdw7pfYxXTRECyvyTKkboTuAmpKFpnAphMTOnTUwiygTxp8b1O7XW8h0lLmzi60wZ44TPUZ0dIGZYMjf+VMLHjh2LOXH9hBlgQFdFaAejJX1n48XLy7YKCwlNxUN+qGhh5BP1+xeJ07jgtSxzPwAX18ILXMyk4o4Veq2u8BjLFkmbDDe97o1KGMNpBme4yzRKTUr4PdvQcakAhsX/APlsgOhMsPExelTfZLCv9qGAv94htYMUxA331XMr6rQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nmXfkKGPqzkrPM3r75eFIbvyYOx/1r6a6VcBt20azU=;
 b=tBz3ijgTmlmUOxgI2pArZOlk3kFmZ2kCsTAkZBzbjIGdcXVF6cX9/LUHS4XQ7rEs5stHwDNQoSupOgpULGeeFiXND7MLUWBlMhKc3BgTrveNuxgPilnDcqcgxeNa574gFYMpTg8/+CHHyUWeaF12gkOWr8qySJ5du3d8dP+N/6Q=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB2985.eurprd08.prod.outlook.com (52.134.111.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Tue, 24 Sep 2019 06:43:07 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::3dcd:d5e4:c17:489d%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 06:43:07 +0000
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
Subject: RE: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Topic: [PATCH v8 3/3] mm: fix double page fault on arm64 if PTE_AF is
 cleared
Thread-Index: AQHVcIOw3L75rYJgH0mXRXYBOBIp/qc5gOoAgACfjkA=
Date:   Tue, 24 Sep 2019 06:43:06 +0000
Message-ID: <DB7PR08MB3082BC38536AE16B056AEA05F7840@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190921135054.142360-1-justin.he@arm.com>
 <20190921135054.142360-4-justin.he@arm.com>
 <20190923170433.GE10192@arrakis.emea.arm.com>
In-Reply-To: <20190923170433.GE10192@arrakis.emea.arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: e18b5369-d082-468d-bc6a-a985d5a40bf6.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b2a48544-60a4-428e-c487-08d740ba7ee6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB2985;
X-MS-TrafficTypeDiagnostic: DB7PR08MB2985:|DB7PR08MB2985:|DB7PR08MB3897:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB3897EA579317D5C85D0113B1F7840@DB7PR08MB3897.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(13464003)(55674003)(199004)(189003)(6436002)(81166006)(55236004)(186003)(25786009)(7416002)(229853002)(9686003)(6246003)(14444005)(7696005)(256004)(52536014)(55016002)(4326008)(8936002)(5660300002)(81156014)(8676002)(54906003)(6862004)(33656002)(6636002)(2906002)(66574012)(316002)(99286004)(86362001)(6116002)(476003)(3846002)(66066001)(74316002)(478600001)(14454004)(66556008)(66946007)(66446008)(102836004)(26005)(71200400001)(64756008)(446003)(71190400001)(6506007)(305945005)(486006)(76176011)(66476007)(11346002)(53546011)(76116006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2985;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: rfJY2sipMA9rGqRpDl3Ry60DzQlHoHttAdOKGD/kiTdVwTdVNlCL+itsQocR8ZRwdyGKNEN6lLdXa5ZaUq5w8bCOK2oSa/CPb9dhPJMM7DMEw2mCSmipKLemOkMeFYw7LcOJaND4/b0mXQ8+q7Chv1+E8YIMkNIa+kzkx+3YFxy6XtoPqEQ/fSsybqmorObqcWM2v0pd9oUG8OTlq5AQndmHaBk+ZjAK2Lgc8rHIdkUFqhvEL9jmrXSmyC2oQhwwoAZfmNe5I0EHarXVmY9ObnisSwCT7M13MrXn19PPAwGjkQVf4OMNVMm/s/zMHCcuABI1uNX0dOjJlGWoN/95w1ym2CcBdqq8g2vXChFveRyNKXBHAruvXJGiZnWlJYeZDnSw3iNLsQUBBa9HSZZLe3kKr9mt0S/OYGDM06WqXZg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2985
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(55674003)(13464003)(189003)(199004)(11346002)(14454004)(76176011)(70586007)(66574012)(36906005)(99286004)(33656002)(446003)(336012)(486006)(70206006)(63350400001)(26826003)(8676002)(76130400001)(14444005)(6506007)(25786009)(6636002)(81166006)(9686003)(23676004)(81156014)(7736002)(5660300002)(55016002)(7696005)(74316002)(2486003)(126002)(476003)(436003)(316002)(6246003)(356004)(66066001)(8936002)(52536014)(4326008)(478600001)(86362001)(53546011)(54906003)(2906002)(26005)(47776003)(6116002)(3846002)(22756006)(305945005)(186003)(6862004)(229853002)(102836004)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3897;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9badfe3b-0ec0-4121-00e2-08d740ba755a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR08MB3897;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: bo8A/AWIsMKK2cSNJEUGwyT8x4EubjFQIn4KGBG7earwnjhzuDjwhFA0Jgbpn0gVwXb9VQA0V+BaHu5WzO6bYlpMr057uwMcL57mEaC4rvuVlBExY6LAVPSIBRY2j+n6LhRW1YUo1+M+yUuN1uYXxL0XS6Rza53fG0U7zxmGzfamFvy7fAr2Pvk1Sg8yQ5NmtbN6iNenbaV4ZZ1stM4Xhaux1uDkuVJs2+fI3q/n+qlbUTKrhvg6u+CBy3iJxDlNmxcf+bAlio7hsySD410mXJ2mBjlpoJbpsAbfZkL7Y87d1ANK67iaxK2OWxKGhrPcix/GbC2N/Hdlz3lh4Nq6sM3XpN+xms6LBzvkEcnEKrngoWSBv1g2tR7HG3Wco7secmNNhd6/80i3tBcs2GRPfDP69mujn4J7+JJiN0wQVWk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 06:43:23.2051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a48544-60a4-428e-c487-08d740ba7ee6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2F0YWxpbg0KUGxlYXNlIHNlZSBhbiBpbXBvcnRhbnQgY29tbWVudCBpbmxpbmUsIHRoYW5r
cw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENhdGFsaW4gTWFyaW5h
cyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+IFNlbnQ6IDIwMTnlubQ55pyIMjTml6UgMTow
NQ0KPiBUbzogSnVzdGluIEhlIChBcm0gVGVjaG5vbG9neSBDaGluYSkgPEp1c3Rpbi5IZUBhcm0u
Y29tPg0KPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZA0K
PiA8TWFyay5SdXRsYW5kQGFybS5jb20+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9yc2VAYXJtLmNv
bT47IE1hcmMNCj4gWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+OyBNYXR0aGV3IFdpbGNveCA8d2ls
bHlAaW5mcmFkZWFkLm9yZz47IEtpcmlsbCBBLg0KPiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92
QGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmc7
IFN1enVraSBQb3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBhcm0uY29tPjsgUHVuaXQNCj4gQWdyYXdh
bCA8cHVuaXRhZ3Jhd2FsQGdtYWlsLmNvbT47IEFuc2h1bWFuIEtoYW5kdWFsDQo+IDxBbnNodW1h
bi5LaGFuZHVhbEBhcm0uY29tPjsgQWxleCBWYW4gQnJ1bnQNCj4gPGF2YW5icnVudEBudmlkaWEu
Y29tPjsgUm9iaW4gTXVycGh5IDxSb2Jpbi5NdXJwaHlAYXJtLmNvbT47DQo+IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC0NCj4g
Zm91bmRhdGlvbi5vcmc+OyBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT47IFJh
bHBoIENhbXBiZWxsDQo+IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT47IGhlamlhbmV0QGdtYWlsLmNv
bTsgS2FseSBYaW4gKEFybSBUZWNobm9sb2d5DQo+IENoaW5hKSA8S2FseS5YaW5AYXJtLmNvbT47
IG5kIDxuZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDMvM10gbW06IGZpeCBk
b3VibGUgcGFnZSBmYXVsdCBvbiBhcm02NCBpZiBQVEVfQUYNCj4gaXMgY2xlYXJlZA0KPiANCj4g
T24gU2F0LCBTZXAgMjEsIDIwMTkgYXQgMDk6NTA6NTRQTSArMDgwMCwgSmlhIEhlIHdyb3RlOg0K
PiA+IEBAIC0yMTUxLDIxICsyMTYzLDUzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3dfdXNlcl9w
YWdlKHN0cnVjdCBwYWdlDQo+ICpkc3QsIHN0cnVjdCBwYWdlICpzcmMsIHVuc2lnbmVkIGxvDQo+
ID4gIAkgKiBmYWlscywgd2UganVzdCB6ZXJvLWZpbGwgaXQuIExpdmUgd2l0aCBpdC4NCj4gPiAg
CSAqLw0KPiA+ICAJaWYgKHVubGlrZWx5KCFzcmMpKSB7DQo+ID4gLQkJdm9pZCAqa2FkZHIgPSBr
bWFwX2F0b21pYyhkc3QpOw0KPiA+IC0JCXZvaWQgX191c2VyICp1YWRkciA9ICh2b2lkIF9fdXNl
ciAqKSh2YSAmIFBBR0VfTUFTSyk7DQo+ID4gKwkJdm9pZCAqa2FkZHI7DQo+ID4gKwkJcHRlX3Qg
ZW50cnk7DQo+ID4gKwkJdm9pZCBfX3VzZXIgKnVhZGRyID0gKHZvaWQgX191c2VyICopKGFkZHIg
JiBQQUdFX01BU0spOw0KPiA+DQo+ID4gKwkJLyogT24gYXJjaGl0ZWN0dXJlcyB3aXRoIHNvZnR3
YXJlICJhY2Nlc3NlZCIgYml0cywgd2Ugd291bGQNCj4gPiArCQkgKiB0YWtlIGEgZG91YmxlIHBh
Z2UgZmF1bHQsIHNvIG1hcmsgaXQgYWNjZXNzZWQgaGVyZS4NCj4gPiArCQkgKi8NCj4gDQo+IE5p
dHBpY2s6IHBsZWFzZSBmb2xsb3cgdGhlIGtlcm5lbCBjb2Rpbmcgc3R5bGUgZm9yIG11bHRpLWxp
bmUgY29tbWVudHMNCj4gKGFib3ZlIGFuZCB0aGUgZm9yIHRoZSByZXN0IG9mIHRoZSBwYXRjaCk6
DQo+IA0KPiAJCS8qDQo+IAkJICogWW91ciBtdWx0aS1saW5lIGNvbW1lbnQuDQo+IAkJICovDQo+
IA0KPiA+ICsJCWlmIChhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKCkgJiYgIXB0ZV95b3VuZyh2bWYt
Pm9yaWdfcHRlKSkNCj4gew0KPiA+ICsJCQl2bWYtPnB0ZSA9IHB0ZV9vZmZzZXRfbWFwX2xvY2so
bW0sIHZtZi0+cG1kLA0KPiBhZGRyLA0KPiA+ICsJCQkJCQkgICAgICAgJnZtZi0+cHRsKTsNCj4g
PiArCQkJaWYgKGxpa2VseShwdGVfc2FtZSgqdm1mLT5wdGUsIHZtZi0+b3JpZ19wdGUpKSkgew0K
PiA+ICsJCQkJZW50cnkgPSBwdGVfbWt5b3VuZyh2bWYtPm9yaWdfcHRlKTsNCj4gPiArCQkJCWlm
IChwdGVwX3NldF9hY2Nlc3NfZmxhZ3Modm1hLCBhZGRyLA0KPiA+ICsJCQkJCQkJICB2bWYtPnB0
ZSwgZW50cnksIDApKQ0KPiA+ICsJCQkJCXVwZGF0ZV9tbXVfY2FjaGUodm1hLCBhZGRyLCB2bWYt
DQo+ID5wdGUpOw0KPiA+ICsJCQl9IGVsc2Ugew0KPiA+ICsJCQkJLyogT3RoZXIgdGhyZWFkIGhh
cyBhbHJlYWR5IGhhbmRsZWQgdGhlDQo+IGZhdWx0DQo+ID4gKwkJCQkgKiBhbmQgd2UgZG9uJ3Qg
bmVlZCB0byBkbyBhbnl0aGluZy4gSWYgaXQncw0KPiA+ICsJCQkJICogbm90IHRoZSBjYXNlLCB0
aGUgZmF1bHQgd2lsbCBiZSB0cmlnZ2VyZWQNCj4gPiArCQkJCSAqIGFnYWluIG9uIHRoZSBzYW1l
IGFkZHJlc3MuDQo+ID4gKwkJCQkgKi8NCj4gPiArCQkJCXB0ZV91bm1hcF91bmxvY2sodm1mLT5w
dGUsIHZtZi0+cHRsKTsNCj4gPiArCQkJCXJldHVybiBmYWxzZTsNCj4gPiArCQkJfQ0KPiA+ICsJ
CQlwdGVfdW5tYXBfdW5sb2NrKHZtZi0+cHRlLCB2bWYtPnB0bCk7DQo+ID4gKwkJfQ0KPiANCj4g
QW5vdGhlciBuaXQsIHlvdSBjb3VsZCByZXdyaXRlIHRoaXMgYmxvY2sgc2xpZ2h0bHkgdG8gYXZv
aWQgdG9vIG11Y2gNCj4gaW5kZW50YXRpb24uIFNvbWV0aGluZyBsaWtlICh1bnRlc3RlZCk6DQo+
IA0KPiAJCWlmIChhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKCkgJiYgIXB0ZV95b3VuZyh2bWYtPm9y
aWdfcHRlKSkNCj4gew0KPiAJCQl2bWYtPnB0ZSA9IHB0ZV9vZmZzZXRfbWFwX2xvY2sobW0sIHZt
Zi0+cG1kLA0KPiBhZGRyLA0KPiAJCQkJCQkgICAgICAgJnZtZi0+cHRsKTsNCj4gCQkJaWYgKHVu
bGlrZWx5KCFwdGVfc2FtZSgqdm1mLT5wdGUsIHZtZi0+b3JpZ19wdGUpKSkgew0KPiAJCQkJLyoN
Cj4gCQkJCSAqIE90aGVyIHRocmVhZCBoYXMgYWxyZWFkeSBoYW5kbGVkIHRoZSBmYXVsdA0KPiAJ
CQkJICogYW5kIHdlIGRvbid0IG5lZWQgdG8gZG8gYW55dGhpbmcuIElmIGl0J3MNCj4gCQkJCSAq
IG5vdCB0aGUgY2FzZSwgdGhlIGZhdWx0IHdpbGwgYmUgdHJpZ2dlcmVkDQo+IAkJCQkgKiBhZ2Fp
biBvbiB0aGUgc2FtZSBhZGRyZXNzLg0KPiAJCQkJICovDQo+IAkJCQlwdGVfdW5tYXBfdW5sb2Nr
KHZtZi0+cHRlLCB2bWYtPnB0bCk7DQo+IAkJCQlyZXR1cm4gZmFsc2U7DQo+IAkJCX0NCj4gCQkJ
ZW50cnkgPSBwdGVfbWt5b3VuZyh2bWYtPm9yaWdfcHRlKTsNCj4gCQkJaWYgKHB0ZXBfc2V0X2Fj
Y2Vzc19mbGFncyh2bWEsIGFkZHIsDQo+IAkJCQkJCSAgdm1mLT5wdGUsIGVudHJ5LCAwKSkNCj4g
CQkJCXVwZGF0ZV9tbXVfY2FjaGUodm1hLCBhZGRyLCB2bWYtPnB0ZSk7DQo+IAkJCXB0ZV91bm1h
cF91bmxvY2sodm1mLT5wdGUsIHZtZi0+cHRsKTsNCj4gCQl9DQo+IA0KPiA+ICsNCj4gPiArCQlr
YWRkciA9IGttYXBfYXRvbWljKGRzdCk7DQo+IA0KPiBTaW5jZSB5b3UgbW92ZWQgdGhlIGttYXBf
YXRvbWljKCkgaGVyZSwgY291bGQgdGhlIGFib3ZlDQo+IGFyY2hfZmF1bHRzX29uX29sZF9wdGUo
KSBydW4gaW4gYSBwcmVlbXB0aWJsZSBjb250ZXh0PyBJIHN1Z2dlc3RlZCB0bw0KPiBhZGQgYSBX
QVJOX09OIGluIHBhdGNoIDIgdG8gYmUgc3VyZS4NCg0KU2hvdWxkIEkgbW92ZSBrbWFwX2F0b21p
YyBiYWNrIHRvIHRoZSBvcmlnaW5hbCBsaW5lPyBUaHVzLCB3ZSBjYW4gbWFrZSBzdXJlDQp0aGF0
IGFyY2hfZmF1bHRzX29uX29sZF9wdGUoKSBpcyBpbiB0aGUgY29udGV4dCBvZiBwcmVlbXB0X2Rp
c2FibGVkPw0KT3RoZXJ3aXNlLCBhcmNoX2ZhdWx0c19vbl9vbGRfcHRlKCkgbWF5IGNhdXNlIHBs
ZW50eSBvZiB3YXJuaW5nIGlmIEkgYWRkDQphIFdBUk5fT04gaW4gYXJjaF9mYXVsdHNfb25fb2xk
X3B0ZS4gIEkgdGVzdGVkIGl0IHdoZW4gSSBlbmFibGUgdGhlIFBSRUVNUFQ9eQ0Kb24gYSBUaHVu
ZGVyWDIgcWVtdSBndWVzdC4NCg0KDQotLQ0KQ2hlZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0K
PiANCj4gPiAgCQkvKg0KPiA+ICAJCSAqIFRoaXMgcmVhbGx5IHNob3VsZG4ndCBmYWlsLCBiZWNh
dXNlIHRoZSBwYWdlIGlzIHRoZXJlDQo+ID4gIAkJICogaW4gdGhlIHBhZ2UgdGFibGVzLiBCdXQg
aXQgbWlnaHQganVzdCBiZSB1bnJlYWRhYmxlLA0KPiA+ICAJCSAqIGluIHdoaWNoIGNhc2Ugd2Ug
anVzdCBnaXZlIHVwIGFuZCBmaWxsIHRoZSByZXN1bHQgd2l0aA0KPiA+ICAJCSAqIHplcm9lcy4N
Cj4gPiAgCQkgKi8NCj4gPiAtCQlpZiAoX19jb3B5X2Zyb21fdXNlcl9pbmF0b21pYyhrYWRkciwg
dWFkZHIsIFBBR0VfU0laRSkpDQo+ID4gKwkJaWYgKF9fY29weV9mcm9tX3VzZXJfaW5hdG9taWMo
a2FkZHIsIHVhZGRyLCBQQUdFX1NJWkUpKSB7DQo+ID4gKwkJCS8qIEdpdmUgYSB3YXJuIGluIGNh
c2UgdGhlcmUgY2FuIGJlIHNvbWUgb2JzY3VyZQ0KPiA+ICsJCQkgKiB1c2UtY2FzZQ0KPiA+ICsJ
CQkgKi8NCj4gPiArCQkJV0FSTl9PTl9PTkNFKDEpOw0KPiANCj4gVGhhdCdzIG1vcmUgb2YgYSBx
dWVzdGlvbiBmb3IgdGhlIG1tIGd1eXM6IGF0IHRoaXMgcG9pbnQgd2UgZG8gdGhlDQo+IGNvcHlp
bmcgd2l0aCB0aGUgcHRsIHJlbGVhc2VkOyBpcyB0aGVyZSBhbnl0aGluZyBlbHNlIHRoYXQgY291
bGQgaGF2ZQ0KPiBtYWRlIHRoZSBwdGUgb2xkIGluIHRoZSBtZWFudGltZT8gSSB0aGluayB1bnVz
ZV9wdGUoKSBpcyBvbmx5IGNhbGxlZCBvbg0KPiBhbm9ueW1vdXMgdm1hcywgc28gaXQgc2hvdWxk
bid0IGJlIHRoZSBjYXNlIGhlcmUuDQo+IA0KPiA+ICAJCQljbGVhcl9wYWdlKGthZGRyKTsNCj4g
PiArCQl9DQo+ID4gIAkJa3VubWFwX2F0b21pYyhrYWRkcik7DQo+ID4gIAkJZmx1c2hfZGNhY2hl
X3BhZ2UoZHN0KTsNCj4gPiAgCX0gZWxzZQ0KPiA+IC0JCWNvcHlfdXNlcl9oaWdocGFnZShkc3Qs
IHNyYywgdmEsIHZtYSk7DQo+ID4gKwkJY29weV91c2VyX2hpZ2hwYWdlKGRzdCwgc3JjLCBhZGRy
LCB2bWEpOw0KPiA+ICsNCj4gPiArCXJldHVybiB0cnVlOw0KPiA+ICB9DQo+IA0KPiAtLQ0KPiBD
YXRhbGluDQo=
