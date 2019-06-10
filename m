Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C88DC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D04220862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3VQ8rZgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbfFJNpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:45:52 -0400
Received: from mail-eopbgr730084.outbound.protection.outlook.com ([40.107.73.84]:15232
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390507AbfFJNpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh2jW16gPA0Bf28c9FxfM2ZL4qlsykx3cxASQhjWgfE=;
 b=3VQ8rZgBUn2n2C9bxHzg+nXJ46cwGuQ0QZ/P8EGSyoNyjrPPzJG0OvrzEi4CjAoqwynJ9gC2UYObUbynmG+mmOfvLwkVpzBK1a6Oe5tLRykRr8Bm+DkSgYTM9Ru6X/MR46w6QrnGYU3183k8Z9Ky+7OG1mGMfQy5bZ0yV6NP9Sc=
Received: from MWHPR0201CA0021.namprd02.prod.outlook.com
 (2603:10b6:301:74::34) by SN6PR02MB4943.namprd02.prod.outlook.com
 (2603:10b6:805:99::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15; Mon, 10 Jun
 2019 13:45:39 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR0201CA0021.outlook.office365.com
 (2603:10b6:301:74::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Mon, 10 Jun 2019 13:45:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1965.12 via Frontend Transport; Mon, 10 Jun 2019 13:45:38 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 10 Jun 2019 14:45:31 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 10 Jun 2019 14:45:31 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 mark.rutland@arm.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=49286 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1haKc7-00074r-Hs; Mon, 10 Jun 2019 14:45:31 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V6 10/11] Docs: misc: xilinx_sdfec: Add documentation
Date:   Mon, 10 Jun 2019 14:45:13 +0100
Message-ID: <1560174314-124649-11-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(189003)(199004)(486006)(47776003)(60926002)(50466002)(8936002)(26826003)(11346002)(5660300002)(26005)(48376002)(2201001)(2616005)(446003)(956004)(186003)(110136005)(54906003)(106002)(246002)(30864003)(44832011)(28376004)(76176011)(6666004)(356004)(476003)(50226002)(426003)(71366001)(76130400001)(14444005)(7636002)(316002)(305945005)(16586007)(36756003)(126002)(70206006)(51416003)(7696005)(2906002)(478600001)(8676002)(36906005)(336012)(70586007)(107886003)(6306002)(4326008)(9786002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4943;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef286e9c-1e14-4c21-e357-08d6eda9ec51
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB4943;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4943:
X-MS-Exchange-PUrlCount: 2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4943C8CA278316BBEA9BCE49CB130@SN6PR02MB4943.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FLdg5yCkcBOCUbLUhyQJ4RI4/gyyvIfliAzZ4agH6dvXaOIkAELETOzwMVOtstyEna0RtQ7XuGEPG5WjeZlQo9pszJ9NNBa+MVdngeDkCMpHBGn6Ljm+W1WmMs4FLGZwrsC+aqRAQK47XF5Lt3vvtyS4SZJasfgxPa8lePgfHOmejQPrX1p3ZHBxS6FbeJ8msRjh4IhoHkz1O4tLLkj0HfFN3WSSinyLwp3/EaJq/TS29TCRVIQe60aFGwBVXN5z3CHYQyUGF1ZO7cDSeGuHYHz5MRNNqB5KLjVPvggly263Y3Xj2hVbXZ+aeMtRdBQLaD5IN8hLmcflIibtUzpM/39ofcwR9KLFI+siM2VDsKdnVQls5Dsc9t2lQVPGUQGEp3rLFdR0a/qE/4eSP6bi1egc///WGNmqgyakkwLlFl4=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 13:45:38.7938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef286e9c-1e14-4c21-e357-08d6eda9ec51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD-FEC driver documentation.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 Documentation/misc-devices/index.rst        |   1 +
 Documentation/misc-devices/xilinx_sdfec.rst | 291 ++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 Documentation/misc-devices/xilinx_sdfec.rst

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index dfd1f45..b5b4757 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -15,3 +15,4 @@ fit into other categories.
    :maxdepth: 2
 
    ibmvmc
+   xilinx_sdfec
diff --git a/Documentation/misc-devices/xilinx_sdfec.rst b/Documentation/misc-devices/xilinx_sdfec.rst
new file mode 100644
index 0000000..87966e3
--- /dev/null
+++ b/Documentation/misc-devices/xilinx_sdfec.rst
@@ -0,0 +1,291 @@
+.. SPDX-License-Identifier: GPL-2.0+
+====================
+Xilinx SD-FEC Driver
+====================
+
+Overview
+========
+
+This driver supports SD-FEC Integrated Block for Zynq |Ultrascale+ (TM)| RFSoCs.
+
+.. |Ultrascale+ (TM)| unicode:: Ultrascale+ U+2122
+   .. with trademark sign
+
+For a full description of SD-FEC core features, see the `SD-FEC Product Guide (PG256) <https://www.xilinx.com/cgi-bin/docs/ipdoc?c=sd_fec;v=latest;d=pg256-sdfec-integrated-block.pdf>`_
+
+This driver supports the following features:
+
+  - Retrieval of the Integrated Block configuration and status information
+  - Configuration of LDPC codes
+  - Configuration of Turbo decoding
+  - Monitoring errors
+
+Missing features, known issues, and limitations of the SD-FEC driver are as
+follows:
+
+  - Only allows a single open file handler to any instance of the driver at any time
+  - Reset of the SD-FEC Integrated Block is not controlled by this driver
+  - Does not support shared LDPC code table wraparound
+
+The device tree entry is described in:
+`linux-xlnx/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt <https://github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetree/bindings/misc/xlnx%2Csd-fec.txt>`_
+
+
+Modes of Operation
+------------------
+
+The driver works with the SD-FEC core in two modes of operation:
+
+  - Run-time configuration
+  - Programmable Logic (PL) initialization
+
+
+Run-time Configuration
+~~~~~~~~~~~~~~~~~~~~~~
+
+For Run-time configuration the role of driver is to allow the software application to do the following:
+
+	- Load the configuration parameters for either Turbo decode or LDPC encode or decode
+	- Activate the SD-FEC core
+	- Monitor the SD-FEC core for errors
+	- Retrieve the status and configuration of the SD-FEC core
+
+Programmable Logic (PL) Initialization
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For PL initialization, supporting logic loads configuration parameters for either
+the Turbo decode or LDPC encode or decode.  The role of the driver is to allow
+the software application to do the following:
+
+	- Activate the SD-FEC core
+	- Monitor the SD-FEC core for errors
+	- Retrieve the status and configuration of the SD-FEC core
+
+
+Driver Structure
+================
+
+The driver provides a platform device where the ``probe`` and ``remove``
+operations are provided.
+
+  - probe: Updates configuration register with device-tree entries plus determines the current activate state of the core, for example, is the core bypassed or has the core been started.
+
+
+The driver defines the following driver file operations to provide user
+application interfaces:
+
+  - open: Implements restriction that only a single file descriptor can be open per SD-FEC instance at any time
+  - release: Allows another file descriptor to be open, that is after current file descriptor is closed
+  - poll: Provides a method to monitor for SD-FEC Error events
+  - unlocked_ioctl: Provides the the following ioctl commands that allows the application configure the SD-FEC core:
+
+		- :c:macro:`XSDFEC_START_DEV`
+		- :c:macro:`XSDFEC_STOP_DEV`
+		- :c:macro:`XSDFEC_GET_STATUS`
+		- :c:macro:`XSDFEC_SET_IRQ`
+		- :c:macro:`XSDFEC_SET_TURBO`
+		- :c:macro:`XSDFEC_ADD_LDPC_CODE_PARAMS`
+		- :c:macro:`XSDFEC_GET_CONFIG`
+		- :c:macro:`XSDFEC_SET_ORDER`
+		- :c:macro:`XSDFEC_SET_BYPASS`
+		- :c:macro:`XSDFEC_IS_ACTIVE`
+		- :c:macro:`XSDFEC_CLEAR_STATS`
+		- :c:macro:`XSDFEC_SET_DEFAULT_CONFIG`
+
+
+Driver Usage
+============
+
+
+Overview
+--------
+
+After opening the driver, the user should find out what operations need to be
+performed to configure and activate the SD-FEC core and determine the
+configuration of the driver.
+The following outlines the flow the user should perform:
+
+  - Determine Configuration
+  - Set the order, if not already configured as desired
+  - Set Turbo decode, LPDC encode or decode parameters, depending on how the
+    SD-FEC core is configured plus if the SD-FEC has not been configured for PL
+    initialization
+  - Enable interrupts, if not already enabled
+  - Bypass the SD-FEC core, if required
+  - Start the SD-FEC core if not already started
+  - Get the SD-FEC core status
+  - Monitor for interrupts
+  - Stop the SD-FEC core
+
+
+Note: When monitoring for interrupts if a critical error is detected where a reset is required, the driver will be required to load the default configuration.
+
+
+Determine Configuration
+-----------------------
+
+Determine the configuration of the SD-FEC core by using the ioctl
+:c:macro:`XSDFEC_GET_CONFIG`.
+
+Set the Order
+-------------
+
+Setting the order determines how the order of Blocks can change from input to output.
+
+Setting the order is done by using the ioctl :c:macro:`XSDFEC_SET_ORDER`
+
+Setting the order can only be done if the following restrictions are met:
+
+	- The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not STARTED
+
+
+Add LDPC Codes
+--------------
+
+The following steps indicate how to add LDPC codes to the SD-FEC core:
+
+	- Use the auto-generated parameters to fill the :c:type:`struct xsdfec_ldpc_params <xsdfec_ldpc_params>` for the desired LDPC code.
+	- Set the SC, QA, and LA table offsets for the LPDC parameters and the parameters in the structure :c:type:`struct xsdfec_ldpc_params <xsdfec_ldpc_params>`
+	- Set the desired Code Id value in the structure :c:type:`struct xsdfec_ldpc_params <xsdfec_ldpc_params>`
+	- Add the LPDC Code Parameters using the ioctl :c:macro:`XSDFEC_ADD_LDPC_CODE_PARAMS`
+	- For the applied LPDC Code Parameter use the function :c:func:`xsdfec_calculate_shared_ldpc_table_entry_size` to calculate the size of shared LPDC code tables. This allows the user to determine the shared table usage so when selecting the table offsets for the next LDPC code parameters unused table areas can be selected.
+	- Repeat for each LDPC code parameter.
+
+Adding LDPC codes can only be done if the following restrictions are met:
+
+	- The ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core is configured as LDPC
+	- The ``code_wr_protect`` of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates that write protection is not enabled
+	- The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not started
+
+Set Turbo Decode
+----------------
+
+Configuring the Turbo decode parameters is done by using the ioctl :c:macro:`XSDFEC_SET_TURBO` using auto-generated parameters to fill the :c:type:`struct xsdfec_turbo <xsdfec_turbo>` for the desired Turbo code.
+
+Adding Turbo decode can only be done if the following restrictions are met:
+
+	- The ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core is configured as TURBO
+	- The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not STARTED
+
+Enable Interrupts
+-----------------
+
+Enabling or disabling interrupts is done by using the ioctl :c:macro:`XSDFEC_SET_IRQ`. The members of the parameter passed, :c:type:`struct xsdfec_irq <xsdfec_irq>`, to the ioctl are used to set and clear different categories of interrupts. The category of interrupt is controlled as following:
+
+  - ``enable_isr`` controls the ``tlast`` interrupts
+  - ``enable_ecc_isr`` controls the ECC interrupts
+
+If the ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core is configured as TURBO then the enabling ECC errors is not required.
+
+Bypass the SD-FEC
+-----------------
+
+Bypassing the SD-FEC is done by using the ioctl :c:macro:`XSDFEC_SET_BYPASS`
+
+Bypassing the SD-FEC can only be done if the following restrictions are met:
+
+	- The ``state`` member of :c:type:`struct xsdfec_status <xsdfec_status>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC core has not STARTED
+
+Start the SD-FEC core
+---------------------
+
+Start the SD-FEC core by using the ioctl :c:macro:`XSDFEC_START_DEV`
+
+Get SD-FEC Status
+-----------------
+
+Get the SD-FEC status of the device by using the ioctl :c:macro:`XSDFEC_GET_STATUS`, which will fill the :c:type:`struct xsdfec_status <xsdfec_status>`
+
+Monitor for Interrupts
+----------------------
+
+	- Use the poll system call to monitor for an interrupt. The poll system call waits for an interrupt to wake it up or times out if no interrupt occurs.
+	- On return Poll ``revents`` will indicate whether stats and/or state have been updated
+		- ``POLLPRI`` indicates a critical error and the user should use :c:macro:`XSDFEC_GET_STATUS` and :c:macro:`XSDFEC_GET_STATS` to confirm
+		- ``POLLRDNORM`` indicates a non-critical error has occurred and the user should use  :c:macro:`XSDFEC_GET_STATS` to confirm
+	- Get stats by using the ioctl :c:macro:`XSDFEC_GET_STATS`
+		- For critical error the ``isr_err_count`` or ``uecc_count`` member  of :c:type:`struct xsdfec_stats <xsdfec_stats>` is non-zero
+		- For non-critical errors the ``cecc_count`` member of :c:type:`struct xsdfec_stats <xsdfec_stats>` is non-zero
+	- Get state by using the ioctl :c:macro:`XSDFEC_GET_STATUS`
+		- For a critical error the ``state`` of :c:type:`xsdfec_status <xsdfec_status>` will indicate a Reset Is Required
+	- Clear stats by using the ioctl :c:macro:`XSDFEC_CLEAR_STATS`
+
+If a critical error is detected where a reset is required. The application is required to call the ioctl :c:macro:`XSDFEC_SET_DEFAULT_CONFIG`, after the reset and it is not required to call the ioctl :c:macro:`XSDFEC_STOP_DEV`
+
+Note: Using poll system call prevents busy looping using :c:macro:`XSDFEC_GET_STATS` and :c:macro:`XSDFEC_GET_STATUS`
+
+Stop the SD-FEC Core
+---------------------
+
+Stop the device by using the ioctl :c:macro:`XSDFEC_STOP_DEV`
+
+Set the Default Configuration
+-----------------------------
+
+Load default configuration by using the ioctl :c:macro:`XSDFEC_SET_DEFAULT_CONFIG` to restore the driver.
+
+Limitations
+-----------
+
+Users should not duplicate SD-FEC device file handlers, for example fork() or dup() a process that has a created an SD-FEC file handler.
+
+Driver IOCTLs
+==============
+
+.. c:macro:: XSDFEC_START_DEV
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_START_DEV
+
+.. c:macro:: XSDFEC_STOP_DEV
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_STOP_DEV
+
+.. c:macro:: XSDFEC_GET_STATUS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_GET_STATUS
+
+.. c:macro:: XSDFEC_SET_IRQ
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_IRQ
+
+.. c:macro:: XSDFEC_SET_TURBO
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_TURBO
+
+.. c:macro:: XSDFEC_ADD_LDPC_CODE_PARAMS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_ADD_LDPC_CODE_PARAMS
+
+.. c:macro:: XSDFEC_GET_CONFIG
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_GET_CONFIG
+
+.. c:macro:: XSDFEC_SET_ORDER
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_ORDER
+
+.. c:macro:: XSDFEC_SET_BYPASS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_BYPASS
+
+.. c:macro:: XSDFEC_IS_ACTIVE
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_IS_ACTIVE
+
+.. c:macro:: XSDFEC_CLEAR_STATS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_CLEAR_STATS
+
+.. c:macro:: XSDFEC_GET_STATS
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_GET_STATS
+
+.. c:macro:: XSDFEC_SET_DEFAULT_CONFIG
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :doc: XSDFEC_SET_DEFAULT_CONFIG
+
+Driver Type Definitions
+=======================
+
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :internal:
\ No newline at end of file
-- 
2.7.4

