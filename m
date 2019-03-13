Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D402213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbmaOVrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCMSkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44852 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMSkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:40:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id a3so1975215pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGCmHLKJA9/EYdLy/6HPhjPsvA0XaSLq0sCYMk41rjQ=;
        b=BbmaOVrTTrfPLRHgBCJK3fvZxYO5/ln++Ubzs451/+vYsxNPdWwBbSHUAv/FxKjuFD
         Mf+xGTJBljqOzIsg8dAa9TKqpwh+H9DRemPztnU5TnsNKAzMzvFkodrueROckXzhzK1o
         3I0SjuMQMX54hGSu9vG52ZWNFs9dyKGdAewCsDpK+NGOlCIvkGQBqPTCkWFGhLtr9oQf
         IDU6EZ5XyvVpGezq8qb6dA3DlgAHHVZems5b6lDtfub+q/2uJCpBRVWzzXMWiGFOx9up
         Y2VDMo4J6umdKSt14jrMvHkdLLMaHxOqFxj/0OAFT8srX5agSdjiugfRlcmwJNK9yNDM
         xV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGCmHLKJA9/EYdLy/6HPhjPsvA0XaSLq0sCYMk41rjQ=;
        b=GrGJTWabhR4q7rFSNfLH9BCKk3AryP2tuHOuO/3F+q038XROMh9vn6Xd4kQ3H91Ex0
         yuXlSuyo3HXVMd/kmQ6ty5TFQs0eVhIOEz9asXoEz5rB8n4HbskDquVTee/vci7mJJAv
         JW8V7iEY/hUD1vMn9/HrTYhzQDJeuMrkH3rwUe1z25PihCs62u4qZl+SE30eX5uR8Phs
         KGOffrydhbtLjWPH4WMyn8+uYyBLfmR6c39NOYS2RAlYu3hmySrnykFJNxc+7JRt7cZ1
         hGi3iNXJlV1rG5ijjEHXoMlaBTa0MsUhTTKnMyeqGZTGg2YhzuBiUgcmOmgqfYjjxfD6
         jMaw==
X-Gm-Message-State: APjAAAXgW3bBefw/DwINxCjSMVykV68rzt6zmupnUHPX2GofoC/gMcTT
        OE2wLjwSiwxmjTYGlN5dJtWYBgbL3b4=
X-Google-Smtp-Source: APXvYqzdI6qgHAAwU5a2Vf/gu7NwWbBAvf44GvpOocbzEDCRQK42dGNNnvbR4MBLHpoDMPFq7Zhgxg==
X-Received: by 2002:a63:204d:: with SMTP id r13mr15642250pgm.63.1552502400062;
        Wed, 13 Mar 2019 11:40:00 -0700 (PDT)
Received: from castle.hsd1.ca.comcast.net ([2603:3024:1704:3e00::d657])
        by smtp.gmail.com with ESMTPSA id i13sm15792562pgq.17.2019.03.13.11.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 11:39:58 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 0/6] mm: reduce the memory footprint of dying memory cgroups
Date:   Wed, 13 Mar 2019 11:39:47 -0700
Message-Id: <20190313183953.17854-1-guro@fb.com>
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

v3:
  - replaced get_cpu_mask() with cpumask_of() (by Johannes)

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

