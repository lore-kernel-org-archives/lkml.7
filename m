Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EE6C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F73B2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PJDu4u5s";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PJDu4u5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgABLGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:06:47 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:56290
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728111AbgABLGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQX4hRVAgN3LIoBOhCjo2ks3nbiR5I3+lI7QfsC04KY=;
 b=PJDu4u5sGIE7meHwkO3JHcmHRNOb09494SflSUb6vZ4wKZ9GmdXS0/a/EY96TD80Y2qEcuXx8oHbnBagVjuRs5WkSlnRrzJuNN7IAV1ok13k8Sd9VmH9liDZ2b2ojr6JCguw8d4cB7jo6kH6B9BfwUfwgWSXtHOD0dUaYuYhZxM=
Received: from AM6PR08CA0029.eurprd08.prod.outlook.com (2603:10a6:20b:c0::17)
 by AM6PR08MB4246.eurprd08.prod.outlook.com (2603:10a6:20b:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10; Thu, 2 Jan
 2020 11:06:02 +0000
Received: from AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by AM6PR08CA0029.outlook.office365.com
 (2603:10a6:20b:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend
 Transport; Thu, 2 Jan 2020 11:06:02 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT035.mail.protection.outlook.com (10.152.16.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 2 Jan 2020 11:06:01 +0000
Received: ("Tessian outbound ca1df68f3668:v40"); Thu, 02 Jan 2020 11:06:01 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4ab2c514fe725f37
X-CR-MTA-TID: 64aa7808
Received: from a9e3b36459cd.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 79B93FED-ED01-4907-95EA-B670B516B518.1;
        Thu, 02 Jan 2020 11:05:56 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a9e3b36459cd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Jan 2020 11:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYxuh8GD6i5EGRqWWmzmxGsyswD6/Q5iu86sVMhskmoOaX0IormyubipOv+U0p8Jqug2/WZj7K2cypF90ePWfnZbTKSRtNCxuDM0t87tGkU/VJdMl4Syka1NRNTwMFU2qQ24wsP96MfTWhE5sXeMwwIuOQT/UUz4ffj9+xS1xSttVTZcKPl79ZyodR4+nSMTP/uXinYklCWCjo74rDzNfa38ck0OcQBjKLfyXKGRKRC+Wmo9oMeWs7weNvIolDSeA0CGhA1t4J9EI3I7WVL1duCXUOoYmqnXNpfC1Rhi7tJWP+8B4cOH/6edvq9hvNDUZFA9o/oHjQHjPGvytJOw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQX4hRVAgN3LIoBOhCjo2ks3nbiR5I3+lI7QfsC04KY=;
 b=VVvVQOoZ24pMI/VymuHflB6+nScZ/yV4WJV123KQ3dfDeBPsCgU6MJGojvxfHOTODN8Cd6fwyiVBk2J1fjUUgbV5i5Fx5uXqmThPc+WZcPJcDDVXsqVfFwinPfCAGvZPPeUZNNheyxiQi/5oMwxkhjKH7348yXiChDaPFQuimNpPs8ly2uC5GNVFow0fJ5oPBkvn+r30uYJYmQKfYgRoamSzN5D+nOR66nuDzyyLAOSwK1RbrQ0o/0LI7uG5ltRSt3/EbRwVkOimeDdjdVbAO5lHQ5Iibe+YHe5XcvlGhGysmfXPU1h0dLv4owHEHNLo8yNDRqQml0gQ7BHg3xc/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQX4hRVAgN3LIoBOhCjo2ks3nbiR5I3+lI7QfsC04KY=;
 b=PJDu4u5sGIE7meHwkO3JHcmHRNOb09494SflSUb6vZ4wKZ9GmdXS0/a/EY96TD80Y2qEcuXx8oHbnBagVjuRs5WkSlnRrzJuNN7IAV1ok13k8Sd9VmH9liDZ2b2ojr6JCguw8d4cB7jo6kH6B9BfwUfwgWSXtHOD0dUaYuYhZxM=
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com (10.169.225.144) by
 DB6PR0801MB1928.eurprd08.prod.outlook.com (10.168.83.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Thu, 2 Jan 2020 11:05:54 +0000
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::79d6:875c:1a3a:cb75]) by DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::79d6:875c:1a3a:cb75%7]) with mapi id 15.20.2602.012; Thu, 2 Jan 2020
 11:05:54 +0000
Received: from [10.32.36.146] (217.140.106.40) by LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.10 via Frontend Transport; Thu, 2 Jan 2020 11:05:52 +0000
From:   James Clark <James.Clark@arm.com>
To:     "leo.yan@linaro.org" <leo.yan@linaro.org>
CC:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: Re: [PATCH] perf tools: Fix bug when recording SPE and non SPE events
Thread-Topic: [PATCH] perf tools: Fix bug when recording SPE and non SPE
 events
Thread-Index: AQHVtyVvIt8qdYS9jk64bAWEtkmeEqfHGX0AgBAxaIA=
Date:   Thu, 2 Jan 2020 11:05:53 +0000
Message-ID: <591d2827-55f7-130d-ab43-2a6bd715fe5e@arm.com>
References: <20191220110525.30131-1-james.clark@arm.com>
 <20191223034852.GB3981@leoy-ThinkPad-X240s>
In-Reply-To: <20191223034852.GB3981@leoy-ThinkPad-X240s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.40]
x-clientproxiedby: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To DB6PR0801MB1638.eurprd08.prod.outlook.com
 (2603:10a6:4:38::16)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f88cef80-fb27-4103-1c4b-08d78f73c11c
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1928:|DB6PR0801MB1928:|AM6PR08MB4246:
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42469659D31C2FBAC8630D53E2200@AM6PR08MB4246.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0270ED2845
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(8676002)(478600001)(81156014)(36756003)(81166006)(4326008)(71200400001)(956004)(7416002)(2616005)(54906003)(186003)(53546011)(6486002)(31686004)(31696002)(66946007)(86362001)(16526019)(16576012)(6916009)(26005)(52116002)(5660300002)(2906002)(66556008)(64756008)(8936002)(66476007)(316002)(44832011)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1928;H:DB6PR0801MB1638.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: S6z5D/9wG+1NM9DkySi4K9RQv90+vc64zUalnH7VthSUlvxfgZBzPUXhzc4tI8t9cUKd4B4PuPl7Ofw6AwHOD9O5et967l8xpMfckLEPGEtDAX6sxmpD3Gb++kAQhiyICoAwA7guGPMayiaYNLyKPKH3Po+1ZyCBY0DCVdFv+1tr3bD+g6rEN73IX9PIZcML1k0XDkHgBxhsjHNJCWxU4mgcP70fY/a5Yn2swqW0yB//c/a0aazJVJDsUzEnrFA+EFM0KZFLUknmn/n3mSf0ARgK6dprCXpVE/GY6RJkxEM1TXtXNHlt3ntkmGvCMIW9+e67T4GZGnt6IsoQAiMQpYIqcL6X56LY42/uJ70qsy+psS+CMRAJ94PlNf3mtEaW3X+HgczXPSGlSuNThA6kkUkvM+CTTQ+mvOZEyUb8+jM0r1utMeKzCLewuQw9e0L+
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7C1764980986E4CBFE67B411C435244@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1928
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(16526019)(336012)(186003)(356004)(86362001)(6486002)(16576012)(54906003)(76130400001)(53546011)(956004)(36756003)(26005)(5660300002)(36906005)(316002)(2616005)(450100002)(107886003)(70586007)(70206006)(4326008)(31686004)(6862004)(8676002)(8936002)(26826003)(31696002)(2906002)(478600001)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4246;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 49be8887-8e56-4df9-6f13-08d78f73bbfc
NoDisclaimer: True
X-Forefront-PRVS: 0270ED2845
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKRMpt8n1rIUiHjYdGKfaD98Jy3FJ9D7euEPhEFsbgVJ2SBEvdiXKZDqcDuUhi/WNDHAdOYEb4C80Wyk49T9y1RJroQuCnrGiS1fchAvoEB7tV4B0wewqZdQtiUVD6tpaGjxXmF3GOAYI1OIWcwfxWcLvnzGY1jG61j4z/1E81uzyaWvOFutiTJX/71cvfUAAgNrFRm38V6RTFFYpcgiemdoKzywijNu2CsY8t3kFNbhna0dvoSMEzwIyZewJo9BFVDlOUj70UQH6g33y3viWWFxXpctNk4AXCyEcubW43M2MaktgQoyjFAEtNLWEXtdi0wBPiYH9/ku1/G2p9tKyM/4DX+APl6YNyGf9Vy5n6YL7DCaW1UDVH46lmrZ0bfnIcjsyyeeh7d8NImLgzU2MJBqGooicv0eOBb/aYoRuky7YfTAoTRSQWfXhoJAqYlR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2020 11:06:01.9269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88cef80-fb27-4103-1c4b-08d78f73c11c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVvLA0KDQpEbyB5b3UgbWVhbiB0aGF0IHlvdSB3b3VsZCBuZXZlciBleHBlY3QgdGhlcmUg
dG8gYmUgbW9yZSB0aGFuIG9uZSBTUEUgZmlsZSBsaWtlIC9zeXMvYnVzL2V2ZW50X3NvdXJjZS9k
ZXZpY2VzL2FybV9zcGVfMD8NCg0KSWYgdGhhdCBpcyB0aGUgY2FzZSB0aGVuIGRvIHlvdSBrbm93
IHdoeSB0aGVyZSBpcyBzdGlsbCBhIG51bWJlciBhcHBlbmRlZCB0byB0aGUgZmlsZT8NCg0KDQpU
aGFua3MNCkphbWVzDQoNCk9uIDIzLzEyLzIwMTkgMDM6NDgsIExlbyBZYW4gd3JvdGU6DQo+IEhp
IEphbWVzLA0KPiANCj4gT24gRnJpLCBEZWMgMjAsIDIwMTkgYXQgMTE6MDU6MjVBTSArMDAwMCwg
SmFtZXMgQ2xhcmsgd3JvdGU6DQo+PiBUaGlzIHBhdGNoIGZpeGVzIGFuIGlzc3VlIHdoZW4gbm9u
IEFybSBTUEUgZXZlbnRzIGFyZSBzcGVjaWZpZWQgYWZ0ZXIgYW4NCj4+IEFybSBTUEUgZXZlbnQu
IEluIHRoYXQgY2FzZSwgcGVyZiB3aWxsIGV4aXQgd2l0aCBhbiBlcnJvciBjb2RlIGFuZCBub3QN
Cj4+IHByb2R1Y2UgYSByZWNvcmQgZmlsZS4gVGhpcyBpcyBiZWNhdXNlIGEgbG9vcCBpbmRleCBp
cyB1c2VkIHRvIHN0b3JlIHRoZQ0KPj4gbG9jYXRpb24gb2YgdGhlIHJlbGV2YW50IEFybSBTUEUg
UE1VLCBidXQgaWYgbm9uIFNQRSBQTVVzIGZvbGxvdywgdGhhdA0KPj4gaW5kZXggd2lsbCBiZSBv
dmVyd3JpdHRlbi4gRml4IHRoaXMgaXNzdWUgYnkgc2F2aW5nIHRoZSBQTVUgaW50byBhDQo+PiB2
YXJpYWJsZSBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBpbmRleCwgYW5kIGFsc28gYWRkIGFuIGVycm9y
IG1lc3NhZ2UuDQo+Pg0KPj4gQmVmb3JlIHRoZSBmaXg6DQo+PiAgICAgLi9wZXJmIHJlY29yZCAt
ZSBhcm1fc3BlL3RzX2VuYWJsZT0xLyAtZSBicmFuY2gtbWlzc2VzIGxzOyBlY2hvICQ/DQo+PiAg
ICAgMjM3DQo+Pg0KPj4gQWZ0ZXIgdGhlIGZpeDoNCj4+ICAgICAuL3BlcmYgcmVjb3JkIC1lIGFy
bV9zcGUvdHNfZW5hYmxlPTEvIC1lIGJyYW5jaC1taXNzZXMgbHM7IGVjaG8gJD8NCj4+ICAgICAu
Li4NCj4+ICAgICAwDQo+IA0KPiBKdXN0IGJyaW5nIHVwIGEgcXVlc3Rpb24gcmVsYXRlZCB3aXRo
IFBNVSBldmVudCByZWdpc3RyYXRpb24uICBMZXQncw0KPiBzZWUgdGhlIERUIGJpbmRpbmcgaW4g
YXJjaC9hcm02NC9ib290L2R0cy9hcm0vZnZwLWJhc2UtcmV2Yy5kdHM6DQo+IA0KPiAgICAgICAg
ICBzcGUtcG11IHsNCj4gICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxzdGF0aXN0
aWNhbC1wcm9maWxpbmctZXh0ZW5zaW9uLXYxIjsNCj4gICAgICAgICAgICAgICAgICBpbnRlcnJ1
cHRzID0gPEdJQ19QUEkgNSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gICAgICAgICAgfTsNCj4g
DQo+IA0KPiBOb3cgU1BFIHJlZ2lzdGVycyBQTVUgZXZlbnQgZm9yIGV2ZXJ5IENQVTsgc2VlbSB0
byBtZSwgdGhvdWdoIFNQRSBpcyBhbg0KPiBJUCBiaW5kaW5nIHBlciBDUFUsIGl0IHNob3VsZCBy
ZWdpc3RlciBpbnRvIHBlcmYgZnJhbWV3b3JrIHdpdGggc2luZ2xlDQo+IHBtdSBldmVudCwgQVJN
J3MgUE1VL0VUTS9JbnRlbFBUIGFsbCB1c2UgdGhpcyB3YXkgdG8gcmVnc2l0ZXIgUE1VIGV2ZW50
Ow0KPiB0aGlzIGNhbiBhbGxvdyBwZXJmIHRvb2wgbG9naWMgdG8gYmUgbW9yZSBuZWF0Lg0KPiAN
Cj4gQWZ0ZXIgdGhlIGRyaXZlciBjaGFuZ2VzIHRvIHVzZSBzaW5nbGUgUE1VIHJlZ2lzdHJhdGlv
biwgdGhlIHBlcmYgdG9vbA0KPiBjb2RlIGNhbiBiZSBjaGFuZ2VkIHRvIHVzZSBzaW1wbGUgd2F5
IHRvIGZpbmQgcGVyZl9wbXUgYW5kIHRoaXMgZGF0YQ0KPiBzdHJ1Y3R1cmUgY2FuIGJlIG5vdCBi
b3VuZCB0byBhIHNwZWNpZmljIENQVS4gIEZpbmFsbHksIHRoaXMgYnVnIGNhbg0KPiBiZSBzbW9v
dGhseSBkaXNtaXNzZWQuDQo+IA0KPiBUaGFua3MsDQo+IExlbw0KPiANCj4+IFNpZ25lZC1vZmYt
Ynk6IEphbWVzIENsYXJrIDxqYW1lcy5jbGFya0Bhcm0uY29tPg0KPj4gQ2M6IE1hdGhpZXUgUG9p
cmllciA8bWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc+DQo+PiBDYzogU3V6dWtpIEsgUG91bG9z
ZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+DQo+PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+
PiBDYzogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+DQo+PiBDYzog
TWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4+IENjOiBBbGV4YW5kZXIgU2hp
c2hraW4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+DQo+PiBDYzogSmlyaSBP
bHNhIDxqb2xzYUByZWRoYXQuY29tPg0KPj4gQ2M6IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2Vy
bmVsLm9yZz4NCj4+IENjOiBJZ29yIEx1YmFzaGV2IDxpbHViYXNoZUBha2FtYWkuY29tPg0KPj4g
LS0tDQo+PiAgdG9vbHMvcGVyZi9hcmNoL2FybS91dGlsL2F1eHRyYWNlLmMgIHwgMTAgKysrKyst
LS0tLQ0KPj4gIHRvb2xzL3BlcmYvYXJjaC9hcm02NC91dGlsL2FybS1zcGUuYyB8ICAxICsNCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL2FybS91dGlsL2F1eHRyYWNlLmMgYi90b29s
cy9wZXJmL2FyY2gvYXJtL3V0aWwvYXV4dHJhY2UuYw0KPj4gaW5kZXggMGE2ZTc1Yjg3NzdhLi4y
MzBmMDNiNjIyZTEgMTAwNjQ0DQo+PiAtLS0gYS90b29scy9wZXJmL2FyY2gvYXJtL3V0aWwvYXV4
dHJhY2UuYw0KPj4gKysrIGIvdG9vbHMvcGVyZi9hcmNoL2FybS91dGlsL2F1eHRyYWNlLmMNCj4+
IEBAIC01NCw5ICs1NCw5IEBAIHN0cnVjdCBhdXh0cmFjZV9yZWNvcmQNCj4+ICAqYXV4dHJhY2Vf
cmVjb3JkX19pbml0KHN0cnVjdCBldmxpc3QgKmV2bGlzdCwgaW50ICplcnIpDQo+PiAgew0KPj4g
IAlzdHJ1Y3QgcGVyZl9wbXUJKmNzX2V0bV9wbXU7DQo+PiArCXN0cnVjdCBwZXJmX3BtdSAqYXJt
X3NwZV9wbXUgPSBOVUxMOw0KPj4gIAlzdHJ1Y3QgZXZzZWwgKmV2c2VsOw0KPj4gIAlib29sIGZv
dW5kX2V0bSA9IGZhbHNlOw0KPj4gLQlib29sIGZvdW5kX3NwZSA9IGZhbHNlOw0KPj4gIAlzdGF0
aWMgc3RydWN0IHBlcmZfcG11ICoqYXJtX3NwZV9wbXVzID0gTlVMTDsNCj4+ICAJc3RhdGljIGlu
dCBucl9zcGVzID0gMDsNCj4+ICAJaW50IGkgPSAwOw0KPj4gQEAgLTc5LDEzICs3OSwxMyBAQCBz
dHJ1Y3QgYXV4dHJhY2VfcmVjb3JkDQo+PiAgDQo+PiAgCQlmb3IgKGkgPSAwOyBpIDwgbnJfc3Bl
czsgaSsrKSB7DQo+PiAgCQkJaWYgKGV2c2VsLT5jb3JlLmF0dHIudHlwZSA9PSBhcm1fc3BlX3Bt
dXNbaV0tPnR5cGUpIHsNCj4+IC0JCQkJZm91bmRfc3BlID0gdHJ1ZTsNCj4+ICsJCQkJYXJtX3Nw
ZV9wbXUgPSBhcm1fc3BlX3BtdXNbaV07DQo+PiAgCQkJCWJyZWFrOw0KPj4gIAkJCX0NCj4+ICAJ
CX0NCj4+ICAJfQ0KPj4gIA0KPj4gLQlpZiAoZm91bmRfZXRtICYmIGZvdW5kX3NwZSkgew0KPj4g
KwlpZiAoZm91bmRfZXRtICYmIGFybV9zcGVfcG11KSB7DQo+PiAgCQlwcl9lcnIoIkNvbmN1cnJl
bnQgQVJNIENvcmVzaWdodCBFVE0gYW5kIFNQRSBvcGVyYXRpb24gbm90IGN1cnJlbnRseSBzdXBw
b3J0ZWRcbiIpOw0KPj4gIAkJKmVyciA9IC1FT1BOT1RTVVBQOw0KPj4gIAkJcmV0dXJuIE5VTEw7
DQo+PiBAQCAtOTUsOCArOTUsOCBAQCBzdHJ1Y3QgYXV4dHJhY2VfcmVjb3JkDQo+PiAgCQlyZXR1
cm4gY3NfZXRtX3JlY29yZF9pbml0KGVycik7DQo+PiAgDQo+PiAgI2lmIGRlZmluZWQoX19hYXJj
aDY0X18pDQo+PiAtCWlmIChmb3VuZF9zcGUpDQo+PiAtCQlyZXR1cm4gYXJtX3NwZV9yZWNvcmRp
bmdfaW5pdChlcnIsIGFybV9zcGVfcG11c1tpXSk7DQo+PiArCWlmIChhcm1fc3BlX3BtdSkNCj4+
ICsJCXJldHVybiBhcm1fc3BlX3JlY29yZGluZ19pbml0KGVyciwgYXJtX3NwZV9wbXUpOw0KPj4g
ICNlbmRpZg0KPj4gIA0KPj4gIAkvKg0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvYXJjaC9h
cm02NC91dGlsL2FybS1zcGUuYyBiL3Rvb2xzL3BlcmYvYXJjaC9hcm02NC91dGlsL2FybS1zcGUu
Yw0KPj4gaW5kZXggZWJhNjU0MWVjMGYxLi5iN2QxN2Q4NzI0ZGYgMTAwNjQ0DQo+PiAtLS0gYS90
b29scy9wZXJmL2FyY2gvYXJtNjQvdXRpbC9hcm0tc3BlLmMNCj4+ICsrKyBiL3Rvb2xzL3BlcmYv
YXJjaC9hcm02NC91dGlsL2FybS1zcGUuYw0KPj4gQEAgLTE3OCw2ICsxNzgsNyBAQCBzdHJ1Y3Qg
YXV4dHJhY2VfcmVjb3JkICphcm1fc3BlX3JlY29yZGluZ19pbml0KGludCAqZXJyLA0KPj4gIAlz
dHJ1Y3QgYXJtX3NwZV9yZWNvcmRpbmcgKnNwZXI7DQo+PiAgDQo+PiAgCWlmICghYXJtX3NwZV9w
bXUpIHsNCj4+ICsJCXByX2VycigiQXR0ZW1wdGVkIHRvIGluaXRpYWxpc2UgbnVsbCBTUEUgUE1V
XG4iKTsNCj4+ICAJCSplcnIgPSAtRU5PREVWOw0KPj4gIAkJcmV0dXJuIE5VTEw7DQo+PiAgCX0N
Cj4+IC0tIA0KPj4gMi4yNC4wDQo+Pg0K
