Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AB6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C2320854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4h6mdrDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCSMEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:36 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:43574
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbfCSMEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEU9qYTO03vHt/EIt0nrRCo9bzbj9L9MWW0g/e7t0nI=;
 b=4h6mdrDlsiFN0As1G6i5aMwsZlJLaSb5gMmOvpZykb/wpFWKlN2WVVHcUwSHxdMl1JCWnHtA1WZuhrAMnPthCKHTg+t5LaY6IiOsFPy0eecobNy+W2CWbdE6Hyu9ycGM4I9G/T1Ln5pMWEy59WdHMnpcD3ppRV8tUGxqpTFLIyM=
Received: from BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28)
 by CY4PR02MB2199.namprd02.prod.outlook.com (2603:10b6:903:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:04:32 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0051.outlook.office365.com
 (2603:10b6:207:3d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:31 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:30 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:30 +0000
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
        id 1h6DTq-0003Ch-TF; Tue, 19 Mar 2019 12:04:30 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 00/12] misc: xilinx sd-fec driver
Date:   Tue, 19 Mar 2019 12:04:12 +0000
Message-ID: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(199004)(189003)(336012)(478600001)(26826003)(356004)(966005)(110136005)(486006)(36906005)(476003)(9786002)(316002)(126002)(956004)(44832011)(2201001)(60926002)(2616005)(7636002)(47776003)(305945005)(71366001)(36756003)(6306002)(426003)(6666004)(5660300002)(14444005)(8676002)(107886003)(5024004)(106466001)(246002)(48376002)(54906003)(28376004)(50466002)(93146003)(51416003)(2906002)(4326008)(8746002)(7696005)(8936002)(50226002)(186003)(26005)(106002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2199;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e04c32e5-ea76-4b35-6eab-08d6ac630be9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:CY4PR02MB2199;
X-MS-TrafficTypeDiagnostic: CY4PR02MB2199:
X-MS-Exchange-PUrlCount: 1
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB21999787A701DFCAA1F52642CB400@CY4PR02MB2199.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ABO+P3i1J2CqhBaZTKQVK48i0xVEzaYgzNCYB30Cye15xNVq9MFillDJUIfJR30HyKc4r68fm3xTpl4VKFpT0PstA86Ew5mzLkbb82lKUd29QxC2VzyF9z+r9ecKxBUEYB2Kc9WdtWmf8LiXj+Pt24QaJFDhqq44X7F+ZUpORvwNnEjnPJXuvOiCi9Ng56gwZSdAnhWPvt5+3/vQnRcJ2XB0nGDV6B1zVyaDm/mYCP1k9Fx6/MUrX2Ualommywu7ako3XHsFpAmrVRx3tUav2WLSZw+F/NdeYsrlNt20lXY3fVk6AUoI6bPXltCwNIKlYNJsqm7qJfEUDg4Ent8A9//x7BOdMhzX8Zeq2sK5hFrKPVV2RzM0FM8EjUsu9aZop+0MeEeg4arijsomfpK3u+tTgzKtJJ2ZI/DyFVUJ8uo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:31.9469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c32e5-ea76-4b35-6eab-08d6ac630be9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is adding the full Soft Decision Forward Error
Correction (SD-FEC) driver implementation, driver DT binding and
driver documentation.

Forward Error Correction (FEC) codes such as Low Density Parity
Check (LDPC) and turbo codes provide a means to control errors in
data transmissions over unreliable or noisy communication
channels. The SD-FEC Integrated Block is an optimized block for
soft-decision decoding of these codes. Fixed turbo codes are
supported directly, whereas custom and standardized LDPC codes
are supported through the ability to specify the parity check
matrix through an AXI4-Lite bus or using the optional programmable
(PL)-based support logic. For the further information see
https://www.xilinx.com/support/documentation/ip_documentation/
sd_fec/v1_1/pg256-sdfec-integrated-block.pdf

This driver is a platform device driver which supports SDFEC16
(16nm) IP. SD-FEC driver supports LDPC decoding and encoding and
Turbo code decoding. LDPC codes can be specified on
a codeword-by-codeword basis, also a custom LDPC code can be used.

The SD-FEC driver exposes a char device interface and supports
file operations: open(), close(), poll() and ioctl(). The driver
allows only one usage of the device, open() limits the number of
driver instances. The driver also utilize Common Clock Framework
(CCF).

The control and monitoring is supported over ioctl system call.
The features supported by ioctl():
- enable or disable data pipes to/from device
- configure the FEC algorithm parameters
- set the order of data
- provide a control of a SDFEC bypass option
- activates/deactivates SD-FEC
- collect and provide statistical data
- enable/disable interrupt mode

Poll can be utilized to detect errors on IRQ trigger rather than
using looping status and stats ioctl's.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Santhosh Dyavanapally <SDYAVANA@xilinx.com>
Tested by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Tested-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Dragan Cvetic (12):
  dt-bindings: xilinx-sdfec: Add SDFEC binding
  misc: xilinx-sdfec: add core driver
  misc: xilinx_sdfec: Add CCF support
  misc: xilinx_sdfec: Add open, close and ioctl
  misc: xilinx_sdfec: Store driver config and state
  misc: xilinx_sdfec: Add ability to configure turbo mode
  misc: xilinx_sdfec: Add ability to configure LDPC
  misc: xilinx_sdfec: Add ability to get/set config
  misc: xilinx_sdfec: Support poll file operation
  misc: xilinx_sdfec: Add stats & status ioctls
  Docs: misc: xilinx_sdfec: Add documentation
  MAINTAINERS: add maintainer for SD-FEC support

 .../devicetree/bindings/misc/xlnx,sd-fec.txt       |   58 +
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/misc-devices/xilinx_sdfec.rst        |  286 ++++
 MAINTAINERS                                        |   12 +
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/xilinx_sdfec.c                        | 1683 ++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h                   |  470 ++++++
 8 files changed, 2523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Documentation/misc-devices/xilinx_sdfec.rst
 create mode 100644 drivers/misc/xilinx_sdfec.c
 create mode 100644 include/uapi/misc/xilinx_sdfec.h

--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
