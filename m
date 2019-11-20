Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DC022310
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ElgyeJNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfKTN4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:56:06 -0500
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:2377
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbfKTN4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:56:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/u9zF28QYCfjGS0nEW2dWzQDhSYRYf2tq2CzAd4pPKqzZBSnTRGSAMEKEHR4EUbihJtFz+JwGqaQrqcKJMUmHSaKvqaloABtdQxe7tv55uDFJ0i6VpM86qO4xuMZobSDtnj5WEifCqe1K8YU77jBGoLk1836CSdAkd4S6onn8aL6xhLbq5Znth5CEVVLGUE8YI5b3RaA+LVaizfMX5IHn6xKjPwTA2DEcCMX8ECyjYqDsEd/rU8AzrKRUp7ebKUtnyxBq9xwhxFjNXLepi4ic7jY7isE3qLEh+ODAvoI6wh5/Gi0i8XVpjYwRR6ijQUCl0uFnFXeUbE3xewOOl1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy9icOgS/+H2juQeNJbREoqoY+vdKSKbg5KRMGxlHnw=;
 b=PRJxHnVXPyDYsc7Xi8SpE4HuPmVZ+RhHx2Jo8vjYItN75JctGt6iiRO5fT9cDu2cGtnLLc8ZflXf4qxJBxmrA2aOPY8LmrAV4OrIpRu3jsLwL0mHW0/tYnIv6u/r5w6arN/pC0a7a93k0L3idUoZjOuLzw1cBnd1otJfjQS7O/vbNJv2fHUV0xHUGXyMc88acCgKb1/hjrqUWDgdvDVEEyAAEBJcT7hvHZ5mBIQ4V57rLj9k2TDiemSMbgEWzU3TI8I5mqCW5Tc4Izu/404PWa8WdVfRit9dLSfkURhwf13VcASiQ8T5o1IlZPCmk8CzRMucRyLP5T+0r7oXgdGyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vy9icOgS/+H2juQeNJbREoqoY+vdKSKbg5KRMGxlHnw=;
 b=ElgyeJNC/eyOjH1lC6A7FZKpydLdgxiyFIf1f+sBnrKoED83Z54qMJAagVBmXlAKwI0OxAiCnS2y0++cWORlS1f8MP8t3NcbvCSjiyR35ODgt91ydx2/hdUSlJOkIhAWURsI9o3c9nLC+orI2J9KrPxWdBY1TmrZUjiZAzhNjoQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from BY5PR12MB3860.namprd12.prod.outlook.com (10.255.138.89) by
 BY5PR12MB3956.namprd12.prod.outlook.com (10.255.138.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 20 Nov 2019 13:56:02 +0000
Received: from BY5PR12MB3860.namprd12.prod.outlook.com
 ([fe80::dc7:b2d0:b79d:88de]) by BY5PR12MB3860.namprd12.prod.outlook.com
 ([fe80::dc7:b2d0:b79d:88de%2]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 13:56:02 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommu/amd: Fixes for x2APIC support
Date:   Wed, 20 Nov 2019 07:55:47 -0600
Message-Id: <1574258149-15602-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0044.prod.exchangelabs.com (2603:10b6:800::12) To
 BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25)
MIME-Version: 1.0
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45e7f891-b9cc-47fe-24a4-08d76dc160d9
X-MS-TrafficTypeDiagnostic: BY5PR12MB3956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39566C4E626A58D5F2E01C5CF34F0@BY5PR12MB3956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(66556008)(6666004)(99286004)(4720700003)(14454004)(7736002)(25786009)(4744005)(6436002)(486006)(476003)(305945005)(2616005)(3846002)(36756003)(44832011)(2906002)(66946007)(6512007)(478600001)(6116002)(4326008)(5660300002)(50466002)(48376002)(186003)(47776003)(86362001)(51416003)(6506007)(386003)(26005)(14444005)(81166006)(81156014)(8936002)(66476007)(8676002)(6486002)(66066001)(16586007)(316002)(50226002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR12MB3956;H:BY5PR12MB3860.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OP51tceT1Pxb6LXoOpUUN+tcGWluR4NxX2NOQkUHtHeKsob3J6/FIGpDe3QFQckti3/A9I6gyGksWNM+USDcPL/gYVGnZUj/vGd2yU/LiQf929XrJ7H5PW/+uSuEJYG1/5MJ6sgqRZ8SoNVBXjBnomfb3wH0dm4YAwAcS97cEC3nc8l7YD7es8tCY4NlMoOdISa/OUrgTOwdLG6x2XyrVfjv4sAVaCSyKIYonJl9tMeCTGrtcbyuHkoV0Y9miCp7D39sDFPGE6qyb2px0obf7aIqwoQ4LBiHgpQJdVKitdn/NJal9oGsTf8l4iCk2XQAsTT8PP52Ak8SiQS7j0fXCScOgrIYVdb56/yUVi4JCQc06yyHM2dwpDZEZrIAj1lXs7nfiu88XE/lZBi7D8+LqN4J10ylyTzBAO8Rt0jVccXZZ1rHqbVdr81YQC8ox5D+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e7f891-b9cc-47fe-24a4-08d76dc160d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 13:56:02.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtGB0gc6Vv8BRK3lCKggjPsdg8bVlCG4MtCvSky88Oi/dAPY72ULdLVBHJ8FzTzQLOcXw/XEvXVYRTuKMNtOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding feature support check for MMIO access to MSI capability
block registers when enabling x2APIC (XT) mode. Also fix up logic
for checking XT feature support for IVHD type 10h.

Suravee Suthikulpanit (2):
  iommu/amd: Check feature support bit before accessing MSI capability
    registers
  iommu/amd: Only support x2APIC with IVHD type 11h/40h

 drivers/iommu/amd_iommu_init.c  | 19 ++++++++++++-------
 drivers/iommu/amd_iommu_types.h |  2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
1.8.3.1

