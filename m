Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943DCC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6785920656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ulkxi+Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfFYOB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:01:56 -0400
Received: from mail-eopbgr750047.outbound.protection.outlook.com ([40.107.75.47]:62527
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbfFYOBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8xOtvZnGag/13sI6VqtomdUe88yUmY+6Rqe0SzGArk=;
 b=ulkxi+CeMGw4km8ckzEmmZ88m2Sn585nMN+zMAzxocwwQmN7IgmBWi/dgJdVQskSkmC2Cr44AXGA6tln0TAHjAVjq/KJsX0gdMa3QnnuTP9jwNPl+Z0BSDHZmiHD47EhxORuZY9macEVymVYBPbvc6m9mOsHpvifATHuLDjPxrI=
Received: from CY4PR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:910:16::14) by MWHPR12MB1166.namprd12.prod.outlook.com
 (2603:10b6:300:7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13; Tue, 25 Jun
 2019 14:01:53 +0000
Received: from DM3NAM03FT008.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::204) by CY4PR1201CA0004.outlook.office365.com
 (2603:10b6:910:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 14:01:53 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 DM3NAM03FT008.mail.protection.outlook.com (10.152.82.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2008.13 via Frontend Transport; Tue, 25 Jun 2019 14:01:52 +0000
Received: from hwentlanhp.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Tue, 25 Jun 2019
 09:01:52 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <airlied@gmail.com>, <natechancellor@gmail.com>
CC:     <Anthony.Koo@amd.com>, <alexander.deucher@amd.com>,
        <Jun.Lei@amd.com>, <Bhawanpreet.Lakha@amd.com>,
        <sunpeng.li@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Use msleep instead of udelay for 8ms wait
Date:   Tue, 25 Jun 2019 10:00:46 -0400
Message-ID: <20190625140046.31682-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
References: <CAPM=9txaQ43GwOzXSE3prTRLbMt+ip=s_ssmFzWsfsTYdLssaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(428003)(199004)(189003)(68736007)(50466002)(36756003)(81166006)(4326008)(6666004)(426003)(186003)(47776003)(356004)(48376002)(14444005)(305945005)(70206006)(53936002)(2616005)(11346002)(8936002)(81156014)(8676002)(446003)(476003)(53416004)(316002)(26005)(77096007)(54906003)(110136005)(5660300002)(44832011)(76176011)(2870700001)(2906002)(4744005)(72206003)(1076003)(478600001)(486006)(86362001)(7696005)(336012)(126002)(70586007)(51416003)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1166;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dbd7018-1c18-4bf2-175d-08d6f975ad2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:MWHPR12MB1166;
X-MS-TrafficTypeDiagnostic: MWHPR12MB1166:
X-Microsoft-Antispam-PRVS: <MWHPR12MB116640AFBDF7B1F757608FC78CE30@MWHPR12MB1166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FUf/ugQMFnurU++uU85eo/NPfFmqD4B4QfDTjngAVbaEgnsPY65UP3tavgfOtlXyJG9CwdeNjf43cYkrsWaIbLSEYqyz+g+IGeUedKxvaG9l5wYw82hGUjRjLn4tOmF3RMrFURUEt/u3qdZFvR6CUBFfdxbiI/2MhL8CHYYwuE2FqzDkL9Hhj92LGciSbidE2unRmriJrjT56XF5+7JfxpCP2jXZnR1Daj7Eseies0oPKc4aW/OGwE3KT9uwe/5sQYyZMJgJGZwgf1p3YveK0hV+AXUYebB0QbXCN/MdlhNvNf6gmyiTernP555cpZ3U2snP8/MG0bfBJeZ6gldMdW6V2xaxGXzexqh2o/H4PI4GmfHSHEJGjchZ8AVkCW9sTmSdxW6O6JSNBBq57L66YL2YoPh/pzIWCn9eMhveogk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 14:01:52.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbd7018-1c18-4bf2-175d-08d6f975ad2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm32's udelay only allows values up to 2000 microseconds. msleep
does the trick for us here as there is no problem if this isn't
microsecond accurate and takes a tad longer.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 4c31930f1cdf..f5d02f89b3f9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -548,7 +548,7 @@ static void read_edp_current_link_settings_on_detect(struct dc_link *link)
 			break;
 		}
 
-		udelay(8000);
+		msleep(8);
 	}
 
 	ASSERT(status == DC_OK);
-- 
2.22.0

