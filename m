Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD097C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A336120727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bJH8Rduj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bJH8Rduj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKOABP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:01:15 -0500
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:59278
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726767AbfKOABP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzGC0DqsM/3LF52XQ0H3D1A0+kd7gBAbikqvwdXvVZg=;
 b=bJH8RdujgxZXSvi+dR1a7z4Gd2cFGKaj7xyTJpRbnYiHriW7axlNRVnhoBlDUPYi0cK2nHqLkKQ40zsoPS1NV8trVePnRcvmlEeit4z61CIsAPyknDynFBv6vGWz5HisX204OYW/kK+p73lK9vq+Rn5+EVUm28ePMqLxt4H6/nM=
Received: from VI1PR08CA0096.eurprd08.prod.outlook.com (2603:10a6:800:d3::22)
 by VI1PR08MB3936.eurprd08.prod.outlook.com (2603:10a6:803:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23; Fri, 15 Nov
 2019 00:01:07 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by VI1PR08CA0096.outlook.office365.com
 (2603:10a6:800:d3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 00:01:07 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Fri, 15 Nov 2019 00:01:07 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Fri, 15 Nov 2019 00:01:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4f9ff1f8aeed800c
X-CR-MTA-TID: 64aa7808
Received: from c360b9969126.2 (cr-mta-lb-1.cr-mta-net [104.47.9.50])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3C77F4EB-0F3A-4702-9BE0-0891BABC113E.1;
        Fri, 15 Nov 2019 00:01:01 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c360b9969126.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Nov 2019 00:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEJ//z6pLOiP4o2rPLAHqr73IDCj/CR2EMSlF0WawvO5Em7QLVtQgstWxnYiCpMKWMQHhS3jQSXfPGGP7Jmgytw3mz4zWQIeIyY3XwuubmfNfsrLpM3a7PjLIntJSfmx8b2NuQzI097XQ31ksCQkmkhobVC3wkI3ESPDc5MGjfa6hmRz/P6R82f64UZqcYOQ51MQL0i74+xbFN/rLfcGoI3xRODTLfVxRZ9a0782EzTWonO0GlM8ZFqFE856McLs4DaXI08uZxmIUwQ2fBy1GIPT/9Bza9m4Af3rbLQcltkFnikVvfmfoTZvU91l1jsMLKp+PuvOKuT9Vwc+Z70WbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzGC0DqsM/3LF52XQ0H3D1A0+kd7gBAbikqvwdXvVZg=;
 b=CtAuLcsXvMzP8IB+1XWqpsgVX4pyJNxZu2dt9nptnOIEphVhpf2nrCedafvNVn7++KgxChf3yCJQ9opXsAFJjTrMoZQqN7ok6jnrMX555sgVyyNnjH5L1doQ97NKTrBU9d1I/7wwa5P9RNy5wR671iiL+Jhyh3ByvwhBAXzPn4qakAP1xzF0Fqr2G9E4+W2F6y4OV7a127Fer5s6erzxhuIuJmR3QcXAB/ee52C6Fqq751JL9x55ihgZ1L7lgft10t2rspXkHSQ8UAjlfB7Ups/lODNe2PMZvLbtmWajjbN4pJemDKavppozQjarF/2xSFOXoyu123kxhqdj9C3mIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzGC0DqsM/3LF52XQ0H3D1A0+kd7gBAbikqvwdXvVZg=;
 b=bJH8RdujgxZXSvi+dR1a7z4Gd2cFGKaj7xyTJpRbnYiHriW7axlNRVnhoBlDUPYi0cK2nHqLkKQ40zsoPS1NV8trVePnRcvmlEeit4z61CIsAPyknDynFBv6vGWz5HisX204OYW/kK+p73lK9vq+Rn5+EVUm28ePMqLxt4H6/nM=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4383.eurprd08.prod.outlook.com (20.179.28.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 00:01:00 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 00:01:00 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     nd <nd@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gZHJtL2tvbWVkYTogQ2xlYW4gd2FybmluZ3M6IGNhbmRp?=
 =?utf-8?B?ZGF0ZSBmb3IgJ2dudV9wcmludGbigJkgZm9ybWF0IGF0dHJpYnV0ZQ==?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBkcm0va29tZWRhOiBDbGVhbiB3YXJuaW5nczogY2FuZGlkYXRl?=
 =?utf-8?B?IGZvciAnZ251X3ByaW50ZuKAmSBmb3JtYXQgYXR0cmlidXRl?=
Thread-Index: AQHVmtLsTLvLo3Z9SUGqMMXb28Jv4aeLWd+A
Date:   Fri, 15 Nov 2019 00:01:00 +0000
Message-ID: <3596931.2M0sqJgrhf@e123338-lin>
References: <20191114100421.30510-1-james.qian.wang@arm.com>
In-Reply-To: <20191114100421.30510-1-james.qian.wang@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P123CA0045.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::33)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f6e1b154-8d53-426d-07e8-08d7695eea3c
X-MS-TrafficTypeDiagnostic: VI1PR08MB4383:|VI1PR08MB4383:|VI1PR08MB3936:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3936041C932F643C3963AABC8F700@VI1PR08MB3936.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:3276;OLM:3276;
x-forefront-prvs: 02229A4115
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(189003)(199004)(5660300002)(76176011)(66476007)(3846002)(6116002)(2906002)(81166006)(81156014)(9686003)(6512007)(14454004)(54906003)(6436002)(71200400001)(71190400001)(316002)(64756008)(99286004)(8936002)(66446008)(229853002)(66946007)(6486002)(486006)(26005)(476003)(25786009)(6636002)(102836004)(52116002)(66556008)(478600001)(66066001)(6246003)(386003)(256004)(7736002)(305945005)(6506007)(4326008)(446003)(11346002)(186003)(6862004)(86362001)(33716001)(14444005)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4383;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uKJfjLOPIk1ZbZzDVcRcNj0FG62DBRGNXIV7WQd1D0OwNCDHcYMtfOTcy2/6WR6fUkA5Q/fXIgJMVaHR+cpJADXs0F5ajl7znf40xUGIRcaoVQ8pBAFz5EVJ/Ro1HciFBEBiKW3l88x8ydaX2dl2j1+i5MstjRv+DXzqE1is1H8JCve0YYYBkrMa2XeqtzF7kjFAmox5N5IIBdvFQQCKW0uiFu7/F2HsOMjAIFNxuwaoOVRoSzziw0ljauOkC6qMWDsngjeQZkG5i8PlGgXeYircOYkjsZjQynvwQm48uK9ZexIGoCkVVO9rkze2ZLwHtT8+qdhmNVkNRhFDjI4yZ5MICC1GjuUYntxwbBkCU3CwJ5a6sesF1R81mC02GLtB3AXSTboVKSTcf+wEmPPG8xgeA683MLf8Y4Vavyk4lCyt6IHk0X9CZMBx6LVRCJGv
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEF0B555DCB0BA4C813E0AF9D863D3B8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4383
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(346002)(136003)(376002)(39860400002)(1110001)(339900001)(189003)(199004)(436003)(81166006)(11346002)(229853002)(81156014)(2486003)(86362001)(316002)(5660300002)(54906003)(36906005)(186003)(105606002)(23676004)(446003)(7736002)(305945005)(8936002)(336012)(386003)(3846002)(50466002)(6116002)(6506007)(76176011)(22756006)(33716001)(70586007)(14444005)(6512007)(70206006)(356004)(9686003)(26826003)(25786009)(4326008)(66066001)(6486002)(478600001)(26005)(14454004)(47776003)(102836004)(486006)(476003)(126002)(6862004)(76130400001)(6636002)(6246003)(99286004)(107886003)(2906002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3936;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a3fd4af1-da83-4101-f533-08d7695ee5f8
NoDisclaimer: True
X-Forefront-PRVS: 02229A4115
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD37ed2O/1jg0vRFdUQs/aja/UsUSBbbSH5aDb0C1FBWU7+iK9Hi3wEeTWt2Q3+4Ib/vwYQvVdjfOuCDUm9oCCSWwvFLquCPgIE6HrV6vS4fXy9plphKxk044L8oWNvHwS7D/VHww9rK33geaZMRwXj5jvriV+Uh1TO2WWTyOs0nMzKy5IaXoZIDkcS740Oo/3rNnnLQ/GfSv1bGfy571njXgQdxsOzpPovyLUZdVHLKG0WqTmzd20m1pm/m/w5VmCE6r5ZyxmJk5iJrRTM/EVw/E1XRXBoZzV3EdWYn++mnzeck0F5mUISUZ9GeLf/dfQkj/tOo7jU5uVuq/Bcny26TgLMYUGHlA/iXAEsgfQpJLQFhBuuFIJi/EZaN871M0vZmM9hqnoOaZca4Ixu9KEZbIgUkbttuuXusUhVWCYIT/vVm6TuSopsUBQ6xArUt
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 00:01:07.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e1b154-8d53-426d-07e8-08d7695eea3c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1cnNkYXksIDE0IE5vdmVtYmVyIDIwMTkgMTA6MDQ6MzcgR01UIGphbWVzIHFpYW4gd2Fu
ZyAoQXJtIFRlY2hub2xvZ3kgQ2hpbmEpIHdyb3RlOg0KPiBrb21lZGEva29tZWRhX2V2ZW50LmM6
IEluIGZ1bmN0aW9uIOKAmGtvbWVkYV9zcHJpbnRm4oCZOg0KPiBrb21lZGEva29tZWRhX2V2ZW50
LmM6MzE6Mjogd2FybmluZzogZnVuY3Rpb24g4oCYa29tZWRhX3NwcmludGbigJkgbWlnaHQgYmUg
YSBjYW5kaWRhdGUgZm9yIOKAmGdudV9wcmludGbigJkgZm9ybWF0IGF0dHJpYnV0ZSBbLVdzdWdn
ZXN0LWF0dHJpYnV0ZT1mb3JtYXRdDQo+ICAgbnVtID0gdnNucHJpbnRmKHN0ci0+c3RyICsgc3Ry
LT5sZW4sIGZyZWVfc3osIGZtdCwgYXJncyk7DQo+IA0KPiB2MjogVXBkYXRlIHRoZSBjb21tZW50
IG1zZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGphbWVzIHFpYW4gd2FuZyAoQXJtIFRlY2hub2xv
Z3kgQ2hpbmEpIDxqYW1lcy5xaWFuLndhbmdAYXJtLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9ldmVudC5jIHwgMSArDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYXJtL2Rpc3BsYXkva29tZWRhL2tvbWVkYV9ldmVudC5jIGIvZHJpdmVycy9ncHUvZHJtL2Fy
bS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZXZlbnQuYw0KPiBpbmRleCBiZjI2OTY4M2Y4MTEuLjk3
N2MzOGQ1MTZkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tv
bWVkYS9rb21lZGFfZXZlbnQuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYXJtL2Rpc3BsYXkv
a29tZWRhL2tvbWVkYV9ldmVudC5jDQo+IEBAIC0xNyw2ICsxNyw3IEBAIHN0cnVjdCBrb21lZGFf
c3RyIHsNCj4gIA0KPiAgLyogcmV0dXJuIDAgb24gc3VjY2VzcywgIDwgMCBvbiBubyBzcGFjZS4N
Cj4gICAqLw0KPiArX19wcmludGYoMiwgMykNCj4gIHN0YXRpYyBpbnQga29tZWRhX3NwcmludGYo
c3RydWN0IGtvbWVkYV9zdHIgKnN0ciwgY29uc3QgY2hhciAqZm10LCAuLi4pDQo+ICB7DQo+ICAJ
dmFfbGlzdCBhcmdzOw0KPiAtLSANCj4gMi4yMC4xDQo+IA0KPiANCg0KUmV2aWV3ZWQtYnk6IE1p
aGFpbCBBdGFuYXNzb3YgPG1paGFpbC5hdGFuYXNzb3ZAYXJtLmNvbT4NCg0KLS0gDQpNaWhhaWwN
Cg0KDQoNCg==
