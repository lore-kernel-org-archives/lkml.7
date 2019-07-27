Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357FC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD812087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 08:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ReH7Icso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfG0Ieo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 04:34:44 -0400
Received: from mail-eopbgr810058.outbound.protection.outlook.com ([40.107.81.58]:41635
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfG0Ieo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 04:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF/+GqLPUkbgXq3si/JwPNC7QgmXQKw9iQxV9kvTUbbpukxRqvwhYnAJvtWXPVZ7aZS4l8rsct2O5EyR47noCC6HWYnuUtvJziizHp1pLw8dfQPqMMk1Hzh6U9QShJA1nyOaHJa9EBESw6KyhI1pfLehhIyHAmvv8OeSyauMoj29Uo/kqsBqY3+VBLAW2Pi4XLCN6d1M+a0gqmHoN8dVrRvEvd4rO6FaabdJQhAxkLYWlvenD43JOBTGYV5f0zO9O/JEFHXLIyV4CRx5E632Mk5xqK5oUSd7eK2SM9jnm9fdo3wVMcX+cuMLLj7Y8rva1LGcFt48NxwgaY2ytdQsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X09j1svwi3xQk7cnpfgREcmmzUvy3vpLW2EP/cSctGs=;
 b=j1qN8bsN1sVcJY904szKcsdEf3YScAWtiiszTCz2S62rviWG410hO34gRWqiqJPM4m0VK4/XrvrNA59jcEUzm7fDw9R2ugca0CpT/jQitfqthFkl8djSZ++rWwu57rWXGLPMe3RofoNRI1tdLDU3p9F1rA+iDFzn7Orm3KRpS956aUncZVWx9Ptdm0SLjKdieJER2LvcDvQFOSeEsIzeW5pvWgRli1Tmpp+Cb13NnWedMJx4DyyqfHZoTsTFk7vm+lICaA4pYRy5DzR/PfWPGbcrEPvRhf90zXKAdTSr3/IfWAdi8cucrdck186ttowq3jQTywBy6w+r/DSSgASluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X09j1svwi3xQk7cnpfgREcmmzUvy3vpLW2EP/cSctGs=;
 b=ReH7IcsofVyI5mTsCrpdNQ1hD+ivAyfJYQhMygcLDpvhnrqN+kD/A/wMWwiLhV0wypdqOEdttxAFRsyNu1bMJyqApSFQhE682GFrB/QU0uO7VLk/ePTHGVk3sBUCzMejQra1yghoNkblR4vapZfTbFx5x4+SUG4nK8Ko6/luL2g=
Received: from DM6PR02CA0099.namprd02.prod.outlook.com (2603:10b6:5:1f4::40)
 by DM6PR02MB6746.namprd02.prod.outlook.com (2603:10b6:5:21b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.14; Sat, 27 Jul
 2019 08:34:01 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0099.outlook.office365.com
 (2603:10b6:5:1f4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.15 via Frontend
 Transport; Sat, 27 Jul 2019 08:34:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2115.10 via Frontend Transport; Sat, 27 Jul 2019 08:34:00 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 27 Jul 2019 09:33:59 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 27 Jul 2019 09:33:59 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=40508 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hrI9P-00027X-R2; Sat, 27 Jul 2019 09:33:59 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V9 0/8] misc: xilinx sd-fec drive
Date:   Sat, 27 Jul 2019 09:33:50 +0100
Message-ID: <1564216438-322406-1-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(54534003)(50226002)(70206006)(8936002)(76130400001)(9786002)(70586007)(7636002)(305945005)(2201001)(6666004)(356004)(106002)(50466002)(107886003)(2616005)(476003)(956004)(426003)(36756003)(48376002)(4326008)(16586007)(28376004)(336012)(47776003)(186003)(71366001)(26005)(110136005)(54906003)(5660300002)(478600001)(14444005)(7696005)(51416003)(8676002)(486006)(316002)(26826003)(6306002)(966005)(44832011)(246002)(126002)(60926002)(2906002)(36906005)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6746;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1757b0c-2cdf-48f0-d166-08d7126d2cf3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR02MB6746;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6746:
X-MS-Exchange-PUrlCount: 9
X-Microsoft-Antispam-PRVS: <DM6PR02MB67462EDF3BA8352F259CF3A9CBC30@DM6PR02MB6746.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 01110342A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uGX7lKaXpqGzZEiRnmR9h/AkHqip3Jmi2BCpNXNAkpXm4EAEVIfQBkHS7K309Tg6286VqS36VzMc3oqzaPEXnhWr7+uDfvU8MK/RheNgSjiEwQ+ufp8fXo3uZjUFh/Xig2uJ8C1n0G0CvpVxtShSwgM65oSwkCD8BohYhybw00O/wFikizLSt2WBuDzVsI2STnUj4ZS6eLDkE0OsG4Tgn92qIZWIeTGY85S8TlfOYk8idTgHLUFI9Nw8pPVLGQXP43LHe+HnieukMI0CF+5OaCGcLY1rhD5VL8rt8y2T4pF/km3ERlVN7pQgHTmyO8nncX1YJkM9TYpAduYDNSSd9GSWa2Hwe0LCrgN6h2hlCrE9QujGI9PE6xA1A66W0oEkeMMXtyIQMKLc3ZJ922gCMXAhDKRAjTAC9LNH2cYxwbs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2019 08:34:00.9474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1757b0c-2cdf-48f0-d166-08d7126d2cf3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6746
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

Changes V8 -> V9:
- no changes

Link to V8 patch series:
https://lore.kernel.org/lkml/1562458542-457448-1-git-send-email-dragan.cvetic@xilinx.com/

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

