Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F59CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BC8214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="J7/IPHqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbfJ2Kb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:31:29 -0400
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:42818
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730960AbfJ2Kb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl/FGw/t7WuiAuQpBQAKINDSIfg+eVcRLCs0SDPlKi1UKKQYtnWtt/b8QPuR50giHJnGDGuNPkGI8HHLb58IxO2kT3TIXDmduygAFTJo4uF5QDiI46IAherng+e1LqFoeiWQeYxUqrSwQfIpUXvkpjbtLgcn6+kU6VbMAr6dNKhJtNPv5FRA6KUseMDV/9rHY7V6onQQKTeBu5KaO0bocQ3mjeSz0ZMmYE//W25Mbt6CX7DimZnoIuShV76ZxVm+ZLv5oQcKvahamFQ4kcistHfs6U9oQWCq/Axjl19FJO07aQ0dIoqbxb2yENVYEiLTCFea6iclpxmgSf/e9YWjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wSs8ysPVsmFKbPmDqQlTIs45+Cp/7XXqOFdW7LxfiU=;
 b=goQ2ErZKa7OaOniUASGJaLH9wXp1YfQ463Z4MerOi715OTcsLTFtIas6SsacKRd8C0OuJfkjUK1pPIAL2kNySLI7nFKVj4M0zNL1uJ/QEfMqAso8+Iesuygpv3P2znaUECTZigxqHabgTY+twNBaME9JQNEd7gfpg2Xw9oDixX1qO0YZ66oUU0r/opv5Tj5IFFMr4hNHLKut6macWg6AgelmMaFJTdIa5K/KaCKMzcACNsOSuwgKwj/bmw4SMWC5vqN6lZ+ArlDzocZVJ+fFMaPv5UXFcnC90FjOZLiUG8QpGhDJJvUl4eXuwjWrkP66Ir1UxYjNsqHpa/yQ3eVf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wSs8ysPVsmFKbPmDqQlTIs45+Cp/7XXqOFdW7LxfiU=;
 b=J7/IPHqAGswLJ4PrfW8uXS2GzN+WksvyEgR7I8BdV8wqB70gfzDlDE9d2g2DNMbxevWwuF6Piu6htf2HpJY4OSCKnHNEsJzzZL/HsnPl4jd6cGqHPsxgfzToeplfpCnTbnaejypUFw261yh30DYqHXw+cRBiIagTW6p/0XKq57o=
Received: from MN2PR02CA0033.namprd02.prod.outlook.com (2603:10b6:208:fc::46)
 by CY4PR0201MB3492.namprd02.prod.outlook.com (2603:10b6:910:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Tue, 29 Oct
 2019 10:31:23 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MN2PR02CA0033.outlook.office365.com
 (2603:10b6:208:fc::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Tue, 29 Oct 2019 10:31:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 10:31:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOmY-0002ul-47; Tue, 29 Oct 2019 03:31:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1iPOmS-000667-VR; Tue, 29 Oct 2019 03:31:17 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1iPOmN-00062u-AV; Tue, 29 Oct 2019 03:31:11 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 988A6121744; Tue, 29 Oct 2019 16:01:10 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: [PATCH v4 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date:   Tue, 29 Oct 2019 16:01:06 +0530
Message-Id: <1572345066-101293-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(26005)(51416003)(478600001)(8676002)(16586007)(81156014)(81166006)(42186006)(106002)(8936002)(50226002)(316002)(36386004)(103686004)(48376002)(36756003)(47776003)(50466002)(2906002)(107886003)(356004)(6666004)(14444005)(4326008)(336012)(6266002)(70586007)(70206006)(44832011)(486006)(2616005)(186003)(126002)(5660300002)(476003)(426003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3492;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 748214f6-5d6e-4ba8-3ca5-08d75c5b24d8
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3492:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB34924E65C7740127FDBC4A19C1610@CY4PR0201MB3492.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgjdF34bPhbpvbQcqyg/SGc+5FJSVDZwX3R9zzLT/0lmCrujWpcMEhybvE9934GnDXPrz5cbesDB26p+/YgvFPzcZwPQLpMRBExyR4QkNf21mw037gMhywik7V4gv9Sptl0sCL7PefcbVS2Q3T+ETgnNj/H+6Ryam+yqEqXm+7JdFcPZFpLVOTyVjAfU3MHm9pd4DHRsn4jVhGgPZtPrbyuiuwG8bfQxsVhFyAr4O7KQVhYfGfeVesR2Cdq3lrwKsRGXcxHQMFSeGyOqzyKdb3d2UZ2Lw73mctmXqhNMSeUqRn3+DcvJwVZUiEBQGNuDdCF0HsLK8s3joEOXF9sK4w9ftqvyMFSTnhVUTshyyr2ZeINiS0sSUfOJxRKFf9qXKK6ZnLujxUBFq3kq9cU6C0K+mjvZSupFWpKrXh0EsVFYMwj+o+Iuyxmule+se8La
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 10:31:22.5014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 748214f6-5d6e-4ba8-3ca5-08d75c5b24d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3492
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does the following:
 - Reorganize the Clock Handling in Arasan SD driver
 - Adds new sampling clock in Arasan SD driver
 - Adds support to set Clock Delays in SD Arasan Driver
 - Add SDIO Tap Delay handling in ZynqMP firmware driver
 - Add support for ZynqMP Tap Delays setting in Arasan SD driver

Changes in v2:
	- Replaced the deprecated calls to clock framework APIs
	- Added support for dev_clk_get() call to work for SD card clock
	- Separated the clock data struct
	- Fragmented the patch series in smaller patches to make it more
	  readable

Changes in v3:
	- Reverted "Replaced the deprecated calls to clock framework APIs"
	- Removed devm_clk_get() call which was added in v2

Changes in v4:
	- Made the Phase Delay properties Arasan specific

Manish Narani (8):
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay nodes
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  41 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 477 +++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h          |  13 +-
 3 files changed, 499 insertions(+), 32 deletions(-)

-- 
2.17.1

