Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C9C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18475217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KA4FDxA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfHEJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:52:22 -0400
Received: from mail-eopbgr30047.outbound.protection.outlook.com ([40.107.3.47]:38885
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727158AbfHEJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsflULuYnYRUCfoJpOjqv4XiC81+vaRJms4XPiXjmDBuEgB7/0YuxKIV6a2bmkc/oyZ3+pfWnk3u/ResAeGW3vkxjNlIeCHYqgb51p93OvRKSpzZ2MJBWKT6PBfcL0pYty80Wyq+AqN6HwM90GXh1ioFYDbuWe3sQcHfNWVhRt2F7DgLT4fM9CaVuo8zV5Iot+tPlaNyUAxYLd+esnow9Z9dgp/paMH2anB2zBX/MbSqN6iAibn8sKkLWUviNuH6z9hQmS/qEGq8TQMaArKvyR0a9jhMR0QpQhVK6VLiXeIt7gskBy2mbcwVeKdNAnRKjtjEUmT2ogKPzzmHoPbJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4KCZjkk2Qua9X1hPieafjRQTnhZzpgkKZuVTEwLDUE=;
 b=So3c3VxdByjjZMQdvUmf3GYr02eVXRtja7cFBeiNF8FAxRGMu1ODC+SjOtRPV+UaF9lqhMT0rSbhr/vrIzux026NKzLzdDyeGP/TQfLuQMuX5bSAVY3eSBmqTdu3618rBXQvlpaFEwKka+7l2Cq4SsjZyrErWJ8jUaRXf4LRINr7l8WqRev5j/14L3K+q7Ox0/E3eTlr548Lifg1VrrhAEhZn50Kp9MTy+IBq7tcwLog1ZIxhPUNr0YzWR5C6X4BhvFgKW7n84M4dl6XbghKifP+hzI7xwmkbd/WNBSWDwdS6/HMyq4PAFUHhSf7iu9ZcpFBqqn5Blp8pDc7jSu8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4KCZjkk2Qua9X1hPieafjRQTnhZzpgkKZuVTEwLDUE=;
 b=KA4FDxA2NmQg6x09Kcxnc3+BXZw9NxN4d4pP1nql9d/2hbQLWBu8wBv0ov2J4GjggLr3FC7eEkh5qTtjYjNm7XSSe7vbbDhDW6Rh6qZDeYsSM37yBPc0UnAaCSFSabvOMocSCOlLbyD5V0xqx1hZGhcK6Pq/0CzCFxpsCN0mPSQ=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3520.eurprd08.prod.outlook.com (20.177.61.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 09:52:18 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888%3]) with mapi id 15.20.2115.005; Mon, 5 Aug 2019
 09:52:18 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Topic: [PATCH v2] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Index: AQHVS3N34kDp/cF7tkmzeLrHpfGDHA==
Date:   Mon, 5 Aug 2019 09:52:17 +0000
Message-ID: <20190805095155.17999-1-mihail.atanassov@arm.com>
References: <20190802143951.4436-1-mihail.atanassov@arm.com>
In-Reply-To: <20190802143951.4436-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::15) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.22.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46cbcb7b-5fa8-4153-4278-08d7198a9a10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB3520;
x-ms-traffictypediagnostic: VI1PR08MB3520:
x-microsoft-antispam-prvs: <VI1PR08MB35206C8B6CE6CEE3ABFD890C8FDA0@VI1PR08MB3520.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(40434004)(189003)(199004)(6916009)(2906002)(5640700003)(5660300002)(44832011)(5024004)(14444005)(256004)(68736007)(66446008)(66946007)(64756008)(66476007)(66556008)(2616005)(11346002)(446003)(36756003)(4326008)(2501003)(99286004)(81166006)(81156014)(71190400001)(76176011)(2351001)(305945005)(52116002)(102836004)(86362001)(476003)(8676002)(386003)(6506007)(1076003)(486006)(7736002)(54906003)(6116002)(3846002)(316002)(71200400001)(8936002)(50226002)(53936002)(478600001)(14454004)(25786009)(186003)(26005)(6512007)(66066001)(6486002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3520;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VEN3eukLl6Si86GSfhNhxZw3MASEtEIDDUSbBRBq08G+3LlX1tEhwClc8l4VLfqWsIaHRZrPZkAYV4P4TvMlqs3Pk9HSxc0JmqnaPNO1O90t0Rer2ddOle5GQTylgrHvnO+pD2Qf/0PueUlgRHiqCCPCwiOY8Dygu6dzADgNLdhHprX2qwCeNo85vul9etL317339zPbPaLvEe94tosK9sltDykLf684Y2ok7fjUtd0mYqqo858bxXxxNRExbQRcLw6I6SFp4vm7epBmYDU3jyRlLShk/PLR4Kkzd/D5Yxie8l5kya2+8P54I8ltHpvKp31ltzqkg9Yy15kbOldNaAnmi6SQ2iUgbLo6P1EGAOEQTpNDrCpY5Kxn42VUP0g9NEXhqcqklijR/hckoHY6bW8MvupDCfBcpEvHRYx/Ey0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46cbcb7b-5fa8-4153-4278-08d7198a9a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 09:52:17.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihail.Atanassov@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'memory-region' property of the komeda display driver DT binding
allows the use of a 'reserved-memory' node for buffer allocations. Add
the requisite of_reserved_mem_device_{init,release} calls to actually
make use of the memory if present.

Changes since v1:
 - Move handling inside komeda_parse_dt

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 1ff7f4b2c620..0142ee991957 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -8,6 +8,7 @@
 #include <linux/iommu.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #ifdef CONFIG_DEBUG_FS
@@ -146,6 +147,12 @@ static int komeda_parse_dt(struct device *dev, struct =
komeda_dev *mdev)
 return mdev->irq;
 }

+/* Get the optional framebuffer memory resource */
+ret =3D of_reserved_mem_device_init(dev);
+if (ret && ret !=3D -ENODEV)
+return ret;
+ret =3D 0;
+
 for_each_available_child_of_node(np, child) {
 if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
 ret =3D komeda_parse_pipe_dt(mdev, child);
@@ -292,6 +299,8 @@ void komeda_dev_destroy(struct komeda_dev *mdev)

 mdev->n_pipelines =3D 0;

+of_reserved_mem_device_release(dev);
+
 if (funcs && funcs->cleanup)
 funcs->cleanup(mdev);

--
2.22.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
