Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A32C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97EE2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9UOI736"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCLWeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:34:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35055 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfCLWeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:34:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id e17so14352pgd.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CG8VBs5njjsmOqTJucGpp1GQp/U3yTJMZSM/HvLW4gk=;
        b=h9UOI736Jx8iXrIAW5OPQIbfTw5h4YbGzRbG/vYeMXWaWJOxBybprNrbv4O+Tu+XAp
         Xz5UJG4r2OR2oJwLhH/SYygF3nWcDR6f/K1FfVliZXnjYXNX0BiwDnugHX/7+U2Ooixz
         cUggfKM+93MVHidmn0HHx96nbtXCm+90bq//g8SAcGYa/sVorTsYEJvn4qQc6WqL4bpf
         pL6LqHWecY2HOTC5ASTMunxu/cveQxG03yRiGfEgZ2JNVLAVJnxnry4Fhi7aSUBjBJ3T
         DK6kiYcnApv2T3uDE55OilUSc3eR7GOQszr0gowGNe/ITjB3LPrB3gD5qbs1siRZGjMq
         /oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CG8VBs5njjsmOqTJucGpp1GQp/U3yTJMZSM/HvLW4gk=;
        b=KQGNsN8mvBMA2JE6ZsX+pQy2ABr/eTBsphMBpEQvfTdNft/9Es0xfAVBAmAVjwCvSf
         9rpeukLEvOElh6t+pfIUv7jBfkGmM2Rvafu6L+qVJURIeO1vYmOOFw/UcMO4DySrJtUl
         UC5LNUStjuP6HHusfJxxNwPJYRB0xgWiE8/dfqZfO/VmXhN5Q6OK6ZSwD/SKF9H2D9vm
         9XcVVuzVYtJRtjF0mLiAkYE+5MJeCl9KmNxz/I7uxt5GZhor/Mk3Dlo9M8aqhViq5o/Z
         +vtQ+VtqsOe2v6glhENfwdJIpy+0x1Mbf4Irw5b7d9Hf9pHe5scDGbnGmA8PpJ4k+2zE
         mreQ==
X-Gm-Message-State: APjAAAXt+k5LQbWG+4akfKr47zHlu9g5s/yNmKCFxopk3o3e3aI6cBiz
        codsyYQS6TJyEJtOB5lCRkk=
X-Google-Smtp-Source: APXvYqy8tOPejVH25UDtkqcgofc+5QUcNdJIMGt8cfCJjTCXftBKArtxUyMWs1dIsenafkn68gXx8w==
X-Received: by 2002:a17:902:e713:: with SMTP id co19mr43680plb.102.1552430047540;
        Tue, 12 Mar 2019 15:34:07 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::1:3203])
        by smtp.gmail.com with ESMTPSA id i13sm14680592pfo.106.2019.03.12.15.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 15:34:06 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v2 0/6] mm: reduce the memory footprint of dying memory cgroups
Date:   Tue, 12 Mar 2019 15:33:57 -0700
Message-Id: <20190312223404.28665-1-guro@fb.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A cgroup can remain in the dying state for a long time, being pinned in the
memory by any kernel object. It can be pinned by a page, shared with other
cgroup (e.g. mlocked by a process in the other cgroup). It can be pinned
by a vfs cache object, etc.

Mostly because of percpu data, the size of a memcg structure in the kernel
memory is quite large. Depending on the machine size and the kernel config,
it can easily reach hundreds of kilobytes per cgroup.

Depending on the memory pressure and the reclaim approach (which is a separate
topic), it looks like several hundreds (if not single thousands) of dying
cgroups is a typical number. On a moderately sized machine the overall memory
footprint is measured in hundreds of megabytes.

So if we can't completely get rid of dying cgroups, let's make them smaller.
This patchset aims to reduce the size of a dying memory cgroup by the premature
release of percpu data during the cgroup removal, and use of atomic counterparts
instead. Currently it covers per-memcg vmstat_percpu, per-memcg per-node
lruvec_stat_cpu. The same approach can be further applied to other percpu data.

Results on my test machine (32 CPUs, singe node):

  With the patchset:              Originally:

  nr_dying_descendants 0
  Slab:              66640 kB	  Slab:              67644 kB
  Percpu:             6912 kB	  Percpu:             6912 kB

  nr_dying_descendants 1000
  Slab:              85912 kB	  Slab:              84704 kB
  Percpu:            26880 kB	  Percpu:            64128 kB

So one dying cgroup went from 75 kB to 39 kB, which is almost twice smaller.
The difference will be even bigger on a bigger machine
(especially, with NUMA).

To test the patchset, I used the following script:
  CG=/sys/fs/cgroup/percpu_test/

  mkdir ${CG}
  echo "+memory" > ${CG}/cgroup.subtree_control

  cat ${CG}/cgroup.stat | grep nr_dying_descendants
  cat /proc/meminfo | grep -e Percpu -e Slab

  for i in `seq 1 1000`; do
      mkdir ${CG}/${i}
      echo $$ > ${CG}/${i}/cgroup.procs
      dd if=/dev/urandom of=/tmp/test-${i} count=1 2> /dev/null
      echo $$ > /sys/fs/cgroup/cgroup.procs
      rmdir ${CG}/${i}
  done

  cat /sys/fs/cgroup/cgroup.stat | grep nr_dying_descendants
  cat /proc/meminfo | grep -e Percpu -e Slab

  rmdir ${CG}


v2:
  - several renamings suggested by Johannes Weiner
  - added a patch, which merges cpu offlining and percpu flush code


Roman Gushchin (6):
  mm: prepare to premature release of memcg->vmstats_percpu
  mm: prepare to premature release of per-node lruvec_stat_cpu
  mm: release memcg percpu data prematurely
  mm: release per-node memcg percpu data prematurely
  mm: flush memcg percpu stats and events before releasing
  mm: refactor memcg_hotplug_cpu_dead() to use
    memcg_flush_offline_percpu()

 include/linux/memcontrol.h |  66 ++++++++++----
 mm/memcontrol.c            | 179 ++++++++++++++++++++++++++++---------
 2 files changed, 186 insertions(+), 59 deletions(-)

-- 
2.20.1

