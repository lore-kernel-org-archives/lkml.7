Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457D6206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V2ApcZfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKNShc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:37:32 -0500
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:65347
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbfKNShc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:37:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEaGZctyvLTaui8/IRUl9O33OGrtb0RVlC9Vl8JprqYSc+HYPRF42EaleW+Dz1IaitXfDIsvhcA3EC7o/1B4+NVS70xrYc1YHfKsGawjjOHXGfFJKgBvPQvym0UItYf+P4XJ99UxJIpNPJ2rAvU7zCZ3FvdkZQCMJlkKJmYROzqN6hMjbAr14YApSXIvWyjXW3SNjRKKA6EPov1dKnt2y7+h1OakrCRSOLMyhz/r1pCsZ1W5Rpo2GV1H5v6v7UR2HeHjhwcri2UOikv3Ou/jT0VgMx3ETcrNGa9SAx2rLoZ7AIyOCd/57umgv7byPynT90gzC0qlO7AO47Vtpv8PQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YovV48tTausd17gDWHcqnvq5h6M+NdzKXl3mIbpqCVI=;
 b=JankMI8csUVhz9awmdnc3Kpyj0xOJCcSMgxCoV060YQm+k8gqaXP9HTs4WubLaadUtFmIQaUfClBPk+2KKypaC1+1t/iD3pf28Nt+cLjqYnc7TFmo+2vM4UtnABoma2FNh/BwbUMn30B6abWVIdBqR080Aoq5yDxedInlFYZuc28wrRyrUZB1LYY1M3rsT+QWUDt+rPxYxOrTT5camwL5U5YHYGT66+zRBZh89Gnm6Zg7jXPLE8q0Ym93HgjXyZpsRihu1Ve67jb1hyfLDoKBZk5H+yiQ/fc3F6JG8y2QKvwrVQN7jibIVLPBQ32alEHMLXOpPhYW4aPxib63jNw+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YovV48tTausd17gDWHcqnvq5h6M+NdzKXl3mIbpqCVI=;
 b=V2ApcZfeWSYySoz1jqgYpHhUSE5gOloVRISJfki+XBWFpg7MLoPwtFjoQ5HPH6ipWxpkEzgyWMflPVZIxOHaVpQpQSI1Yn77bFvaK3KLaLgXafBgjV1xkOQoCzcKhRQ+9hNgkebHXC4v/+E04mDvghZQPCHcKThVFdQIZSx5cjk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.102.141) by
 SN6PR12MB2752.namprd12.prod.outlook.com (52.135.107.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Thu, 14 Nov 2019 18:37:27 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::7175:51ac:283b:b306]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::7175:51ac:283b:b306%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:37:27 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 0/2] perf/x86/amd: Add support for Large Increment per Cycle Events
Date:   Thu, 14 Nov 2019 12:37:18 -0600
Message-Id: <20191114183720.19887-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.24.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:805:8e::31) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:6e::13)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc8ce312-5a67-4401-5c87-08d76931b2f6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2752:
X-MS-Exchange-PUrlCount: 1
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2752DD3E5E8EB6F1371B4B8E87710@SN6PR12MB2752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02213C82F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39850400004)(376002)(199004)(189003)(2616005)(66946007)(2870700001)(36756003)(25786009)(2906002)(26005)(6512007)(6306002)(52116002)(44832011)(386003)(8676002)(6506007)(486006)(476003)(51416003)(186003)(6666004)(7736002)(86362001)(50226002)(14444005)(81156014)(81166006)(6436002)(305945005)(6486002)(48376002)(66066001)(478600001)(47776003)(110136005)(316002)(14454004)(5660300002)(966005)(99286004)(4326008)(1076003)(66556008)(66476007)(6116002)(8936002)(50466002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2752;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhB+YNln/9UuLLV9yppeBfJWgLfFptBlOeA1NSgsqIzDYStv8A3CjhS/UpA2Ju4xbk+WrE5gpU+sQ6BogYB8EuEvoVfUp4yGT1Rg03f+A7BRRgIzcbe6QNWNotTRi4jjPR1tE6sIqDn5N/O2RjddkD4n/ZVzsUBAZ3ouLPZfUhmKqRYhfNkXciNv+Y0/ULTbNEJcQax7inFQ4HYQX42Xelgy3LxCei1IwSLawjd8JpcfBpmvxnxE9UimH5enRGUFIN075dSWpoOeciS2L2rYE6svtd6puCpqME5xNtc5YzsCm+39LRyvsQXRiA0p11EeG6aEHcSLxoWtbajueyi6EEtr91O5ADr457rknPhNelDhns1VAvI+mkeMg8WNolB5n9Aj6IeH+1TgPWEykaVrv/ajeLe65iLtoxPAQJSJUOYz/wwte2sm8ittsWQjYHREFnDDtnmZ7IrbTDzPtqe1Cxp8CTIG9EiA/FjRngCQKv0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8ce312-5a67-4401-5c87-08d76931b2f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 18:37:27.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EwUT8o42BuDxUTfFSTsxsKj2lNWEX1tRoKz5aeCl5XELcubqrUWsn1UqO+5K7rqFV2JavHIpyaq0wlj0Hcf3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchseries adds support for Large Increment per Cycle Events,
which is needed to count events like Retired SSE/AVX FLOPs.
The first patch constrains Large Increment events to the even PMCs,
and the second patch changes the scheduler to accommodate and
program the new Merge event needed on the odd counters.

The RFC was posted here:

https://lkml.org/lkml/2019/8/26/828

Changes since then include mostly fixing interoperation with the
watchdog, splitting, rewording, and addressing Peter Zijlstra's
comments:

 - Mentioned programming the odd counter before the even counter
   in the commit text, as is now also done in the code.

 - Do the programming of the counters in the enable/disable paths
   instead of the commit_scheduler hook.

 - Instead of the loop re-counting all large increment events,
   have collect_events() and a new amd_put_event_constraints_f17h
   update a new cpuc variable 'n_lg_inc'.  Now the scheduler
   does a simple subtraction to get the target gpmax value.

 - Amend the fastpath's used_mask code to fix a problem where
   counter programming was being overwritten when running with
   the watchdog enabled.

 - Omit the superfluous __set_bit(idx + 1) in __perf_sched_find_counter
   and clear the large increment's sched->state.used bit in the
   path where a failure to schedule is determined due to the
   next counter already being used (thanks Nathan Fontenot).

 - Broaden new PMU initialization code to run on families 17h and
   above.

 - Have new is_large_inc(strcut perf_event) common to all x86 paths
   as is is_pebs_pt().  That way, the raw event code checker
   amd_is_lg_inc_event_code() can stay in its vendor-specific area
   events/amd/core.c.

 - __set_bit, WARN_ON(!gpmax), all addressed.

 - WRT changing the naming to PAIR, etc. I dislike the idea because
   h/w documentation consistently calls this now relatively old
   feature for "Large Increment per Cycle" events, and the secondary
   event needed, specifically the "Merge event (0xFFF)".  When I
   started this project the biggest problem was disambiguating
   between the Large Increment event (FLOPs, or others), and the
   Merge event (0xFFF) itself.  Different phases had "Merge" for
   the Merge event vs. "Merged" for the Large Increment event(s),
   or "Mergee", which made reading the source code too easy to
   mistake one for the other. So I opted for two distinctly
   different base terms/stem-words: Large increment (lg_inc) and
   Merge, to match the documentation, which basically has it right.
   Changing the term to "pair" would have created the same "pair" vs.
   "paired" vs. "pairer" etc. confusion, so I dropped it.

 - WRT the comment "How about you make __perf_sched_find_count() set
   the right value? That already knows it did this.", I didn't see
   how I'd get away from still having to do the constraints flag &
   LARGE_INC check in perf_assign_events(), to re-adjust the assignment
   in the assign array, or sched.state.counter.  This code really
   is only needed after the counter assignment is made, in order to
   program the h/w correctly.

Kim Phillips (2):
  perf/x86/amd: Constrain Large Increment per Cycle events
  perf/x86/amd: Add support for Large Increment per Cycle Events

 arch/x86/events/amd/core.c   | 110 +++++++++++++++++++++++++----------
 arch/x86/events/core.c       |  46 ++++++++++++++-
 arch/x86/events/perf_event.h |  21 +++++++
 3 files changed, 145 insertions(+), 32 deletions(-)

-- 
2.24.0

