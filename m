Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1D4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6612D206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="uFGX5YZL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vQbdxLNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLWPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 10:16:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42532 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726828AbfLWPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:16:48 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBNFGaee027203;
        Mon, 23 Dec 2019 07:16:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=AsLrBrwpTUkvVsy6PlMLs0KSilLyrY3tL4GFSieEuLk=;
 b=uFGX5YZLivNWaboqEUJ4Bm+9/7TgxSvTfIEZs1sIIfIyKxfVqhwRBpaf8ZB4JfRkqqGq
 e6c7vwmhWIoJrWvZWfogN6qXirlN2aqNtsuVLKgEfAtZ930CNWmznHt0dMgePqNOihlG
 kWrySBtn6G8MPBiTysPMz0AV3SoOO7H4WYBWqxdhB3VQL13zI0mZCrreGdwn1Fln5Ju0
 SBeBi4wLhv1ptBchdAaodohtVahTnuuT9TW3yOl2vZa2BQsPayjehPb87LwUQYm2dIew
 IF1q7PIgPx6Af525TPOLsAgtC2iyNXEookzxLysysezvJzGB4W+N8l1YzsOaSluHvv+b SA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2x1fv3nkkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 07:16:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALE/K0C5S36bQXVu9I23R7hf3qQ8QwKiB0LKbMck0ENSZyymX71GRl1Si+vVfmGe470FZtTZmP/4qCxDzTsLl+odP5/IU1UPqDfiG6+3Zq5DJhUiOWN7WsZS4wUy1pXh0k2S2RZyPIIt+ogCA07A+xtKL8uRCRAyIf+sL81p83keyyuQKVI9A2QYbmUArCOCDrRMlLi+wNDVrVaQrVDF8I9FbO6fBCR4WWThAo0XnfPgDFUUvl9BABS5lveBHquYWhV5ak/Rn9/cayd6RD7BNQybixcm+/Tzpeoc3cZXGyt+11Yk1IWnUaDl0NTBPM93brrLjV6pmYS5l79+4hM7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsLrBrwpTUkvVsy6PlMLs0KSilLyrY3tL4GFSieEuLk=;
 b=G0y+AlCxtXXxCGh+HEdfnTGrcRVbwBqpV6rw+ulAxErxHbm27BFYy8CYT54Qppic9dj2LRGQLpjXN1tGSunpmebm6XrDQz9kvSas9Z4ve+Vf7eOaK2UGlaSEseIYI4jIy6E1fukp+rea0FLnsJdI8x3ny97NirNJBtHIZ5LySTyF6r9EnnSodU7zfIJCSa3po4KbCdTn6kKZUUPOeTpYrVTYZBBtXweb06Kvu9SZN/gqcUjxgq9N8RUAatKcKG+prgg/441gHJgHZT8dRSrzqjzvhy1j+yypq0csA+AmrLXupYC9GKbGQtq7Z0Z6j0WgoVLDHRSpPRNnis264Xjxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsLrBrwpTUkvVsy6PlMLs0KSilLyrY3tL4GFSieEuLk=;
 b=vQbdxLNNug+03UI1jx76A8QfByUks6lUIfo3RaaTLCe/z2Goy2ebRDWe2w49veYdGxg4SxGxmAlMmj3QruQzxfFixBKXngcqamNnSlFLLjq1ZKWzNofp6y/yVDfu0q0U8CLjwpnw0slEZG6d97dYaH+MwI/O5FDj4rRRURaJJMk=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 DM6PR07MB6441.namprd07.prod.outlook.com (2603:10b6:5:1c3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 15:15:45 +0000
Received: from MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::204) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.16 via Frontend
 Transport; Mon, 23 Dec 2019 15:15:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT028.mail.protection.outlook.com (10.13.181.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16 via Frontend Transport; Mon, 23 Dec 2019 15:15:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id xBNFFfVR093771
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 23 Dec 2019 07:15:43 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 23 Dec 2019 16:15:41 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Dec 2019 16:15:41 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBNFFeDh015127;
        Mon, 23 Dec 2019 16:15:41 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBNFFdks015113;
        Mon, 23 Dec 2019 16:15:39 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 00/14] PHY: Update Cadence Torrent PHY driver with reconfiguration
Date:   Mon, 23 Dec 2019 16:15:25 +0100
Message-ID: <1577114139-14984-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(36092001)(199004)(189003)(36756003)(186003)(2906002)(6666004)(356004)(4326008)(107886003)(26005)(336012)(2616005)(5660300002)(19627235002)(8676002)(15650500001)(42186006)(81156014)(426003)(8936002)(70586007)(36906005)(81166006)(70206006)(86362001)(478600001)(54906003)(110136005)(316002)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6441;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 191ca8db-2976-4a61-a847-08d787bafba7
X-MS-TrafficTypeDiagnostic: DM6PR07MB6441:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6441AB2A747912954282917FD22E0@DM6PR07MB6441.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0260457E99
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3HfUdN/Cu+xs5FuvQ5B7ZR3rqgdN9kMYufiRsvG/f3+dsJB4zrwEd+U5QzV9CwADi1Flgz6OGHN1L2e6od263xeH2VoFocMg+TwhNVkcWvq5BEfT8egcPBUcsxRsP8AdcXnba6eYKlp3yMfOFvExWc+lLyeVVhLvVG3bXuCNYJhhAVK63oDiPoSCZHHkHS8iVKcrhMZK8WXxEJ2XQze/46fcCXNYon0lArOf00pTEjClGU36pWhD5+V0rRcw/99XsCq4jkBj8R9ZWPUV8q3U1Gg3PiEZudCX5InEiGakWSwZYWb7yJBRdXVJg7wHCxwlItmPXrZtM2Wk0gvl2e+lhRMxgEF/f8FyoLxo142vmI2hU/GsY0mnBlZAxpcNFFCavn4cLVuyb2l9PMJj1J3H6A91KrK6qgh4GG/M+UOkE/Jh+C/KnWZlgc+mMJ+vm4FW1cYr5rinTDu550wku+Oj8EC17VO2jmOVdlwChfKc9p5x4Z2+FIXcsvpUyWO8eIOGPInZ18RhzbWuhHX2LfSUuJ4251ISbSwGP3y/Y15Dmw=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 15:15:45.1389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 191ca8db-2976-4a61-a847-08d787bafba7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6441
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_06:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series applies to the Cadence SD0801 PHY driver.
Cadence SD0801 PHY is also known as Torrent PHY. Torrent PHY
is a multiprotocol PHY supporting PHY configurations including
Display Port, USB and PCIe.

This patch series converts SD0801 PHY driver for DisplayPort into a
generic Torrent PHY driver, updates DisplayPort functionality with
reconfiguration support and finally adds platform dependent initialization
for TI J7 SoCs.

The patch series has following patches which applies the changes
in the below sequence
1. 001-dt-bindings-phy-Convert-Cadence-MHDP-PHY-bindings-to-YAML
This patch converts the MHDP PHY device tree bindings to yaml schemas
2. 002-phy-cadence-dp-Rename-to-phy-Cadence-Torrent
Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
3. 003-phy-cadence-torrent-Adopt-Torrent-nomenclature
Update private data structures, module descriptions and functions prefix to Torrent
4. 004-phy-cadence-torrent-Add-wrapper-for-PHY-register-access
Add a wrapper function to write Torrent PHY registers to improve code readability.
5. 005-phy-cadence-torrent-Add-wrapper-for-DPTX-register-access
Add wrapper functions to read, write DisplayPort specific PHY registers to improve code
readability.
6. 006-phy-cadence-torrent-Refactor-code-for-reusability
Add separate function to set different power state values.
Use of uniform polling timeout value. Check return values of functions for error handling.
7. 007-phy-cadence-torrent-Add clock bindings
Add Torrent PHY reference clock bindings.
8. 008-phy-cadence-torrent-Add-19.2-MHz-reference-clock-support
Add configuration functions for 19.2 MHz reference clock support.Add register configurations
for SSC support.
9. 009-phy-cadence-torrent-Add-phy-lane-reset-support
Add reset support for PHY lane group.
10. 010-phy-cadence-torrent-Implement-phy-configure-APIs
Add PHY configuration APIs for link rate, number of lanes, voltage swing and pre-emphasis values.
11. 011-phy-cadence-torrent-Use-regmap
Use regmap for accessing Torrent PHY registers. Update register offsets. Abstract address
calculation using regmap APIs.
12. 012-phy: cadence-torrent-Use-regmap-to-read-and-write-DPTX-PHY-registers
Use regmap to read and write DPTX specific PHY registers.
13. 013-dt-bindings-phy-phy-cadence-torrent-Add-platform-dependent-compatible-string
Add a new compatible string used for TI SoCs using Torrent PHY.
14. 014-phy-cadence-torrent-Add-platform-dependent-initialization-structure
Add platform dependent initialization data for Torrent PHY used in TI's J721E SoC.

Version History:

v2:
  - Remove patch [1] from this series and send for a separate review.
  - Use enum in compatible property of YAML file.
  - Remove quotes in clock-names property "refclk" -> refclk in YAML file.
  - Add reg-names property to YAML file
  - Add additionalProperties:false to YAML file.
  - No change in the driver code.

This patch series is dependent on PHY DisplayPort configuration patch [1].

[1]

https://patchwork.kernel.org/patch/11307829/

Swapnil Jakhade (8):
  phy: cadence-torrent: Adopt Torrent nomenclature
  phy: cadence-torrent: Add wrapper for PHY register access
  phy: cadence-torrent: Add wrapper for DPTX register access
  phy: cadence-torrent: Refactor code for reusability
  phy: cadence-torrent: Add 19.2 MHz reference clock support
  phy: cadence-torrent: Add PHY lane reset support
  phy: cadence-torrent: Implement PHY configure APIs
  phy: cadence-torrent: Use regmap to read and write DPTX PHY registers

Yuti Amonkar (6):
  dt-bindings: phy: Convert Cadence MHDP PHY bindings to YAML.
  phy: cadence-dp: Rename to phy-cadence-torrent
  dt-bindings: phy: phy-cadence-torrent: Add clock bindings
  phy: cadence-torrent: Use regmap to read and write Torrent PHY
    registers
  dt-bindings: phy: phy-cadence-torrent: Add platform dependent
    compatible string
  phy: cadence-torrent: Add platform dependent initialization structure

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |   30 -
 .../bindings/phy/phy-cadence-torrent.yaml          |   78 +
 drivers/phy/cadence/Kconfig                        |    6 +-
 drivers/phy/cadence/Makefile                       |    2 +-
 drivers/phy/cadence/phy-cadence-dp.c               |  541 ------
 drivers/phy/cadence/phy-cadence-torrent.c          | 1824 ++++++++++++++++++++
 6 files changed, 1906 insertions(+), 575 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c

-- 
2.7.4

