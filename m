Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9727C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD3F214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TubYzZkL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="TubYzZkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfKGLmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:42:43 -0500
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:11854
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfKGLmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Qy+5QuuahR73Se226LG9hQrqrQVwjZKRRxbwvRDIM=;
 b=TubYzZkLu2R/4itVn+9bXG5WvF7vFAWUFNr9v50A7rZz0WSCDHWEUHA4gbl4iL9GJyPkm+WWRpSnDF4PGvp4eMUkhQRa3EyAGt1DH/O2T4DCFnJ7L7epn+MXqheCQJww4rPGhOQqpItWgaGZu2tikw2RZw2xbeKdHwpe514cUJQ=
Received: from VI1PR08CA0138.eurprd08.prod.outlook.com (2603:10a6:800:d5::16)
 by HE1PR0802MB2266.eurprd08.prod.outlook.com (2603:10a6:3:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 11:42:35 +0000
Received: from AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by VI1PR08CA0138.outlook.office365.com
 (2603:10a6:800:d5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 11:42:35 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT047.mail.protection.outlook.com (10.152.16.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.21 via Frontend Transport; Thu, 7 Nov 2019 11:42:35 +0000
Received: ("Tessian outbound 851a1162fca7:v33"); Thu, 07 Nov 2019 11:42:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bed9424188f2679d
X-CR-MTA-TID: 64aa7808
Received: from 382107c0733b.2 (cr-mta-lb-1.cr-mta-net [104.47.10.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 479E54D0-3CD5-4ADF-AF21-0104589DAD5D.1;
        Thu, 07 Nov 2019 11:42:26 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 382107c0733b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 07 Nov 2019 11:42:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/5mOrUCMN5lznBCrr0JUb1EFuSdGntYfUEW7jZOautE4PlHbiT/qo6xjavurg2IAfjr+J4oCPZWq+dkMuFvXepCS3TfIHonvVtXuTa10/u+BrzO3ixuhJJXdXkhdQYEupcx9SIzanAe8gXIR5p5ia7WVFFTr/+PbeRAysVU3ovKnglNazWbbB4/5Z2ZT7ZafYpJEfHgzcTovU/J/Lo+x/9JC8ZNM6z28hPh+Tww4gWifPdp9aTE5r72T+B04AAuNq5oiGobcymkWX9KlNhIX+Tuv8eQGrXmR0a4aWLPcwKMk7QfPj4r5M07uQ0X8diWo7Bbh+vqxv14XFKpyop15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Qy+5QuuahR73Se226LG9hQrqrQVwjZKRRxbwvRDIM=;
 b=DaKbSSfcVD6+NpyS8a0vWCGeQO6k4/ToQKpZtAK7xsCHv9eMvAFu0JjMSwJ5Jm5WhtG4Eu1mwLhcY087BlrXwRvtuwp9J2nJ6p6My2CF3aEfrVgrmVMZntTBU7mdNuxnfK4/jvyB2N9S2Yk0Elseq6ZUYtv5XLXshQr86Z98y7vvWoKAIQc6AhqyGSqcM1iCy9imbTi/PzaP4pXUjk4/rCY1u34izUgh4Emuq1o6o9jWzsG75t+fOZZ8eoZgu4MP5Y0TrQ5uPhj3+ILq2Ug0VponP/tFGIPG+Qhj3MdgevXc/yfn9hrBSzcA2VCgzDNOyFvmGHHQ3dE8Z++CYnhPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Qy+5QuuahR73Se226LG9hQrqrQVwjZKRRxbwvRDIM=;
 b=TubYzZkLu2R/4itVn+9bXG5WvF7vFAWUFNr9v50A7rZz0WSCDHWEUHA4gbl4iL9GJyPkm+WWRpSnDF4PGvp4eMUkhQRa3EyAGt1DH/O2T4DCFnJ7L7epn+MXqheCQJww4rPGhOQqpItWgaGZu2tikw2RZw2xbeKdHwpe514cUJQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4351.eurprd08.prod.outlook.com (20.179.27.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 11:42:25 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 11:42:25 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] drm/komeda: Improve IRQ error event prints
Thread-Topic: [PATCH v2 0/5] drm/komeda: Improve IRQ error event prints
Thread-Index: AQHVlWBsrADBZKixe0GvhOzL83K+tQ==
Date:   Thu, 7 Nov 2019 11:42:25 +0000
Message-ID: <20191107114155.54307-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d972004-fcc8-4e70-3118-08d763779524
X-MS-TrafficTypeDiagnostic: VI1PR08MB4351:|VI1PR08MB4351:|HE1PR0802MB2266:
X-MS-Exchange-PUrlCount: 1
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB22668FD49945B94A5B9336818F780@HE1PR0802MB2266.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
x-forefront-prvs: 0214EB3F68
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(53754006)(316002)(54906003)(476003)(50226002)(71200400001)(6512007)(305945005)(6916009)(2906002)(8936002)(2616005)(44832011)(4326008)(6436002)(66066001)(256004)(486006)(86362001)(26005)(71190400001)(36756003)(52116002)(2351001)(14444005)(6506007)(99286004)(6486002)(102836004)(2501003)(386003)(186003)(6116002)(14454004)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(478600001)(6306002)(1076003)(3846002)(8676002)(81166006)(81156014)(7736002)(5640700003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4351;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DYVX0PYoPwfggPDms5K3+w8K7LRIsPpvXOoyKUCqUGD6fVf9oK8gu7/MjZ1x0aq2KQPKLDpJ+bExTFQ5X4S4kKzEvENh8Ow1/iSblQ/StR7siQzrZAhRRgGGRBtvg2XAG9Bc1GFOxkWTzkLFl4zhTTkEY8XkTVn2kQcHPPwv3khMtUSybrxx6olRlhplRkqOI2pCmasD7oftF82fCNmzmCY3CpoqG+0QTRokk2VJjnfTrRMu4GdkU8mHbQgkkmPRte30+veehjLbrnS5rNwk3nFKIM4nRayqIkj6XzDjPombWCX+N5ysvHQGnwFBQp9j1CkhTXPd+h1Cs6qOv9h9m1BqmGEQ+qP0PsTQnuQE+j27yvzBA5vrviR378tkJk5k1oPaCZURpwX/ej6q8JMQshV9UPg9ss1MUqD78eCKA1kDViqCQjt+LUtpN7TEFCwUap6OyeXYaMZCa8Fi1Qkrdh898wuagvcSJ4jPer7xzD8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4351
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT047.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(1110001)(339900001)(199004)(189003)(53754006)(36906005)(50466002)(8746002)(8936002)(25786009)(8676002)(81156014)(86362001)(6512007)(50226002)(6306002)(1076003)(81166006)(70206006)(3846002)(70586007)(6116002)(336012)(6506007)(23756003)(26005)(102836004)(105606002)(99286004)(186003)(386003)(5640700003)(2351001)(47776003)(316002)(54906003)(486006)(7736002)(2616005)(126002)(476003)(2906002)(22756006)(4326008)(6486002)(2501003)(356004)(5660300002)(6862004)(14454004)(36756003)(478600001)(14444005)(305945005)(76130400001)(26826003)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2266;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e538ae12-ba5c-4d88-5a5f-08d763778f27
NoDisclaimer: True
X-Forefront-PRVS: 0214EB3F68
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wpelH6Ed2zTt/GQgexOs1ZYOwC6kF7TKAex/mAR/V6UsfF0QrjuO4Mpfsaz7K656LSlctZNCGTjk6rwDhehm23NjA/eDHTQzb3Fsh/w5tSw1nYRFBtxp5Bc6K7OQ1zNGEVqQt87UtstJ3hPZX9TYGHqesvOjXIhLuRqB7ghLbx1wfAKfOHv65p3As8Y42rv0x2URTl1MNZZIlRtxA+4XfopHB0U7jvDKNv661TGPRECaRETHDpUm2r8yM0dp5/gY8sJpmHVJuCizYMxLLfCLtk3Iso1cAwUBYQPM4iHDPooMudmKllrbS+ns6SHBCoz5XliyExLdlT5iKn2V0Yz/LFnX95KsMqXzMz1N6BV8bvBjKGwLtiInQ1s3I+KK9QVCFNYzH8wMGTIBQCjssMYuAJLmGmcvdbncVU4KP2/6TtXD5eQzAeSNpUD8GAGnqXVkL8AFRW4LTi/9G2ZPaRB2uC4zzEYN3t5tgVaY7Zw+K8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 11:42:35.0089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d972004-fcc8-4e70-3118-08d763779524
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Sending out a v2 of the series since I had missed out a couple of issues
checkpatch caught.

Changes since v1 [https://patchwork.freedesktop.org/series/68325/]:
 - Fixed a couple of checkpatch issues in 2/5 and 5/5

v1's cover letter:

This is a smallish series that tries to remove some build-time
configurability in komeda and replace it with a debugfs control. Later
patches in the series add some extra functionality which I found useful
during my debugging sessions, so I figured I'd bake it in.

I've preserved the default behaviour as if CONFIG_KOMEDA_ERROR_PRINT
were enabled, so production kernels can have some feedback from the
driver when things are going south.

1: Introduce the err_verbosity debugfs node for komeda; this keeps the
   default of printing error events once per frame.
2: Drop CONFIG_KOMEDA_ERROR_PRINT since output can be disabled at
   runtime
3: Add a drm state dump on event. It's quite chatty so I left it only
   for error events; printing all that once per frame every vsync floods my
   serial terminal, so no info + state combination.
4: Add lower-severity categories to the event printer
5: Normally these events fire only once per pageflip, but sometimes it's
   useful to see them all as they come in.

These patches are overall quite tiny, and I was considering just
squashing them into one, but I opted to keep them separate for an easier
review experience; please let me know whether you prefer a single patch.
Thanks!

Mihail Atanassov (5):
  drm/komeda: Add debugfs node to control error verbosity
  drm/komeda: Remove CONFIG_KOMEDA_ERROR_PRINT
  drm/komeda: Optionally dump DRM state on interrupts
  drm/komeda: Add option to print WARN- and INFO-level IRQ events
  drm/komeda: add rate limiting disable to err_verbosity

 drivers/gpu/drm/arm/display/Kconfig           |  6 ----
 drivers/gpu/drm/arm/display/komeda/Makefile   |  5 ++--
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 30 +++++++++++++++----
 .../gpu/drm/arm/display/komeda/komeda_event.c | 23 +++++++++++---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   |  2 +-
 6 files changed, 51 insertions(+), 19 deletions(-)

--=20
2.23.0

