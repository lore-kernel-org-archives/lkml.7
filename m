Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CB8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D393214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="G4531IvX";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="t6jZQRAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfLKNKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45310 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729377AbfLKNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:39 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD48ZJ020455;
        Wed, 11 Dec 2019 05:09:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=P85gdHEJ/W46bV+0uENhb+bVGZB6ZfvLm1PLQKlJNBs=;
 b=G4531IvXhPMJdtGNubO+m4ttgIIiB0aH19fbrIZ1K3GJX2GfIt8mKEFhifarYCcAdN60
 zg99LJldKK00gkwoNNuLRcaemvdeS72gVep7NkWLJkv4+fY22e2jzAiwY4iEqwY84HKS
 TyIpSfS5XQ/cnxqT3EIwFgcblDy/qcBOUdbgNwW03fulR7uJ+9uIT+u6yTZAYCQTfb6q
 5D6v0vuIO2ZseLJ2yHXjZ0Zz+n8LAIqs2dKhMkvXLSpOKIuZ0nXr9Lrjs29eJx20XHBB
 6C98rVs0iXn/Ez9bBQQ8e3jcfljAcV+HYRAliFCaqv2VMpIE51GC/gBuQ43J+udpuIyh OQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wr9dfp680-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 05:09:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVQ9hQ6cHDe2QxyqDt1Xq/AtruxLzUivFkpNgVRTkaSVWJKGRNWxvd8W8C2f7uU/G+Qwba59x8b0OrwDEauFf9KD66RWNWxRz3bSUG9cM6CbNHpMUVS8s5v1qN+wf5kWLXmaFyKLRj6WXl4g12l6q7vUNMuP0eMiJpn9Phav4h6jndzdlcE7wXaVd67mdmV396mcZDhreuWnOMZRb8AnYCxfoBpEsn2sWP3Mw2pU9h84cz4V3N8FC2hnn9G3fAckBf9WWy6xl4otdMo2y/YalbOYXoAaHNtvEKjMvddFnZbBflc7nJ7GsxF2yTs0VqHhaiEhZrazAaOkUtkcY1jyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P85gdHEJ/W46bV+0uENhb+bVGZB6ZfvLm1PLQKlJNBs=;
 b=nczSI/7WFtEd2lMyGb1g/ME1SB2dBk83rOkJXbrspIDEXJCWUGwfbgfmhAOdziDl++ZQd3lQWPPjEOHBLhhqg3/v7Hxe++fezY1QlIQpcu1wId83BEaDoR/fv/5wrfhuW2LX/Cdk+S0XRNtzP9heXdYGdU6CYHAQToAYOrIKI7bpIKMvvtGOzQbUAwn2oY72CAQ8AXWU9qimS9S2qywVK9+XfzsCiVNZFEkDHwR6vNyF7Qw9EGFQuga2n8DK5LQzRk6XVhjhhKi3DcQDesvnsd3HMYbxSjiplXJZff4v6AqnT6LoCrdWlYzmFl8sD6oodrF2HFppOBU2pEAbBzqB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P85gdHEJ/W46bV+0uENhb+bVGZB6ZfvLm1PLQKlJNBs=;
 b=t6jZQRAxoRokbtRU9Ep8WkdV+bo9BLGN/WqFedzk7FgBeXSBKI1/g0uB5ay+ReZs3nfogwwBDTYbmA7ZWag1K1NG0eVFIeKs6XQuDHdk0IB/NJdw3OYhhQInV7ImQd51dCDMrydjYMH5hFyxWefLTPObRS763lo66Yd8yilasRk=
Received: from BYAPR07CA0057.namprd07.prod.outlook.com (2603:10b6:a03:60::34)
 by DM6PR07MB6921.namprd07.prod.outlook.com (2603:10b6:5:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 13:09:26 +0000
Received: from DM6NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::204) by BYAPR07CA0057.outlook.office365.com
 (2603:10b6:a03:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 13:09:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT061.mail.protection.outlook.com (10.13.179.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Wed, 11 Dec 2019 13:09:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9L5Z006811
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 11 Dec 2019 08:09:23 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 11 Dec 2019 14:09:21 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 11 Dec 2019 14:09:21 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id xBBD9LJP011564;
        Wed, 11 Dec 2019 14:09:21 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id xBBD9KK9011547;
        Wed, 11 Dec 2019 14:09:20 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [RESEND PATCH v1 00/15] PHY: Update Cadence Torrent PHY driver with reconfiguration 
Date:   Wed, 11 Dec 2019 14:09:05 +0100
Message-ID: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(36092001)(70586007)(26826003)(8936002)(76130400001)(36756003)(70206006)(478600001)(81156014)(81166006)(8676002)(4743002)(107886003)(15650500001)(186003)(5660300002)(19627235002)(6666004)(356004)(2616005)(426003)(2906002)(336012)(86362001)(316002)(54906003)(110136005)(42186006)(26005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB6921;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ca89b5-dd14-429d-4d95-08d77e3b58a9
X-MS-TrafficTypeDiagnostic: DM6PR07MB6921:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6921733C5CA1AB5B32C09F11D25A0@DM6PR07MB6921.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Q5XwMdVmAuJv3To1oJ+rnIkKM+9HCIRY45I6aqgfqsHXTNYT17ek/ljYKhEPI0FXPFLdcDySiDafflyExzG46wC3sU6mL4R2ai3QOu9ybTPfey9A0OcElGzb4kyIFrEnGa/MusQZ2Ha2VZdssiP7m0XhloZRnp4zS7X6BeA8+mKY1fuO41rVZqZF1lQyP6VPOxckdFat39yRkVc7JRucyK3vNcOupz3oaQSDEglN9TmiV9v/RLGj+3hbGmPnpsUm/U3u03TjbuVR/8KoTFTZCgVSdosiM0QzSrGir3xA7bVedu1WU6ZG99Tvyns+E1yTYOGGjOtoPRSO4j7t7BEG5UqIQ1HkwYX9pPH1Zwrr5+BBZ6nDUFcDuf185ZF+P6tYURutfKV1PG1WV60W0Yqfb9aYgHkV5XGggFEQio4mpl5N56d0/cNPMdWONsr9XxFpRvVhtBCceMWqYmRvJ1Rb1a1A0DlDhlLEIeOCisMdwh8s/6LXse5yqklacOuKwy6
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 13:09:25.1204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca89b5-dd14-429d-4d95-08d77e3b58a9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6921
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_03:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series applies to the Cadence SD0801 PHY driver. Cadence SD0801 PHY driver
is Torrent PHY driver for Display Port.
Torrent PHY is a multiprotocol PHY supporting PHY configurations including Display Port,
USB and PCIe. 
This patch series first adds Display Port configuration then updates the driver to make
it a generic Torrent driver and finally adds SoC platform dependent initialization.

The patch series has 15 patches which applies the changes in the below sequence 
1.  001-phy-cadance-dp-Add-DisplayPort-configuration-options
This patch adds generic DisplayPort API for configuring PHY.The parameters configured are
link rate, number of lanes, voltage swing and pre-emphasis.
2. 002-dt-bindings-phy-Convert-Cadence-MHDP-PHY-bindings-to-YAML
This patch converts the MHDP PHY device tree bindings to yaml schemas 
3. 003-phy-cadence-dp-Rename-to-phy-Cadence-Torrent
Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent 
4. 004-phy-cadence-torrent-Adopt-Torrent-nomenclature
Update private data structures, module descriptions and functions prefix to Torrent 
5. 005-phy-cadence-torrent-Add-wrapper-for-PHY-register-access
Add a wrapper function to write Torrent PHY registers to improve code readability.
6. 006-phy-cadence-torrent-Add-wrapper-for-DPTX-register-access
Add wrapper functions to read, write DisplayPort specific PHY registers to improve code
readability.
7. 007-phy-cadence-torrent-Refactor-code-for-reusability
Add separate function to set different power state values.
Use of uniform polling timeout value. Check return values of functions for error handling.
8. 008-phy-cadence-torrent-Add clock bindings 
Add Torrent PHY reference clock bindings. 
9. 009-phy-cadence-torrent-Add-19.2-MHz-reference-clock-support
Add configuration functions for 19.2 MHz reference clock support.Add register configurations
for SSC support.
10. 010-phy-cadence-torrent-Add-phy-lane-reset-support
Add reset support for PHY lane group.
11. 011-phy-cadence-torrent-Implement-phy-configure-APIs
Add PHY configuration APIs for link rate, number of lanes, voltage swing and pre-emphasis values.
12. 012-phy-cadence-torrent-Use-regmap
Use regmap for accessing Torrent PHY registers. Update register offsets. Abstract address 
calculation using regmap APIs.
13. 013-phy: cadence-torrent-Use-regmap-to-read-and-write-DPTX-PHY-registers
Use regmap to read and write DPTX specific PHY registers.
14. 014-dt-bindings-phy-phy-cadence-torrent-Add-platform-dependent-compatible-string
Add a new compatible string used for TI SoCs using Torrent PHY.
15. 015-phy-cadence-torrent-Add-platform-dependent-initialization-structure
Add platform dependent initialization data for Torrent PHY used in TI's J721E SoC.

Swapnil Jakhade (8):
  phy: cadence-torrent: Adopt Torrent nomenclature
  phy: cadence-torrent: Add wrapper for PHY register access
  phy: cadence-torrent: Add wrapper for DPTX register access
  phy: cadence-torrent: Refactor code for reusability
  phy: cadence-torrent: Add 19.2 MHz reference clock support
  phy: cadence-torrent: Add PHY lane reset support
  phy: cadence-torrent: Implement PHY configure APIs
  phy: cadence-torrent: Use regmap to read and write DPTX PHY registers

Yuti Amonkar (7):
  phy: Add DisplayPort configuration options
  dt-bindings:phy: Convert Cadence MHDP PHY bindings to YAML.
  phy: cadence-dp: Rename to phy-cadence-torrent
  dt-bindings: phy: phy-cadence-torrent: Add clock bindings
  phy: cadence-torrent: Use regmap to read and write Torrent PHY
    registers
  dt-bindings: phy: phy-cadence-torrent: Add platform dependent
    compatible string
  phy: cadence-torrent: Add platform dependent initialization structure

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |   30 -
 .../bindings/phy/phy-cadence-torrent.yaml          |   71 +
 drivers/phy/cadence/Kconfig                        |    6 +-
 drivers/phy/cadence/Makefile                       |    2 +-
 drivers/phy/cadence/phy-cadence-dp.c               |  541 ------
 drivers/phy/cadence/phy-cadence-torrent.c          | 1824 ++++++++++++++++++++
 include/linux/phy/phy-dp.h                         |   95 +
 include/linux/phy/phy.h                            |    4 +
 8 files changed, 1998 insertions(+), 575 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c
 create mode 100644 include/linux/phy/phy-dp.h

-- 
2.7.4

