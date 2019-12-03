Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E91DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048E2206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OYryaSO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:01:45 -0500
Received: from mail-eopbgr730071.outbound.protection.outlook.com ([40.107.73.71]:21408
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfLCJBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:01:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3G6p0uU687zF6Pmtq/aDjurdA3RNN0z5ZYWV4zoPGEpBlJbbmVVe4Gf6OLnNk6+HWoPwsItf6/11d3nBLrKcndm/WgNsz5jswWJyzRSTu0jVOc9A6GBoJrLn4vDRBHgEgQQVvdpBxVrs/OPe1Dz+CQIGVevXf/PLvROh7RIJi+69o7a6uPyDqKQl7VHrGDl0iVTnzH7i/FNssjqDYllV4q087UkhnWnt+YYNTNVeX9RPtIvtt1guiie1dl56qer5JBFcmUBxFa9h6dvfpXEeeMcf5Vd6R767QL1716SoyhTZdc9W3X7llW6amajNEluVsJrZ+qIJFra9QmOC9U6tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa8GQDtVZ55krGG4A222iWrdZStd0cKVUfGvTDeyXGY=;
 b=BuGL5SXIU6RvrYjmRKxtZ34zQbB2sPwHJkSXRGNKtBnBqq4YiC4I8G9MqIQjxQKZKanVT4ZijSki3a006Kezl3u3kNcueVjUkWOuX7A0aqQKenRH+YeFRPin15XYwKO4cYWN0JSNCs9HpnrMlD3Spg/pYgj86IsL0/IQR0oVOz22LkEkzdmaUUACzoyeE1krNd2flzBZy2vJqo6TFTrly8BUp7wAKQ3ieypSDGY7d+M+k1IoPecHrAMiAZAeV9xHvjWDzON/chZSSht1N3QQt2MwwXtMC3LNGeTaKruidwbqsg3zefPaam+WuLbvIc4mZEQrWa16pROW9bFaKYTglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa8GQDtVZ55krGG4A222iWrdZStd0cKVUfGvTDeyXGY=;
 b=OYryaSO1QuKgkI4D2LjJFWKotg66JE+1sci4z39UGqAyhksvoGqrsxhDSlSoImkHN63kUy/CS7XcaJDIo7zWi+BTDx5Z3tmalXQ/bih1K2GX6J4Km7IDeT+fhWBn+6Gg9i4Nql0VFkP+2QpfL1fr5FAUySVtzuAGH99V0Fu9qxA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.172.206) by
 DM6PR12MB3722.namprd12.prod.outlook.com (10.255.172.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 09:01:42 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::39cc:b3a4:6c0a:14f6]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::39cc:b3a4:6c0a:14f6%7]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:01:41 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        jon.grimm@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
Subject: [PATCH] x86/fpu: Warn only when CPU-provided sizes less than struct declaration
Date:   Tue,  3 Dec 2019 04:01:28 -0500
Message-Id: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::14)
MIME-Version: 1.0
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [61.90.27.152]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbcfcc37-4b67-4513-d2af-08d777cf69c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3722:|DM6PR12MB3722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3722A6E4BC9FE29077E1E965F3420@DM6PR12MB3722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02408926C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(4720700003)(6436002)(7736002)(50466002)(25786009)(48376002)(478600001)(5660300002)(6116002)(3846002)(36756003)(66556008)(66476007)(14454004)(44832011)(2906002)(6666004)(4326008)(2616005)(14444005)(66946007)(26005)(16586007)(81156014)(86362001)(186003)(6512007)(50226002)(316002)(54906003)(99286004)(81166006)(6486002)(8676002)(52116002)(8936002)(51416003)(305945005)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3722;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUiLJ/VyO0gUG0u5PHzWxa0zsBEEm+kDWH52Z1EdqbzOcz5Mm/nwOtnvuWfO9Ee/3MwaW8hJO3G/VoGL2JXGUpxXnUWg8MJrFr/ICJXxqHXMxi+W/FNLBCfL5xg89kBvihg/0SYR5G0nIXeOiLGZ49cmar8hXWSpTtS0+z6jog9hE/LndDNCup6OSY6aZUEtBOI6HuLUZCbM6sWud36JcwQLcWKHOXPMdHPvtOwBx7009JMucxoX+IFPV9R9rY7r6Ww06pLzdN3mX9qzbi7hC45Uyhbg1Y7nd5/FX/bWe88oL2uNVH0di7TLQV2hcfIUPrlxXjW9UyZIWcGqLJKCjrEyCoT8fwreULp0FY0pUY8X3afZW+TtSLojlul257H6HtBAExVL3eW8ue2mK84GmUT/M+3lxwL13iNEmEVwCmrRw1/U/GyS5Bt58PXfyj0D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcfcc37-4b67-4513-d2af-08d777cf69c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 09:01:41.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWtj4j6MYGEiszquEoiGrhF/B/7h/iO0hUo8itpRcM2HqF8pssBCb18jeVsGTdG9/bnhfE4ywXMZoC8ngFEO6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current XCHECK_SZ macro warns if the XFEATURE size reported
by CPUID does not match the size of kernel structure. However, depending
on the hardware implementation, CPUID can report the XSAVE state size
larger than the size of C structures defined for each of the XSAVE state
due to padding. Such case should be safe and should not need to generate
warning message.

Therefore, change the logic to warn only when the CPUID reported size is
less than then size of C structure.

Fixes: ef78f2a4bf84 ("x86/fpu: Check CPU-provided sizes against struct declarations")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com> 
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e5cb67d..f002115 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -523,7 +523,7 @@ static void __xstate_dump_leaves(void)
 
 #define XCHECK_SZ(sz, nr, nr_macro, __struct) do {			\
 	if ((nr == nr_macro) &&						\
-	    WARN_ONCE(sz != sizeof(__struct),				\
+	    WARN_ONCE(sz < sizeof(__struct),				\
 		"%s: struct is %zu bytes, cpu state %d bytes\n",	\
 		__stringify(nr_macro), sizeof(__struct), sz)) {		\
 		__xstate_dump_leaves();					\
-- 
1.8.3.1

