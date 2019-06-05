Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025162083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="Bw87RAJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfFEP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:59:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40145 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfFEP70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:59:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id r18so6485748edo.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kkZWtnBurY2WW6xwlUiKXDHLoZrLdW1fZdtO5engfaU=;
        b=Bw87RAJ5p0HKEpsXo4qErsDmKQAaN6y8yw86pBg6o/vkuOse7R/LHvL5ImUlbb320W
         +311tioqVPvKGfK948dqFLRx+9WYIE5vhpfaUCwKwSOUGn7TP0/3jPOKXg8/NCgmLnWq
         lO2q3xSNzCXNVYVgzp3PGcQHFkpeAWOVWhI6NOdEIHyInlxShDvoMyG7MQ3Ft0l+JgXY
         3Fl/qwfQby61nNpWtAe/pdHWdSmuinNZ68zkry6Gy90Pw5lveZHOCbhLLm6Dc97unDJz
         fSXc5z+L+Mm4fUk+i3KKn21Mv7bQt4DRxbQT9ouhyaW32pqI8pyjibIeYwQLQ3YVMCD/
         k6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kkZWtnBurY2WW6xwlUiKXDHLoZrLdW1fZdtO5engfaU=;
        b=KjmYNb0uxoKq9mTqeZDXKbpsXUmUi+rOTrA7FiTlk71ggzdX/LVgqdDVH4EhL0tZuX
         6VDC8Aqgu4TKqBj0IfXVALB3SOgMetX08ZiGfaUfUNc4r3B2StyW7+giLjsoTVGCHjUH
         hIp3psCOeawfzeJZg56OCW5e+Ezk+yIwTn/Jw1ldDifpGKei04nLamKBXvFSw61dn3KK
         Xy45GVINEqwXLzsqXijPwp03IDmisdnkHmy4wiJ4JHVKkB8nq4r4KQXpfhUAXtnjEhK9
         cThemyxqOwgc/ANO0OqNnQi6OCfCrmFSdo88QJ4yMOLGDE8PLDk8aaz8ddhqymSpILTG
         MGjQ==
X-Gm-Message-State: APjAAAUN+KYcJYl+cLxJJ567Logx+ZcLH90Y8hPLrB3oa6fDt3NTdl2e
        mgp7K4muhsgSTRi602wU0jSzOg==
X-Google-Smtp-Source: APXvYqwiriYeZEuXH8SBmqwOANnYxtjwIzH0WYmgXS/PQopjYyXxO/hAO7F8m1Y2qyeucu2pmCNItQ==
X-Received: by 2002:a17:906:2191:: with SMTP id 17mr4153542eju.280.1559750364802;
        Wed, 05 Jun 2019 08:59:24 -0700 (PDT)
Received: from localhost ([94.1.151.203])
        by smtp.gmail.com with ESMTPSA id y21sm304540ejm.60.2019.06.05.08.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:59:24 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Date:   Wed,  5 Jun 2019 16:59:22 +0100
Message-Id: <20190605155922.17153-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
for any sched domains with a NUMA distance greater than 2 hops
(RECLAIM_DISTANCE). The idea being that it's expensive to balance
across domains that far apart.

However, as is rather unfortunately explained in

  commit 32e45ff43eaf ("mm: increase RECLAIM_DISTANCE to 30")

the value for RECLAIM_DISTANCE is based on node distance tables from
2011-era hardware.

Current AMD EPYC machines have the following NUMA node distances:

node distances:
node   0   1   2   3   4   5   6   7
  0:  10  16  16  16  32  32  32  32
  1:  16  10  16  16  32  32  32  32
  2:  16  16  10  16  32  32  32  32
  3:  16  16  16  10  32  32  32  32
  4:  32  32  32  32  10  16  16  16
  5:  32  32  32  32  16  10  16  16
  6:  32  32  32  32  16  16  10  16
  7:  32  32  32  32  16  16  16  10

where 2 hops is 32.

The result is that the scheduler fails to load balance properly across
NUMA nodes on different sockets -- 2 hops apart.

For example, pinning 16 busy threads to NUMA nodes 0 (CPUs 0-7) and 4
(CPUs 32-39) like so,

  $ numactl -C 0-7,32-39 ./spinner 16

causes all threads to fork and remain on node 0 until the active
balancer kicks in after a few seconds and forcibly moves some threads
to node 4.

Update the code in sd_init() to account for modern node distances, and
maintaining backward-compatible behaviour by respecting
RECLAIM_DISTANCE for distances more than 2 hops.

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>
---
 kernel/sched/topology.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f53f89df837d..0eea395f7c6b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1410,7 +1410,18 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
-		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE) {
+
+		/*
+		 * Strip the following flags for sched domains with a NUMA
+		 * distance greater than the historical 2-hops value
+		 * (RECLAIM_DISTANCE) and where tl->numa_level confirms it
+		 * really is more than 2 hops.
+		 *
+		 * Respecting RECLAIM_DISTANCE means we maintain
+		 * backwards-compatible behaviour.
+		 */
+		if (sched_domains_numa_distance[tl->numa_level] > RECLAIM_DISTANCE &&
+		    tl->numa_level > 3) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
 				       SD_WAKE_AFFINE);
-- 
2.13.7

