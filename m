Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF91BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760BE24249
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vo7cDWEg";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vo7cDWEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLEIfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:35:54 -0500
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:15646
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfLEIfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQkcOiJ1zh/q5YY5FqAhKqjxh02a7M7mSd82rVg0QMw=;
 b=vo7cDWEggnJ+h0Ahm787C1Fb2lKqliPgrTqa5YTBFgDBBQfRKaBREUqqfkYSWsaYeLRcPQzQ/AqFrk55pefaFnoQZoak5wOsqClrpuFkASffAju+G+Kg55k3WzurNWQOkoE006mnNHoxJ799lR3zwUxg2HTwKWpkjssUtYHMrLI=
Received: from AM4PR08CA0049.eurprd08.prod.outlook.com (2603:10a6:205:2::20)
 by DB7PR08MB2987.eurprd08.prod.outlook.com (2603:10a6:5:1c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.22; Thu, 5 Dec
 2019 08:35:46 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by AM4PR08CA0049.outlook.office365.com
 (2603:10a6:205:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.12 via Frontend
 Transport; Thu, 5 Dec 2019 08:35:46 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Thu, 5 Dec 2019 08:35:45 +0000
Received: ("Tessian outbound 5574dd7ffaa4:v37"); Thu, 05 Dec 2019 08:35:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ea84697a14331f00
X-CR-MTA-TID: 64aa7808
Received: from ae5c1a33a848.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 06CA67F3-662C-4EE0-977A-0F5187108D0D.1;
        Thu, 05 Dec 2019 08:35:40 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ae5c1a33a848.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Dec 2019 08:35:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAZYEjOFA692MRBN82kEyT24M0AKvgxAqEPWPGkOmyJ6vPyI66e+cfP4dKIKDbx1d2Yell2NxsiAiwE6Ajl3vmmlZUL7y6t4kyGKlgSFXLvTKkPXEdHhAi5oWApTmMEuYAqC7B5WaxujMRluPoI4sG94ozmD6apiKRRHzpDQgeiHh1OGzHYJnOw5UdFPrj/GXibMojQ9+/Uz0DjfngiRxyMgH+qMyd+3smFLwbdmnFcBRnIU++HKDqKx6Uo1j2RwptYKqKQ/0O3d+N0YtGSDHmWj9pRDOk3fBxxgHTIZt7N+L/gtUzaDhyS0gegwc/qoPaj97Us1Mw0vLp7wRciOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQkcOiJ1zh/q5YY5FqAhKqjxh02a7M7mSd82rVg0QMw=;
 b=iW4KWaCF3WAQxlsdKyZH42kqTAQli2yXH8CJDsLawA4RwUy/Q03Yic+GOfKz9lvohpUN9gtDWe4MxM+Nf5hX97cbLV2EA6Z/K7/jKg38DKNoWXb3FVxdFRjPZo9Qr7Qg80YkewcTqeqLS2CCDAl/IZyq7NggyefhG5TPF4Hgd+Qr0f8E5BQC6d+zWKDyysj5Ojl3Pmw+0CK7dTqRxPC/f+KjungH8k1bzGIkwioohY8IqJJmMBlvu6ciilQK0Mc98g3TbTdZIMnRpq7N5Apfbfz6SUDgOfQlRz0LcteTglldRIpFa1J1bma2R0+M60CFGRC4huuPU+rWl4b85URKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQkcOiJ1zh/q5YY5FqAhKqjxh02a7M7mSd82rVg0QMw=;
 b=vo7cDWEggnJ+h0Ahm787C1Fb2lKqliPgrTqa5YTBFgDBBQfRKaBREUqqfkYSWsaYeLRcPQzQ/AqFrk55pefaFnoQZoak5wOsqClrpuFkASffAju+G+Kg55k3WzurNWQOkoE006mnNHoxJ799lR3zwUxg2HTwKWpkjssUtYHMrLI=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 AM0SPR01MB0047.eurprd08.prod.outlook.com (20.179.32.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 08:35:38 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::f984:b0c7:bce9:144e%2]) with mapi id 15.20.2495.014; Thu, 5 Dec 2019
 08:35:38 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v5 0/5] arm/komeda: Add side_by_side support
Thread-Topic: [PATCH v5 0/5] arm/komeda: Add side_by_side support
Thread-Index: AQHVq0b4+ZN5ApmJ1kuuVJmeDKJyTw==
Date:   Thu, 5 Dec 2019 08:35:37 +0000
Message-ID: <20191205083436.11060-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7684bfc9-6060-401c-3c7f-08d7795e1f8c
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0047:|AM0SPR01MB0047:|DB7PR08MB2987:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB2987F045FAEF4B753DAF7A18B35C0@DB7PR08MB2987.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
x-forefront-prvs: 02426D11FE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(199004)(189003)(8676002)(5660300002)(71190400001)(71200400001)(7736002)(305945005)(2906002)(86362001)(316002)(36756003)(103116003)(81156014)(50226002)(1076003)(81166006)(8936002)(6862004)(6636002)(4326008)(99286004)(478600001)(2616005)(186003)(102836004)(25786009)(52116002)(14454004)(55236004)(26005)(6512007)(54906003)(66946007)(66476007)(6116002)(66556008)(64756008)(6506007)(66446008)(3846002)(6486002)(37006003)(6436002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0SPR01MB0047;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0wz8ifd2vnifS6eq5RDhbkXsuxJWUY3ph1tak+QTCqCiv1aw953JcurHm2h7bhlPNtkvKsPwj4X6ueCi6kspcWcaam9RCN/39nfZldEk++OZs5oT1Rp4nMvHxDkifb3t/sgSqKSoqmbDIkztYYtMuxdiwU01EmUS1kno1XqCh1SOz0NbGvfRpKZfBwWA7ZV4YirFhOeJOQQruprPrnbM4duQIyZc5v01AnsMeHrCrrRRSbC7JUkHN0orDz/AJCCualdzzXoUiwwHJ1x2X5BGA7xEAfQf35NlX94RaaCR5s+oAS9twlD/6procc6qhE+x9hju6KhONctgdeNvdESaTwUscKPn4YVM17gN8+EMDzLL0Wk74WUhPoryFCJCGPbZCVEC6NUCH7/fbesaBi76CHpic/5TGin3ycLY5+S+mZgS+gYVI25HQ2wDcZ4SFSmP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0047
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(7736002)(8676002)(50466002)(6486002)(316002)(70586007)(70206006)(103116003)(305945005)(3846002)(81156014)(6636002)(50226002)(76130400001)(37006003)(14454004)(23756003)(6116002)(5660300002)(14444005)(2906002)(22756006)(86362001)(81166006)(8746002)(1076003)(6512007)(356004)(26005)(336012)(25786009)(2616005)(6506007)(102836004)(54906003)(36756003)(36906005)(99286004)(26826003)(8936002)(6862004)(478600001)(4326008)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2987;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1c5b52d7-e494-4384-a566-08d7795e1aaa
NoDisclaimer: True
X-Forefront-PRVS: 02426D11FE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85UoZ6Sc8Svcbvu7xuKigTeqwyO1UstES191NL2XHkpT4Sq8zyidmVGKA5aGMZDA2RKsU/sDYcnSm0HUcke7Fs/Tk1YPBfPZFV6WCIFz3Y9kS3ywoIgPEN8bCi3tmXr/42mQYokXvvipHZ3lyEg1HxNwlL3fA8+m6sM2eTdO6WnufNjhDHDildoQXfaB2s0EefexfBpmWS/q4LT87qHNHYE3Q6kNXwBt4TykMp6wqIrrSNywsRYKDMYL5ZIMIUaKW+qrSj/oJWHiYfGi7XGZOMBC4uv0v/dXJrsfzWXiyISF7jmnOl786Ojr4yvvNNTB4ILqdFj8KAWBLqmKO+13u1qRDxR8+XUnaCht9NgFNxNQIN8LhHflLv7z72Y9HlcIlHnVXty1EEc5DnJXSiyZ982BKWtWgtDPzgp8gmPt8y4fy/DkCgQCrwCPHXJ2mKF0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2019 08:35:45.8304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7684bfc9-6060-401c-3c7f-08d7795e1f8c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2987
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi: All

Komeda HW (two pipelines) can work on side by side mode, which splits the
internal display processing to two halves (LEFT/RIGHT) and handle them by
two pipelines separately and simultaneously.
And since one single pipeline only handles the half display frame, so the
main engine clock requirement can also be halved.

The data flow of side_by_side as blow:

 slave.layer0 ->\                  /-> slave.wb_layer -> mem.fb.right_part
     ...         -> slave.compiz ->
 slave.layer3 ->/                  \-> slave.improcessor->
                                                          \   /-> output-li=
nk0
 master.layer0 ->\                   /-> master.improcessor ->\-> output-li=
nk1
     ...          -> master.compiz ->
 master.layer3 ->/                   \-> master.wb_layer -> mem.fb.left_par=
t

v3: Rebase
v5: Drop the patch: Expose side_by_side by sysfs/config_id

james qian wang (Arm Technology China) (5):
  drm/komeda: Add side by side assembling
  drm/komeda: Add side by side plane_state split
  drm/komeda: Build side by side display output pipeline
  drm/komeda: Add side by side support for writeback
  drm/komeda: Update writeback signal for side_by_side

 .../arm/display/komeda/d71/d71_component.c    |   4 +
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  54 ++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |   4 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |   9 +
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   8 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  50 +++-
 .../drm/arm/display/komeda/komeda_pipeline.h  |  39 ++-
 .../display/komeda/komeda_pipeline_state.c    | 277 +++++++++++++++++-
 .../gpu/drm/arm/display/komeda/komeda_plane.c |   7 +-
 .../arm/display/komeda/komeda_wb_connector.c  |  11 +-
 10 files changed, 419 insertions(+), 44 deletions(-)

--=20
2.20.1

