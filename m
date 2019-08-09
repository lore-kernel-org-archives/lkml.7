Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203DAC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06342086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 10:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i1nbwsMz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iiyHwhVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406447AbfHIK4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 06:56:31 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:40005
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405928AbfHIK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+K2u7m8VQglbBdju9n9+gJh1prbQM8eTIb6RZI/Q8w=;
 b=i1nbwsMz5rNxXQ5CrWCgeVp9/fHtauZptPayITvCiSO4gl2tc+h7c+/RD3vN4N83rIkdgTF5D5Cu4qUS7KycxOT5GimjsFeiD+6ibsTVR3w8o9FGDD7g0Oo0poilV3ObP5+lnQ6immL6wuFseI44V2+955wVtSBXgBGcIM/UPHc=
Received: from VI1PR08CA0100.eurprd08.prod.outlook.com (2603:10a6:800:d3::26)
 by VI1PR0801MB1855.eurprd08.prod.outlook.com (2603:10a6:800:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15; Fri, 9 Aug
 2019 10:56:18 +0000
Received: from VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::208) by VI1PR08CA0100.outlook.office365.com
 (2603:10a6:800:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.14 via Frontend
 Transport; Fri, 9 Aug 2019 10:56:18 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT054.mail.protection.outlook.com (10.152.19.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 9 Aug 2019 10:56:16 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Fri, 09 Aug 2019 10:56:11 +0000
X-CR-MTA-TID: 64aa7808
Received: from 65c5bba726de.1 (cr-mta-lb-1.cr-mta-net [104.47.1.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8228BA48-3C1D-4E53-90F0-17430C596893.1;
        Fri, 09 Aug 2019 10:56:06 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 65c5bba726de.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 09 Aug 2019 10:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jURJZbmKqKefHN7adu/i4/idX/qOOC1LBQ6jHSMJe3sORDldzuHzHHOmdZWeEnSDiBHOwEhS6ePmwoISHDoEjb0GSCqhuJRbC1KAFTnp5SO2LwBTnlZWRAWo4xAQa+jMkZunU5al8A2AmwLZ0i4kpLyUZyNCrJ2f5tiEcC5e5utW1y3dpwIbruR0y5ESTiVgXiUPtBsZ30dVcvp7BYI/UULhT960eqQCP6eaN+a7q8CC40MYuWdfh5Gv7vYNEV4mxvMO4gV47ualN18kxkKhrbt5X7WWZ7z03oeLjlNLvQBoRcVu/1sJoIFVRgxscQbmHm6K7CroiO8ubTj+bvcFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVhb3QP8F3FbnFywKTdRj95pJmrMaLa+wYlOyDSBx88=;
 b=dkVFzPhpn551gUWlb1kyIi/A1s/fT9iZYQQ4H1vgCtl/ppVhuDm3WjO+PvrSQi9viZVIwWrORiP/LkiDoLnxHcOpnFQvgDJXplVTFFEgN6Yyb4MUhdXwgtPmxHooIxgEuAx9S9YuTz99aiUZdnhfsrp/V9cuEVDbSF2GbQRcGfuC5ZTDurD5PQDITqZXc3xuopfVWSTOe04IY82+CSdsR/g52/Ws8RrEGRFpBauOAmpUpJf6CJWv5Mu8t2edoaeh7ul0qco35kMHPYWKAcmgbXU/gEDL398YxoHY4Jkhrxz17kBmcllAjMR/HU/kCBWydNRvoB7ztjBJ+1ID6l7wTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVhb3QP8F3FbnFywKTdRj95pJmrMaLa+wYlOyDSBx88=;
 b=iiyHwhVtcEHX1clHEMa5TY8/MsKtupXaPn3qZrCgqZg4ZCdVwpQ1Y1I8ZZ4BE2haxBA1Ggvqjq3BLTE26rndMcv/bz6J03/fefwwCHFN5oV4V81q2SVLNb3T+COJZdxCZtxvVHuyEvow6HZG105t8+LNdB9+OBnt6ZL7A4n4e9s=
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com (52.134.110.24) by
 DB7PR08MB3642.eurprd08.prod.outlook.com (20.177.120.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Fri, 9 Aug 2019 10:56:04 +0000
Received: from DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::a13f:5848:5d6d:beef]) by DB7PR08MB3082.eurprd08.prod.outlook.com
 ([fe80::a13f:5848:5d6d:beef%5]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 10:56:04 +0000
From:   "Justin He (Arm Technology China)" <Justin.He@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Kees Cook" <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: RE: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid
 pointers for %pD
Thread-Topic: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid
 pointers for %pD
Thread-Index: AQHVTlFi3Xg58F0mk0itPSqLumHfBKbypEqAgAAAY/A=
Date:   Fri, 9 Aug 2019 10:56:04 +0000
Message-ID: <DB7PR08MB3082C27A075C410FE339F308F7D60@DB7PR08MB3082.eurprd08.prod.outlook.com>
References: <20190809012457.56685-1-justin.he@arm.com>
 <CAHp75VcR1rJ5AX_Nj3n2NnMasLRp74Y3R6Mh4XQ5s64aKrF6tw@mail.gmail.com>
In-Reply-To: <CAHp75VcR1rJ5AX_Nj3n2NnMasLRp74Y3R6Mh4XQ5s64aKrF6tw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 74d556d6-bd0c-4451-b991-abc2113b7b20.0
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
x-originating-ip: [113.29.88.7]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 53b10bb7-36ee-4a8d-94e5-08d71cb833d6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3642;
X-MS-TrafficTypeDiagnostic: DB7PR08MB3642:|VI1PR0801MB1855:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB18556D67F8152E2C82B9099CF7D60@VI1PR0801MB1855.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2803;OLM:2803;
x-forefront-prvs: 01244308DF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(13464003)(189003)(199004)(14454004)(4326008)(54906003)(316002)(7416002)(71200400001)(71190400001)(86362001)(256004)(74316002)(25786009)(33656002)(7736002)(305945005)(229853002)(6916009)(2906002)(6436002)(52536014)(66066001)(55236004)(5660300002)(66476007)(66556008)(64756008)(66946007)(76116006)(3846002)(6116002)(66446008)(6506007)(486006)(11346002)(102836004)(53546011)(76176011)(446003)(53936002)(81156014)(81166006)(476003)(186003)(6246003)(8936002)(26005)(478600001)(8676002)(7696005)(55016002)(9686003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3642;H:DB7PR08MB3082.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: BptKx9bLu2OPVhQn8rdzsz7p5sC819eLrkQ1bJU4LsBNrQ4IfZrCEeiKKk+znlgvcn0MQAsWdWI6q3hyxjZCBo2AsOk8SrGYeedaJ0gBzeCSI8vAxhquPaj6QT7tRe7FwStUoNFbzJwLMdBP5njQp8IOOgH9D55tvPbWUj4bPYsebCAucyCHFS15Y3ACjJjFHXdS2mgHqwopC5KgNSlQQEUEf1MeinfNNQ4iq00SqQxNYLggSIVimrrJfskAZO38FzbEosMjdocj7ZFJt19VJAVk5ik/Qd5IyhBges5ZHhnvXz8NmJ80z2T+Tswl8/KgAcehLTSfB1QQDYNSWcl6qCLwI1du+6VnSpGWvyQG+I+Gtsd0U/lOq7+VXnSEeL1/bAt/YQ7936OpupakIa3/NoQajfkwSjn6I7Jm2v0fd0M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3642
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Justin.He@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(13464003)(40434004)(189003)(199004)(316002)(6116002)(36906005)(305945005)(186003)(436003)(63370400001)(11346002)(446003)(66066001)(74316002)(7736002)(8676002)(5024004)(126002)(14444005)(63350400001)(476003)(486006)(26005)(336012)(70206006)(7696005)(33656002)(76176011)(99286004)(70586007)(2486003)(102836004)(23676004)(6506007)(47776003)(54906003)(53546011)(3846002)(356004)(25786009)(81166006)(81156014)(26826003)(76130400001)(22756006)(8936002)(55016002)(9686003)(2906002)(86362001)(6862004)(478600001)(4326008)(229853002)(5660300002)(50466002)(14454004)(6246003)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1855;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 196d6a51-1c29-4943-93ac-08d71cb82cc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0801MB1855;
X-Forefront-PRVS: 01244308DF
X-Microsoft-Antispam-Message-Info: iB7k0QfqyJdAUpbSxtmlxSLcapWyucnubXGEeeqiDb5FxM9CzTegrpbVgEBobKs24uvhVF0GXQB3t5eSfaLbgLbC6c6Q/L+CxnwVc7RPLdv8pqwHvRpqnhc48wuO8kNMMbek9DJrFOoVPEPF9GHImqE2mWmeoTFcYWgseuzBDTWfUsRrF4tNWt5xpwyhFEj6UCV+hFXIJtd/hT3swEZzxzj0XvBN4kEhI0gNo45FJXxsCsubWRGleZ22ihRDWNA7erncOGGGM/2eW8GIpb95CJR3X2wFCA9MF+INVsuR9Pig3jGl4MT/lcjfbLdKmnUbffHz3JJ+7deRDLHAUgj3lMvVqf49YLIeONMHfeVbPmi0l3fcvS/zbvTC+Lxu6j1ek2Ql/K17zrMxiG5vPiNjun+RlvmRzDj+6Wxw0zCQVeM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2019 10:56:16.2883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b10bb7-36ee-4a8d-94e5-08d71cb833d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtv
IDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTZW50OiAyMDE55bm0OOaciDnml6UgMTg6
NTINCj4gVG86IEp1c3RpbiBIZSAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIDxKdXN0aW4uSGVAYXJt
LmNvbT4NCj4gQ2M6IFBldHIgTWxhZGVrIDxwbWxhZGVrQHN1c2UuY29tPjsgQW5keSBTaGV2Y2hl
bmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBTZXJnZXkgU2Vub3po
YXRza3kNCj4gPHNlcmdleS5zZW5vemhhdHNreUBnbWFpbC5jb20+OyBHZWVydCBVeXR0ZXJob2V2
ZW4NCj4gPGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlz
dCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT47IFN0ZXZlbg0KPiBSb3N0ZWR0IChWTXdhcmUpIDxyb3N0ZWR0QGdv
b2RtaXMub3JnPjsgS2VlcyBDb29rDQo+IDxrZWVzY29va0BjaHJvbWl1bS5vcmc+OyBTaHVhaCBL
aGFuIDxzaHVhaEBrZXJuZWwub3JnPjsgVG9iaW4gQy4NCj4gSGFyZGluZyA8dG9iaW5Aa2VybmVs
Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHZzcHJpbnRmOiBQcmV2ZW50IGNyYXNo
IHdoZW4gZGVyZWZlcmVuY2luZyBpbnZhbGlkDQo+IHBvaW50ZXJzIGZvciAlcEQNCj4NCj4gT24g
RnJpLCBBdWcgOSwgMjAxOSBhdCA0OjI4IEFNIEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gQ29tbWl0IDNlNTkwM2ViOWNmZiAoInZzcHJpbnRmOiBQcmV2ZW50IGNy
YXNoIHdoZW4gZGVyZWZlcmVuY2luZw0KPiBpbnZhbGlkDQo+ID4gcG9pbnRlcnMiKSBwcmV2ZW50
cyBtb3N0IGNyYXNoIGV4Y2VwdCBmb3IgJXBELg0KPiA+IFRoZXJlIGlzIGFuIGFkZGl0aW9uYWwg
cG9pbnRlciBkZXJlZmVyZW5jaW5nIGJlZm9yZSBkZW50cnlfbmFtZS4NCj4gPg0KPiA+IEF0IGxl
YXN0LCB2bWEtPmZpbGUgY2FuIGJlIE5VTEwgYW5kIGJlIHBhc3NlZCB0byBwcmludGsgJXBEIGlu
DQo+ID4gcHJpbnRfYmFkX3B0ZSwgd2hpY2ggY2FuIGNhdXNlIGNyYXNoLg0KPiA+DQo+ID4gVGhp
cyBwYXRjaCBmaXhlcyBpdCB3aXRoIGludHJvZHVjaW5nIGEgbmV3IGZpbGVfZGVudHJ5X25hbWUu
DQo+ID4NCj4NCj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtv
QGdtYWlsLmNvbT4NCj4NCj4gUGVyaGFwcyB5b3UgbmVlZCB0byBhZGQgYSBGaXhlcyB0YWcNClRo
YW5rcywgQW5keQ0KRml4ZXM6IDNlNTkwM2ViOWNmZiAoInZzcHJpbnRmOiBQcmV2ZW50IGNyYXNo
IHdoZW4gZGVyZWZlcmVuY2luZyBpbnZhbGlkIHBvaW50ZXJzIikNCg0KTmVlZCBJIHJlcG9zdGVk
IHYyPw0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGliL3Zz
cHJpbnRmLmMgfCAxMyArKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi92c3By
aW50Zi5jIGIvbGliL3ZzcHJpbnRmLmMNCj4gPiBpbmRleCA2MzkzNzA0NGM1N2QuLmI0YTExOTE3
NmZkYiAxMDA2NDQNCj4gPiAtLS0gYS9saWIvdnNwcmludGYuYw0KPiA+ICsrKyBiL2xpYi92c3By
aW50Zi5jDQo+ID4gQEAgLTg2OSw2ICs4NjksMTUgQEAgY2hhciAqZGVudHJ5X25hbWUoY2hhciAq
YnVmLCBjaGFyICplbmQsIGNvbnN0DQo+IHN0cnVjdCBkZW50cnkgKmQsIHN0cnVjdCBwcmludGZf
c3ANCj4gPiAgICAgICAgIHJldHVybiB3aWRlbl9zdHJpbmcoYnVmLCBuLCBlbmQsIHNwZWMpOw0K
PiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIG5vaW5saW5lX2Zvcl9zdGFjaw0KPiA+ICtjaGFyICpm
aWxlX2RlbnRyeV9uYW1lKGNoYXIgKmJ1ZiwgY2hhciAqZW5kLCBjb25zdCBzdHJ1Y3QgZmlsZSAq
ZiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcHJpbnRmX3NwZWMgc3BlYywg
Y29uc3QgY2hhciAqZm10KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpZiAoY2hlY2tfcG9pbnRlcigm
YnVmLCBlbmQsIGYsIHNwZWMpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gYnVmOw0KPiA+
ICsNCj4gPiArICAgICAgIHJldHVybiBkZW50cnlfbmFtZShidWYsIGVuZCwgZi0+Zl9wYXRoLmRl
bnRyeSwgc3BlYywgZm10KTsNCj4gPiArfQ0KPiA+ICAjaWZkZWYgQ09ORklHX0JMT0NLDQo+ID4g
IHN0YXRpYyBub2lubGluZV9mb3Jfc3RhY2sNCj4gPiAgY2hhciAqYmRldl9uYW1lKGNoYXIgKmJ1
ZiwgY2hhciAqZW5kLCBzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LA0KPiA+IEBAIC0yMTY2LDkg
KzIxNzUsNyBAQCBjaGFyICpwb2ludGVyKGNvbnN0IGNoYXIgKmZtdCwgY2hhciAqYnVmLCBjaGFy
DQo+ICplbmQsIHZvaWQgKnB0ciwNCj4gPiAgICAgICAgIGNhc2UgJ0MnOg0KPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gY2xvY2soYnVmLCBlbmQsIHB0ciwgc3BlYywgZm10KTsNCj4gPiAgICAg
ICAgIGNhc2UgJ0QnOg0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gZGVudHJ5X25hbWUoYnVm
LCBlbmQsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKGNvbnN0IHN0
cnVjdCBmaWxlICopcHRyKS0+Zl9wYXRoLmRlbnRyeSwNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHNwZWMsIGZtdCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBm
aWxlX2RlbnRyeV9uYW1lKGJ1ZiwgZW5kLCBwdHIsIHNwZWMsIGZtdCk7DQo+ID4gICNpZmRlZiBD
T05GSUdfQkxPQ0sNCj4gPiAgICAgICAgIGNhc2UgJ2cnOg0KPiA+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gYmRldl9uYW1lKGJ1ZiwgZW5kLCBwdHIsIHNwZWMsIGZtdCk7DQo+ID4gLS0NCj4gPiAy
LjE3LjENCj4gPg0KPg0KPg0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2
Y2hlbmtvDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQg
YW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVn
ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkg
dGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0
byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBj
b3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
