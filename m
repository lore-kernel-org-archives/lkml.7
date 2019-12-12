Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71252C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28661214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ek8oJ4F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfLLRBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:01:14 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:41345
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729260AbfLLRBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:01:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDjTypG92CNi91KiP5P5CgaBTO0iczW8dUEPATPoJ9RCNAso3YFHBNR3HNXg7CFuUxkbzYBZmFYchdEx1XMGKOouKfjR61A7kqFecT4oZn6/ZZUKCOUrcW9Iqllwjjfn07M/7+u46IdLnS4TikM6qNZsF2siOIWwE5+iWIDtUKASc3y02+6PrSEZHVo93Sw5c7QznIuvR+/xIovOIwaVAwf9EMJnSYfw2E+bxWvAUtbAi//kCYHNByXGRrcawJElidAtJja8jAuT4UafCerd7JvThK4qfoih0h3Gu3VbHbSrlRtCh9rFXUUkJ+DnfHUjqhwEpbKvXPwOqBbz5xGQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9lwkZ0sgfq21w7jcSqrK/oZ735Z6ZdzVYTaN9hifEU=;
 b=FtcDZXC2+opcNvtsv1w2hipsDRZ2VcJxR1X0rLfLBJmUHemkkKWP7E+VkGts5R2Vb59BuYJJ+QHmWEVm+4RHGqGJi+34zvDdifAG5y2XWuStVip8rhA6pLfppE18dtH9EBDgQjyeL02N8H4BBP+mYfnxpu776FJ5Q8WH3YrHrvwF/bF9vahOvvIBXPOMHZ6C0okfYuXpYaUA4LDCWCr3nnm9B3OtXGJB3o/PU/SGksDMbuV1AMTqP8odctKYDBMNXGpmuhY28lVkKQirPdT6NixyDCWGdWz/ELiZHkt6XsoETV6KfXK7CXvkuVJHucZwNt6+e3SZm9Go40RjiIeJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9lwkZ0sgfq21w7jcSqrK/oZ735Z6ZdzVYTaN9hifEU=;
 b=ek8oJ4F/QKztECnOb7AhxrmSCKJzNrytEWVUWKpRS8lUePCiw/QoEqzihit8lGZmNkPjbLsIzeNpTIDG0bJSaJUoixhQLjZVYvsz2Qrdn/nY36zrhqbXFWaODl2C6AjcDhESpvfTP5OuOP54EDdIfFKAXEX798N3/AUYhntbXFk=
Received: from DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) by
 DB8PR04MB6650.eurprd04.prod.outlook.com (20.179.251.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 17:01:10 +0000
Received: from DB8PR04MB5931.eurprd04.prod.outlook.com
 ([fe80::5002:adf2:99f5:a4fe]) by DB8PR04MB5931.eurprd04.prod.outlook.com
 ([fe80::5002:adf2:99f5:a4fe%7]) with mapi id 15.20.2516.020; Thu, 12 Dec 2019
 17:01:10 +0000
From:   Youri Querry <youri.querry_1@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
CC:     Youri Querry <youri.querry_1@nxp.com>
Subject: [PATCH 0/3] soc: fsl: dpio: Enable QMAN batch enqueuing
Thread-Topic: [PATCH 0/3] soc: fsl: dpio: Enable QMAN batch enqueuing
Thread-Index: AQHVsQ3AyGczVLMI40Km2qz47OLo9w==
Date:   Thu, 12 Dec 2019 17:01:10 +0000
Message-ID: <1576170032-3124-1-git-send-email-youri.querry_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:a03:100::30) To DB8PR04MB5931.eurprd04.prod.outlook.com
 (2603:10a6:10:ae::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=youri.querry_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eef162b9-dccf-4868-76a3-08d77f24e329
x-ms-traffictypediagnostic: DB8PR04MB6650:|DB8PR04MB6650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB665085F9B4811F9D0B4C4EB6F3550@DB8PR04MB6650.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(478600001)(26005)(52116002)(66446008)(6506007)(86362001)(6512007)(316002)(4326008)(2906002)(71200400001)(186003)(36756003)(6486002)(5660300002)(4744005)(81166006)(81156014)(2616005)(6636002)(64756008)(8676002)(66476007)(66946007)(8936002)(110136005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6650;H:DB8PR04MB5931.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ER9sFAM2lVRxox33xBPtov+ChSZOPjM0twI0gLFFwOYQyXKH2xNb7PUmLFT1eSEKRxAwYo1+QA6A7cmXOWJKRIOf7Kmu7kbG7x1lwkOgsAgBjEBpwaj7UBc7rp0GVNQhhKayttGjbLrMCATQFhhK5TRxjykaE64mBno4NN8uCW3Hb4kWDN/Exm1YGHYiISOco1ANI8DR7/yL8/dzr6QP0WkXXUI9p9ZJgigtlIQ0stwaK2ct4E8HUm0HdiCJSq9cu4cHgZqcdUgxPgrpT1EMEliUrbad0JwLecQQ30SgJllpFETZv5gw738Ofm2KKOmcM8CYIicy1wcNxd+bgvpuGPI+1obE0DyAylTKHu04mHFiW+q5QEBDaDX7U9Dain+HXFGQqZ8XQ+wCDa15QuQXJ73rXbRDiV5M70Oi4cu33a77wfNe4eS12K0NYUzicmZt
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef162b9-dccf-4868-76a3-08d77f24e329
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 17:01:10.5698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXrsNpXKKiM+4mYB+wC4GPKaKIR1g1kV24vrcsFoXXIiYQqcI11PUUplqeFyvSKxu0gCU0i6REYSCBP/19J8Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set consists of:
- We added an interface to enqueue several packets at a time and
  improve performance.
- Make the algorithm decisions once at initialization and use
  function pointers to improve performance.
- Replaced the QMAN enqueue array mode algorithm with a ring
  mode algorithm. This is to make the enqueue of several frames
  at a time more effective.

Youri Querry (3):
  soc: fsl: dpio: Adding QMAN multiple enqueue interface.
  soc: fsl: dpio: QMAN performance improvement. Function pointer
    indirection.
  soc: fsl: dpio: Replace QMAN array mode by ring mode enqueue.

 drivers/soc/fsl/dpio/dpio-service.c |  69 +++-
 drivers/soc/fsl/dpio/qbman-portal.c | 766 ++++++++++++++++++++++++++++++++=
----
 drivers/soc/fsl/dpio/qbman-portal.h | 158 +++++++-
 include/soc/fsl/dpaa2-io.h          |   6 +-
 4 files changed, 907 insertions(+), 92 deletions(-)

--=20
2.7.4

