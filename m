Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE84C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D000621479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562605810;
	bh=7ERY0I+F3mztoMq02b3yIFPlTnTqJgefGFIKj8Zd1QE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=LEfGubUn7+XS80bi3cqYl90CKGFf8X3fV+UEZaaqHZ4zjxw/FDvd64U1piUe75Y86
	 LRQrp6CrQ6+AvEheLbkq9motNTNwd9uhJp/Rj9CoddHM1M5JCN8nAdh4TAdtoVft8J
	 McToVLL1bGf3Tryz81FaCQa8KNebl9kHS9YWbLIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbfGHRKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:10:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39437 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:10:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so10509103qtu.6;
        Mon, 08 Jul 2019 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BdKgnrOU06X/Q8S32FIzC7gdOJEflmilCgUnr8XW8Uo=;
        b=fzo2ZCAFTzMmFJzkdRl+282iXZMLC1B8DcfQnfKKCF6eSHkIfKS3jaHlbbozr54zVQ
         t9P4Idy3pi9FO8UhmrQTi1VqveI0S/NbmPYoGqe56988OJF01xM64cks05Hzv6XO+era
         y7zJpaeUz05G9e2CPc/e4XUOModyaVHABcfrFeeZIeGuXPbB/CoS9Hcs6vIFw/QsRVfh
         AQBT6UNuMzGXUxZMPXSPIklxUoLAxFMp87ZR5sLo+CYsvmcZQC+/FRbgPJuua62cBWJL
         m2NpSPN/hu02oh4+qA1unN+tA+fpk7KWgYt+i6a0jN8VV+bgvwgnTxBhQv82st4vquUJ
         CGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BdKgnrOU06X/Q8S32FIzC7gdOJEflmilCgUnr8XW8Uo=;
        b=g+SzgmVo6QLkaLd6ptYBKt2y6yP+I/HZ0aaWfoOMYhFMFnFaybcMwe7bEaxKT2kbeo
         Xo+aT7BkKJH9fhgdWe7RawZunREbKoT/X2yke5VEW99xh0+eU1PLYrqYWYoz7K6B+01w
         dR/0h7F6vgYKM/WKJQgCVIpkC/pcq+kRntrngJagsqNsFmU2/qUBpce3Qkhv7PlZxfhq
         iG/9T5opdUyCGY2LLAgYZAhz3GWZhgDcYi2tG0z80Mrs6LqCfKZiqNFvwTTiJlmS23Fj
         zUSeh48/RX7056Y3kUOVOXtHdbC+WOBigSMS4EhZFQUUAgRcnNnBQddPp0qSVssOIaD5
         DPFw==
X-Gm-Message-State: APjAAAWY15Dj4Nt6S2Eq4MEj65qiC/2wqYFsCgMgAOxpHzbhltvGwVha
        1in0bsiMboGqEZfzalPPqPs=
X-Google-Smtp-Source: APXvYqxwl8L8E6/n8ezvRR95dwN9YsySKyxoE5T8ipnn+DOgvNYtFag36103fnyWQ0doEASxwT2Lgw==
X-Received: by 2002:ac8:1410:: with SMTP id k16mr14730026qtj.335.1562605807899;
        Mon, 08 Jul 2019 10:10:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id l80sm621857qke.24.2019.07.08.10.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:10:07 -0700 (PDT)
Date:   Mon, 8 Jul 2019 10:10:05 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.3-rc1
Message-ID: <20190708171005.GG657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Documentation updates and the addition of cgroup_parse_float() which
will be used by new controllers including blk-iocost.

Thanks.

The following changes since commit c596687a008b579c503afb7a64fcacc7270fae9e:

  cgroup: Fix css_task_iter_advance_css_set() cset skip condition (2019-06-10 09:08:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3

for you to fetch changes up to 99c8b231ae6c6ca4ca2fd1c0b3701071f589661f:

  docs: cgroup-v1: convert docs to ReST and rename to *.rst (2019-06-14 13:29:54 -0700)

----------------------------------------------------------------
Mauro Carvalho Chehab (1):
      docs: cgroup-v1: convert docs to ReST and rename to *.rst

Tejun Heo (3):
      cgroup: add cgroup_parse_float()
      Merge branch 'for-5.2-fixes' into for-5.3
      cgroup: Move cgroup_parse_float() implementation out of CONFIG_SYSFS

 Documentation/admin-guide/cgroup-v2.rst            |   6 +
 Documentation/admin-guide/hw-vuln/l1tf.rst         |   2 +-
 Documentation/admin-guide/kernel-parameters.txt    |   4 +-
 .../admin-guide/mm/numa_memory_policy.rst          |   2 +-
 Documentation/block/bfq-iosched.txt                |   2 +-
 .../{blkio-controller.txt => blkio-controller.rst} |  96 +++--
 .../cgroup-v1/{cgroups.txt => cgroups.rst}         | 186 +++++----
 .../cgroup-v1/{cpuacct.txt => cpuacct.rst}         |  15 +-
 .../cgroup-v1/{cpusets.txt => cpusets.rst}         | 209 ++++++----
 .../cgroup-v1/{devices.txt => devices.rst}         |  40 +-
 ...freezer-subsystem.txt => freezer-subsystem.rst} |  14 +-
 .../cgroup-v1/{hugetlb.txt => hugetlb.rst}         |  41 +-
 Documentation/cgroup-v1/index.rst                  |  30 ++
 .../cgroup-v1/{memcg_test.txt => memcg_test.rst}   | 265 +++++++-----
 Documentation/cgroup-v1/{memory.txt => memory.rst} | 463 +++++++++++++--------
 .../cgroup-v1/{net_cls.txt => net_cls.rst}         |  37 +-
 .../cgroup-v1/{net_prio.txt => net_prio.rst}       |  24 +-
 Documentation/cgroup-v1/{pids.txt => pids.rst}     |  82 ++--
 Documentation/cgroup-v1/{rdma.txt => rdma.rst}     |  66 +--
 Documentation/filesystems/tmpfs.txt                |   2 +-
 Documentation/scheduler/sched-deadline.txt         |   2 +-
 Documentation/scheduler/sched-design-CFS.txt       |   2 +-
 Documentation/scheduler/sched-rt-group.txt         |   2 +-
 Documentation/vm/numa.rst                          |   4 +-
 Documentation/vm/page_migration.rst                |   2 +-
 Documentation/vm/unevictable-lru.rst               |   2 +-
 Documentation/x86/x86_64/fake-numa-for-cpusets.rst |   4 +-
 MAINTAINERS                                        |   2 +-
 block/Kconfig                                      |   2 +-
 include/linux/cgroup-defs.h                        |   2 +-
 include/linux/cgroup.h                             |   2 +
 include/uapi/linux/bpf.h                           |   2 +-
 init/Kconfig                                       |   2 +-
 kernel/cgroup/cgroup.c                             |  43 ++
 kernel/cgroup/cpuset.c                             |   2 +-
 security/device_cgroup.c                           |   2 +-
 tools/include/uapi/linux/bpf.h                     |   2 +-
 37 files changed, 1017 insertions(+), 648 deletions(-)
 rename Documentation/cgroup-v1/{blkio-controller.txt => blkio-controller.rst} (90%)
 rename Documentation/cgroup-v1/{cgroups.txt => cgroups.rst} (88%)
 rename Documentation/cgroup-v1/{cpuacct.txt => cpuacct.rst} (90%)
 rename Documentation/cgroup-v1/{cpusets.txt => cpusets.rst} (90%)
 rename Documentation/cgroup-v1/{devices.txt => devices.rst} (88%)
 rename Documentation/cgroup-v1/{freezer-subsystem.txt => freezer-subsystem.rst} (95%)
 rename Documentation/cgroup-v1/{hugetlb.txt => hugetlb.rst} (70%)
 create mode 100644 Documentation/cgroup-v1/index.rst
 rename Documentation/cgroup-v1/{memcg_test.txt => memcg_test.rst} (62%)
 rename Documentation/cgroup-v1/{memory.txt => memory.rst} (71%)
 rename Documentation/cgroup-v1/{net_cls.txt => net_cls.rst} (50%)
 rename Documentation/cgroup-v1/{net_prio.txt => net_prio.rst} (71%)
 rename Documentation/cgroup-v1/{pids.txt => pids.rst} (62%)
 rename Documentation/cgroup-v1/{rdma.txt => rdma.rst} (79%)

-- 
tejun
