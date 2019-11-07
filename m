Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA72221D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ePqqupRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfKGUxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:53:41 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:44178 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKGUxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:53:40 -0500
Received: by mail-pf1-f170.google.com with SMTP id q26so3279158pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRiOqVqF7fkbNnBCdHcHlpMVwV+oaW2ZJ1zi2pGGke8=;
        b=ePqqupRSQg4vkwjECEem6IB1+aU57zZva9VDVkIaaqP6DGkNxVKNuLmE0ilILpAalH
         jMzJjfAYnwHRFBdxoRnP/AysWORHd+ahoj5f/tXDlrT2MBZZbbH+owvB3CnN3Iayg8bZ
         J6paV8IauAo9Xtgmt1u4oaab8CuleD9F3fECDlOiaPXhcMpljSBdQ4/6spJeKkWNJehU
         p/TZhlv1VEdVWXT48uBz0yIWk7QzNoAPsAs3AzRkhML1fCwK2d6Ss0c2FpYtjG2GdeKz
         Ecvl0fQfiJvF4i0j2EVmbYO0SY2b8voSIBWd0NiBB9s19+6thn3VXdaFj5TBD2UyNiZ4
         ZJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hRiOqVqF7fkbNnBCdHcHlpMVwV+oaW2ZJ1zi2pGGke8=;
        b=rVGQke/vHwPvnPYusTSNAqi74nvrf9be2dxHboZUd99hVPKSnQX8cXcxtYGz7e+RQf
         Y3Z+q1kTTqBFur4+ZGNCk0Uq8YDykckxupov5HMdVhkF9v2+5UvMgkz70v92uSuR+/6e
         mSGPb1lWOdRQOyd+9+9AMzOui3JzHZzdUL4GBc5Uk+K8BqSqmHkDblDYlJYiRe5ra1Mi
         gB2FOlfUlklQLH+6nFAQAqfKO7RQw0ePVKq1/9bpHRAYPdUR++iD+m/m/QU5kFb7u7KQ
         IGnaxGiYXqfrcse7rz0KgyiUHMI+4ERrej4UKAyvXs3/Oy/mqV9LNMiMwmuFGyc7R2nO
         F16g==
X-Gm-Message-State: APjAAAXWK5AhV+zaLaR0nHMxB7OQWD1xFZJOJlVB57k8Jit6F5qvHi7m
        bZD0pmF/0IpcxQSUXDZ0NU4fSA==
X-Google-Smtp-Source: APXvYqx8xTAxYY/Su1yCNM4c3FuS3t23gN3HcTWSvbJ5dSw/TtaPxyTbdceDprP0HN7/X5xVMvk0Nw==
X-Received: by 2002:a63:fc09:: with SMTP id j9mr6985037pgi.272.1573160018173;
        Thu, 07 Nov 2019 12:53:38 -0800 (PST)
Received: from localhost ([2620:10d:c090:200::3:3792])
        by smtp.gmail.com with ESMTPSA id h186sm3937459pfb.63.2019.11.07.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:53:37 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/3] mm: fix page aging across multiple cgroups
Date:   Thu,  7 Nov 2019 12:53:31 -0800
Message-Id: <20191107205334.158354-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When applications are put into unconfigured cgroups for memory
accounting purposes, the cgrouping itself should not change the
behavior of the page reclaim code. We expect the VM to reclaim the
coldest pages in the system. But right now the VM can reclaim hot
pages in one cgroup while there is eligible cold cache in others.

This is because one part of the reclaim algorithm isn't truly cgroup
hierarchy aware: the inactive/active list balancing. That is the part
that is supposed to protect hot cache data from one-off streaming IO.

The recursive cgroup reclaim scheme will scan and rotate the physical
LRU lists of each eligible cgroup at the same rate in a round-robin
fashion, thereby establishing a relative order among the pages of all
those cgroups. However, the inactive/active balancing decisions are
made locally within each cgroup, so when a cgroup is running low on
cold pages, its hot pages will get reclaimed - even when sibling
cgroups have plenty of cold cache eligible in the same reclaim run.

For example:

   [root@ham ~]# head -n1 /proc/meminfo 
   MemTotal:        1016336 kB

   [root@ham ~]# ./reclaimtest2.sh 
   Establishing 50M active files in cgroup A...
   Hot pages cached: 12800/12800 workingset-a
   Linearly scanning through 18G of file data in cgroup B:
   real    0m4.269s
   user    0m0.051s
   sys     0m4.182s
   Hot pages cached: 134/12800 workingset-a

The streaming IO in B, which doesn't benefit from caching at all,
pushes out most of the workingset in A.

Solution

This series fixes the problem by elevating inactive/active balancing
decisions to the toplevel of the reclaim run. This is either a cgroup
that hit its limit, or straight-up global reclaim if there is physical
memory pressure. From there, it takes a recursive view of the cgroup
subtree to decide whether page deactivation is necessary.

In the test above, the VM will then recognize that cgroup B has plenty
of eligible cold cache, and that the hot pages in A can be spared:

   [root@ham ~]# ./reclaimtest2.sh 
   Establishing 50M active files in cgroup A...
   Hot pages cached: 12800/12800 workingset-a
   Linearly scanning through 18G of file data in cgroup B:
   real    0m4.244s
   user    0m0.064s
   sys     0m4.177s
   Hot pages cached: 12800/12800 workingset-a

Implementation

Whether active pages can be deactivated or not is influenced by two
factors: the inactive list dropping below a minimum size relative to
the active list, and the occurence of refaults.

This patch series first moves refault detection to the reclaim root,
then enforces the minimum inactive size based on a recursive view of
the cgroup tree's LRUs.

History

Note that this actually never worked correctly in Linux cgroups. In
the past it worked for global reclaim and leaf limit reclaim only (we
used to have two physical LRU linkages per page), but it never worked
for intermediate limit reclaim over multiple leaf cgroups.

We're noticing this now because 1) we're putting everything into
cgroups for accounting, not just the things we want to control and 2)
we're moving away from leaf limits that invoke reclaim on individual
cgroups, toward large tree reclaim, triggered by high-level limits, or
physical memory pressure that is influenced by local protections such
as memory.low and memory.min instead.

Requirements

These changes are based on v5.4-rc6-mmotm-2019-11-05-20-44.

 include/linux/memcontrol.h |   5 +
 include/linux/mmzone.h     |   4 +-
 include/linux/swap.h       |   2 +-
 mm/vmscan.c                | 269 +++++++++++++++++++++++++------------------
 mm/workingset.c            |  72 +++++++++---
 5 files changed, 223 insertions(+), 129 deletions(-)


