Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D255206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZieE9H84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfKKTfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:35:04 -0500
Received: from mail-eopbgr720071.outbound.protection.outlook.com ([40.107.72.71]:62496
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726879AbfKKTfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:35:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGdItVaRUiv9RjGABK5ZuF9npDLp76qx72QhQdHYmYno5Rzn0vpXJxbGfMtiqzv/ARIdzpRcK8Re2PqXPsfEzHwSCqzYIGmZ37GAKhC9kT0TGuL5E195oBOFfM+rbNfAUy5+bLVVGX5eiz51leNNRmI/hIzFqvBle8O9C8kxwLPyVZ5qbF4f6mjlSgyR1zckwOsUFPR5l4QASlC8k4AFS9v1BTRrfV9YMsFn+ixPxMEOyiOZelYlOaP1LL8FlIeKH8tNQvpgXqdxgiE/d6qyJkILJh0v8UZZ5DpWaoqIAOjWeE4UxNlaRTo0jLWgSVgXvxKEY2uLpPb+MQxbWmY5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqTwLXDjqiAe8R2d922gEvHOmHuChaUeTE3PYM3PwSM=;
 b=nA1NDrMfEULSLkKYcRSh2nUemAdPAMpkn83rQUgqD4MhztxYxAIX63XARjTOldFKn6PWFDTFw9tPOXhv/fYsvWJ4oMUdxH8X1uG3jfMpRTtcPDANI2R+aUAYwmZcN4LRe+5DUcEcGeelgJ5vHX9GsuUIY1WV9GclCDTHu3+KZ55PlpdKdKt0MjbHM2SeraE+zqL91dUfopgQm6wlO4EdNwxj4ZtOrgBLYk71ZZr10Gko5yO1mYoo18hA0bK6aAqSecLcVKTeVxl4y7pnmUd7SlY7kIXeG5YSTCLI8rSSFMaIWpL/4ePdKcGoXXrg0Fd3duzTaaHy2zoSBK2IyQ6log==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqTwLXDjqiAe8R2d922gEvHOmHuChaUeTE3PYM3PwSM=;
 b=ZieE9H841u213CkMOOgoMfxNlvW5ELphtEQSEQGcw9yZE1n1fH7jkJ6lwtPhGXNBXyRtPRA/f6bBRS9oeodtCnPl6nbt7qF80oDcoCcQ5dyMfDk6PoG1TBqBPcYsX/RDd0Tp8Wspun2LsNtySnEHUuoUdQe5K637Fi+INwdnxKk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.71.154) by
 DM6PR12MB3289.namprd12.prod.outlook.com (20.179.71.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Mon, 11 Nov 2019 19:34:53 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::dd0c:8e53:4913:8ef4]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::dd0c:8e53:4913:8ef4%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 19:34:53 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Luck <tony.luck@intel.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] Documentation/process: Add AMD contact for embargoed hardware issues
Date:   Mon, 11 Nov 2019 13:34:37 -0600
Message-Id: <c1062e44a8784747e4834d28de6f54c30ae95058.1573500877.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR15CA0020.namprd15.prod.outlook.com
 (2603:10b6:805:16::33) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8efda5d-870d-48c6-ce20-08d766de3984
X-MS-TrafficTypeDiagnostic: DM6PR12MB3289:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB328951B558A3FF3DA20BFFABEC740@DM6PR12MB3289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0218A015FA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(54906003)(476003)(6666004)(486006)(50466002)(2616005)(86362001)(186003)(8936002)(99286004)(4326008)(7736002)(7416002)(5660300002)(50226002)(386003)(6506007)(66946007)(51416003)(52116002)(305945005)(66476007)(66556008)(2906002)(66066001)(25786009)(26005)(4744005)(478600001)(36756003)(118296001)(6512007)(6486002)(47776003)(81156014)(16586007)(81166006)(6116002)(3846002)(48376002)(6436002)(14454004)(14444005)(8676002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3289;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: teMJ9zLUWtqRfD9eV0iuFhpLpAXpG63mGdm0Z50iPTZqSDG3ZN8yEpuFQ5ieAwtTiIA6OScZ/jEHsI4Ja7xzlKeZxPETd8DUXzuief4e+cpJCJEO9LZ4WUtnHF+EjCB9TtBzAzELd0XRcojNf2Syp4qKUpDYp1jN4xLKGUtB8fnKVv91jRLlGDpzrwHAarJIDJ19pcufj1nWRGqH5drVyUsarvg/jsN7B1/DWGCZoMZVIW/H/JJbduXlKbQgZYCscxlitMziq2k75RrE1fBsrjAcKxh3gZ46zfZ/kWZekJKIDbUz/l4LVT/9gL6R8gbRAgtUiwY0ghOclbMTsUm2z6v1mfCaCY0z1JNsN4w+FUS/jlHWALQXUtk5UdShP02ywSQHRVZyVO3X/KDKzQlrR6DoM1HAbjWFH+LeUGriv5iksuFsNpKiC9sS0eX/K6Tr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8efda5d-870d-48c6-ce20-08d766de3984
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2019 19:34:53.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCPck+aPwVIakVtiLx7wIB3olG2BdSg/qGlcuvsUTlwDSpEoM2HqOP+bu6oo4qu3Jnv6FBXZy4BmWPEidPtHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the AMD ambassador to the embargoed hardware issues
document.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index a3c3349046c4..799580acc8de 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -240,7 +240,7 @@ an involved disclosed party. The current ambassadors list:
 
   ============= ========================================================
   ARM
-  AMD
+  AMD		Tom Lendacky <tom.lendacky@amd.com>
   IBM
   Intel		Tony Luck <tony.luck@intel.com>
   Qualcomm	Trilok Soni <tsoni@codeaurora.org>
-- 
2.17.1

