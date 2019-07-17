Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17DC76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595CA21849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zUT/Ch2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfGQM3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:29:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:54584 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfGQM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:29:21 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 9B7102E14E7;
        Wed, 17 Jul 2019 15:29:18 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ttVOnIowdA-TIiK6lFj;
        Wed, 17 Jul 2019 15:29:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1563366558; bh=GkI1vFOT++uyatsCF9OkZ7BsUl/lwbKpS28Kcx4smEY=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=zUT/Ch2FRAuXKeKsUy2GKoCVeAkDxPWMsQKVKduAaqW60pGTqyj+A45AGb1DawgVP
         MhAIsZPLGfda0d8ynwBQb/V2+vASQeWhVGFkFNW0577I3VsRlsH4Y6q0imiXzx1uA7
         O/PaU60Bb7ohzDoMklbMGaba3gSt68RBzaw0dLfQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:38d2:81d0:9f31:221f])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Q1tjHAsjiv-TI98o0cW;
        Wed, 17 Jul 2019 15:29:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] mm/memcontrol: fix flushing per-cpu counters in
 memcg_hotplug_cpu_dead
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>
Date:   Wed, 17 Jul 2019 15:29:17 +0300
Message-ID: <156336655741.2828.4721531901883313745.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct memcg pointer.

Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/memcontrol.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 249671873aa9..06d33dfc4ec4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2259,7 +2259,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
 			if (x)
 				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmstats[i]);
+					atomic_long_add(x, &mi->vmstats[i]);
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
@@ -2282,7 +2282,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
 			if (x)
 				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmevents[i]);
+					atomic_long_add(x, &mi->vmevents[i]);
 		}
 	}
 

