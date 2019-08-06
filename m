Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E840BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01DA214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fijginM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfHFRp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:45:58 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:13729
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfHFRp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:45:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlCFjFDbvuufSaaJS5PKRuYyKbwTLq81PcWi41LZXQV07pUENK1kwOsr8g7sGpAMZ0uZIiMEX88Gcm9fA+93x1YsApYXR1LXyfm6bnUQtuVMETm7fjCIcveimWHpp1G4zYNpYKyXKt8wM46Ywn19f99gvqefwLrXo05UkyuABZfyuew01iE2tDtiVwax0/znaPgL5KD5WgvL4PXYQkVvew1lXMoXBEM1qdGE5724ATwfl+G9+qpbsClXX76+YpxFRXJvQU0I4PV/7F0u252ikH5MLKxFumq0sO0Y7dCevsLGWLN/qF6TBlc/L0yrY+gOKYDZgj04r8NqdgStgPRvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUKVk2ZE8nwPZ1LhyQ07nkU/pVIiQ7q6jRq+pAUmKcM=;
 b=TVaS76WGi+ZfffUpBNATeoZdrpYzqSpjqjyEVysHsCPrMnlD+IBbP0uCEYuPrT1nIEraHTxw7mAttK/UhIzJH674iNMaizaKFtu9B7IqKDafLaXWmi+UxnNvLZS1VX9s6ddsF7mbRVw/3S+ifVwZNLRxZn/d+42KNqF/JezdPDvNpLKexJlpd5thcbas1dtP5XjjJl+wrVBiCESfOIsjXvXZ7hPBHsjQ9hpEn9bWWP5QYNicvceFqYyrrM15FW//5CZZXZwIlE79C55Vash2SONTZxt0V+oMOr4GZBdTHFTYzEse+nvRS455GERjF9+VDeK3WHf7Btva6S+1cam3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com;dmarc=permerror action=none
 header.from=amd.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUKVk2ZE8nwPZ1LhyQ07nkU/pVIiQ7q6jRq+pAUmKcM=;
 b=fijginM+BsMt7HvPBaaPQPYUHKSDbfLcH2eIWMmzr8hFV7nYIi/1Bv+bZ4vUJno/E3XVp2MXjSL45eD684K+4QQURsI+nqldAPump7hKw0fRM+sOLobHYA5NGijZYjDGClGj2vSOicycb2I4j9qQETR4XJ61PVAyYbZKXcciN98=
Received: from CH2PR12CA0004.namprd12.prod.outlook.com (2603:10b6:610:57::14)
 by DM5PR12MB1530.namprd12.prod.outlook.com (2603:10b6:4:4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Tue, 6 Aug 2019 17:45:55 +0000
Received: from BY2NAM03FT014.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::203) by CH2PR12CA0004.outlook.office365.com
 (2603:10b6:610:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.13 via Frontend
 Transport; Tue, 6 Aug 2019 17:45:55 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 BY2NAM03FT014.mail.protection.outlook.com (10.152.84.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2136.14 via Frontend Transport; Tue, 6 Aug 2019 17:45:54 +0000
Received: from hwentlanhp.amd.com (10.180.168.240) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Tue, 6 Aug 2019
 12:45:53 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <hariprasad.kelam@gmail.com>
CC:     <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <nikola.cornij@amd.com>,
        <Dmytro.Laktyushkin@amd.com>, <colin.king@canonical.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        "Harry Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add number of slices per line to DSC parameter validation
Date:   Tue, 6 Aug 2019 13:45:49 -0400
Message-ID: <20190806174549.7856-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CADnq5_OL1+bJUGh44AY48DP=G=xTtdrf+kO2233qjJzudWhw_Q@mail.gmail.com>
References: <CADnq5_OL1+bJUGh44AY48DP=G=xTtdrf+kO2233qjJzudWhw_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(428003)(199004)(189003)(2906002)(76176011)(44832011)(68736007)(70206006)(50226002)(8936002)(70586007)(8676002)(316002)(1076003)(81166006)(81156014)(14444005)(2870700001)(53416004)(53936002)(51416003)(476003)(36756003)(126002)(47776003)(426003)(7696005)(6916009)(486006)(2616005)(11346002)(336012)(4326008)(86362001)(356004)(478600001)(54906003)(48376002)(305945005)(6666004)(2351001)(5660300002)(50466002)(26005)(186003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1530;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ea6083-b8ab-4f03-5408-08d71a95ee50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328);SRVR:DM5PR12MB1530;
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1530B28C4855582F06B7C6458CD50@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0121F24F22
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uPKfIagK7X91CwB0caabnoEYD7hDSl28l/UgFOW0g0CLFcGlxNp7RY99A77wie4wvGCPi2dx4jYD0eh+rZ2Rf1ENN1Xhv1bavpXCXuknuTMScRVO/64o+145I7sfBmazUIlfKNtYUfotHAlTpz0w/gZortPsDDcCN6FSoRFUZXQpB89unrhfMlN/XdC3WlU5IltMFp5CB7XD4OCnDXqrXiu2fxF48g3kFdW/TLBgpprZmoUiaYJBRI+9GAAXnLEKDS+InsnYlJXTza4KvacIVT5joZ7GKSipfjh2UzwlsEgXA6NyWACuhjIr678j/NBNadoJui7HW4orySyTkIWVY++8ViQU8ZqevbO+69vWcDwPf5CPjpRSQQ6sFA2h28Lz7xcgAAgisfLlKnv9fdVhAvWiKI2YydHTqpwY3iWaDv0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2019 17:45:54.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ea6083-b8ab-4f03-5408-08d71a95ee50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Number of slices per line was mistakenly left out

Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---

Thanks, Hariprasad, for your patch. The second condition should actually check
for num_slices_h.

Harry

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index e870caa8d4fa..adb69c038efb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -302,7 +302,7 @@ static bool dsc_prepare_config(struct display_stream_compressor *dsc, const stru
 		    dsc_cfg->dc_dsc_cfg.linebuf_depth == 0)));
 	ASSERT(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff); // 6.0 <= bits_per_pixel <= 63.9375
 
-	if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_v ||
+	if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_h ||
 		!(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2) ||
 		!dsc_cfg->pic_width || !dsc_cfg->pic_height ||
 		!((dsc_cfg->dc_dsc_cfg.version_minor == 1 && // v1.1 line buffer depth range:
-- 
2.22.0

