Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3452C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A172175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3MSfdwrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfCSMFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:05:00 -0400
Received: from mail-eopbgr730060.outbound.protection.outlook.com ([40.107.73.60]:55177
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbfCSMEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dkBAy+7pEUikFS7assvtahUi51B8e3u/hIu6uLwDgk=;
 b=3MSfdwrhZZ8eKpqQ7KywjYzQF3SdBXhZLyBoE7bJ7g4YLR3kvtb40R4gLFHLB3pIA0c++zHDiSTePVgWoYzHwRBBV6Lk88eD0GofjH6AFbfWqM1Kfv6XDs6TOgcNUonvycKMj0I57eBTLv3USEuMhzl+gd1EtHzXMojsr3fObns=
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by MWHPR02MB2207.namprd02.prod.outlook.com (2603:10b6:300:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:04:41 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:41 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:39 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:39 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DTz-0003Ch-UH; Tue, 19 Mar 2019 12:04:39 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 11/12] Docs: misc: xilinx_sdfec: Add documentation
Date:   Tue, 19 Mar 2019 12:04:23 +0000
Message-ID: <1552997064-432700-12-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(189003)(199004)(5660300002)(47776003)(305945005)(7636002)(36906005)(5024004)(2906002)(14444005)(246002)(28376004)(9786002)(26826003)(316002)(110136005)(478600001)(54906003)(93146003)(8936002)(6346003)(106466001)(50226002)(8746002)(7696005)(107886003)(51416003)(76176011)(106002)(4326008)(336012)(26005)(186003)(2616005)(11346002)(956004)(486006)(48376002)(71366001)(426003)(476003)(126002)(60926002)(8676002)(44832011)(50466002)(356004)(2201001)(30864003)(6666004)(36756003)(446003)(6306002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2207;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956d4a9c-10c3-4f70-d701-08d6ac63118b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR02MB2207;
X-MS-TrafficTypeDiagnostic: MWHPR02MB2207:
X-MS-Exchange-PUrlCount: 2
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB220758E83AC444E16252257ECB400@MWHPR02MB2207.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HrevjDeb1uSZYFwWqJBUStK+b156BL7wAvCIdg37i7hUG4s6P5NfoWadw7Frs/L7Xe6gcpDDHLctg5BjlaDFGS7aEd4BfylfzoHS16snFSAv0pYUsEGkJ6rq2ZcUMWsHDXEe3bJ+MnY/1bEynoJ6B4psd2L5VjpoCNm0RAMJKK9Gv+a1x6uyraodGXwGIJiJH7dRUGZOJxI8MFrHt4nFzZU2Ox8ZQz/RK9+/JGRNBzXfKWFgGQjyl7YsgI2zAOizVKRDAif/AwOXQ64hg88zklT/CWsAE0uvw+kR3D88lLgc83Xe852ASiiwE7/RSn2HMI8TEjbJxBqaYR88qx7PN3+yu2X2TmS9AWr8edg/N9GPPNM5j61k1GeQ7MnHZk5LgfL+vR0h3aSw6Tx7QVuv6R/V/ll5olqfh3zr+mnmI+Q=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:41.1647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 956d4a9c-10c3-4f70-d701-08d6ac63118b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD-FEC driver documentation.

Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 Documentation/misc-devices/index.rst        |   1 +
 Documentation/misc-devices/xilinx_sdfec.rst | 286 ++++++++++++++++++++++++=
++++
 2 files changed, 287 insertions(+)
 create mode 100644 Documentation/misc-devices/xilinx_sdfec.rst

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devi=
ces/index.rst
index dfd1f45..b5b4757 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -15,3 +15,4 @@ fit into other categories.
    :maxdepth: 2

    ibmvmc
+   xilinx_sdfec
diff --git a/Documentation/misc-devices/xilinx_sdfec.rst b/Documentation/mi=
sc-devices/xilinx_sdfec.rst
new file mode 100644
index 0000000..99ec3dd
--- /dev/null
+++ b/Documentation/misc-devices/xilinx_sdfec.rst
@@ -0,0 +1,286 @@
+.. SPDX-License-Identifier: GPL-2.0+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Xilinx SD-FEC Driver
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+This driver supports SD-FEC Integrated Block for Zynq |Ultrascale+ (TM)| R=
FSoCs.
+
+.. |Ultrascale+ (TM)| unicode:: Ultrascale+ U+2122
+   .. with trademark sign
+
+For a full description of SD-FEC core features, see the `SD-FEC Product Gu=
ide (PG256) <https://www.xilinx.com/cgi-bin/docs/ipdoc?c=3Dsd_fec;v=3Dlates=
t;d=3Dpg256-sdfec-integrated-block.pdf>`_
+
+This driver supports the following features:
+
+  - Retrieval of the Integrated Block configuration and status information
+  - Configuration of LDPC codes
+  - Configuration of Turbo decoding
+  - Monitoring errors
+
+Missing features, known issues, and limitations of the SD-FEC driver are a=
s
+follows:
+
+  - Only allows a single open file handler to any instance of the driver a=
t any time
+  - Reset of the SD-FEC Integrated Block is not controlled by this driver
+  - Does not support shared LDPC code table wraparound
+
+The device tree entry is described in:
+`linux-xlnx/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt <https:=
//github.com/Xilinx/linux-xlnx/blob/master/Documentation/devicetree/binding=
s/misc/xlnx%2Csd-fec.txt>`_
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
+For Run-time configuration the role of driver is to allow the software app=
lication to do the following:
+
+       - Load the configuration parameters for either Turbo decode or LDPC=
 encode or decode
+       - Activate the SD-FEC core
+       - Monitor the SD-FEC core for errors
+       - Retrieve the status and configuration of the SD-FEC core
+
+Programmable Logic (PL) Initialization
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For PL initialization, supporting logic loads configuration parameters for=
 either
+the Turbo decode or LDPC encode or decode.  The role of the driver is to a=
llow
+the software application to do the following:
+
+       - Activate the SD-FEC core
+       - Monitor the SD-FEC core for errors
+       - Retrieve the status and configuration of the SD-FEC core
+
+
+Driver Structure
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The driver provides a platform device where the ``probe`` and ``remove``
+operations are provided.
+
+  - probe: Updates configuration register with device-tree entries plus de=
termines the current activate state of the core, for example, is the core b=
ypassed or has the core been started.
+
+
+The driver defines the following driver file operations to provide user
+application interfaces:
+
+  - open: Implements restriction that only a single file descriptor can be=
 open per SD-FEC instance at any time
+  - release: Allows another file descriptor to be open, that is after curr=
ent file descriptor is closed
+  - poll: Provides a method to monitor for SD-FEC Error events
+  - unlocked_ioctl: Provides the the following ioctl commands that allows =
the application configure the SD-FEC core:
+
+               - :c:macro:`XSDFEC_START_DEV`
+               - :c:macro:`XSDFEC_STOP_DEV`
+               - :c:macro:`XSDFEC_GET_STATUS`
+               - :c:macro:`XSDFEC_SET_IRQ`
+               - :c:macro:`XSDFEC_SET_TURBO`
+               - :c:macro:`XSDFEC_ADD_LDPC_CODE_PARAMS`
+               - :c:macro:`XSDFEC_GET_CONFIG`
+               - :c:macro:`XSDFEC_SET_ORDER`
+               - :c:macro:`XSDFEC_SET_BYPASS`
+               - :c:macro:`XSDFEC_IS_ACTIVE`
+               - :c:macro:`XSDFEC_CLEAR_STATS`
+               - :c:macro:`XSDFEC_SET_DEFAULT_CONFIG`
+
+
+Driver Usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+Overview
+--------
+
+After opening the driver, the user should find out what operations need to=
 be
+performed to configure and activate the SD-FEC core and determine the
+configuration of the driver.
+The following outlines the flow the user should perform:
+
+  - Determine Configuration
+  - Set the order, if not already configured as desired
+  - Set Turbo decode, LPDC encode or decode parameters, depending on how t=
he
+    SD-FEC core is configured plus if the SD-FEC has not been configured f=
or PL
+    initialization
+  - Enable interrupts, if not already enabled
+  - Bypass the SD-FEC core, if required
+  - Start the SD-FEC core if not already started
+  - Get the SD-FEC core status
+  - Monitor for interrupts
+  - Stop the SD-FEC core
+
+
+Note: When monitoring for interrupts if a critical error is detected where=
 a reset is required, the driver will be required to load the default confi=
guration.
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
+Setting the order determines how the order of Blocks can change from input=
 to output.
+
+Setting the order is done by using the ioctl :c:macro:`XSDFEC_SET_ORDER`
+
+Setting the order can only be done if the following restrictions are met:
+
+       - The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_sta=
tus>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC=
 core has not STARTED
+
+
+Add LDPC Codes
+--------------
+
+The following steps indicate how to add LDPC codes to the SD-FEC core:
+
+       - Use the auto-generated parameters to fill the :c:type:`struct xsd=
fec_ldpc_params <xsdfec_ldpc_params>` for the desired LDPC code.
+       - Set the SC, QA, and LA table offsets for the LPDC parameters and =
the parameters in the structure :c:type:`struct xsdfec_ldpc_params <xsdfec_=
ldpc_params>`
+       - Set the desired Code Id value in the structure :c:type:`struct xs=
dfec_ldpc_params <xsdfec_ldpc_params>`
+       - Add the LPDC Code Parameters using the ioctl :c:macro:`XSDFEC_ADD=
_LDPC_CODE_PARAMS`
+       - For the applied LPDC Code Parameter use the function :c:func:`xsd=
fec_calculate_shared_ldpc_table_entry_size` to calculate the size of shared=
 LPDC code tables. This allows the user to determine the shared table usage=
 so when selecting the table offsets for the next LDPC code parameters unus=
ed table areas can be selected.
+       - Repeat for each LDPC code parameter.
+
+Adding LDPC codes can only be done if the following restrictions are met:
+
+       - The ``code`` member of :c:type:`struct xsdfec_config <xsdfec_conf=
ig>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC =
core is configured as LDPC
+       - The ``code_wr_protect`` of :c:type:`struct xsdfec_config <xsdfec_=
config>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates that wr=
ite protection is not enabled
+       - The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_sta=
tus>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC=
 core has not started
+
+Set Turbo Decode
+----------------
+
+Configuring the Turbo decode parameters is done by using the ioctl :c:macr=
o:`XSDFEC_SET_TURBO` using auto-generated parameters to fill the :c:type:`s=
truct xsdfec_turbo <xsdfec_turbo>` for the desired Turbo code.
+
+Adding Turbo decode can only be done if the following restrictions are met=
:
+
+       - The ``code`` member of :c:type:`struct xsdfec_config <xsdfec_conf=
ig>` filled by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC =
core is configured as TURBO
+       - The ``state`` member of struct :c:type:`xsdfec_status <xsdfec_sta=
tus>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC=
 core has not STARTED
+
+Enable Interrupts
+-----------------
+
+Enabling or disabling interrupts is done by using the ioctl :c:macro:`XSDF=
EC_SET_IRQ`. The members of the parameter passed, :c:type:`struct xsdfec_ir=
q <xsdfec_irq>`, to the ioctl are used to set and clear different categorie=
s of interrupts. The category of interrupt is controlled as following:
+
+  - ``enable_isr`` controls the ``tlast`` interrupts
+  - ``enable_ecc_isr`` controls the ECC interrupts
+
+If the ``code`` member of :c:type:`struct xsdfec_config <xsdfec_config>` f=
illed by the ioctl :c:macro:`XSDFEC_GET_CONFIG` indicates the SD-FEC core i=
s configured as TURBO then the enabling ECC errors is not required.
+
+Bypass the SD-FEC
+-----------------
+
+Bypassing the SD-FEC is done by using the ioctl :c:macro:`XSDFEC_SET_BYPAS=
S`
+
+Bypassing the SD-FEC can only be done if the following restrictions are me=
t:
+
+       - The ``state`` member of :c:type:`struct xsdfec_status <xsdfec_sta=
tus>` filled by the ioctl :c:macro:`XSDFEC_GET_STATUS` indicates the SD-FEC=
 core has not STARTED
+
+Start the SD-FEC core
+---------------------
+
+Start the SD-FEC core by using the ioctl :c:macro:`XSDFEC_START_DEV`
+
+Get SD-FEC Status
+-----------------
+
+Get the SD-FEC status of the device by using the ioctl :c:macro:`XSDFEC_GE=
T_STATUS`, which will fill the :c:type:`struct xsdfec_status <xsdfec_status=
>`
+
+Monitor for Interrupts
+----------------------
+
+       - Use the poll system call to monitor for an interrupt. The poll sy=
stem call waits for an interrupt to wake it up or times out if no interrupt=
 occurs.
+       - On return Poll ``revents`` will indicate whether stats and/or sta=
te have been updated
+               - ``POLLPRI`` indicates a critical error and the user shoul=
d use :c:macro:`XSDFEC_GET_STATUS` and :c:macro:`XSDFEC_GET_STATS` to confi=
rm
+               - ``POLLRDNORM`` indicates a non-critical error has occurre=
d and the user should use  :c:macro:`XSDFEC_GET_STATS` to confirm
+       - Get stats by using the ioctl :c:macro:`XSDFEC_GET_STATS`
+               - For critical error the ``isr_err_count`` or ``uecc_count`=
` member  of :c:type:`struct xsdfec_stats <xsdfec_stats>` is non-zero
+               - For non-critical errors the ``cecc_count`` member of :c:t=
ype:`struct xsdfec_stats <xsdfec_stats>` is non-zero
+       - Get state by using the ioctl :c:macro:`XSDFEC_GET_STATUS`
+               - For a critical error the ``state`` of :c:type:`xsdfec_sta=
tus <xsdfec_status>` will indicate a Reset Is Required
+       - Clear stats by using the ioctl :c:macro:`XSDFEC_CLEAR_STATS`
+
+If a critical error is detected where a reset is required. The application=
 is required to call the ioctl :c:macro:`XSDFEC_SET_DEFAULT_CONFIG`, after =
the reset and it is not required to call the ioctl :c:macro:`XSDFEC_STOP_DE=
V`
+
+Note: Using poll system call prevents busy looping using :c:macro:`XSDFEC_=
GET_STATS` and :c:macro:`XSDFEC_GET_STATUS`
+
+Stop the SD-FEC Core
+---------------------
+
+Stop the device by using the ioctl :c:macro:`XSDFEC_STOP_DEV`
+
+Set the Default Configuration
+-----------------------------
+
+Load default configuration by using the ioctl :c:macro:`XSDFEC_SET_DEFAULT=
_CONFIG` to restore the driver.
+
+Driver IOCTLs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. kernel-doc:: include/uapi/misc/xilinx_sdfec.h
+   :internal:
\ No newline at end of file
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
