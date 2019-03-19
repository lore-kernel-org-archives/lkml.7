Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE54C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED71D217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RJ/5lFR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCSVyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:54:38 -0400
Received: from mail-eopbgr820080.outbound.protection.outlook.com ([40.107.82.80]:48096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbfCSVyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHjSe4oqMmojCOjqkdCweg6uuaH9yKL0EzIhDPzhzAI=;
 b=RJ/5lFR6ggkPCYSuGMPxv68e9pdk0ZD5kg6XgNm4ia9r8NFXiCMGi/mJzIK5bJ/1hoPRKgEzNdrwQRdDv3KGFDqFOk88Ap4Z/WtYaNjG9BIpJQ2354fGQ4B4JUzcAAc82pQtLKDYNu8eaflhnqyCxxbvbETjgeIui4sPD4jyuCI=
Received: from BYAPR02CA0035.namprd02.prod.outlook.com (2603:10b6:a02:ee::48)
 by BL0PR02MB5537.namprd02.prod.outlook.com (2603:10b6:208:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 21:54:15 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BYAPR02CA0035.outlook.office365.com
 (2603:10b6:a02:ee::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 21:54:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 21:54:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52700 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgY-0002CH-2T; Tue, 19 Mar 2019 14:54:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgS-0001Ps-Ur; Tue, 19 Mar 2019 14:54:08 -0700
Received: from [172.19.73.196] (helo=xsjsonals5570.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <sonals@xilinx.com>)
        id 1h6MgL-0001KM-Pm; Tue, 19 Mar 2019 14:54:01 -0700
Received: by xsjsonals5570.xilinx.com (Postfix, from userid 1000)
        id 8387C760022; Tue, 19 Mar 2019 14:54:01 -0700 (PDT)
From:   <sonal.santan@xilinx.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <airlied@redhat.com>, <cyrilc@xilinx.com>, <michals@xilinx.com>,
        <lizhih@xilinx.com>, <hyunk@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>
Subject: [RFC PATCH Xilinx Alveo 2/6] Global data structures shared between xocl and xmgmt drivers
Date:   Tue, 19 Mar 2019 14:53:57 -0700
Message-ID: <20190319215401.6562-3-sonal.santan@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190319215401.6562-1-sonal.santan@xilinx.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(189003)(199004)(107886003)(14444005)(6266002)(51416003)(5024004)(426003)(2616005)(446003)(11346002)(36756003)(336012)(54906003)(106002)(52956003)(476003)(42186006)(8936002)(26005)(76176011)(103686004)(53946003)(6666004)(4326008)(16586007)(2876002)(2906002)(356004)(50226002)(186003)(86152003)(81166006)(81156014)(2351001)(30864003)(8676002)(50466002)(106466001)(6916009)(36386004)(90966002)(47776003)(126002)(1076003)(486006)(48376002)(63266004)(316002)(305945005)(478600001)(5660300002)(5001870100001)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5537;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3078a39b-3c9b-439a-5bb5-08d6acb56da9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BL0PR02MB5537;
X-MS-TrafficTypeDiagnostic: BL0PR02MB5537:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB553740CEE161BC39D3A98863BB400@BL0PR02MB5537.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: X4tcE+TaDr2ng0Ye+kLscKi64X2mW5pWcaZK8NmxkFDdvF3ZMge0pYI4p9D1X2w5jrKIuFgNNjouqW8i1wH4V1qb4Tn4vh8QZohPBlzsDP+zqPG7POQYC7pN5paxaFJ3ukGrLphV2IP/fMlp1bB5bI3CfndcrsQAMQheS/FYucn8tVPRpy5BfWsqZpfvY+Y4xSHLss1JuqZ4b8BVh9xSZ8uD/iT/5qLI44U6hiGSMaTZSoqlU4J5KKKtfqXkh+RYX523JzcWix/qEoZ01wi/Vr5UmTHqXPImf5/jblANGJY2bsC45ma8vFh4jJI7R4I8OUpqyyG6IZUQTBLVKyZQ/BnKwJBaJ62BrhKHZyd1nfPkDYcyEXmXpTft3egAbKpR1gKWlTZOxUrJKv7nvlVukzXRmGoLtsx0yKMJMtwEWH0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 21:54:14.5154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3078a39b-3c9b-439a-5bb5-08d6acb56da9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5537
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/gpu/drm/xocl/devices.h     | 954 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xocl/ert.h         | 385 ++++++++++++
 drivers/gpu/drm/xocl/version.h     |  22 +
 drivers/gpu/drm/xocl/xclbin.h      | 314 ++++++++++
 drivers/gpu/drm/xocl/xclfeatures.h | 107 ++++
 drivers/gpu/drm/xocl/xocl_ctx.c    | 196 ++++++
 drivers/gpu/drm/xocl/xocl_drm.h    |  91 +++
 drivers/gpu/drm/xocl/xocl_drv.h    | 783 +++++++++++++++++++++++
 drivers/gpu/drm/xocl/xocl_subdev.c | 540 ++++++++++++++++
 drivers/gpu/drm/xocl/xocl_thread.c |  64 ++
 10 files changed, 3456 insertions(+)
 create mode 100644 drivers/gpu/drm/xocl/devices.h
 create mode 100644 drivers/gpu/drm/xocl/ert.h
 create mode 100644 drivers/gpu/drm/xocl/version.h
 create mode 100644 drivers/gpu/drm/xocl/xclbin.h
 create mode 100644 drivers/gpu/drm/xocl/xclfeatures.h
 create mode 100644 drivers/gpu/drm/xocl/xocl_ctx.c
 create mode 100644 drivers/gpu/drm/xocl/xocl_drm.h
 create mode 100644 drivers/gpu/drm/xocl/xocl_drv.h
 create mode 100644 drivers/gpu/drm/xocl/xocl_subdev.c
 create mode 100644 drivers/gpu/drm/xocl/xocl_thread.c

diff --git a/drivers/gpu/drm/xocl/devices.h b/drivers/gpu/drm/xocl/devices.h
new file mode 100644
index 000000000000..3fc6f8ea6c9b
--- /dev/null
+++ b/drivers/gpu/drm/xocl/devices.h
@@ -0,0 +1,954 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+
+/*
+ *  Copyright (C) 2018-2019, Xilinx Inc
+ *
+ */
+
+
+#ifndef	_XCL_DEVICES_H_
+#define	_XCL_DEVICES_H_
+
+/* board flags */
+enum {
+	XOCL_DSAFLAG_PCI_RESET_OFF =		0x01,
+	XOCL_DSAFLAG_MB_SCHE_OFF =		0x02,
+	XOCL_DSAFLAG_AXILITE_FLUSH =		0x04,
+	XOCL_DSAFLAG_SET_DSA_VER =		0x08,
+	XOCL_DSAFLAG_SET_XPR =			0x10,
+	XOCL_DSAFLAG_MFG =			0x20,
+};
+
+#define	FLASH_TYPE_SPI	"spi"
+#define	FLASH_TYPE_QSPIPS	"qspi_ps"
+
+struct xocl_subdev_info {
+	uint32_t		id;
+	char			*name;
+	struct resource		*res;
+	int			num_res;
+	void			*priv_data;
+	int			data_len;
+};
+
+struct xocl_board_private {
+	uint64_t		flags;
+	struct xocl_subdev_info	*subdev_info;
+	uint32_t		subdev_num;
+	uint32_t		dsa_ver;
+	bool			xpr;
+	char			*flash_type; /* used by xbflash */
+	char			*board_name; /* used by xbflash */
+	bool			mpsoc;
+};
+
+#ifdef __KERNEL__
+#define XOCL_PCI_DEVID(ven, dev, subsysid, priv)		\
+	.vendor = ven, .device = dev, .subvendor = PCI_ANY_ID,	\
+	.subdevice = subsysid, .driver_data =			\
+	(kernel_ulong_t) &XOCL_BOARD_##priv
+
+struct xocl_dsa_vbnv_map {
+	uint16_t		vendor;
+	uint16_t		device;
+	uint16_t		subdevice;
+	char			*vbnv;
+	struct xocl_board_private	*priv_data;
+};
+
+#else
+struct xocl_board_info {
+	uint16_t		vendor;
+	uint16_t		device;
+	uint16_t		subdevice;
+	struct xocl_board_private	*priv_data;
+};
+
+#define XOCL_PCI_DEVID(ven, dev, subsysid, priv)        \
+	.vendor = ven, .device = dev,			\
+	.subdevice = subsysid, .priv_data = &XOCL_BOARD_##priv
+
+struct resource {
+	size_t		start;
+	size_t		end;
+	unsigned long	flags;
+};
+
+enum {
+	IORESOURCE_MEM,
+	IORESOURCE_IRQ,
+};
+
+#define	PCI_ANY_ID	-1
+#define SUBDEV_SUFFIX
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+
+#endif
+
+#define	MGMT_SUFFIX		".m"
+#define	USER_SUFFIX		".u"
+
+#define	XOCL_FEATURE_ROM_USER	"rom" USER_SUFFIX
+#define XOCL_FEATURE_ROM	"rom" SUBDEV_SUFFIX
+#define XOCL_XDMA		"xdma" SUBDEV_SUFFIX
+#define XOCL_QDMA		"qdma" SUBDEV_SUFFIX
+#define XOCL_MB_SCHEDULER	"mb_scheduler" SUBDEV_SUFFIX
+#define XOCL_XVC_PUB		"xvc_pub" SUBDEV_SUFFIX
+#define XOCL_XVC_PRI		"xvc_pri" SUBDEV_SUFFIX
+#define XOCL_SYSMON		"sysmon" SUBDEV_SUFFIX
+#define XOCL_FIREWALL		"firewall" SUBDEV_SUFFIX
+#define	XOCL_MB			"microblaze" SUBDEV_SUFFIX
+#define	XOCL_XIIC		"xiic" SUBDEV_SUFFIX
+#define	XOCL_MAILBOX		"mailbox" SUBDEV_SUFFIX
+#define	XOCL_ICAP		"icap" SUBDEV_SUFFIX
+#define	XOCL_MIG		"mig" SUBDEV_SUFFIX
+#define	XOCL_XMC		"xmc" SUBDEV_SUFFIX
+#define	XOCL_DNA		"dna" SUBDEV_SUFFIX
+#define	XOCL_FMGR		"fmgr" SUBDEV_SUFFIX
+
+enum subdev_id {
+	XOCL_SUBDEV_FEATURE_ROM,
+	XOCL_SUBDEV_DMA,
+	XOCL_SUBDEV_MB_SCHEDULER,
+	XOCL_SUBDEV_XVC_PUB,
+	XOCL_SUBDEV_XVC_PRI,
+	XOCL_SUBDEV_SYSMON,
+	XOCL_SUBDEV_AF,
+	XOCL_SUBDEV_MIG,
+	XOCL_SUBDEV_MB,
+	XOCL_SUBDEV_XIIC,
+	XOCL_SUBDEV_MAILBOX,
+	XOCL_SUBDEV_ICAP,
+	XOCL_SUBDEV_XMC,
+	XOCL_SUBDEV_DNA,
+	XOCL_SUBDEV_FMGR,
+	XOCL_SUBDEV_NUM
+};
+
+#define	XOCL_RES_FEATURE_ROM				\
+		((struct resource []) {			\
+			{				\
+			.start	= 0xB0000,		\
+			.end	= 0xB0FFF,		\
+			.flags	= IORESOURCE_MEM,	\
+			}				\
+		})
+
+
+#define	XOCL_DEVINFO_FEATURE_ROM			\
+	{						\
+		XOCL_SUBDEV_FEATURE_ROM,		\
+		XOCL_FEATURE_ROM,			\
+		XOCL_RES_FEATURE_ROM,			\
+		ARRAY_SIZE(XOCL_RES_FEATURE_ROM),	\
+	}
+
+#define	XOCL_RES_SYSMON					\
+		((struct resource []) {			\
+			{				\
+			.start	= 0xA0000,		\
+			.end	= 0xAFFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			}				\
+		})
+
+#define	XOCL_DEVINFO_SYSMON				\
+	{						\
+		XOCL_SUBDEV_SYSMON,			\
+		XOCL_SYSMON,				\
+		XOCL_RES_SYSMON,			\
+		ARRAY_SIZE(XOCL_RES_SYSMON),		\
+	}
+
+/* Will be populated dynamically */
+#define	XOCL_RES_MIG					\
+		((struct resource []) {			\
+			{				\
+			.start	= 0x0,			\
+			.end	= 0x3FF,		\
+			.flags  = IORESOURCE_MEM,	\
+			}				\
+		})
+
+#define	XOCL_DEVINFO_MIG				\
+	{						\
+		XOCL_SUBDEV_MIG,			\
+		XOCL_MIG,				\
+		XOCL_RES_MIG,				\
+		ARRAY_SIZE(XOCL_RES_MIG),		\
+	}
+
+
+#define	XOCL_RES_AF					\
+		((struct resource []) {			\
+			{				\
+			.start	= 0xD0000,		\
+			.end	= 0xDFFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0xE0000,		\
+			.end	= 0xEFFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0xF0000,		\
+			.end	= 0xFFFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x330000,		\
+			.end	= 0x330FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+		})
+
+#define	XOCL_DEVINFO_AF					\
+	{						\
+		XOCL_SUBDEV_AF,				\
+		XOCL_FIREWALL,				\
+		XOCL_RES_AF,				\
+		ARRAY_SIZE(XOCL_RES_AF),		\
+	}
+
+#define	XOCL_RES_AF_DSA52				\
+		((struct resource []) {			\
+			{				\
+			.start	= 0xD0000,		\
+			.end	= 0xDFFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0xE0000,		\
+			.end	= 0xE0FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0xE1000,		\
+			.end	= 0xE1FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0xF0000,		\
+			.end	= 0xFFFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x330000,		\
+			.end	= 0x330FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+		})
+
+#define	XOCL_DEVINFO_AF_DSA52				\
+	{						\
+		XOCL_SUBDEV_AF,				\
+		XOCL_FIREWALL,				\
+		XOCL_RES_AF_DSA52,			\
+		ARRAY_SIZE(XOCL_RES_AF_DSA52),		\
+	}
+
+#define	XOCL_RES_XVC_PUB				\
+	((struct resource []) {				\
+		{					\
+			.start	= 0xC0000,		\
+			.end	= 0xCFFFF,		\
+			.flags	= IORESOURCE_MEM,	\
+		},					\
+	})
+
+#define	XOCL_DEVINFO_XVC_PUB				\
+	{						\
+		XOCL_SUBDEV_XVC_PUB,			\
+		XOCL_XVC_PUB,				\
+		XOCL_RES_XVC_PUB,			\
+		ARRAY_SIZE(XOCL_RES_XVC_PUB),		\
+	}
+
+#define	XOCL_RES_XVC_PRI				\
+	((struct resource []) {				\
+		{					\
+			.start	= 0x1C0000,		\
+			.end	= 0x1CFFFF,		\
+			.flags	= IORESOURCE_MEM,	\
+		},					\
+	})
+
+#define	XOCL_DEVINFO_XVC_PRI				\
+	{						\
+		XOCL_SUBDEV_XVC_PRI,			\
+		XOCL_XVC_PRI,				\
+		XOCL_RES_XVC_PRI,			\
+		ARRAY_SIZE(XOCL_RES_XVC_PRI),		\
+	}
+
+#define	XOCL_RES_XIIC					\
+	((struct resource []) {				\
+		{					\
+			.start	= 0x41000,		\
+			.end	= 0x41FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+	})
+
+#define	XOCL_DEVINFO_XIIC				\
+	{						\
+		XOCL_SUBDEV_XIIC,			\
+		XOCL_XIIC,				\
+		XOCL_RES_XIIC,				\
+		ARRAY_SIZE(XOCL_RES_XIIC),		\
+	}
+
+
+/* Will be populated dynamically */
+#define	XOCL_RES_DNA					\
+	((struct resource []) {				\
+		{					\
+			.start	= 0x0,			\
+			.end	= 0xFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+		}					\
+	})
+
+#define	XOCL_DEVINFO_DNA				\
+	{						\
+		XOCL_SUBDEV_DNA,			\
+		XOCL_DNA,				\
+		XOCL_RES_DNA,				\
+		ARRAY_SIZE(XOCL_RES_DNA),		\
+	}
+
+#define	XOCL_MAILBOX_OFFSET_MGMT	0x210000
+#define	XOCL_RES_MAILBOX_MGMT				\
+	((struct resource []) {				\
+		{					\
+			.start	= XOCL_MAILBOX_OFFSET_MGMT, \
+			.end	= 0x21002F,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		{					\
+			.start	= 11,			\
+			.end	= 11,			\
+			.flags  = IORESOURCE_IRQ,	\
+		},					\
+	})
+
+#define	XOCL_DEVINFO_MAILBOX_MGMT			\
+	{						\
+		XOCL_SUBDEV_MAILBOX,			\
+		XOCL_MAILBOX,				\
+		XOCL_RES_MAILBOX_MGMT,			\
+		ARRAY_SIZE(XOCL_RES_MAILBOX_MGMT),	\
+	}
+
+#define	XOCL_MAILBOX_OFFSET_USER	0x200000
+#define	XOCL_RES_MAILBOX_USER				\
+	((struct resource []) {				\
+		{					\
+			.start	= XOCL_MAILBOX_OFFSET_USER, \
+			.end	= 0x20002F,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		{					\
+			.start	= 4,			\
+			.end	= 4,			\
+			.flags  = IORESOURCE_IRQ,	\
+		},					\
+	})
+
+#define	XOCL_DEVINFO_MAILBOX_USER			\
+	{						\
+		XOCL_SUBDEV_MAILBOX,			\
+		XOCL_MAILBOX,				\
+		XOCL_RES_MAILBOX_USER,			\
+		ARRAY_SIZE(XOCL_RES_MAILBOX_USER),	\
+	}
+
+#define	XOCL_RES_ICAP_MGMT				\
+	((struct resource []) {				\
+		/* HWICAP registers */			\
+		{					\
+			.start	= 0x020000,		\
+			.end	= 0x020119,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		/* GENERAL_STATUS_BASE */		\
+		{					\
+			.start	= 0x032000,		\
+			.end	= 0x032003,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		/* AXI Gate registers */		\
+		{					\
+			.start	= 0x030000,		\
+			.end	= 0x03000b,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		/* OCL_CLKWIZ0_BASE */			\
+		{					\
+			.start	= 0x050000,		\
+			.end	= 0x050fff,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		/* OCL_CLKWIZ1_BASE */			\
+		{					\
+			.start	= 0x051000,		\
+			.end	= 0x051fff,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+		/* OCL_CLKFREQ_BASE */			\
+		{					\
+			.start	= 0x052000,		\
+			.end	= 0x052fff,		\
+			.flags  = IORESOURCE_MEM,	\
+		},					\
+	})
+
+#define	XOCL_DEVINFO_ICAP_MGMT				\
+	{						\
+		XOCL_SUBDEV_ICAP,			\
+		XOCL_ICAP,				\
+		XOCL_RES_ICAP_MGMT,			\
+		ARRAY_SIZE(XOCL_RES_ICAP_MGMT),		\
+	}
+
+#define	XOCL_DEVINFO_ICAP_USER				\
+	{						\
+		XOCL_SUBDEV_ICAP,			\
+		XOCL_ICAP,				\
+		NULL,					\
+		0,					\
+	}
+
+#define	XOCL_RES_XMC					\
+		((struct resource []) {			\
+			{				\
+			.start	= 0x120000,		\
+			.end	= 0x121FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x131000,		\
+			.end	= 0x131FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x140000,		\
+			.end	= 0x15FFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x160000,		\
+			.end	= 0x17FFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x190000,		\
+			.end	= 0x19FFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+		})
+
+#define	XOCL_DEVINFO_XMC					\
+	{						\
+		XOCL_SUBDEV_XMC,				\
+		XOCL_XMC,				\
+		XOCL_RES_XMC,				\
+		ARRAY_SIZE(XOCL_RES_XMC),		\
+	}
+
+#define	XOCL_DEVINFO_XMC_USER			\
+	{						\
+		XOCL_SUBDEV_XMC,				\
+		XOCL_XMC,				\
+		NULL,					\
+		0,					\
+	}
+
+#define	XOCL_RES_MB					\
+		((struct resource []) {			\
+			{				\
+			.start	= 0x120000,		\
+			.end	= 0x121FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x131000,		\
+			.end	= 0x131FFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x140000,		\
+			.end	= 0x15FFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+			{				\
+			.start	= 0x160000,		\
+			.end	= 0x17FFFF,		\
+			.flags  = IORESOURCE_MEM,	\
+			},				\
+		})
+
+#define	XOCL_DEVINFO_MB					\
+	{						\
+		XOCL_SUBDEV_MB,				\
+		XOCL_MB,				\
+		XOCL_RES_MB,				\
+		ARRAY_SIZE(XOCL_RES_MB),		\
+	}
+
+#define	XOCL_DEVINFO_QDMA				\
+	{						\
+		XOCL_SUBDEV_DMA,			\
+		XOCL_QDMA,				\
+		NULL,					\
+		0,					\
+	}
+
+#define	XOCL_DEVINFO_XDMA				\
+	{						\
+		XOCL_SUBDEV_DMA,			\
+		XOCL_XDMA,				\
+		NULL,					\
+		0,					\
+	}
+
+#define XOCL_RES_SCHEDULER				\
+	((struct resource []) {				\
+		{					\
+			.start  = 0,			\
+			.end    = 3,			\
+			.flags  = IORESOURCE_IRQ,	\
+		}					\
+	})
+
+
+#define	XOCL_DEVINFO_SCHEDULER				\
+	{						\
+		XOCL_SUBDEV_MB_SCHEDULER,		\
+		XOCL_MB_SCHEDULER,			\
+		XOCL_RES_SCHEDULER,			\
+		ARRAY_SIZE(XOCL_RES_SCHEDULER),		\
+	}
+
+#define	XOCL_DEVINFO_FMGR				\
+	{						\
+		XOCL_SUBDEV_FMGR,			\
+		XOCL_FMGR,				\
+		NULL,					\
+		0,					\
+	}
+
+
+/* user pf defines */
+#define	USER_RES_QDMA							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_QDMA,				\
+			XOCL_DEVINFO_SCHEDULER,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_ICAP_USER,				\
+		})
+
+#define	XOCL_BOARD_USER_QDMA						\
+	(struct xocl_board_private){					\
+		.flags		= XOCL_DSAFLAG_MB_SCHE_OFF,		\
+		.subdev_info	= USER_RES_QDMA,			\
+		.subdev_num = ARRAY_SIZE(USER_RES_QDMA),		\
+	}
+
+#define	USER_RES_XDMA_DSA50						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_XDMA,				\
+			XOCL_DEVINFO_SCHEDULER,				\
+			XOCL_DEVINFO_ICAP_USER,				\
+		})
+
+#define	USER_RES_XDMA							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_XDMA,				\
+			XOCL_DEVINFO_SCHEDULER,				\
+			XOCL_DEVINFO_MAILBOX_USER,			\
+			XOCL_DEVINFO_ICAP_USER,				\
+		})
+
+#define USER_RES_AWS							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_XDMA,				\
+			XOCL_DEVINFO_SCHEDULER,				\
+			XOCL_DEVINFO_ICAP_USER,				\
+		})
+
+#define	USER_RES_DSA52							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_XDMA,				\
+			XOCL_DEVINFO_SCHEDULER,				\
+			XOCL_DEVINFO_MAILBOX_USER,			\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_ICAP_USER,				\
+			XOCL_DEVINFO_XMC_USER,				\
+		})
+
+#define	XOCL_BOARD_USER_XDMA_DSA50					\
+	(struct xocl_board_private){					\
+		.flags		= XOCL_DSAFLAG_MB_SCHE_OFF,		\
+		.subdev_info	= USER_RES_XDMA_DSA50,			\
+		.subdev_num = ARRAY_SIZE(USER_RES_XDMA_DSA50),		\
+	}
+
+#define	XOCL_BOARD_USER_XDMA						\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= USER_RES_XDMA,			\
+		.subdev_num = ARRAY_SIZE(USER_RES_XDMA),		\
+	}
+
+#define	XOCL_BOARD_USER_XDMA_ERT_OFF					\
+	(struct xocl_board_private){					\
+		.flags		= XOCL_DSAFLAG_MB_SCHE_OFF,		\
+		.subdev_info	= USER_RES_XDMA,			\
+		.subdev_num = ARRAY_SIZE(USER_RES_XDMA),		\
+	}
+
+#define XOCL_BOARD_USER_AWS						\
+	(struct xocl_board_private){					\
+		.flags      = 0,					\
+		.subdev_info    = USER_RES_AWS,				\
+		.subdev_num = ARRAY_SIZE(USER_RES_AWS),			\
+	}
+
+#define	XOCL_BOARD_USER_DSA52						\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= USER_RES_DSA52,			\
+		.subdev_num = ARRAY_SIZE(USER_RES_DSA52),		\
+	}
+
+/* mgmt pf defines */
+#define	MGMT_RES_DEFAULT						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_XIIC,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	MGMT_RES_DSA50							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_XIIC,				\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	XOCL_BOARD_MGMT_DEFAULT						\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_DEFAULT,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_DEFAULT),		\
+	}
+
+#define	XOCL_BOARD_MGMT_DSA50						\
+	(struct xocl_board_private){					\
+		.flags		= XOCL_DSAFLAG_PCI_RESET_OFF |		\
+			XOCL_DSAFLAG_AXILITE_FLUSH |			\
+			XOCL_DSAFLAG_MB_SCHE_OFF,			\
+		.subdev_info	= MGMT_RES_DSA50,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_DSA50),		\
+	}
+
+#define	MGMT_RES_6A8F							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	MGMT_RES_6A8F_DSA50						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	MGMT_RES_XBB_DSA51						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_XMC,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	XOCL_BOARD_MGMT_6A8F						\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_6A8F,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_6A8F),		\
+	}
+
+#define	XOCL_BOARD_MGMT_XBB_DSA51						\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_XBB_DSA51,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_XBB_DSA51),		\
+		.flash_type = FLASH_TYPE_SPI,				\
+	}
+
+
+#define	XOCL_BOARD_MGMT_888F	XOCL_BOARD_MGMT_6A8F
+#define	XOCL_BOARD_MGMT_898F	XOCL_BOARD_MGMT_6A8F
+
+#define	XOCL_BOARD_MGMT_6A8F_DSA50					\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_6A8F_DSA50,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_6A8F_DSA50),		\
+	}
+
+#define	MGMT_RES_QDMA							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PRI,				\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+
+#define	XOCL_BOARD_MGMT_QDMA					\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_QDMA,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_QDMA),		\
+		.flash_type = FLASH_TYPE_SPI				\
+	}
+
+#define MGMT_RES_XBB_QDMA                                               \
+	((struct xocl_subdev_info []) {                         \
+		XOCL_DEVINFO_FEATURE_ROM,                       \
+		XOCL_DEVINFO_SYSMON,                            \
+		XOCL_DEVINFO_AF_DSA52,                          \
+		XOCL_DEVINFO_XMC,                               \
+		XOCL_DEVINFO_XVC_PRI,                           \
+		XOCL_DEVINFO_ICAP_MGMT,                         \
+	})
+
+#define XOCL_BOARD_MGMT_XBB_QDMA                                        \
+	(struct xocl_board_private){                                    \
+		.flags          = 0,                                    \
+		.subdev_info    = MGMT_RES_XBB_QDMA,                    \
+		.subdev_num = ARRAY_SIZE(MGMT_RES_XBB_QDMA),            \
+		.flash_type = FLASH_TYPE_SPI				\
+	}
+
+#define	XOCL_BOARD_MGMT_6B0F		XOCL_BOARD_MGMT_6A8F
+
+#define	MGMT_RES_6A8F_DSA52						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF_DSA52,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PRI,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	XOCL_BOARD_MGMT_6A8F_DSA52					\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_6A8F_DSA52,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_6A8F_DSA52),		\
+	}
+
+#define	MGMT_RES_XBB_DSA52						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF_DSA52,				\
+			XOCL_DEVINFO_XMC,				\
+			XOCL_DEVINFO_XVC_PRI,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	XOCL_BOARD_MGMT_XBB_DSA52					\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_XBB_DSA52,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_XBB_DSA52),		\
+		.flash_type = FLASH_TYPE_SPI,				\
+	}
+
+#define	MGMT_RES_6E8F_DSA52						\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_AF,				\
+			XOCL_DEVINFO_MB,				\
+			XOCL_DEVINFO_XVC_PRI,				\
+			XOCL_DEVINFO_XIIC,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	XOCL_BOARD_MGMT_6E8F_DSA52					\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_6E8F_DSA52,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_6E8F_DSA52),		\
+	}
+
+#define MGMT_RES_MPSOC							\
+		((struct xocl_subdev_info []) {				\
+			XOCL_DEVINFO_FEATURE_ROM,			\
+			XOCL_DEVINFO_SYSMON,				\
+			XOCL_DEVINFO_XVC_PUB,				\
+			XOCL_DEVINFO_MAILBOX_MGMT,			\
+			XOCL_DEVINFO_ICAP_MGMT,				\
+			XOCL_DEVINFO_FMGR,				\
+		})
+
+#define	XOCL_BOARD_MGMT_MPSOC						\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= MGMT_RES_MPSOC,			\
+		.subdev_num = ARRAY_SIZE(MGMT_RES_MPSOC),		\
+		.mpsoc = true,						\
+		.board_name = "samsung",				\
+		.flash_type = FLASH_TYPE_QSPIPS,			\
+	}
+
+#define	XOCL_BOARD_USER_XDMA_MPSOC					\
+	(struct xocl_board_private){					\
+		.flags		= 0,					\
+		.subdev_info	= USER_RES_XDMA,			\
+		.subdev_num = ARRAY_SIZE(USER_RES_XDMA),		\
+		.mpsoc = true,						\
+	}
+
+
+#define	XOCL_BOARD_XBB_MFG(board)					\
+	(struct xocl_board_private){					\
+		.flags = XOCL_DSAFLAG_MFG,				\
+		.board_name = board,					\
+		.flash_type = FLASH_TYPE_SPI,				\
+	}
+
+#define	XOCL_MGMT_PCI_IDS	{					\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4A47, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4A87, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4B47, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4B87, 0x4350, MGMT_DSA50) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4B87, 0x4351, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x684F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0xA883, 0x1351, MGMT_MPSOC) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0xA983, 0x1351, MGMT_MPSOC) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x688F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x694F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x698F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A4F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A8F, 0x4350, MGMT_6A8F_DSA50) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A8F, 0x4351, MGMT_6A8F) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A8F, 0x4352, MGMT_6A8F_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A9F, 0x4360, MGMT_QDMA) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5010, PCI_ANY_ID, MGMT_XBB_QDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A9F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6E4F, PCI_ANY_ID, MGMT_DEFAULT) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6B0F, PCI_ANY_ID, MGMT_6B0F) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6E8F, 0x4352, MGMT_6E8F_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x888F, PCI_ANY_ID, MGMT_888F) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x898F, PCI_ANY_ID, MGMT_898F) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x788F, 0x4351, MGMT_XBB_DSA51) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x788F, 0x4352, MGMT_XBB_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x798F, 0x4352, MGMT_XBB_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A8F, 0x4353, MGMT_6A8F_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5000, PCI_ANY_ID, MGMT_XBB_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5004, PCI_ANY_ID, MGMT_XBB_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5008, PCI_ANY_ID, MGMT_XBB_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x13FE, 0x006C, PCI_ANY_ID, MGMT_6A8F) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0xD000, PCI_ANY_ID, XBB_MFG("u200")) }, \
+	{ XOCL_PCI_DEVID(0x10EE, 0xD004, PCI_ANY_ID, XBB_MFG("u250")) }, \
+	{ XOCL_PCI_DEVID(0x10EE, 0xD008, PCI_ANY_ID, XBB_MFG("u280-es1")) }, \
+	{ XOCL_PCI_DEVID(0x10EE, 0xD00C, PCI_ANY_ID, XBB_MFG("u280")) }, \
+	{ XOCL_PCI_DEVID(0x10EE, 0xEB10, PCI_ANY_ID, XBB_MFG("twitch")) }, \
+	{ 0, }								\
+}
+
+#define	XOCL_USER_PCI_IDS	{					\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4A48, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4A88, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4B48, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4B88, 0x4350, USER_XDMA_DSA50) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x4B88, 0x4351, USER_XDMA) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6850, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6890, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6950, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0xA884, 0x1351, USER_XDMA_MPSOC) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0xA984, 0x1351, USER_XDMA_MPSOC) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6990, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A50, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A90, 0x4350, USER_XDMA_DSA50) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A90, 0x4351, USER_XDMA) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A90, 0x4352, USER_DSA52) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6A90, 0x4353, USER_DSA52) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6E50, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6B10, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6E90, 0x4352, USER_DSA52) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x8890, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x8990, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x7890, 0x4351, USER_XDMA) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x7890, 0x4352, USER_DSA52) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x7990, 0x4352, USER_DSA52) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5001, PCI_ANY_ID, USER_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5005, PCI_ANY_ID, USER_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5009, PCI_ANY_ID, USER_DSA52) },	\
+	{ XOCL_PCI_DEVID(0x13FE, 0x0065, PCI_ANY_ID, USER_XDMA) },	\
+	{ XOCL_PCI_DEVID(0x1D0F, 0x1042, PCI_ANY_ID, USER_AWS) },	\
+	{ XOCL_PCI_DEVID(0x1D0F, 0xF000, PCI_ANY_ID, USER_AWS) },	\
+	{ XOCL_PCI_DEVID(0x1D0F, 0xF010, PCI_ANY_ID, USER_AWS) },	\
+	{ XOCL_PCI_DEVID(0x10EE, 0x6AA0, 0x4360, USER_QDMA) },		\
+	{ XOCL_PCI_DEVID(0x10EE, 0x5011, PCI_ANY_ID, USER_QDMA) },	\
+	{ 0, }								\
+}
+
+#define XOCL_DSA_VBNV_MAP	{					\
+	{ 0x10EE, 0x5001, PCI_ANY_ID, "xilinx_u200_xdma_201820_1",	\
+		&XOCL_BOARD_USER_XDMA },				\
+	{ 0x10EE, 0x5000, PCI_ANY_ID, "xilinx_u200_xdma_201820_1",	\
+		&XOCL_BOARD_MGMT_XBB_DSA51 }				\
+}
+
+#endif
diff --git a/drivers/gpu/drm/xocl/ert.h b/drivers/gpu/drm/xocl/ert.h
new file mode 100644
index 000000000000..2e94c5a63877
--- /dev/null
+++ b/drivers/gpu/drm/xocl/ert.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+/**
+ * Copyright (C) 2017-2019, Xilinx Inc
+ * DOC: Xilinx SDAccel Embedded Runtime definition
+ *
+ * Header file *ert.h* defines data structures used by Emebdded Runtime (ERT) and
+ * XRT xclExecBuf() API.
+ */
+
+#ifndef _ERT_H_
+#define _ERT_H_
+
+#if defined(__KERNEL__)
+# include <linux/types.h>
+#else
+# include <stdint.h>
+#endif
+
+/**
+ * struct ert_packet: ERT generic packet format
+ *
+ * @state:   [3-0] current state of a command
+ * @custom:  [11-4] custom per specific commands
+ * @count:   [22-12] number of words in payload (data)
+ * @opcode:  [27-23] opcode identifying specific command
+ * @type:    [31-28] type of command (currently 0)
+ * @data:    count number of words representing packet payload
+ */
+struct ert_packet {
+  union {
+    struct {
+      uint32_t state:4;   /* [3-0]   */
+      uint32_t custom:8;  /* [11-4]  */
+      uint32_t count:11;  /* [22-12] */
+      uint32_t opcode:5;  /* [27-23] */
+      uint32_t type:4;    /* [31-28] */
+    };
+    uint32_t header;
+  };
+  uint32_t data[1];   /* count number of words */
+};
+
+/**
+ * struct ert_start_kernel_cmd: ERT start kernel command format
+ *
+ * @state:           [3-0] current state of a command
+ * @extra_cu_masks:  [11-10] extra CU masks in addition to mandatory mask
+ * @count:           [22-12] number of words following header
+ * @opcode:          [27-23] 0, opcode for start_kernel
+ * @type:            [31-27] 0, type of start_kernel
+ *
+ * @cu_mask:         first mandatory CU mask
+ * @data:            count-1 number of words representing interpreted payload
+ *
+ * The packet payload is comprised of reserved id field, a mandatory CU mask,
+ * and extra_cu_masks per header field, followed by a CU register map of size
+ * (count - (1 + extra_cu_masks)) uint32_t words.
+ */
+struct ert_start_kernel_cmd {
+  union {
+    struct {
+      uint32_t state:4;          /* [3-0]   */
+      uint32_t unused:6;         /* [9-4]  */
+      uint32_t extra_cu_masks:2; /* [11-10]  */
+      uint32_t count:11;         /* [22-12] */
+      uint32_t opcode:5;         /* [27-23] */
+      uint32_t type:4;           /* [31-27] */
+    };
+    uint32_t header;
+  };
+
+  /* payload */
+  uint32_t cu_mask;          /* mandatory cu mask */
+  uint32_t data[1];          /* count-1 number of words */
+};
+
+#define COPYBO_UNIT   64     /* Limited by KDMA CU */
+struct ert_start_copybo_cmd {
+  uint32_t state:4;          /* [3-0], must be ERT_CMD_STATE_NEW */
+  uint32_t unused:6;         /* [9-4] */
+  uint32_t extra_cu_masks:2; /* [11-10], = 3 */
+  uint32_t count:11;         /* [22-12], = sizeof(ert_start_copybo_cmd)-1 */
+  uint32_t opcode:5;         /* [27-23], = ERT_START_COPYBO */
+  uint32_t type:4;           /* [31-27], = ERT_DEFAULT */
+  uint32_t cu_mask[4];       /* mandatory cu masks */
+  uint32_t reserved[4];      /* for scheduler use */
+  uint32_t src_addr_lo;      /* low 32 bit of src addr */
+  uint32_t src_addr_hi;      /* high 32 bit of src addr */
+  uint32_t src_bo_hdl;       /* src bo handle, cleared by driver */
+  uint32_t dst_addr_lo;      /* low 32 bit of dst addr */
+  uint32_t dst_addr_hi;      /* high 32 bit of dst addr */
+  uint32_t dst_bo_hdl;       /* dst bo handle, cleared by driver */
+  uint32_t size;             /* size in COPYBO_UNIT byte */
+};
+
+/**
+ * struct ert_configure_cmd: ERT configure command format
+ *
+ * @state:           [3-0] current state of a command
+ * @count:           [22-12] number of words in payload (5 + num_cus)
+ * @opcode:          [27-23] 1, opcode for configure
+ * @type:            [31-27] 0, type of configure
+ *
+ * @slot_size:       command queue slot size
+ * @num_cus:         number of compute units in program
+ * @cu_shift:        shift value to convert CU idx to CU addr
+ * @cu_base_addr:    base address to add to CU addr for actual physical address
+ *
+ * @ert:1            enable embedded HW scheduler
+ * @polling:1        poll for command completion
+ * @cu_dma:1         enable CUDMA custom module for HW scheduler
+ * @cu_isr:1         enable CUISR custom module for HW scheduler
+ * @cq_int:1         enable interrupt from host to HW scheduler
+ * @cdma:1           enable CDMA kernel
+ * @unused:25
+ * @dsa52:1          reserved for internal use
+ *
+ * @data:            addresses of @num_cus CUs
+ */
+struct ert_configure_cmd {
+  union {
+    struct {
+      uint32_t state:4;          /* [3-0]   */
+      uint32_t unused:8;         /* [11-4]  */
+      uint32_t count:11;         /* [22-12] */
+      uint32_t opcode:5;         /* [27-23] */
+      uint32_t type:4;           /* [31-27] */
+    };
+    uint32_t header;
+  };
+
+  /* payload */
+  uint32_t slot_size;
+  uint32_t num_cus;
+  uint32_t cu_shift;
+  uint32_t cu_base_addr;
+
+  /* features */
+  uint32_t ert:1;
+  uint32_t polling:1;
+  uint32_t cu_dma:1;
+  uint32_t cu_isr:1;
+  uint32_t cq_int:1;
+  uint32_t cdma:1;
+  uint32_t unusedf:25;
+  uint32_t dsa52:1;
+
+  /* cu address map size is num_cus */
+  uint32_t data[1];
+};
+
+/**
+ * struct ert_abort_cmd: ERT abort command format.
+ *
+ * @idx: The slot index of command to abort
+ */
+struct ert_abort_cmd {
+  union {
+    struct {
+      uint32_t state:4;          /* [3-0]   */
+      uint32_t unused:11;        /* [14-4]  */
+      uint32_t idx:8;            /* [22-15] */
+      uint32_t opcode:5;         /* [27-23] */
+      uint32_t type:4;           /* [31-27] */
+    };
+    uint32_t header;
+  };
+};
+
+/**
+ * ERT command state
+ *
+ * @ERT_CMD_STATE_NEW:      Set by host before submitting a command to scheduler
+ * @ERT_CMD_STATE_QUEUED:   Internal scheduler state
+ * @ERT_CMD_STATE_SUBMITTED:Internal scheduler state
+ * @ERT_CMD_STATE_RUNNING:  Internal scheduler state
+ * @ERT_CMD_STATE_COMPLETE: Set by scheduler when command completes
+ * @ERT_CMD_STATE_ERROR:    Set by scheduler if command failed
+ * @ERT_CMD_STATE_ABORT:    Set by scheduler if command abort
+ */
+enum ert_cmd_state {
+  ERT_CMD_STATE_NEW = 1,
+  ERT_CMD_STATE_QUEUED = 2,
+  ERT_CMD_STATE_RUNNING = 3,
+  ERT_CMD_STATE_COMPLETED = 4,
+  ERT_CMD_STATE_ERROR = 5,
+  ERT_CMD_STATE_ABORT = 6,
+  ERT_CMD_STATE_SUBMITTED = 7,
+};
+
+/**
+ * Opcode types for commands
+ *
+ * @ERT_START_CU:       start a workgroup on a CU
+ * @ERT_START_KERNEL:   currently aliased to ERT_START_CU
+ * @ERT_CONFIGURE:      configure command scheduler
+ * @ERT_WRITE:          write pairs of addr and value
+ * @ERT_CU_STAT:        get stats about CU execution
+ * @ERT_START_COPYBO:   start KDMA CU or P2P, may be converted to ERT_START_CU
+ *                      before cmd reach to scheduler, short-term hack
+ */
+enum ert_cmd_opcode {
+  ERT_START_CU     = 0,
+  ERT_START_KERNEL = 0,
+  ERT_CONFIGURE    = 2,
+  ERT_STOP         = 3,
+  ERT_ABORT        = 4,
+  ERT_WRITE        = 5,
+  ERT_CU_STAT      = 6,
+  ERT_START_COPYBO = 7,
+};
+
+/**
+ * Command types
+ *
+ * @ERT_DEFAULT:        default command type
+ * @ERT_KDS_LOCAL:      command processed by KDS locally
+ * @ERT_CTRL:           control command uses reserved command queue slot
+ */
+enum ert_cmd_type {
+  ERT_DEFAULT = 0,
+  ERT_KDS_LOCAL = 1,
+  ERT_CTRL = 2,
+};
+
+/**
+ * Address constants per spec
+ */
+#define ERT_WORD_SIZE                     4          /* 4 bytes */
+#define ERT_CQ_SIZE                       0x10000    /* 64K */
+#define ERT_CQ_BASE_ADDR                  0x190000
+#define ERT_CSR_ADDR                      0x180000
+
+/**
+ * The STATUS REGISTER is for communicating completed CQ slot indices
+ * MicroBlaze write, host reads.  MB(W) / HOST(COR)
+ */
+#define ERT_STATUS_REGISTER_ADDR          (ERT_CSR_ADDR)
+#define ERT_STATUS_REGISTER_ADDR0         (ERT_CSR_ADDR)
+#define ERT_STATUS_REGISTER_ADDR1         (ERT_CSR_ADDR + 0x4)
+#define ERT_STATUS_REGISTER_ADDR2         (ERT_CSR_ADDR + 0x8)
+#define ERT_STATUS_REGISTER_ADDR3         (ERT_CSR_ADDR + 0xC)
+
+/**
+ * The CU DMA REGISTER is for communicating which CQ slot is to be started
+ * on a specific CU.  MB selects a free CU on which the command can
+ * run, then writes the 1<<CU back to the command slot CU mask and
+ * writes the slot index to the CU DMA REGISTER.  HW is notified when
+ * the register is written and now does the DMA transfer of CU regmap
+ * map from command to CU, while MB continues its work. MB(W) / HW(R)
+ */
+#define ERT_CU_DMA_ENABLE_ADDR            (ERT_CSR_ADDR + 0x18)
+#define ERT_CU_DMA_REGISTER_ADDR          (ERT_CSR_ADDR + 0x1C)
+#define ERT_CU_DMA_REGISTER_ADDR0         (ERT_CSR_ADDR + 0x1C)
+#define ERT_CU_DMA_REGISTER_ADDR1         (ERT_CSR_ADDR + 0x20)
+#define ERT_CU_DMA_REGISTER_ADDR2         (ERT_CSR_ADDR + 0x24)
+#define ERT_CU_DMA_REGISTER_ADDR3         (ERT_CSR_ADDR + 0x28)
+
+/**
+ * The SLOT SIZE is the size of slots in command queue, it is
+ * configurable per xclbin. MB(W) / HW(R)
+ */
+#define ERT_CQ_SLOT_SIZE_ADDR             (ERT_CSR_ADDR + 0x2C)
+
+/**
+ * The CU_OFFSET is the size of a CU's address map in power of 2.  For
+ * example a 64K regmap is 2^16 so 16 is written to the CU_OFFSET_ADDR.
+ * MB(W) / HW(R)
+ */
+#define ERT_CU_OFFSET_ADDR                (ERT_CSR_ADDR + 0x30)
+
+/**
+ * The number of slots is command_queue_size / slot_size.
+ * MB(W) / HW(R)
+ */
+#define ERT_CQ_NUMBER_OF_SLOTS_ADDR       (ERT_CSR_ADDR + 0x34)
+
+/**
+ * All CUs placed in same address space separated by CU_OFFSET. The
+ * CU_BASE_ADDRESS is the address of the first CU. MB(W) / HW(R)
+ */
+#define ERT_CU_BASE_ADDRESS_ADDR          (ERT_CSR_ADDR + 0x38)
+
+/**
+ * The CQ_BASE_ADDRESS is the base address of the command queue.
+ * MB(W) / HW(R)
+ */
+#define ERT_CQ_BASE_ADDRESS_ADDR          (ERT_CSR_ADDR + 0x3C)
+
+/**
+ * The CU_ISR_HANDLER_ENABLE (MB(W)/HW(R)) enables the HW handling of
+ * CU interrupts.  When a CU interrupts (when done), hardware handles
+ * the interrupt and writes the index of the CU that completed into
+ * the CU_STATUS_REGISTER (HW(W)/MB(COR)) as a bitmask
+ */
+#define ERT_CU_ISR_HANDLER_ENABLE_ADDR    (ERT_CSR_ADDR + 0x40)
+#define ERT_CU_STATUS_REGISTER_ADDR       (ERT_CSR_ADDR + 0x44)
+#define ERT_CU_STATUS_REGISTER_ADDR0      (ERT_CSR_ADDR + 0x44)
+#define ERT_CU_STATUS_REGISTER_ADDR1      (ERT_CSR_ADDR + 0x48)
+#define ERT_CU_STATUS_REGISTER_ADDR2      (ERT_CSR_ADDR + 0x4C)
+#define ERT_CU_STATUS_REGISTER_ADDR3      (ERT_CSR_ADDR + 0x50)
+
+/**
+ * The CQ_STATUS_ENABLE (MB(W)/HW(R)) enables interrupts from HOST to
+ * MB to indicate the presense of a new command in some slot.  The
+ * slot index is written to the CQ_STATUS_REGISTER (HOST(W)/MB(R))
+ */
+#define ERT_CQ_STATUS_ENABLE_ADDR         (ERT_CSR_ADDR + 0x54)
+#define ERT_CQ_STATUS_REGISTER_ADDR       (ERT_CSR_ADDR + 0x58)
+#define ERT_CQ_STATUS_REGISTER_ADDR0      (ERT_CSR_ADDR + 0x58)
+#define ERT_CQ_STATUS_REGISTER_ADDR1      (ERT_CSR_ADDR + 0x5C)
+#define ERT_CQ_STATUS_REGISTER_ADDR2      (ERT_CSR_ADDR + 0x60)
+#define ERT_CQ_STATUS_REGISTER_ADDR3      (ERT_CSR_ADDR + 0x64)
+
+/**
+ * The NUMBER_OF_CU (MB(W)/HW(R) is the number of CUs per current
+ * xclbin.  This is an optimization that allows HW to only check CU
+ * completion on actual CUs.
+ */
+#define ERT_NUMBER_OF_CU_ADDR             (ERT_CSR_ADDR + 0x68)
+
+/**
+ * Enable global interrupts from MB to HOST on command completion.
+ * When enabled writing to STATUS_REGISTER causes an interrupt in HOST.
+ * MB(W)
+ */
+#define ERT_HOST_INTERRUPT_ENABLE_ADDR    (ERT_CSR_ADDR + 0x100)
+
+/**
+ * Interrupt controller base address
+ * This value is per hardware BSP (XPAR_INTC_SINGLE_BASEADDR)
+ */
+#define ERT_INTC_ADDR                     0x41200000
+
+/**
+ * Look up table for CUISR for CU addresses
+ */
+#define ERT_CUISR_LUT_ADDR                (ERT_CSR_ADDR + 0x400)
+
+/**
+ * ERT stop command/ack
+ */
+#define	ERT_STOP_CMD			  ((ERT_STOP << 23) | ERT_CMD_STATE_NEW)
+#define	ERT_STOP_ACK			  (ERT_CMD_STATE_COMPLETED)
+
+/**
+ * State machine for both CUDMA and CUISR modules
+ */
+#define ERT_HLS_MODULE_IDLE               0x1
+#define ERT_CUDMA_STATE                   (ERT_CSR_ADDR + 0x318)
+#define ERT_CUISR_STATE                   (ERT_CSR_ADDR + 0x328)
+
+/**
+ * Interrupt address masks written by MB when interrupts from
+ * CU are enabled
+ */
+#define ERT_INTC_IPR_ADDR                 (ERT_INTC_ADDR + 0x4)  /* pending */
+#define ERT_INTC_IER_ADDR                 (ERT_INTC_ADDR + 0x8)  /* enable */
+#define ERT_INTC_IAR_ADDR                 (ERT_INTC_ADDR + 0x0C) /* acknowledge */
+#define ERT_INTC_MER_ADDR                 (ERT_INTC_ADDR + 0x1C) /* master enable */
+
+static inline void
+ert_fill_copybo_cmd(struct ert_start_copybo_cmd *pkt, uint32_t src_bo,
+  uint32_t dst_bo, uint64_t src_offset, uint64_t dst_offset, uint64_t size)
+{
+  pkt->state = ERT_CMD_STATE_NEW;
+  pkt->extra_cu_masks = 3;
+  pkt->count = sizeof (struct ert_start_copybo_cmd) / 4 - 1;
+  pkt->opcode = ERT_START_COPYBO;
+  pkt->type = ERT_DEFAULT;
+  pkt->cu_mask[0] = 0;
+  pkt->cu_mask[1] = 0;
+  pkt->cu_mask[2] = 0;
+  pkt->cu_mask[3] = 0;
+  pkt->src_addr_lo = src_offset;
+  pkt->src_addr_hi = (src_offset >> 32) & 0xFFFFFFFF;
+  pkt->src_bo_hdl = src_bo;
+  pkt->dst_addr_lo = dst_offset;
+  pkt->dst_addr_hi = (dst_offset >> 32) & 0xFFFFFFFF;
+  pkt->dst_bo_hdl = dst_bo;
+  pkt->size = size / COPYBO_UNIT;
+}
+
+#endif
diff --git a/drivers/gpu/drm/xocl/version.h b/drivers/gpu/drm/xocl/version.h
new file mode 100644
index 000000000000..bdf3d2c6655a
--- /dev/null
+++ b/drivers/gpu/drm/xocl/version.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+#ifndef _XRT_VERSION_H_
+#define _XRT_VERSION_H_
+
+static const char xrt_build_version[] = "2.2.0";
+
+static const char xrt_build_version_branch[] = "master";
+
+static const char xrt_build_version_hash[] = "2de0f3707ba3b3f1a853006bfd8f75a118907021";
+
+static const char xrt_build_version_hash_date[] = "Mon, 4 Mar 2019 13:26:04 -0800";
+
+static const char xrt_build_version_date_rfc[] = "Mon, 04 Mar 2019 19:33:17 -0800";
+
+static const char xrt_build_version_date[] = "2019-03-04 19:33:17";
+
+static const char xrt_modified_files[] = "";
+
+#define XRT_DRIVER_VERSION "2.2.0,2de0f3707ba3b3f1a853006bfd8f75a118907021"
+
+#endif
diff --git a/drivers/gpu/drm/xocl/xclbin.h b/drivers/gpu/drm/xocl/xclbin.h
new file mode 100644
index 000000000000..4a40e9ab03e7
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xclbin.h
@@ -0,0 +1,314 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+/* Copyright (C) 2015-2019, Xilinx Inc */
+
+#ifndef _XCLBIN_H_
+#define _XCLBIN_H_
+
+#if defined(__KERNEL__)
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/version.h>
+#elif defined(__cplusplus)
+#include <cstdlib>
+#include <cstdint>
+#include <algorithm>
+#include <uuid/uuid.h>
+#else
+#include <stdlib.h>
+#include <stdint.h>
+#include <uuid/uuid.h>
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+    /**
+     * Container format for Xilinx bitstreams, metadata and other
+     * binary blobs.
+     * Every segment must be aligned at 8 byte boundary with null byte padding
+     * between adjacent segments if required.
+     * For segements which are not present both offset and length must be 0 in
+     * the header.
+     * Currently only xclbin0\0 is recognized as file magic. In future if/when file
+     * format is updated the magic string will be changed to xclbin1\0 and so on.
+     */
+    enum XCLBIN_MODE {
+        XCLBIN_FLAT,
+        XCLBIN_PR,
+        XCLBIN_TANDEM_STAGE2,
+        XCLBIN_TANDEM_STAGE2_WITH_PR,
+        XCLBIN_HW_EMU,
+        XCLBIN_SW_EMU,
+        XCLBIN_MODE_MAX
+    };
+
+    /*
+     *  AXLF LAYOUT
+     *  -----------
+     *
+     *  -----------------------------------------
+     *  | Magic                                 |
+     *  -----------------------------------------
+     *  | Header                                |
+     *  -----------------------------------------
+     *  | One or more section headers           |
+     *  -----------------------------------------
+     *  | Matching number of sections with data |
+     *  -----------------------------------------
+     *
+     */
+
+    enum axlf_section_kind {
+        BITSTREAM = 0,
+        CLEARING_BITSTREAM,
+        EMBEDDED_METADATA,
+        FIRMWARE,
+        DEBUG_DATA,
+        SCHED_FIRMWARE,
+        MEM_TOPOLOGY,
+        CONNECTIVITY,
+        IP_LAYOUT,
+        DEBUG_IP_LAYOUT,
+        DESIGN_CHECK_POINT,
+        CLOCK_FREQ_TOPOLOGY,
+        MCS,
+        BMC,
+        BUILD_METADATA,
+        KEYVALUE_METADATA,
+        USER_METADATA,
+        DNA_CERTIFICATE,
+        PDI,
+        BITSTREAM_PARTIAL_PDI
+    };
+
+    enum MEM_TYPE {
+        MEM_DDR3,
+        MEM_DDR4,
+        MEM_DRAM,
+        MEM_STREAMING,
+        MEM_PREALLOCATED_GLOB,
+        MEM_ARE, //Aurora
+        MEM_HBM,
+        MEM_BRAM,
+        MEM_URAM,
+        MEM_STREAMING_CONNECTION
+    };
+
+    enum IP_TYPE {
+        IP_MB = 0,
+        IP_KERNEL, //kernel instance
+        IP_DNASC,
+        IP_DDR4_CONTROLLER
+    };
+
+    struct axlf_section_header {
+        uint32_t m_sectionKind;             /* Section type */
+        char m_sectionName[16];             /* Examples: "stage2", "clear1", "clear2", "ocl1", "ocl2, "ublaze", "sched" */
+        uint64_t m_sectionOffset;           /* File offset of section data */
+        uint64_t m_sectionSize;             /* Size of section data */
+    };
+
+    struct axlf_header {
+        uint64_t m_length;                  /* Total size of the xclbin file */
+        uint64_t m_timeStamp;               /* Number of seconds since epoch when xclbin was created */
+        uint64_t m_featureRomTimeStamp;     /* TimeSinceEpoch of the featureRom */
+        uint16_t m_versionPatch;            /* Patch Version */
+        uint8_t m_versionMajor;             /* Major Version - Version: 2.1.0*/
+        uint8_t m_versionMinor;             /* Minor Version */
+        uint32_t m_mode;                    /* XCLBIN_MODE */
+	union {
+	    struct {
+		uint64_t m_platformId;      /* 64 bit platform ID: vendor-device-subvendor-subdev */
+		uint64_t m_featureId;       /* 64 bit feature id */
+	    } rom;
+	    unsigned char rom_uuid[16];     /* feature ROM UUID for which this xclbin was generated */
+	};
+        unsigned char m_platformVBNV[64];   /* e.g. xilinx:xil-accel-rd-ku115:4ddr-xpr:3.4: null terminated */
+	union {
+	    char m_next_axlf[16];           /* Name of next xclbin file in the daisy chain */
+	    uuid_t uuid;                    /* uuid of this xclbin*/
+	};
+        char m_debug_bin[16];               /* Name of binary with debug information */
+        uint32_t m_numSections;             /* Number of section headers */
+    };
+
+    struct axlf {
+        char m_magic[8];                            /* Should be "xclbin2\0"  */
+        unsigned char m_cipher[32];                 /* Hmac output digest */
+        unsigned char m_keyBlock[256];              /* Signature for validation of binary */
+        uint64_t m_uniqueId;                        /* axlf's uniqueId, use it to skip redownload etc */
+        struct axlf_header m_header;                /* Inline header */
+        struct axlf_section_header m_sections[1];   /* One or more section headers follow */
+    };
+
+    typedef struct axlf xclBin;
+
+    /**** BEGIN : Xilinx internal section *****/
+
+    /* bitstream information */
+    struct xlnx_bitstream {
+        uint8_t m_freq[8];
+        char bits[1];
+    };
+
+    /****   MEMORY TOPOLOGY SECTION ****/
+    struct mem_data {
+	uint8_t m_type; //enum corresponding to mem_type.
+	uint8_t m_used; //if 0 this bank is not present
+	union {
+	    uint64_t m_size; //if mem_type DDR, then size in KB;
+	    uint64_t route_id; //if streaming then "route_id"
+	};
+	union {
+	    uint64_t m_base_address;//if DDR then the base address;
+	    uint64_t flow_id; //if streaming then "flow id"
+	};
+	unsigned char m_tag[16]; //DDR: BANK0,1,2,3, has to be null terminated; if streaming then stream0, 1 etc
+    };
+
+    struct mem_topology {
+        int32_t m_count; //Number of mem_data
+        struct mem_data m_mem_data[1]; //Should be sorted on mem_type
+    };
+
+    /****   CONNECTIVITY SECTION ****/
+    /* Connectivity of each argument of Kernel. It will be in terms of argument
+     * index associated. For associating kernel instances with arguments and
+     * banks, start at the connectivity section. Using the m_ip_layout_index
+     * access the ip_data.m_name. Now we can associate this kernel instance
+     * with its original kernel name and get the connectivity as well. This
+     * enables us to form related groups of kernel instances.
+     */
+
+    struct connection {
+        int32_t arg_index; //From 0 to n, may not be contiguous as scalars skipped
+        int32_t m_ip_layout_index; //index into the ip_layout section. ip_layout.m_ip_data[index].m_type == IP_KERNEL
+        int32_t mem_data_index; //index of the m_mem_data . Flag error is m_used false.
+    };
+
+    struct connectivity {
+        int32_t m_count;
+        struct connection m_connection[1];
+    };
+
+
+    /****   IP_LAYOUT SECTION ****/
+    /* IPs on AXI lite - their types, names, and base addresses.*/
+    struct ip_data {
+        uint32_t m_type; //map to IP_TYPE enum
+        uint32_t properties; //32 bits to indicate ip specific property. eg if m_type == IP_KERNEL then bit 0 is for interrupt.
+        uint64_t m_base_address;
+        uint8_t m_name[64]; //eg Kernel name corresponding to KERNEL instance, can embed CU name in future.
+    };
+
+    struct ip_layout {
+        int32_t m_count;
+        struct ip_data m_ip_data[1]; //All the ip_data needs to be sorted by m_base_address.
+    };
+
+    /*** Debug IP section layout ****/
+    enum DEBUG_IP_TYPE {
+        UNDEFINED = 0,
+        LAPC,
+        ILA,
+        AXI_MM_MONITOR,
+        AXI_TRACE_FUNNEL,
+        AXI_MONITOR_FIFO_LITE,
+        AXI_MONITOR_FIFO_FULL,
+        ACCEL_MONITOR,
+        AXI_STREAM_MONITOR
+    };
+
+    struct debug_ip_data {
+        uint8_t m_type; // type of enum DEBUG_IP_TYPE
+        uint8_t m_index;
+        uint8_t m_properties;
+        uint8_t m_major;
+        uint8_t m_minor;
+        uint8_t m_reserved[3];
+        uint64_t m_base_address;
+        char    m_name[128];
+    };
+
+    struct debug_ip_layout {
+        uint16_t m_count;
+        struct debug_ip_data m_debug_ip_data[1];
+    };
+
+    enum CLOCK_TYPE {                      /* Supported clock frequency types */
+        CT_UNUSED = 0,                     /* Initialized value */
+        CT_DATA   = 1,                     /* Data clock */
+        CT_KERNEL = 2,                     /* Kernel clock */
+        CT_SYSTEM = 3                      /* System Clock */
+    };
+
+    struct clock_freq {                    /* Clock Frequency Entry */
+        u_int16_t m_freq_Mhz;              /* Frequency in MHz */
+        u_int8_t m_type;                   /* Clock type (enum CLOCK_TYPE) */
+        u_int8_t m_unused[5];              /* Not used - padding */
+        char m_name[128];                  /* Clock Name */
+    };
+
+    struct clock_freq_topology {           /* Clock frequency section */
+        int16_t m_count;                   /* Number of entries */
+        struct clock_freq m_clock_freq[1]; /* Clock array */
+    };
+
+    enum MCS_TYPE {                        /* Supported MCS file types */
+        MCS_UNKNOWN = 0,                   /* Initialized value */
+        MCS_PRIMARY = 1,                   /* The primary mcs file data */
+        MCS_SECONDARY = 2,                 /* The secondary mcs file data */
+    };
+
+    struct mcs_chunk {                     /* One chunk of MCS data */
+        uint8_t m_type;                    /* MCS data type */
+        uint8_t m_unused[7];               /* padding */
+        uint64_t m_offset;                 /* data offset from the start of the section */
+        uint64_t m_size;                   /* data size */
+    };
+
+    struct mcs {                           /* MCS data section */
+        int8_t m_count;                    /* Number of chunks */
+        int8_t m_unused[7];                /* padding */
+        struct mcs_chunk m_chunk[1];       /* MCS chunks followed by data */
+    };
+
+    struct bmc {                           /* bmc data section  */
+        uint64_t m_offset;                 /* data offset from the start of the section */
+        uint64_t m_size;                   /* data size (bytes)*/
+        char m_image_name[64];             /* Name of the image (e.g., MSP432P401R) */
+        char m_device_name[64];            /* Device ID         (e.g., VCU1525)  */
+        char m_version[64];
+        char m_md5value[33];               /* MD5 Expected Value(e.g., 56027182079c0bd621761b7dab5a27ca)*/
+        char m_padding[7];                 /* Padding */
+    };
+
+    enum CHECKSUM_TYPE
+    {
+        CST_UNKNOWN = 0,
+        CST_SDBM = 1,
+        CST_LAST
+    };
+
+    /**** END : Xilinx internal section *****/
+
+# ifdef __cplusplus
+    namespace xclbin {
+      inline const axlf_section_header*
+      get_axlf_section(const axlf* top, axlf_section_kind kind)
+      {
+        auto begin = top->m_sections;
+        auto end = begin + top->m_header.m_numSections;
+        auto itr = std::find_if(begin,end,[kind](const axlf_section_header& sec) { return sec.m_sectionKind==kind; });
+        return (itr!=end) ? &(*itr) : nullptr;
+      }
+    }
+# endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/drivers/gpu/drm/xocl/xclfeatures.h b/drivers/gpu/drm/xocl/xclfeatures.h
new file mode 100644
index 000000000000..3ef2616e061f
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xclfeatures.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+
+/*
+ *  Xilinx SDAccel FPGA BIOS definition
+ *  Copyright (C) 2016-2019, Xilinx Inc
+ */
+
+#ifndef xclfeatures_h_
+#define xclfeatures_h_
+
+#define FEATURE_ROM_MAJOR_VERSION 10
+#define FEATURE_ROM_MINOR_VERSION 1
+
+//Layout: At address 0xB0000, we will have the FeatureRomHeader that comprises:
+//
+//1. First have FeatureRomHeader: 152 bytes of information followed by
+//2. Then, as a part of FeatureRomHeader we have the PRRegion struct(s).
+//	The number of such structs will be same as OCLRegionCount.
+//3. After this the freq scaling table is laid out.
+//
+
+//#include <stdint.h>
+
+struct PartialRegion {
+	uint16_t clk[4];
+	uint8_t XPR; //0 : non-xpt, 1: xpr
+};
+
+// Each entry represents one row in freq scaling table.
+struct FreqScalingTableRow {
+	short config0;
+	short freq;
+	short config2;
+};
+
+enum PROMType  {
+	BPI    = 0,
+	SPI   = 1
+   //room for 6 more types of flash devices.
+};
+
+enum DebugType	{
+	DT_NIFD	 = 0x01,
+	DT_FIREWALL  = 0x02
+  //There is room for future expansion upto 8 IPs
+};
+
+// This bit mask is used with the FeatureBitMap to calculate 64 bool features
+//
+// To test if a feature is provided:
+//   FeatureRomHeader header;
+//   if (FeatureBitMask::FBM_IS_UNIFIED & header.FeatureBitMap)
+//     // it is supported
+//   else
+//     // it is not supported
+//
+// To set if a feature is provided:
+//   header.FeatureBitMap = 0;
+//   header.FeatureBitMap |= FeatureBitMask::FBM_IS_UNIFIED;
+//
+enum FeatureBitMask {
+	UNIFIED_PLATFORM	 =   0x0000000000000001	      /* bit 1 : Unified platform */
+	, XARE_ENBLD		 =   0x0000000000000002	      /* bit 2 : Aurora link enabled DSA */
+	, BOARD_MGMT_ENBLD	 =   0x0000000000000004	      /* bit 3 : Has MB based power monitoring */
+	, MB_SCHEDULER		 =   0x0000000000000008	      /* bit 4:	 Has MB based scheduler */
+	, PROM_MASK		 =   0x0000000000000070	      /* bits 5,6 &7  : 3 bits for PROMType */
+	/**	------ Bit 8 unused **/
+	, DEBUG_MASK		 =   0x000000000000FF00	      /* bits 9 through 16  : 8 bits for DebugType */
+	, PEER_TO_PEER		 =   0x0000000000010000	      /* bits 17  : Bar 2 is a peer to peer bar */
+	, UUID			 =   0x0000000000020000	      /* bits 18  : UUID enabled. uuid[16] field is valid */
+	, HBM			 =   0x0000000000040000	      /* bits 19  : Device has HBM's. */
+	, CDMA			 =   0x0000000000080000	      /* bits 21  : Device has CDMA*/
+	, QDMA			 =   0x0000000000100000	      /* bits 20  : Device has QDMA*/
+
+	//....more
+};
+
+
+// In the following data structures, the EntryPointString, MajorVersion, and MinorVersion
+// values are all used in the Runtime to identify if the ROM is producing valid data, and
+// to pick the schema to read the rest of the data; Ergo, these values shall not change.
+
+/*
+ * Struct used for >  2017.2_sdx
+ * This struct should be used for version (==) 10.0 (Major: 10, Minor: 0)
+ */
+struct FeatureRomHeader {
+	unsigned char EntryPointString[4];  // This is "xlnx"
+	uint8_t MajorVersion;		    // Feature ROM's major version eg 1
+	uint8_t MinorVersion;		    // minor version eg 2.
+	// -- DO NOT CHANGE THE TYPES ABOVE THIS LINE --
+	uint32_t VivadoBuildID;		    // Vivado Software Build (e.g., 1761098 ). From ./vivado --version
+	uint32_t IPBuildID;		    // IP Build (e.g., 1759159 from abve)
+	uint64_t TimeSinceEpoch;	    // linux time(NULL) call, at write_dsa_rom invocation
+	unsigned char FPGAPartName[64];	    // The hardware FPGA part. Null termninated
+	unsigned char VBNVName[64];	    // eg : xilinx:xil-accel-rd-ku115:4ddr-xpr:3.4: null terminated
+	uint8_t DDRChannelCount;	    // 4 for TUL
+	uint8_t DDRChannelSize;		    // 4 (in GB)
+	uint64_t DRBaseAddress;	            // The Dynamic Range's (AppPF/CL/Userspace) Base Address
+	uint64_t FeatureBitMap;		    // Feature Bit Map, 64 different bool features, maps to enum FeatureBitMask
+	unsigned char uuid[16];		    // UUID of the DSA.
+	uint8_t HBMCount;		    // Number of HBMs
+	uint8_t HBMSize;		    // Size of (each) HBM in GB
+	uint32_t CDMABaseAddress[4];	    // CDMA base addresses
+};
+
+#endif // xclfeatures_h_
diff --git a/drivers/gpu/drm/xocl/xocl_ctx.c b/drivers/gpu/drm/xocl/xocl_ctx.c
new file mode 100644
index 000000000000..4a6c6045c827
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xocl_ctx.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Lizhi.Hou@xilinx.com
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include "xocl_drv.h"
+
+/*
+ * helper functions to protect driver private data
+ */
+DEFINE_MUTEX(xocl_drvinst_lock);
+struct xocl_drvinst *xocl_drvinst_array[XOCL_MAX_DEVICES * 10];
+
+void *xocl_drvinst_alloc(struct device *dev, u32 size)
+{
+	struct xocl_drvinst	*drvinstp;
+	int		inst;
+
+	mutex_lock(&xocl_drvinst_lock);
+	for (inst = 0; inst < ARRAY_SIZE(xocl_drvinst_array); inst++)
+		if (!xocl_drvinst_array[inst])
+			break;
+
+	if (inst == ARRAY_SIZE(xocl_drvinst_array))
+		goto failed;
+
+	drvinstp = kzalloc(size + sizeof(struct xocl_drvinst), GFP_KERNEL);
+	if (!drvinstp)
+		goto failed;
+
+	drvinstp->dev = dev;
+	drvinstp->size = size;
+	init_completion(&drvinstp->comp);
+	atomic_set(&drvinstp->ref, 1);
+	INIT_LIST_HEAD(&drvinstp->open_procs);
+
+	xocl_drvinst_array[inst] = drvinstp;
+
+	mutex_unlock(&xocl_drvinst_lock);
+
+	return drvinstp->data;
+
+failed:
+	mutex_unlock(&xocl_drvinst_lock);
+
+	kfree(drvinstp);
+	return NULL;
+}
+
+void xocl_drvinst_free(void *data)
+{
+	struct xocl_drvinst	*drvinstp;
+	struct xocl_drvinst_proc *proc, *temp;
+	struct pid		*p;
+	int		inst;
+	int		ret;
+
+	mutex_lock(&xocl_drvinst_lock);
+	drvinstp = container_of(data, struct xocl_drvinst, data);
+	for (inst = 0; inst < ARRAY_SIZE(xocl_drvinst_array); inst++) {
+		if (drvinstp == xocl_drvinst_array[inst])
+			break;
+	}
+
+	/* it must be created before */
+	BUG_ON(inst == ARRAY_SIZE(xocl_drvinst_array));
+
+	xocl_drvinst_array[inst] = NULL;
+	mutex_unlock(&xocl_drvinst_lock);
+
+	/* wait all opened instances to close */
+	if (!atomic_dec_and_test(&drvinstp->ref)) {
+		xocl_info(drvinstp->dev, "Wait for close %p\n",
+				&drvinstp->comp);
+		ret = wait_for_completion_killable(&drvinstp->comp);
+		if (ret == -ERESTARTSYS) {
+			list_for_each_entry_safe(proc, temp,
+				&drvinstp->open_procs, link) {
+				p = find_get_pid(proc->pid);
+				if (!p)
+					continue;
+				ret = kill_pid(p, SIGBUS, 1);
+				if (ret)
+					xocl_err(drvinstp->dev,
+						"kill %d failed",
+						proc->pid);
+				put_pid(p);
+			}
+			wait_for_completion(&drvinstp->comp);
+		}
+	}
+
+	kfree(drvinstp);
+}
+
+void xocl_drvinst_set_filedev(void *data, void *file_dev)
+{
+	struct xocl_drvinst	*drvinstp;
+	int		inst;
+
+	mutex_lock(&xocl_drvinst_lock);
+	drvinstp = container_of(data, struct xocl_drvinst, data);
+	for (inst = 0; inst < ARRAY_SIZE(xocl_drvinst_array); inst++) {
+		if (drvinstp == xocl_drvinst_array[inst])
+			break;
+	}
+
+	BUG_ON(inst == ARRAY_SIZE(xocl_drvinst_array));
+
+	drvinstp->file_dev = file_dev;
+	mutex_unlock(&xocl_drvinst_lock);
+}
+
+void *xocl_drvinst_open(void *file_dev)
+{
+	struct xocl_drvinst	*drvinstp;
+	struct xocl_drvinst_proc	*proc;
+	int		inst;
+	u32		pid;
+
+	mutex_lock(&xocl_drvinst_lock);
+	for (inst = 0; inst < ARRAY_SIZE(xocl_drvinst_array); inst++) {
+		drvinstp = xocl_drvinst_array[inst];
+		if (drvinstp && file_dev == drvinstp->file_dev)
+			break;
+	}
+
+	if (inst == ARRAY_SIZE(xocl_drvinst_array)) {
+		mutex_unlock(&xocl_drvinst_lock);
+		return NULL;
+	}
+
+	pid = pid_nr(task_tgid(current));
+	list_for_each_entry(proc, &drvinstp->open_procs, link) {
+		if (proc->pid == pid)
+			break;
+	}
+	if (&proc->link == &drvinstp->open_procs) {
+		proc = kzalloc(sizeof(*proc), GFP_KERNEL);
+		if (!proc) {
+			mutex_unlock(&xocl_drvinst_lock);
+			return NULL;
+		}
+		proc->pid = pid;
+		list_add(&proc->link, &drvinstp->open_procs);
+	} else
+		proc->count++;
+	xocl_info(drvinstp->dev, "OPEN %d\n", drvinstp->ref.counter);
+
+	if (atomic_inc_return(&drvinstp->ref) == 2)
+		reinit_completion(&drvinstp->comp);
+
+
+	mutex_unlock(&xocl_drvinst_lock);
+
+	return drvinstp->data;
+}
+
+void xocl_drvinst_close(void *data)
+{
+	struct xocl_drvinst	*drvinstp;
+	struct xocl_drvinst_proc *proc;
+	u32	pid;
+
+	mutex_lock(&xocl_drvinst_lock);
+	drvinstp = container_of(data, struct xocl_drvinst, data);
+
+	xocl_info(drvinstp->dev, "CLOSE %d\n", drvinstp->ref.counter);
+
+	pid = pid_nr(task_tgid(current));
+	list_for_each_entry(proc, &drvinstp->open_procs, link) {
+		if (proc->pid == pid)
+			break;
+	}
+
+	if (proc) {
+		proc->count--;
+		if (!proc->count) {
+			list_del(&proc->link);
+			kfree(proc);
+		}
+	}
+
+	if (atomic_dec_return(&drvinstp->ref) == 1) {
+		xocl_info(drvinstp->dev, "NOTIFY %p\n", &drvinstp->comp);
+		complete(&drvinstp->comp);
+	}
+
+	mutex_unlock(&xocl_drvinst_lock);
+}
diff --git a/drivers/gpu/drm/xocl/xocl_drm.h b/drivers/gpu/drm/xocl/xocl_drm.h
new file mode 100644
index 000000000000..de362ee062f6
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xocl_drm.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ */
+
+#ifndef _XOCL_DRM_H
+#define	_XOCL_DRM_H
+
+#include <linux/hashtable.h>
+
+/**
+ * struct drm_xocl_exec_metadata - Meta data for exec bo
+ *
+ * @state: State of exec buffer object
+ * @active: Reverse mapping to kds command object managed exclusively by kds
+ */
+struct drm_xocl_exec_metadata {
+	enum drm_xocl_execbuf_state state;
+	struct xocl_cmd            *active;
+};
+
+struct xocl_drm {
+	xdev_handle_t		xdev;
+	/* memory management */
+	struct drm_device       *ddev;
+	/* Memory manager array, one per DDR channel */
+	struct drm_mm           **mm;
+	struct mutex            mm_lock;
+	struct drm_xocl_mm_stat **mm_usage_stat;
+	u64                     *mm_p2p_off;
+	DECLARE_HASHTABLE(mm_range, 6);
+};
+
+struct drm_xocl_bo {
+	/* drm base object */
+	struct drm_gem_object base;
+	struct drm_mm_node   *mm_node;
+	struct drm_xocl_exec_metadata metadata;
+	struct page         **pages;
+	struct sg_table      *sgt;
+	void                 *vmapping;
+	void                 *bar_vmapping;
+	struct dma_buf                  *dmabuf;
+	const struct vm_operations_struct *dmabuf_vm_ops;
+	unsigned int          dma_nsg;
+	unsigned int          flags;
+	unsigned int          type;
+};
+
+struct drm_xocl_unmgd {
+	struct page         **pages;
+	struct sg_table      *sgt;
+	unsigned int          npages;
+	unsigned int          flags;
+};
+
+struct drm_xocl_bo *xocl_drm_create_bo(struct xocl_drm *drm_p, uint64_t unaligned_size,
+				       unsigned int user_flags, unsigned int user_type);
+void xocl_drm_free_bo(struct drm_gem_object *obj);
+
+
+void xocl_mm_get_usage_stat(struct xocl_drm *drm_p, u32 ddr,
+			    struct drm_xocl_mm_stat *pstat);
+void xocl_mm_update_usage_stat(struct xocl_drm *drm_p, u32 ddr,
+			       u64 size, int count);
+int xocl_mm_insert_node(struct xocl_drm *drm_p, u32 ddr,
+			struct drm_mm_node *node, u64 size);
+void *xocl_drm_init(xdev_handle_t xdev);
+void xocl_drm_fini(struct xocl_drm *drm_p);
+uint32_t xocl_get_shared_ddr(struct xocl_drm *drm_p, struct mem_data *m_data);
+int xocl_init_mem(struct xocl_drm *drm_p);
+void xocl_cleanup_mem(struct xocl_drm *drm_p);
+int xocl_check_topology(struct xocl_drm *drm_p);
+
+int xocl_gem_fault(struct vm_fault *vmf);
+
+static inline struct drm_xocl_bo *to_xocl_bo(struct drm_gem_object *bo)
+{
+	return (struct drm_xocl_bo *)bo;
+}
+
+int xocl_init_unmgd(struct drm_xocl_unmgd *unmgd, uint64_t data_ptr,
+		    uint64_t size, u32 write);
+void xocl_finish_unmgd(struct drm_xocl_unmgd *unmgd);
+
+#endif
diff --git a/drivers/gpu/drm/xocl/xocl_drv.h b/drivers/gpu/drm/xocl/xocl_drv.h
new file mode 100644
index 000000000000..c67f3f03feae
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xocl_drv.h
@@ -0,0 +1,783 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Lizhi.Hou@Xilinx.com
+ */
+
+#ifndef	_XOCL_DRV_H_
+#define	_XOCL_DRV_H_
+
+#include <linux/version.h>
+#include <drm/drmP.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_mm.h>
+#include "xclbin.h"
+#include "devices.h"
+#include <drm/xocl_drm.h>
+#include <drm/xmgmt_drm.h>
+
+static inline void xocl_memcpy_fromio(void *buf, void *iomem, u32 size)
+{
+	int i;
+
+	BUG_ON(size & 0x3);
+
+	for (i = 0; i < size / 4; i++)
+		((u32 *)buf)[i] = ioread32((char *)(iomem) + sizeof(u32) * i);
+}
+
+static inline void xocl_memcpy_toio(void *iomem, void *buf, u32 size)
+{
+	int i;
+
+	BUG_ON(size & 0x3);
+
+	for (i = 0; i < size / 4; i++)
+		iowrite32(((u32 *)buf)[i], ((char *)(iomem) + sizeof(u32) * i));
+}
+
+#define	XOCL_MODULE_NAME	"xocl"
+#define	XCLMGMT_MODULE_NAME	"xclmgmt"
+#define	ICAP_XCLBIN_V2			"xclbin2"
+
+#define XOCL_MAX_DEVICES	16
+#define XOCL_EBUF_LEN           512
+#define xocl_sysfs_error(xdev, fmt, args...)	 \
+	snprintf(((struct xocl_dev_core *)xdev)->ebuf, XOCL_EBUF_LEN,	\
+		 fmt, ##args)
+#define MAX_M_COUNT      64
+
+#define	XDEV2DEV(xdev)		(&XDEV(xdev)->pdev->dev)
+
+#define xocl_err(dev, fmt, args...)			\
+	dev_err(dev, "%s: "fmt, __func__, ##args)
+#define xocl_info(dev, fmt, args...)			\
+	dev_info(dev, "%s: "fmt, __func__, ##args)
+#define xocl_dbg(dev, fmt, args...)			\
+	dev_dbg(dev, "%s: "fmt, __func__, ##args)
+
+#define xocl_xdev_info(xdev, fmt, args...)		\
+	xocl_info(XDEV2DEV(xdev), fmt, ##args)
+#define xocl_xdev_err(xdev, fmt, args...)		\
+	xocl_err(XDEV2DEV(xdev), fmt, ##args)
+#define xocl_xdev_dbg(xdev, fmt, args...)		\
+	xocl_dbg(XDEV2DEV(xdev), fmt, ##args)
+
+#define	XOCL_DRV_VER_NUM(ma, mi, p)		\
+	((ma) * 1000 + (mi) * 100 + (p))
+
+#define	XOCL_READ_REG32(addr)		\
+	ioread32(addr)
+#define	XOCL_WRITE_REG32(val, addr)	\
+	iowrite32(val, addr)
+
+/* xclbin helpers */
+#define sizeof_sect(sect, data) \
+({ \
+	size_t ret; \
+	size_t data_size; \
+	data_size = (sect) ? sect->m_count * sizeof(typeof(sect->data)) : 0; \
+	ret = (sect) ? offsetof(typeof(*sect), data) + data_size : 0; \
+	(ret); \
+})
+
+#define	XOCL_PL_TO_PCI_DEV(pldev)		\
+	to_pci_dev(pldev->dev.parent)
+
+#define XOCL_PL_DEV_TO_XDEV(pldev) \
+	pci_get_drvdata(XOCL_PL_TO_PCI_DEV(pldev))
+
+#define	XOCL_QDMA_USER_BAR	2
+#define	XOCL_DSA_VERSION(xdev)			\
+	(XDEV(xdev)->priv.dsa_ver)
+
+#define XOCL_DSA_IS_MPSOC(xdev)                \
+	(XDEV(xdev)->priv.mpsoc)
+
+#define	XOCL_DEV_ID(pdev)			\
+	((pci_domain_nr(pdev->bus) << 16) |	\
+	PCI_DEVID(pdev->bus->number, pdev->devfn))
+
+#define XOCL_ARE_HOP 0x400000000ull
+
+#define	XOCL_XILINX_VEN		0x10EE
+#define	XOCL_CHARDEV_REG_COUNT	16
+
+#define INVALID_SUBDEVICE ~0U
+
+#define XOCL_INVALID_MINOR -1
+
+extern struct class *xrt_class;
+
+struct drm_xocl_bo;
+struct client_ctx;
+
+struct xocl_subdev {
+	struct platform_device *pldev;
+	void                   *ops;
+};
+
+struct xocl_subdev_private {
+	int		id;
+	bool		is_multi;
+	char		priv_data[1];
+};
+
+#define	XOCL_GET_SUBDEV_PRIV(dev)				\
+	(((struct xocl_subdev_private *)dev_get_platdata(dev))->priv_data)
+
+typedef	void *xdev_handle_t;
+
+struct xocl_pci_funcs {
+	int (*intr_config)(xdev_handle_t xdev, u32 intr, bool enable);
+	int (*intr_register)(xdev_handle_t xdev, u32 intr,
+		irq_handler_t handler, void *arg);
+	int (*reset)(xdev_handle_t xdev);
+};
+
+#define	XDEV(dev)	((struct xocl_dev_core *)(dev))
+#define	XDEV_PCIOPS(xdev)	(XDEV(xdev)->pci_ops)
+
+#define	xocl_user_interrupt_config(xdev, intr, en)	\
+	XDEV_PCIOPS(xdev)->intr_config(xdev, intr, en)
+#define	xocl_user_interrupt_reg(xdev, intr, handler, arg)	\
+	XDEV_PCIOPS(xdev)->intr_register(xdev, intr, handler, arg)
+#define xocl_reset(xdev)			\
+	(XDEV_PCIOPS(xdev)->reset ? XDEV_PCIOPS(xdev)->reset(xdev) : \
+	-ENODEV)
+
+struct xocl_health_thread_arg {
+	int (*health_cb)(void *arg);
+	void		*arg;
+	u32		interval;    /* ms */
+	struct device	*dev;
+};
+
+struct xocl_drvinst_proc {
+	struct list_head	link;
+	u32			pid;
+	u32			count;
+};
+
+struct xocl_drvinst {
+	struct device		*dev;
+	u32			size;
+	atomic_t		ref;
+	struct completion	comp;
+	struct list_head	open_procs;
+	void			*file_dev;
+	char			data[1];
+};
+
+struct xocl_dev_core {
+	struct pci_dev         *pdev;
+	int			dev_minor;
+	struct xocl_subdev	subdevs[XOCL_SUBDEV_NUM];
+	u32			subdev_num;
+	struct xocl_pci_funcs  *pci_ops;
+
+	u32			bar_idx;
+	void			* __iomem bar_addr;
+	resource_size_t		bar_size;
+	resource_size_t		feature_rom_offset;
+
+	u32			intr_bar_idx;
+	void			* __iomem intr_bar_addr;
+	resource_size_t		intr_bar_size;
+
+	struct task_struct     *health_thread;
+	struct xocl_health_thread_arg thread_arg;
+
+	struct xocl_board_private priv;
+
+	char			ebuf[XOCL_EBUF_LEN + 1];
+
+	bool			offline;
+};
+
+enum data_kind {
+	MIG_CALIB,
+	DIMM0_TEMP,
+	DIMM1_TEMP,
+	DIMM2_TEMP,
+	DIMM3_TEMP,
+	FPGA_TEMP,
+	VCC_BRAM,
+	CLOCK_FREQ_0,
+	CLOCK_FREQ_1,
+	FREQ_COUNTER_0,
+	FREQ_COUNTER_1,
+	VOL_12V_PEX,
+	VOL_12V_AUX,
+	CUR_12V_PEX,
+	CUR_12V_AUX,
+	SE98_TEMP0,
+	SE98_TEMP1,
+	SE98_TEMP2,
+	FAN_TEMP,
+	FAN_RPM,
+	VOL_3V3_PEX,
+	VOL_3V3_AUX,
+	VPP_BTM,
+	VPP_TOP,
+	VOL_5V5_SYS,
+	VOL_1V2_TOP,
+	VOL_1V2_BTM,
+	VOL_1V8,
+	VCC_0V9A,
+	VOL_12V_SW,
+	VTT_MGTA,
+	VOL_VCC_INT,
+	CUR_VCC_INT,
+	IDCODE,
+	IPLAYOUT_AXLF,
+	MEMTOPO_AXLF,
+	CONNECTIVITY_AXLF,
+	DEBUG_IPLAYOUT_AXLF,
+	PEER_CONN,
+	XCLBIN_UUID,
+};
+
+
+#define	XOCL_DSA_PCI_RESET_OFF(xdev_hdl)			\
+	(((struct xocl_dev_core *)xdev_hdl)->priv.flags &	\
+	XOCL_DSAFLAG_PCI_RESET_OFF)
+#define	XOCL_DSA_MB_SCHE_OFF(xdev_hdl)			\
+	(((struct xocl_dev_core *)xdev_hdl)->priv.flags &	\
+	XOCL_DSAFLAG_MB_SCHE_OFF)
+#define	XOCL_DSA_AXILITE_FLUSH_REQUIRED(xdev_hdl)			\
+	(((struct xocl_dev_core *)xdev_hdl)->priv.flags &	\
+	XOCL_DSAFLAG_AXILITE_FLUSH)
+
+#define	XOCL_DSA_XPR_ON(xdev_hdl)		\
+	(((struct xocl_dev_core *)xdev_hdl)->priv.xpr)
+
+
+#define	SUBDEV(xdev, id)	\
+	(XDEV(xdev)->subdevs[id])
+
+/* rom callbacks */
+struct xocl_rom_funcs {
+	unsigned int (*dsa_version)(struct platform_device *pdev);
+	bool (*is_unified)(struct platform_device *pdev);
+	bool (*mb_mgmt_on)(struct platform_device *pdev);
+	bool (*mb_sched_on)(struct platform_device *pdev);
+	uint32_t* (*cdma_addr)(struct platform_device *pdev);
+	u16 (*get_ddr_channel_count)(struct platform_device *pdev);
+	u64 (*get_ddr_channel_size)(struct platform_device *pdev);
+	bool (*is_are)(struct platform_device *pdev);
+	bool (*is_aws)(struct platform_device *pdev);
+	bool (*verify_timestamp)(struct platform_device *pdev, u64 timestamp);
+	u64 (*get_timestamp)(struct platform_device *pdev);
+	void (*get_raw_header)(struct platform_device *pdev, void *header);
+};
+#define ROM_DEV(xdev)	\
+	SUBDEV(xdev, XOCL_SUBDEV_FEATURE_ROM).pldev
+#define	ROM_OPS(xdev)	\
+	((struct xocl_rom_funcs *)SUBDEV(xdev, XOCL_SUBDEV_FEATURE_ROM).ops)
+#define	xocl_dsa_version(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->dsa_version(ROM_DEV(xdev)) : 0)
+#define	xocl_is_unified(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->is_unified(ROM_DEV(xdev)) : true)
+#define	xocl_mb_mgmt_on(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->mb_mgmt_on(ROM_DEV(xdev)) : false)
+#define	xocl_mb_sched_on(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->mb_sched_on(ROM_DEV(xdev)) : false)
+#define	xocl_cdma_addr(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->cdma_addr(ROM_DEV(xdev)) : 0)
+#define	xocl_get_ddr_channel_count(xdev) \
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->get_ddr_channel_count(ROM_DEV(xdev)) :\
+	0)
+#define	xocl_get_ddr_channel_size(xdev) \
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->get_ddr_channel_size(ROM_DEV(xdev)) : 0)
+#define	xocl_is_are(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->is_are(ROM_DEV(xdev)) : false)
+#define	xocl_is_aws(xdev)		\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->is_aws(ROM_DEV(xdev)) : false)
+#define	xocl_verify_timestamp(xdev, ts)	\
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->verify_timestamp(ROM_DEV(xdev), ts) : \
+	false)
+#define	xocl_get_timestamp(xdev) \
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->get_timestamp(ROM_DEV(xdev)) : 0)
+#define	xocl_get_raw_header(xdev, header) \
+	(ROM_DEV(xdev) ? ROM_OPS(xdev)->get_raw_header(ROM_DEV(xdev), header) :\
+	NULL)
+
+/* dma callbacks */
+struct xocl_dma_funcs {
+	ssize_t (*migrate_bo)(struct platform_device *pdev,
+			      struct sg_table *sgt, u32 dir, u64 paddr, u32 channel, u64 sz);
+	int (*ac_chan)(struct platform_device *pdev, u32 dir);
+	void (*rel_chan)(struct platform_device *pdev, u32 dir, u32 channel);
+	u32 (*get_chan_count)(struct platform_device *pdev);
+	u64 (*get_chan_stat)(struct platform_device *pdev, u32 channel,
+			     u32 write);
+	u64 (*get_str_stat)(struct platform_device *pdev, u32 q_idx);
+	int (*user_intr_config)(struct platform_device *pdev, u32 intr, bool en);
+	int (*user_intr_register)(struct platform_device *pdev, u32 intr,
+				  irq_handler_t handler, void *arg, int event_fd);
+	int (*user_intr_unreg)(struct platform_device *pdev, u32 intr);
+	void *(*get_drm_handle)(struct platform_device *pdev);
+};
+
+#define DMA_DEV(xdev)	\
+	SUBDEV(xdev, XOCL_SUBDEV_DMA).pldev
+#define	DMA_OPS(xdev)	\
+	((struct xocl_dma_funcs *)SUBDEV(xdev, XOCL_SUBDEV_DMA).ops)
+#define	xocl_migrate_bo(xdev, sgt, write, paddr, chan, len)	\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->migrate_bo(DMA_DEV(xdev), \
+	sgt, write, paddr, chan, len) : 0)
+#define	xocl_acquire_channel(xdev, dir)		\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->ac_chan(DMA_DEV(xdev), dir) : \
+	-ENODEV)
+#define	xocl_release_channel(xdev, dir, chan)	\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->rel_chan(DMA_DEV(xdev), dir, \
+	chan) : NULL)
+#define	xocl_get_chan_count(xdev)		\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->get_chan_count(DMA_DEV(xdev)) \
+	: 0)
+#define	xocl_get_chan_stat(xdev, chan, write)		\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->get_chan_stat(DMA_DEV(xdev), \
+	chan, write) : 0)
+#define xocl_dma_intr_config(xdev, irq, en)			\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->user_intr_config(DMA_DEV(xdev), \
+	irq, en) : -ENODEV)
+#define xocl_dma_intr_register(xdev, irq, handler, arg, event_fd)	\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->user_intr_register(DMA_DEV(xdev), \
+	irq, handler, arg, event_fd) : -ENODEV)
+#define xocl_dma_intr_unreg(xdev, irq)				\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->user_intr_unreg(DMA_DEV(xdev),	\
+	irq) : -ENODEV)
+#define	xocl_dma_get_drm_handle(xdev)				\
+	(DMA_DEV(xdev) ? DMA_OPS(xdev)->get_drm_handle(DMA_DEV(xdev)) : \
+	NULL)
+
+/* mb_scheduler callbacks */
+struct xocl_mb_scheduler_funcs {
+	int (*create_client)(struct platform_device *pdev, void **priv);
+	void (*destroy_client)(struct platform_device *pdev, void **priv);
+	uint (*poll_client)(struct platform_device *pdev, struct file *filp,
+		poll_table *wait, void *priv);
+	int (*client_ioctl)(struct platform_device *pdev, int op,
+		void *data, void *drm_filp);
+	int (*stop)(struct platform_device *pdev);
+	int (*reset)(struct platform_device *pdev);
+};
+#define	MB_SCHEDULER_DEV(xdev)	\
+	SUBDEV(xdev, XOCL_SUBDEV_MB_SCHEDULER).pldev
+#define	MB_SCHEDULER_OPS(xdev)	\
+	((struct xocl_mb_scheduler_funcs *)SUBDEV(xdev,	\
+		XOCL_SUBDEV_MB_SCHEDULER).ops)
+#define	xocl_exec_create_client(xdev, priv)		\
+	(MB_SCHEDULER_DEV(xdev) ?			\
+	MB_SCHEDULER_OPS(xdev)->create_client(MB_SCHEDULER_DEV(xdev), priv) : \
+	-ENODEV)
+#define	xocl_exec_destroy_client(xdev, priv)		\
+	(MB_SCHEDULER_DEV(xdev) ?			\
+	MB_SCHEDULER_OPS(xdev)->destroy_client(MB_SCHEDULER_DEV(xdev), priv) : \
+	NULL)
+#define	xocl_exec_poll_client(xdev, filp, wait, priv)		\
+	(MB_SCHEDULER_DEV(xdev) ?					\
+	MB_SCHEDULER_OPS(xdev)->poll_client(MB_SCHEDULER_DEV(xdev), filp, \
+	wait, priv) : 0)
+#define	xocl_exec_client_ioctl(xdev, op, data, drm_filp)		\
+	(MB_SCHEDULER_DEV(xdev) ?				\
+	MB_SCHEDULER_OPS(xdev)->client_ioctl(MB_SCHEDULER_DEV(xdev),	\
+	op, data, drm_filp) : -ENODEV)
+#define	xocl_exec_stop(xdev)		\
+	(MB_SCHEDULER_DEV(xdev) ?					\
+	 MB_SCHEDULER_OPS(xdev)->stop(MB_SCHEDULER_DEV(xdev)) : \
+	 -ENODEV)
+#define	xocl_exec_reset(xdev)		\
+	(MB_SCHEDULER_DEV(xdev) ?					\
+	 MB_SCHEDULER_OPS(xdev)->reset(MB_SCHEDULER_DEV(xdev)) : \
+	 -ENODEV)
+
+#define XOCL_MEM_TOPOLOGY(xdev)						\
+	((struct mem_topology *)					\
+	 xocl_icap_get_data(xdev, MEMTOPO_AXLF))
+#define XOCL_IP_LAYOUT(xdev)						\
+	((struct ip_layout *)						\
+	 xocl_icap_get_data(xdev, IPLAYOUT_AXLF))
+
+#define	XOCL_IS_DDR_USED(xdev, ddr)					\
+	(XOCL_MEM_TOPOLOGY(xdev)->m_mem_data[ddr].m_used == 1)
+#define	XOCL_DDR_COUNT_UNIFIED(xdev)		\
+	(XOCL_MEM_TOPOLOGY(xdev) ? XOCL_MEM_TOPOLOGY(xdev)->m_count : 0)
+#define	XOCL_DDR_COUNT(xdev)			\
+	((xocl_is_unified(xdev) ? XOCL_DDR_COUNT_UNIFIED(xdev) :	\
+	xocl_get_ddr_channel_count(xdev)))
+
+/* sysmon callbacks */
+enum {
+	XOCL_SYSMON_PROP_TEMP,
+	XOCL_SYSMON_PROP_TEMP_MAX,
+	XOCL_SYSMON_PROP_TEMP_MIN,
+	XOCL_SYSMON_PROP_VCC_INT,
+	XOCL_SYSMON_PROP_VCC_INT_MAX,
+	XOCL_SYSMON_PROP_VCC_INT_MIN,
+	XOCL_SYSMON_PROP_VCC_AUX,
+	XOCL_SYSMON_PROP_VCC_AUX_MAX,
+	XOCL_SYSMON_PROP_VCC_AUX_MIN,
+	XOCL_SYSMON_PROP_VCC_BRAM,
+	XOCL_SYSMON_PROP_VCC_BRAM_MAX,
+	XOCL_SYSMON_PROP_VCC_BRAM_MIN,
+};
+struct xocl_sysmon_funcs {
+	int (*get_prop)(struct platform_device *pdev, u32 prop, void *val);
+};
+#define	SYSMON_DEV(xdev)	\
+	SUBDEV(xdev, XOCL_SUBDEV_SYSMON).pldev
+#define	SYSMON_OPS(xdev)	\
+	((struct xocl_sysmon_funcs *)SUBDEV(xdev,			\
+		XOCL_SUBDEV_SYSMON).ops)
+#define	xocl_sysmon_get_prop(xdev, prop, val)		\
+	(SYSMON_DEV(xdev) ? SYSMON_OPS(xdev)->get_prop(SYSMON_DEV(xdev), \
+	prop, val) : -ENODEV)
+
+/* firewall callbacks */
+enum {
+	XOCL_AF_PROP_TOTAL_LEVEL,
+	XOCL_AF_PROP_STATUS,
+	XOCL_AF_PROP_LEVEL,
+	XOCL_AF_PROP_DETECTED_STATUS,
+	XOCL_AF_PROP_DETECTED_LEVEL,
+	XOCL_AF_PROP_DETECTED_TIME,
+};
+struct xocl_firewall_funcs {
+	int (*get_prop)(struct platform_device *pdev, u32 prop, void *val);
+	int (*clear_firewall)(struct platform_device *pdev);
+	u32 (*check_firewall)(struct platform_device *pdev, int *level);
+};
+#define AF_DEV(xdev)	\
+	SUBDEV(xdev, XOCL_SUBDEV_AF).pldev
+#define	AF_OPS(xdev)	\
+	((struct xocl_firewall_funcs *)SUBDEV(xdev,	\
+	XOCL_SUBDEV_AF).ops)
+#define	xocl_af_get_prop(xdev, prop, val)		\
+	(AF_DEV(xdev) ? AF_OPS(xdev)->get_prop(AF_DEV(xdev), prop, val) : \
+	-ENODEV)
+#define	xocl_af_check(xdev, level)			\
+	(AF_DEV(xdev) ? AF_OPS(xdev)->check_firewall(AF_DEV(xdev), level) : 0)
+#define	xocl_af_clear(xdev)				\
+	(AF_DEV(xdev) ? AF_OPS(xdev)->clear_firewall(AF_DEV(xdev)) : -ENODEV)
+
+/* microblaze callbacks */
+struct xocl_mb_funcs {
+	void (*reset)(struct platform_device *pdev);
+	int (*stop)(struct platform_device *pdev);
+	int (*load_mgmt_image)(struct platform_device *pdev, const char *buf,
+		u32 len);
+	int (*load_sche_image)(struct platform_device *pdev, const char *buf,
+		u32 len);
+	int (*get_data)(struct platform_device *pdev, enum data_kind kind);
+};
+
+struct xocl_dna_funcs {
+	u32 (*status)(struct platform_device *pdev);
+	u32 (*capability)(struct platform_device *pdev);
+	void (*write_cert)(struct platform_device *pdev, const uint32_t *buf, u32 len);
+};
+
+#define	XMC_DEV(xdev)		\
+	SUBDEV(xdev, XOCL_SUBDEV_XMC).pldev
+#define	XMC_OPS(xdev)		\
+	((struct xocl_mb_funcs *)SUBDEV(xdev,	\
+	XOCL_SUBDEV_XMC).ops)
+
+#define	DNA_DEV(xdev)		\
+	SUBDEV(xdev, XOCL_SUBDEV_DNA).pldev
+#define	DNA_OPS(xdev)		\
+	((struct xocl_dna_funcs *)SUBDEV(xdev,	\
+	XOCL_SUBDEV_DNA).ops)
+#define	xocl_dna_status(xdev)			\
+	(DNA_DEV(xdev) ? DNA_OPS(xdev)->status(DNA_DEV(xdev)) : 0)
+#define	xocl_dna_capability(xdev)			\
+	(DNA_DEV(xdev) ? DNA_OPS(xdev)->capability(DNA_DEV(xdev)) : 2)
+#define xocl_dna_write_cert(xdev, data, len)  \
+	(DNA_DEV(xdev) ? DNA_OPS(xdev)->write_cert(DNA_DEV(xdev), data, len) : 0)
+
+#define	MB_DEV(xdev)		\
+	SUBDEV(xdev, XOCL_SUBDEV_MB).pldev
+#define	MB_OPS(xdev)		\
+	((struct xocl_mb_funcs *)SUBDEV(xdev,	\
+	XOCL_SUBDEV_MB).ops)
+#define	xocl_mb_reset(xdev)			\
+	(XMC_DEV(xdev) ? XMC_OPS(xdev)->reset(XMC_DEV(xdev)) : \
+	(MB_DEV(xdev) ? MB_OPS(xdev)->reset(MB_DEV(xdev)) : NULL))
+
+#define	xocl_mb_stop(xdev)			\
+	(XMC_DEV(xdev) ? XMC_OPS(xdev)->stop(XMC_DEV(xdev)) : \
+	(MB_DEV(xdev) ? MB_OPS(xdev)->stop(MB_DEV(xdev)) : -ENODEV))
+
+#define xocl_mb_load_mgmt_image(xdev, buf, len)		\
+	(XMC_DEV(xdev) ? XMC_OPS(xdev)->load_mgmt_image(XMC_DEV(xdev), buf, len) :\
+	(MB_DEV(xdev) ? MB_OPS(xdev)->load_mgmt_image(MB_DEV(xdev), buf, len) :\
+	-ENODEV))
+#define xocl_mb_load_sche_image(xdev, buf, len)		\
+	(XMC_DEV(xdev) ? XMC_OPS(xdev)->load_sche_image(XMC_DEV(xdev), buf, len) :\
+	(MB_DEV(xdev) ? MB_OPS(xdev)->load_sche_image(MB_DEV(xdev), buf, len) :\
+	-ENODEV))
+
+#define xocl_xmc_get_data(xdev, cmd)			\
+	(XMC_DEV(xdev) ? XMC_OPS(xdev)->get_data(XMC_DEV(xdev), cmd) : -ENODEV)
+
+/*
+ * mailbox callbacks
+ */
+enum mailbox_request {
+	MAILBOX_REQ_UNKNOWN = 0,
+	MAILBOX_REQ_TEST_READY,
+	MAILBOX_REQ_TEST_READ,
+	MAILBOX_REQ_LOCK_BITSTREAM,
+	MAILBOX_REQ_UNLOCK_BITSTREAM,
+	MAILBOX_REQ_HOT_RESET,
+	MAILBOX_REQ_FIREWALL,
+	MAILBOX_REQ_GPCTL,
+	MAILBOX_REQ_LOAD_XCLBIN_KADDR,
+	MAILBOX_REQ_LOAD_XCLBIN,
+	MAILBOX_REQ_RECLOCK,
+	MAILBOX_REQ_PEER_DATA,
+	MAILBOX_REQ_CONN_EXPL,
+};
+
+enum mb_cmd_type {
+	MB_CMD_DEFAULT = 0,
+	MB_CMD_LOAD_XCLBIN,
+	MB_CMD_RECLOCK,
+	MB_CMD_CONN_EXPL,
+	MB_CMD_LOAD_XCLBIN_KADDR,
+	MB_CMD_READ_FROM_PEER,
+};
+struct mailbox_req_bitstream_lock {
+	pid_t pid;
+	uuid_t uuid;
+};
+
+struct mailbox_subdev_peer {
+	enum data_kind kind;
+};
+
+struct mailbox_bitstream_kaddr {
+	uint64_t addr;
+};
+
+struct mailbox_gpctl {
+	enum mb_cmd_type cmd_type;
+	uint32_t data_total_len;
+	uint64_t priv_data;
+	void *data_ptr;
+};
+
+
+struct mailbox_req {
+	enum mailbox_request req;
+	uint32_t data_total_len;
+	uint64_t flags;
+	char data[0];
+};
+
+#define MB_PROT_VER_MAJOR 0
+#define MB_PROT_VER_MINOR 5
+#define MB_PROTOCOL_VER   ((MB_PROT_VER_MAJOR<<8) + MB_PROT_VER_MINOR)
+
+#define MB_PEER_CONNECTED 0x1
+#define MB_PEER_SAME_DOM  0x2
+#define MB_PEER_SAMEDOM_CONNECTED (MB_PEER_CONNECTED | MB_PEER_SAME_DOM)
+
+typedef	void (*mailbox_msg_cb_t)(void *arg, void *data, size_t len,
+	u64 msgid, int err);
+struct xocl_mailbox_funcs {
+	int (*request)(struct platform_device *pdev, void *req,
+		size_t reqlen, void *resp, size_t *resplen,
+		mailbox_msg_cb_t cb, void *cbarg);
+	int (*post)(struct platform_device *pdev, u64 req_id,
+		void *resp, size_t len);
+	int (*listen)(struct platform_device *pdev,
+		mailbox_msg_cb_t cb, void *cbarg);
+	int (*reset)(struct platform_device *pdev, bool end_of_reset);
+	int (*get_data)(struct platform_device *pdev, enum data_kind kind);
+};
+#define	MAILBOX_DEV(xdev)	SUBDEV(xdev, XOCL_SUBDEV_MAILBOX).pldev
+#define	MAILBOX_OPS(xdev)	\
+	((struct xocl_mailbox_funcs *)SUBDEV(xdev, XOCL_SUBDEV_MAILBOX).ops)
+#define MAILBOX_READY(xdev)	(MAILBOX_DEV(xdev) && MAILBOX_OPS(xdev))
+#define	xocl_peer_request(xdev, req, reqlen, resp, resplen, cb, cbarg)		\
+	(MAILBOX_READY(xdev) ? MAILBOX_OPS(xdev)->request(MAILBOX_DEV(xdev), \
+	req, reqlen, resp, resplen, cb, cbarg) : -ENODEV)
+#define	xocl_peer_response(xdev, reqid, buf, len)			\
+	(MAILBOX_READY(xdev) ? MAILBOX_OPS(xdev)->post(MAILBOX_DEV(xdev), \
+	reqid, buf, len) : -ENODEV)
+#define	xocl_peer_notify(xdev, req, reqlen)					\
+	(MAILBOX_READY(xdev) ? MAILBOX_OPS(xdev)->post(MAILBOX_DEV(xdev), 0, \
+	req, reqlen) : -ENODEV)
+#define	xocl_peer_listen(xdev, cb, cbarg)				\
+	(MAILBOX_READY(xdev) ? MAILBOX_OPS(xdev)->listen(MAILBOX_DEV(xdev), \
+	cb, cbarg) : -ENODEV)
+#define	xocl_mailbox_reset(xdev, end)				\
+	(MAILBOX_READY(xdev) ? MAILBOX_OPS(xdev)->reset(MAILBOX_DEV(xdev), \
+	end) : -ENODEV)
+#define	xocl_mailbox_get_data(xdev, kind)				\
+	(MAILBOX_READY(xdev) ? MAILBOX_OPS(xdev)->get_data(MAILBOX_DEV(xdev), kind) \
+		: -ENODEV)
+
+struct xocl_icap_funcs {
+	void (*reset_axi_gate)(struct platform_device *pdev);
+	int (*reset_bitstream)(struct platform_device *pdev);
+	int (*download_bitstream_axlf)(struct platform_device *pdev,
+		const void __user *arg);
+	int (*download_boot_firmware)(struct platform_device *pdev);
+	int (*ocl_set_freq)(struct platform_device *pdev,
+		unsigned int region, unsigned short *freqs, int num_freqs);
+	int (*ocl_get_freq)(struct platform_device *pdev,
+		unsigned int region, unsigned short *freqs, int num_freqs);
+	int (*ocl_update_clock_freq_topology)(struct platform_device *pdev, struct xclmgmt_ioc_freqscaling *freqs);
+	int (*ocl_lock_bitstream)(struct platform_device *pdev,
+		const uuid_t *uuid, pid_t pid);
+	int (*ocl_unlock_bitstream)(struct platform_device *pdev,
+		const uuid_t *uuid, pid_t pid);
+	uint64_t (*get_data)(struct platform_device *pdev,
+		enum data_kind kind);
+};
+#define	ICAP_DEV(xdev)	SUBDEV(xdev, XOCL_SUBDEV_ICAP).pldev
+#define	ICAP_OPS(xdev)							\
+	((struct xocl_icap_funcs *)SUBDEV(xdev, XOCL_SUBDEV_ICAP).ops)
+#define	xocl_icap_reset_axi_gate(xdev)					\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->reset_axi_gate(ICAP_DEV(xdev)) :		\
+	NULL)
+#define	xocl_icap_reset_bitstream(xdev)					\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->reset_bitstream(ICAP_DEV(xdev)) :		\
+	-ENODEV)
+#define	xocl_icap_download_axlf(xdev, xclbin)				\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->download_bitstream_axlf(ICAP_DEV(xdev), xclbin) : \
+	-ENODEV)
+#define	xocl_icap_download_boot_firmware(xdev)				\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->download_boot_firmware(ICAP_DEV(xdev)) :	\
+	-ENODEV)
+#define	xocl_icap_ocl_get_freq(xdev, region, freqs, num)		\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->ocl_get_freq(ICAP_DEV(xdev), region, freqs, num) : \
+	-ENODEV)
+#define	xocl_icap_ocl_update_clock_freq_topology(xdev, freqs)		\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->ocl_update_clock_freq_topology(ICAP_DEV(xdev), freqs) : \
+	-ENODEV)
+#define	xocl_icap_ocl_set_freq(xdev, region, freqs, num)		\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->ocl_set_freq(ICAP_DEV(xdev), region, freqs, num) : \
+	-ENODEV)
+#define	xocl_icap_lock_bitstream(xdev, uuid, pid)			\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->ocl_lock_bitstream(ICAP_DEV(xdev), uuid, pid) :	\
+	-ENODEV)
+#define	xocl_icap_unlock_bitstream(xdev, uuid, pid)			\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->ocl_unlock_bitstream(ICAP_DEV(xdev), uuid, pid) : \
+	-ENODEV)
+#define	xocl_icap_get_data(xdev, kind)				\
+	(ICAP_OPS(xdev) ?						\
+	ICAP_OPS(xdev)->get_data(ICAP_DEV(xdev), kind) : \
+	0)
+
+/* helper functions */
+xdev_handle_t xocl_get_xdev(struct platform_device *pdev);
+void xocl_init_dsa_priv(xdev_handle_t xdev_hdl);
+
+/* subdev functions */
+int xocl_subdev_create_multi_inst(xdev_handle_t xdev_hdl,
+	struct xocl_subdev_info *sdev_info);
+int xocl_subdev_create_one(xdev_handle_t xdev_hdl,
+	struct xocl_subdev_info *sdev_info);
+int xocl_subdev_create_by_id(xdev_handle_t xdev_hdl, int id);
+int xocl_subdev_create_all(xdev_handle_t xdev_hdl,
+			   struct xocl_subdev_info *sdev_info, u32 subdev_num);
+void xocl_subdev_destroy_one(xdev_handle_t xdev_hdl, u32 subdev_id);
+void xocl_subdev_destroy_all(xdev_handle_t xdev_hdl);
+void xocl_subdev_destroy_by_id(xdev_handle_t xdev_hdl, int id);
+
+int xocl_subdev_create_by_name(xdev_handle_t xdev_hdl, char *name);
+int xocl_subdev_destroy_by_name(xdev_handle_t xdev_hdl, char *name);
+
+int xocl_subdev_get_devinfo(uint32_t subdev_id,
+			    struct xocl_subdev_info *subdev_info, struct resource *res);
+
+void xocl_subdev_register(struct platform_device *pldev, u32 id,
+			  void *cb_funcs);
+void xocl_fill_dsa_priv(xdev_handle_t xdev_hdl, struct xocl_board_private *in);
+int xocl_xrt_version_check(xdev_handle_t xdev_hdl,
+			   struct axlf *bin_obj, bool major_only);
+int xocl_alloc_dev_minor(xdev_handle_t xdev_hdl);
+void xocl_free_dev_minor(xdev_handle_t xdev_hdl);
+
+/* context helpers */
+extern struct mutex xocl_drvinst_mutex;
+extern struct xocl_drvinst *xocl_drvinst_array[XOCL_MAX_DEVICES * 10];
+
+void *xocl_drvinst_alloc(struct device *dev, u32 size);
+void xocl_drvinst_free(void *data);
+void *xocl_drvinst_open(void *file_dev);
+void xocl_drvinst_close(void *data);
+void xocl_drvinst_set_filedev(void *data, void *file_dev);
+
+/* health thread functions */
+int health_thread_start(xdev_handle_t xdev);
+int health_thread_stop(xdev_handle_t xdev);
+
+/* init functions */
+int __init xocl_init_userpf(void);
+void xocl_fini_fini_userpf(void);
+
+int __init xocl_init_drv_user_qdma(void);
+void xocl_fini_drv_user_qdma(void);
+
+int __init xocl_init_feature_rom(void);
+void xocl_fini_feature_rom(void);
+
+int __init xocl_init_xdma(void);
+void xocl_fini_xdma(void);
+
+int __init xocl_init_qdma(void);
+void xocl_fini_qdma(void);
+
+int __init xocl_init_mb_scheduler(void);
+void xocl_fini_mb_scheduler(void);
+
+int __init xocl_init_xvc(void);
+void xocl_fini_xvc(void);
+
+int __init xocl_init_firewall(void);
+void xocl_fini_firewall(void);
+
+int __init xocl_init_sysmon(void);
+void xocl_fini_sysmon(void);
+
+int __init xocl_init_mb(void);
+void xocl_fini_mb(void);
+
+int __init xocl_init_xiic(void);
+void xocl_fini_xiic(void);
+
+int __init xocl_init_mailbox(void);
+void xocl_fini_mailbox(void);
+
+int __init xocl_init_icap(void);
+void xocl_fini_icap(void);
+
+int __init xocl_init_mig(void);
+void xocl_fini_mig(void);
+
+int __init xocl_init_xmc(void);
+void xocl_fini_xmc(void);
+
+int __init xocl_init_dna(void);
+void xocl_fini_dna(void);
+
+int __init xocl_init_fmgr(void);
+void xocl_fini_fmgr(void);
+#endif
diff --git a/drivers/gpu/drm/xocl/xocl_subdev.c b/drivers/gpu/drm/xocl/xocl_subdev.c
new file mode 100644
index 000000000000..0ade2af180b0
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xocl_subdev.c
@@ -0,0 +1,540 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include "xclfeatures.h"
+#include "xocl_drv.h"
+#include "version.h"
+
+struct xocl_subdev_array {
+	xdev_handle_t xdev_hdl;
+	int id;
+	struct platform_device **pldevs;
+	int count;
+};
+
+static DEFINE_IDA(xocl_dev_minor_ida);
+
+static DEFINE_IDA(subdev_multi_inst_ida);
+static struct xocl_dsa_vbnv_map dsa_vbnv_map[] = XOCL_DSA_VBNV_MAP;
+
+static struct platform_device *xocl_register_subdev(xdev_handle_t xdev_hdl,
+	struct xocl_subdev_info *sdev_info, bool multi_inst)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct platform_device *pldev;
+	struct xocl_subdev_private *priv;
+	resource_size_t iostart;
+	struct resource *res;
+	int sdev_id;
+	int i, retval;
+
+	if (multi_inst) {
+		sdev_id = ida_simple_get(&subdev_multi_inst_ida,
+			0, 0, GFP_KERNEL);
+		if (sdev_id < 0)
+			return ERR_PTR(-ENOENT);
+	} else {
+		sdev_id = XOCL_DEV_ID(core->pdev);
+	}
+
+	xocl_info(&core->pdev->dev, "creating subdev %s", sdev_info->name);
+	pldev = platform_device_alloc(sdev_info->name, sdev_id);
+	if (!pldev) {
+		xocl_err(&core->pdev->dev, "failed to alloc device %s",
+			sdev_info->name);
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	/* user bar is determined dynamically */
+	iostart = pci_resource_start(core->pdev, core->bar_idx);
+
+	if (sdev_info->num_res > 0) {
+		res = devm_kzalloc(&pldev->dev, sizeof(*res) *
+			sdev_info->num_res, GFP_KERNEL);
+		if (!res) {
+			xocl_err(&pldev->dev, "out of memory");
+			retval = -ENOMEM;
+			goto error;
+		}
+		memcpy(res, sdev_info->res, sizeof(*res) * sdev_info->num_res);
+
+		for (i = 0; i < sdev_info->num_res; i++) {
+			if (sdev_info->res[i].flags & IORESOURCE_MEM) {
+				res[i].start += iostart;
+				res[i].end += iostart;
+			}
+		}
+
+		retval = platform_device_add_resources(pldev,
+			res, sdev_info->num_res);
+		devm_kfree(&pldev->dev, res);
+		if (retval) {
+			xocl_err(&pldev->dev, "failed to add res");
+			goto error;
+		}
+
+		priv = vzalloc(sizeof(*priv) + sdev_info->data_len);
+		if (sdev_info->data_len > 0 && sdev_info->priv_data) {
+			memcpy(priv->priv_data, sdev_info->priv_data,
+				sdev_info->data_len);
+		}
+		priv->id = sdev_info->id;
+		priv->is_multi = multi_inst;
+		retval = platform_device_add_data(pldev,
+			priv, sizeof(*priv) + sdev_info->data_len);
+		vfree(priv);
+		if (retval) {
+			xocl_err(&pldev->dev, "failed to add data");
+			goto error;
+		}
+	}
+
+	pldev->dev.parent = &core->pdev->dev;
+
+	retval = platform_device_add(pldev);
+	if (retval) {
+		xocl_err(&pldev->dev, "failed to add device");
+		goto error;
+	}
+
+	return pldev;
+
+error:
+	platform_device_put(pldev);
+	return NULL;
+}
+
+int xocl_subdev_get_devinfo(uint32_t subdev_id,
+	struct xocl_subdev_info *info, struct resource *res)
+{
+	switch (subdev_id) {
+	case XOCL_SUBDEV_DNA:
+		*info = (struct xocl_subdev_info)XOCL_DEVINFO_DNA;
+		break;
+	case XOCL_SUBDEV_MIG:
+		*info = (struct xocl_subdev_info)XOCL_DEVINFO_MIG;
+		break;
+	default:
+		return -ENODEV;
+	}
+	/* Only support retrieving subdev info with 1 base address and no irq */
+	if (info->num_res > 1)
+		return -EINVAL;
+	*res = *info->res;
+	info->res = res;
+	return 0;
+}
+
+/*
+ * Instantiating a subdevice instance that support > 1 instances.
+ * Restrictions:
+ * 1. it can't expose interfaces for other part of driver to call
+ * 2. one type of subdevice can either be created as single instance or multiple
+ * instance subdevices, but not both.
+ */
+int xocl_subdev_create_multi_inst(xdev_handle_t xdev_hdl,
+	struct xocl_subdev_info *sdev_info)
+{
+	int ret = 0;
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct platform_device *pldev;
+
+	device_lock(&core->pdev->dev);
+	pldev = xocl_register_subdev(core, sdev_info, true);
+	if (!pldev) {
+		xocl_err(&core->pdev->dev,
+			"failed to reg multi instance subdev %s",
+			sdev_info->name);
+		ret = -ENOMEM;
+	}
+	device_unlock(&core->pdev->dev);
+
+	return ret;
+}
+
+int xocl_subdev_create_one(xdev_handle_t xdev_hdl,
+	struct xocl_subdev_info *sdev_info)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct pci_dev *pdev = core->pdev;
+	u32	id = sdev_info->id;
+	int	ret = 0;
+
+	if (core->subdevs[id].pldev)
+		return 0;
+
+	core->subdevs[id].pldev = xocl_register_subdev(core, sdev_info, false);
+	if (!core->subdevs[id].pldev) {
+		xocl_err(&pdev->dev, "failed to register subdev %s",
+			sdev_info->name);
+		ret = -EINVAL;
+		goto failed;
+	}
+	/*
+	 * force probe to avoid dependence issue. if probing
+	 * failed, it could be this device is not detected on the board.
+	 * delete the device.
+	 */
+	ret = device_attach(&core->subdevs[id].pldev->dev);
+	if (ret != 1) {
+		xocl_err(&pdev->dev, "failed to probe subdev %s, ret %d",
+			sdev_info->name, ret);
+		ret = -ENODEV;
+		goto failed;
+	}
+	xocl_info(&pdev->dev, "Created subdev %s", sdev_info->name);
+
+	return 0;
+
+failed:
+	return (ret);
+}
+
+int xocl_subdev_create_by_name(xdev_handle_t xdev_hdl, char *name)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	int i, n;
+
+	for (i = 0; i < core->priv.subdev_num; i++) {
+		n = strlen(name);
+		if (name[n - 1] == '\n')
+			n--;
+		if (!strncmp(core->priv.subdev_info[i].name, name, n))
+			break;
+	}
+	if (i == core->priv.subdev_num)
+		return -ENODEV;
+
+	return xocl_subdev_create_one(xdev_hdl,
+			&core->priv.subdev_info[i]);
+}
+
+int xocl_subdev_destroy_by_name(xdev_handle_t xdev_hdl, char *name)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	int i, n;
+
+	for (i = 0; i < core->priv.subdev_num; i++) {
+		n = strlen(name);
+		if (name[n - 1] == '\n')
+			n--;
+		if (!strncmp(core->priv.subdev_info[i].name, name, n))
+			break;
+	}
+	if (i == core->priv.subdev_num)
+		return -ENODEV;
+
+	xocl_subdev_destroy_one(xdev_hdl, core->priv.subdev_info[i].id);
+
+	return 0;
+}
+
+int xocl_subdev_create_by_id(xdev_handle_t xdev_hdl, int id)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	int i;
+
+	for (i = 0; i < core->priv.subdev_num; i++)
+		if (core->priv.subdev_info[i].id == id)
+			break;
+	if (i == core->priv.subdev_num)
+		return -ENOENT;
+
+	return xocl_subdev_create_one(xdev_hdl,
+			&core->priv.subdev_info[i]);
+}
+
+int xocl_subdev_create_all(xdev_handle_t xdev_hdl,
+	struct xocl_subdev_info *sdev_info, u32 subdev_num)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct FeatureRomHeader rom;
+	u32	id;
+	int	i, ret = 0;
+
+	/* lookup update table */
+	ret = xocl_subdev_create_one(xdev_hdl,
+		&(struct xocl_subdev_info)XOCL_DEVINFO_FEATURE_ROM);
+	if (ret)
+		goto failed;
+
+	for (i = 0; i < ARRAY_SIZE(dsa_vbnv_map); i++) {
+		xocl_get_raw_header(core, &rom);
+		if ((core->pdev->vendor == dsa_vbnv_map[i].vendor ||
+			dsa_vbnv_map[i].vendor == (u16)PCI_ANY_ID) &&
+			(core->pdev->device == dsa_vbnv_map[i].device ||
+			dsa_vbnv_map[i].device == (u16)PCI_ANY_ID) &&
+			(core->pdev->subsystem_device ==
+			dsa_vbnv_map[i].subdevice ||
+			dsa_vbnv_map[i].subdevice == (u16)PCI_ANY_ID) &&
+			!strncmp(rom.VBNVName, dsa_vbnv_map[i].vbnv,
+			sizeof(rom.VBNVName))) {
+			sdev_info = dsa_vbnv_map[i].priv_data->subdev_info;
+			subdev_num = dsa_vbnv_map[i].priv_data->subdev_num;
+			xocl_fill_dsa_priv(xdev_hdl, dsa_vbnv_map[i].priv_data);
+			break;
+		}
+	}
+
+	core->subdev_num = subdev_num;
+
+	/* create subdevices */
+	for (i = 0; i < core->subdev_num; i++) {
+		id = sdev_info[i].id;
+		if (core->subdevs[id].pldev)
+			continue;
+
+		ret = xocl_subdev_create_one(xdev_hdl, &sdev_info[i]);
+		if (ret)
+			goto failed;
+	}
+
+	return 0;
+
+failed:
+	xocl_subdev_destroy_all(xdev_hdl);
+	return ret;
+}
+
+void xocl_subdev_destroy_one(xdev_handle_t xdev_hdl, uint32_t subdev_id)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+
+	if (subdev_id == INVALID_SUBDEVICE)
+		return;
+	if (core->subdevs[subdev_id].pldev) {
+		device_release_driver(&core->subdevs[subdev_id].pldev->dev);
+		platform_device_unregister(core->subdevs[subdev_id].pldev);
+		core->subdevs[subdev_id].pldev = NULL;
+	}
+}
+
+static int match_multi_inst_subdevs(struct device *dev, void *data)
+{
+	struct xocl_subdev_array *subdevs = (struct xocl_subdev_array *)data;
+	struct xocl_dev_core *core = (struct xocl_dev_core *)subdevs->xdev_hdl;
+	struct platform_device *pldev = to_platform_device(dev);
+	struct xocl_subdev_private *priv = dev_get_platdata(dev);
+
+	if (dev->parent == &core->pdev->dev &&
+		priv && priv->is_multi) {
+		if (subdevs->pldevs != NULL)
+			subdevs->pldevs[subdevs->count] = pldev;
+		subdevs->count++;
+	}
+
+	return 0;
+}
+
+static int match_subdev_by_id(struct device *dev, void *data)
+{
+	struct xocl_subdev_array *subdevs = (struct xocl_subdev_array *)data;
+	struct xocl_dev_core *core = (struct xocl_dev_core *)subdevs->xdev_hdl;
+	struct xocl_subdev_private *priv = dev_get_platdata(dev);
+
+	if (dev->parent == &core->pdev->dev &&
+		priv && priv->id == subdevs->id) {
+		if (subdevs->pldevs != NULL)
+			subdevs->pldevs[subdevs->count] =
+				to_platform_device(dev);
+		subdevs->count++;
+	}
+
+	return 0;
+}
+static void xocl_subdev_destroy_common(xdev_handle_t xdev_hdl,
+	int (*match)(struct device *dev, void *data),
+	struct xocl_subdev_array *subdevs)
+{
+	int i;
+	struct xocl_subdev_private *priv;
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+
+	bus_for_each_dev(&platform_bus_type, NULL, subdevs,
+		match);
+	if (subdevs->count == 0)
+		return;
+
+	subdevs->pldevs = vzalloc(sizeof(*subdevs->pldevs) * subdevs->count);
+	if (!subdevs->pldevs)
+		return;
+	subdevs->count = 0;
+
+	bus_for_each_dev(&platform_bus_type, NULL, subdevs,
+		match);
+
+	for (i = 0; i < subdevs->count; i++) {
+		priv = dev_get_platdata(&subdevs->pldevs[i]->dev);
+		if (priv->is_multi)
+			ida_simple_remove(&subdev_multi_inst_ida,
+				subdevs->pldevs[i]->id);
+		else
+			core->subdevs[subdevs->id].pldev = NULL;
+		device_release_driver(&subdevs->pldevs[i]->dev);
+		platform_device_unregister(subdevs->pldevs[i]);
+	}
+
+	vfree(subdevs->pldevs);
+}
+
+void xocl_subdev_destroy_by_id(xdev_handle_t xdev_hdl, int id)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct xocl_subdev_array subdevs;
+
+	memset(&subdevs, 0, sizeof(subdevs));
+	subdevs.xdev_hdl = xdev_hdl;
+	subdevs.id = id;
+
+	device_lock(&core->pdev->dev);
+	xocl_subdev_destroy_common(xdev_hdl,
+		match_subdev_by_id, &subdevs);
+	device_unlock(&core->pdev->dev);
+}
+void xocl_subdev_destroy_all(xdev_handle_t xdev_hdl)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct xocl_subdev_array subdevs;
+	int	i;
+
+	memset(&subdevs, 0, sizeof(subdevs));
+	subdevs.xdev_hdl = xdev_hdl;
+
+	xocl_subdev_destroy_common(xdev_hdl,
+		match_multi_inst_subdevs, &subdevs);
+
+	for (i = ARRAY_SIZE(core->subdevs) - 1; i >= 0; i--)
+		xocl_subdev_destroy_one(xdev_hdl, i);
+
+	core->subdev_num = 0;
+}
+
+void xocl_subdev_register(struct platform_device *pldev, u32 id,
+	void *cb_funcs)
+{
+	struct xocl_dev_core		*core;
+
+	BUG_ON(id >= XOCL_SUBDEV_NUM);
+	core = xocl_get_xdev(pldev);
+	BUG_ON(!core);
+
+	core->subdevs[id].ops = cb_funcs;
+}
+
+xdev_handle_t xocl_get_xdev(struct platform_device *pdev)
+{
+	struct device *dev;
+
+	dev = pdev->dev.parent;
+
+	return dev ? pci_get_drvdata(to_pci_dev(dev)) : NULL;
+}
+
+void xocl_fill_dsa_priv(xdev_handle_t xdev_hdl, struct xocl_board_private *in)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+	struct pci_dev *pdev = core->pdev;
+	unsigned int i;
+
+	memset(&core->priv, 0, sizeof(core->priv));
+	/*
+	 * follow xilinx device id, subsystem id codeing rules to set dsa
+	 * private data. And they can be overwrited in subdev header file
+	 */
+	if ((pdev->device >> 5) & 0x1)
+		core->priv.xpr = true;
+
+	core->priv.dsa_ver = pdev->subsystem_device & 0xff;
+
+	/* data defined in subdev header */
+	core->priv.subdev_info = in->subdev_info;
+	core->priv.subdev_num = in->subdev_num;
+	core->priv.flags = in->flags;
+	core->priv.flash_type = in->flash_type;
+	core->priv.board_name = in->board_name;
+	core->priv.mpsoc = in->mpsoc;
+	if (in->flags & XOCL_DSAFLAG_SET_DSA_VER)
+		core->priv.dsa_ver = in->dsa_ver;
+	if (in->flags & XOCL_DSAFLAG_SET_XPR)
+		core->priv.xpr = in->xpr;
+
+	for (i = 0; i < in->subdev_num; i++) {
+		if (in->subdev_info[i].id == XOCL_SUBDEV_FEATURE_ROM) {
+			core->feature_rom_offset =
+				in->subdev_info[i].res[0].start;
+			break;
+		}
+	}
+}
+
+int xocl_xrt_version_check(xdev_handle_t xdev_hdl,
+	struct axlf *bin_obj, bool major_only)
+{
+	u32 major, minor, patch;
+	/* check runtime version:
+	 *    1. if it is 0.0.xxxx, this implies old xclbin,
+	 *       we pass the check anyway.
+	 *    2. compare major and minor, returns error if it does not match.
+	 */
+	if (sscanf(xrt_build_version, "%d.%d.%d", &major, &minor, &patch) != 3)
+		return -ENODEV;
+
+	if (major != bin_obj->m_header.m_versionMajor &&
+		bin_obj->m_header.m_versionMajor != 0)
+		goto err;
+
+	if (major_only)
+		return 0;
+
+	if ((major != bin_obj->m_header.m_versionMajor ||
+		minor != bin_obj->m_header.m_versionMinor) &&
+		!(bin_obj->m_header.m_versionMajor == 0 &&
+		bin_obj->m_header.m_versionMinor == 0))
+		goto err;
+
+	return 0;
+
+err:
+	xocl_err(&XDEV(xdev_hdl)->pdev->dev,
+		"Mismatch xrt version, xrt %s, xclbin %d.%d.%d", xrt_build_version,
+		bin_obj->m_header.m_versionMajor,
+		bin_obj->m_header.m_versionMinor,
+		bin_obj->m_header.m_versionPatch);
+
+	return -EINVAL;
+}
+
+int xocl_alloc_dev_minor(xdev_handle_t xdev_hdl)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+
+	core->dev_minor = ida_simple_get(&xocl_dev_minor_ida,
+		0, 0, GFP_KERNEL);
+
+	if (core->dev_minor < 0) {
+		xocl_err(&core->pdev->dev, "Failed to alloc dev minor");
+		core->dev_minor = XOCL_INVALID_MINOR;
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+void xocl_free_dev_minor(xdev_handle_t xdev_hdl)
+{
+	struct xocl_dev_core *core = (struct xocl_dev_core *)xdev_hdl;
+
+	if (core->dev_minor != XOCL_INVALID_MINOR) {
+		ida_simple_remove(&xocl_dev_minor_ida, core->dev_minor);
+		core->dev_minor = XOCL_INVALID_MINOR;
+	}
+}
diff --git a/drivers/gpu/drm/xocl/xocl_thread.c b/drivers/gpu/drm/xocl/xocl_thread.c
new file mode 100644
index 000000000000..07cce3f5921b
--- /dev/null
+++ b/drivers/gpu/drm/xocl/xocl_thread.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ *  Copyright (C) 2017 Xilinx, Inc. All rights reserved.
+ *
+ *  Thread to check sysmon/firewall status for errors/issues
+ *  Author: Lizhi.Hou@Xilinx.com
+ *
+ */
+
+#include <linux/kthread.h>
+#include "xocl_drv.h"
+
+int health_thread(void *data)
+{
+	struct xocl_health_thread_arg *thread_arg = data;
+
+	while (!kthread_should_stop()) {
+		msleep_interruptible(thread_arg->interval);
+
+		thread_arg->health_cb(thread_arg->arg);
+	}
+	xocl_info(thread_arg->dev, "The health thread has terminated.");
+	return 0;
+}
+
+int health_thread_start(xdev_handle_t xdev)
+{
+	struct xocl_dev_core *core = XDEV(xdev);
+
+	xocl_info(&core->pdev->dev, "init_health_thread");
+	core->health_thread = kthread_run(health_thread, &core->thread_arg,
+		"xocl_health_thread");
+
+	if (IS_ERR(core->health_thread)) {
+		xocl_err(&core->pdev->dev, "ERROR! health thread init");
+		core->health_thread = NULL;
+		return -ENOMEM;
+	}
+
+	core->thread_arg.dev = &core->pdev->dev;
+
+	return 0;
+}
+
+int health_thread_stop(xdev_handle_t xdev)
+{
+	struct xocl_dev_core *core = XDEV(xdev);
+	int ret;
+
+	if (!core->health_thread)
+		return 0;
+
+	ret = kthread_stop(core->health_thread);
+	core->health_thread = NULL;
+
+	xocl_info(&core->pdev->dev, "fini_health_thread. ret = %d\n", ret);
+	if (ret != -EINTR) {
+		xocl_err(&core->pdev->dev, "The health thread has terminated");
+		ret = 0;
+	}
+
+	return ret;
+}
-- 
2.17.0

