Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F08CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5357421D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="iym1wqat";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OCMAUq2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfKDNEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:04:13 -0500
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:14913
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfKDNEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ORRMSGv2rFGkesJmJDWRHtB2BsJWDbuQEnKfg1jvow=;
 b=iym1wqat/Ltgw8K2eWiBBP0TF+2aheZLfYCKf2sYiAlv3URpiWwDWJ5K5HoAnGWS3aaknVL3Wqz6oHfABAiZHQ9qkqoyj8TX3G2thRbWkGayAgV0Q0ML0NtYSUCjly9yWSAw0iJAAH0s87FuHVob+Kli1baKo/61/eoHItzxHaM=
Received: from VI1PR08CA0087.eurprd08.prod.outlook.com (2603:10a6:800:d3::13)
 by AM5PR0801MB1668.eurprd08.prod.outlook.com (2603:10a6:203:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.24; Mon, 4 Nov
 2019 13:04:03 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VI1PR08CA0087.outlook.office365.com
 (2603:10a6:800:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.24 via Frontend
 Transport; Mon, 4 Nov 2019 13:04:03 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Mon, 4 Nov 2019 13:04:03 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Mon, 04 Nov 2019 13:03:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a870a74861de1579
X-CR-MTA-TID: 64aa7808
Received: from 2120e66fa18b.2 (cr-mta-lb-1.cr-mta-net [104.47.25.106])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FD506A8B-42D2-477A-AD36-4834073605C3.1;
        Mon, 04 Nov 2019 13:03:54 +0000
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on0106.outbound.protection.outlook.com [104.47.25.106])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2120e66fa18b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 04 Nov 2019 13:03:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkbCgIvLp6G2AodUpCMh110xHqnDlE63LLi1loCzLIZJUpeQlhOJrlLq4t7evebpPI0ZrFKTOn1yZhVt5bq7QKgTP4MAyFrOX8+N6DzVeeMp0cMb+IROQpFRMFckGy4WZZ3sKvP+cFM/wvsC+tTK+vk6EbkQMFGnR1BSdWK2n5JkwXSE2wIK120m+JINN/BitBWfY6yI9ILSvzlVhGZXQb6kZanO1p5g29qyYFR7M126ovxMYrtHTYl9d9Dq+jMBzuR2jadYI7ei4GmnXk2aUb9F9/yIPFbN0LZRbJoyUx+NUjv5D2geszOCfvKly9rmOgMhsSgAixDJJKQpC8JKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSRwqzYZFRfuZuiIHCNwblOYFAbXzOxXZ4OYw3QN83k=;
 b=Zlxm27siW8bmC89MM9kjNWpZxdK3gCK58SYgWoXH+Z+RX/2CFxHhL9DPzzi0Vrwqlby6eUR/EgOB350WYC4GwFePUUBlWlJbovFl0VMFVhMbBsBwDdQD2nztHv0QdSZJoVLNlGP5Eig//YuX1uLPHIvfr+5Jja2B09G0mAiPC3vkAHkKu6j4zG1gt0wpgAm3nkQu9FB67tjyBLibYvW2XWHEDiZiUC2KsomAI81E+gTO+Xd9bw748d/mSyehthJDI7DSwsM+DI3xZ/E8EmrBxV32AMj5aD9zBCL1UlzJzNLSm26QhsKzwSYU1gJkFNxslmSZplJsoImGqDpJQXZ93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSRwqzYZFRfuZuiIHCNwblOYFAbXzOxXZ4OYw3QN83k=;
 b=OCMAUq2DcwmX/6PHEw5zur9gDzk5sUsIvU7GJSRS8EGkhNkKRkp32EESYBIdw6WliL4KSaKkJHH4TJKy81slFmbrm/VkvmkUb40Q1cRFIdsGGpUUsqvEaiT4KzB0od1GnI27gqXNg5ptYNLqQQnK5VxPzpx604l9Ioa/qo3Nudc=
Received: from PR2PR08MB4843.eurprd08.prod.outlook.com (52.133.110.76) by
 PR2PR08MB4700.eurprd08.prod.outlook.com (52.133.108.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 13:03:52 +0000
Received: from PR2PR08MB4843.eurprd08.prod.outlook.com
 ([fe80::70a7:3eec:4700:3131]) by PR2PR08MB4843.eurprd08.prod.outlook.com
 ([fe80::70a7:3eec:4700:3131%2]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 13:03:51 +0000
From:   Amit Kachhap <Amit.Kachhap@arm.com>
To:     Will Deacon <will@kernel.org>
CC:     Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        "deller@gmx.de" <deller@gmx.de>, "duwe@suse.de" <duwe@suse.de>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        James Morse <James.Morse@arm.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jthierry@redhat.com" <jthierry@redhat.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "svens@stackframe.org" <svens@stackframe.org>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>
Subject: Re: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Thread-Topic: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Thread-Index: AQHVjnomuaxy+Iiw8UaPeqvM+8cAdKd4LNKAgALU0oCAAAH4AA==
Date:   Mon, 4 Nov 2019 13:03:51 +0000
Message-ID: <d9b738fa-b7c5-f1b2-3878-d7afa4ba7ba5@arm.com>
References: <20191029165832.33606-1-mark.rutland@arm.com>
 <42c113ee-e7fc-3e94-cca0-f05f1c89fdb8@arm.com>
 <20191104125637.GB24108@willie-the-truck>
In-Reply-To: <20191104125637.GB24108@willie-the-truck>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::20) To PR2PR08MB4843.eurprd08.prod.outlook.com
 (2603:10a6:101:24::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Amit.Kachhap@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.105.40]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e89a644f-0e24-4094-fde6-08d7612777d9
X-MS-TrafficTypeDiagnostic: PR2PR08MB4700:|PR2PR08MB4700:|AM5PR0801MB1668:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB166836848BD56E42307249CC8C7F0@AM5PR0801MB1668.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0211965D06
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(81166006)(81156014)(7416002)(102836004)(8676002)(4326008)(66476007)(64756008)(66066001)(5660300002)(66556008)(66446008)(386003)(6506007)(71200400001)(53546011)(71190400001)(66946007)(6512007)(14454004)(229853002)(6436002)(36756003)(478600001)(11346002)(446003)(2616005)(3846002)(25786009)(6116002)(26005)(476003)(186003)(305945005)(2906002)(7736002)(31686004)(256004)(6246003)(44832011)(8936002)(99286004)(54906003)(86362001)(31696002)(76176011)(486006)(316002)(6486002)(6916009)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4700;H:PR2PR08MB4843.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZH5PGaRnfRr57b1gSuP2rVkk7VdbUKOQUWEW5CkAdsB1vuGphpC9keGZjUKcYNVRQN6OaNVBEaK4Y4SEAlahVnI6sb2D0QevCATY5QZShVIj1E5KDPzQI5zqSuUx17zeywwrtPNf+V1gLhia4VA5MlhnggFvJAEv8bYmdE/1BXS5MP75+K2ouvrvuYmyn4uh/w/QK5JXUOyICixyaQ7AtA3wNcaW8DdeJNzzkTljTz285hrxJJyCKoDfNL25lXkoWSKsigcFMyPy76uJcOP3riPZUhGEtjfAV9YptbHF5xMzbfPooIhXB6woCT1oCgMd8lbCuRji4iALglfhp5ASkRCo0BzBq46kIdUbLycMAUiiTgChIfENLlO4+TswNzGzLAwmjf9EhOAg1Ne7RtPbluEUimEb9UtvqnuKR0GvO8dHBbNeDSe27n03gzXuIJAQ
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C71A00549171B49956BEC8D60D9E624@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4700
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amit.Kachhap@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1110001)(339900001)(40434004)(189003)(199004)(486006)(336012)(6862004)(70206006)(6486002)(8676002)(5660300002)(81166006)(81156014)(86362001)(6246003)(36756003)(386003)(478600001)(99286004)(76176011)(23676004)(2486003)(47776003)(6116002)(4326008)(70586007)(107886003)(14454004)(3846002)(8936002)(356004)(5024004)(305945005)(14444005)(36906005)(76130400001)(26826003)(102836004)(186003)(53546011)(31686004)(450100002)(26005)(66066001)(229853002)(50466002)(2616005)(6512007)(31696002)(446003)(11346002)(6506007)(476003)(126002)(105606002)(22756006)(54906003)(25786009)(436003)(2906002)(7736002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1668;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8a41a572-7531-4f20-0f1d-08d761277086
X-Forefront-PRVS: 0211965D06
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNJolsBmWePsWBAcy1pR5FJCNxADU2kF7DsEO5glxKGcSjrQKGe5M9FBXsClF2t4GQBwqhjKWJ2wzi1B6MCb//yVCMcgxJvZEmax1bU8VGJXK0aGTvn6edAddUCkYW8J3vuIWcfQUFoun+rP2gC7gUGY/9NMiZw1QhakQYpyt0V4oxGgcjX36aDKH5yL+yaRy7R1xps3lA+Vr9PNEkSLYL85+2EhMjBQNW0kdt4/Q+lDqjIo4qzMzIjiVN8GtiIaF82JoqexXdTx0gaImUC7ZNSMaSP2qkbTyjciJiWSMs4MDb8q7PubHkma+4rv8SEztjqK8whbQlRyAvIFqUsKXGPOnNSqSLU3WYG5dxg4Q/110u2HaT8h6K5WNe8eWntMEf+xQvenju8geWDId/4MiJu/MSG9ohiCbqbOOx8DyjrNoITcuXtQxQo5m39kwxZf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2019 13:04:03.7207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e89a644f-0e24-4094-fde6-08d7612777d9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzQvMTkgNjoyNiBQTSwgV2lsbCBEZWFjb24gd3JvdGU6DQo+IE9uIFNhdCwgTm92
IDAyLCAyMDE5IGF0IDA1OjQyOjI1UE0gKzA1MzAsIEFtaXQgRGFuaWVsIEthY2hoYXAgd3JvdGU6
DQo+PiBPbiAxMC8yOS8xOSAxMDoyOCBQTSwgTWFyayBSdXRsYW5kIHdyb3RlOg0KPj4+IFRoaXMg
c2VyaWVzIGlzIGEgcmV3b3JrZWQgdmVyc2lvbiBvZiBUb3JzdGVuJ3MgRlRSQUNFX1dJVEhfUkVH
UyBzZXJpZXMNCj4+PiBbMV0uIEkndmUgdHJpZWQgdG8gcmV3b3JrIHRoZSBleGlzdGluZyBjb2Rl
IGluIHByZXBhcmF0b3J5IHBhdGNoZXMgc28NCj4+PiB0aGF0IHRoZSBwYXRjaGFibGUtZnVuY3Rp
b24tZW50cnkgYml0cyBzbG90IGluIHdpdGggZmV3ZXIgc3VycHJpc2VzLg0KPj4+IFRoaXMgdmVy
c2lvbiBpcyBiYXNlZCBvbiB2NS40LXJjMywgYW5kIGNhbiBiZSBmb3VuZCBpbiBteQ0KPj4+IGFy
bTY0L2Z0cmFjZS13aXRoLXJlZ3MgYnJhbmNoIFsyXS4NCj4+Pg0KPj4+IFBhdGNoIDEgYWRkcyBh
biAob3B0aW9uYWwpIGZ0cmFjZV9pbml0X25vcCgpLCB3aGljaCB0aGUgY29yZSBjb2RlIHVzZXMN
Cj4+PiB0byBpbml0aWFsaXplIGNhbGxzaXRlcy4gVGhpcyBhbGxvd3MgdXMgdG8gYXZvaWQgYSBz
eW50aGV0aWMgTUNPVU5UX0FERFINCj4+PiBzeW1ib2wsIGFuZCBtb3JlIGNsZWFubHkgc2VwYXJh
dGVzIHRoZSBvbmUtdGltZSBpbml0aWFsaXphdGlvbiBvZiB0aGUNCj4+PiBjYWxsc2l0ZSBmcm9t
IGR5bmFtaWMgTk9QPC0+Q0FMTCBtb2RpZmljYXRpb24uIEFyY2hpdGVjdHVyZXMgd2hpY2ggZG9u
J3QNCj4+PiBpbXBsZW1lbnQgdGhpcyBnZXQgdGhlIGV4aXN0aW5nIGZ0cmFjZV9tYWtlX25vcCgp
IHdpdGggTUNPVU5UX0FERFIuDQo+Pj4NCj4+PiBSZWNlbnRseSBwYXJpc2MgZ2FpbmVkIGZ0cmFj
ZSBzdXBwb3J0IHVzaW5nIHBhdGNoYWJsZS1mdW5jdGlvbi1lbnRyeS4NCj4+PiBQYXRjaCAyIG1h
a2VzIHRoZSBoYW5kbGluZyBvZiBtb2R1bGUgY2FsbHNpdGUgbG9jYXRpb25zIGNvbW1vbiBpbg0K
Pj4+IGtlcm5lbC9tb2R1bGUuYyB3aXRoIGEgbmV3IEZUUkFDRV9DQUxMU0lURV9TRUNUSU9OIGRl
ZmluaXRpb24sIGFuZA0KPj4+IHJlbW92ZWQgdGhlIG5ld2x5IHJlZHVuZGFudCBiaXRzIGZyb20g
YXJjaC9wYXJpc2MuDQo+Pj4NCj4+PiBQYXRjaGVzIDMgYW5kIDQgbW92ZSB0aGUgbW9kdWxlIFBM
VCBpbml0aWFsaXphdGlvbiB0byBtb2R1bGUgbG9hZCB0aW1lLA0KPj4+IHdoaWNoIHNpbXBsaWZp
ZXMgcnVudGltZSBjYWxsc2l0ZSBtb2RpZmljYXRpb24uIFRoaXMgYWxzbyBtZWFucyB0aGF0IHdl
DQo+Pj4gZG9uJ3QgdHJhbnNpdGVudGx5IG1hcmsgdGhlIG1vZHVsZSB0ZXh0IFJXLCBhbmQgd2ls
bCBhbGxvdyBmb3IgdGhlDQo+Pj4gcmVtb3ZhbCBvZiBtb2R1bGVfZGlzYWJsZV9ybygpLg0KPj4+
DQo+Pj4gUGF0Y2hlcyA1IGFuZCA2IGFkZCBzb21lIHRyaXZpYWwgaW5mcmFzdHJ1Y3R1cmUsIHdp
dGggcGF0Y2ggNyBmaW5hbGx5DQo+Pj4gYWRkaW5nIEZUUkFDRV9XSVRIX1JFR1Mgc3VwcG9ydC4g
QWRkaXRpb25hbCB3b3JrIHdpbGwgYmUgcmVxdWlyZWQgZm9yDQo+Pj4gbGl2ZXBhdGNoaW5nIChl
LmcuIGltcGxlbWVudGluZyByZWxpYWJsZSBzdGFjayB0cmFjZSksIHdoaWNoIGlzDQo+Pj4gY29t
bWVudGVkIGFzIHBhcnQgb2YgcGF0Y2ggNy4NCj4+Pg0KPj4+IFBhdGNoIDggaXMgYSB0cml2aWFs
IGNsZWFudXAgYXRvcCBvZiB0aGUgcmVzdCBvZiB0aGUgc2VyaWVzLCBtYWtpbmcgdGhlDQo+Pj4g
Y29kZSBlYXNpZXIgdG8gcmVhZCBhbmQgbGVzcyBzdXNjZXB0aWJsZSB0byBjb25maWctc3BlY2lm
aWMgYnJlYWthZ2UuDQo+PiBJIHRlc3RlZCB0aGUgd2hvbGUgc2VyaWVzIHdpdGggbXkgbGF0ZXN0
IGluLWtlcm5lbCBwdHJhdXRoIHBhdGNoZXMgWzFdDQo+PiBhbmQgZ3JhcGhfdHJhY2VyL2Z1bmN0
aW9uX2dyYXBoX3RyYWNlciB3b3JrcyBmaW5lLCBTbyBmb3IgdGhlIHdob2xlIHNlcmllcywNCj4+
IFRlc3RlZC1ieTogQW1pdCBEYW5pZWwgS2FjaGhhcCA8YW1pdC5rYWNoaGFwQGFybS5jb20+DQo+
Pg0KPj4gQWxzbyBJIGdhdmUgZmV3IG1pbm9yIGNvbW1lbnRzIGluIHRoZSBpbmRpdmlkdWFsIHBh
dGNoZXMuIFdpdGggdGhvc2UNCj4+IGNvbW1lbnRzLA0KPj4gU2lnbmVkLW9mZi1ieTogQW1pdCBE
YW5pZWwgS2FjaGhhcCA8YW1pdC5rYWNoaGFwQGFybS5jb20+DQpPb3BzIHNvcnJ5IEkgbWVhbnQs
DQpSZXZpZXdlZC1vZmYtYnk6IEFtaXQgRGFuaWVsIEthY2hoYXAgPGFtaXQua2FjaGhhcEBhcm0u
Y29tPg0KPg0KPiBJIGRvbid0IHRoaW5rIHRoaXMgbWVhbnMgd2hhdCB5b3UgdGhpbmsgaXQgbWVh
bnMuIFBsZWFzZSByZWFkOg0KVGhhbmtzIGZvciBwb2ludGluZyBpdC4NCj4NCj4gRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QNCj4NCj4gV2lsbA0KPg0KSU1QT1JU
QU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50
cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1t
ZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBl
cnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3Jt
YXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
