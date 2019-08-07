Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45836C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A2021922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c6s4N9Lv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Qvb4TJge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfHGLLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:11:41 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:8832
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfHGLLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7k45ouuuXODyzVXGMw1Co7sn3b2HeOQSPozZIY9T1g=;
 b=c6s4N9LvveaGmZXBqX3QQb82lJ0k9iyfxnQLuVjFqgkYbkfirpqkz2ByPwNQdVTFC5MGaCpvNAVjXK80xvzV+JB9LWw9zdr0au+imt0Mll4zVGkiCmi3Ew8IzbhqIwqd1uYLdniOy61kZcEa9P1l/smOu79F7LWNPl03ohqmIw8=
Received: from VE1PR08CA0022.eurprd08.prod.outlook.com (2603:10a6:803:104::35)
 by AM6PR08MB4949.eurprd08.prod.outlook.com (2603:10a6:20b:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Wed, 7 Aug
 2019 11:11:30 +0000
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by VE1PR08CA0022.outlook.office365.com
 (2603:10a6:803:104::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Wed, 7 Aug 2019 11:11:30 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Wed, 7 Aug 2019 11:11:29 +0000
Received: ("Tessian outbound 40a263b748b4:v26"); Wed, 07 Aug 2019 11:11:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 853fbe5086365bb0
X-CR-MTA-TID: 64aa7808
Received: from 40e338a7140c.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D9944598-E30A-44AE-BDB3-BFF2F5D96355.1;
        Wed, 07 Aug 2019 11:11:21 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2054.outbound.protection.outlook.com [104.47.8.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 40e338a7140c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Wed, 07 Aug 2019 11:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcetVjLvTIu0TtcafO/k7BQLgWOBtqgNh/JIpOr7A2FqMi7MaQIA43AlJo714uMCMZ9zOQ+9udf39JDQ6SML1qX9FUmokz7Zw8eBL46wXOBU92s62XjL7yDJKTOOr3POauv4N8/p23LuKMX11uJsXyC33pcw840BbzZtUD0SIcNs9wU8ektAxh7b747OtXmyLGte5LeWHZ9hVb08EhQqIOCzq9DsxBMAgagZ5YxOqwQTlQcGzo/zoigYyKuuf5ByhzHHcl38NPpikuXEaRkuW6zFZ0HQT+uSzOUFB7aqVXIkc8XuNzka/agJeHpfUVJQvPom94QQGGt2F0vrdJR/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0WRZS4mN3o/N6ig5UfufIGQHCCixQE3l7rPB5ey2C0=;
 b=f/hhfp2m7hmFFxWFmQOBG38KXC/Ju3VCRDuUgG708PPtAg3vhcwN19PAjuWgB0wIRA8j9gKqv+fk0VGtkzNOOqCoalJTFarncitfCYm8QRbunNLk3Irmi6KKwOwkUA9yZp8xUs962WEEYjYMQEyNnRiOFpIS2aughqgp/dNprCG+i/CBZ613Md693QknNQUDqnBToWoqQNYHUAgR0vPleKFlZXiaqze3CWaS6FqW7Mwz/WwOpgydnVKCn9SRcMq7pF6jWvDBvW8DFjfj9Loxg6/WXKnQRbqD2M3qPbp3rcfEAujezjzPz2LEDVrAW6tVNkqF2kQqybd/JbkzLsGynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0WRZS4mN3o/N6ig5UfufIGQHCCixQE3l7rPB5ey2C0=;
 b=Qvb4TJge2JyujtuDfLKdbylykgghCR1qCYCq1yrFIL0DlALLLGMeBZN9Jq3WIwopZqbt7frWvz1XpVm1fpjIloaQzKU+PsmDALims4tzZt/b8Oc2IRCiJBDFKoKgXlN3fHgxpQaspv3B/xmVaTSjka3qwNUHxKctRLYwqScaRcw=
Received: from DB6PR08MB2647.eurprd08.prod.outlook.com (10.175.233.142) by
 DB6PR08MB2821.eurprd08.prod.outlook.com (10.170.220.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.20; Wed, 7 Aug 2019 11:11:19 +0000
Received: from DB6PR08MB2647.eurprd08.prod.outlook.com
 ([fe80::5804:a8fc:c70e:cb4c]) by DB6PR08MB2647.eurprd08.prod.outlook.com
 ([fe80::5804:a8fc:c70e:cb4c%7]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 11:11:19 +0000
From:   Tushar Khandelwal <Tushar.Khandelwal@arm.com>
To:     Sudeep Holla <Sudeep.Holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "morten_bp@live.dk" <morten_bp@live.dk>, nd <nd@arm.com>,
        Morten Petersen <Morten.Petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Thread-Topic: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
Thread-Index: AQHVPNWWqZ5nqYwTRESTK6j2lnJD4KbVpRIAgAU62ACADOeVgIAH8UaA
Date:   Wed, 7 Aug 2019 11:11:19 +0000
Message-ID: <9D863536-33C8-4103-A553-64C95FF94FC4@arm.com>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <20190802105357.GF23424@e107155-lin>
In-Reply-To: <20190802105357.GF23424@e107155-lin>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1b.0.190715
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Tushar.Khandelwal@arm.com; 
x-originating-ip: [217.140.106.49]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 21a5efb0-21bf-4dc4-f86a-08d71b27ff09
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB6PR08MB2821;
X-MS-TrafficTypeDiagnostic: DB6PR08MB2821:|AM6PR08MB4949:
X-Microsoft-Antispam-PRVS: <AM6PR08MB494968C639391FFAE7740E8BF7D40@AM6PR08MB4949.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01221E3973
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(6436002)(66556008)(4326008)(25786009)(86362001)(6486002)(14454004)(91956017)(76116006)(66066001)(5660300002)(478600001)(66946007)(64756008)(66476007)(66446008)(6246003)(81156014)(53936002)(8936002)(14444005)(6512007)(2906002)(256004)(33656002)(305945005)(229853002)(76176011)(8676002)(7736002)(71190400001)(71200400001)(81166006)(102836004)(53546011)(26005)(99286004)(58126008)(110136005)(6506007)(36756003)(486006)(2616005)(15650500001)(6116002)(3846002)(186003)(316002)(54906003)(476003)(68736007)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2821;H:DB6PR08MB2647.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: 7v+SFPA9+bxnxUmTDD2/xrT7zJCqQtdHB+2VZyMPhJpU1NeWaxPU6wBD0mw2+EFbp2hk0FvfX8/iKUlwbSgJEaOH8IkjUTBmdSGeQzBgWhjn+iCAGhfnp0ehL/0f1PUy83r+/CvsJblRlVSPdTugKN+pTEDrjHiQ2SlWIADsZeHpEffWJ7HcJ2DCehsax3nfvE5B7plgPjzb2IBfKrHCarl+LJRMTVXDAeRy6PzdiNGmMlUQWsJCOMuIQO1TNubLNqY2iFEGZ06oygJBk3PNd1bcn9q6N9Ao2GrXBysBsRc6lrV9CYF7sk5iPAaM+2G30gCbscXhHtNQLuEqnD4x5oMZVkiPb+R2YOFk26B7S2b1s6trmv3jsi3Eb092Hwd4tuofzgGXI4QFWiwMi2pLidwK5z0Y9czk6K+LtMy9BrQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <811613A61F70F546AB1E06819B5521E4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2821
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tushar.Khandelwal@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(189003)(40434004)(199004)(305945005)(99286004)(50466002)(7736002)(186003)(26005)(5660300002)(25786009)(229853002)(66066001)(36756003)(356004)(47776003)(6486002)(11346002)(446003)(102836004)(486006)(126002)(2616005)(476003)(8676002)(336012)(3846002)(15650500001)(6116002)(33656002)(36906005)(14454004)(6506007)(436003)(63350400001)(63370400001)(76130400001)(6246003)(70586007)(8936002)(6512007)(450100002)(70206006)(316002)(5024004)(14444005)(53546011)(110136005)(54906003)(2906002)(86362001)(22756006)(58126008)(478600001)(2486003)(4326008)(23676004)(81166006)(81156014)(76176011)(26826003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4949;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0f7de8aa-ebc2-4311-e0f8-08d71b27f971
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM6PR08MB4949;
X-Forefront-PRVS: 01221E3973
X-Microsoft-Antispam-Message-Info: 517+cpqJXx5+YA8NsYRNZnb8hq7Uv1whPXYREB7xyWabDUt2Tqt0WsJ6yU/ESPkqclDsFrTrJEolzKvP1TacpNEkWQuWoAxSzUTa41X9ebjK/iLdPO+tW1xhWssBoCBtTwtFYZjirvMn9X2CxZMseBUwFyUHf0K4XMO8GZAe6OHjt81SiTcW2CgdcSpbtB9bCzGElqNXAUBQ+C5ZaNHsnBJTf1V0s2Ro0qos/Sji2KcYd0PNTaIH8jROZD1gPkFIT6RnNjFsQtrg/xMiT1dhyNqA8DAsVxc9Qommbmru9ui9jPFEQkPw8sd3D4fH2NvYDRQ28RhyhQr7CWEerNi4Ej5eu0JE4W43RGWlmxBxB5s3a6BrNw/ikMVzQLIY3yleBTW4K/X5rMQxgDT5XzTGNm3uMFdfq9c3x1/ITEIZB14=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 11:11:29.1591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a5efb0-21bf-4dc4-f86a-08d71b27ff09
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4949
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDAyLzA4LzIwMTksIDExOjU0LCAiU3VkZWVwIEhvbGxhIiA8c3VkZWVwLmhvbGxh
QGFybS5jb20+IHdyb3RlOg0KDQogICAgT24gVGh1LCBKdWwgMjUsIDIwMTkgYXQgMTI6NDk6NThB
TSAtMDUwMCwgSmFzc2kgQnJhciB3cm90ZToNCiAgICA+IE9uIFN1biwgSnVsIDIxLCAyMDE5IGF0
IDQ6NTggUE0gSmFzc2kgQnJhciA8amFzc2lzaW5naGJyYXJAZ21haWwuY29tPiB3cm90ZToNCiAg
ICA+ID4NCg0KICAgIFsuLi5dDQoNCiAgICA+ID4gSWYgdGhlIG1odXYyIGluc3RhbmNlIGltcGxl
bWVudHMsIHNheSwgMyBjaGFubmVsIHdpbmRvd3MgYmV0d2Vlbg0KICAgID4gPiBzZW5kZXIgKGxp
bnV4KSBhbmQgcmVjZWl2ZXIgKGZpcm13YXJlKSwgYW5kIExpbnV4IHJ1bnMgdHdvIHByb3RvY29s
cw0KICAgID4gPiBlYWNoIHJlcXVpcmluZyAxIGFuZCAyLXdvcmQgc2l6ZWQgbWVzc2FnZXMgcmVz
cGVjdGl2ZWx5LiBUaGUgaGFyZHdhcmUNCiAgICA+ID4gc3VwcG9ydHMgdGhhdCBieSBhc3NpZ25p
bmcgd2luZG93cyBbMF0gYW5kIFsxLDJdIHRvIGVhY2ggcHJvdG9jb2wuDQogICAgPiA+IEhvd2V2
ZXIsIEkgZG9uJ3QgdGhpbmsgdGhlIGRyaXZlciBjYW4gc3VwcG9ydCB0aGF0LiBPciBkb2VzIGl0
Pw0KICAgID4gPg0KICAgID4gVGhpbmtpbmcgYWJvdXQgaXQsIElNTywgdGhlIG1ib3gtY2VsbCBz
aG91bGQgY2FycnkgYSAxMjggKDR4MzIpIGJpdA0KICAgID4gbWFzayBzcGVjaWZ5aW5nIHRoZSBz
ZXQgb2Ygd2luZG93cyAoY29ycmVzcG9uZGluZyB0byB0aGUgYml0cyBzZXQgaW4NCiAgICA+IHRo
ZSBtYXNrKSBhc3NvY2lhdGVkIHdpdGggdGhlIGNoYW5uZWwuDQogICAgPiBBbmQgdGhlIGNvbnRy
b2xsZXIgZHJpdmVyIHNob3VsZCBzZWUgYW55IGNoYW5uZWwgYXMgYXNzb2NpYXRlZCB3aXRoDQog
ICAgPiB2YXJpYWJsZSBudW1iZXIgb2Ygd2luZG93cyAnTicsIHdoZXJlIE4gaXMgWzAsMTI0XQ0K
ICAgID4NCiAgICA+IG1odV9jbGllbnQxOiBwcm90bzFAMmUwMDAwMDAgew0KICAgID4gICAgICAg
IC4uLi4uDQogICAgPiAgICAgICAgbWJveGVzID0gPCZtYm94IDB4MCAweDAgMHgwIDB4MT4NCiAg
ICA+IH0NCiAgICA+DQogICAgPiBtaHVfY2xpZW50MjogcHJvdG8yQDJmMDAwMDAwIHsNCiAgICA+
ICAgICAgICAuLi4uLg0KICAgID4gICAgICAgIG1ib3hlcyA9IDwmbWJveCAweDAgMHgwIDB4MCAw
eDY+DQogICAgPiB9DQogICAgPg0KDQogICAgVGhpcyBzdGlsbCBkb2Vzbid0IGFkZHJlc3MgdGhl
IG92ZXJoZWFkIEkgbWVudGlvbmVkIGluIG15IGFybV9taHVfdjENCiAgICBzZXJpZXMuDQoNCiAg
ICBBcyBwZXIgeW91IHN1Z2dlc3Rpb24sIHdlIHdpbGwgaGF2ZSBvbmUgY2hhbm5lbCB3aXRoIGFs
bCBwb3NzaWJsZQ0KICAgIGJpdCBtYXNrIHZhbHVlIHRvIHNwZWNpZnkgdGhlIHdpbmRvdy4gTGV0
J3MgaW1hZ2luZSB0aGF0IDIgcHJvdG9jb2xzDQogICAgc2hhcmUgdGhlIHNhbWUgY2hhbm5lbCwg
dGhlbiB0aGUgcmVxdWVzdHMgYXJlIHNlcmlhbGlzZWQuDQogICAgRS5nLiBpZiBiaXRzIDAgYW5k
IDEgYXJlIGFsbG9jYXRlZCBmb3Igc2F5IHByb3RvY29sIzEgYW5kIGJpdHMgMiBhbmQgMw0KICAg
IGZvciBwcm90b2NvbCMyLg0KDQpBdCBhIGdpdmVuIHRpbWUgb25seSBvbmUgcHJvdG9jb2wgY2Fu
IGJlIHVzZWQgYnkgYSBjbGllbnQuIE5vIG1peC1tYXRjaA0Kb2YgcHJvdG9jb2xzIGFyZSBoYW5k
bGVkIGJ5IHRoZSBkcml2ZXIgY3VycmVudGx5LiBBbHNvIGl0cyBub3QgcG9zc2libGUgdG8gYWRk
cmVzcyBhbGwNCnBvc3NpYmxlIHNjZW5hcmlvcyBvZmZlcmVkIGJ5IHRoZSBJUC4gVGhhdCdzIHdo
eSB0aGUgY3VycmVudCBkcml2ZXIgZGVzaWduIGlzDQpiYXNlZCBvbiB0aGUgaW1wbGVtZW50YXRp
b24gaW4gdGhlIGV4aXN0aW5nIHBsYXRmb3Jtcy4NCg0KICAgIEZ1cnRoZXIgcHJvdG9jb2wjMSBo
YXMgaGlnaGVyIGxhdGVuY3kgcmVxdWlyZW1lbnRzIGxpa2Ugc2NoZWQtZ292ZXJub3INCiAgICBE
VkZTIGFuZCB0aGVyZSBhcmUgMy00IHBlbmRpbmcgcmVxdWVzdHMgb24gcHJvdG9jb2wjMiwgdGhl
biB0aGUgaW5jb21pbmcNCiAgICByZXF1ZXN0cyBmb3IgcHJvdG9jb2wjMSBpcyBibG9ja2VkLg0K
DQogICAgVGhpcyBpcyBkZWZpbml0ZWx5IG92ZXJoZWFkIGFuZCBJIGhhdmUgc2VlbiBsb3RzIG9m
IGlzc3VlIGFyb3VuZCB0aGlzDQogICAgYW5kIGhlbmNlIEkgd2FzIHJlcXVlc3RpbmcgdGhhdCB3
ZSBuZWVkIHRvIGNyZWF0ZSBpbmRpdmlkdWFsIGNoYW5uZWxzDQogICAgZm9yIGVhY2ggb2YgdGhl
c2UuIEhhdmluZyBhYnN0cmFjdGlvbiBvbiB0b3AgdG8gbXVsdGlwbGV4IG9yIGFyYml0cmF0ZQ0K
ICAgIHdvbid0IGhlbHAuDQoNCkFsc28gdGhlIChtYm94LWNlbGxzKSBhcHByb2FjaCB3aWxsIG5v
dCBhbGxvdyB1cyB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4NCnNpbmdsZS13b3JkIGFuZCBkb29y
YmVsbCB3aGljaCBpcyByZXF1aXJlZCB0byBtYWtlIHRoZSBjb250cm9sbGVyIGRyaXZlcg0KYXdh
cmUgb2YgdGhlIGRhdGEgZXhwZWN0ZWQgd2hldGhlciBpdCdzIGEgcG9pbnRlciB0byBhIGxvY2F0
aW9uIG9yIGluDQpyZWdpc3RlciBpdHNlbGYuDQoNCi0tVHVzaGFyDQogICAgLS0NCiAgICBSZWdh
cmRzLA0KICAgIFN1ZGVlcA0KDQoNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0
aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFs
c28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2Ug
dGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2Us
IG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlv
dS4NCg==
