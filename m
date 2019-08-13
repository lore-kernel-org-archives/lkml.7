Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F6FC32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9395220840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XZfxW7It";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="XZfxW7It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfHME4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:56:33 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:28487
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726997AbfHME43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq3aalZnurXi5SJDyY6FLUSB8PWic1GXGYoqGxQPtVQ=;
 b=XZfxW7Ito1RfXmnB+/2cdPzi8Qgfj8Ts7NwMGbSXP8jz/e2kfRdn4NewComCgTQA+cijb2WRkHjGH4ZoRcFwNJmCaMHZkk4k57I/BxL5w7V0ncWlte5rUQlXNGrCHHCEbrwYs5jQcbZ+pBUoLa3/2K2n65xnVWmiyQxZQ57Kk1M=
Received: from VI1PR0801CA0084.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::28) by VE1PR08MB4957.eurprd08.prod.outlook.com
 (2603:10a6:803:110::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.18; Tue, 13 Aug
 2019 04:56:22 +0000
Received: from DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::204) by VI1PR0801CA0084.outlook.office365.com
 (2603:10a6:800:7d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.16 via Frontend
 Transport; Tue, 13 Aug 2019 04:56:22 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT013.mail.protection.outlook.com (10.152.20.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Tue, 13 Aug 2019 04:56:14 +0000
Received: ("Tessian outbound 220137ab7b0b:v26"); Tue, 13 Aug 2019 04:56:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3a53dbed5f9ca5ff
X-CR-MTA-TID: 64aa7808
Received: from 032befcf3b01.2 (cr-mta-lb-1.cr-mta-net [104.47.2.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 23EAD7A8-D7CB-48CE-B2E2-F8833D4456C3.1;
        Tue, 13 Aug 2019 04:55:58 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 032befcf3b01.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384);
    Tue, 13 Aug 2019 04:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR7grlPu2KTqaA3qjgt/pZgds1RmFR1O1GZybKZuETt4WmOqpkBHYBHyot3cNl56uSE7FtIRHk/+EK1WgyfEnrWUcQ66U0ip8Udb72fhoh0H9f8r+CWUP8iZJvTTBIGNxv1nmCHeYeoRMOfHAMYW5YrqWu73SlhALsP0ppD8CLT7jLAtS/yc/TRUshOWDv83vxzSDVZi2myJq/D/4qk/1FlcYaXjP8zXfEQdIQewI+frGn0aOVFd9TIuXfJ2/+wg+dUuGqTgKACbWdxUlHBX4+83Ua25ZApVzO+bttxYEgqbnEopM6VmRBylVINWPMs1RxyGUNYwcEw/YETvcGDEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq3aalZnurXi5SJDyY6FLUSB8PWic1GXGYoqGxQPtVQ=;
 b=Oo+LFETCj2ONnMznRMWw4L8AZcmXTZbOvMMsnGCquobTaY26iNS9AwLfB3XgLBNSS66i6LzXzoh99IlYCXfHkcwgtPJTVl5W0S48FCUGfl6+KMK34JGrdSMhMK4uANI07RpANcxK18fuqODSlo2xo41g+OobUvyNxMZ2NYKBNxE+FxxCX9+X6brnsIkTcX7TEWfLLC0JlUjLHIDC4nWcZbpMmJMBTh/fzN7AN4fchCdklP62sni1QDXbfEpj+seqK8fZYQMcjLH4L23It6bxOfIJ+rVQhSMDUHnd2+YZs7AlWlUtMOzHTFjkzc245aaLJ/TzpEeyBHP0ABN7BMpcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq3aalZnurXi5SJDyY6FLUSB8PWic1GXGYoqGxQPtVQ=;
 b=XZfxW7Ito1RfXmnB+/2cdPzi8Qgfj8Ts7NwMGbSXP8jz/e2kfRdn4NewComCgTQA+cijb2WRkHjGH4ZoRcFwNJmCaMHZkk4k57I/BxL5w7V0ncWlte5rUQlXNGrCHHCEbrwYs5jQcbZ+pBUoLa3/2K2n65xnVWmiyQxZQ57Kk1M=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4752.eurprd08.prod.outlook.com (10.255.112.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Tue, 13 Aug 2019 04:55:56 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::2151:f0b1:3ea7:c134%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 04:55:56 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 0/4] drm/komeda: Enable layer/plane color mgmt
Thread-Topic: [PATCH v2 0/4] drm/komeda: Enable layer/plane color mgmt
Thread-Index: AQHVUZNk2pA6XccCe02wqaw3fxQuDQ==
Date:   Tue, 13 Aug 2019 04:55:55 +0000
Message-ID: <20190813045536.28239-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: df2965e8-a742-45b2-5043-08d71faa91c8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4752;
X-MS-TrafficTypeDiagnostic: VE1PR08MB4752:|VE1PR08MB4957:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB495745D2C420BC5EC9458D15B3D20@VE1PR08MB4957.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:4125;OLM:4125;
x-forefront-prvs: 01283822F8
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(50226002)(5660300002)(2201001)(110136005)(26005)(316002)(66066001)(6116002)(3846002)(305945005)(2906002)(7736002)(103116003)(71190400001)(71200400001)(8676002)(1076003)(54906003)(55236004)(66946007)(478600001)(81156014)(14454004)(386003)(6506007)(4326008)(36756003)(52116002)(2616005)(102836004)(25786009)(256004)(81166006)(186003)(6486002)(64756008)(66556008)(66476007)(99286004)(2501003)(6512007)(6436002)(86362001)(66446008)(8936002)(486006)(476003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4752;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: lSy4l6VBTwUM7ZIwdYdd+1shqrEq1OyurCrthzb/e64ds4jaCsOjdENOzarZAZcMRHaybAidgcdadNqG0xkOBU3om1P+c6oIdWFzmvoEd5PPfba8sE81q4+lcMq7YglkXHcLI97mvYO1V4AHOKm2w4TJbVoaVzev3qHKk1/p8KAv/HT8WaiqnmlzZRw03fyOtdJEb4+31G5QpA7zzJxeQQXcVd41EGXFRMcKUVlGqyxkYklZRcQQQfK3SK6pfBfEKR8euZVZFcPURSnRnC6zkfCXmw9ZiazK2jRiYBrW/fPwhEoJn52ZyvZa+fWX6zicTBZAMuhXKc+B10mzMpn2UBR+2aL6uGPJ0pP43CyY4WUCspRfwcQOM1pIsKAI7+Vrn8b/Oy56PdSRHjE0iH9E5rLfoEpyZnFRgWPTZNrOQeg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4752
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(47776003)(110136005)(99286004)(486006)(76130400001)(1076003)(36756003)(2501003)(25786009)(5660300002)(63350400001)(63370400001)(336012)(2616005)(70206006)(476003)(70586007)(54906003)(126002)(81166006)(8676002)(81156014)(103116003)(8746002)(66066001)(6512007)(6486002)(8936002)(4326008)(356004)(316002)(6116002)(305945005)(26005)(186003)(50226002)(3846002)(50466002)(14454004)(7736002)(6506007)(86362001)(26826003)(102836004)(478600001)(23756003)(22756006)(2201001)(386003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4957;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: add636b4-a6b0-4566-ec32-08d71faa864c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VE1PR08MB4957;
NoDisclaimer: True
X-Forefront-PRVS: 01283822F8
X-Microsoft-Antispam-Message-Info: 5EJWMYprPlVzFa6YZPszb9+WD/+EfoSPxKmquCPiPuosAac/d01VzuSmY3U3Y1pkPeKYtAHkLlbo8T32S7cQ5Ikj2yhIfAP+pnUvJCiIEqxt8BYUsmij7ADixK7vW3XF7il7F1930N4CGD4TVxxAKwfT9IDhZe+O4q7cjtRt3xInAEflm8ZAhhdEVlLA/LbxRo8vA9BF1tMLAxqfI+V0hKQ3A9EOGx+Ez2EKFy+63ynAvUBiONmb7qxEn34bZZP/sgLrHi2x3V5XzfdU9I4JTIZNbJrjwo7sz75Eq5zIgyIdm6q+sUKyyM1u8uKXzEIMmZcRZSCh14vdWj6Uz5cS0+3pdMOp2+6lAG3KKib05rKURIG75pcQi548r94Fsb054IoW2f58MWM/v/Pi90kbnuUyvO8uIeTPzGlHTy5HC2c=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 04:56:14.6399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df2965e8-a742-45b2-5043-08d71faa91c8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enabled layer/plane color management for komeda driver

v2: Rebase it on drm-misc-next

james qian wang (Arm Technology China) (4):
  drm/komeda: Introduce komeda_coeffs_table/manager
  drm/komeda: Introduce komeda_color_manager/state
  drm: Increase DRM_OBJECT_MAX_PROPERTY to 32
  drm/komeda: Enable Layer color management for komeda

 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../arm/display/komeda/d71/d71_component.c    |  64 +++++++++
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  |   5 +-
 .../gpu/drm/arm/display/komeda/d71/d71_dev.h  |   2 +
 .../drm/arm/display/komeda/komeda_coeffs.c    | 119 +++++++++++++++++
 .../drm/arm/display/komeda/komeda_coeffs.h    |  74 ++++++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 126 ++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    |  32 ++++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |   4 +-
 .../display/komeda/komeda_pipeline_state.c    |  53 +++++++-
 .../gpu/drm/arm/display/komeda/komeda_plane.c |  12 ++
 .../arm/display/komeda/komeda_private_obj.c   |   4 +
 include/drm/drm_mode_object.h                 |   2 +-
 13 files changed, 490 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_coeffs.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_coeffs.h

--
2.20.1
