Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FCFC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEA82173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CjVHLsOj";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CjVHLsOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfIBQId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 12:08:33 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:30176
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbfIBQIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UvnjU0gZE5Bt4ndJL4qMcV1q/dghPbx+NMApdVHyFE=;
 b=CjVHLsOjsW/3CtvG3x3197yq3d1OkeVkJ8PzGuefKbFdJQXCY4gexvDZJvf3BLhI7Co3aaqWHYhEpZ+4wRIsq1RCfsfKSYTAD1E5WpKWrYcFGvqU3JVgAHob8MbOZvd2F6efQqFE/eFeuWqeXbQrmkqaa+YNLzSxH3Spm7Rwdb0=
Received: from DB6PR0801CA0046.eurprd08.prod.outlook.com (2603:10a6:4:2b::14)
 by VI1PR0802MB2608.eurprd08.prod.outlook.com (2603:10a6:800:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.21; Mon, 2 Sep
 2019 16:08:23 +0000
Received: from AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by DB6PR0801CA0046.outlook.office365.com
 (2603:10a6:4:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.18 via Frontend
 Transport; Mon, 2 Sep 2019 16:08:23 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT056.mail.protection.outlook.com (10.152.17.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Mon, 2 Sep 2019 16:08:20 +0000
Received: ("Tessian outbound 802e738ad7e5:v27"); Mon, 02 Sep 2019 16:08:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c95ee69a1b96d1c2
X-CR-MTA-TID: 64aa7808
Received: from 4631eaee93e3.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8EA02E3F-A276-4C60-857C-B172E909D10D.1;
        Mon, 02 Sep 2019 16:08:15 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4631eaee93e3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Mon, 02 Sep 2019 16:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAnID8gZf2Oysz5qjXRqq5vkAVIY4a7uDPw9cr5J4dJ9n+roRWmx4F0oQif8lMYio+nb+XXvQSrQdAE8tjUgMpUV9r2Z8sYsi0aU86BorT4EPPLmZDjPfYkAJltZ3SDy2HbSnjGCYqRaOz4rKkzvGjjtk9VZwS9u8iEy5MDWhCoCGcb+YvHoS7cwa/8J1CFBwWtVAzdf+OE1D8AxTBuD5K/r7flYMk7Jm4C31ImVrYAcvlfbMgmtlUgBvurH/MQjBKN51l5JJECkmI5JC6KRAnWzWoMTrTepKkKTP9FcdoiucZsmypXxUvevbOcsWIH8O0xQM86KkDzSqv1H/OAy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UvnjU0gZE5Bt4ndJL4qMcV1q/dghPbx+NMApdVHyFE=;
 b=eInz0kewAt1JJiFcJhdqnotvZqWLKtPp5djZKCcVkGD6ZovTTT9q8ainYmi3GmEXw3ZepJUlWx/M/aZP3bT3dBCf9xkueUu0Eaa9oTo/HONY/KpAXSTIe9y41PXHsdo0MCz30VztVnznJY2zRW1iBiHjMY4EJinkJSJV5BGg8Txy0MOBHtiMRQP7cIYqojCYEAA1x3IRaxhZKydYu6xiSazU2GKEoLuWJFYcSG/TP/eP3+V1B5zQlQ71lCH9f//TWYzr5jPIYsI6+ykoReLMiFmkr06ifyfszORFMVMKJYpUSax94K1Zgm+1qbS0O8chwmPo2jg9HNJqby1Ion2Brw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UvnjU0gZE5Bt4ndJL4qMcV1q/dghPbx+NMApdVHyFE=;
 b=CjVHLsOjsW/3CtvG3x3197yq3d1OkeVkJ8PzGuefKbFdJQXCY4gexvDZJvf3BLhI7Co3aaqWHYhEpZ+4wRIsq1RCfsfKSYTAD1E5WpKWrYcFGvqU3JVgAHob8MbOZvd2F6efQqFE/eFeuWqeXbQrmkqaa+YNLzSxH3Spm7Rwdb0=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2337.eurprd08.prod.outlook.com (10.172.218.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Mon, 2 Sep 2019 16:08:13 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::7d5c:f74d:f62b:2f9f]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::7d5c:f74d:f62b:2f9f%9]) with mapi id 15.20.2220.021; Mon, 2 Sep 2019
 16:08:13 +0000
From:   James Clark <James.Clark@arm.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, James Clark <James.Clark@arm.com>
Subject: [PATCH v2 0/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Topic: [PATCH v2 0/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Thread-Index: AQHVYaifTUQseQAR4ESfvvklNMuxTw==
Date:   Mon, 2 Sep 2019 16:08:13 +0000
Message-ID: <20190902160713.1425-1-james.clark@arm.com>
References: <00f00310-09ae-909c-4dfd-021996e45be1@arm.com>
In-Reply-To: <00f00310-09ae-909c-4dfd-021996e45be1@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LO2P265CA0355.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::31) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 2e854eea-b74b-45e0-cdcf-08d72fbfc66e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM4PR0802MB2337;
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2337:|AM4PR0802MB2337:|VI1PR0802MB2608:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB260866A36DEFFB1A1BFDC767E2BE0@VI1PR0802MB2608.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4941;OLM:4941;
x-forefront-prvs: 01480965DA
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(316002)(256004)(99286004)(305945005)(7736002)(50226002)(36756003)(66066001)(8936002)(2906002)(486006)(446003)(11346002)(2616005)(476003)(81156014)(81166006)(8676002)(44832011)(52116002)(66946007)(66446008)(66476007)(66556008)(64756008)(110136005)(54906003)(76176011)(71200400001)(71190400001)(102836004)(450100002)(6506007)(186003)(2501003)(26005)(386003)(6436002)(6512007)(3846002)(6116002)(25786009)(4326008)(5660300002)(6486002)(14454004)(53936002)(86362001)(1076003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2337;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: QkutR4Qi4HQTGrrzu4n5GZA8nGjJWsw7nU3sarEOuZyj2ni2F9HLBuTDIZpQm6o79gqxA2pbJLq3dyoDXikDbBUcvSDjT9gX7bw5YrEQIP03uSUjFFGTDXedqsquxdX6xnXBaUnUGSWDh8E4OtS9ZNB3+xQCi5NzGE0EIUMPSZmoyej4h0e0Tm9wdiZFoUXszFwor+OWnUUM++Ih8nB9QI5EnB38tVBQm2JyUkQ7QoUXRVmyQe6itVgdKJ7YylSwfjUj/gad7LBIebzM7pPVYAyq9wmgBt9zVv3WUvvYxYXN8DzjGzAtKYfR2RUlr1VKSXR3lC+5CHr4ixkboI+TPo4TuPP8pELMUm7ZhKxqtg7h2cjPYQrFPDc6bEqX3j+2bAAWyap7hmfUNW2JMEFZh9L1VgaTZN9AygX/0inxl7Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2337
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT056.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(6506007)(386003)(8746002)(76176011)(26826003)(14454004)(356004)(23756003)(99286004)(186003)(110136005)(36906005)(1076003)(316002)(25786009)(6512007)(50466002)(76130400001)(54906003)(81166006)(81156014)(8676002)(478600001)(4326008)(102836004)(63370400001)(63350400001)(450100002)(11346002)(446003)(336012)(26005)(70206006)(50226002)(2501003)(86362001)(66066001)(2906002)(3846002)(6116002)(47776003)(486006)(7736002)(305945005)(126002)(476003)(2616005)(36756003)(6486002)(22756006)(8936002)(5660300002)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2608;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 48325ba9-d894-4ea4-5dab-08d72fbfc1da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0802MB2608;
NoDisclaimer: True
X-Forefront-PRVS: 01480965DA
X-Microsoft-Antispam-Message-Info: Pi6DkfDipYZaQFwJqJqhya52yWWVMsjTyb8iSMT6lWojesVhoCnKh/418BdrBQ2lW5y2Ap6FLOaPVRE/T2b0pGA5d7mcQjPVxDofqM4Z43Qe8J/alPS+DMd4cWq0wW1QBdt3B9+STCxSea5lbOs5Rsu3wHmhq+22MCAlEbkjmhMot5i5WinH+NX2uTFNbrjViKV0Fp5ddw/nwNAqytkpIxK/ktX2W+rHRc/qtIPrvn2uA1OD2b2BgRt2SP3UkpsH9w16cWa86QvtaNdCj3Fcgm7uMIYwn82aQa/7/4nq7lg1wHAAVJK+brW+u2fYRhOtrupsnNqLmF31tk58Baw3cFkacMCBFWIgxDvsfcXKo9BE5qfTmWiIC+W/HUj8hyjNIV7Puz++EILo7vdJy0HjM0PB7OXuFcp0bZ96LuFBzKI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2019 16:08:20.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e854eea-b74b-45e0-cdcf-08d72fbfc66e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmitting due to the previous patch having a disclaimer appended.
I've tested that this applies cleanly with git am.

James Clark (1):
  perf tools: Add PMU event JSON files for ARM Cortex-A76 and, Neoverse
    N1.

 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  14 ++
 .../arch/arm64/arm/cortex-a76-n1/bus.json     |  24 ++
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 207 ++++++++++++++++++
 .../arm64/arm/cortex-a76-n1/exception.json    |  52 +++++
 .../arm64/arm/cortex-a76-n1/instruction.json  | 108 +++++++++
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |  23 ++
 .../arch/arm64/arm/cortex-a76-n1/other.json   |   7 +
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  14 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 9 files changed, 451 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bran=
ch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cach=
e.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exce=
ption.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/inst=
ruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memo=
ry.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/othe=
r.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipe=
line.json

--=20
2.23.0

