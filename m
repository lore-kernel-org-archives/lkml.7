Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E0DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE94020679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tHFH25Sm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="t/tGWGOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440718AbfJYP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:26:58 -0400
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:40846
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731226AbfJYP05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEMOYudQG+nLvsttJlkqDHuWmer+vdugxtk1eGnhU9w=;
 b=tHFH25SmX3ftm4Mobwja+YhuKAPsMtnMYiX8oKRqGRar5DKk3n7KQGmIVYaG3OIc5xuDy6qpwm792bHVrxfB8lqmsrzllFx0cfEyBgj9Y+SmdOndCIED+0WxaMcn3QWqecQLftACPzCYoYAgiT0oQ3mK8UBNsYZJvflvVPz3vs4=
Received: from DB6PR0802CA0045.eurprd08.prod.outlook.com (2603:10a6:4:a3::31)
 by DB8PR08MB5530.eurprd08.prod.outlook.com (2603:10a6:10:11f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Fri, 25 Oct
 2019 15:26:52 +0000
Received: from DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by DB6PR0802CA0045.outlook.office365.com
 (2603:10a6:4:a3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Fri, 25 Oct 2019 15:26:52 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT050.mail.protection.outlook.com (10.152.21.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Fri, 25 Oct 2019 15:26:52 +0000
Received: ("Tessian outbound 0939a6bab6b1:v33"); Fri, 25 Oct 2019 15:26:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed44c5c205ac56a0
X-CR-MTA-TID: 64aa7808
Received: from 99db361510f5.2 (cr-mta-lb-1.cr-mta-net [104.47.10.58])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 26A60225-7EFD-485C-9E29-428FD083DB6D.1;
        Fri, 25 Oct 2019 15:26:45 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 99db361510f5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Fri, 25 Oct 2019 15:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrmuYg6Djxikh9DYTVtD6B48hVt1Ke1DWh4DCTKfOb4/9QUdQn2XPo0zDohTENIfCJzg0GIgKIRPggToVRguhyjb972uR3i8fhCorzPLdkaf7ggNOQMYn5inbwV0IhiQrv1LrimoraZHatmOzcnB+iLrKbQyB57WiIgMsnPZf9d14XAv2SzqVexyVtIFfS1cfzAplaRNGFfNOcoTFmtyi8BhjxfhNBYA9WZ7O/3Dbcp/T7nUArEkCkGzpzdXlVwdjGIy1aKGa9xLSbtU2Dk3L7Wd+Eyp2AHoxdHHtUbBrgii7Cc3oijJwZSrP0KHiVPSVGQT3HbmE9Jo5oo4eunTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFXPIm8P1frjD8BOUeLbyPNn3sTeS8tO0e5x7XbdKyQ=;
 b=WjjAUd71427ZK6JWxBs/AqjdWl7O+XsZ8jvHVqpCyNG6hwFhSaCaAt0hNfdcSsuV3+FZHFt5ImIGgIkneihOazVFqz0JLvj6TlM6QmBasitJihTWGP6NNVe/vaAVDU5FXAuQXwuhfkhXBEsxdbjFFE1jNIqVM4fZm8X7e9wia9Te2GgEGMhQUguOUIlasvjJ8Yb7bUY1ADqR9lf9MD6/UXbfrBGbBlIoALsiUffpxqKbE9wEonh2nuQyZIgta59c5DMJdRUbQA/Pcom0HL9z8I4AwMi8NR7/ct8xiCLwWNv2pGyBw8e25MABN2YBComDTNEcl+NjDDUI8rKeb5ifrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFXPIm8P1frjD8BOUeLbyPNn3sTeS8tO0e5x7XbdKyQ=;
 b=t/tGWGOlJNujtSEir4EPkwtyEJ1Phgds38QlFk/SR0jjxGDpRHskXRJ7ijLqvK3197blILbH6ARofnRdkXzsXHpywsffqeWRXgwJ2eU+mCygq+J22gfEJylSsJMg7yHKlR6nuGHTQ3evyTnuGeQK34tYrpRMKrlOwOwv2NPcuRI=
Received: from VI1PR0801MB1790.eurprd08.prod.outlook.com (10.168.67.143) by
 VI1PR0801MB1885.eurprd08.prod.outlook.com (10.173.71.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Fri, 25 Oct 2019 15:26:43 +0000
Received: from VI1PR0801MB1790.eurprd08.prod.outlook.com
 ([fe80::7ca1:beb:8a1f:607b]) by VI1PR0801MB1790.eurprd08.prod.outlook.com
 ([fe80::7ca1:beb:8a1f:607b%3]) with mapi id 15.20.2387.025; Fri, 25 Oct 2019
 15:26:43 +0000
From:   Valentin Schneider <Valentin.Schneider@arm.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [QUESTION] Hung task warning while running syzkaller test
Thread-Topic: [QUESTION] Hung task warning while running syzkaller test
Thread-Index: AQHVgl11bWBDyU55z0yIxPyV+36p6adp71sAgAFxbACAACuwAA==
Date:   Fri, 25 Oct 2019 15:26:43 +0000
Message-ID: <1e247b1f-74cf-dab3-05c1-36adc411478d@arm.com>
References: <0d7aa66d-d2b9-775c-56b3-543d132fdb84@huawei.com>
 <1693d19e-56c7-9d6f-8e80-10fe82101cff@arm.com>
 <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
In-Reply-To: <aa5d0f35-e707-f5e3-251e-f940c0b0232b@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [78.146.242.238]
x-clientproxiedby: LO2P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::23) To VI1PR0801MB1790.eurprd08.prod.outlook.com
 (2603:10a6:800:5b::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Valentin.Schneider@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0fab7103-4a3d-4014-59a1-08d7595fc2de
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1885:|DB8PR08MB5530:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB553066F357B14B4396C7E8A38F650@DB8PR08MB5530.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 02015246A9
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(54094003)(199004)(189003)(36756003)(86362001)(99286004)(7736002)(66066001)(66446008)(44832011)(64756008)(6486002)(66556008)(2906002)(26005)(2501003)(52116002)(6116002)(229853002)(102836004)(5660300002)(386003)(76176011)(53546011)(6506007)(486006)(14454004)(478600001)(31686004)(4744005)(2616005)(446003)(476003)(11346002)(110136005)(186003)(66946007)(6246003)(66476007)(54906003)(8676002)(3846002)(6512007)(316002)(71200400001)(256004)(81166006)(8936002)(81156014)(71190400001)(6436002)(4326008)(31696002)(25786009)(5024004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1885;H:VI1PR0801MB1790.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Hno3LUw0ipxWzMedHZF9Vn3pKlESqzuAzbVT4OOWZ2zRmA3N7LBRfUviMAvtxwR/gTu6IoxLgn21OUBCMLhMFRv16cxTDdISCAo+S+sT5l47Meg5gObkkJDCRypo9yTwULUu09suSKX9rx/12uXbrao8DNFoMxNHQRhKpoMrCNNOJDlNm4tjQmRH3IaerP8eMMfjhkJtpiExZSjsJsgA67emCUioxjtDMWsPUPXeRQ1IgcUOBmWBm7mz6yHiXeOa8qg5XsURCF1Klon5mexc6Ipjzp/n9YGdy6KCOmY1noUPko4um772wZJjsj4daF1VtJRyrXXud9C4zyrZTU4/NH8hWrpEyLNzo+9JakRlezSWZp8pkyNE8Mk4YIgWPz8KCM1AGqLAeHIUl3N5TThh/rthgEeDdy7cAWK311Zwnt10/ndAANEoVJOVS35J34MO
Content-Type: text/plain; charset="gb2312"
Content-ID: <A86E952E3EAE9A4F8FC0F90B65FF5A90@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1885
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Valentin.Schneider@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(1110001)(339900001)(199004)(189003)(54094003)(40434004)(99286004)(478600001)(66066001)(6246003)(229853002)(26005)(8936002)(110136005)(54906003)(186003)(356004)(316002)(305945005)(6486002)(6512007)(102836004)(336012)(107886003)(47136003)(31686004)(76176011)(105606002)(76130400001)(3846002)(6506007)(53546011)(4326008)(6116002)(436003)(386003)(5660300002)(22756006)(4744005)(50466002)(23696002)(486006)(7736002)(14454004)(446003)(2501003)(476003)(81166006)(47776003)(126002)(31696002)(86362001)(81156014)(8676002)(2616005)(5024004)(11346002)(14444005)(70206006)(25786009)(70586007)(48336001)(26826003)(2906002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB5530;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a61823ad-2e0c-40f1-784f-08d7595fbd9b
X-Forefront-PRVS: 02015246A9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCLtVXdN5jsQCNDN+PchO6tY8vD4wME2J3hqEmZsGekU19dPt6+oLiDFldhnO/779WMUZ6nixttZcC+otQ/aVGpYTVNnocZwXxeZza2cWlHO/LCGoj24slOwZfktmdjnAR5WUxBYfI2MXZSDSoBDy35PkC7GWXuJPIG9DgwYudNZYh0l+l6nMoSIQ/FfNre4s1bJNpyuq9/vEuTFJy97D6S6T6VZlhLUvl50hYyqeh/M393SFxcPwjkE3SznBhfz0E9nuncfwQIP8p/HN0Zbo6UpgHytbJr4pndWG/Vd0BtTNwfQN70RK9TBx4S4TUgyMY10Rt7srZ2fFwERI+/pKZ2k1DnyJCQSons8u+dpRqWBFHoTUabtyS8bNzxFHInIws3LRiXWMrq8pGan6EJFAFjpwFAI804HbTIp4SAOPXDDKRmHKgXCmxzpKu/XRqD2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2019 15:26:52.1821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fab7103-4a3d-4014-59a1-08d7595fc2de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUvMTAvMjAxOSAxMzo1MCwgWmhpaGFvIENoZW5nIHdyb3RlOg0KPiBJIGFkZGVkIGNvbmZp
ZyBpbiBhdHRhY2htZW50Lg0KPg0KPiBJdCB3aWxsIHRha2UgNS0xMCBtaW51dGVzIHRvIHJlcHJv
ZHVjZSBvbiB0aGUga2VybmVsIG9mIHRoZSBsb3dlciB2ZXJzaW9uKGZvciBleGFtcGxlLCB2NC40
KS4gQW5kIGZ0cmFjZSBtYXkgbmVlZCB0byBiZSBlbmFibGVkIGZvciB0aGUgbGF0ZXN0IG1haW5s
aW5lIHRvIHJlcHJvZHVjZSBodW5nX3Rhc2ssIGl0IHdpbGwgdGFrZSBzZXZlcmFsIGhvdXJzLg0K
Pg0KDQpUaGF0IHNvdW5kcyBmdW4uIEknbGwgdHJ5IHRvIGdldCB0aGF0IHJ1bm5pbmcgb3Zlcm5p
Z2h0IHNvbWVkYXkgSSdtIG5vdA0KcnVubmluZyBvdGhlciBzdHVmZiwgdGhvdWdoIFRCSCBzZWVp
bmcgYXMgdGhlIGZyZWV6ZXIgaXMgaW52b2x2ZWQgSSB3b25kZXIgaWYNCml0IGlzbid0IGp1c3Qg
c3l6a2FsbGVyIGtlZXBpbmcgc3R1ZmYgZnJvemVuIGZvciB0b28gbG9uZy4NCklNUE9SVEFOVCBO
T1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3Qg
dGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24s
IHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9u
IGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
