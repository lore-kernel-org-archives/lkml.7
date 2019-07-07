Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39FBC48BD5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A982083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 00:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NOQZcc8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGGAPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 20:15:53 -0400
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:17872
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbfGGAPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 20:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOyuTZS7vLWp0X5nJRBoWvPujeRRYv+Wxw+fvRTVdEw=;
 b=NOQZcc8/e5+vNEx3G1bEElUoGy9VVrbvl3zfcNQddVsI+DfPStLlVPXVWSLk7l9yTOqvYJ4YW9lLo1aDJffs8gc0tA2U3vvWfI0kqRr3I8tNMLgvLMqYHquS2KKLOVlfmbOOvTeWYjNzfXAKGDDSMx+z5HdFExGvcBRdFaEjvms=
Received: from DM6PR02CA0014.namprd02.prod.outlook.com (2603:10b6:5:1c::27) by
 MN2PR02MB6766.namprd02.prod.outlook.com (2603:10b6:208:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Sun, 7 Jul
 2019 00:15:50 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM6PR02CA0014.outlook.office365.com
 (2603:10b6:5:1c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.19 via Frontend
 Transport; Sun, 7 Jul 2019 00:15:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2032.15 via Frontend Transport; Sun, 7 Jul 2019 00:15:49 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sun, 7 Jul 2019 01:15:45 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sun, 7 Jul 2019 01:15:45 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=58228 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hjuqG-0004ON-W0; Sun, 07 Jul 2019 01:15:45 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V8 0/8] misc: xilinx sd-fec drive
Date:   Sun, 7 Jul 2019 01:15:34 +0100
Message-ID: <1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(376002)(136003)(396003)(2980300002)(54534003)(189003)(199004)(51416003)(7696005)(2201001)(956004)(26005)(7636002)(186003)(336012)(305945005)(36756003)(71366001)(6306002)(8936002)(2616005)(476003)(486006)(126002)(4326008)(316002)(16586007)(44832011)(36906005)(14444005)(28376004)(5660300002)(356004)(6666004)(50226002)(54906003)(110136005)(106002)(9786002)(8676002)(478600001)(2906002)(246002)(26826003)(48376002)(50466002)(966005)(107886003)(70206006)(76130400001)(426003)(47776003)(70586007)(60926002)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6766;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be212b49-1e15-414f-1d20-08d7027043ea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR02MB6766;
X-MS-TrafficTypeDiagnostic: MN2PR02MB6766:
X-MS-Exchange-PUrlCount: 8
X-Microsoft-Antispam-PRVS: <MN2PR02MB676625CF1689EF5B5B49AC77CBF70@MN2PR02MB6766.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0091C8F1EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: RonO8HxXgzKYl8j6grJlSqKcfD2Vj3xe1yspJ3ufraQsqyHjW/wMuIJaPeBe0UjvSBbUsjU77NCspPRGSaDikrUpPYJ+F4xqACJv5ZpqDkk1CODuN0Q42u5vySFkTZoyY9DlgL09DHrgP9uq5TXup99h1RAVmPt2w3L7105oP+ZWYFPOi2GLmuhivj/K9c+IU9SEMweFWjWzYzyJCyjKTNEIP2FA4PoB4ezfj4XCs/8cz/rAhFrOcwdGPZL/OOpbGy/vCv/r4Cntgvyk9kDAyzD3nZh49+9ewLevi7zCPn/dfJWFO22PJerhbeWOb0SdGC2L3usWUhsU2GQI0m2yUnYwCN7i9/ZB7JW5O6AqfnuVMHzWRglXIpILRrD448i/a6RClEVNHQ30Une7VDv+0UZbdAL1ZsgmSi1nNg6gPaE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2019 00:15:49.3572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be212b49-1e15-414f-1d20-08d7027043ea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6766
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

Changes V4 -> V5:
- change atomic variables to c type variables
- align spinlock name to better description
- correct a logicla error in LDPC algorithm
- remove log messages
- remove useless if statements
- remove not needed fec_id variable
- squash commit 4 with 6

Link to V4 patch series:
https://lore.kernel.org/lkml/1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com/

Changes V5 -> V6:
- the kernle/user space variables convert enums to __u32
- put device ID under IDR

Link to V5 patch series:
https://lore.kernel.org/lkml/1560038656-380620-1-git-send-email-dragan.cvetic@xilinx.com/

Changes V6 -> V7:
- Fix maintainers list

Link to V6 patch series:
https://lore.kernel.org/lkml/1560174314-124649-1-git-send-email-dragan.cvetic@xilinx.com/

Changes V7 -> V8:
- 3 patches are added to char-misc, 8 to go
- remove holes in structs for 32bit and 64bit
- fix the compiler warning

Link to V7 patch series:
https://lore.kernel.org/lkml/1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com/

Dragan Cvetic (8):
  misc: xilinx_sdfec: Store driver config and state
  misc: xilinx_sdfec: Add ability to configure turbo
  misc: xilinx_sdfec: Add ability to configure LDPC
  misc: xilinx_sdfec: Add ability to get/set config
  misc: xilinx_sdfec: Support poll file operation
  misc: xilinx_sdfec: Add stats & status ioctls
  Docs: misc: xilinx_sdfec: Add documentation
  MAINTAINERS: add maintainer for SD-FEC

 Documentation/misc-devices/index.rst |    1 +
 MAINTAINERS                          |   11 +
 drivers/misc/xilinx_sdfec.c          | 1184 +++++++++++++++++++++++++++++++++-
 include/uapi/misc/xilinx_sdfec.h     |  448 +++++++++++++
 4 files changed, 1638 insertions(+), 6 deletions(-)
 create mode 100644 include/uapi/misc/xilinx_sdfec.h

-- 
2.7.4

