Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF028C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96F126D23
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 21:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hOCZMeOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFCV7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 17:59:00 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45343 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCV7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 17:59:00 -0400
Received: by mail-pg1-f172.google.com with SMTP id w34so9023742pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcbe5XK5tsFMWxSLs2tZ84hRD+cj/6YTqAC2Tmv3P6A=;
        b=hOCZMeOhk+mnIUArMWNnC4vOoecC/JJjH016s1tw4Q96mSLD+0XvEFZfhYCyOuiLe3
         3JPco6SQFbsgOo3tJVA/rGxuMMqV+PxWgHbtFyYjLLr4aJ45fWaaT3ONrFh3O59CMhRv
         1a7SdQk8hx4KAgvnXTXy4jWGFB5OfJ5r7LCWoltwNWxy5L9bf/dZJoxBT8mbb0BqQ+14
         aoRFh3Hi+L5+3to6drNMaTiQ5MWNn112T5jPH2jmcr2nTpfYazs2lHbfT0EgV4wDf9p7
         +ZAzMj5wXkBDVcVYUtZ37FLCh0uEdyTwkwGCZK2XRuhvUzzguAJo+j34T00y0fKG5UdN
         paFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hcbe5XK5tsFMWxSLs2tZ84hRD+cj/6YTqAC2Tmv3P6A=;
        b=fuoAAXMyKpzmCC3Y4MO4107USzh18UvqxzM6TT4293H5Rlh7lXj+GS59kj/IoNnFIB
         n97C7rBwi01DRwAz7AfeS9swVUxSri7j+EC4HLs3Zy/wcX6g0EYCZR/RU0fzqaV+xvI9
         NcA9OF8jzl8g/hkGFsoL76/8roJC+8OSkwaUamvP3dnVlolZgRwCznLnJgC7A9uYffLX
         2F6SAUgizPaitktHU+Rr+8T/8ufkyQwhsQBGfbcF6LUIb00jPz6qfcDTjRHz1dctwCOe
         28FQMIoGt567OS1kQx+NNJJHtR9qbOkBHKJJtgLlWlOQP+jLMJIWr3l/60MSABWC/IIb
         IJ7w==
X-Gm-Message-State: APjAAAXXtouYjRv4DkaVDgPFg2ayUX41bMpS6M2ZOoJx/8WI6sz+lvDE
        Tjm9UcBiAME4xlDnQmNOsb/HcB+e94M=
X-Google-Smtp-Source: APXvYqz4Qw8yGDgRFudiuxfXs7P+jDtt3/2W1h5CX5aNY5aXM70fQ7T4ZIHJj3eYv41Qd3NLYGM9aQ==
X-Received: by 2002:a17:90a:7146:: with SMTP id g6mr32429865pjs.45.1559596101827;
        Mon, 03 Jun 2019 14:08:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:9fa4])
        by smtp.gmail.com with ESMTPSA id i12sm17107336pfd.33.2019.06.03.14.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:08:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 00/11] mm: fix page aging across multiple cgroups
Date:   Mon,  3 Jun 2019 17:07:35 -0400
Message-Id: <20190603210746.15800-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
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
of eligible cold cache, and that thet hot pages in A can be spared:

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

After some cleanups and preparations, this patch series first moves
refault detection to the reclaim root, then enforces the minimum
inactive size based on a recursive view of the cgroup tree's LRUs.

History

Note that this actually never worked correctly in Linux cgroups. In
the past it worked for global reclaim and leaf limit reclaim only (we
used to have two physical LRU linkages per page), but it never worked
for intermediate limit reclaim over multiple leaf cgroups.

We're noticing this now because 1) we're putting everything into
cgroups for accounting, not just the things we want to control and 2)
we're moving away from leaf limits that invoke reclaim on individual
cgroups, toward large tree reclaim, triggered by high-level limits or
physical memory pressure, that is influenced by local protections such
as memory.low and memory.min instead.

Requirements

These changes are based on the fast recursive memcg stats merged in
5.2-rc1. The patches are against v5.2-rc2-mmots-2019-05-29-20-56-12
plus the page cache fix in https://lkml.org/lkml/2019/5/24/813.

 include/linux/memcontrol.h |  37 +--
 include/linux/mmzone.h     |  30 +-
 include/linux/swap.h       |   2 +-
 mm/memcontrol.c            |   6 +-
 mm/page_alloc.c            |   2 +-
 mm/vmscan.c                | 667 ++++++++++++++++++++++---------------------
 mm/workingset.c            |  74 +++--
 7 files changed, 437 insertions(+), 381 deletions(-)


