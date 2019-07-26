Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B656C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA6420449
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vdF1kvlw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="1FyqAVn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfGZN7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:59:00 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:56236
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbfGZNkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBdVxUrRvcGUkUMMHm1a+fbvH503IhqDX9b1+ziP25o=;
 b=vdF1kvlwOzvot9mHqiojS7IWKFT4fSHROhsmDla35Ein51gP+mYnstLjtehQ5g5Th1mHXnu615T8WAA3l5mONQkVN+c5dguYwWIEbUJnWTohTK285H24sHsEZW+tn2IDJ9ZY1+3Hdh0ySg+ZSeYemJLj5/uH3kWIfbD/SRvpgzc=
Received: from AM6PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:20b:c0::23)
 by VI1PR0801MB1855.eurprd08.prod.outlook.com (2603:10a6:800:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.17; Fri, 26 Jul
 2019 13:40:27 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::206) by AM6PR08CA0035.outlook.office365.com
 (2603:10a6:20b:c0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10 via Frontend
 Transport; Fri, 26 Jul 2019 13:40:27 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 26 Jul 2019 13:40:26 +0000
Received: ("Tessian outbound 71602e13cd49:v26"); Fri, 26 Jul 2019 13:40:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4575bec6b0a1d680
X-CR-MTA-TID: 64aa7808
Received: from f21b50041842.1 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BFB28717-4DA5-49EC-A251-2353D2E52BEE.1;
        Fri, 26 Jul 2019 13:40:21 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f21b50041842.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Jul 2019 13:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+Panh5l2RsmERHgYf61pB1zWU/Ex0Em1ijjzv/GiiZTLsw0VL71EPEImq1+OwW+06xtmKssSDbQMy8VPT1NIYZFBaXR5ihE1EqpMNNaR7M1C3SdUxA/lUktvv/+9Lj3k2qV0NitI8tW2PS99lZwSHU0QAmU3Qa7IAj2LE2RMDLH/IsJFPc0mxdtY+Q0SUogBcs2k9kgZFMyU6XZKK9xQasL2/8AarQcvtA8tVHUjA+WVI8W/7W5wsJ8Y/Ksx5eQ/bvswv+NhiiswgxrkM9uRqm5WQgL/V/VseKE5D+4E3/fmYLnZ+jwm4aYwnbRZmqQx5j3lmGCDhKZ5p0ZCvIKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgOrKa9ATOzPSuG5yy2BzhCg1iHMKSH8IZHh4HypSZo=;
 b=YUNU7+H4qiZaXn1R8Q61fUtPyzknHpAFuqLm9H/z78JMpu+kd5HXmxRKSVoPkt+Mo1LRj5HzEv3+QTeZmgOKQCBqd+a33O0HQDzV0rmOaQr5uB1wuFUemHeKDEwxOPpQhzFngdt7spBwGLcUTVg/hzJXJBjPDjQqY1DyTplBIgHxjgzSieFLnfJYLelaosEEyjyhUSjs5G46Qlbk1IpvedG6Vlux2xS1z3c0L31g5nJVjhi9sgxwJEs9QrQUlsdVntJBaa/cg+Qugl0WA2+ErOj8UT4IOrmjKKtiaxOyY/pN/n9oDMVufsdjBlX9aYOcRA0i1MrFdKzlFASb7/BTNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgOrKa9ATOzPSuG5yy2BzhCg1iHMKSH8IZHh4HypSZo=;
 b=1FyqAVn045Zs2QSIpcKfJWlaLldSSu9y74uZiFnmK40SUNZoNvMKkTpskjEHK81WI1KES1odxDOfugYzUbKKZDvG7iICtKSe6adOXvCwd9HU9YKiBDEVvYrm7YCKK9ZrNTJnzN/Fy4IMGJh6pOXHu54D5n9kQ8Zapbwr3Sq6Ssw=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2130.eurprd08.prod.outlook.com (10.172.219.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 13:40:19 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::547b:d806:40d0:50fc]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::547b:d806:40d0:50fc%5]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 13:40:19 +0000
From:   James Clark <James.Clark@arm.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Topic: [PATCH 1/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Index: AQHVQ7Vvq+lMjjxezEm4ixWlJXREeabc5+eA
Date:   Fri, 26 Jul 2019 13:40:19 +0000
Message-ID: <00f00310-09ae-909c-4dfd-021996e45be1@arm.com>
References: <4ae020be-180e-4cb6-4b84-a2d519b466ef@arm.com>
 <16b1f7b1-4058-e2e9-c5fd-ceef5a947d2e@arm.com>
In-Reply-To: <16b1f7b1-4058-e2e9-c5fd-ceef5a947d2e@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LNXP265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::26) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e6baab0e-515c-4bce-eadb-08d711ced12f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2130;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2130:|VI1PR0801MB1855:
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1855827B6A98D6177A8CC09BE2C00@VI1PR0801MB1855.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 01106E96F6
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(40434004)(199004)(189003)(4744005)(31686004)(4326008)(26005)(66066001)(54906003)(11346002)(446003)(476003)(229853002)(6916009)(486006)(14444005)(5024004)(66556008)(71200400001)(2616005)(186003)(478600001)(71190400001)(256004)(66946007)(36756003)(7736002)(14454004)(2351001)(52116002)(6512007)(305945005)(316002)(6116002)(3846002)(102836004)(44832011)(6506007)(64756008)(8676002)(66476007)(76176011)(386003)(68736007)(2501003)(25786009)(81156014)(31696002)(86362001)(2906002)(66446008)(81166006)(8936002)(5640700003)(6246003)(53936002)(99286004)(6486002)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2130;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: OA9D9Slve1Pdjj2/mZxEP5PAl8WS+/kA+VjzngmH0ynBOPr3RbyMAh/ChGqxynT3ZhnlG79PdJODaVAUrrR3Li5BAj8Rwv1pSuJm0xrJmQsrBN6tRFWK/R/XcFcxOXzPd3baGRsClT23b7tWmJi9Ttoc/fAfx+8+O8PZESN1fi73becmjyfr2C3oNEClV5BRXg8hOBwHe3d2Lj/pLzzIU6sFlJTjKAltP1L9Vbw7RuuKf4uy9Imf4hWsVFf5S7MRdu+io5eh5lO0SEf4yN9yGxdJydYj5gY4rPshLQWw9lfj93OIM+7U3JXp1r/1g+vFXyRpIlmANTet4Nqt15SzzanxZVxkMoCw8vLGZ5jqLV59f/3jBRmqcmdkXHShBG5mHc8OACsnuqFUXxVljGVLWsyV7q3BdvtueQ6+aPOHuVo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BE146503469C341839C979B41A5B068@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2130
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(2980300002)(199004)(189003)(40434004)(66066001)(4326008)(305945005)(36756003)(81156014)(14444005)(54906003)(102836004)(356004)(50466002)(36906005)(8676002)(81166006)(47776003)(186003)(486006)(63350400001)(3846002)(5024004)(4744005)(436003)(7736002)(63370400001)(316002)(99286004)(76176011)(6506007)(476003)(8936002)(446003)(26005)(2486003)(22756006)(336012)(23676004)(5640700003)(2906002)(6486002)(6916009)(126002)(76130400001)(2616005)(2501003)(11346002)(31696002)(478600001)(450100002)(6246003)(70586007)(229853002)(31686004)(70206006)(86362001)(6512007)(25786009)(2351001)(5660300002)(14454004)(26826003)(386003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1855;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 90dc5cdc-c1f6-40b4-7e67-08d711ceccfd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0801MB1855;
X-Forefront-PRVS: 01106E96F6
X-Microsoft-Antispam-Message-Info: clGmX/zl2MU8JeY5yOdlW7Cqx4u4ZhfIzfYkJGXn4iFYqe6IjTWinfX623RtYUoxsEjbHoXDnftoAlOZpGGI50VMmAjJDXF3thvZu4vbXbZm+PZ78eAli3SA0i2OBf5GJLqJozcmXgxOFSt6CpI7BQ+i05HMSMxvwhy+A44rNe+u4FFfREiT0cziPiSbUosdEKRq/ekJaU3zcg9p80wzU/1dEkHFo5gcnlkNjnY6i5wR/zokyJzDOHJQL/U7ndIeWvyyMXVPmzQ+F7a5Mxx871rCq2G36/TLDyHlYUY7rY2h8P4Nw/9rXaC0Ox5fVVLjxU0Y9T95eFIphZrih/jnjuvl4ktjzazh5aTmMX1Ces2Dkm3vWyI2W0am6wEECJxts2MvDYWtshn1pf34InEJfYGnnObSxaTj52xh7OrzBfE=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2019 13:40:26.5557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6baab0e-515c-4bce-eadb-08d711ced12f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IElNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkg
YXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4g
SWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFu
eSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkg
dGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCj4NCg0KUGxlYXNlIGln
bm9yZSB0aGUgbm90aWNlLCBJIHdpbGwgZ2V0IHRoYXQgcmVtb3ZlZC4NCklNUE9SVEFOVCBOT1RJ
Q0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNv
bmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVz
ZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGlu
IGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==
