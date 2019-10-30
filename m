Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF0CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2626320874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b2OGvSQ7";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="b2OGvSQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfJ3LEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:04:01 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:3138
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbfJ3LEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drG2s95FlPHzLtaCB7CK+eu2vgqqVuggRRanMCwbbPI=;
 b=b2OGvSQ784drGF+7EDLnbPqPQmDbOcOzBNZVL6/S7RESewItKc4+D3tkgjXHAzoLrNMpF+9YhW6pDQZo//ca1wuCpdXMZjGoer7hQAyTTUN/s2ioqNi1FiHEJrAPjKicDQGTex5k/7LYaom9ifj4SUaWdKgOHQF1bmtC4zx1mtQ=
Received: from VI1PR0802CA0025.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::11) by DB7PR08MB3276.eurprd08.prod.outlook.com
 (2603:10a6:5:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Wed, 30 Oct
 2019 11:03:52 +0000
Received: from DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0802CA0025.outlook.office365.com
 (2603:10a6:800:a9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Wed, 30 Oct 2019 11:03:52 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT040.mail.protection.outlook.com (10.152.20.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 30 Oct 2019 11:03:52 +0000
Received: ("Tessian outbound 6481c7fa5a3c:v33"); Wed, 30 Oct 2019 11:03:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8c6c8a75f9282954
X-CR-MTA-TID: 64aa7808
Received: from 16cca4489d9e.1 (cr-mta-lb-1.cr-mta-net [104.47.13.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A9A8B00F-5606-4138-9E9C-FD8C3992EE45.1;
        Wed, 30 Oct 2019 11:03:45 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2051.outbound.protection.outlook.com [104.47.13.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 16cca4489d9e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 30 Oct 2019 11:03:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Keh6Qkz1ewawjkyOJOi9BKt2X/mNeXVrgCR73gmmO81H7fIe8MiJGIwVOk18pjqKX185hM7iEFfY0kX8pjSWW8iXOkb/uesESxwA/ZIoavPBx4JwPXJksMgC9qJJpr+JBqb+xV7RVpnYwVc0Hph2chYdI1D3iFutkb4pmGKyGaDXofIn1jqqczIUE6tgFyhMlEdOjcSgCm7mATyaRTfFVHjJ+8FfULqP+qbdk1rU9Q+awmZ5p5moyj3MSbuE6tUMYTpi9tyqlu+Yb6ORf9knVDpRo4f7+d40zZSiun4hBgvyxHO1ctwgVkyaB9INW9xhGt/wwYsil5tXqukCMQb6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drG2s95FlPHzLtaCB7CK+eu2vgqqVuggRRanMCwbbPI=;
 b=Q0MNV54H21zn6Fyzl4SLgzSQLrfIlBdZr02QQqMI8WvW1ChMb1NjF5htcBEIR0JJsG0Aeua4gtYEhPmmvaKDpopvqJICyUP5zrSxuG5S1BkMFuHFJku2LGB9BURwEtkFw2oc2tbyc2JLWUMaJqh1JOcCrQr6vvI+0QIXzyZiQ3hnq4abB/oJLYpdVxfRM9ilMouQo9pjbokUk0yiOeAfMpwjpg5l4dmaAqfLUGgKfdsgSZUV91PyqIiTTG4E2HAqg+DXLls6xCLGgILxvLXziKSKxx/8WIXzCAR1e66jVOhx5EbdYGK2uwpv5jR5LLobZpWWKAYtjeYwPr8kPr1Anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drG2s95FlPHzLtaCB7CK+eu2vgqqVuggRRanMCwbbPI=;
 b=b2OGvSQ784drGF+7EDLnbPqPQmDbOcOzBNZVL6/S7RESewItKc4+D3tkgjXHAzoLrNMpF+9YhW6pDQZo//ca1wuCpdXMZjGoer7hQAyTTUN/s2ioqNi1FiHEJrAPjKicDQGTex5k/7LYaom9ifj4SUaWdKgOHQF1bmtC4zx1mtQ=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2164.eurprd08.prod.outlook.com (10.172.215.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 11:03:43 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.027; Wed, 30 Oct 2019
 11:03:43 +0000
From:   James Clark <James.Clark@arm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Thread-Topic: [PATCH] Fixes issue when debugging debug builds of Perf.
Thread-Index: AQHVjYOYRLLudNMVSkWDWCd/TfiO3Kdxp4UAgAAFBwCAAAI3gIABWZcA
Date:   Wed, 30 Oct 2019 11:03:43 +0000
Message-ID: <578c3a3a-2972-2b95-b98c-aee78950f5bb@arm.com>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org> <20191029141852.GC4922@kernel.org>
 <20191029142647.GD4922@kernel.org>
In-Reply-To: <20191029142647.GD4922@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::16) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1549b567-9c15-4299-f293-08d75d28d95a
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2164:|DB7PR08MB3276:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DB7PR08MB3276E1A4398E3D1ABFB69364E2600@DB7PR08MB3276.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2657;OLM:2657;
x-forefront-prvs: 02065A9E77
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(199004)(189003)(966005)(54906003)(6916009)(25786009)(36756003)(6512007)(6306002)(31686004)(14454004)(478600001)(4326008)(6486002)(6436002)(66066001)(229853002)(186003)(102836004)(26005)(446003)(476003)(486006)(2616005)(44832011)(11346002)(8676002)(8936002)(316002)(81166006)(81156014)(53546011)(386003)(6506007)(99286004)(76176011)(14444005)(6246003)(52116002)(2906002)(66946007)(86362001)(66556008)(66446008)(64756008)(66476007)(305945005)(7736002)(256004)(31696002)(71190400001)(71200400001)(6116002)(5660300002)(3846002)(299355004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2164;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SFKsJFTLfsikrczVV+elOst4feqaAUsUuzAHKKhK/9mwnuhoS3MrTQyr2NMP/v9zJoiVTiQ5hsxbX5anJnDYIRBw7/WfXhmr80u47obpkfe5VaYVVDigLK5EhKkaPJ63k6YXugHd3+/0CkwGkdb3LSDtKQvw17xNKNE3GT8F3rKXibecJLkHFkKLf+bhljCA+snq8erSwtcdIkmWuaSdGbfkAHbjWVEt+EoBA721ccAupkwv1NeU7czpMZqNeWDGUEpceNDQnRWy+b90atJ8mx1o4IKts+uU+NlcABs383WmEcWkmWJhal6T2MssX9nv1y53lKvGu/Jop7SnPnT6DslKGaMqhaPSyV/KLWTarpUxjIKldaKCsFcHpLeaSSPm6HLbDtoD0fZwM027fCAo7ydb1E5mc62l01CLuWVUfwFCF+hU5qngLfROCLh3TzaErjDe1bipXqA+FYUSG0jkoK8/WgTvLYu3XnLWTvzCMV4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BC226332A3B4344A7CF0E593EA674EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2164
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT040.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(1110001)(339900001)(199004)(189003)(14454004)(47776003)(14444005)(336012)(22756006)(7736002)(86362001)(11346002)(446003)(476003)(2616005)(2906002)(25786009)(356004)(436003)(126002)(305945005)(99286004)(3846002)(31696002)(76130400001)(36756003)(450100002)(66066001)(6246003)(966005)(26826003)(6116002)(478600001)(5660300002)(23676004)(54906003)(6506007)(53546011)(6862004)(102836004)(26005)(186003)(70586007)(31686004)(81156014)(81166006)(8676002)(70206006)(105606002)(6486002)(8936002)(50466002)(76176011)(316002)(386003)(229853002)(2486003)(6306002)(486006)(6512007)(4326008)(299355004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3276;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 669b5433-39c4-4c84-9ef3-08d75d28d400
NoDisclaimer: True
X-Forefront-PRVS: 02065A9E77
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4zutxcBbTapqo22+tvnpCFSSNaaPPCt7NSa0d3pojhB8u0VkgWUqYXIm6uS05iixxwdY0fvzWQP1Fxy2++v6MlpLPEpeS/tEiE74a78A55md1m1Ix58S548DJAIG3KIwP8my5vhujIONPkJv54FeyPCbKU3INXyzWnY1Wb4vPHYz7TkuW/f7Qt/SU1sVWRGI7Bfz+sOiMqQeVqj1SIUYmysexo09M+zBS6l5wlIsS36szz+naUWkcWddfWo3br7g9jXUFtVn9pCOKaZgje7lfxRnQnkxY236900TBhPJC+xGijF3sV2iVLYxeGAC9XqOuNFgHwyFkiJc7oHVEBaLhe+BiolORMDHqSUDX0XgFgVrirOw3lG2RBNZMUKWO3U03PtUNpH/KO2o3Yt/UvEZe2nFFi/Yfm2DGKNQZX774PCDBtKh0hJ3lLklniDkrOPDwWrU9xYPVivQBrfZIkGG4UCPCF1Vtdc1H271/HEfwk=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2019 11:03:52.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1549b567-9c15-4299-f293-08d75d28d95a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3276
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuYWxkbywNCg0KVGhhbmtzIGZvciB0aGF0LCB5ZXMgc2VwYXJhdGluZyB0aGVtIGxvb2tz
IGJldHRlci4NCkkgd2lsbCB0cnkgdG8gYnJlYWsgZG93biBjb21taXRzIGluIHRoZSBmdXR1cmUu
DQoNCj4gVGhlIHBhdGNoIGNhbWUgbWFuZ2xlZCwgc28gSSdtIGFwcGx5aW5nIGJ5IGhhbmQsIGFu
ZCBzZXBhcmF0aW5nIGl0IGludG8NCj4gdHdvIHBhdGNoZXMsIHRoZSBmaXJzdCBmb3IgdGhlIGZp
cnN0IHBhcmFncmFwaCBhbmQgdGhlIG90aGVyIGZvciB0aGUNCj4gc2Vjb25kLCBvaz8NCg0KQnkg
bWFuZ2xlZCBkbyB5b3UgbWVhbiB0aGUgcXVvdGVkIHByaW50YWJsZXMgIj0zRCIgYW5kICI9MjAi
Pw0KDQpJdCBzZWVtcyBsaWtlIGdpdCBzZW5kLWVtYWlsIGZhbGxzIGJhY2sgdG8gdGhpcyBiZWhh
dmlvciBieSBkZWZhdWx0Og0KDQogICAgICAgICANCiAgICAgLS10cmFuc2Zlci1lbmNvZGluZz0o
N2JpdHw4Yml0fHF1b3RlZC1wcmludGFibGV8YmFzZTY0fGF1dG8pDQoNCiAgICAgICBTcGVjaWZ5
IHRoZSB0cmFuc2ZlciBlbmNvZGluZyB0byBiZSB1c2VkIHRvIHNlbmQgdGhlIG1lc3NhZ2Ugb3Zl
ciBTTVRQLg0KICAgICAgIDdiaXQgd2lsbCBmYWlsIHVwb24gZW5jb3VudGVyaW5nIGEgbm9uLUFT
Q0lJIG1lc3NhZ2UuIHF1b3RlZC1wcmludGFibGUgY2FuIGJlDQogICAgICAgdXNlZnVsIHdoZW4g
dGhlIHJlcG9zaXRvcnkgY29udGFpbnMgZmlsZXMgdGhhdCBjb250YWluIGNhcnJpYWdlIHJldHVy
bnMsIGJ1dA0KICAgICAgIG1ha2VzIHRoZSByYXcgcGF0Y2ggZW1haWwgZmlsZSAoYXMgc2F2ZWQg
ZnJvbSBhIE1VQSkgbXVjaCBoYXJkZXIgdG8gaW5zcGVjdA0KICAgICAgIG1hbnVhbGx5LiBiYXNl
NjQgaXMgZXZlbiBtb3JlIGZvb2wgcHJvb2YsIGJ1dCBhbHNvIGV2ZW4gbW9yZSBvcGFxdWUuIGF1
dG8gd2lsbA0KICAgICAgIHVzZSA4Yml0IHdoZW4gcG9zc2libGUsIGFuZCBxdW90ZWQtcHJpbnRh
YmxlIG90aGVyd2lzZS4NCg0KDQpJIGNvcGllZCBteSByYXcgcGF0Y2ggYW5kIHdhcyBhYmxlIHRv
IHN1Y2Nlc3NmdWxseSBhcHBseSBpdCB3aXRoIGdpdCBhbSwgZXZlbiB3aXRoIHRoaXMgZXNjYXBp
bmcuIEFsdGhvdWdoIEkNCmRpZCB1cGdyYWRlIHRvIGEgbmV3ZXIgdmVyc2lvbiBvZiBnaXQgKDIu
MjMuMCkuDQoNCklmIEkgdmlldyB0aGUgcGF0Y2ggdGhhdCB5b3UgY3JlYXRlZCwgdGhlbiBpdCBk
b2Vzbid0IGhhdmUgcXVvdGVkIHByaW50YWJsZSBlc2NhcGluZy4gU28gdGhlcmUgZG9lcw0Kc2Vl
bSB0byBiZSBhIGRpZmZlcmVuY2Ugc29tZXdoZXJlLg0KRG8geW91IHRoaW5rIEkgc2hvdWxkIHVz
ZSAiZ2l0IHNlbmQtZW1haWwgLS10cmFuc2Zlci1lbmNvZGluZz03Yml0Ij8NCg0KDQpUaGFua3MN
CkphbWVzDQoNCk9uIDI5LzEwLzIwMTkgMTQ6MjYsIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyB3
cm90ZToNCj4gRW0gVHVlLCBPY3QgMjksIDIwMTkgYXQgMTE6MTg6NTJBTSAtMDMwMCwgQXJuYWxk
byBDYXJ2YWxobyBkZSBNZWxvIGVzY3JldmV1Og0KPj4gQW5kIGhlcmUgaXMgdGhlIGZpcnN0IHBh
dGNoIG91dCBvZiB5b3VyIGxhcmdlciBvbmUsIEkgY2hhbmdlZCB0aGUNCj4+IHN1YmplY3QgbGlu
ZSB0byByZWZsZWN0IHRoYXQgdGhpcyBpcyBub3QgdG9vbHMvcGVyZiBzcGVjaWZpYywgYXMNCj4+
IHRvb2xzL29ianRvb2wvIGFsc28gdXNlcyBsaWJzdWJjbWQsIGFkZGVkIEpvc2gsIG9ianRvb2wn
cyBtYWludGFpbmVyIHNvDQo+PiB0aGF0IGhlIGlzIG1hZGUgYXdhcmUuDQo+IA0KPiBBbmQgdGhl
IHNlY29uZCBwYXRjaDoNCj4gDQo+IA0KPiBjb21taXQgZDAzODE0NDlmZDlhYjczM2VjMmRhZjUy
NzI2M2RhOWY3M2YxZTk0ZQ0KPiBBdXRob3I6IEphbWVzIENsYXJrIDxKYW1lcy5DbGFya0Bhcm0u
Y29tPg0KPiBEYXRlOiAgIE1vbiBPY3QgMjggMTE6MzQ6MDEgMjAxOSArMDAwMA0KPiANCj4gICAg
IGxpYnN1YmNtZDogVXNlIC1PMCB3aXRoIERFQlVHPTENCj4gICAgIA0KPiAgICAgV2hlbiBhICdt
YWtlIERFQlVHPTEnIGJ1aWxkIGlzIGRvbmUsIHRoZSBjb21tYW5kIHBhcnNlciBpcyBzdGlsbCBi
dWlsdA0KPiAgICAgd2l0aCAtTzYgYW5kIGlzIGhhcmQgdG8gc3RlcCB0aHJvdWdoLCBmaXggaXQg
bWFraW5nIGl0IHVzZSAtTzAgaW4gdGhhdA0KPiAgICAgY2FzZS4NCj4gICAgIA0KPiAgICAgU2ln
bmVkLW9mZi1ieTogSmFtZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGFybS5jb20+DQo+ICAgICBDYzog
QWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+ICAgICBDYzogSWFuIFJv
Z2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiAgICAgQ2M6IEppcmkgT2xzYSA8am9sc2FAa2Vy
bmVsLm9yZz4NCj4gICAgIENjOiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4N
Cj4gICAgIENjOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQo+ICAgICBDYzog
bmQgPG5kQGFybS5jb20+DQo+ICAgICBMaW5rOiBodHRwOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAxOTEwMjgxMTMzNDAuNDI4Mi0xLWphbWVzLmNsYXJrQGFybS5jb20NCj4gICAgIFsgc3BsaXQg
ZnJvbSBhIGxhcmdlciBwYXRjaCBdDQo+ICAgICBTaWduZWQtb2ZmLWJ5OiBBcm5hbGRvIENhcnZh
bGhvIGRlIE1lbG8gPGFjbWVAcmVkaGF0LmNvbT4NCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9s
aWIvc3ViY21kL01ha2VmaWxlIGIvdG9vbHMvbGliL3N1YmNtZC9NYWtlZmlsZQ0KPiBpbmRleCAz
NTJjNjA2MmRlYmEuLjFjNzc3YTcyYmIzOSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbGliL3N1YmNt
ZC9NYWtlZmlsZQ0KPiArKysgYi90b29scy9saWIvc3ViY21kL01ha2VmaWxlDQo+IEBAIC0yNyw3
ICsyNyw5IEBAIGlmZXEgKCQoREVCVUcpLDApDQo+ICAgIGVuZGlmDQo+ICBlbmRpZg0KPiAgDQo+
IC1pZmVxICgkKENDX05PX0NMQU5HKSwgMCkNCj4gK2lmZXEgKCQoREVCVUcpLDEpDQo+ICsgIENG
TEFHUyArPSAtTzANCj4gK2Vsc2UgaWZlcSAoJChDQ19OT19DTEFORyksIDApDQo+ICAgIENGTEFH
UyArPSAtTzMNCj4gIGVsc2UNCj4gICAgQ0ZMQUdTICs9IC1PNg0KPiANCg==
