Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C110C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA97620838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nuUWiSq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfLJNID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:08:03 -0500
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:46822
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727529AbfLJNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:07:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfHqo69PbB6QvbCnWcdqi+8ApjxxEfT13dLYGUrt7WHLIEEyewWGch9+3XkGC81etY7EFk5YGFCwCJ9taMOoMVk4d6ceL8dOpB8mP8ZFfHsCDi/4bBaVhMYf423d7D45SjdzhKKEJKQxVivGwODmhtR74Kka32Wu2SeP5uiap2ULq7M7z3u67hHSix2qW8CPvxq4Sb5wXQH7U/oXs82sYL+TiZBq5WJn+cXlg1iBGFnt2f3QqhU8pcPsxfPfLqI5hyjduGfLl5jHi1CH/2AFvokud7oXMTVgdAodc9TlUBEePoxxJbbEOgxxs/Cp5G+zjfH03ts4RVfU2gxkco/Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj+oD0KgsNOBwhS6sD0d4UQxcccC7nEOj1NsraymGZU=;
 b=i9Hto5R0832sueEemNAywu6MkfOcZvld+ivQXvdq4Raek6yKp5mEIUGxWypouIhDvygcXl6VKHyM/VzmY+CGvzstoFTy/PCyHAzaqu5yuFJX1CkY0qLlF9zrysIpL3xoB0y17TtldO9apXqGoapbmkKIeZqmwayCQySfApRJbL/qtJOU/QhPk/7O9MyEHZhJNv6q/qRuzOhaPh616xP/hqLF0ISXDU0euzyQ2d64zZkGiFApoCc02h3t7dfkvkPdlFU+1rzS/JfFp/IfQLRD6JhjMcMO8saZSyMsp20bMM9tZSPt75mpDn2k7Hx16Bmv4PU79FknxIRXZgLlLwpy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj+oD0KgsNOBwhS6sD0d4UQxcccC7nEOj1NsraymGZU=;
 b=nuUWiSq7PuLfwN1sdYBbufNpwvvQhoEEpyzN7t0KrNuUK3MjrWjvUTafVLTznXS71aCwHge7rlMAsNtJxiKe6tztFN+iA9onsHbDR6aqokt5ZcRbMF/kH2ypkxWVWkfGtWj6iETD6P1Xp8drFYoFQ9bkN8i2QZoU1vXDK5RbRnE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3934.namprd12.prod.outlook.com (10.255.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Tue, 10 Dec 2019 13:07:54 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::1900:6cb7:12ff:11c%4]) with mapi id 15.20.2516.018; Tue, 10 Dec 2019
 13:07:54 +0000
From:   Sanjay R Mehta <Sanju.Mehta@amd.com>
To:     Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, jdmason@kudzu.us
Cc:     logang@deltatee.com, dave.jiang@intel.com, allenbh@gmail.com,
        will@kernel.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] ntb_perf: pass correct struct device to dma_alloc_coherent
Date:   Tue, 10 Dec 2019 07:07:35 -0600
Message-Id: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::14) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.156.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7befc626-5bc5-4468-a67d-08d77d71f7af
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:|MN2PR12MB3934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3934F1B7D571D2E94E787A5BE55B0@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 02475B2A01
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(189003)(199004)(186003)(8936002)(2616005)(6666004)(6512007)(52116002)(6486002)(86362001)(4326008)(478600001)(2906002)(66946007)(6506007)(26005)(8676002)(36756003)(81166006)(5660300002)(66556008)(66476007)(316002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3934;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9h6NvTAuSuNFpB953cv6cXnXQtx8tDbItafwDIs8vESpPNT11rOk5PVdAVcFCGJZg1Cfz6Zicab9pcJsm728G7E/3lGHcy2ute18rftEmoYaYC8cyKpMXtFdVadTYHg5VVd96VGvBV9D4cGLy8DBqrckvqXksJGTFQG3ldGvkFmKaDTZFhRnKPVQSsfPrZP9Eg92p+n3VS9mE3TPQv21iXjTvhTW6Ur68n+ZhnM455iPKYyQd0o8FO4emgJBySGjYiKQsdE+mxu/NSUQHg1OjkNXOoW4BCIaMb655MmZxTiNRZ8EXGfFGbBOzbVl1Z4v54LR7xn95IqwK89JWy65+XLbe/oOdnF7kifzNSijP/mwL/gx4KwthZ3skK9LVg2eGkRep858efOX7jBs8Ue7CSnn9IL+3Rp6KOEVpFLKIXaY7F9NPO6+H9kdCsqfdq1E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7befc626-5bc5-4468-a67d-08d77d71f7af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2019 13:07:54.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TETFvItKW9G1/vL3Ua/kXE0YaJGH8lzJlDZXthxDH3uhI6E+HgzjaKpZ6En+t2Q8SFIIMSYESaXoFJlEITkuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

Currently, ntb->dev is passed to dma_alloc_coherent
and dma_free_coherent calls. The returned dma_addr_t
is the CPU physical address. This works fine as long
as IOMMU is disabled. But when IOMMU is enabled, we
need to make sure that IOVA is returned for dma_addr_t.
So the correct way to achieve this is by changing the
first parameter of dma_alloc_coherent() as ntb->pdev->dev
instead.

Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index f5df33a..8729838 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
 		return;
 
 	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
-	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
+	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
 			  peer->inbuf, peer->inbuf_xlat);
 	peer->inbuf = NULL;
 }
@@ -588,8 +588,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
-					 &peer->inbuf_xlat, GFP_KERNEL);
+	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
+					 peer->inbuf_size, &peer->inbuf_xlat,
+					 GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
 			&peer->inbuf_size);
-- 
2.7.4

