Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B56BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B192341C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 09:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jMHVtTXh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jMHVtTXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH3JJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 05:09:09 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:1391
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726492AbfH3JJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 05:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2YfttFwbe46fxWfeXwZ4kI2bD84XZ4DigU/++mKPNI=;
 b=jMHVtTXhZPt3ekTifruid5AQ2UTZDkE+ZP/4FXIf1J3mO1RqlhwvMVVibH+qu9Rjoc1fsITyMOz8ryEHs2zZvcOBtqDZl1Eed8MsK6G7jknQfjHHfTyFJRDF515vqIbdflzUcfn1Zl6X1upcmareIM7F0TNmcuLc+3hE38cUwz8=
Received: from VI1PR0802CA0001.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::11) by AM5PR0801MB1841.eurprd08.prod.outlook.com
 (2603:10a6:203:2e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Fri, 30 Aug
 2019 09:09:03 +0000
Received: from AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR0802CA0001.outlook.office365.com
 (2603:10a6:800:aa::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.19 via Frontend
 Transport; Fri, 30 Aug 2019 09:09:02 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT015.mail.protection.outlook.com (10.152.16.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Fri, 30 Aug 2019 09:09:00 +0000
Received: ("Tessian outbound f83cc93ed55d:v27"); Fri, 30 Aug 2019 09:09:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: c226450c5ae5965a
X-CR-MTA-TID: 64aa7808
Received: from e94b51b8b2cd.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.5.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F99EBCDA-CFC7-44F6-A43C-9B5C12236A6A.1;
        Fri, 30 Aug 2019 09:08:54 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e94b51b8b2cd.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Aug 2019 09:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixRs0yuHpliMB1IhDhzWmVAdMg+aWd7TbNJX1sLF9TTRWoK6WR7MRYKhFEULOxqb7vkUe57Bw9aTqOyj/DQVK7owjL6FxquZ8+XzRL5DrRGC/KKxyQk2lFekJb1caqs1rteU8KdRLAwTUpBMDMuFUTB2A87k581aeh49CQT/syglKIgYuDVBxX2Y+xT6hySoL9psFrdI5oqu44K4l6acDBVkNqCZ03YCbltJmaXapW8atArGzSyILlG9lEadUl/yiWE+dfJrcdztOqdeXDo/cZj9AsiALPelIRkWsQm5VzDQBH/HXf94ZLe2AofZCwie8r54JZMg35IZs/5U9vCt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2YfttFwbe46fxWfeXwZ4kI2bD84XZ4DigU/++mKPNI=;
 b=b8WMW/9twhk2j4vQzup1Mma93n0DQ0/SZ9Sf8tiHiKZhyIVPl9UD5MfINdzrxMMUxUZt5JNj/+7YIpEPzrlXYvWGrfHUaEAiC5MB4yRVmISCrvA1qHY330K8wv1PU6T5VVBEwFzBr2SJrz0VxByk1yiRL/EGKuxpJ9jlJomxBeRm8sQDpkvm+k/kA/k7GH5f82+nwcwrJ8W8Lt2RqZ4fCbvcO7g8lI7CTAGeC9ik4QzB5wBP2IxPe7RTcEM9lMOnbzz0f+RqJn3syqZNper+9DmLx5cT6e0TQs1VybPKn6zGQv3myuWg7qcSNMXYwJvrH1yF+R6BJejfA/XCsVuQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2YfttFwbe46fxWfeXwZ4kI2bD84XZ4DigU/++mKPNI=;
 b=jMHVtTXhZPt3ekTifruid5AQ2UTZDkE+ZP/4FXIf1J3mO1RqlhwvMVVibH+qu9Rjoc1fsITyMOz8ryEHs2zZvcOBtqDZl1Eed8MsK6G7jknQfjHHfTyFJRDF515vqIbdflzUcfn1Zl6X1upcmareIM7F0TNmcuLc+3hE38cUwz8=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3968.eurprd08.prod.outlook.com (20.178.125.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Fri, 30 Aug 2019 09:08:52 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 09:08:52 +0000
From:   "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: [PATCH v1 0/2] drm/komeda: Add layer line size support
Thread-Topic: [PATCH v1 0/2] drm/komeda: Add layer line size support
Thread-Index: AQHVXxKKAEDUFXeRJ0igqjka6hFsHw==
Date:   Fri, 30 Aug 2019 09:08:51 +0000
Message-ID: <20190830090835.8747-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::14) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8f0d10a9-e59d-4bfa-ca08-08d72d29b268
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3968;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3968:|VI1PR08MB3968:|AM5PR0801MB1841:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB18413EA7BCBB7926F33842D09FBD0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0145758B1D
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(4326008)(66446008)(2616005)(25786009)(476003)(8676002)(2906002)(6436002)(2201001)(66556008)(81156014)(81166006)(64756008)(99286004)(14454004)(66476007)(5660300002)(486006)(26005)(4744005)(50226002)(86362001)(7736002)(71200400001)(6636002)(66066001)(1076003)(66946007)(71190400001)(305945005)(186003)(53936002)(3846002)(6512007)(110136005)(6486002)(8936002)(2501003)(102836004)(316002)(54906003)(55236004)(478600001)(386003)(6506007)(52116002)(256004)(6116002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3968;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: kwPkVc7hiz36a8GBcz5lxCZk4p4zPuptjojihuEhsL4NTx0xJlzUZsMlesU1N70yfg3IfoPdcbxRYL0oQu1zNRHEUI6qfu6YNcBH4Cxs+xPbdCrYiLm9aQQILjaBRJ9AsQ8Lo/uVWZSDg87cat02q7MXC8A4uMSWkcCXaiMSVK7gnKgvnkK23u+/7acKCX/YO/IwdpQ+oOmJv+/VEgOD9MYwARVEgCfgfjUPP0NmV7elIqbkhupsoxUqPv5wfAFh7fHjs5UJ5FGKzD7sJKhx6ZTPgLxQJKGIO2SsQ3Sz5jH6gWAF41FzMS4/M2nNPwOXHrgtibOMRELAFM31MXlhIIvw3A3G+wgZWJKEZdilmY2O4lH93n1HiO911TvSu3UXPFB2Sosq9qUj324kl2LE2y571k+zT73aXryiKXKgkBw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3968
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT015.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(199004)(189003)(70586007)(4326008)(2906002)(86362001)(2501003)(66066001)(336012)(47776003)(356004)(70206006)(6512007)(25786009)(76130400001)(63370400001)(5660300002)(186003)(102836004)(63350400001)(6636002)(4744005)(2616005)(6486002)(476003)(126002)(1076003)(2201001)(6506007)(386003)(26005)(486006)(316002)(110136005)(305945005)(36906005)(99286004)(7736002)(23756003)(8746002)(81166006)(478600001)(50226002)(3846002)(81156014)(36756003)(6116002)(50466002)(26826003)(8676002)(14454004)(8936002)(22756006)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1841;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6f28eadf-8ce2-4630-560e-08d72d29ad00
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(710020)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM5PR0801MB1841;
NoDisclaimer: True
X-Forefront-PRVS: 0145758B1D
X-Microsoft-Antispam-Message-Info: otDKzlW4SNDxvvnJEOLLHJPAiYhs5qpNmsN164rAUqNCyq64L5+rxj4K7nC620VBg/ykDcLCri8I0UMkSE8wIBg+muCR2nWzjgbTINc45fZ3OT2nAVv7bzscU6Fg0y+CWg0dEV7zcd4FhYna+mIUue5tU9zjrUAVZBrIGEdxrhI5SBVn9E5XJaq7lqbwFsUSMXnQ7ec77L9u2cE/N/cgr48ezyoxAwWyBZKKTfdsNNfDSCPh5x1pcTXNz58c5dqAK4lBLvUqf3N6dMAdxFARaLdn6XHCHZQlYI+Z/5hLlvLn9WYs/7+xuVHvCdZvfyzOa9wi61GiujoOR+tIINCcqof3SaqpHBsdTURXpdhxC0EyFmEITT3Iua7z0DneEn3kKENSchRBqWU74/0WtIn6/2UESy+x7Y2wXOM/Lw5WMd4=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2019 09:09:00.4353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0d10a9-e59d-4bfa-ca08-08d72d29b268
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From D32 every component have a line size register to indicate internal
fifo size, instead of using the global line_sz.

This serie aims at adding the layer line size support and check
accordingly on both D71 and D32 or newer.

Lowry Li (Arm Technology China) (2):
  drm/komeda: Add line size support
  drm/komeda: Adds layer horizontal input size limitation check for D71

 .../arm/display/komeda/d71/d71_component.c    | 105 ++++++++++++++++--
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h |   8 +-
 .../drm/arm/display/komeda/komeda_pipeline.h  |   2 +
 .../display/komeda/komeda_pipeline_state.c    |  17 +++
 4 files changed, 117 insertions(+), 15 deletions(-)

--=20
2.17.1

