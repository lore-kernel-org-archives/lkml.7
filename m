Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B6CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8372064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 07:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zyDY8cun";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zyDY8cun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJUH0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 03:26:10 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:47813
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbfJUH0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 03:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lTSa4rYX3Lu+7lcq+ZpvV7iUcBTi5ViWo+mOBrwSCc=;
 b=zyDY8cunxghdhJqbHmbP6ZbgmQMyY9Q/WidHVoKouaCo7YNhvhztN9B0F0qionpePxkaY4vl7NsYbtImKMW31QFO1NqG2uNq+P/Q2ch+oG3FA1SvuHu3RKQE105MTwxJ9T5qlz7Z54s8Eyy63YjUgRnVSXq1jWMaBVH1Ka3283Y=
Received: from DB7PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:5:16::29) by
 AM6PR08MB4787.eurprd08.prod.outlook.com (2603:10a6:20b:c9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.21; Mon, 21 Oct 2019 07:23:10 +0000
Received: from VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by DB7PR08CA0016.outlook.office365.com
 (2603:10a6:5:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.23 via Frontend
 Transport; Mon, 21 Oct 2019 07:23:10 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT061.mail.protection.outlook.com (10.152.19.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Mon, 21 Oct 2019 07:23:08 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Mon, 21 Oct 2019 07:23:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fc5c19b7bc3fd90b
X-CR-MTA-TID: 64aa7808
Received: from 0116dc2b193f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.13.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 61EFADBE-4C64-4786-A89F-2329A4302BB0.1;
        Mon, 21 Oct 2019 07:22:58 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0116dc2b193f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 07:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB5kLZgTCNDRQ0VLnGuHucWDnbl2D9ECTQ7NuCFEZZA6SKiGqLXz0wYsKA/Y082K/+oHxXaBDgp0TsahSIR3kqACq5VQs6HkhhVLs35vWwkQficaW0uKicFnJ3lwPMmFZyR9pdy0V++XK5WL/yLCRDZyYfGZlBnGCofIO13nrhqYpBdHUGU4DuWpCC0orlEl6tnzq1Gic5z1QBZYwy9RiWw4Ywk+yi+OjWFjMZYBcClzb+ZFNd7PMNeKcQj1oj0kksYDLg0GfjJe5NrjKEpYoVZdkJGsFgCNOqCXN+AlcEfNJOeZb3R/e0Juqc1Crfgs+gfdrVR05tmEf+FeN5Fj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lTSa4rYX3Lu+7lcq+ZpvV7iUcBTi5ViWo+mOBrwSCc=;
 b=FqYQmYlOV+rZXj8saB3MkeYofj8upB/nhgD60QSks/03E1UNj3rwmuajTUMVhYAbmibm/bHu5GRORwrBZ29LTq3DoPexSPMfI8n5tcfXGwIG4MCARG+4wKQEPjIDf1IRchVGVxhI4uJwdfvsaTWkgCTn/txny0sccOrWl9o8ysE0SotCLqpkLWTuM8R+gNeyDNr8YMh3OM4YweMTWWvZUh7fzLLqpr/P6alKu/4hXBsud8dr4GE3NL+uDXtqLf/Axp7xDIIYgDvA24tmjVUMexbVoibnEn+lAbHpr9i1RdyB7FigIee+SusMQJXimbGjaUUM0PW9MsOxM2vraPKxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lTSa4rYX3Lu+7lcq+ZpvV7iUcBTi5ViWo+mOBrwSCc=;
 b=zyDY8cunxghdhJqbHmbP6ZbgmQMyY9Q/WidHVoKouaCo7YNhvhztN9B0F0qionpePxkaY4vl7NsYbtImKMW31QFO1NqG2uNq+P/Q2ch+oG3FA1SvuHu3RKQE105MTwxJ9T5qlz7Z54s8Eyy63YjUgRnVSXq1jWMaBVH1Ka3283Y=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4831.eurprd08.prod.outlook.com (10.255.115.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 07:22:55 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::40ed:7ed3:90cf:ece5%3]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 07:22:55 +0000
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
Subject: [PATCH v6 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Topic: [PATCH v6 0/4] drm/komeda: Enable CRTC color-mgmt
Thread-Index: AQHVh+BbShqgZztuuU6+TkzZNLRVVQ==
Date:   Mon, 21 Oct 2019 07:22:55 +0000
Message-ID: <20191021072215.3993-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b05fe6ce-ab48-4351-1b66-08d755f785f3
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VE1PR08MB4831:|VE1PR08MB4831:|AM6PR08MB4787:
X-MS-Exchange-PUrlCount: 3
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47876A40914C26B830217F24B3690@AM6PR08MB4787.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39850400004)(396003)(136003)(376002)(199004)(189003)(110136005)(6506007)(6486002)(386003)(66066001)(4326008)(966005)(8676002)(66946007)(54906003)(99286004)(103116003)(36756003)(6512007)(6436002)(66446008)(64756008)(66556008)(66476007)(6306002)(55236004)(2171002)(102836004)(2501003)(26005)(14454004)(186003)(81156014)(81166006)(2201001)(478600001)(316002)(2906002)(7736002)(86362001)(71190400001)(71200400001)(256004)(6116002)(25786009)(305945005)(14444005)(486006)(3846002)(52116002)(5660300002)(8936002)(2616005)(476003)(1076003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4831;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VtTJ/aonrK8J62/p3ISZjZaKsy4xwxA3eX3miBViE3RM16ZX0rj+IZ6L96r6K93eEbkBzDTkJJbIrTo1HGPF3xcAyQk/f7Pqy/VintKKNuLgDZ0Pt4ME8ANsxc5gdJCWZkgZpylHrD+YhhA3l4/zTDUFANKUQ4PQu/aPhsslDGizPZ3amxn9FOVyE6ZpENLX6SUipt8Ze3jT/7yC/jFPQwU09W8vCML70ncsx34fJ+aAnFmKFFCQA9sO67GP184XhG/d454PsbVhWmWO9eLQwCyPUGE+dskgmyXJRlZP4xJD8csSrB5bwYcpJhecxr10I7naFDoQVvei0KE6zfE66W/es1vSpcTRTNi08deh/8N9Yj/y2zbVT0wysZvwG5AF2kpCVUtPM0fpnmhuOuffSHpD/MeObaUfj5tj42l26L7WbCUw6BkZdu2ES00RwIOY
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4831
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(6116002)(14454004)(6512007)(3846002)(966005)(478600001)(36906005)(316002)(70586007)(70206006)(6306002)(5660300002)(63350400001)(103116003)(4326008)(2171002)(50226002)(8746002)(2906002)(26826003)(22756006)(14444005)(1076003)(8936002)(6486002)(25786009)(50466002)(66066001)(102836004)(81156014)(386003)(6506007)(99286004)(23756003)(26005)(36756003)(47776003)(186003)(7736002)(356004)(81166006)(8676002)(110136005)(54906003)(2201001)(336012)(126002)(305945005)(2501003)(76130400001)(476003)(86362001)(2616005)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4787;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 01010e68-0779-46cd-fe08-08d755f77d98
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /c25ImbPoi+zz2SHpi7RtGZFDzosVAj2ov9kyY9awmQ9m2vGa7xMsWJPdvaUDAuVxuayixciC48t300J5zQlDVjiV8gC6ZP6bZXGzfs20SpIoAExW6kcsRCmrbOAWaHFcsAtlbklj1WUdF3L8yyu/Fi0XT2RVYgNvDkYqsHP/dNC++QJ5zgdnGTmOnm/pS9ZBP2FDQqM9pJvajy1zBdc9qhVe7oBYUx4Z9fY5GNG10Z0WBjsiRmAeGSOkq0s7c8nQh3JFNWhzmuDTeqaqFeE9WMhQuYC5ZfVkiGfCVaNCdQnyWWwhOXkQkxLNgr/NJfVssIR7cmMOpf8LmLKlLtcrGDfrpCkWlftoZUXuxjZD6Lg4X9BPJAf9TbnveazY2+n50QX7gU+DByi/JnyKiMmcE9ZYnznXxghNwp1V8ww4HiwbvD6BKD0o0+TKae36gyjFTgfPLXL18GdeRXKgqUuehwq7OrzWFxtvyIJi/pEtuA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 07:23:08.7758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05fe6ce-ab48-4351-1b66-08d755f785f3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

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

v6:
  Allows m =3D=3D 0 according to Mihail's comments.

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
 drivers/gpu/drm/drm_color_mgmt.c              | 36 ++++++++++
 include/drm/drm_color_mgmt.h                  |  2 +
 8 files changed, 144 insertions(+), 1 deletion(-)

--
2.20.1
