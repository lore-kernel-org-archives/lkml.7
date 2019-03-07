Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F78C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4766420840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baZX8c4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCGXAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:00:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40852 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfCGXAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:00:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so12453523pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZiJH4Ow73tuiBV88Fygbaz1AoqkBYeF4+n2mjYnICk=;
        b=baZX8c4FlLhpBJPoSRgY7Rp8YON53q0tykAHOZ5cFNIVg+FeYidnaWg0Xc9sGGNEWk
         LCBIUz5cj6+rxQHhInhFStRag16qQA+B2B6NEkHO4vD5bfljuKUoRiMMIT9luBOzntXx
         oSiY+uE4SBXvn9gG3Cr39R20AvM6bDAcTwPcNIwX0/bFBn8uYzDhezkh+hART3E2Ggcn
         jkW2WiGr/jXjr7Y+w2ejT8xwPRas/HzTE66VtqeSFoxNdoxI8UcHalb5OLBQEs7onBpU
         LywumicyLOtWGsmFRNxtchpqZJ6Aqyx+naQuORMV7O9k/HCsKJkM/QwmNSN65dhh/m3x
         hi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BZiJH4Ow73tuiBV88Fygbaz1AoqkBYeF4+n2mjYnICk=;
        b=d8G8ZFkYTJzAwF/RL7foj5vdtLNuJo6gN3fpqwfLjUgfBkEgrtOHHIdpPHY2Z7MKZh
         AHhO1iZkCdM7zu558olRjxMCjJr4gUsjQNl9ibCVoyQM0RaGLtmog3f54WuGa8ZaYh9f
         UBpH6bxxHrkuq4WaQ5NRa9ZC9jSBX9VOSW1XeDy/NID444tA+WAqna0H4+HqWY7BqSRF
         RxSe/sO6gFoOmGcKyBg5YPlrWcoV0IMDUIMoAwAMz9KfApDagOP+qjJW+Itm28TdyayL
         sy0fZJlalH+F38SQW9pBva75FoKeKri3tCoLDYcU4YmKwENRO0Vp87wg66nqDmvMwMR5
         w9vQ==
X-Gm-Message-State: APjAAAWVIMDz3BEaz1+0L6m2pABDgMUyZBx3WVX84YAaAfFnOcE+zbGQ
        LekJPkmR+AtSmfcnNHEQZL+aJDZ2
X-Google-Smtp-Source: APXvYqyp/acXT9PUFOWKYnSnyfI+ObcfHDsVWEh9a5ooMagR00iidpFsB8sPMRd26yvBPWq0t+bQOw==
X-Received: by 2002:a65:4244:: with SMTP id d4mr13840826pgq.419.1551999637002;
        Thu, 07 Mar 2019 15:00:37 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::2:d18b])
        by smtp.gmail.com with ESMTPSA id i126sm11864806pfb.15.2019.03.07.15.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:00:36 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     linux-mm@kvack.org, kernel-team@fb.com
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 0/5] mm: reduce the memory footprint of dying memory cgroups
Date:   Thu,  7 Mar 2019 15:00:28 -0800
Message-Id: <20190307230033.31975-1-guro@fb.com>
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


Roman Gushchin (5):
  mm: prepare to premature release of memcg->vmstats_percpu
  mm: prepare to premature release of per-node lruvec_stat_cpu
  mm: release memcg percpu data prematurely
  mm: release per-node memcg percpu data prematurely
  mm: spill memcg percpu stats and events before releasing

 include/linux/memcontrol.h |  66 ++++++++++----
 mm/memcontrol.c            | 173 +++++++++++++++++++++++++++++++++----
 2 files changed, 204 insertions(+), 35 deletions(-)

-- 
2.20.1

