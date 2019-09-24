Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAECC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8325C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WiHfFHey";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WiHfFHey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409324AbfIXIBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:01:01 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:61846
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405186AbfIXIBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDeY3yrLXKxZ6ZJjHvIhB+5kXK6vvx+mi9GVwSuEm20=;
 b=WiHfFHey67RKfm0gApqkx7cpui6HBIamOOBo5PhxRF6+ie9DF60ojE8DuB6V4hz5TkjT6aw8ydg9yqxhayQgSfuVqkvb2triH2Ia2L2Zd8SPOOSlUMw4cr+FGmMB4gIoyBpDTvhBamA39Nui/IWGDeAGF9+m6Ejl9RFTxlus+tk=
Received: from VI1PR08CA0162.eurprd08.prod.outlook.com (2603:10a6:800:d1::16)
 by AM0PR08MB5266.eurprd08.prod.outlook.com (2603:10a6:208:162::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.26; Tue, 24 Sep
 2019 08:00:53 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by VI1PR08CA0162.outlook.office365.com
 (2603:10a6:800:d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Tue, 24 Sep 2019 08:00:53 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20 via Frontend Transport; Tue, 24 Sep 2019 08:00:51 +0000
Received: ("Tessian outbound 96594883d423:v31"); Tue, 24 Sep 2019 08:00:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bf83f19d794a2f1c
X-CR-MTA-TID: 64aa7808
Received: from 7f18e8879431.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.14.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BC20BACA-8626-461D-A5A0-C6D906BDF088.1;
        Tue, 24 Sep 2019 08:00:40 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7f18e8879431.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 24 Sep 2019 08:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvUGJxETwrbm6K0q3ycpR3wu2j4n0IHtO9kQti/sd6CaXqVO2/fds2NaNIMdcTH2w4bUp+tqM/d0+cDWYJjGGa079+8PIebPNQ0urr/epT8n33KWXA5sXrsGVvw+CuMMYD3wRGBqzlSGhwatKaXSuxV12Bn9BWFGlQPJTD33ef+zZXhN5hBFmCMAKveiEAZYLIVVuTMNfgUY5mQjkRmc7L79rz0SBLPeyU5gDz5rcBbymYosq+gyulpDIBilk3c63UkCSaMY/VIs0GXzWGJEgh6aUEOaqn8hi0A0VkTOKoYV7rzgVglFYYcGjp6PkNiR3R4lOl2UY/RofQufUL1VFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDeY3yrLXKxZ6ZJjHvIhB+5kXK6vvx+mi9GVwSuEm20=;
 b=hAw3aVUNqH4rnYupjjBs4vfTWvdfl0eod6er46+Ysmw/AMZccPjF+2sPrQjYyms/ij9o3+asUnMyglgWrTsmWc6jnNfAX/V0Y/WA3mkoI6UyYXRoZIFoCU15UB83Hqnyy4hPHe8+YguwyGapSacIakEnczKJR7IkIzR3pp8FA+nmcFfAgafEeO3I7I6eymoOcHhsni/J0rLy135ry3Zvl7uGPlvnLaIZkicX/kg959W1gw2AqSAByWWArVrN6HxnWielZr1ovigy95LX5iUDlYlO95E6v1rxr2FA10pi/07Yc162x2QU1/JYapFGQJ26n7RcGSLd4ozQCaWpcxoMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDeY3yrLXKxZ6ZJjHvIhB+5kXK6vvx+mi9GVwSuEm20=;
 b=WiHfFHey67RKfm0gApqkx7cpui6HBIamOOBo5PhxRF6+ie9DF60ojE8DuB6V4hz5TkjT6aw8ydg9yqxhayQgSfuVqkvb2triH2Ia2L2Zd8SPOOSlUMw4cr+FGmMB4gIoyBpDTvhBamA39Nui/IWGDeAGF9+m6Ejl9RFTxlus+tk=
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com (52.133.246.150) by
 VI1PR08MB3165.eurprd08.prod.outlook.com (52.133.15.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Tue, 24 Sep 2019 08:00:39 +0000
Received: from VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b]) by VI1PR08MB5488.eurprd08.prod.outlook.com
 ([fe80::d09e:254b:4d3b:456b%3]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:00:39 +0000
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
Subject: [PATCH v2 0/2] drm/komeda: Add layer line size support
Thread-Topic: [PATCH v2 0/2] drm/komeda: Add layer line size support
Thread-Index: AQHVcq4n2NTPDT8buUeD7qC/mk6snA==
Date:   Tue, 24 Sep 2019 08:00:39 +0000
Message-ID: <20190924080022.19250-1-lowry.li@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::34) To VI1PR08MB5488.eurprd08.prod.outlook.com
 (2603:10a6:803:137::22)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8de527e6-bc33-4439-f23b-08d740c55171
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR08MB3165;
X-MS-TrafficTypeDiagnostic: VI1PR08MB3165:|VI1PR08MB3165:|AM0PR08MB5266:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB526640039B1A68DCE9445D759F840@AM0PR08MB5266.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
x-forefront-prvs: 0170DAF08C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(186003)(54906003)(81166006)(81156014)(71190400001)(8676002)(4326008)(99286004)(14454004)(110136005)(66066001)(66946007)(66556008)(25786009)(66446008)(26005)(486006)(66476007)(478600001)(316002)(64756008)(8936002)(7736002)(52116002)(36756003)(50226002)(476003)(2616005)(5660300002)(6116002)(2201001)(6512007)(86362001)(6436002)(102836004)(3846002)(256004)(6636002)(55236004)(1076003)(2501003)(305945005)(386003)(2906002)(4744005)(6486002)(71200400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3165;H:VI1PR08MB5488.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: VsQloRHI3HAgmCciJZt+8SGTz6hT9Y8ID4mFhEYNVya59qNbQBdpTPQ+nHe2G2LoIaubc41feZEVjxfjDQb93A13TwL4q0UyNMCeHjivS/lgawx33TZHF1Uqc1vYOAD6mubPR2xtlJulj1CdMfEfj6EQdmP7y7nCKDkefcop01XN4pwqRv9IRJ9zg1j7CfqqDceUHXn4KA10M/0hs0iHOYOFZO8OynmYU6UQ0RXK6ygp0Ix8mlqo2Yr8UIkFp2BP0xQZLrxFQRoFNFzo89krbAAixfL0mcMkEwO6I4eiVUV+jY3IGjGjpGzZAl63hBWf8NGRi00wy8ZQzdGJLv85Z51SCsi59Bsb9OJkxS3V3IKKi0TB6gvNgnWhf7huKUyhQQGA16Y+YHnk9m88AO6notN3OSlqpYoIgBci3oolWYk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3165
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lowry.Li@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(199004)(189003)(4744005)(63350400001)(6486002)(2201001)(1076003)(305945005)(7736002)(54906003)(3846002)(6636002)(8676002)(81156014)(26826003)(4326008)(23756003)(50226002)(356004)(25786009)(81166006)(6512007)(70206006)(70586007)(8746002)(36756003)(8936002)(110136005)(476003)(386003)(486006)(186003)(6506007)(2906002)(22756006)(102836004)(47776003)(2616005)(478600001)(50466002)(316002)(66066001)(99286004)(5660300002)(336012)(14454004)(36906005)(6116002)(76130400001)(86362001)(2501003)(26005)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5266;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a3603b8b-040d-4bb1-72c1-08d740c549c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(710020)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR08MB5266;
NoDisclaimer: True
X-Forefront-PRVS: 0170DAF08C
X-Microsoft-Antispam-Message-Info: McRbMF3mDmASgrDli2qtSIXHpPfVXyt2qR1nQhSjRG6b3sACHZ9b5TodroGwjGUDjS4zkP0bBlTOhEc4M3nnM7NQsijPdSbhty07Jbj8pBafqQ6G3a4KLFvShPfOYryVYGkVnHnyUWSgbXk4Acgk70gQbM7JHD6SsCNDmbxNHM+2GmiF53Z8ORQvIj8bqAbBnWoZyF69GDm3yg734waW4IQtxzQNRB+QPtsNQ4bVmHG72HCYUBakIesCz08lxA0BvmYpk2h2NRYU2Q+C04dip34znyKjIZwKrDtilbWCSlZ74WnjS/JvEwUYnGV2+9vsPO/ZcVpRGK3uNhTyTMjr/J7HQCdQjYVRY/cHtn8dWBcpOW6uKit9jiAjdUc6n4Ld6mTIkhn682YnM+zovmD07JbHcW3s09SkboJZW+/NYD8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2019 08:00:51.3770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de527e6-bc33-4439-f23b-08d740c55171
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From D32 every component have a line size register to indicate internal
fifo size, instead of using the global line_sz.

This serie aims at adding the layer line size support and check
accordingly on both D71 and D32 or newer.

Changes since v1:
Rebases to drm-misc-next branch.

Lowry Li (Arm Technology China) (2):
  drm/komeda: Add line size support
  drm/komeda: Adds layer horizontal input size limitation check for D71

 .../arm/display/komeda/d71/d71_component.c    | 106 ++++++++++++++++--
 .../gpu/drm/arm/display/komeda/d71/d71_regs.h |   9 +-
 .../drm/arm/display/komeda/komeda_pipeline.h  |   2 +
 .../display/komeda/komeda_pipeline_state.c    |  17 +++
 4 files changed, 119 insertions(+), 15 deletions(-)

--=20
2.17.1

