Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93886C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603F2206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mengyan1223.wang header.i=@mengyan1223.wang header.b="X6WUvQ6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFOI3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 04:29:31 -0400
Received: from mengyan1223.wang ([89.208.246.23]:56688 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOI3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 04:29:30 -0400
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jun 2019 04:29:30 EDT
Received: from [IPv6:2408:8270:a51:2470:fdc9:19d4:d061:dd4f] (unknown [IPv6:2408:8270:a51:2470:fdc9:19d4:d061:dd4f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id C3F06665D2;
        Sat, 15 Jun 2019 04:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1560586815;
        bh=bqks99JML0mByy8FjY6xU4G7QtZG+ZkGbWODY0s995M=;
        h=Subject:From:To:Cc:Date:From;
        b=X6WUvQ6Am7IOROADt2MULQT0N6H5XyrHdIjWhdgp66wkT9D8yJ03fRRJg/E8IzSug
         gP0aGKnrhRYQxaiRYYbPD+FNjl+mcGY+DcnnpYHZJat/mcn3+jv+6UuxSAFkQC/7Fm
         J6Yf0nJeFn/Rq0SXJrgMZDo0dMHERBp4NR1yps8ewLikCwHpT1K9ZW7KAC5AHOJDxE
         MmIP//2o1N12q/4eljFk+jD8otsc+oigSiisbEjPqxj+3G/Utn+HpXRQLdbZvtl5zs
         EYW60BWEROdja3ZcdxvD1EgO9YE768kPQwCJJCK/G5PEiAsYo1EaNILfCRAvT7uhUf
         eHr2f/ibTrg5A==
Message-ID: <0f1be041f8de95603753ffe989bd25069efa13bb.camel@mengyan1223.wang>
Subject: [PATCH RFC] mm: memcontrol: add cgroup v2 interface to read memory
 watermark
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Jun 2019 16:20:04 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a control file memory.watermark showing the watermark
consumption of the cgroup and its descendants, in bytes.

Signed-off-by: Xi Ruoyao <xry111@mengyan1223.wang>
---
 mm/memcontrol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba9138a4a1de..b1d968f2adcd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5495,6 +5495,13 @@ static u64 memory_current_read(struct cgroup_subsys_state
*css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static u64 memory_watermark_read(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	return (u64)memcg->memory.watermark * PAGE_SIZE;
+}
+
 static int memory_min_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -5771,6 +5778,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "watermark",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = memory_watermark_read,
+	},
 	{
 		.name = "min",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

