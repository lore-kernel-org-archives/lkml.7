Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE8FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ADA21848
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IMqnCyzH";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IMqnCyzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392442AbfJPKed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:34:33 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:32282
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfJPKec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvsOmkRSMnj04Xocdc9OWJufW8g0vLPexZfqLFFKCwQ=;
 b=IMqnCyzH9IoGOtSeJ3uV2xJk3fmsR8qKo/Zc/Cw4MM+eS1Zs/397c0Mlri7nDdiiYH2oQpXiqzrdUeY2abJ8Bvk1XXR/n9+r28lcsiz8Zj7q81LUgTsomXzHoNPGl7HNLgFTyUFi1wJvOd+iwK+oHROeud+lq0zYN5Gx6czJDKM=
Received: from VI1PR08CA0247.eurprd08.prod.outlook.com (2603:10a6:803:dc::20)
 by HE1PR0801MB2090.eurprd08.prod.outlook.com (2603:10a6:3:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Wed, 16 Oct
 2019 10:34:12 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::204) by VI1PR08CA0247.outlook.office365.com
 (2603:10a6:803:dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 10:34:12 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Wed, 16 Oct 2019 10:34:11 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Wed, 16 Oct 2019 10:34:08 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 067d89d41c5ecfaf
X-CR-MTA-TID: 64aa7808
Received: from 86eb13a6e5c8.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.4.57])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A87B71A0-EBA1-45C9-B8C9-06C94C3A2FB4.1;
        Wed, 16 Oct 2019 10:34:03 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 86eb13a6e5c8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Oct 2019 10:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8iISnhWFe2qJI6HwJibyaVRP4WtgJrMWECkxVU0tcpUky7kOTMGg//FVLDw8lubzFoSOGHCipr54ZTan69NvuzES+j5sRvDjzrhN8UXqJBo4o4fqoSS+AW2evEULMMbWneq79g8Fg4L4svcyxVw7xMq17PWoLPSxVgBBSYuQlT/tGQrB+dXZrYpnGxYmji0iscIWve9YliJYj5TjWJ4gfJeR5ywsj2oFuPlMde0UuBDKhDypjDUS9QwJTMzLDqnDEZhP8CoIbqbSi6bb4UCA4oMFgFagG3tPIt1JcJnQsSr/TgbuVOh9D+7JulZ++MhwY2W5IXbQQwZvO3LGYJ5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvsOmkRSMnj04Xocdc9OWJufW8g0vLPexZfqLFFKCwQ=;
 b=JFP1P47ppOVh8mYwqM/SpLsXvr57vgHYeq/R0E4tTCf1CfjhOUjcfdfpK2PMmUgFTWWuB/8iESBiwk+TD1bRlhkaNzYy8Gk2ztmAp9qfomfn8OZakeBBNzX2SybObjy32YkAkI5aMZZlIN2AzjADchPW3iDT7UJ6vgZm+xyDK0N/5Yxd18vRlumz5/atEQTDxm1ECEA7vbUkgR0vaniZxhjoUsBAjSQwr4PVtALb2jK6PGBdnLUFJOEob5FCJv5tgafdOBZVby4Ds7x2+BOxEGN+yPxXVRMKj4zqzSseebJxgbxgB4yDqYQMa8w9jYpDLlptRaltJjZFqupFROodrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvsOmkRSMnj04Xocdc9OWJufW8g0vLPexZfqLFFKCwQ=;
 b=IMqnCyzH9IoGOtSeJ3uV2xJk3fmsR8qKo/Zc/Cw4MM+eS1Zs/397c0Mlri7nDdiiYH2oQpXiqzrdUeY2abJ8Bvk1XXR/n9+r28lcsiz8Zj7q81LUgTsomXzHoNPGl7HNLgFTyUFi1wJvOd+iwK+oHROeud+lq0zYN5Gx6czJDKM=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5182.eurprd08.prod.outlook.com (20.179.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 16 Oct 2019 10:34:01 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:34:00 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "imirkin@alum.mit.edu" <imirkin@alum.mit.edu>
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
Subject: [PATCH v5 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v5 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVhA05K3a87ww2REG7o6++3/JrAw==
Date:   Wed, 16 Oct 2019 10:34:00 +0000
Message-ID: <20191016103339.25858-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a17a80ae-3c6a-4072-9ebc-08d752246278
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB5182:|VE1PR08MB5182:|HE1PR0801MB2090:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20908B3DDE011150E33E3B32B3920@HE1PR0801MB2090.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0192E812EC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(199004)(189003)(1076003)(64756008)(66446008)(66946007)(66556008)(66476007)(2171002)(6486002)(66066001)(71190400001)(8676002)(2201001)(14454004)(6436002)(71200400001)(5660300002)(81166006)(81156014)(36756003)(2501003)(52116002)(966005)(386003)(6506007)(86362001)(25786009)(256004)(476003)(2616005)(305945005)(3846002)(8936002)(186003)(103116003)(14444005)(6512007)(6306002)(478600001)(6116002)(55236004)(2906002)(486006)(54906003)(50226002)(4326008)(7736002)(110136005)(26005)(316002)(102836004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5182;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 7BYgXXZyQp5E1wGKJEj1/up+hh/TsA2jHt/bLL/bDBJNfR1ir0/nNEm2RZsKV4yqfqm0DVQICevpIfQiay2AsTEC/lKW/ndhG7hVqvGDwuD6+mbQGedYzEzkCIqCS8mq6pQkyN4jQBs67fcfDF2R41uRLeXAchjospAPFHXfTDqtLgeiTwhI9dPCUCQMqc4VlbupyV4EyQ7VnfJaKITn6bsVJkU4cN7v0rEmswmcZOxD0iz5/pSDeMFY482UrNo4sLkg8VFBND6CugHr5AiaKD9jAfD+iKw/a1gs1EjnPkfMhUifLS+UlkO2IwUG+3+P0dwPjLd33UbgMnbnO6O5AYXOWxqWSRp3P2/1UcBthpdc2LV8kf9FJvGtARpWfMwRJ2A7mjkJ3tW+rAwXEg4O7IkHb7oP38BwQF6q2knHribnKQG5g7CPiauKDp93cqrn7gmgXUmwGSqghPUDps0riA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5182
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(189003)(199004)(99286004)(25786009)(50226002)(81166006)(47776003)(186003)(81156014)(6512007)(8936002)(8676002)(103116003)(6486002)(76130400001)(1076003)(6306002)(8746002)(386003)(4326008)(70586007)(70206006)(26005)(6506007)(2171002)(356004)(486006)(66066001)(476003)(2616005)(126002)(5660300002)(63350400001)(336012)(102836004)(305945005)(966005)(3846002)(6116002)(7736002)(14454004)(26826003)(2201001)(36756003)(86362001)(478600001)(2501003)(50466002)(54906003)(23756003)(2906002)(22756006)(110136005)(316002)(36906005)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB2090;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e3c7f39e-3024-4f0b-006a-08d752245b74
NoDisclaimer: True
X-Forefront-PRVS: 0192E812EC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrz6BE4zOFtmNbtTwBpR78fVNEeR9MVZ7G3IWkbGvGUit6RSX1sJQhXi4VLOWvEJ2RwGWq7Z0zlROCCAyg1qMSb2JvEwqameT9mGtvTeLkVNoy3myAfHRFXhSszXr2zxvak68W4eNnxTy4wWfmSRmgyO2UYNIdu2CSo+DCYIUClSIUOSgbgpTuoZSDHO+MSKqRXT2FqZJEymH6C1LVkZEb+UqMYc1dx2i6sWeHLioZjEjyUQNSkCIhNATqMZYP2QRuCAE0jR4K0ZGDMSEz1oSN9RP6hhN23V5AC5nnhBloGutNNH1GwqlwsLBgpcAEAkn82hFd8XKBvXD7T/aAPIeJTi4ycynjGQwKXPf532DnOvsokimZ0oF/i2lUjPftdRf5LKbeU7JlQoyDUmuyuXJFXwx5m6Q0z1+o0hlay2xazabbZSNZCJ5/mqH+8Yhoe09mNPOz4EsQCkYpfmqhG+gQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 10:34:11.9185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a17a80ae-3c6a-4072-9ebc-08d752246278
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enable CRTC color-mgmt for komeda driver, for current komeda HW
which only supports color conversion and forward gamma for CRTC.

This series actually are regrouped from:
- drm/komeda: Enable layer/plane color-mgmt:
  https://patchwork.freedesktop.org/series/60893/

- drm/komeda: Enable CRTC color-mgmt
  https://patchwork.freedesktop.org/series/61370/

For removing the dependence on:
- https://patchwork.freedesktop.org/series/30876/

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm/komeda: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

v2:
  Move the fixpoint conversion function s31_32_to_q2_12() to drm core
  as a shared helper.

v4:
  Address review comments from Mihai, Daniel and Ilia.

V5:
- Includes the sign bit in the value of m (Qm.n).
- Rebase with drm-misc-next

Lowry Li (Arm Technology China) (1):
  drm/komeda: Adds gamma and color-transform support for DOU-IPS

james qian wang (Arm Technology China) (3):
  drm: Add a new helper drm_color_ctm_s31_32_to_qm_n()
  drm/komeda: Add drm_lut_to_fgamma_coeffs()
  drm/komeda: Add drm_ctm_to_coeffs()

 .../arm/display/komeda/d71/d71_component.c    | 20 ++++++
 .../arm/display/komeda/komeda_color_mgmt.c    | 66 +++++++++++++++++++
 .../arm/display/komeda/komeda_color_mgmt.h    | 10 ++-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    |  6 ++
 drivers/gpu/drm/drm_color_mgmt.c              | 27 ++++++++
 include/drm/drm_color_mgmt.h                  |  2 +
 8 files changed, 135 insertions(+), 1 deletion(-)

--
2.20.1
