Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B405C207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n9zcaK6G";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yt7lCg7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfDBGCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:02:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:31827 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBGCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554184963; x=1585720963;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=9Z1y0gxqRMLGpY2Yk1sFK7ip9p14cbENeiuQF9lFemY=;
  b=n9zcaK6GvLd2k14RV7eKJjW7x1P+pX8JFGT2bmOd6/Xx/hZJjsJGCNi9
   KcBg6Yrq8OLKgwm8O12w7MNNzVYudeAnBBW4N6m3uJBGO+GIboFdpsLNE
   lctqSNAcuBMV1Z8tzDs7NqtIomtGJyAoY/khcGpqDWBLcpteYM5lISwrk
   cHun7SQflVtMIjnYU4n5WSC10eyk/Wb1bgQ0ihu3XMiCJw5+4g3xLF7CU
   S+mPi05OCnguQHKYul8US+rhLh/SnEy0KFXgvebxogqyFT2e653q4BLCb
   vJfkgzIpY4rZdnfUrzDyRz3UpGvsh2P2m4kfj/xy4xheCoas5p4S3VI8C
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,298,1549900800"; 
   d="scan'208";a="104765019"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2019 14:02:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTrxcMC6BmBZxC/1x5IQtCPOx3IXwqtfOEFeiMWB75g=;
 b=Yt7lCg7PProayyaPzOSMro+p3M6jpewVoGelOpX5g8eUOKsODeJZtiCQbcuhHHvAmQ0MrQqmSFaHQ1MBHBKNUXgOxKH3z0xOjtI3s2y4B4U8vjhTafXG7zF4CGvnWsvXjlNSZMP6Pky2Q0DFzgSoRyhTTbkPK9eBUhJfeC8nlso=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5567.namprd04.prod.outlook.com (20.178.246.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 06:02:39 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::ad2f:3a0f:2de1:6fb2%5]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 06:02:39 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH] RISC-V: Fix Maximum Physical Memory 2GiB option for 64bit
 systems
Thread-Topic: [PATCH] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
Thread-Index: AQHU6RmtavXCl8b8E02WvsawiHwFzQ==
Date:   Tue, 2 Apr 2019 06:02:38 +0000
Message-ID: <20190402055902.14017-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To MN2PR04MB6061.namprd04.prod.outlook.com (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48adeb41-784c-475a-6082-08d6b730cf50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR04MB5567;
x-ms-traffictypediagnostic: MN2PR04MB5567:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MN2PR04MB55679A8418965DB965EB80048D560@MN2PR04MB5567.namprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(81166006)(6486002)(106356001)(97736004)(4326008)(71200400001)(71190400001)(81156014)(50226002)(8676002)(72206003)(478600001)(14454004)(186003)(256004)(316002)(4744005)(53936002)(2906002)(25786009)(36756003)(54906003)(110136005)(66066001)(305945005)(8936002)(476003)(5660300002)(7736002)(86362001)(6506007)(99286004)(486006)(68736007)(1076003)(6116002)(6512007)(2616005)(26005)(105586002)(3846002)(6436002)(386003)(52116002)(44832011)(102836004)(2171002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5567;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6QcyB8eZ97sO35kSvHfUwTpCb0E9XX1CTiMzrbTHSxdyqNXU142fn542OmUIMg+3pJ7Mm77jX5iPS7pMjtWnI3B8dWNpbdVQVxjlA0lKCFBfzjutdDYoDAryn2Yp2qJQTqrKipJZsuvINhAq/14KayIlmryYYQU1KzCJJ/h61M49acPNteqPre8W3E0KyDj4DSA0dz0q3EuNd+HwfEGCKZDCsQufVOZBEKey8x8/DXW1vbv5Ok4uxwFs0f9g+A9aVgTQ7MJzwbFQZvVV+gVBDXz5i3tatjdo21iwV2Hwomqnpd+8iyKInrd1D7ScCKqfmv/94+3iYPMMtpxJowD+4ExzL7bYSY0dJs9kKd/EvblTX7IbDeQ8gHsl8tZHAHlszUdppI/PCM9zKpiMi/mQ8uJ/PvfOptHItFULdHgWOTs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48adeb41-784c-475a-6082-08d6b730cf50
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 06:02:38.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Maximum Physical Memory 2GiB option for 64bit systems is currently
broken because kernel hangs at boot-time when this option is enabled
and the underlying system has more than 2GiB memory.

This issue can be easily reproduced on SiFive Unleashed board where
we have 8GiB of memory.

This patch fixes above issue by reserving unusable memory region in
setup_bootmem().

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/mm/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5fd8c922e1c2..6b063f20a9d0 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -121,6 +121,14 @@ void __init setup_bootmem(void)
 			 */
 			memblock_reserve(reg->base, vmlinux_end - reg->base);
 			mem_size =3D min(reg->size, (phys_addr_t)-PAGE_OFFSET);
+
+			/*
+			 * Reserve from the end of usable area to the end of
+			 * region
+			 */
+			if ((reg->base + mem_size) < end)
+				memblock_reserve(reg->base + mem_size,
+						 end - reg->base - mem_size);
 		}
 	}
 	BUG_ON(mem_size =3D=3D 0);
--=20
2.17.1

