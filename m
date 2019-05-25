Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED8AC282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989002168B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KjoF71rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfEYLho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:37:44 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:9605
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbfEYLhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMi4aR42tO/2gmGrMvFZj7Smiqd1DdjsI9jR74MlF8g=;
 b=KjoF71rTkFS/xe3CYhqcyk9Xq5YSs4MNxuoz06IyksmJZJwcZ0hZ36uS12a5s8hg4P6jksD3/EUsBZcLbl3tWYu6itQSgqLHvV5JcjhiCKtI6UKprfkpEwiD+XQ4Vtdo+d4S7g78+vHUz359J0Iu2/C4wxIHpj1S/XAiAA9xEzQ=
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by DM6PR02MB6235.namprd02.prod.outlook.com (2603:10b6:5:1d1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.16; Sat, 25 May
 2019 11:37:38 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.17 via Frontend
 Transport; Sat, 25 May 2019 11:37:38 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1922.16 via Frontend Transport; Sat, 25 May 2019 11:37:37 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 25 May 2019 12:37:34 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 25 May 2019 12:37:34 +0100
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
Received: from [149.199.110.15] (port=57194 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hUUzW-00058U-AX; Sat, 25 May 2019 12:37:34 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V4 00/12] misc: xilinx sd-fec drive
Date:   Sat, 25 May 2019 12:37:13 +0100
Message-ID: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39840400004)(136003)(2980300002)(199004)(189003)(54534003)(316002)(70586007)(478600001)(71366001)(2201001)(51416003)(486006)(186003)(14444005)(54906003)(76130400001)(7696005)(2906002)(70206006)(956004)(966005)(47776003)(106002)(44832011)(26826003)(36756003)(4326008)(8676002)(476003)(60926002)(126002)(336012)(7636002)(2616005)(110136005)(107886003)(36906005)(16586007)(6306002)(9786002)(356004)(6666004)(8936002)(246002)(5660300002)(305945005)(50226002)(48376002)(426003)(26005)(28376004)(50466002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6235;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe1573e2-b279-4278-6b7c-08d6e105637d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB6235;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6235:
X-MS-Exchange-PUrlCount: 4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB6235961F51CAF7878A1E4F08CB030@DM6PR02MB6235.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0048BCF4DA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: nvT2aw1mX2svpmRU3fIY9IqC0Ut2HRckq5VraQNyKjEzolcNM/XeDCm1pNlkDMi26PCRV1S3NzrwGjwR30rYvSyOlQ3KHDQe1ZogamPreE4e2QopN9zbDGjg6POUMFXKHD4t2nVymNGjX4aQhxzWN7PskCtTSDcjBvi17hza9D/T7d1pwSD+vZyt8+mm6yFAbehKUvLz13+VD1cpP+9Qf920f+ErsGYjKn8eHisSR8huee6cf7nuiD2Rjhre8VJnABp8El2m7nNdE2ZBFWEaV6bUx2wAGRBGnyxBOnBWjBsD00F0XFwk6RhRC9TYln9BZybwHLPGqNIQ9c0VgIMQsrGE4TxP/QcpM0tabZu1xMu1xfmFDFkGBgD1vZAaIz9MwC11Ih+ksxEu7HnHNGm+5IGGRWPXEuZviFmgAZxILjk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2019 11:37:37.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1573e2-b279-4278-6b7c-08d6e105637d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6235
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

Tested-by: Santhosh Dyavanapally <SDYAVANA@xilinx.com>
Tested by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Changes V1 -> V2:
- Removed unnecesary comenting from the commit messages.
- Removed error log messages which can be triggered from user space.
- Corrected the SDFEC table end addresses.
- Removed casting between user pointer and kernel pointer.
- Corrected definition of ioctl command code, used a corect type for
size parameters.
- Changes to declarations of IOCTL that pass structures, i.e. do not
use pointers for sizeof as prevents compile time checks
- IOCTL size fix, using a paging to manage a memory. Implemented a big
tables transfer from user to kernel with get_user_pages_fast().
- Removed unnecessary check after container_of.
- Removed not needed ioctl code checkes inside ioctl handler.
- Implemented compat_ioctl.
- Updated reviewer and tester lists.
- Updated documentation, added Limitation chapter related to fork()
and dup().

Link to V1 patch series:
https://lore.kernel.org/lkml/1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com/

Changes V2 -> V3:
- Corrected a licence in xilinx_sdfec.h changed to uapi licence format.
- Corrected driver variable data types into user space data types.

Link to V2 patch series:
https://lore.kernel.org/lkml/1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com/

Changes V3 -> V4:
- Migrate to simplier misc driver
- Fix DT example
- Remove helper function
- Remove unused open_count variable
- Remove some logs
- Change log level to dev_dbg in the most logs
- Change spin lock to spin_lock_irqsave/spin_lock_irqrestore
- Correct a licence date in xilinx_sdfec.c
- Add PTR_ERR in clock handling

Link to V3 patch series:
https://lore.kernel.org/lkml/1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com/

Dragan Cvetic (12):
  dt-bindings: xilinx-sdfec: Add SDFEC binding
  misc: xilinx-sdfec: add core driver
  misc: xilinx_sdfec: Add CCF support
  misc: xilinx_sdfec: Add open, close and ioctl
  misc: xilinx_sdfec: Store driver config and state
  misc: xilinx_sdfec: Add ability to configure turbo
  misc: xilinx_sdfec: Add ability to configure LDPC
  misc: xilinx_sdfec: Add ability to get/set config
  misc: xilinx_sdfec: Support poll file operation
  misc: xilinx_sdfec: Add stats & status ioctls
  Docs: misc: xilinx_sdfec: Add documentation
  MAINTAINERS: add maintainer for SD-FEC

 .../devicetree/bindings/misc/xlnx,sd-fec.txt       |   58 +
 Documentation/misc-devices/index.rst               |    1 +
 Documentation/misc-devices/xilinx_sdfec.rst        |  291 ++++
 MAINTAINERS                                        |   12 +
 drivers/misc/Kconfig                               |   12 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/xilinx_sdfec.c                        | 1568 ++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h                   |  456 ++++++
 8 files changed, 2399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Documentation/misc-devices/xilinx_sdfec.rst
 create mode 100644 drivers/misc/xilinx_sdfec.c
 create mode 100644 include/uapi/misc/xilinx_sdfec.h

-- 
2.7.4

