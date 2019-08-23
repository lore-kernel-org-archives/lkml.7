Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A0721848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Gn+ctRRD";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Gn+ctRRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390873AbfHWIbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:31:10 -0400
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:13733
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733069AbfHWIbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y11Yvj33a+MOxPykoOjhK8QBQ/PYirnUfqfX8NXjXz0=;
 b=Gn+ctRRDSOPXgLmu5XjkFhetK7NfjlK1WDyEGQXAA9Cflp+0Y676EOX+SF6rnjZeb3hJk+dHUVnzvImdqUpT9jgzvBuReIcZxRNYUqmSLxGZJtuIEAxCPKJsV19xd4PpaS7DKfO3AsRX3qH6RRpUOlWQZtDU2k6bN8EsBMiZKpQ=
Received: from AM4PR08CA0074.eurprd08.prod.outlook.com (2603:10a6:205:2::45)
 by DB6PR0801MB1847.eurprd08.prod.outlook.com (2603:10a6:4:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Fri, 23 Aug
 2019 08:31:04 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by AM4PR08CA0074.outlook.office365.com
 (2603:10a6:205:2::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.15 via Frontend
 Transport; Fri, 23 Aug 2019 08:31:03 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2199.13 via Frontend Transport; Fri, 23 Aug 2019 08:31:02 +0000
Received: ("Tessian outbound 4ee777a495a5:v27"); Fri, 23 Aug 2019 08:31:02 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a21034e3368520a5
X-CR-MTA-TID: 64aa7808
Received: from 524f221c7a79.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.10.59])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D164E1B4-1CF8-4C22-8B55-D49832C9475D.1;
        Fri, 23 Aug 2019 08:30:57 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2059.outbound.protection.outlook.com [104.47.10.59])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 524f221c7a79.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 23 Aug 2019 08:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga9QkpyVO1xPdxe38yXbm2BSbIjDfHfIVPvDJwA3NDAGtTy5we1cKjEiDSsjc5OpbzPCJK+BcNcOr7tSjXcw3smkTmsNYuxPcH0GiR1odRSOGrUecbYT9natlxD7QjRo8bbNg5GhD3M2n3KQhCtFy7RVFoTjpc2XaZvTY2oT6yZHyGv9u4MC7YP4KAFEjKVyIb8b76/goFjxkcjQBRno2u77K8dLJoAqnaQPw4IlFA+ZD5qpLPkBxXookUqKhwcbyxDVPXEqd3hfIL5BbTZoAmuVSHVheGj5fIRpV/UpJYvs3dbn6RNS0yP5jOPRWJ2WTr129Nz6QgaC5lxr45Rirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y11Yvj33a+MOxPykoOjhK8QBQ/PYirnUfqfX8NXjXz0=;
 b=gH+vvBQaohqpRoRHkKVZHj/s6j2i1YGX7PWzm9qKxWiW9gLIsG6GGBzHX3P2Ds2YmTowLw4AEznTYkPLVkAzHGoec8pjl8Tlw3D45tbO4YDw9Yq3I5p+nv6uMi99DW8hDi9eVypqR32bjRu43OLHMJpnPSoWEJnxdLSBJP85ACEJgt8FafSFFTichjEiuiVKmZBZU+Qxhf9LuRGVrIgUJ3AYUvo+CFzT1PAwTj8M7DC0/9UkXamsuiBTz0vP60bv0Jueym+3I1HFx7GRx2pDL/YkeUOmCPrIbHNcKABK1mwefM2lMhpHBnRwbcloELnwFAXuIGkCsDuE3+1LkdElng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y11Yvj33a+MOxPykoOjhK8QBQ/PYirnUfqfX8NXjXz0=;
 b=Gn+ctRRDSOPXgLmu5XjkFhetK7NfjlK1WDyEGQXAA9Cflp+0Y676EOX+SF6rnjZeb3hJk+dHUVnzvImdqUpT9jgzvBuReIcZxRNYUqmSLxGZJtuIEAxCPKJsV19xd4PpaS7DKfO3AsRX3qH6RRpUOlWQZtDU2k6bN8EsBMiZKpQ=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2275.eurprd08.prod.outlook.com (10.172.220.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 08:30:55 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::f482:c808:6949:f621]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::f482:c808:6949:f621%11]) with mapi id 15.20.2178.020; Fri, 23 Aug
 2019 08:30:54 +0000
From:   James Clark <James.Clark@arm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: Re: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Thread-Topic: [PATCH] Fixes hang in zstd compression test by changing the
 source of random data.
Thread-Index: AQHVWPE5/pKj1LLZ0UK87cC00QUcbacHrfmAgAAAMwCAALoXAA==
Date:   Fri, 23 Aug 2019 08:30:54 +0000
Message-ID: <94cf610f-440d-a35d-9dc0-7c4941f03386@arm.com>
References: <3d8cc701-df4e-f949-1715-5118b530e990@arm.com>
 <20190822212407.GJ3929@kernel.org> <20190822212450.GK3929@kernel.org>
In-Reply-To: <20190822212450.GK3929@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LNXP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::22) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a0dd3c22-894d-4ce9-4028-08d727a43be6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM4PR0802MB2275;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2275:|DB6PR0801MB1847:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB184723EA430D4A3F94883F1AE2A40@DB6PR0801MB1847.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 0138CD935C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(71200400001)(71190400001)(316002)(52116002)(3846002)(81156014)(8676002)(81166006)(14454004)(305945005)(6116002)(54906003)(7736002)(76176011)(6486002)(66946007)(66066001)(66446008)(64756008)(66556008)(66476007)(6512007)(476003)(25786009)(44832011)(6246003)(99286004)(186003)(26005)(53936002)(2616005)(36756003)(229853002)(4326008)(6436002)(11346002)(53546011)(5660300002)(386003)(31696002)(6506007)(486006)(4744005)(31686004)(102836004)(256004)(478600001)(86362001)(8936002)(2906002)(446003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2275;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: fwdFznEnuWbh3GROgK26U99ZNCsp4YfpjVHhkN8wZpLgtdNETbDfDVikfkqRUciBQSAMJacWztMoG4gdQD9iDuUK2xbDpa2n2/ByJUftN3sVspmlGTeyIM0RSWf5OF5hAH4oQlxjw3/1oz2qEfArbk4pAfzLQFDaaPV+7JkWLyO525F+s1gTcNruqStAGdXkRTB+Egp1/fnF+O/Zlds2ODnmMyqWSmVsprlTiBNtoowzKBeLOrbnlc85pdId7Ty/znzDl3Ye9HmhcMmV4ibALLcINAO9TBJg8VZMbt8hI6nWWdGj9sXtwg3oHiy5jITvHuAJdOJkpUMKdTMZHk7xyaDsIKMcFZhsWoWyUp4BypvTyc7txYJsuk/CLF4yhNhZT3G1T3MLNDjCc6MZi5EkEzE8tWXBscd/6mYi5+Njt6A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C07E2E6EC3E7944A2EE1BE04400FDEA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2275
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(26826003)(99286004)(47776003)(66066001)(476003)(126002)(486006)(446003)(11346002)(2616005)(336012)(436003)(23676004)(63350400001)(76176011)(2486003)(36906005)(5660300002)(6506007)(53546011)(36756003)(386003)(478600001)(186003)(70206006)(63370400001)(26005)(316002)(54906003)(70586007)(31686004)(4744005)(229853002)(2906002)(3846002)(50466002)(305945005)(7736002)(6862004)(450100002)(86362001)(4326008)(76130400001)(6246003)(6512007)(6116002)(81166006)(81156014)(102836004)(8936002)(8676002)(356004)(25786009)(14454004)(22756006)(31696002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1847;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: db6c7201-e84d-4528-2fc1-08d727a436ce
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DB6PR0801MB1847;
NoDisclaimer: True
X-Forefront-PRVS: 0138CD935C
X-Microsoft-Antispam-Message-Info: WTYHZzcIdjJoPZ9gDcMz+aTYgR1HM1QE3w4zKhl7jjEDj4DO4ZnQqVL0tLnkPnY8qWLds19Rh+YzjeSamN0FydThRn+VUU+RjgVb/g0z3pj6/DrdC6P9FpJb+y+FgI6wO8oImA0p5zpU+r57B483GyxwQ0gsov4Moes/euq/ErRSZmZEe/jEr17pVktMymu3MMYSS4Rfup0yH6vltjEljuNj4DcO1z6O0Io1nbgtPQCQ94rRCDUHEs1VEuBBbE70V2TVMlfdLdk2kDIh+TKAPYtwAl5xxehsov1MZSoYvPCM73pLpMdt4c/YA8KL0f43PokQBikSp5tR/uCzAAE5SBE4jFFqwwrqciKK6gex/8MvzSJVApfgB6vFlG+wvsQRLN4K/VgeO26h9lRMJxRKN9IT8+BX/4tgpPaTKCNNOVM=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2019 08:31:02.7348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dd3c22-894d-4ce9-4028-08d727a43be6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgYWJvdXQgdGhhdCwgSSB3aWxsIGxvb2sgaW50byBpdC4NCg0KVGhhbmtzDQpKYW1lcw0K
DQpPbiAyMi8wOC8yMDE5IDIyOjI0LCBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8gd3JvdGU6DQo+
IEVtIFRodSwgQXVnIDIyLCAyMDE5IGF0IDA2OjI0OjA3UE0gLTAzMDAsIEFybmFsZG8gQ2FydmFs
aG8gZGUgTWVsbyBlc2NyZXZldToNCj4+IEVtIFRodSwgQXVnIDIyLCAyMDE5IGF0IDAxOjU1OjE1
UE0gKzAwMDAsIEphbWVzIENsYXJrIGVzY3JldmV1Og0KPj4+IFJ1bm5pbmcgJ3BlcmYgdGVzdCcg
d2l0aCB6c3RkIGNvbXByZXNzaW9uIGxpbmtlZCB3aWxsIGhhbmcgYXQgdGhlIHRlc3QNCj4+PiAn
WnN0ZCBwZXJmLmRhdGEgY29tcHJlc3Npb24vZGVjb21wcmVzc2lvbicgYmVjYXVzZSAvZGV2L3Jh
bmRvbSBibG9ja3MNCj4+PiByZWFkcyB1bnRpbCB0aGVyZSBpcyBlbm91Z2ggZW50cm9weS4gVGhp
cyBtZWFucyB0aGF0IHRoZSB0ZXN0IHdpbGwNCj4+PiBhcHBlYXIgdG8gbmV2ZXIgY29tcGxldGUg
dW5sZXNzIHRoZSBtb3VzZSBpcyBjb250aW51YWxseSBtb3ZlZCB3aGlsZQ0KPj4+IHJ1bm5pbmcg
aXQuDQo+Pg0KPj4gbWVzc2FnZSBjYW1lIG1hbmdsZWQsIGhhZCB0byBkbyBpdCBieSBoYW5kIGFu
ZCB0aGVuIGhvb2sgdXAgeW91ciBoZWFkZXINCj4+IHNvIGFzIHRvIGdldCB0aGUgY29ycmVjdCBk
YXRlLCBhdHRyaWJ1dGlvbiwgZXRjLCBwbGVhc2UgY2hlY2sNCj4+IERvY3VtZW50YXRpb24vcHJv
Y2Vzcy9lbWFpbC1jbGllbnRzLnJzdCwNCj4gDQo+IEhhdmluZyBzYWlkIHRoYXQsIHRoYW5rcywg
YXBwbGllZC4NCj4gDQo+IC0gQXJuYWxkbw0KPiANCg==
